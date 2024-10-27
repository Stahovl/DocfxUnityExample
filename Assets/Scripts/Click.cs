using UnityEngine;
using UnityEngine.UIElements;

/// <summary>
/// Main and only class for the docfx example
/// </summary>
/// <remarks>
/// This class works in conjunction with Main.uxml file.
/// For more information about the UI structure see <see href="~/ui/index.md">UI Documentation</see>.
/// </remarks>
public class Click : MonoBehaviour
{
    [SerializeField] private UIDocument _mainDocument;

    private Button _counterButton;

    private int _counter = 0;

    private void OnValidate()
    {
        if (_mainDocument == null)
        {
            Debug.LogError($"UIDocument not set in {gameObject.name}", this);
        }
    }

    private void Start()
    {
        var root = GetComponent<UIDocument>().rootVisualElement;

        _counterButton = root.Q<Button>("CounterButton");
        _counterButton.clicked += OnCounterButtonClick;
    }

    private void OnDisable()
    {
        if (_counterButton != null)
        {
            _counterButton.clicked -= OnCounterButtonClick;
        }
    }

    private void OnCounterButtonClick()
    {
        _counterButton.text = $"{_counter++}";
    }
}
