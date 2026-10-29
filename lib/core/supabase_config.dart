// Isi dua nilai di bawah dari Supabase Dashboard:
// Project Settings -> API (atau API Keys)
//
// - supabaseUrl         : Project URL
// - supabasePublishableKey : Publishable / anon key
//
// JANGAN memakai service_role / secret key di aplikasi Flutter.

const String supabaseUrl = 'https://yqlvxbwqarxeyqixnnca.supabase.co';
const String supabasePublishableKey = 'sb_publishable_zRLeyb2kI3pH4uOY7UqFwA_ej-N9aGX';

bool get isSupabaseConfigured =>
    supabaseUrl.startsWith('https://') &&
    !supabaseUrl.contains('PROJECT_ID') &&
    supabasePublishableKey.isNotEmpty &&
    !supabasePublishableKey.startsWith('ISI_');
