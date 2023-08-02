Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 882E876D390
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 18:20:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qREZN-00063O-II; Wed, 02 Aug 2023 12:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qREZK-00062O-UZ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:19:26 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qREZH-0006Fi-Kj
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690993160; bh=3o4KTXUsdRZ10iRrqw3JujvQ853pCrOkKE3TdB5CjFM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wO4vkd1pvV3L3lEgr29TxiAppmcf0kcySj3QH/1r8v9Ikpfolkd5gHpEfl+zIS/Mv
 C8WfjlOvwBps2+v2j+TqdrPVsPiGXLlhTey6VqrpdDQup+53/Kb+Z7Ng1JIRpRe9Gj
 54LAHLiWV+gEvT3GPg/ak8XlT9ztHhyEtU438ckbc+k6oA7pHYGUMdmBz4ixWQjybI
 LbKiMkgDDPvSboPcelmJx7QXMxky2/XKUJL4Eq1Er/wCAl+AUiN19sHfAi0hDul7E4
 yFD9qICyrWIt19VgP5yX2Ifj62dUnyG3HfFA0IyG+bEFgPm+7IVCspSSX1gz49scQ+
 fOt0nyByt7EaQ==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id F0F9F3F21CDB;
 Wed,  2 Aug 2023 09:19:20 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id PEK-f0SzJfPB; Wed,  2 Aug 2023 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690993158; bh=3o4KTXUsdRZ10iRrqw3JujvQ853pCrOkKE3TdB5CjFM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Hk2y0ChPyWgDAZ5CsWtYwgyBFiG21Hr5c7XufiGKIWMdNO9ldjcZH4LlbuNMyzj6d
 3b3aveDY+evPolev5DDPjjDKwpJ+W7z9vBs2zZFc5dd0zUV+uM7ri1h78C9P73dRPg
 aFyp8eZrApz3i9GfoCnpojz1oAPVyxQ0toD66z7+tdRNNfjxH5AvGLlrxn+/RpCKh4
 +iZ6Rc6+O4+XX87bWZECLG7y3SjQc2fieOcEIj3w+7H3cX+NQv4SebXhXQ/pW8xpxD
 D0dGXNnStZlfxKHl6xhoXH0+LBoZA7t3ymfmtwNaDOAO2jqC68wGNP2K51/43fdW8q
 En9HAOa1/xxJg==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id DCE963F21D80;
 Wed,  2 Aug 2023 09:19:18 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 793291E601ED; Wed,  2 Aug 2023 09:19:18 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
	Keith Packard <keithp@keithp.com>
Subject: [PATCH 3/3] target/m68k: Support semihosting on non-ColdFire targets
Date: Wed,  2 Aug 2023 09:19:14 -0700
Message-Id: <20230802161914.395443-4-keithp@keithp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802161914.395443-1-keithp@keithp.com>
References: <20230802161914.395443-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

According to the m68k semihosting spec:

"The instruction used to trigger a semihosting request depends on the
 m68k processor variant.  On ColdFire, "halt" is used; on other processors
 (which don't implement "halt"), "bkpt #0" may be used."

Add support for non-CodeFire processors by matching BKPT #0
instructions. When semihosting is disabled, convert those
back to illegal op exceptions.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 target/m68k/cpu.h       |  1 +
 target/m68k/op_helper.c | 16 ++++++++++++++++
 target/m68k/translate.c |  4 ++++
 3 files changed, 21 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index cf70282717..b741c50a8f 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -67,6 +67,7 @@
 
 #define EXCP_RTE            0x100
 #define EXCP_HALT_INSN      0x101
+#define EXCP_BKPT_INSN      0x102
 
 #define M68K_DTTR0   0
 #define M68K_DTTR1   1
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 1ce850bbc5..2d89db6dde 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -295,6 +295,22 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
             /* Return from an exception.  */
             m68k_rte(env);
             return;
+        case EXCP_BKPT_INSN:
+            if (semihosting_enabled((env->sr & SR_S) == 0)
+                    && (env->pc & 3) == 0
+                    && cpu_lduw_code(env, env->pc - 4) == 0x4e71
+                    && cpu_ldl_code(env, env->pc) == 0x4e7bf000) {
+                env->pc += 4;
+                do_m68k_semihosting(env, env->dregs[0]);
+                return;
+            }
+            /*
+             * When semihosting is not enabled, translate this back to
+             * an illegal op exception.
+             */
+            cs->exception_index = EXCP_ILLEGAL;
+            env->pc += 2;
+            break;
         }
     }
 
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index e07161d76f..d037c57453 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2640,6 +2640,10 @@ DISAS_INSN(bkpt)
 #if defined(CONFIG_USER_ONLY)
     gen_exception(s, s->base.pc_next, EXCP_DEBUG);
 #else
+    if ((insn & 7) == 0) {
+        gen_exception(s, s->pc, EXCP_BKPT_INSN);
+        return;
+    }
     gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
 #endif
 }
-- 
2.40.1


