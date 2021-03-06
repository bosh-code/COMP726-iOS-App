# COMP726-iOS-App - Egg-Chain
> A blockchain-based iOS app for source traceability of eggs in NZ.

Third-year blockchain paper assignment. Used as a vessel to learn Swift & SwiftUI as well as blockchain implementation.
A demonstration of how source traceability of New Zealand eggs could be implemented using a chain. A very fast prototype trying out SwiftUI.

## Companion blockchain node repo

[EggBlockchain](https://github.com/bosh-code/EggBlockchain)
The EggBlockchain repo hosts code for the macOS Swift node this app interfaces with.

## Requirements

* XCode 12.0 or greater
* iOS 13.0 or greater

### Building and running

* Ensure the [EggBlockchain](https://github.com/bosh-code/EggBlockchain) is running on your mac. Visit http://localhost:8000/chain to verify. The [README.md](https://github.com/bosh-code/EggBlockchain/blob/main/README.md) contains more information on building and running the node.
* Clone the repo into XCode using GitHub or clone locally and open the .xcodeproj.
* Change the development team to your own and confirm build targets are correct.

### Screenshots 
![List View][list]
![About View][about]
![Add View][add]

[list]: https://github.com/bosh-code/COMP726-iOS-App/blob/main/Assets/list.PNG "List View"
[about]: https://github.com/bosh-code/COMP726-iOS-App/blob/main/Assets/about.PNG "About View"
[add]: https://github.com/bosh-code/COMP726-iOS-App/blob/main/Assets/add.PNG "Add View"

## Features

* If you are running a simulated device, ensure that you download the sample QR code and choose it when using the scanner.

## Licensing

This project is licensed under Unlicense license.
