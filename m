Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF927DB876
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 11:49:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxPob-0001VB-8i; Mon, 30 Oct 2023 06:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qxPoY-0001UW-MC
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:48:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qxPoW-0002TT-Hh
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698662887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lrh22jinATdGUu3nKvA40QpvTZC7H9ihNznwulyYSoc=;
 b=GUeAHWSdsTEY5J7XSdLYccGB6QzgmnRhl0UftnJ8DmlgmtBQt6c+EdNso+4kmiqcZbh/6V
 ZY0dExtsstw/js6PMZBtKVPIwgxAAeOGr/Mh1z8LPqknk8m8k9CAs96Ss+2jf9AZzpS4nO
 NomADKKFoI39BYAU4UbzYDtiSOO6RNM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-CjoLDKYqOl-S2fHXUsVxhw-1; Mon, 30 Oct 2023 06:48:05 -0400
X-MC-Unique: CjoLDKYqOl-S2fHXUsVxhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E5EF811E8E;
 Mon, 30 Oct 2023 10:48:05 +0000 (UTC)
Received: from localhost (unknown [10.39.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65F1F1121306;
 Mon, 30 Oct 2023 10:48:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v7 01/23] build-sys: add a "pixman" feature
Date: Mon, 30 Oct 2023 14:47:32 +0400
Message-ID: <20231030104755.124188-2-marcandre.lureau@redhat.com>
In-Reply-To: <20231030104755.124188-1-marcandre.lureau@redhat.com>
References: <20231030104755.124188-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

For now, pixman is mandatory, but we set config_host.h and Kconfig.
Once compilation is fixed, "pixman" will become actually optional.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 meson.build                   | 10 ++++++++--
 include/ui/qemu-pixman.h      |  2 ++
 Kconfig.host                  |  3 +++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 5 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index dcef8b1e79..2d67cbf6d6 100644
--- a/meson.build
+++ b/meson.build
@@ -813,10 +813,14 @@ if 'ust' in get_option('trace_backends')
                      method: 'pkg-config')
 endif
 pixman = not_found
-if have_system or have_tools
-  pixman = dependency('pixman-1', required: have_system, version:'>=0.21.8',
+if not get_option('pixman').auto() or have_system or have_tools
+  pixman = dependency('pixman-1', required: get_option('pixman'), version:'>=0.21.8',
                       method: 'pkg-config')
 endif
+if not pixman.found() and (have_system or have_tools)
+  error('FIXME: pixman is currently required')
+endif
+
 zlib = dependency('zlib', required: true)
 
 libaio = not_found
@@ -2125,6 +2129,7 @@ config_host_data.set('CONFIG_SECCOMP', seccomp.found())
 if seccomp.found()
   config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
 endif
+config_host_data.set('CONFIG_PIXMAN', pixman.found())
 config_host_data.set('CONFIG_SNAPPY', snappy.found())
 config_host_data.set('CONFIG_SOLARIS', targetos == 'sunos')
 if get_option('tcg').allowed()
@@ -2844,6 +2849,7 @@ have_ivshmem = config_host_data.get('CONFIG_EVENTFD')
 host_kconfig = \
   (get_option('fuzzing') ? ['CONFIG_FUZZ=y'] : []) + \
   (have_tpm ? ['CONFIG_TPM=y'] : []) + \
+  (pixman.found() ? ['CONFIG_PIXMAN=y'] : []) + \
   (spice.found() ? ['CONFIG_SPICE=y'] : []) + \
   (have_ivshmem ? ['CONFIG_IVSHMEM=y'] : []) + \
   (opengl.found() ? ['CONFIG_OPENGL=y'] : []) + \
diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index e587c48b1f..d37feb5e3c 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -6,11 +6,13 @@
 #ifndef QEMU_PIXMAN_H
 #define QEMU_PIXMAN_H
 
+#ifdef CONFIG_PIXMAN
 /* pixman-0.16.0 headers have a redundant declaration */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wredundant-decls"
 #include <pixman.h>
 #pragma GCC diagnostic pop
+#endif
 
 /*
  * pixman image formats are defined to be native endian,
diff --git a/Kconfig.host b/Kconfig.host
index d763d89269..b6ac2b9316 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -11,6 +11,9 @@ config OPENGL
 config X11
     bool
 
+config PIXMAN
+    bool
+
 config SPICE
     bool
 
diff --git a/meson_options.txt b/meson_options.txt
index 3c7398f3c6..de0e616e76 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -224,6 +224,8 @@ option('l2tpv3', type : 'feature', value : 'auto',
        description: 'l2tpv3 network backend support')
 option('netmap', type : 'feature', value : 'auto',
        description: 'netmap network backend support')
+option('pixman', type : 'feature', value : 'auto',
+       description: 'pixman support')
 option('slirp', type: 'feature', value: 'auto',
        description: 'libslirp user mode network backend support')
 option('vde', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 7ca4b77eae..8a75796c04 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -159,6 +159,7 @@ meson_options_help() {
   printf "%s\n" '  pa              PulseAudio sound support'
   printf "%s\n" '  parallels       parallels image format support'
   printf "%s\n" '  pipewire        PipeWire sound support'
+  printf "%s\n" '  pixman          pixman support'
   printf "%s\n" '  plugins         TCG plugins via shared library loading'
   printf "%s\n" '  png             PNG support with libpng'
   printf "%s\n" '  pvrdma          Enable PVRDMA support'
@@ -416,6 +417,8 @@ _meson_option_parse() {
     --disable-parallels) printf "%s" -Dparallels=disabled ;;
     --enable-pipewire) printf "%s" -Dpipewire=enabled ;;
     --disable-pipewire) printf "%s" -Dpipewire=disabled ;;
+    --enable-pixman) printf "%s" -Dpixman=enabled ;;
+    --disable-pixman) printf "%s" -Dpixman=disabled ;;
     --with-pkgversion=*) quote_sh "-Dpkgversion=$2" ;;
     --enable-plugins) printf "%s" -Dplugins=true ;;
     --disable-plugins) printf "%s" -Dplugins=false ;;
-- 
2.41.0


