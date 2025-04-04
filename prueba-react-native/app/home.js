import React, { useEffect, useState } from 'react';
import { View, FlatList, StyleSheet } from 'react-native';
import { Card, Text, Button, ActivityIndicator } from 'react-native-paper';
import { useRouter } from 'expo-router';
import axios from 'axios';

export default function Home() {
    const router = useRouter();
    const [products, setProducts] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchProducts();
    }, []);

    const fetchProducts = async () => {
        try {
            const response = await axios.get('http://localhost:8080/aplicacion-prueba-0.0.1-SNAPSHOT/api/productos');
            setProducts(response.data);
        } catch (error) {
            console.error('Error al cargar productos:', error);
        } finally {
            setLoading(false);
        }
    };

    const renderItem = ({ item }) => (
        <Card style={styles.card}>
            <Card.Content>
                <Text variant="titleLarge">{item.nombre}</Text>
                <Text variant="bodyMedium">Precio: ${item.precio}</Text>
                <Text variant="bodySmall">Stock: {item.stock}</Text>
            </Card.Content>
            <Card.Actions>
                <Button mode="contained" onPress={() => router.push(`/producto/${item.id}`)}>
                    Ver Detalles
                </Button>
            </Card.Actions>
        </Card>
    );

    return (
        <View style={styles.container}>
            <Button
                mode="contained"
                onPress={() => router.push('/product/new')}
                style={styles.addButton}
            >
                Agregar Producto
            </Button>

            {loading ? (
                <ActivityIndicator animating={true} size="large" />
            ) : (
                <FlatList
                    data={products}
                    keyExtractor={(item) => item.id.toString()}
                    renderItem={renderItem}
                />
            )}
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 20,
        backgroundColor: '#f5f5f5',
    },
    card: {
        marginBottom: 10,
    },
    addButton: {
        marginBottom: 15,
    },
});
