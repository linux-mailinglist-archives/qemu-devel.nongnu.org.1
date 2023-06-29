Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B434742B9B
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 19:57:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEvre-0000Qg-8w; Thu, 29 Jun 2023 13:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEvra-0000PJ-Lv
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 13:55:26 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEvrN-0004oS-Ke
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 13:55:16 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-991e69499d1so101257366b.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688061311; x=1690653311;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjM8op6TLdmenZuMkF9yqJFq7L1y4/sfECN8FSLE1vo=;
 b=sHrdgU6gUqNb43IfzH8hYC9wfDJaIfhMtOqtD9dscYPicmNYMDCF/s80WVHFYfUen6
 nzNlyh1LLls0osOKoWGpss9BVhq1QYVToKfxA9nJKdYnH/5ZmCjGDMq3FYfQ26w6F1eh
 yYLNlqF5WEafiwfS9GwChtjqnRxZG3auivtF5/E0wHcm5BaY3x7Vjhgr+sd3ZRDgDLnS
 jGpWvLC8P3brvXnKWViNdKl9BH9azCLxF1hmV+p8nOtJ0osV+R02LzMqMTq0lCuZI2IO
 BK8FdQ0V98NU/wSHh1OpGLrp4S4v8k10HfpF22eYpk+TcwHDPZKHGnrajYCUh7OmiN7d
 7/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688061311; x=1690653311;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjM8op6TLdmenZuMkF9yqJFq7L1y4/sfECN8FSLE1vo=;
 b=eW7sMce5h2gyGBt3q1mFeNFQsnypygr+5cxzgO9njtJXHm1oiCokpnMh0iyJ0uTHBT
 ohVTrhYgigIVm+uqZag3IXyyPqVIdX7nO1B8v00gAFSg5qHTRyNufwc6MpwItNTonhKY
 ybemPdp60HpTxLkYqAD0wLPF9K1kXm9Q8Wv8FxgEpUv2NSIWzgA23dGYC99qVvJoMCkl
 oa0TqO2qn8OxfzskdFliB+RLgXGiXIRNOc+WjosnCB+xG53BVzYP+B3CoXYxsavLMncO
 1MEuX7McbSre8BaaMv3U6toibXA468rdIIglua9i7C8CLGiZsI3KH1ICixjgVwo3yOHX
 kRSQ==
X-Gm-Message-State: ABy/qLb4xF7rPTRD1DsckIuP5yJ5xCDg9NlnhQnqdSnRFZhS76z6SOCA
 uO8jcGVwur8dmo9/OCN3JEUWlpCWejw=
X-Google-Smtp-Source: APBJJlFB8LHc+64a+ZDLVBjCZf+4erqE12Z5bIFGqromiLsx6PYwe6EZSnsIxNI/gzrpgZh4Z/WjIA==
X-Received: by 2002:a17:906:5904:b0:98e:18ea:442c with SMTP id
 h4-20020a170906590400b0098e18ea442cmr170856ejq.45.1688061311068; 
 Thu, 29 Jun 2023 10:55:11 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-043-218.77.11.pool.telefonica.de.
 [77.11.43.218]) by smtp.gmail.com with ESMTPSA id
 oz31-20020a170906cd1f00b0098860721959sm7060609ejb.198.2023.06.29.10.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 10:55:10 -0700 (PDT)
Date: Thu, 29 Jun 2023 17:55:06 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
CC: richard.henderson@linaro.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 17/33] ui/dbus: win32 support
In-Reply-To: <20230627130231.1614896-18-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
 <20230627130231.1614896-18-marcandre.lureau@redhat.com>
Message-ID: <BCD39302-3C86-483C-A5FC-424F88CF791A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



