import UIKit

final class CharacterListView: UIView {

    let characterCollecitonView = CaracterListCollectionView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension CharacterListView {
    private func configureViews() {
        backgroundColor = Asset.backgroundColor.color
        addSubview(characterCollecitonView)
        NSLayoutConstraint.activate(
            [
                characterCollecitonView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                characterCollecitonView.leadingAnchor.constraint(equalTo: leadingAnchor),
                characterCollecitonView.trailingAnchor.constraint(equalTo: trailingAnchor),
                characterCollecitonView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ]
        )
    }
}
