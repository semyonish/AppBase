import UIKit

@MainActor
class {MODULE_NAME}Wireframe {
    static func createModule() -> UIViewController {
        let view = {MODULE_NAME}View()
        let presenter = {MODULE_NAME}Presenter()
        let router = {MODULE_NAME}Router()
        let interactor = {MODULE_NAME}Interactor()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        
        router.view = view
        
        return view
    }
}
