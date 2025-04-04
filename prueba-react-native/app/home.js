import React, { useEffect, useState } from 'react';
import { View, FlatList, StyleSheet } from 'react-native';
import { Card, Text, Button, ActivityIndicator, Modal, Portal, Provider, useTheme } from 'react-native-paper';
import { useRouter } from 'expo-router';
import axios from 'axios';

export default function Home() {
    const router = useRouter();
    const theme = useTheme(); // Obtener el tema actual
    const [products, setProducts] = useState([]);
    const [loading, setLoading] = useState(true);
    const [visible, setVisible] = useState(false);
    const [selectedProduct, setSelectedProduct] = useState(null);

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

    const showModal = (id) => {
        setSelectedProduct(id);
        setVisible(true);
    };

    const hideModal = () => {
        setSelectedProduct(null);
        setVisible(false);
    };

    const handleDelete = async () => {
        if (!selectedProduct) return;

        try {
            await axios.delete(
                `http://localhost:8080/aplicacion-prueba-0.0.1-SNAPSHOT/api/productos/eliminar`,
                { data: { id: selectedProduct } } // Enviar el ID en el payload
            );
            fetchProducts(); // Recargar la lista después de eliminar
        } catch (error) {
            console.error("Error al eliminar producto:", error);
        } finally {
            hideModal();
        }
    };

    const renderItem = ({ item }) => (
        <Card style={[styles.card, { backgroundColor: theme.colors.surface }]}>
            <Card.Content>
                <Text variant="titleLarge" style={{ color: theme.colors.onSurface }}>{item.nombre}</Text>
                <Text variant="bodyMedium" style={{ color: theme.colors.onSurface }}>Precio: ${item.precio}</Text>
                <Text variant="bodySmall" style={{ color: theme.colors.onSurface }}>Descripción: {item.descripcion}</Text>
            </Card.Content>
            <Card.Actions>
                <Button
                    mode="outlined"
                    onPress={() => router.push({ pathname: "/product/new", params: { id: item.id, nombre: item.nombre, descripcion: item.descripcion, precio: item.precio } })}
                    textColor={theme.colors.primary}
                >
                    Editar
                </Button>


                <Button
                    mode="contained"
                    onPress={() => showModal(item.id)}
                    style={[styles.deleteButton, { backgroundColor: theme.colors.error }]}
                    textColor={theme.colors.onPrimary} // Asegura que el texto sea visible en el botón de eliminar
                >
                    Eliminar
                </Button>
            </Card.Actions>
        </Card>
    );

    return (
        <Provider>
            <View style={[styles.container, { backgroundColor: theme.colors.background }]}>
                <Button mode="contained" onPress={() => router.push('/product/new')} style={styles.addButton}>
                    Agregar Producto
                </Button>

                {loading ? (
                    <ActivityIndicator animating={true} size="large" color={theme.colors.primary} />
                ) : (
                    <FlatList
                        data={products}
                        keyExtractor={(item) => item.id.toString()}
                        renderItem={renderItem}
                    />
                )}

                {/* Modal de Confirmación */}
                <Portal>
                    <Modal visible={visible} onDismiss={hideModal} contentContainerStyle={[styles.modal, { backgroundColor: theme.colors.surface }]}>
                        <Text variant="titleLarge" style={{ color: theme.colors.onSurface }}>Eliminar Producto</Text>
                        <Text style={{ color: theme.colors.onSurface }}>¿Estás seguro de que quieres eliminar este producto?</Text>
                        <View style={styles.modalActions}>
                            <Button mode="outlined" onPress={hideModal} textColor={theme.colors.primary}>Cancelar</Button>
                            <Button
                                mode="contained"
                                onPress={handleDelete}
                                style={[styles.deleteButton, { backgroundColor: theme.colors.error }]}
                                textColor={theme.colors.onPrimary}
                            >
                                Eliminar
                            </Button>
                        </View>
                    </Modal>
                </Portal>
            </View>
        </Provider>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 20,
    },
    card: {
        marginBottom: 10,
        borderRadius: 8,
        padding: 10,
    },
    addButton: {
        marginBottom: 15,
    },
    deleteButton: {
        marginLeft: 10,
    },
    modal: {
        padding: 20,
        marginHorizontal: 20,
        borderRadius: 10,
    },
    modalActions: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginTop: 20,
    },
});
