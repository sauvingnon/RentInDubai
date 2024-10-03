import SwiftUI
import FirebaseAuth

struct NavigationStackManager: View {
    
    static let shared = NavigationStackManager()

    private init(){
        if let userUID = Auth.auth().getUserID(){
            ApartmentLandlordModel.shared.userUID = userUID
            model.navigationStack.append(CurrentSelectionView.apartmentLandlordView(userUID))
        }
    }
    
    class NavigationStackManagerModel: ObservableObject {
        @Published var navigationStack = NavigationPath([CurrentSelectionView]())
        
        @Published var isPresented = false
        var title = ""
        var message = ""
        var actionBlock: ()->() = {}
    }
    
    @ObservedObject var model = NavigationStackManagerModel()
    
    var body: some View {
        NavigationStack(path: $model.navigationStack){
            StartScreen(navigationStack: $model.navigationStack)
                .navigationDestination(for: CurrentSelectionView.self){ selectionView in
                    switch(selectionView){
                    case .startScreen:
                        StartScreen(navigationStack: $model.navigationStack)
                            .navigationBarBackButtonHidden(true)
                    case .authorizationView:
                        AuthorizationView(navigationStack: $model.navigationStack)
                            .navigationBarBackButtonHidden(true)
                    case .apartmentLandlordView(let userUID):
                        ApartmentLandlordView(navigationStack: $model.navigationStack, userUID: userUID)
                            .navigationBarBackButtonHidden(true)
                    case .appendAppertmentView:
                        NewAppartmentView(navigationStack: $model.navigationStack)
                            .navigationBarBackButtonHidden(true)
                    case .showAppartment(let appartment):
                        ShowAppartmentView(navigationStack: $model.navigationStack, appartment: appartment)
                            .navigationBarBackButtonHidden(true)
                    default:
                        StartScreen(navigationStack: $model.navigationStack)
                            .navigationBarBackButtonHidden(true)
                    }
                }
                .navigationBarBackButtonHidden(true)
        }
        .alert(isPresented: $model.isPresented, content: {
            Alert(title: Text(model.title), message: Text(model.message), dismissButton: .cancel(Text("Ок")){
                model.isPresented = false
                model.actionBlock()
            })
        })
    }
    
    public func showAlert(title: String, message: String, actionBlock: @escaping ()->()){
        self.model.title = title
        self.model.message = message
        self.model.actionBlock = actionBlock
        self.model.isPresented = true
    }
    
    // Очистка навигационного стека
    public func clearNavigationStack(){
        model.navigationStack.removeLast(model.navigationStack.count)
    }
}

struct TransportGroupSelector_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStackManager.shared
    }
}

enum CurrentSelectionView: Hashable{
    case startScreen
    case authorizationView
    case apartmentLandlordView(String)
    case appendAppertmentView
    case showAppartment(Appartment)
}

