Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D713897ACE9
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Sep 2024 10:38:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqTiF-0007Ir-Ke; Tue, 17 Sep 2024 04:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sqTiE-0007Ed-AJ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sqTiC-0006DV-HJ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726562248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lW1PonsFY500RWAU7k13QdM3gVsAiiFu/6fGBSj3E7E=;
 b=SKzkw6k9WqBwhGmfetoXvswThts+aZHGKG1reSphR42hDumWZGhVHY/zni6L3eyxzT27nU
 HOSBtMZ4GM/avbdkVWR0YQ73AFLrCioCDMNYLPqr/QWyGDiJeQNTGMfe5XRjx8hSR1R5q9
 ng+nq6aRSzBr5pCF+ffmTY4yT22p4JI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-gFugUfzQNcu9zvRwfN5ENQ-1; Tue,
 17 Sep 2024 04:37:22 -0400
X-MC-Unique: gFugUfzQNcu9zvRwfN5ENQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 006EF19560BF; Tue, 17 Sep 2024 08:37:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.72])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22F0219560A0; Tue, 17 Sep 2024 08:37:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9378518009A5; Tue, 17 Sep 2024 10:37:17 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 4/7] roms: Support compile the efi bios for loongarch
Date: Tue, 17 Sep 2024 10:36:58 +0200
Message-ID: <20240917083709.571436-5-kraxel@redhat.com>
In-Reply-To: <20240917083709.571436-1-kraxel@redhat.com>
References: <20240917083709.571436-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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

From: Xianglai Li <lixianglai@loongson.cn>

Added loongarch UEFI BIOS support to compiled scripts.

  UEFI code images require 16M alignment, flash images require
16M alignment, under the loongarch architecture.This is agreed
upon when the firmware is loaded in QEMU under Loongarch.

  The naming of UEFI under loongarch refers to the x86 and arm naming methods,
and the UEFI image names in x86 and arm are:
edk2-i386-code.fd
edk2-i386-vars.fd
edk2-arm-code.fd
edk2-arm-vars.fd
So on loongarch, we named it:
edk2-loongarch64-code.fd
edk2-loongarch64-vars.fd

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Message-ID: <20240724022245.1317884-1-lixianglai@loongson.cn>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/system/loongarch/virt.rst               |  2 +-
 meson.build                                  |  2 +-
 pc-bios/descriptors/60-edk2-loongarch64.json | 31 ++++++++++++++++++++
 pc-bios/descriptors/meson.build              |  3 +-
 pc-bios/meson.build                          |  2 ++
 roms/edk2-build.config                       | 13 ++++++++
 6 files changed, 50 insertions(+), 3 deletions(-)
 create mode 100644 pc-bios/descriptors/60-edk2-loongarch64.json

diff --git a/docs/system/loongarch/virt.rst b/docs/system/loongarch/virt.rst
index 06d034b8ef28..172fba079e9d 100644
--- a/docs/system/loongarch/virt.rst
+++ b/docs/system/loongarch/virt.rst
@@ -64,7 +64,7 @@ Note: You need get the latest cross-tools at https://github.com/loongson/build-t
 
 (3) Build BIOS:
 
-    See: https://github.com/tianocore/edk2-platforms/tree/master/Platform/Loongson/LoongArchQemuPkg#readme
+    See: https://github.com/tianocore/edk2/tree/master/OvmfPkg/LoongArchVirt#readme
 
 Note: To build the release version of the bios,  set --buildtarget=RELEASE,
       the bios file path:  Build/LoongArchQemu/RELEASE_GCC5/FV/QEMU_EFI.fd
diff --git a/meson.build b/meson.build
index 2d4bf71b24ef..10464466ff39 100644
--- a/meson.build
+++ b/meson.build
@@ -93,7 +93,7 @@ else
   iasl = find_program(get_option('iasl'), required: true)
 endif
 
-edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu', 'riscv64-softmmu' ]
+edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu', 'riscv64-softmmu', 'loongarch64-softmmu' ]
 unpack_edk2_blobs = false
 foreach target : edk2_targets
   if target in target_dirs
diff --git a/pc-bios/descriptors/60-edk2-loongarch64.json b/pc-bios/descriptors/60-edk2-loongarch64.json
new file mode 100644
index 000000000000..f174a1fc9b27
--- /dev/null
+++ b/pc-bios/descriptors/60-edk2-loongarch64.json
@@ -0,0 +1,31 @@
+{
+    "description": "UEFI firmware for loongarch64",
+    "interface-types": [
+        "uefi"
+    ],
+    "mapping": {
+        "device": "flash",
+        "executable": {
+            "filename": "@DATADIR@/edk2-loongarch64-code.fd",
+            "format": "raw"
+        },
+        "nvram-template": {
+            "filename": "@DATADIR@/edk2-loongarch64-vars.fd",
+            "format": "raw"
+        }
+    },
+    "targets": [
+        {
+            "architecture": "loongarch64",
+            "machines": [
+                "virt*"
+            ]
+        }
+    ],
+    "features": [
+
+    ],
+    "tags": [
+
+    ]
+}
diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.build
index 66f85d01c427..afb5a959ccf4 100644
--- a/pc-bios/descriptors/meson.build
+++ b/pc-bios/descriptors/meson.build
@@ -5,7 +5,8 @@ if unpack_edk2_blobs and get_option('install_blobs')
     '60-edk2-aarch64.json',
     '60-edk2-arm.json',
     '60-edk2-i386.json',
-    '60-edk2-x86_64.json'
+    '60-edk2-x86_64.json',
+    '60-edk2-loongarch64.json'
   ]
     configure_file(input: files(f),
                    output: f,
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 8602b45b9b32..090379763e76 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -11,6 +11,8 @@ if unpack_edk2_blobs
     'edk2-i386-vars.fd',
     'edk2-x86_64-code.fd',
     'edk2-x86_64-secure-code.fd',
+    'edk2-loongarch64-code.fd',
+    'edk2-loongarch64-vars.fd',
   ]
 
   foreach f : fds
diff --git a/roms/edk2-build.config b/roms/edk2-build.config
index cc9b21154205..9e45361fb445 100644
--- a/roms/edk2-build.config
+++ b/roms/edk2-build.config
@@ -131,3 +131,16 @@ cpy1 = FV/RISCV_VIRT_CODE.fd  edk2-riscv-code.fd
 cpy2 = FV/RISCV_VIRT_VARS.fd  edk2-riscv-vars.fd
 pad1 = edk2-riscv-code.fd     32m
 pad2 = edk2-riscv-vars.fd     32m
+
+####################################################################################
+# LoongArch64
+
+[build.loongarch64.qemu]
+conf = OvmfPkg/LoongArchVirt/LoongArchVirtQemu.dsc
+arch = LOONGARCH64
+plat = LoongArchVirtQemu
+dest = ../pc-bios
+cpy1 = FV/QEMU_EFI.fd  edk2-loongarch64-code.fd
+pad1 = edk2-loongarch64-code.fd     16m
+cpy2 = FV/QEMU_VARS.fd  edk2-loongarch64-vars.fd
+pad2 = edk2-loongarch64-vars.fd     16m
-- 
2.46.0