Am 27=2E Juni 2023 13:02:14 UTC schrieb marcandre=2Elureau@redhat=2Ecom:
>From: Marc-Andr=C3=A9 Lureau <marcandre=2Elureau@redhat=2Ecom>
>
>D-Bus doesn't support fd-passing on Windows (AF_UNIX doesn't have
>SCM_RIGHTS yet, but there are other means to share objects=2E I have
>proposed various solutions upstream, but none seem fitting enough atm)=2E
>
>To make the "-display dbus" work on Windows, implement an alternative
>D-Bus interface where all the 'h' (FDs) arguments are replaced with
>'ay' (WSASocketW data), and sockets are passed to the other end via
>WSADuplicateSocket()=2E
>
>Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre=2Elureau@redhat=2Ecom>
>Message-Id: <20230606115658=2E677673-6-marcandre=2Elureau@redhat=2Ecom>
>---
> meson=2Ebuild          |  4 +--
> ui/dbus=2Eh            |  6 +++++
> audio/dbusaudio=2Ec    | 44 +++++++++++++++++++++++++++------
> ui/dbus-chardev=2Ec    | 22 +++++++++++++----
> ui/dbus-console=2Ec    | 59 ++++++++++++++++++++++++++++++++++++++------
> ui/dbus-display1=2Exml | 28 +++++++++++++++++++++
> ui/meson=2Ebuild       |  9 ++++++-
> 7 files changed, 149 insertions(+), 23 deletions(-)
>
>diff --git a/meson=2Ebuild b/meson=2Ebuild
>index b409788832=2E=2E9a1ce43471 100644
>--- a/meson=2Ebuild
>+++ b/meson=2Ebuild
>@@ -838,6 +838,8 @@ if gdbus_codegen=2Efound() and get_option('cfi')
>   gdbus_codegen_error =3D '@0@ uses gdbus-codegen, which does not suppor=
t control flow integrity'
> endif
>=20
>+xml_pp =3D find_program('scripts/xml-preprocess=2Epy')
>+
> lttng =3D not_found
> if 'ust' in get_option('trace_backends')
>   lttng =3D dependency('lttng-ust', required: true, version: '>=3D 2=2E1=
',
>@@ -1985,8 +1987,6 @@ dbus_display =3D get_option('dbus_display') \
>            error_message: '-display dbus requires glib>=3D2=2E64') \
>   =2Erequire(gdbus_codegen=2Efound(),
>            error_message: gdbus_codegen_error=2Eformat('-display dbus'))=
 \
>-  =2Erequire(targetos !=3D 'windows',
>-           error_message: '-display dbus is not available on Windows') \
>   =2Eallowed()
>=20
> have_virtfs =3D get_option('virtfs') \
>diff --git a/ui/dbus=2Eh b/ui/dbus=2Eh
>index 9c149e7b41=2E=2E1e8c24a48e 100644
>--- a/ui/dbus=2Eh
>+++ b/ui/dbus=2Eh
>@@ -62,6 +62,12 @@ struct DBusDisplay {
>     Notifier notifier;
> };
>=20
>+#ifdef WIN32
>+bool
>+dbus_win32_import_socket(GDBusMethodInvocation *invocation,
>+                         GVariant *arg_listener, int *socket);
>+#endif
>+
> #define TYPE_DBUS_DISPLAY "dbus-display"
> OBJECT_DECLARE_SIMPLE_TYPE(DBusDisplay, DBUS_DISPLAY)
>=20
>diff --git a/audio/dbusaudio=2Ec b/audio/dbusaudio=2Ec
>index de59467d9e=2E=2E7a11fbfb42 100644
>--- a/audio/dbusaudio=2Ec
>+++ b/audio/dbusaudio=2Ec
>@@ -33,6 +33,7 @@
> #include <gio/gunixfdlist=2Eh>
> #endif
>=20
>+#include "ui/dbus=2Eh"

This patch causes below compile error since pixman=2Eh isn't found=2E It s=
eems as if the pixman include path is missing=2E Since pixman=2Eh is found =
elsewhere in the same build I suspect that the DBUS audio module now needs =
a pixman dependency -- which sounds a little bit weired=2E

