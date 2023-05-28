Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6B6713AC5
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 18:51:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Jan-0000bs-Fd; Sun, 28 May 2023 12:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3Jal-0000bB-FE; Sun, 28 May 2023 12:50:03 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3Jah-0003dC-I4; Sun, 28 May 2023 12:50:03 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-38ede2e0e69so1572585b6e.2; 
 Sun, 28 May 2023 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685292597; x=1687884597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WErItUQvNqASkxkWadEcwLrYMTb/Qj+s/UWP9bWp6nk=;
 b=GfDwjA6MeeOdmDyDxS2RAX95Gggmew8mdi0mE4Odm9jnD4Nkp8dqiBxSHETmw98Da1
 WfX56m5D/mRpMv2E08W7cL8EomQkCOtxjSTjmIQY1Pe2APqyzjxyrFTV/aHliYPxW3ok
 TW7yEknxVsE24jgFPT5cArFO6vVQzgeBy0xpPBijSH0h64WbqaVa3U+08/4dMHFQAtwf
 5uG3Ql30xIT6RWM16XiVu8ce4VyBFrZ7Zu1H2LnvBSXyyfBR4/ZB5kRjmyCvDCfWb2BN
 rnYNnnPAw0ZulN3g8b6b0/jNyS+9yWymh9riEpz6iKOHrEPMvgp8jNUPRDZdPpfp/5Js
 1iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685292597; x=1687884597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WErItUQvNqASkxkWadEcwLrYMTb/Qj+s/UWP9bWp6nk=;
 b=QEVvXGw9BarupYuLhFS6TY7cOrzGMbEP1dUhJuVOIAaQMYDGoAJt+NpKGeNiGjgmjF
 ugCTF5mKlyBmAuMEBeV65gNJ27TeNoTlJlvBqjOGn79+oGL0C9aHr+PF1rIddi+nUB3M
 P2r2bwk+FRwhTD8FJ5gN0dkOP+lhjeeO2T35hcnBm+tUrWvDd6hSpa712hZVjG5PmvEC
 yXRX5Sih1fca0LeqVxDEtgNZ0KF/Ht4B7N2680iQ/bICH/diH1EBV0oFHfSNru5+hCLE
 ANfzunLiuOK16eZF2n54EPsYdE3lb5r3qyKFEeXWf6FtpI6DesDX3pyZfMfcq9GZU89X
 eAXw==
X-Gm-Message-State: AC+VfDwyvBCFkraRnh401DTnGcGXW9EL3KLytiX+BOMjN5WnJMxacKF7
 Z9boH+nLoUwtq8YS8v/Yc8HbstCkRfA=
X-Google-Smtp-Source: ACHHUZ5k3mgGSxBTZu6s+4ntsFDhvnAgartqDKyHCQCbUVVZgLBSthRkwC+sRQBKdakwd8cUCsr6Uw==
X-Received: by 2002:a05:6808:2219:b0:39a:1940:8184 with SMTP id
 bd25-20020a056808221900b0039a19408184mr672074oib.31.1685292597598; 
 Sun, 28 May 2023 09:49:57 -0700 (PDT)
Received: from grind.. (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 w4-20020a4adec4000000b0054f85f67f31sm3378830oou.46.2023.05.28.09.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 09:49:57 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 09/10] target/ppc: Add POWER9 DD2.2 model
Date: Sun, 28 May 2023 13:49:21 -0300
Message-Id: <20230528164922.20364-10-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528164922.20364-1-danielhb413@gmail.com>
References: <20230528164922.20364-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

POWER9 DD2.1 and earlier had significant limitations when running KVM,
including lack of "mixed mode" MMU support (ability to run HPT and RPT
mode on threads of the same core), and a translation prefetch issue
which is worked around by disabling "AIL" mode for the guest.

