import React, { useState } from 'react';
import { View, StyleSheet } from 'react-native';
import { Button, TextInput, Text } from 'react-native-paper';
import { useRouter } from 'expo-router';

export default function LoginScreen({ navigation }) {

    const router = useRouter();

    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');

    const handleLogin = () => {
        if (email === 'admin@example.com' && password === '123456') {
            alert('Inicio de sesión exitoso');
            navigation.replace('Home'); // Redirige a Home después de loguearse
        } else {
            alert('Credenciales incorrectas');
        }
    };

    return (
        <View style={styles.container}>
            <TextInput
                style={styles.input}
                label="Correo electrónico"
                value={email}
                onChangeText={setEmail}
            />
            <TextInput
                style={styles.input}
                label="Contraseña"
                secureTextEntry
                value={password}
                onChangeText={setPassword}
            />
            <Button mode="contained" onPress={handleLogin} style={styles.button}>
                Iniciar Sesión
            </Button>
            <Button onPress={() => router.push('/screens/RegisterScreen')}>
                ¿No tienes cuenta? Regístrate
            </Button>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center', padding: 20
    },
    title: { fontSize: 24, fontWeight: 'bold', marginBottom: 20 },
    input: {
        marginBottom: 10,
    },
    button: { marginTop: 10, width: '100%' },
});
