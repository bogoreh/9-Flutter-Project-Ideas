class CalculatorOperations {
  static String evaluateExpression(String expression) {
    try {
      // Simple evaluation without external package
      // This is a basic implementation - for complex expressions, consider using math_expressions
      expression = expression.replaceAll('×', '*').replaceAll('÷', '/');
      
      // Simple evaluation for basic operations
      if (expression.contains('+') || expression.contains('-') || 
          expression.contains('*') || expression.contains('/')) {
        
        // Split by operators but keep them
        List<String> parts = [];
        String current = '';
        
        for (int i = 0; i < expression.length; i++) {
          String char = expression[i];
          if ('+-*/'.contains(char)) {
            if (current.isNotEmpty) {
              parts.add(current);
              current = '';
            }
            parts.add(char);
          } else {
            current += char;
          }
        }
        if (current.isNotEmpty) {
          parts.add(current);
        }
        
        // Evaluate multiplication and division first
        for (int i = 0; i < parts.length; i++) {
          if (parts[i] == '*' || parts[i] == '/') {
            double left = double.parse(parts[i - 1]);
            double right = double.parse(parts[i + 1]);
            double result = parts[i] == '*' ? left * right : left / right;
            parts[i - 1] = result.toString();
            parts.removeRange(i, i + 2);
            i--;
          }
        }
        
        // Evaluate addition and subtraction
        double result = double.parse(parts[0]);
        for (int i = 1; i < parts.length; i += 2) {
          double right = double.parse(parts[i + 1]);
          if (parts[i] == '+') {
            result += right;
          } else {
            result -= right;
          }
        }
        
        // Return result without decimal if it's an integer
        return result % 1 == 0 ? result.toInt().toString() : result.toStringAsFixed(2);
      }
      
      return expression;
    } catch (e) {
      return 'Error';
    }
  }
}