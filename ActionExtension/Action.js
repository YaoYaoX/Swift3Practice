var Action = function() {};

Action.prototype = {
    
    // 1. extension启动时调用，给extension传递相关参数
    run: function(parameters) {
        parameters.completionFunction({"URL": document.URL, "title": document.title });
    },
        
    // 2. extension消失时调用，通过可以获取extensionContext.completeRequest返回回来的参数，通过eval执行相关js
    finalize: function(parameters) {
        var customJS = parameters["customJS"];
        eval(customJS);
    }
    
};

var ExtensionPreprocessingJS = new Action
