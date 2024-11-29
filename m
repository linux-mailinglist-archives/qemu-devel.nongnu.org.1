Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E179D1FF4
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Nov 2024 07:07:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDHM2-00019J-12; Tue, 19 Nov 2024 01:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tDHLx-00016i-Ke; Tue, 19 Nov 2024 01:04:45 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tDHLv-0004fO-HR; Tue, 19 Nov 2024 01:04:45 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 063B5A6268;
 Tue, 19 Nov 2024 09:04:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2D4391738DD;
 Tue, 19 Nov 2024 09:04:19 +0300 (MSK)
Received: (nullmailer pid 2368948 invoked by uid 1000);
 Tue, 19 Nov 2024 06:04:18 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 65/72] linux-user/arm: Select vdso for be8 and be32
 modes
Date: Tue, 19 Nov 2024 09:04:06 +0300
Message-Id: <20241119060418.2368866-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241118224223@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241118224223@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Richard Henderson <richard.henderson@linaro.org>

In be8 mode, instructions are little-endian.
In be32 mode, instructions are big-endian.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2333
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 95c9e2209cc09453cfd49e91321df254ccbf466f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/arm/Makefile.vdso b/linux-user/arm/Makefile.vdso
index 8a24b0e534..ede489e236 100644
--- a/linux-user/arm/Makefile.vdso
+++ b/linux-user/arm/Makefile.vdso
@@ -3,15 +3,18 @@ include $(BUILD_DIR)/tests/tcg/arm-linux-user/config-target.mak
 SUBDIR = $(SRC_PATH)/linux-user/arm
 VPATH += $(SUBDIR)
 
-all: $(SUBDIR)/vdso-be.so $(SUBDIR)/vdso-le.so
+all: $(SUBDIR)/vdso-be8.so $(SUBDIR)/vdso-be32.so $(SUBDIR)/vdso-le.so
 
 # Adding -use-blx disables unneeded interworking without actually using blx.
 LDFLAGS = -nostdlib -shared -Wl,-use-blx -Wl,-z,max-page-size=4096 \
 	  -Wl,-h,linux-vdso.so.1 -Wl,--build-id=sha1 \
 	  -Wl,--hash-style=both -Wl,-T,$(SUBDIR)/vdso.ld
 
-$(SUBDIR)/vdso-be.so: vdso.S vdso.ld vdso-asmoffset.h
-	$(CC) -o $@ $(LDFLAGS) -mbig-endian $<
+$(SUBDIR)/vdso-be8.so: vdso.S vdso.ld vdso-asmoffset.h
+	$(CC) -o $@ $(LDFLAGS) -mbig-endian -mbe8 $<
+
+$(SUBDIR)/vdso-be32.so: vdso.S vdso.ld vdso-asmoffset.h
+	$(CC) -o $@ $(LDFLAGS) -mbig-endian -mbe32 $<
 
 $(SUBDIR)/vdso-le.so: vdso.S vdso.ld vdso-asmoffset.h
 	$(CC) -o $@ $(LDFLAGS) -mlittle-endian $<
diff --git a/linux-user/arm/meson.build b/linux-user/arm/meson.build
index c4bb9af5b8..348ffb810d 100644
--- a/linux-user/arm/meson.build
+++ b/linux-user/arm/meson.build
@@ -10,10 +10,17 @@ syscall_nr_generators += {
 # is always true as far as source_set.apply() is concerned.  Always build
 # both header files and include the right one via #if.
 
-vdso_be_inc = gen_vdso.process('vdso-be.so',
-                               extra_args: ['-s', 'sigreturn_codes'])
+vdso_be8_inc = gen_vdso.process('vdso-be8.so',
+                               extra_args: ['-s', 'sigreturn_codes',
+                                            '-p', 'vdso_be8'])
+
+vdso_be32_inc = gen_vdso.process('vdso-be32.so',
+                               extra_args: ['-s', 'sigreturn_codes',
+                                            '-p', 'vdso_be32'])
 
 vdso_le_inc = gen_vdso.process('vdso-le.so',
                                extra_args: ['-s', 'sigreturn_codes'])
 
-linux_user_ss.add(when: 'TARGET_ARM', if_true: [vdso_be_inc, vdso_le_inc])
+linux_user_ss.add(when: 'TARGET_ARM', if_true: [
+    vdso_be8_inc, vdso_be32_inc, vdso_le_inc
+])
diff --git a/linux-user/arm/vdso-be32.so b/linux-user/arm/vdso-be32.so
new file mode 100755
index 0000000000..b896d3d545
Binary files /dev/null and b/linux-user/arm/vdso-be32.so differ
diff --git a/linux-user/arm/vdso-be.so b/linux-user/arm/vdso-be8.so
similarity index 95%
rename from linux-user/arm/vdso-be.so
rename to linux-user/arm/vdso-be8.so
index bed02804a4..784b7bdb2a 100755
Binary files a/linux-user/arm/vdso-be.so and b/linux-user/arm/vdso-be8.so differ
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3b8db721e2..1deaf904e9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -659,6 +659,23 @@ static const char *get_elf_platform(void)
 #undef END
 }
 
+#if TARGET_BIG_ENDIAN
+#include "elf.h"
+#include "vdso-be8.c.inc"
+#include "vdso-be32.c.inc"
+
+static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
+{
+    return (EF_ARM_EABI_VERSION(elf_flags) >= EF_ARM_EABI_VER4
+            && (elf_flags & EF_ARM_BE8)
+            ? &vdso_be8_image_info
+            : &vdso_be32_image_info);
+}
+#define vdso_image_info vdso_image_info
+#else
+# define VDSO_HEADER  "vdso-le.c.inc"
+#endif
+
 #else
 /* 64 bit ARM definitions */
 
@@ -958,14 +975,14 @@ const char *elf_hwcap2_str(uint32_t bit)
 
 #undef GET_FEATURE_ID
 
-#endif /* not TARGET_AARCH64 */
-
 #if TARGET_BIG_ENDIAN
 # define VDSO_HEADER  "vdso-be.c.inc"
 #else
 # define VDSO_HEADER  "vdso-le.c.inc"
 #endif
 
+#endif /* not TARGET_AARCH64 */
+
 #endif /* TARGET_ARM */
 
 #ifdef TARGET_SPARC
@@ -3519,12 +3536,14 @@ static void load_elf_interp(const char *filename, struct image_info *info,
     load_elf_image(filename, &src, info, &ehdr, NULL);
 }
 
+#ifndef vdso_image_info
 #ifdef VDSO_HEADER
 #include VDSO_HEADER
-#define  vdso_image_info()  &vdso_image_info
+#define  vdso_image_info(flags)  &vdso_image_info
 #else
-#define  vdso_image_info()  NULL
-#endif
+#define  vdso_image_info(flags)  NULL
+#endif /* VDSO_HEADER */
+#endif /* vdso_image_info */
 
 static void load_elf_vdso(struct image_info *info, const VdsoImageInfo *vdso)
 {
@@ -3855,7 +3874,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
      * Load a vdso if available, which will amongst other things contain the
      * signal trampolines.  Otherwise, allocate a separate page for them.
      */
-    const VdsoImageInfo *vdso = vdso_image_info();
+    const VdsoImageInfo *vdso = vdso_image_info(info->elf_flags);
     if (vdso) {
         load_elf_vdso(&vdso_info, vdso);
         info->vdso = vdso_info.load_bias;
-- 
2.39.5


