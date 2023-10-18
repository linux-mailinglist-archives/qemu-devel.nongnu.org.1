Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6BC7CD6B2
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:35:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1us-0001j0-Sn; Wed, 18 Oct 2023 04:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uq-0001hz-Oz
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uo-0003fK-Nu
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ci9nsDPUBmPgirpk9Ch50MqJqivmpk1eKdp5QoVu9I4=;
 b=TkfDfca0C8OivJABF4TLCHtwJQfOt6ELvANRqCildSg204j+6at4wIdhcbrilpxBm/RNjU
 EOLsZWwTRoY5P3lU34QrwCa5no8efWdmhfNc23L2eD4aOMRjAqbxsk6jzVWEg0j9U0pKN8
 uNL6Sfp0WGDcO0h8mP6E5I/ymXAkdig=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-iwJA5iYdPpqQrTSRwFACLg-1; Wed, 18 Oct 2023 04:28:28 -0400
X-MC-Unique: iwJA5iYdPpqQrTSRwFACLg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9c15543088aso375996166b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617707; x=1698222507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ci9nsDPUBmPgirpk9Ch50MqJqivmpk1eKdp5QoVu9I4=;
 b=QqkolZL5A7uxhxOQSoRiYlD4CnS3uhgeeySC3CgEI5oEihd0/kQ2TLaVmbK6lk1wYN
 N8w/JbQ1KftDE/u7cg99gx7kJc1/0fhvPmPkKBG7crfr1BUIC/9gpgzGIsyh+Drwl5pH
 rXrRKaCPbnVyXj+jq8+hCPiGNeKfhFm6b92rEQOo4+vHNJ66SdGWml1UHTSQWXj1ou72
 jVodTuotRZ+atFSRrilVbA6m1HXKLIMgzYF0nUMF9jIWPEE9mqDklXAd9dUMu9ZSMScm
 jICsl9Zy8X6TXMc/qr+VhoU0ZDYuaZwzWoieluwPpH+ERrwkH/FdMDFMwVS2juFeDlZS
 Xf8g==
X-Gm-Message-State: AOJu0YyFagQcjD9FkTFdFrUmYqiTNWc3e0VJCYV0dEM3CgknJV1OUEHT
 RuByOq/LEZB+sKPaLVlRoiXb7JwKAqA4+61fLz7efJ2t0tmVZp14Ly5iFr0CK3SrYFgCxhXMeIO
 Jr2d0jRzJYMYXbeg60f1lURgjLzkm7k/MOhy4lCB7UBHv3RSJ7PckgMqs31QWWx6PEWVByciGCa
 I=
X-Received: by 2002:a17:907:9724:b0:9ae:5513:e475 with SMTP id
 jg36-20020a170907972400b009ae5513e475mr4443260ejc.9.1697617706923; 
 Wed, 18 Oct 2023 01:28:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT+FzaNfapp9aQuNESx8flvtpjYVEFaoGZqGNzYS7X+2RcFpwDi5WBSmXjPdi3Rx2Ae6PmMg==
X-Received: by 2002:a17:907:9724:b0:9ae:5513:e475 with SMTP id
 jg36-20020a170907972400b009ae5513e475mr4443241ejc.9.1697617706588; 
 Wed, 18 Oct 2023 01:28:26 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 mc8-20020a170906eb4800b009737b8d47b6sm1138613ejb.203.2023.10.18.01.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 17/32] meson, cutils: allow non-relocatable installs
Date: Wed, 18 Oct 2023 10:27:37 +0200
Message-ID: <20231018082752.322306-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Say QEMU is configured with bindir = "/usr/bin" and a firmware path
that starts with "/usr/share/qemu".  Ever since QEMU 5.2, QEMU's
install has been relocatable: if you move qemu-system-x86_64 from
/usr/bin to /home/username/bin, it will start looking for firmware in
/home/username/share/qemu.  Previously, you would get a non-relocatable
install where the moved QEMU will keep looking for firmware in
/usr/share/qemu.

