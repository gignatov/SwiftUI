//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Georgi Ignatov on 24.07.25.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @Environment(\.modelContext) var modelContext
    
    @State private var prospects = [Prospect]()
    @State private var sortOrder = SortDescriptor(\Prospect.name)
    @State private var isShowingScanner = false
    @State private var isShowingSorting = false
    @State private var selectedProstects = Set<Prospect>()
    
    let filter: FilterType
    let predicate: Predicate<Prospect>
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var body: some View {
        NavigationStack {
            List(prospects, selection: $selectedProstects) { prospect in
                NavigationLink {
                    EditView(prospect: prospect)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            
                            Text(prospect.emailAddress)
                                .foregroundStyle(.secondary)
                        }
                        
                        if filter == .none {
                            Spacer()
                            
                            if prospect.isContacted {
                                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                            } else {
                                Image(systemName: "person.crop.circle.badge.xmark")
                            }
                        }
                    }
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(prospect)
                        filterAndSortProspects()
                    }
                    
                    if prospect.isContacted {
                        Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)
                    } else {
                        Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)
                        
                        Button("Remind Me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }
                        .tint(.orange)
                    }
                }
                .tag(prospect)
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag(SortDescriptor(\Prospect.name))
                            
                            Text("Sort by Recent")
                                .tag(SortDescriptor(\Prospect.timestamp, order: .reverse))
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                if !selectedProstects.isEmpty {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete selected") {
                            delete()
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithSwift.com", completion: handleScan)
            }
            .onChange(of: sortOrder, filterAndSortProspects)
            .onAppear(perform: filterAndSortProspects)
        }
    }
    
    init(filter: FilterType) {
        self.filter = filter
        
        switch filter {
        case .none:
            predicate = .true
        case .contacted:
            predicate = #Predicate {
                $0.isContacted
            }
        case .uncontacted:
            predicate = #Predicate {
                !$0.isContacted
            }
        }
    }
    
    func filterAndSortProspects() {
        let descriptor = FetchDescriptor<Prospect>(predicate: predicate, sortBy: [sortOrder])
        if let prospects = try? modelContext.fetch(descriptor) {
            self.prospects = prospects
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else {
                return
            }
            
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
        
        filterAndSortProspects()
    }
    
    func delete() {
        for prospect in prospects {
            modelContext.delete(prospect)
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = .default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
