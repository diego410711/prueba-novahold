import React, { useState } from 'react';
import { View, StyleSheet } from 'react-native';
import { Button, TextInput, Text, useTheme } from 'react-native-paper';
import { useRouter } from 'expo-router';
import axios from 'axios';

export default function Index() {
    const router = useRouter();
    const theme = useTheme(); // Detecta si el usuario está en modo oscuro o claro
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
                router.replace('/home'); // Redirige a Home después de loguearse
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
        <View style={[styles.container, { backgroundColor: theme.colors.background }]}>
            <Text style={[styles.title, { color: theme.colors.onBackground }]}>
                Iniciar Sesión
            </Text>

            <TextInput
                style={styles.input}
                label="Correo electrónico"
                value={email}
                onChangeText={setEmail}
                mode="outlined"
                theme={{ colors: { text: theme.colors.onBackground } }}
            />
            <TextInput
                style={styles.input}
                label="Contraseña"
                secureTextEntry
                value={password}
                onChangeText={setPassword}
                mode="outlined"
                theme={{ colors: { text: theme.colors.onBackground } }}
            />

            <Button mode="contained" onPress={handleLogin} style={styles.button} loading={loading} disabled={loading}>
                Iniciar Sesión
            </Button>

            <Button onPress={() => router.push('/register')} textColor={theme.colors.primary}>
                ¿No tienes cuenta? Regístrate
            </Button>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        padding: 20,
    },
    title: {
        fontSize: 24,
        fontWeight: 'bold',
        textAlign: 'center',
        marginBottom: 20,
    },
    input: {
        marginBottom: 10,
    },
    button: {
        marginTop: 10,
        width: '100%',
    },
});
