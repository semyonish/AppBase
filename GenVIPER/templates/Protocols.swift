import Foundation

@MainActor 
protocol I{MODULE_NAME}View: AnyObject {
    var presenter: I{MODULE_NAME}Presenter! { get set }
}

@MainActor
protocol I{MODULE_NAME}Presenter: AnyObject {
    var view: I{MODULE_NAME}View! { get set }
    var router: I{MODULE_NAME}Router! { get set }
    var interactor: I{MODULE_NAME}Interactor! { get set }
}

@MainActor
protocol I{MODULE_NAME}Router: AnyObject {
    var view: {MODULE_NAME}View! { get set }
}

@MainActor
protocol I{MODULE_NAME}Interactor: AnyObject {
}
