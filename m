Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6899ADF14
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Oct 2024 10:29:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3tCD-0004Ao-8r; Thu, 24 Oct 2024 04:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3tCB-0004AR-Pk
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 04:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3tC9-0000Qa-Nq
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 04:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729758468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71W1wQvMaq0mtQydn1x7oNoKnWVQ1tkNjmubWnaxj30=;
 b=LrASLC0FO94JsFQhW4nD5N7JR2Gl0Nr5QYhyQkzCZGe+H2VIvxRp9tCmdYz5ajzVLTgcdo
 +ovoEQvLTywAe+wd2jb/2zZVNzSfNFMcpe+tBKmO5TSw+aM3K5DX9E024t07kY8FnclV7H
 zL++FxPgpDqTIZaoyAaOlVZjBNfYwcg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-mdLnwLiOPPyjHv60EROdag-1; Thu,
 24 Oct 2024 04:27:44 -0400
X-MC-Unique: mdLnwLiOPPyjHv60EROdag-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 243FC1956057; Thu, 24 Oct 2024 08:27:42 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-239.str.redhat.com
 [10.33.192.239])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40ECD1956088; Thu, 24 Oct 2024 08:27:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Rob Landley <rob@landley.net>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 1/2] Revert "Remove the unused sh4eb target"
Date: Thu, 24 Oct 2024 10:27:34 +0200
Message-ID: <20241024082735.42324-2-thuth@redhat.com>
In-Reply-To: <20241024082735.42324-1-thuth@redhat.com>
References: <20241024082735.42324-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This reverts commit 73ceb12960e686b763415f0880cc5171ccce01cf.

The "r2d" machine can work in big endian mode, see:

 https://lore.kernel.org/qemu-devel/d6755445-1060-48a8-82b6-2f392c21f9b9@landley.net/

So the reasoning for removing sh4eb was wrong.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configs/devices/sh4eb-softmmu/default.mak | 3 +++
 configs/targets/sh4eb-softmmu.mak         | 2 ++
 qapi/machine.json                         | 2 +-
 tests/qtest/endianness-test.c             | 1 +
 tests/qtest/machine-none-test.c           | 1 +
 .gitlab-ci.d/buildtest.yml                | 2 +-
 .gitlab-ci.d/cirrus.yml                   | 2 +-
 .gitlab-ci.d/crossbuilds.yml              | 2 +-
 .travis.yml                               | 2 +-
 tests/qemu-iotests/testenv.py             | 1 +
 tests/qtest/meson.build                   | 1 +
 11 files changed, 14 insertions(+), 5 deletions(-)
 create mode 100644 configs/devices/sh4eb-softmmu/default.mak
 create mode 100644 configs/targets/sh4eb-softmmu.mak

diff --git a/configs/devices/sh4eb-softmmu/default.mak b/configs/devices/sh4eb-softmmu/default.mak
new file mode 100644
index 0000000000..f18d1f6519
--- /dev/null
+++ b/configs/devices/sh4eb-softmmu/default.mak
@@ -0,0 +1,3 @@
+# Default configuration for sh4eb-softmmu
+
+include ../sh4-softmmu/default.mak
diff --git a/configs/targets/sh4eb-softmmu.mak b/configs/targets/sh4eb-softmmu.mak
new file mode 100644
index 0000000000..226b1fc698
--- /dev/null
+++ b/configs/targets/sh4eb-softmmu.mak
@@ -0,0 +1,2 @@
+TARGET_ARCH=sh4
+TARGET_BIG_ENDIAN=y
diff --git a/qapi/machine.json b/qapi/machine.json
index 3cc055b6ff..a6b8795b09 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -37,7 +37,7 @@
              'loongarch64', 'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
-             'sparc', 'sparc64', 'tricore',
+             'sh4eb', 'sparc', 'sparc64', 'tricore',
              'x86_64', 'xtensa', 'xtensaeb' ] }
 
 ##
