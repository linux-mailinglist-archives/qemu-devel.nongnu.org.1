Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0AA7C9F97
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH9B-00042t-3j; Mon, 16 Oct 2023 02:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH94-00042a-0c
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH92-0005U7-8z
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwRXtVjXRc2oO6G7Ta8j3S56M6ZsrgKAu3P/PDdZ/0w=;
 b=Lr94U+o04qeI9TN4hl7C3/+5/v4127xcuLlWibTHWwDxjO/vDbxQajXQF/ij7WLHBuCgPL
 s1Ts5tvvDrW1frXLp2Rb0ejcNOKWGLd+ZcSkb6s+ubeFABXUEyeL9Ua/Ni3WqjBIUBrw97
 eazRreD5Rm8DgekrKQR7UgHhR+mqSsM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-vrOimNY7O-OzzBnNjQq9UQ-1; Mon, 16 Oct 2023 02:32:01 -0400
X-MC-Unique: vrOimNY7O-OzzBnNjQq9UQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-53e119e615aso4262580a12.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437919; x=1698042719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwRXtVjXRc2oO6G7Ta8j3S56M6ZsrgKAu3P/PDdZ/0w=;
 b=OEmHAyXCTw0aozdbWavnst0HjW/1F1dXyu13GCw6zu03n6a7JTxfiKd5ZokGLaozlz
 SmBodVWZToDibN2YOvgRioDJUy7wZCbjHDjTQoeX9wAjm71LK4RMhyzM9gphGSCJZVA8
 HIeLv9qCbF4TydzLQNUNMGklHX3O2LlnQ6gslrli188GWEyFd7ehEYzxu+DnAjRCfrM/
 Q/7xfMWIlELJke8TcVFlP8tFTDtDXdCwnQooFXDDy8JB7SA/O2Mn+m/4jDFFIxA5lTLn
 bnuS7mBK0eI6+2b7ahndw4/NJ3CCqqRJCnN+cFtmtK0ToA0e1jkxbcKvv0q8+2O85wAT
 UfRQ==
X-Gm-Message-State: AOJu0YwTE+Q/gcaTL8SDbdKziKt1HAnlCZLOn/Hx8hcxPdbj+lQYOAnW
 uTYxh7aiZJFjtyFE6JIIOQvgIvRwIfiXPBFICBnhcxjJ4Tw4tTiCiRRvbLwux1e+nH3epWpg80h
 ac/iNzghU7rCJfyx8jj1DApaNLxMysgrwVcmFlUhNE2zF05gBZo3vDR6O/tGTanSuOy2+Jp0XxK
 M=
X-Received: by 2002:a05:6402:35d4:b0:523:2e23:a0bf with SMTP id
 z20-20020a05640235d400b005232e23a0bfmr5668106edc.11.1697437919595; 
 Sun, 15 Oct 2023 23:31:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH/bHATqgK2GYIe6lhDDd9ce3KvthpjNRoynTWgRZffQfIvDqriC66Cd2+6ogp4Zi8K8PuZg==
X-Received: by 2002:a05:6402:35d4:b0:523:2e23:a0bf with SMTP id
 z20-20020a05640235d400b005232e23a0bfmr5668092edc.11.1697437919261; 
 Sun, 15 Oct 2023 23:31:59 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 co25-20020a0564020c1900b0053e36dd75dfsm4540722edb.35.2023.10.15.23.31.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/17] configure,
 meson: use command line options to configure qemu-ga
Date: Mon, 16 Oct 2023 08:31:25 +0200
Message-ID: <20231016063127.161204-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
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

Preserve the functionality of the environment variables, but
allow using the command line instead.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                     | 16 +++++++++-------
 meson_options.txt             |  7 +++++++
 qga/meson.build               |  9 ++++++---
 scripts/meson-buildoptions.sh |  9 +++++++++
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 18dcb0240ed..06b27dd46f4 100755
--- a/configure
+++ b/configure
@@ -1589,12 +1589,6 @@ echo >> $config_host_mak
 
 echo all: >> $config_host_mak
 
-if test "$targetos" = "windows"; then
-  echo "QEMU_GA_MANUFACTURER=${QEMU_GA_MANUFACTURER-QEMU}" >> $config_host_mak
-  echo "QEMU_GA_DISTRO=${QEMU_GA_DISTRO-Linux}" >> $config_host_mak
-  echo "QEMU_GA_VERSION=${QEMU_GA_VERSION-$(cat "$source_path"/VERSION)}" >> $config_host_mak
-fi
-
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
 echo "GDB=$gdb_bin" >> $config_host_mak
@@ -1721,6 +1715,15 @@ if test "$skip_meson" = no; then
   if test "$SMBD" != ''; then
     echo "smbd = $(meson_quote "$SMBD")" >> $cross
   fi
+  if test "${QEMU_GA_MANUFACTURER}" != ''; then
+    echo "qemu_ga_manufacturer = $(meson_quote "${QEMU_GA_MANUFACTURER}")" >> $cross
+  fi
+  if test "${QEMU_GA_DISTRO}" != ''; then
+    echo "qemu_ga_distro = $(meson_quote "${QEMU_GA_DISTRO}")" >> $cross
+  fi
+  if test "${QEMU_GA_VERSION}" != ''; then
+    echo "qemu_ga_version = $(meson_quote "${QEMU_GA_VERSION}")" >> $cross
+  fi
 
   echo >> $cross
   echo "[binaries]" >> $cross
