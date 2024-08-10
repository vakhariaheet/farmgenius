import { connect } from 'mongoose';
const connectDB = async () => {
    await connect(process.env.MONGO_URI);
    
    console.log('Database connected 🚀 🚀 ')
}

export default connectDB;