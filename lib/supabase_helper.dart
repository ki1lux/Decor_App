import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  static Future<void> init() async {
    await Supabase.initialize(
    url: "https://pzehwtouyteodhpnrtxd.supabase.co/",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6ZWh3dG91eXRlb2RocG5ydHhkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgxNTc3NTksImV4cCI6MjA5MzczMzc1OX0.ooaKhcn1e9HyIjr0Ed32kmWmA2AdDaEexrUPHezpruk",
  );
  }
}
