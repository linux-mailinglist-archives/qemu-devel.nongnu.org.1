Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1E27C9BAD
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 23:00:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs8D4-00051F-I5; Sun, 15 Oct 2023 16:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qs8D1-00050p-Ta
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 16:59:35 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qs8Cz-0007SQ-V0
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 16:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mxsNLO2TJ5Nq3iUTsM2g3qQlbCAHu6Vx16FViqOa238=; b=at5BMUllEh/MoaBEcmlwsX9kmi
 mri6G76Dk9muHMFsgQisd19kUhQZwKQZq7G3zNUOkG/cBSaocgBjP46GqZxRKNlW9bHOLcXaxJSLb
 CmpcFOvMj4US23x2zvpgFsnPTcBAJeVCSlfqq+trGQuAn8mOJmrpEiYcnhO8qWSHfJM8=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 6/6] target/tricore: Enable semihosting
Date: Sun, 15 Oct 2023 22:59:13 +0200
Message-ID: <20231015205913.264782-7-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015205913.264782-1-kbastian@mail.uni-paderborn.de>
References: <20231015205913.264782-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.10.15.205116, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.10.8.602001
X-Sophos-SenderHistory: ip=79.202.213.239, fs=1596206, da=185012635, mc=81,
 sc=0, hc=81, sp=0, fso=1596206, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 configs/devices/tricore-softmmu/default.mak |  1 +
 docs/about/emulation.rst                    |  3 +++
 qemu-options.hx                             |  3 ++-
 target/tricore/translate.c                  | 13 +++++++++++--
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/configs/devices/tricore-softmmu/default.mak b/configs/devices/tricore-softmmu/default.mak
index cb8fc286eb..883903073c 100644
--- a/configs/devices/tricore-softmmu/default.mak
+++ b/configs/devices/tricore-softmmu/default.mak
@@ -1,2 +1,3 @@
 CONFIG_TRICORE_TESTBOARD=y
 CONFIG_TRIBOARD=y
+CONFIG_SEMIHOSTING=y
diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 0ad0b86f0d..3ee90bd2aa 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -185,6 +185,9 @@ for that architecture.
   * - RISC-V
     - System and User-mode
     - https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc
+  * - TriCore
+    - System
+    - Infineon ISS syscall handling (for GNU tools)
   * - Xtensa
     - System
     - Tensilica ISS SIMCALL
diff --git a/qemu-options.hx b/qemu-options.hx
index 54a7e94970..d7a6cb94c9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4816,7 +4816,8 @@ ERST
 DEF("semihosting", 0, QEMU_OPTION_semihosting,
     "-semihosting    semihosting mode\n",
     QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA |
-    QEMU_ARCH_MIPS | QEMU_ARCH_NIOS2 | QEMU_ARCH_RISCV)
+    QEMU_ARCH_MIPS | QEMU_ARCH_NIOS2 | QEMU_ARCH_RISCV |
+    QEMU_ARCH_TRICORE)
 SRST
 ``-semihosting``
     Enable :ref:`Semihosting` mode (ARM, M68K, Xtensa, MIPS, Nios II, RISC-V only).
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index dd812ec0f0..1eb44c78c2 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -25,6 +25,7 @@
 #include "tcg/tcg-op.h"
 #include "exec/cpu_ldst.h"
 #include "qemu/qemu-print.h"
+#include "semihosting/semihost.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -3151,6 +3152,14 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
     }
 }
 
+static void gen_debug(DisasContext *ctx)
+{
+    if (semihosting_enabled(false)) {
+        gen_helper_1arg(tricore_semihost, ctx->base.pc_next);
+    } else {
+        /* raise EXCP_DEBUG */
+    }
+}
 
 /*
  * Functions for decoding instructions
@@ -3497,7 +3506,7 @@ static void decode_sr_system(DisasContext *ctx)
         ctx->base.is_jmp = DISAS_EXIT;
         break;
     case OPC2_16_SR_DEBUG:
-        /* raise EXCP_DEBUG */
+        gen_debug(ctx);
         break;
     case OPC2_16_SR_FRET:
         gen_fret(ctx);
@@ -7926,7 +7935,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_SYS_DEBUG:
-        /* raise EXCP_DEBUG */
+        gen_debug(ctx);
         break;
     case OPC2_32_SYS_DISABLE:
         if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
-- 
2.42.0


