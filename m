Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7DFAB6BE8
	for <lists+qemu-devel@lfdr.de>; Wed, 14 May 2025 14:57:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBfe-0000Cr-Aa; Wed, 14 May 2025 08:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBfV-00006r-HZ; Wed, 14 May 2025 08:57:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBfS-0007iL-AE; Wed, 14 May 2025 08:57:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D2939121AC5;
 Wed, 14 May 2025 15:56:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7E76E20B83D;
 Wed, 14 May 2025 15:56:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.18 05/18] target/mips: Revert TARGET_PAGE_BITS_VARY
Date: Wed, 14 May 2025 15:56:11 +0300
Message-Id: <20250514125640.91677-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.18-20250514114012@cover.tls.msk.ru>
References: <qemu-stable-7.2.18-20250514114012@cover.tls.msk.ru>
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

Revert ee3863b9d41 and a08d60bc6c2b.  The logic behind changing
the system page size because of what the Loongson kernel "prefers"
is flawed.

In the Loongson-2E manual, section 5.5, it is clear that the cpu
supports a 4k page size (along with many others).  Similarly for
the Loongson-3 series CPUs, the 4k page size is mentioned in the
section 7.7 (PageMask Register).  Therefore we must continue to
support a 4k page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250328175526.368121-2-richard.henderson@linaro.org>
[PMD: Mention Loongson-3 series CPUs]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit fca2817fdcb00e65020c2dcfcb0b23b2a20ea3c4)
(Mjt: context fixes for 7.2.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 34befa5dd5..dbd26df00b 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -336,7 +336,6 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fuloong2e.ram";
-    mc->minimum_page_bits = 14;
 }
 
 DEFINE_MACHINE("fuloong2e", mips_fuloong2e_machine_init)
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index b4f6bff1b8..dc94e21438 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -616,7 +616,6 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = LOONGSON_MAX_VCPUS;
     mc->default_ram_id = "loongson3.highram";
     mc->default_ram_size = 1600 * MiB;
-    mc->minimum_page_bits = 14;
 }
 
 static const TypeInfo loongson3_machine_types[] = {
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index f4c76994ea..4d9f4297f1 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -23,12 +23,7 @@
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 #endif
-#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 12
-#else
-#define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 12
-#endif
 #define NB_MMU_MODES 4
 
 #endif
diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu/cp0_helper.c
index 5da1124589..f0459a85e6 100644
--- a/target/mips/tcg/sysemu/cp0_helper.c
+++ b/target/mips/tcg/sysemu/cp0_helper.c
@@ -900,18 +900,13 @@ void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
     if ((mask >> maskbits) != 0) {
         goto invalid;
     }
-    /* We don't support VTLB entry smaller than target page */
-    if ((maskbits + TARGET_PAGE_BITS_MIN) < TARGET_PAGE_BITS) {
-        goto invalid;
-    }
     env->CP0_PageMask = mask << CP0PM_MASK;
 
     return;
 
 invalid:
     /* When invalid, set to default target page size. */
-    mask = (~TARGET_PAGE_MASK >> TARGET_PAGE_BITS_MIN);
-    env->CP0_PageMask = mask << CP0PM_MASK;
+    env->CP0_PageMask = 0;
 }
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 9d16859c0a..f0a513365b 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -877,7 +877,7 @@ refill:
             break;
         }
     }
-    pw_pagemask = m >> TARGET_PAGE_BITS_MIN;
+    pw_pagemask = m >> TARGET_PAGE_BITS;
     update_pagemask(env, pw_pagemask << CP0PM_MASK, &pw_pagemask);
     pw_entryhi = (address & ~0x1fff) | (env->CP0_EntryHi & 0xFF);
     {
-- 
2.39.5