FAILED: libaudio-dbus=2Ea=2Ep/audio_dbusaudio=2Ec=2Eo=20
cc -m64 -mcx16 -Ilibaudio-dbus=2Ea=2Ep -I=2E -I=2E=2E/src -Iqapi -Itrace -=
Iui -Iui/shader -I/usr/include/glib-2=2E0 -I/usr/lib/glib-2=2E0/include -I/=
usr/include/sysprof-4 -I/usr/include/libmount -I/usr/include/blkid -I/usr/i=
nclude/gio-unix-2=2E0 -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werro=
r -std=3Dgnu11 -O0 -g -fstack-protector-strong -Wundef -Wwrite-strings -Wmi=
ssing-prototypes -Wstrict-prototypes -Wredundant-decls -Wold-style-declarat=
ion -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k -Wi=
nit-self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels =
-Wexpansion-to-defined -Wimplicit-fallthrough=3D2 -Wmissing-format-attribut=
e -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi -isystem q=
emu/src/linux-headers -isystem linux-headers -iquote =2E -iquote qemu/src -=
iquote qemu/src/include -iquote qemu/src/host/include/x86_64 -iquote qemu/s=
rc/host/include/generic -iquote qemu/src/tcg/i386 -Wno-unused-function -pth=
read -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict=
-aliasing -fno-common -fwrapv -march=3Dx86-64 -mtune=3Dgeneric -O2 -pipe -f=
no-plt -fexceptions -Wp,-D_FORTIFY_SOURCE=3D2 -Wformat -Werror=3Dformat-sec=
urity -fstack-clash-protection -fcf-protection -fPIC -DBUILD_DSO -MD -MQ li=
baudio-dbus=2Ea=2Ep/audio_dbusaudio=2Ec=2Eo -MF libaudio-dbus=2Ea=2Ep/audio=
_dbusaudio=2Ec=2Eo=2Ed -o libaudio-dbus=2Ea=2Ep/audio_dbusaudio=2Ec=2Eo -c =
=2E=2E/src/audio/dbusaudio=2Ec
In file included from qemu/src/include/ui/console=2Eh:4,
                 from qemu/src/ui/dbus=2Eh:31,
                 from =2E=2E/src/audio/dbusaudio=2Ec:36:
qemu/src/include/ui/qemu-pixman=2Eh:12:10: fatal error: pixman=2Eh: No suc=
h file or directory
   12 | #include <pixman=2Eh>
      |          ^~~~~~~~~~

Best regards,
Bernhard

