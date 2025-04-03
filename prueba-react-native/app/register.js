import React, { useState } from 'react';
import { View, StyleSheet } from 'react-native';
import { TextInput, Button, Text, useTheme } from 'react-native-paper';
import { useRouter } from 'expo-router';

export default function Register() {
    const router = useRouter();
    const theme = useTheme(); // Detecta el tema del sistema

    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');

    const handleRegister = () => {
        console.log('Registrando usuario:', { name, email, password });
        // Aquí puedes llamar a una API para registrar el usuario
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

            <Button mode="contained" onPress={handleRegister} style={styles.button}>
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
