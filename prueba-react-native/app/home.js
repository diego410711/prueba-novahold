import { View, Text, Button } from 'react-native';
import { useRouter } from 'expo-router';

export default function Home() {
    const router = useRouter();

    return (
        <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
            <Text>Pantalla de Home</Text>
            <Button title="Cerrar Sesión" onPress={() => router.push('/')} />
        </View>
    );
}