Windows almost always wants relocatable installs, and in fact that
is why QEMU 5.2 introduced relocatability in the first place.
However, newfangled distribution mechanisms such as AppImage
(https://docs.appimage.org/reference/best-practices.html), and
possibly NixOS, also dislike using at runtime the absolute paths
that were established at build time.

On POSIX systems you almost never care; if you do, your usecase
dictates which one is desirable, so there's no single answer.
Obviously relocatability works fine most of the time, because not many
people have complained about QEMU's switch to relocatable install,
and that's why until now there was no way to disable relocatability.

But a non-relocatable, non-modular binary can help if you want to do
experiments with old firmware and new QEMU or vice versa (because you
can just upgrade/downgrade the firmware package, and use rpm2cpio or
similar to extract the QEMU binaries outside /usr), so allow both.
This patch allows one to build a non-relocatable install using a new
option to configure.  Why?  Because it's not too hard, and because
it helps the user double check the relocatability of their install.

Note that the same code that handles relocation also lets you run QEMU
from the build tree and pick e.g. firmware files from the source tree
transparently.  Therefore that part remains active with this patch,
even if you configure with --disable-relocatable.

Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 20 ++++++++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 util/cutils.c                 | 11 ++++++++---
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 010d2c649c2..1be9f92f7da 100644
--- a/meson.build
+++ b/meson.build
@@ -2111,6 +2111,7 @@ config_host_data.set('CONFIG_OPENGL', opengl.found())
 config_host_data.set('CONFIG_PLUGIN', get_option('plugins'))
 config_host_data.set('CONFIG_RBD', rbd.found())
 config_host_data.set('CONFIG_RDMA', rdma.found())
+config_host_data.set('CONFIG_RELOCATABLE', get_option('relocatable'))
 config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
@@ -4054,6 +4055,7 @@ if 'simple' in get_option('trace_backends')
 endif
 summary_info += {'D-Bus display':     dbus_display}
 summary_info += {'QOM debugging':     get_option('qom_cast_debug')}
+summary_info += {'Relocatable install': get_option('relocatable')}
 summary_info += {'vhost-kernel support': have_vhost_kernel}
 summary_info += {'vhost-net support': have_vhost_net}
 summary_info += {'vhost-user support': have_vhost_user}
@@ -4356,3 +4358,21 @@ if host_arch == 'unknown' or not supported_oses.contains(targetos)
   message('If you want to help supporting QEMU on this platform, please')
   message('contact the developers at qemu-devel@nongnu.org.')
 endif
+
+actually_reloc = get_option('relocatable')
+# check if get_relocated_path() is actually able to relocate paths
+if get_option('relocatable') and \
+  not (get_option('prefix') / get_option('bindir')).startswith(get_option('prefix') / '')
+  message()
+  warning('bindir not included within prefix, the installation will not be relocatable.')
+  actually_reloc = false
+endif
+if not actually_reloc and (targetos == 'windows' or get_option('relocatable'))
+  if targetos == 'windows'
+    message()
+    warning('Windows installs should usually be relocatable.')
+  endif
+  message()
+  message('QEMU will have to be installed under ' + get_option('prefix') + '.')
+  message('Use --disable-relocatable to remove this warning.')
+endif
diff --git a/meson_options.txt b/meson_options.txt
index 6a17b909680..e237b268469 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -101,6 +101,8 @@ option('cfi_debug', type: 'boolean', value: false,
        description: 'Verbose errors in case of CFI violation')
 option('multiprocess', type: 'feature', value: 'auto',
        description: 'Out of process device emulation support')
+option('relocatable', type : 'boolean', value : 'true',
+       description: 'toggle relocatable install')
 option('vfio_user_server', type: 'feature', value: 'disabled',
        description: 'vfio-user server support')
 option('dbus_display', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 2a74b0275b3..d4b89e6b443 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -17,6 +17,7 @@ meson_options_help() {
   printf "%s\n" '                           code for the Hexagon frontend'
   printf "%s\n" '  --disable-install-blobs  install provided firmware blobs'
   printf "%s\n" '  --disable-qom-cast-debug cast debugging support'
+  printf "%s\n" '  --disable-relocatable    toggle relocatable install'
   printf "%s\n" '  --docdir=VALUE           Base directory for documentation installation'
   printf "%s\n" '                           (can be empty) [share/doc]'
   printf "%s\n" '  --enable-block-drv-whitelist-in-tools'
@@ -421,6 +422,8 @@ _meson_option_parse() {
     --disable-rbd) printf "%s" -Drbd=disabled ;;
     --enable-rdma) printf "%s" -Drdma=enabled ;;
     --disable-rdma) printf "%s" -Drdma=disabled ;;
+    --enable-relocatable) printf "%s" -Drelocatable=true ;;
+    --disable-relocatable) printf "%s" -Drelocatable=false ;;
     --enable-replication) printf "%s" -Dreplication=enabled ;;
     --disable-replication) printf "%s" -Dreplication=disabled ;;
     --enable-rng-none) printf "%s" -Drng_none=true ;;
diff --git a/util/cutils.c b/util/cutils.c
index c99d26c5e2d..64f817b477b 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1178,9 +1178,11 @@ char *get_relocated_path(const char *dir)
 #else
         g_string_append(result, dir);
 #endif
-    } else if (!starts_with_prefix(dir) || !starts_with_prefix(bindir)) {
-        g_string_assign(result, dir);
-    } else {
+        goto out;
+    }
+
+    if (IS_ENABLED(CONFIG_RELOCATABLE) &&
+        starts_with_prefix(dir) && starts_with_prefix(bindir)) {
         g_string_assign(result, exec_dir);
 
         /* Advance over common components.  */
@@ -1203,7 +1205,10 @@ char *get_relocated_path(const char *dir)
             assert(G_IS_DIR_SEPARATOR(dir[-1]));
             g_string_append(result, dir - 1);
         }
+        goto out;
     }
 
+    g_string_assign(result, dir);
+out:
     return g_string_free(result, false);
 }
-- 
2.41.0


