
cd ../
# 최종적으로 생성된 파일이 위치할 폴더 명
LAYER_FOLDER="Presentation Layer"
echo "Searching $LAYER_FOLDER Folder .."
RESULT_PATH="$(find $PWD -type d -name "$LAYER_FOLDER")"
echo $RESULT_PATH

# Root 에 자동으로 생성되는 폴더
ROOT_FOLDER="GenerateScene"

echo ""
echo ""
echo "Checking gitignore "
GIT_IGNORE=".gitignore"
if [ -f "$GIT_IGNORE" ]; then

  if grep -q ${ROOT_FOLDER} $GIT_IGNORE; then
    :
  else
    echo "Do you want add GeneratedFile Template Folder to $GIT_IGNORE ? (Y/N): "
    read word
    if [ "$word" == "Y" ]; then
    echo "" >> $GIT_IGNORE
    echo "# Auto Gen Scene" >> $GIT_IGNORE
    echo "# ignore Auto Generated Scene Folder " >> $GIT_IGNORE
    echo "GenerateScene" >> $GIT_IGNORE
    echo 'Try it
     ---------------------------------------------
      $ git rm -r --cached .
      $ git add .
      $ git commit -m "Apply .gitignore"
      $ git push
    ---------------------------------------------
    '
    elif [ "$word" == "N" ]; then
    :
    else
    :
    fi
  fi
else
:
fi

if [ -d "$ROOT_FOLDER" ]; then
cd $ROOT_FOLDER
else
echo ""
echo ""
echo "Generate Folder name: GenerateScene in RootFolder "
mkdir "GenerateScene"
cd $ROOT_FOLDER
fi

echo "Enter Scene name (eg. SignIn): "
read name
SCENE_NAME=$name

echo ""
echo ""
echo "[Start]==========================================="
echo ""
echo ""
echo "Start - Folder name: ${SCENE_NAME}Scene .."
SCENE_SUFFIX="Scene"
SCENE_FOLDER="$SCENE_NAME$SCENE_SUFFIX"

if [ -d "$SCENE_FOLDER" ]; then
echo "$SCENE_FOLDER Is Already Generated and will replce for newOne\nAre you sure to replace? (Y/N): "
read word
  if [ "$word" == "Y" ]; then
  echo "Remove $SCENE_FOLDER"
  rm -rf "$SCENE_FOLDER"
  :
  elif [ "$word" == "N" ]; then
  echo "Generating Scene Canceled"
  exit
  else
  echo "You Send Wrong response\nGenerating Scene Canceled"
  exit
  fi
fi
echo "Finish - Folder name: ${SCENE_NAME}Scene .."

echo ""
echo ""
echo "Start - Generate ${SCENE_FOLDER}'s .."
mkdir "$SCENE_FOLDER"
cd $SCENE_FOLDER

# 코디네이터 파일 생성
FOLDER_COORDINATOR="Coordinator"
COORDINATOR_NAME=$SCENE_NAME$FOLDER_COORDINATOR
COORDINATOR_FILE=$COORDINATOR_NAME.swift


# View 폴더 생성
FOLDER_VIEW="View"
VIEW_NAME="${SCENE_NAME}${FOLDER_VIEW}Controller"
VIEW_FILE=$VIEW_NAME.swift


# View 폴더 생성
FOLDER_VIEWMODEL="ViewModel"
VIEWMODEL_NAME=$SCENE_NAME$FOLDER_VIEWMODEL
VIEWMODEL_FILE=$VIEWMODEL_NAME.swift
echo "Finish - Generate $SCENE_FOLDER .."

######################## 파일 생성

echo ""
echo ""
echo "Start - Generate ${FOLDER_VIEW} .."
mkdir "$FOLDER_VIEW"
cd $FOLDER_VIEW

# 파일 입력
touch $VIEW_FILE
echo "// " >> $VIEW_FILE
echo "// $VIEW_FILE" >> $VIEW_FILE
echo "// " >> $VIEW_FILE
echo "
import UIKit

class ${VIEW_NAME}: BaseViewController<${VIEWMODEL_NAME}> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.bindViewModel()
        self.viewModel.viewDidLoad()
        self.bindEvent()

    }

    deinit {
        Debug.print("")
    }
}

