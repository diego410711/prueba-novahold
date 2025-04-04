import React, { useState } from 'react';
import { View, StyleSheet, Alert } from 'react-native';
import { TextInput, Button, Text } from 'react-native-paper';
import { useRouter } from 'expo-router';
import axios from 'axios';

export default function AddProduct() {
    const router = useRouter();
    const [nombre, setNombre] = useState('');
    const [descripcion, setDescripcion] = useState('');
    const [precio, setPrecio] = useState('');

    const handleSave = async () => {
        if (!nombre || !descripcion || !precio) {
            Alert.alert('Error', 'Todos los campos son obligatorios.');
            return;
        }

        try {
            const response = await axios.post(
                'http://localhost:8080/aplicacion-prueba-0.0.1-SNAPSHOT/api/productos/guardar',
                { nombre, descripcion, precio: parseFloat(precio) }
            );

            console.log('✅ Producto guardado:', response.data);

            alert(
                'Producto agregado correctamente',
            );
            router.replace('/home'); // Redirige a Home después de loguearse

        } catch (error) {
            console.error('Error al agregar producto:', error);

            alert(
                error.response?.data?.message || 'No se pudo agregar el producto.'
            );
        }
    };

    return (
        <View style={styles.container}>
            <Text variant="headlineMedium" style={styles.title}>Agregar Producto</Text>
            <TextInput
                label="Nombre"
                value={nombre}
                onChangeText={setNombre}
                mode="outlined"
                style={styles.input}
            />
            <TextInput
                label="Descripción"
                value={descripcion}
                onChangeText={setDescripcion}
                mode="outlined"
                multiline
                numberOfLines={3}
                style={styles.input}
            />
            <TextInput
                label="Precio"
                value={precio}
                onChangeText={setPrecio}
                keyboardType="numeric"
                mode="outlined"
                style={styles.input}
            />
            <Button mode="contained" onPress={handleSave} style={styles.button}>
                Guardar Producto
            </Button>
            <Button mode="outlined" onPress={() => router.back()} style={styles.button}>
                Cancelar
            </Button>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 20,
        justifyContent: 'center',
        backgroundColor: '#f5f5f5',
    },
    title: {
        textAlign: 'center',
        marginBottom: 20,
    },
    input: {
        marginBottom: 15,
    },
    button: {
        marginVertical: 5,
    },
});
