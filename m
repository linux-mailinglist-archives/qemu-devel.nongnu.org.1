Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 003387539CE
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:43:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH9K-0000hm-QR; Fri, 14 Jul 2023 07:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH96-0000X1-Oo; Fri, 14 Jul 2023 07:39:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH92-0004JO-Uk; Fri, 14 Jul 2023 07:39:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E926613D99;
 Fri, 14 Jul 2023 14:38:56 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D87A214BA8;
 Fri, 14 Jul 2023 14:38:40 +0300 (MSK)
Received: (nullmailer pid 1186234 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 13/29] tree-wide spelling fixes in comments and some
 messages: s390x
Date: Fri, 14 Jul 2023 14:38:18 +0300
Message-Id: <20230714113834.1186117-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
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
@@ -382,3 +382,3 @@ static void kvm_s390_release_adapter_routes(S390FLICState *fs,
  * Note: Pass buf and len to kernel. Start with one page and
- * increase until buffer is sufficient or maxium size is
+ * increase until buffer is sufficient or maximum size is
  * reached
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index e0a9f9385b..b1bdbeaeb5 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -186,3 +186,3 @@ enum ZpciIoatDtype {
  *           state and enabled via clp enable/disable
- * enbaled: device is ready for use; transition to disabled via clp disable;
+ * enabled: device is ready for use; transition to disabled via clp disable;
  *          may enter an error state
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index d3ade40a5a..cf1f2efae2 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -89,3 +89,3 @@
  *   alter the structure while we parse it. We cannot use ldl_p and friends
- *   either without doing pointer arithmetics
+ *   either without doing pointer arithmetic
  * So we have to double check that all users of sclp data structures use the
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index ebb155ce1c..d28eb65845 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -251,3 +251,3 @@ static void init_groups(void)
 
-    /* init all bitmaps from gnerated data initially */
+    /* init all bitmaps from generated data initially */
     for (i = 0; i < ARRAY_SIZE(s390_feature_groups); i++) {
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 42b52afdb4..91ce896491 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -977,3 +977,3 @@ static void register_types(void)
 
-    /* init all bitmaps from gnerated data initially */
+    /* init all bitmaps from generated data initially */
     s390_init_feat_bitmap(qemu_max_init, qemu_max_cpu_feat);
diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 4b7fa58af3..5364372c8b 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -88,3 +88,3 @@ static void handle_exceptions(CPUS390XState *env, bool XxC, uintptr_t retaddr)
      * FIXME:
-     * 1. Right now, all inexact conditions are inidicated as
+     * 1. Right now, all inexact conditions are indicated as
      *    "truncated" (0) and never as "incremented" (1) in the DXC.
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 457ed25d2f..555c147c7c 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -531,3 +531,3 @@
     C(0xc406, LLGHRL,  RIL_b, GIE, 0, ri2, r1, 0, ld16u, 0)
-/* LOAD LOGICAL IMMEDATE */
+/* LOAD LOGICAL IMMEDIATE */
     D(0xc00e, LLIHF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 32)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 6661b27efa..94c8c1f9aa 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -431,3 +431,3 @@ static void gen_program_exception(DisasContext *s, int code)
 {
-    /* Remember what pgm exeption this was.  */
+    /* Remember what pgm exception this was.  */
     tcg_gen_st_i32(tcg_constant_i32(code), cpu_env,
diff --git a/tests/tcg/s390x/mvc.c b/tests/tcg/s390x/mvc.c
index 7ae4c44550..b572aa3ced 100644
--- a/tests/tcg/s390x/mvc.c
+++ b/tests/tcg/s390x/mvc.c
@@ -87,3 +87,3 @@ int main(void)
 
-    /* test if MVC works now correctly accross page boundaries */
+    /* test if MVC works now correctly across page boundaries */
     mvc_256(dst + 4096 - 128, src + 4096 - 128);
-- 
2.39.2


