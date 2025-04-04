import React, { useState, useEffect } from 'react';
import { View, StyleSheet, Alert } from 'react-native';
import { TextInput, Button, Text } from 'react-native-paper';
import { useRouter, useLocalSearchParams } from 'expo-router';
import axios from 'axios';

export default function AddProduct() {
    const router = useRouter();
    const params = useLocalSearchParams(); // Recibir datos del producto

    // Si params tiene un id, estamos editando un producto
    const isEditing = !!params.id;

    // Estado inicial basado en los parámetros recibidos
    const [nombre, setNombre] = useState(params.nombre || '');
    const [descripcion, setDescripcion] = useState(params.descripcion || '');
    const [precio, setPrecio] = useState(params.precio ? params.precio.toString() : '');

    const handleSave = async () => {
        if (!nombre || !descripcion || !precio) {
            alert('Todos los campos son obligatorios.');
            return;
        }

        try {
            if (isEditing) {
                // Enviar una solicitud PUT para actualizar el producto
                await axios.put(`http://localhost:8080/aplicacion-prueba-0.0.1-SNAPSHOT/api/productos/actualizar`, {
                    id: params.id,
                    nombre,
                    descripcion,
                    precio: parseFloat(precio),
                });
                alert('Producto actualizado correctamente.');
            } else {
                // Enviar una solicitud POST para crear un nuevo producto
                await axios.post('http://localhost:8080/aplicacion-prueba-0.0.1-SNAPSHOT/api/productos/guardar', {
                    nombre,
                    descripcion,
                    precio: parseFloat(precio),
                });
                alert('Producto agregado correctamente.');
            }

            router.replace('/home'); // Regresar a la pantalla de inicio
        } catch (error) {
            console.error('Error al guardar producto:', error);
            alert('Error', error.response?.data?.message || 'No se pudo completar la operación.');
        }
    };

    return (
        <View style={styles.container}>
            <Text variant="headlineMedium" style={styles.title}>
                {isEditing ? 'Editar Producto' : 'Agregar Producto'}
            </Text>
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
                {isEditing ? 'Actualizar Producto' : 'Guardar Producto'}
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
