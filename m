Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 744AB7CD692
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:32:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1vI-0002F4-E4; Wed, 18 Oct 2023 04:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1vA-00022q-MU
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1v8-0003i2-W6
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E9rNqaVK84tFYCTSHv5gjYxAT3A3NUnYvaGZa77NGgM=;
 b=Y8P2PaQl+drDSUc+rwJ8mg9i+QIdxHiDDuPJzqf3ZnikwYbgUybkEFvqI2gEL0PKCR+SDB
 kBAjLnW6buGs6HdYEMU3gyfOXJUgDA2wfbaNxk1zuYnDinosN/IOvkUpD2wkfNKQ5KKjik
 8ONQhMicUQumsxPikPvtOhhAPEFS4z8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-KHEisyLdMzO-ByZJW6UtAw-1; Wed, 18 Oct 2023 04:28:49 -0400
X-MC-Unique: KHEisyLdMzO-ByZJW6UtAw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9b274cc9636so486269266b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617727; x=1698222527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9rNqaVK84tFYCTSHv5gjYxAT3A3NUnYvaGZa77NGgM=;
 b=I0/MXHpFZCd4HcpGcpVtqlMG21+xtDTrxYy4XDENI0xNahuDrccBH47RT6qb3vrNqX
 RBL2+RRJ3MofI9WaZ+PyeJ7XSKuduKtxTVwcYtZw0fWTA4Y/cVVFn8WgDATW0pfgth1X
 egoFsKPGCGm9O7A1sUNrZGHMaBujEgCGh2KDAM7BZ3qZJ5Q80pcQSRy1+wDQpnh4Q71D
 S6RH04Zf95GooBq2YFUCrxscjrAYrxLZtpxxSBQf0fIY+kKTci/3ecPZogbXfsnQ3ZNc
 /eVe580jZ/CfO7R/SmU73nx1RppUnfZkXoil3Q5px2XOUb27pPqhZyWUdxFAxkvjVG9B
 dARw==
X-Gm-Message-State: AOJu0YyaqtnOrzM0zy2oaW5UoTXTkR7sCRhFarIuDZutyBz7y0HtcZ2W
 NVXPwg1z8H8CAXUsw1wCTFQzWybrsCHbCNeobc5X6D33ZsUodFOxI5JeUZouyepSpQ/WyEOP41S
 1AihVyAo4SpZrx6YaHHJKlBf1FvUY0rscoWJszouPr5i6Jm0kd7UGyAopCkbIM9JiG4IRQLjp37
 k=
X-Received: by 2002:a17:907:7d8c:b0:9a1:f81f:d0d5 with SMTP id
 oz12-20020a1709077d8c00b009a1f81fd0d5mr3362408ejc.54.1697617727488; 
 Wed, 18 Oct 2023 01:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMfwxXGsP1mGB/Ewn+1WASfg0h64QYlqOwwNV4RtXOy86kx/YX6TpUod4OoSzLxpkhAi//2g==
X-Received: by 2002:a17:907:7d8c:b0:9a1:f81f:d0d5 with SMTP id
 oz12-20020a1709077d8c00b009a1f81fd0d5mr3362396ejc.54.1697617727128; 
 Wed, 18 Oct 2023 01:28:47 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 n27-20020a1709062bdb00b009829d2e892csm1217660ejg.15.2023.10.18.01.28.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/32] configure,
 meson: use command line options to configure qemu-ga
Date: Wed, 18 Oct 2023 10:27:49 +0200
Message-ID: <20231018082752.322306-30-pbonzini@redhat.com>
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
index 4b24c572d56..8827a29bf4c 100755
--- a/configure
+++ b/configure
@@ -1592,12 +1592,6 @@ echo >> $config_host_mak
 
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
@@ -1724,6 +1718,15 @@ if test "$skip_meson" = no; then
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
@@ -1775,7 +1778,6 @@ if test "$skip_meson" = no; then
 
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