extension ${VIEW_NAME} {
    private func setUI() {

    }
}

extension ${VIEW_NAME} {
    private func bindViewModel() {
        
    }
}

extension ${VIEW_NAME} {
    private func bindEvent() {

    }
}

" >> $VIEW_FILE
echo "Finish - Generate ${VIEW_FILE} .."


cd ..
echo ""
echo ""
echo "Start - Generate ${FOLDER_VIEWMODEL} .."
mkdir "$FOLDER_VIEWMODEL"
cd $FOLDER_VIEWMODEL

# 파일 입력

touch $VIEWMODEL_FILE
echo "// " >> $VIEWMODEL_FILE
echo "// $VIEWMODEL_FILE" >> $VIEWMODEL_FILE
echo "// " >> $VIEWMODEL_FILE
echo "
import Foundation

struct ${VIEWMODEL_NAME}Input {
    
}


class ${VIEWMODEL_NAME}: BaseViewModel<${VIEWMODEL_NAME}Input, ${COORDINATOR_NAME}Action> {
 
    // MARK: - Private Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareViewModel()
        self.setEvent()
        self.setData()
        
    }
    
    private func prepareViewModel() {
     
    }
    
    deinit {
        Debug.print("")
    }
}

// MARK: - Event
extension ${VIEWMODEL_NAME} {
    private func setEvent() {
        
    }
}

// MARK: - Data
extension ${VIEWMODEL_NAME} {
    private func setData() {
        
    }
}
" >> $VIEWMODEL_FILE
echo "Finish - Generate ${VIEWMODEL_FILE} .."
echo ""
echo ""
cd ..

echo "Start - Generate ${FOLDER_COORDINATOR} .."
mkdir "$FOLDER_COORDINATOR"
cd $FOLDER_COORDINATOR


# 파일 입력
touch $COORDINATOR_FILE
echo "// " >> $COORDINATOR_FILE
echo "// $COORDINATOR_FILE" >> $COORDINATOR_FILE
echo "// " >> $COORDINATOR_FILE
echo "
import Foundation

struct ${COORDINATOR_NAME}Implementation {
    
}

class ${COORDINATOR_NAME}: BaseCoordinator {
    private let implementation: ${COORDINATOR_NAME}Implementation
    
    var inputs: ${VIEWMODEL_NAME}Input!

    init(implementation: ${COORDINATOR_NAME}Implementation) {
        self.implementation = implementation
    }
    
    deinit {
        Debug.print("")
    }

    override func setInput() {
        
        self.inputs = ${VIEWMODEL_NAME}Input(
        )
    }
    override func start() {
        let vc = self.createViewController(input: self.inputs)
        // self.pushVC(vc, completion: nil)

    }

}

protocol ${COORDINATOR_NAME}Injection {
    func createViewController(
        input: ${VIEWMODEL_NAME}Input!
    ) -> ${VIEW_NAME}
}

extension ${COORDINATOR_NAME}: ${COORDINATOR_NAME}Injection {
    func createViewController(
        input: ${VIEWMODEL_NAME}Input!
    ) -> ${VIEW_NAME} {
        let viewModel = ${VIEWMODEL_NAME}(input: inputs, actions: self)
        let vc = ${VIEW_NAME}(viewModel: viewModel)
        return vc
    }
}

protocol ${COORDINATOR_NAME}Action {
    // MARK: Make Actions
}

extension ${COORDINATOR_NAME}: ${COORDINATOR_NAME}Action {
    
}
" >> $COORDINATOR_FILE
echo "Finish - Generate ${COORDINATOR_FILE} .."

echo ""
echo ""
cd ..



CURRENT_PATH="$(find $PWD -type d -name "$SCENE_FOLDER")"
echo $CURRENT_PATH
echo "Copying $SCENE_FOLDER Scene to $LAYER_FOLDER Folder .."
sudo mv -v "$CURRENT_PATH" "$RESULT_PATH/"


echo " "
echo "Open $LAYER_FOLDER Folder "
cd "$RESULT_PATH/$SCENE_FOLDER"
open .

echo " "
echo " "
echo "[Finished]========================================"
echo "Add Generated Scene to .xcodeproj "

