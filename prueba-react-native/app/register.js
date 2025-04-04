import React, { useState } from 'react';
import { View, StyleSheet } from 'react-native';
import { TextInput, Button, Text, useTheme } from 'react-native-paper';
import { useRouter } from 'expo-router';
import axios from 'axios';

export default function Register() {
    const router = useRouter();
    const theme = useTheme();

    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [loading, setLoading] = useState(false);

    const handleRegister = async () => {
        if (!name || !email || !password) {
            alert('Por favor, completa todos los campos');
            return;
        }

        setLoading(true);

        try {
            const response = await axios.post(
                'http://localhost:8080/aplicacion-prueba-0.0.1-SNAPSHOT/api/auth/registro',
                { nombre: name, email, password }
            );

            if (response.status === 200) {
                alert('Registro exitoso. Ahora inicia sesión.');
                router.replace('/'); // Redirige al login
            } else {
                alert('Error en el registro');
            }
        } catch (error) {
            alert('No se pudo completar el registro');
            console.error(error);
        } finally {
            setLoading(false);
        }
    };

    return (
        <View style={[styles.container, { backgroundColor: theme.colors.background }]}>
            <Text style={[styles.title, { color: theme.colors.onBackground }]}>
                Registro
            </Text>

            <TextInput
                label="Nombre"
                value={name}
                onChangeText={setName}
                mode="outlined"
                theme={{ colors: { text: theme.colors.onBackground } }}
                style={styles.input}
            />

            <TextInput
                label="Correo electrónico"
                value={email}
                onChangeText={setEmail}
                keyboardType="email-address"
                mode="outlined"
                theme={{ colors: { text: theme.colors.onBackground } }}
                style={styles.input}
            />

            <TextInput
                label="Contraseña"
                value={password}
                onChangeText={setPassword}
                secureTextEntry
                mode="outlined"
                theme={{ colors: { text: theme.colors.onBackground } }}
                style={styles.input}
            />

            <Button
                mode="contained"
                onPress={handleRegister}
                style={styles.button}
                loading={loading}
                disabled={loading}
            >
                Registrarse
            </Button>

            <Button onPress={() => router.push('/')} textColor={theme.colors.primary}>
                ¿Ya tienes una cuenta? Inicia sesión
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