diff --git a/tests/qtest/endianness-test.c b/tests/qtest/endianness-test.c
index f4872b0283..222d116fae 100644
--- a/tests/qtest/endianness-test.c
+++ b/tests/qtest/endianness-test.c
@@ -41,6 +41,7 @@ static const TestCase test_cases[] = {
     { "ppc64", "pseries-2.7", 0x10080000000ULL,
       .bswap = true, .superio = "i82378" },
     { "sh4", "r2d", 0xfe240000, .superio = "i82378" },
+    { "sh4eb", "r2d", 0xfe240000, .bswap = true, .superio = "i82378" },
     { "sparc64", "sun4u", 0x1fe02000000LL, .bswap = true },
     { "x86_64", "pc", -1 },
     {}
diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 9cf95bea1e..159b2a705a 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -42,6 +42,7 @@ static struct arch2cpu cpus_map[] = {
     { "ppc64", "power8e_v2.1" },
     { "s390x", "qemu" },
     { "sh4", "sh7750r" },
+    { "sh4eb", "sh7751r" },
     { "sparc", "LEON2" },
     { "sparc64", "Fujitsu Sparc64" },
     { "tricore", "tc1796" },
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 01e8470a69..b847196c3e 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -72,7 +72,7 @@ build-system-debian:
   variables:
     IMAGE: debian
     CONFIGURE_ARGS: --with-coroutine=sigaltstack
-    TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4-softmmu
+    TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4eb-softmmu
       sparc-softmmu xtensa-softmmu
     MAKE_CHECK_ARGS: check-build
 
diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 6a7bafac7b..9427302383 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -57,7 +57,7 @@ x64-freebsd-14-build:
     CIRRUS_VM_RAM: 8G
     UPDATE_COMMAND: pkg update; pkg upgrade -y
     INSTALL_COMMAND: pkg install -y
-    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblaze-softmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,xtensa-softmmu
+    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblaze-softmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-softmmu
     TEST_TARGETS: check
 
 aarch64-macos-build:
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 178f62869d..95dfc39224 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -176,7 +176,7 @@ cross-win64-system:
     EXTRA_CONFIGURE_OPTS: --enable-fdt=internal --disable-plugins
     CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu
                         m68k-softmmu microblazeel-softmmu
-                        or1k-softmmu rx-softmmu sh4-softmmu sparc64-softmmu
+                        or1k-softmmu rx-softmmu sh4eb-softmmu sparc64-softmmu
                         tricore-softmmu xtensaeb-softmmu
   artifacts:
     when: on_success
diff --git a/.travis.yml b/.travis.yml
index ad81bc5e1b..8fc1ae0cf2 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -223,7 +223,7 @@ jobs:
           - genisoimage
       env:
         - CONFIG="--disable-containers --audio-drv-list=sdl --disable-user
-            --target-list=arm-softmmu,avr-softmmu,microblaze-softmmu,sh4-softmmu,sparc64-softmmu,xtensaeb-softmmu"
+            --target-list=arm-softmmu,avr-softmmu,microblaze-softmmu,sh4eb-softmmu,sparc64-softmmu,xtensaeb-softmmu"
 
     - name: "[s390x] GCC (user)"
       arch: s390x
diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index 8cd620c202..6326e46b7b 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -245,6 +245,7 @@ def __init__(self, source_dir: str, build_dir: str,
             ('riscv64', 'virt'),
             ('rx', 'gdbsim-r5f562n8'),
             ('sh4', 'r2d'),
+            ('sh4eb', 'r2d'),
             ('tricore', 'tricore_testboard')
         )
         for suffix, machine in machine_map:
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index e8be8b3942..5c131754eb 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -186,6 +186,7 @@ qtests_ppc64 = \
   qtests_pci + ['migration-test', 'cpu-plug-test', 'drive_del-test']
 
 qtests_sh4 = (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : [])
+qtests_sh4eb = (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : [])
 
 qtests_sparc = ['prom-env-test', 'm48t59-test', 'boot-serial-test'] + \
   qtests_filter
-- 
2.47.0


