Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FE87A4ADD
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:53:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEgD-0005iM-Jg; Mon, 18 Sep 2023 09:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qiEg9-0005hZ-PA
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qiEfm-0000RE-RK
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695045139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jCrA3e8yuydcAyBZPCyz9ojYbjub4NprIdCYgs0ND7c=;
 b=Ef9e57mex+JFfW+L4uYkFjzTSB1HaEsU9OlOhD6Q1Od5wlEmVxzVcREwj2q9ZbwvxeSMxQ
 VfC0LqtATwNBshNHNhBX25Bt6Lzqxk9X/xhl2h7S2O9JQIKoS0j0nyRuEmlZus+jNEqiFg
 FMmrHAbAoEpmiKDhp5D/KGkIQFZKZA0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-P8a-QoH1OYetel3qGCoNhQ-1; Mon, 18 Sep 2023 09:52:15 -0400
X-MC-Unique: P8a-QoH1OYetel3qGCoNhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68508801779;
 Mon, 18 Sep 2023 13:52:14 +0000 (UTC)
Received: from localhost (unknown [10.39.208.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BE4D20268CB;
 Mon, 18 Sep 2023 13:52:12 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 01/18] build-sys: add a "pixman" feature
Date: Mon, 18 Sep 2023 17:51:48 +0400
Message-ID: <20230918135206.2739222-2-marcandre.lureau@redhat.com>
In-Reply-To: <20230918135206.2739222-1-marcandre.lureau@redhat.com>
References: <20230918135206.2739222-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 meson.build                   | 10 ++++++++--
 include/ui/qemu-pixman.h      |  2 ++
 Kconfig.host                  |  3 +++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 5 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 5150a74831..e870b039cc 100644
--- a/meson.build
+++ b/meson.build
@@ -828,10 +828,14 @@ if 'ust' in get_option('trace_backends')
                      method: 'pkg-config')
 endif
 pixman = not_found
-if have_system or have_tools
-  pixman = dependency('pixman-1', required: have_system, version:'>=0.21.8',
+if not get_option('pixman').auto() or have_system or have_tools
+  pixman = dependency('pixman-1', required: get_option('pixman'), version:'>=0.21.8',
                       method: 'pkg-config')
 endif
+if not pixman.found()
+  error('FIXME: pixman is currently required')
+endif
+
 zlib = dependency('zlib', required: true)
 
 libaio = not_found
@@ -2124,6 +2128,7 @@ config_host_data.set('CONFIG_SECCOMP', seccomp.found())
 if seccomp.found()
   config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
 endif
+config_host_data.set('CONFIG_PIXMAN', pixman.found())
 config_host_data.set('CONFIG_SNAPPY', snappy.found())
 config_host_data.set('CONFIG_SOLARIS', targetos == 'sunos')
 if get_option('tcg').allowed()
@@ -2843,6 +2848,7 @@ have_ivshmem = config_host_data.get('CONFIG_EVENTFD')
 host_kconfig = \
   (get_option('fuzzing') ? ['CONFIG_FUZZ=y'] : []) + \
   (have_tpm ? ['CONFIG_TPM=y'] : []) + \
+  (pixman.found() ? ['CONFIG_PIXMAN=y'] : []) + \
   (spice.found() ? ['CONFIG_SPICE=y'] : []) + \
   (have_ivshmem ? ['CONFIG_IVSHMEM=y'] : []) + \
   (opengl.found() ? ['CONFIG_OPENGL=y'] : []) + \
diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 51f8709327..b3379f6625 100644
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
index f82d88b7c6..1aaec02d68 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -218,6 +218,8 @@ option('l2tpv3', type : 'feature', value : 'auto',
        description: 'l2tpv3 network backend support')
 option('netmap', type : 'feature', value : 'auto',
        description: 'netmap network backend support')
+option('pixman', type : 'feature', value : 'auto',
+       description: 'pixman support')
 option('slirp', type: 'feature', value: 'auto',
        description: 'libslirp user mode network backend support')
 option('vde', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index e1d178370c..d016caf819 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -147,6 +147,7 @@ meson_options_help() {
   printf "%s\n" '  pa              PulseAudio sound support'
   printf "%s\n" '  parallels       parallels image format support'
   printf "%s\n" '  pipewire        PipeWire sound support'
+  printf "%s\n" '  pixman          pixman support'
   printf "%s\n" '  png             PNG support with libpng'
   printf "%s\n" '  pvrdma          Enable PVRDMA support'
   printf "%s\n" '  qcow1           qcow1 image format support'
@@ -398,6 +399,8 @@ _meson_option_parse() {
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


