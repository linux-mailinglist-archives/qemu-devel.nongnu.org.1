Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8512C761C54
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:56:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJS3-0002H7-6f; Tue, 25 Jul 2023 10:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOJRu-0002DP-Ob; Tue, 25 Jul 2023 10:55:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOJRs-00009I-N1; Tue, 25 Jul 2023 10:55:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 05B7D161C0;
 Tue, 25 Jul 2023 17:55:37 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8D6271953B;
 Tue, 25 Jul 2023 17:55:34 +0300 (MSK)
Received: (nullmailer pid 3375803 invoked by uid 1000);
 Tue, 25 Jul 2023 14:55:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 2/8] s390x: spelling fixes
Date: Tue, 25 Jul 2023 17:55:26 +0300
Message-Id: <cced0d653973f6ad0d9e8bdbd365e12d0f2316f9.1690294956.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690294956.git.mjt@tls.msk.ru>
References: <cover.1690294956.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/intc/s390_flic_kvm.c          | 2 +-
 include/hw/s390x/s390-pci-bus.h  | 2 +-
 include/hw/s390x/sclp.h          | 2 +-
 target/s390x/cpu_features.c      | 2 +-
 target/s390x/cpu_models.c        | 2 +-
 target/s390x/tcg/fpu_helper.c    | 2 +-
 target/s390x/tcg/insn-data.h.inc | 2 +-
 target/s390x/tcg/translate.c     | 2 +-
 tests/tcg/s390x/mvc.c            | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 4e86d2d436..28364b22d6 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -380,7 +380,7 @@ static void kvm_s390_release_adapter_routes(S390FLICState *fs,
  * @size: ignored
  *
  * Note: Pass buf and len to kernel. Start with one page and
- * increase until buffer is sufficient or maxium size is
+ * increase until buffer is sufficient or maximum size is
  * reached
  */
 static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index e0a9f9385b..b1bdbeaeb5 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -184,7 +184,7 @@ enum ZpciIoatDtype {
  * The following states make up the "configured" meta-state:
  * disabled: device is configured but not enabled; transition between this
  *           state and enabled via clp enable/disable
- * enbaled: device is ready for use; transition to disabled via clp disable;
+ * enabled: device is ready for use; transition to disabled via clp disable;
  *          may enter an error state
  * blocked: ignore all DMA and interrupts; transition back to enabled or from
  *          error state via mpcifc
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index d3ade40a5a..cf1f2efae2 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -87,7 +87,7 @@
  * - we work on a private copy of the SCCB, since there are several length
  *   fields, that would cause a security nightmare if we allow the guest to
  *   alter the structure while we parse it. We cannot use ldl_p and friends
- *   either without doing pointer arithmetics
+ *   either without doing pointer arithmetic
  * So we have to double check that all users of sclp data structures use the
  * right endianness wrappers.
  */
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index ebb155ce1c..d28eb65845 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -249,7 +249,7 @@ static void init_groups(void)
 {
     int i;
 
-    /* init all bitmaps from gnerated data initially */
+    /* init all bitmaps from generated data initially */
     for (i = 0; i < ARRAY_SIZE(s390_feature_groups); i++) {
         s390_init_feat_bitmap(s390_feature_groups[i].init,
                               s390_feature_groups[i].feat);
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 42b52afdb4..91ce896491 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -975,7 +975,7 @@ static void register_types(void)
 
     init_ignored_base_feat();
 
-    /* init all bitmaps from gnerated data initially */
+    /* init all bitmaps from generated data initially */
     s390_init_feat_bitmap(qemu_max_init, qemu_max_cpu_feat);
     for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
         s390_init_feat_bitmap(s390_cpu_defs[i].base_init,
diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 3d941ed2d2..c329b31261 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -87,7 +87,7 @@ static void handle_exceptions(CPUS390XState *env, bool XxC, uintptr_t retaddr)
 
     /*
      * FIXME:
-     * 1. Right now, all inexact conditions are inidicated as
+     * 1. Right now, all inexact conditions are indicated as
      *    "truncated" (0) and never as "incremented" (1) in the DXC.
      * 2. Only traps due to invalid/divbyzero are suppressing. Other traps
      *    are completing, meaning the target register has to be written!
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 86a509b0ac..0bfd88d3c3 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -529,7 +529,7 @@
 /* LOAD LOGICAL HALFWORD RELATIVE LONG */
     C(0xc402, LLHRL,   RIL_b, GIE, 0, ri2, new, r1_32, ld16u, 0)
     C(0xc406, LLGHRL,  RIL_b, GIE, 0, ri2, r1, 0, ld16u, 0)
-/* LOAD LOGICAL IMMEDATE */
+/* LOAD LOGICAL IMMEDIATE */
     D(0xc00e, LLIHF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 32)
     D(0xc00f, LLILF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 0)
     D(0xa50c, LLIHH,   RI_a,  Z,  0, i2_16u_shl, 0, r1, mov2, 0, 48)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 84d76f1cea..dc7041e1d8 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -429,7 +429,7 @@ static void gen_exception(int excp)
 
 static void gen_program_exception(DisasContext *s, int code)
 {
-    /* Remember what pgm exeption this was.  */
+    /* Remember what pgm exception this was.  */
     tcg_gen_st_i32(tcg_constant_i32(code), cpu_env,
                    offsetof(CPUS390XState, int_pgm_code));
 
diff --git a/tests/tcg/s390x/mvc.c b/tests/tcg/s390x/mvc.c
index 7ae4c44550..b572aa3ced 100644
--- a/tests/tcg/s390x/mvc.c
+++ b/tests/tcg/s390x/mvc.c
@@ -85,7 +85,7 @@ int main(void)
         }
     }
 
-    /* test if MVC works now correctly accross page boundaries */
+    /* test if MVC works now correctly across page boundaries */
     mvc_256(dst + 4096 - 128, src + 4096 - 128);
     for (i = 0; i < ALLOC_SIZE; i++) {
         if (src[i] != 0xff) {
-- 
2.39.2