These processors are not widely available, and it's difficult to deal
with all these quirks in qemu +/- KVM, so create a POWER9 DD2.2 CPU
and make it the default POWER9 CPU.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-Id: <20230515160201.394587-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv.c                   |  2 +-
 hw/ppc/pnv_core.c              |  2 +-
 hw/ppc/spapr.c                 |  2 +-
 hw/ppc/spapr_cpu_core.c        |  1 +
 include/hw/ppc/pnv.h           |  2 +-
 target/ppc/cpu-models.c        |  4 +++-
 target/ppc/cpu-models.h        |  1 +
 target/ppc/cpu_init.c          | 21 +++++++++++++++++++--
 tests/qtest/device-plug-test.c |  4 ++--
 9 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 11cb48af2f..590fc64b32 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2171,7 +2171,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
     };
 
     mc->desc = "IBM PowerNV (Non-Virtualized) POWER9";
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
     xfc->match_nvt = pnv_match_nvt;
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 410f31bdf8..0bc3ad41c8 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -348,7 +348,7 @@ static const TypeInfo pnv_core_infos[] = {
     DEFINE_PNV_CORE_TYPE(power8, "power8e_v2.1"),
     DEFINE_PNV_CORE_TYPE(power8, "power8_v2.0"),
     DEFINE_PNV_CORE_TYPE(power8, "power8nvl_v1.0"),
-    DEFINE_PNV_CORE_TYPE(power9, "power9_v2.0"),
+    DEFINE_PNV_CORE_TYPE(power9, "power9_v2.2"),
     DEFINE_PNV_CORE_TYPE(power10, "power10_v2.0"),
 };
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b623e23d6c..dcb7f1c70a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4631,7 +4631,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
 
     smc->dr_lmb_enabled = true;
     smc->update_dt_enabled = true;
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
     mc->has_hotpluggable_cpus = true;
     mc->nvdimm_supported = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 8a4861f45a..9b88dd549a 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -390,6 +390,7 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
     DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power10_v1.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
 #ifdef CONFIG_KVM
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 409f3bf763..7e5fef7c43 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -48,7 +48,7 @@ DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER8,
 DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER8NVL,
                          TYPE_PNV_CHIP_POWER8NVL)
 
-#define TYPE_PNV_CHIP_POWER9 PNV_CHIP_TYPE_NAME("power9_v2.0")
+#define TYPE_PNV_CHIP_POWER9 PNV_CHIP_TYPE_NAME("power9_v2.2")
 DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER9,
                          TYPE_PNV_CHIP_POWER9)
 
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 912b037c63..7dbb47de64 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -732,6 +732,8 @@
                 "POWER9 v1.0")
     POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
                 "POWER9 v2.0")
+    POWERPC_DEF("power9_v2.2",   CPU_POWERPC_POWER9_DD22,            POWER9,
+                "POWER9 v2.2")
     POWERPC_DEF("power10_v1.0",  CPU_POWERPC_POWER10_DD1,            POWER10,
                 "POWER10 v1.0")
     POWERPC_DEF("power10_v2.0",  CPU_POWERPC_POWER10_DD20,           POWER10,
@@ -907,7 +909,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "power8e", "power8e_v2.1" },
     { "power8", "power8_v2.0" },
     { "power8nvl", "power8nvl_v1.0" },
-    { "power9", "power9_v2.0" },
+    { "power9", "power9_v2.2" },
     { "power10", "power10_v2.0" },
 #endif
 
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index a77e036b3a..572b5e553a 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -350,6 +350,7 @@ enum {
     CPU_POWERPC_POWER9_BASE        = 0x004E0000,
     CPU_POWERPC_POWER9_DD1         = 0x004E1100,
     CPU_POWERPC_POWER9_DD20        = 0x004E1200,
+    CPU_POWERPC_POWER9_DD22        = 0x004E1202,
     CPU_POWERPC_POWER10_BASE       = 0x00800000,
     CPU_POWERPC_POWER10_DD1        = 0x00801100,
     CPU_POWERPC_POWER10_DD20       = 0x00801200,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 5aa0b3f0f1..05bf73296b 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6284,9 +6284,26 @@ static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
         return false;
     }
 
-    if ((pvr & 0x0f00) == (pcc->pvr & 0x0f00)) {
-        /* Major DD version matches to power9_v1.0 and power9_v2.0 */
+    if ((pvr & 0x0f00) != (pcc->pvr & 0x0f00)) {
+        /* Major DD version does not match */
+        return false;
+    }
+
+    if ((pvr & 0x0f00) == 0x100) {
+        /* DD1.x always matches power9_v1.0 */
         return true;
+    } else if ((pvr & 0x0f00) == 0x200) {
+        if ((pvr & 0xf) < 2) {
+            /* DD2.0, DD2.1 match power9_v2.0 */
+            if ((pcc->pvr & 0xf) == 0) {
+                return true;
+            }
+        } else {
+            /* DD2.2, DD2.3 match power9_v2.2 */
+            if ((pcc->pvr & 0xf) == 2) {
+                return true;
+            }
+        }
     }
 
     return false;
diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-test.c
index abd544b70c..c6f33153eb 100644
--- a/tests/qtest/device-plug-test.c
+++ b/tests/qtest/device-plug-test.c
@@ -175,8 +175,8 @@ static void test_spapr_cpu_unplug_request(void)
 {
     QTestState *qtest;
 
-    qtest = qtest_initf("-cpu power9_v2.0 -smp 1,maxcpus=2 "
-                        "-device power9_v2.0-spapr-cpu-core,core-id=1,id=dev0");
+    qtest = qtest_initf("-cpu power9_v2.2 -smp 1,maxcpus=2 "
+                        "-device power9_v2.2-spapr-cpu-core,core-id=1,id=dev0");
 
     /* similar to test_pci_unplug_request */
     process_device_remove(qtest, "dev0");
-- 
2.40.1