> #include "ui/dbus-display1=2Eh"
>=20
> #define AUDIO_CAP "dbus"
>@@ -422,7 +423,6 @@ dbus_audio_fini(void *opaque)
>     g_free(da);
> }
>=20
>-#ifdef G_OS_UNIX
> static void
> listener_out_vanished_cb(GDBusConnection *connection,
>                          gboolean remote_peer_vanished,
>@@ -448,7 +448,9 @@ listener_in_vanished_cb(GDBusConnection *connection,
> static gboolean
> dbus_audio_register_listener(AudioState *s,
>                              GDBusMethodInvocation *invocation,
>+#ifdef G_OS_UNIX
>                              GUnixFDList *fd_list,
>+#endif
>                              GVariant *arg_listener,
>                              bool out)
> {
>@@ -475,6 +477,11 @@ dbus_audio_register_listener(AudioState *s,
>         return DBUS_METHOD_INVOCATION_HANDLED;
>     }
>=20
>+#ifdef G_OS_WIN32
>+    if (!dbus_win32_import_socket(invocation, arg_listener, &fd)) {
>+        return DBUS_METHOD_INVOCATION_HANDLED;
>+    }
>+#else
>     fd =3D g_unix_fd_list_get(fd_list, g_variant_get_handle(arg_listener=
), &err);
>     if (err) {
>         g_dbus_method_invocation_return_error(invocation,
>@@ -484,6 +491,7 @@ dbus_audio_register_listener(AudioState *s,
>                                               err->message);
>         return DBUS_METHOD_INVOCATION_HANDLED;
>     }
>+#endif
>=20
>     socket =3D g_socket_new_from_fd(fd, &err);
>     if (err) {
>@@ -492,15 +500,28 @@ dbus_audio_register_listener(AudioState *s,
>                                               DBUS_DISPLAY_ERROR_FAILED,
>                                               "Couldn't make a socket: %=
s",
>                                               err->message);
>+#ifdef G_OS_WIN32
>+        closesocket(fd);
>+#else
>+        close(fd);
>+#endif
>         return DBUS_METHOD_INVOCATION_HANDLED;
>     }
>     socket_conn =3D g_socket_connection_factory_create_connection(socket=
);
>     if (out) {
>         qemu_dbus_display1_audio_complete_register_out_listener(
>-            da->iface, invocation, NULL);
>+            da->iface, invocation
>+#ifdef G_OS_UNIX
>+            , NULL
>+#endif
>+            );
>     } else {
>         qemu_dbus_display1_audio_complete_register_in_listener(
>-            da->iface, invocation, NULL);
>+            da->iface, invocation
>+#ifdef G_OS_UNIX
>+            , NULL
>+#endif
>+            );
>     }
>=20
>     listener_conn =3D
>@@ -578,24 +599,33 @@ dbus_audio_register_listener(AudioState *s,
> static gboolean
> dbus_audio_register_out_listener(AudioState *s,
>                                  GDBusMethodInvocation *invocation,
>+#ifdef G_OS_UNIX
>                                  GUnixFDList *fd_list,
>+#endif
>                                  GVariant *arg_listener)
> {
>     return dbus_audio_register_listener(s, invocation,
>-                                        fd_list, arg_listener, true);
>+#ifdef G_OS_UNIX
>+                                        fd_list,
>+#endif
>+                                        arg_listener, true);
>=20
> }
>=20
> static gboolean
> dbus_audio_register_in_listener(AudioState *s,
>                                 GDBusMethodInvocation *invocation,
>+#ifdef G_OS_UNIX
>                                 GUnixFDList *fd_list,
>+#endif
>                                 GVariant *arg_listener)
> {
>     return dbus_audio_register_listener(s, invocation,
>-                                        fd_list, arg_listener, false);
>-}
>+#ifdef G_OS_UNIX
>+                                        fd_list,
> #endif
>+                                        arg_listener, false);
>+}
>=20
> static void
> dbus_audio_set_server(AudioState *s, GDBusObjectManagerServer *server, b=
ool p2p)
>@@ -610,14 +640,12 @@ dbus_audio_set_server(AudioState *s, GDBusObjectMan=
agerServer *server, bool p2p)
>=20
>     da->audio =3D g_dbus_object_skeleton_new(DBUS_DISPLAY1_AUDIO_PATH);
>     da->iface =3D qemu_dbus_display1_audio_skeleton_new();
>-#ifdef G_OS_UNIX
>     g_object_connect(da->iface,
>                      "swapped-signal::handle-register-in-listener",
>                      dbus_audio_register_in_listener, s,
>                      "swapped-signal::handle-register-out-listener",
>                      dbus_audio_register_out_listener, s,
>                      NULL);
>-#endif
>=20
>     g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(da->audi=
o),
>                                          G_DBUS_INTERFACE_SKELETON(da->i=
face));
>diff --git a/ui/dbus-chardev=2Ec b/ui/dbus-chardev=2Ec
>index 7154d81a9a=2E=2E1d3a7122a1 100644
>--- a/ui/dbus-chardev=2Ec
>+++ b/ui/dbus-chardev=2Ec
>@@ -110,18 +110,24 @@ dbus_chardev_init(DBusDisplay *dpy)
>                          dbus_display_chardev_foreach, dpy);
> }
>=20
>-#ifdef G_OS_UNIX
> static gboolean
> dbus_chr_register(
>     DBusChardev *dc,
>     GDBusMethodInvocation *invocation,
>+#ifdef G_OS_UNIX
>     GUnixFDList *fd_list,
>+#endif
>     GVariant *arg_stream,
>     QemuDBusDisplay1Chardev *object)
> {
>     g_autoptr(GError) err =3D NULL;
>     int fd;
>=20
>+#ifdef G_OS_WIN32
>+    if (!dbus_win32_import_socket(invocation, arg_stream, &fd)) {
>+        return DBUS_METHOD_INVOCATION_HANDLED;
>+    }
>+#else
>     fd =3D g_unix_fd_list_get(fd_list, g_variant_get_handle(arg_stream),=
 &err);
>     if (err) {
>         g_dbus_method_invocation_return_error(
>@@ -131,13 +137,18 @@ dbus_chr_register(
>             "Couldn't get peer FD: %s", err->message);
>         return DBUS_METHOD_INVOCATION_HANDLED;
>     }
>+#endif
>=20
>     if (qemu_chr_add_client(CHARDEV(dc), fd) < 0) {
>         g_dbus_method_invocation_return_error(invocation,
>                                               DBUS_DISPLAY_ERROR,
>                                               DBUS_DISPLAY_ERROR_FAILED,
>                                               "Couldn't register FD!");
>+#ifdef G_OS_WIN32
>+        closesocket(fd);
>+#else
>         close(fd);
>+#endif
>         return DBUS_METHOD_INVOCATION_HANDLED;
>     }
>=20
>@@ -145,10 +156,13 @@ dbus_chr_register(
>                  "owner", g_dbus_method_invocation_get_sender(invocation=
),
>                  NULL);
>=20
>-    qemu_dbus_display1_chardev_complete_register(object, invocation, NUL=
L);
>+    qemu_dbus_display1_chardev_complete_register(object, invocation
>+#ifndef G_OS_WIN32
>+                                                 , NULL
>+#endif
>+        );
>     return DBUS_METHOD_INVOCATION_HANDLED;
> }
>-#endif
>=20
> static gboolean
> dbus_chr_send_break(
>@@ -179,10 +193,8 @@ dbus_chr_open(Chardev *chr, ChardevBackend *backend,
>     dc->iface =3D qemu_dbus_display1_chardev_skeleton_new();
>     g_object_set(dc->iface, "name", backend->u=2Edbus=2Edata->name, NULL=
);
>     g_object_connect(dc->iface,
>-#ifdef G_OS_UNIX
>                      "swapped-signal::handle-register",
>                      dbus_chr_register, dc,
>-#endif
>                      "swapped-signal::handle-send-break",
>                      dbus_chr_send_break, dc,
>                      NULL);
>diff --git a/ui/dbus-console=2Ec b/ui/dbus-console=2Ec
>index d5f6c93637=2E=2E4a1c1fb55e 100644
>--- a/ui/dbus-console=2Ec
>+++ b/ui/dbus-console=2Ec
>@@ -165,7 +165,6 @@ dbus_display_console_class_init(DBusDisplayConsoleCla=
ss *klass)
>     gobject_class->dispose =3D dbus_display_console_dispose;
> }
>=20
>-#ifdef G_OS_UNIX
> static void
> listener_vanished_cb(DBusDisplayListener *listener)
> {
>@@ -177,7 +176,6 @@ listener_vanished_cb(DBusDisplayListener *listener)
>     g_hash_table_remove(ddc->listeners, name);
>     qkbd_state_lift_all_keys(ddc->kbd);
> }
>-#endif
>=20
> static gboolean
> dbus_console_set_ui_info(DBusDisplayConsole *ddc,
>@@ -211,11 +209,47 @@ dbus_console_set_ui_info(DBusDisplayConsole *ddc,
>     return DBUS_METHOD_INVOCATION_HANDLED;
> }
>=20
>-#ifdef G_OS_UNIX
>+#ifdef G_OS_WIN32
>+bool
>+dbus_win32_import_socket(GDBusMethodInvocation *invocation,
>+                         GVariant *arg_listener, int *socket)
>+{
>+    gsize n;
>+    WSAPROTOCOL_INFOW *info =3D (void *)g_variant_get_fixed_array(arg_li=
stener, &n, 1);
>+
>+    if (!info || n !=3D sizeof(*info)) {
>+        g_dbus_method_invocation_return_error(
>+            invocation,
>+            DBUS_DISPLAY_ERROR,
>+            DBUS_DISPLAY_ERROR_FAILED,
>+            "Failed to get socket infos");
>+        return false;
>+    }
>+
>+    *socket =3D WSASocketW(FROM_PROTOCOL_INFO,
>+                         FROM_PROTOCOL_INFO,
>+                         FROM_PROTOCOL_INFO,
>+                         info, 0, 0);
>+    if (*socket =3D=3D INVALID_SOCKET) {
>+        g_autofree gchar *emsg =3D g_win32_error_message(WSAGetLastError=
());
>+        g_dbus_method_invocation_return_error(
>+            invocation,
>+            DBUS_DISPLAY_ERROR,
>+            DBUS_DISPLAY_ERROR_FAILED,
>+            "Couldn't create socket: %s", emsg);
>+        return false;
>+    }
>+
>+    return true;
>+}
>+#endif
>+
> static gboolean
> dbus_console_register_listener(DBusDisplayConsole *ddc,
>                                GDBusMethodInvocation *invocation,
>+#ifdef G_OS_UNIX
>                                GUnixFDList *fd_list,
>+#endif
>                                GVariant *arg_listener)
> {
>     const char *sender =3D g_dbus_method_invocation_get_sender(invocatio=
n);
>@@ -237,6 +271,11 @@ dbus_console_register_listener(DBusDisplayConsole *d=
dc,
>         return DBUS_METHOD_INVOCATION_HANDLED;
>     }
>=20
>+#ifdef G_OS_WIN32
>+    if (!dbus_win32_import_socket(invocation, arg_listener, &fd)) {
>+        return DBUS_METHOD_INVOCATION_HANDLED;
>+    }
>+#else
>     fd =3D g_unix_fd_list_get(fd_list, g_variant_get_handle(arg_listener=
), &err);
>     if (err) {
>         g_dbus_method_invocation_return_error(
>@@ -246,6 +285,7 @@ dbus_console_register_listener(DBusDisplayConsole *dd=
c,
>             "Couldn't get peer fd: %s", err->message);
>         return DBUS_METHOD_INVOCATION_HANDLED;
>     }
>+#endif
>=20
>     socket =3D g_socket_new_from_fd(fd, &err);
>     if (err) {
>@@ -254,13 +294,21 @@ dbus_console_register_listener(DBusDisplayConsole *=
ddc,
>             DBUS_DISPLAY_ERROR,
>             DBUS_DISPLAY_ERROR_FAILED,
>             "Couldn't make a socket: %s", err->message);
>+#ifdef G_OS_WIN32
>+        closesocket(fd);
>+#else
>         close(fd);
>+#endif
>         return DBUS_METHOD_INVOCATION_HANDLED;
>     }
>     socket_conn =3D g_socket_connection_factory_create_connection(socket=
);
>=20
>     qemu_dbus_display1_console_complete_register_listener(
>-        ddc->iface, invocation, NULL);
>+        ddc->iface, invocation
>+#ifdef G_OS_UNIX
>+        , NULL
>+#endif
>+    );
>=20
>     listener_conn =3D g_dbus_connection_new_sync(
>         G_IO_STREAM(socket_conn),
>@@ -287,7 +335,6 @@ dbus_console_register_listener(DBusDisplayConsole *dd=
c,
>     trace_dbus_registered_listener(sender);
>     return DBUS_METHOD_INVOCATION_HANDLED;
> }
>-#endif
>=20
> static gboolean
> dbus_kbd_press(DBusDisplayConsole *ddc,
>@@ -516,10 +563,8 @@ dbus_display_console_new(DBusDisplay *display, QemuC=
onsole *con)
>         "device-address", device_addr,
>         NULL);
>     g_object_connect(ddc->iface,
>-#ifdef G_OS_UNIX
>         "swapped-signal::handle-register-listener",
>         dbus_console_register_listener, ddc,
>-#endif
>         "swapped-signal::handle-set-uiinfo",
>         dbus_console_set_ui_info, ddc,
>         NULL);
>diff --git a/ui/dbus-display1=2Exml b/ui/dbus-display1=2Exml
>index cc0c9b68bf=2E=2Ecd596f774e 100644
>--- a/ui/dbus-display1=2Exml
>+++ b/ui/dbus-display1=2Exml
>@@ -57,7 +57,13 @@
>         :dbus:iface:`org=2Eqemu=2EDisplay1=2EListener` interface=2E
>     -->
>     <method name=3D"RegisterListener">
>+      <?if $(env=2ETARGETOS) =3D=3D windows?>
>+      <arg type=3D"ay" name=3D"listener" direction=3D"in">
>+        <annotation name=3D"org=2Egtk=2EGDBus=2EC=2EForceGVariant" value=
=3D"true"/>
>+      </arg>
>+      <?else?>
>       <arg type=3D"h" name=3D"listener" direction=3D"in"/>
>+      <?endif?>
>     </method>
>=20
>     <!--
>@@ -334,6 +340,9 @@
>       </arg>
>     </method>
>=20
>+    <?if $(env=2ETARGETOS) =3D=3D windows?>
>+    <!-- Add shared memory/texture support -->
>+    <?else?>
>     <!--
>         ScanoutDMABUF:
>         @dmabuf: the DMABUF file descriptor=2E
>@@ -372,6 +381,7 @@
>       <arg type=3D"i" name=3D"width" direction=3D"in"/>
>       <arg type=3D"i" name=3D"height" direction=3D"in"/>
>     </method>
>+    <?endif?>
>=20
>     <!--
>         Disable:
>@@ -532,7 +542,13 @@
>         :dbus:iface:`org=2Eqemu=2EDisplay1=2EAudioOutListener` interface=
=2E
>     -->
>     <method name=3D"RegisterOutListener">
>+      <?if $(env=2ETARGETOS) =3D=3D windows?>
>+      <arg type=3D"ay" name=3D"listener" direction=3D"in">
>+        <annotation name=3D"org=2Egtk=2EGDBus=2EC=2EForceGVariant" value=
=3D"true"/>
>+      </arg>
>+      <?else?>
>       <arg type=3D"h" name=3D"listener" direction=3D"in"/>
>+      <?endif?>
>     </method>
>=20
>     <!--
>@@ -547,7 +563,13 @@
>         :dbus:iface:`org=2Eqemu=2EDisplay1=2EAudioInListener` interface=
=2E
>     -->
>     <method name=3D"RegisterInListener">
>+      <?if $(env=2ETARGETOS) =3D=3D windows?>
>+      <arg type=3D"ay" name=3D"listener" direction=3D"in">
>+        <annotation name=3D"org=2Egtk=2EGDBus=2EC=2EForceGVariant" value=
=3D"true"/>
>+      </arg>
>+      <?else?>
>       <arg type=3D"h" name=3D"listener" direction=3D"in"/>
>+      <?endif?>
>     </method>
>   </interface>
>=20
>@@ -760,7 +782,13 @@
>         The current handler, if any, will be replaced=2E
>     -->
>     <method name=3D"Register">
>+      <?if $(env=2ETARGETOS) =3D=3D windows?>
>+      <arg type=3D"ay" name=3D"listener" direction=3D"in">
>+        <annotation name=3D"org=2Egtk=2EGDBus=2EC=2EForceGVariant" value=
=3D"true"/>
>+      </arg>
>+      <?else?>
>       <arg type=3D"h" name=3D"stream" direction=3D"in"/>
>+      <?endif?>
>     </method>
>=20
>     <!--
>diff --git a/ui/meson=2Ebuild b/ui/meson=2Ebuild
>index a5506ac8ad=2E=2Ed84650676d 100644
>--- a/ui/meson=2Ebuild
>+++ b/ui/meson=2Ebuild
>@@ -74,9 +74,16 @@ endif
>=20
> if dbus_display
>   dbus_ss =3D ss=2Esource_set()
>+  env =3D environment()
>+  env=2Eset('TARGETOS', targetos)
>+  xml =3D custom_target('dbus-display preprocess',
>+                      input: 'dbus-display1=2Exml',
>+                      output: 'dbus-display1=2Exml',
>+                      env: env,
>+                      command: [xml_pp, '@INPUT@', '@OUTPUT@'])
>   dbus_display1 =3D custom_target('dbus-display gdbus-codegen',
>                                 output: ['dbus-display1=2Eh', 'dbus-disp=
lay1=2Ec'],
>-                                input: files('dbus-display1=2Exml'),
>+                                input: xml,
>                                 command: [gdbus_codegen, '@INPUT@',
>                                           '--glib-min-required', '2=2E64=
',
>                                           '--output-directory', meson=2E=
current_build_dir(),

