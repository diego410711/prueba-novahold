import React, { useState } from 'react';
import { View, StyleSheet } from 'react-native';
import { Button, TextInput, Text } from 'react-native-paper';
import { useRouter } from 'expo-router';
import axios from 'axios';

export default function LoginScreen({ navigation }) {
    const router = useRouter();
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [loading, setLoading] = useState(false);

    const handleLogin = async () => {
        if (!email || !password) {
            alert('Por favor, ingresa tu correo y contraseña');
            return;
        }

        setLoading(true);

        try {
            const response = await axios.post('http://localhost:8080/aplicacion-prueba-0.0.1-SNAPSHOT/api/auth/login', {
                email,
                password
            });

            if (response.status === 200) {
                alert('Inicio de sesión exitoso');
                navigation.replace('Home'); // Redirige a Home después de loguearse
            } else {
                alert('Error en el inicio de sesión');
            }
        } catch (error) {
            alert('Credenciales incorrectas o error en el servidor');
            console.error(error);
        } finally {
            setLoading(false);
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
            <Button mode="contained" onPress={handleLogin} style={styles.button} loading={loading} disabled={loading}>
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
    input: {
        marginBottom: 10,
    },
    button: { marginTop: 10, width: '100%' },
});