@@ -1772,7 +1775,6 @@ if test "$skip_meson" = no; then
 
   rm -rf meson-private meson-info meson-logs
 
-  # Built-in options
   test "$download" = "disabled" && meson_option_add "--wrap-mode=nodownload"
   test "$default_feature" = no && meson_option_add -Dauto_features=disabled
   test "$static" = yes && meson_option_add -Dprefer_static=true
diff --git a/meson_options.txt b/meson_options.txt
index e237b268469..1b0c02b4a58 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -353,5 +353,12 @@ option('qom_cast_debug', type: 'boolean', value: true,
 option('slirp_smbd', type : 'feature', value : 'auto',
        description: 'use smbd (at path --smbd=*) in slirp networking')
 
+option('qemu_ga_manufacturer', type: 'string', value: 'QEMU',
+       description: '"manufacturer" name for qemu-ga registry entries')
+option('qemu_ga_distro', type: 'string', value: 'Linux',
+       description: 'second path element in qemu-ga registry entries')
+option('qemu_ga_version', type: 'string', value: '',
+       description: 'version number for qemu-ga installer')
+
 option('hexagon_idef_parser', type : 'boolean', value : true,
        description: 'use idef-parser to automatically generate TCG code for the Hexagon frontend')
diff --git a/qga/meson.build b/qga/meson.build
index 59cae0cc6ee..940a51d55db 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -145,6 +145,9 @@ if targetos == 'windows'
     else
       libpcre = 'libpcre2'
     endif
+    qga_msi_version = get_option('qemu_ga_version') == '' \
+      ? project.version() \
+      : get_option('qemu_ga_version')
     qga_msi = custom_target('QGA MSI',
                             input: files('installer/qemu-ga.wxs'),
                             output: 'qemu-ga-@0@.msi'.format(host_arch),
@@ -155,9 +158,9 @@ if targetos == 'windows'
                               qemu_ga_msi_vss,
                               '-D', 'BUILD_DIR=' + meson.project_build_root(),
                               '-D', 'BIN_DIR=' + glib_pc.get_variable('bindir'),
-                              '-D', 'QEMU_GA_VERSION=' + config_host['QEMU_GA_VERSION'],
-                              '-D', 'QEMU_GA_MANUFACTURER=' + config_host['QEMU_GA_MANUFACTURER'],
-                              '-D', 'QEMU_GA_DISTRO=' + config_host['QEMU_GA_DISTRO'],
+                              '-D', 'QEMU_GA_VERSION=' + qga_msi_version,
+                              '-D', 'QEMU_GA_MANUFACTURER=' + get_option('qemu_ga_manufacturer'),
+                              '-D', 'QEMU_GA_DISTRO=' + get_option('qemu_ga_distro'),
                               '-D', 'LIBPCRE=' + libpcre,
                             ])
     all_qga += [qga_msi]
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index dec33820163..bda88993bd1 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -64,6 +64,12 @@ meson_options_help() {
   printf "%s\n" '  --localstatedir=VALUE    Localstate data directory [/var/local]'
   printf "%s\n" '  --mandir=VALUE           Manual page directory [share/man]'
   printf "%s\n" '  --prefix=VALUE           Installation prefix [/usr/local]'
+  printf "%s\n" '  --qemu-ga-distro=VALUE   second path element in qemu-ga registry entries'
+  printf "%s\n" '                           [Linux]'
+  printf "%s\n" '  --qemu-ga-manufacturer=VALUE'
+  printf "%s\n" '                           "manufacturer" name for qemu-ga registry entries'
+  printf "%s\n" '                           [QEMU]'
+  printf "%s\n" '  --qemu-ga-version=VALUE  version number for qemu-ga installer'
   printf "%s\n" '  --smbd=VALUE             Path to smbd for slirp networking'
   printf "%s\n" '  --sysconfdir=VALUE       Sysconf data directory [etc]'
   printf "%s\n" '  --tls-priority=VALUE     Default TLS protocol/cipher priority string'
@@ -422,6 +428,9 @@ _meson_option_parse() {
     --enable-qed) printf "%s" -Dqed=enabled ;;
     --disable-qed) printf "%s" -Dqed=disabled ;;
     --firmwarepath=*) quote_sh "-Dqemu_firmwarepath=$(meson_option_build_array $2)" ;;
+    --qemu-ga-distro=*) quote_sh "-Dqemu_ga_distro=$2" ;;
+    --qemu-ga-manufacturer=*) quote_sh "-Dqemu_ga_manufacturer=$2" ;;
+    --qemu-ga-version=*) quote_sh "-Dqemu_ga_version=$2" ;;
     --with-suffix=*) quote_sh "-Dqemu_suffix=$2" ;;
     --enable-qga-vss) printf "%s" -Dqga_vss=enabled ;;
     --disable-qga-vss) printf "%s" -Dqga_vss=disabled ;;
-- 
2.41.0


