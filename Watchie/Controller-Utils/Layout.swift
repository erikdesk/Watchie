import UIKit

struct Layout {
    static var shared = Layout()
    
    private init() {}

    func generateRandomComplexLayout() -> UICollectionViewLayout {
        
        let styles = createNonRepeatingRandom(from: Array(0...3), count: 10)
        var subitems: [NSCollectionLayoutGroup] = []
        var heightMultiplier: CGFloat = 0.0
        for style in styles {
            if style == 0 {
                subitems.append(compositeSinglePairContainerGroup())
                heightMultiplier += 1.0
            } else if style == 1 {
                subitems.append(compositePairSingleContainerGroup())
                heightMultiplier += 1.0
            } else if style == 2 {
                subitems.append(horizontalPairContainerGroup())
                heightMultiplier += 3/4
            } else if style == 3 {
                subitems.append(horizontalTripetContainerGroup())
                heightMultiplier += 1/2
            }
        }
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(heightMultiplier)),
            subitems: subitems)
        
        let section = NSCollectionLayoutSection(group: group)
    //        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing) // group padding
    //        section.interGroupSpacing = spacing // section padding
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }

    // MARK: containers

    private func compositeSinglePairContainerGroup() -> NSCollectionLayoutGroup {
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth((3/2)*(2/3))),
            subitems: [singleContainerGroup(), verticalPairContainerGroup()])
        
        return group
    }

    private func compositePairSingleContainerGroup() -> NSCollectionLayoutGroup {
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth((3/2)*(2/3))),
            subitems: [verticalPairContainerGroup(), singleContainerGroup()])
        
        return group
    }

    private func singleContainerGroup() -> NSCollectionLayoutGroup {
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/3),
                heightDimension: .fractionalWidth((3/2)*(2/3))),//*(3/4)
            subitems: [singleItemGroup()])
        
        return group
    }

    private func verticalPairContainerGroup() -> NSCollectionLayoutGroup {
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalWidth((2)*(3/2)*(1/3))),
            subitems: [verticalPairItemsGroup()])
        
        return group
    }

    private func horizontalPairContainerGroup() -> NSCollectionLayoutGroup {
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth((3/2)*(1/2))),
            subitems: [horizontalPairItemsGroup()])
        
        return group
    }

    private func horizontalTripetContainerGroup() -> NSCollectionLayoutGroup {
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth((3/2)*(1/3))),
            subitems: [horizontalTripletItemsGroup()])
        
        return group
    }

    // MARK: base parts

    private func singleItemGroup() -> NSCollectionLayoutGroup {
        let spacing: CGFloat = 3
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: spacing,
            leading: spacing,
            bottom: spacing,
            trailing: spacing)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)),
            subitems: [item])

        return group
    }

    private func verticalPairItemsGroup() -> NSCollectionLayoutGroup {
        let spacing: CGFloat = 3
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/2)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: spacing,
            leading: spacing,
            bottom: spacing,
            trailing: spacing)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)),
            subitems: [item, item])

        return group
    }

    private func horizontalPairItemsGroup() -> NSCollectionLayoutGroup {
        let spacing: CGFloat = 3
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/2),
                heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: spacing,
            leading: spacing,
            bottom: spacing,
            trailing: spacing)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)),
            subitems: [item, item])

        return group
    }

    private func horizontalTripletItemsGroup() -> NSCollectionLayoutGroup {
        let spacing: CGFloat = 3
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: spacing,
            leading: spacing,
            bottom: spacing,
            trailing: spacing)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)),
            subitems: [item, item, item])

        return group
    }

    private func createNonRepeatingRandom(from numbers: [Int], count: Int) -> [Int] {
        var newNumbers: [Int] = []
        
        while (newNumbers.count < count) {
            let randomNumber = Int.random(in: 0..<numbers.count)
            if newNumbers.count == 0 {
                newNumbers.append(randomNumber)
            } else if newNumbers.last == randomNumber {
                
            } else {
                newNumbers.append(randomNumber)
            }
        }
        
        return newNumbers
    }
}
