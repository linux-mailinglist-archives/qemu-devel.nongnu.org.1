Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA067E331C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:36:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BtZ-0003Dw-Kl; Mon, 06 Nov 2023 21:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtW-0002sU-Fq
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:46 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtU-00035P-Gu
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:46 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc9b626a96so26948425ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324363; x=1699929163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6QG9uGqqG/ZxppfouZVb9w3fLYDP7x4ZVtyFJ5kQQY=;
 b=klByGa/MVMFtqPsxs9zgcpvz6qwQxYOxS4PI6LVVYkkWPKHFeHdGExIqVAfPM087uX
 NX+eUnAPgHTpJ1xp5/KC48Lw/eMJxnD7JnE6RcMQg4bkVQ1MJ5HPGVeQcWfj86aO+eo9
 4zUWGC3sxOPOkUM7WpnfXGCLTOsPO15a4Ae/BHFSMEx0jdOrcGJ5bLW5rafurfMMizjl
 bHPOoY+HC9QCCtse6LsgMMKPDU0FLhe+vgr5D7tzfAZe+zgYknnhsMnwIdv2rd4kyVf3
 cBGf7Ah6QS5coGPODvOwbA0kwaRWwmFzo09oJjhc641Y5NGj0UM3IvronPiO4mLg4lTj
 ZAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324363; x=1699929163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6QG9uGqqG/ZxppfouZVb9w3fLYDP7x4ZVtyFJ5kQQY=;
 b=d8Tjhsdeq0fj9Xuw6TfRuQ2v4Wl2bw+yaOJGf2E4p+kqy0izUUq2IAc/BynlsVn67w
 SDsme2PZ8+6it5ztuSW3CyP2uze7TJYygd4kT2av0yfatMLJFJviDjWD0SOPRTqjoGTt
 SGg/bw0f8rVOaRroPFsP2WXHsKT5fLCecuzPmk6GmWFqWvOgqdXJo37ROLmtI4vpPZXi
 skrI1LxYyS37TGCk/yD60crvyS8F5LhTsFyQwgbvzewkGpMIwEQQ+ibICKRLR5vE9ZCu
 3AuKYxf2chaSqfhofTLqJN7aQQCRv9JI05wcPUrn6MlkCkSr0k0sH+Xm2lY8kqd+RrXT
 S7DA==
X-Gm-Message-State: AOJu0YwMEjPN6Xy6TekBeJNHq1wYF1vRFIb43uNNhGJFWCEG9Sa7Q0V2
 SeCElYb16WH4RAN15UHCdzVCH+M5kakb8A==
X-Google-Smtp-Source: AGHT+IFSllPW2c5d0D/LlupH7ZXZabtedpuIzVRP52MtPnQ3+zDZmUws+cWz6YrjTeRgLlhGBYqF4A==
X-Received: by 2002:a17:903:11c8:b0:1cc:7ebe:4db6 with SMTP id
 q8-20020a17090311c800b001cc7ebe4db6mr16468755plh.39.1699324362951; 
 Mon, 06 Nov 2023 18:32:42 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:32:42 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 48/49] target/riscv: Add "pmu-mask" property to replace
 "pmu-num"
Date: Tue,  7 Nov 2023 12:29:44 +1000
Message-ID: <20231107022946.1055027-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

From: Rob Bradford <rbradford@rivosinc.com>

Using a mask instead of the number of PMU devices supports the accurate
emulation of platforms that have a discontinuous set of PMU counters.

The "pmu-num" property now generates a warning when used by the user on
the command line.

Rather than storing the value for "pmu-num" convert it directly to the
mask if it is specified (overwriting the default "pmu-mask" value)
likewise the value is calculated from the mask if the property value is
obtained.

In the unusual situation that both "pmu-mask" and "pmu-num" are provided
then then the order on the command line determines which takes
precedence (later overwriting earlier.)

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231031154000.18134-5-rbradford@rivosinc.com>
[Changes by AF
 - Fixup ext_zihpm logic after rebase
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     |  2 +-
 target/riscv/cpu.c         | 40 +++++++++++++++++++++++++++++++++++++-
 target/riscv/machine.c     |  2 +-
 target/riscv/pmu.c         | 15 +++++++-------
 target/riscv/tcg/tcg-cpu.c |  4 ++--
 5 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 634ff673b3..f4605fb190 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -134,7 +134,7 @@ struct RISCVCPUConfig {
     bool ext_xtheadsync;
     bool ext_XVentanaCondOps;
 
-    uint8_t pmu_num;
+    uint32_t pmu_mask;
     char *priv_spec;
     char *user_spec;
     char *bext_spec;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 70c0a78c6c..02db2760d1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1427,8 +1427,46 @@ const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void prop_pmu_num_set(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint8_t pmu_num;
+
+    visit_type_uint8(v, name, &pmu_num, errp);
+
+    if (pmu_num > (RV_MAX_MHPMCOUNTERS - 3)) {
+        error_setg(errp, "Number of counters exceeds maximum available");
+        return;
+    }
+
+    if (pmu_num == 0) {
+        cpu->cfg.pmu_mask = 0;
+    } else {
+        cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, pmu_num);
+    }
+
+    warn_report("\"pmu-num\" property is deprecated; use \"pmu-mask\"");
+}
+
+static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint8_t pmu_num = ctpop32(cpu->cfg.pmu_mask);
+
+    visit_type_uint8(v, name, &pmu_num, errp);
+}
+
+const PropertyInfo prop_pmu_num = {
+    .name = "pmu-num",
+    .get = prop_pmu_num_get,
+    .set = prop_pmu_num_set,
+};
+
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
+    DEFINE_PROP_UINT32("pmu-mask", RISCVCPU, cfg.pmu_mask, MAKE_64BIT_MASK(3, 16)),
+    {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
 
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 14bb2d7819..fdde243e04 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -316,7 +316,7 @@ static bool pmu_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.pmu_num;
+    return (cpu->cfg.pmu_mask > 0);
 }
 
 static const VMStateDescription vmstate_pmu_ctr_state = {
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 7ddf4977b1..0e7d58b8a5 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -18,14 +18,13 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/error-report.h"
 #include "cpu.h"
 #include "pmu.h"
 #include "sysemu/cpu-timers.h"
 #include "sysemu/device_tree.h"
 
 #define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
-#define MAKE_32BIT_MASK(shift, length) \
-        (((uint32_t)(~0UL) >> (32 - (length))) << (shift))
 
 /*
  * To keep it simple, any event can be mapped to any programmable counters in
@@ -184,7 +183,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
     CPURISCVState *env = &cpu->env;
     gpointer value;
 
-    if (!cpu->cfg.pmu_num) {
+    if (!cpu->cfg.pmu_mask) {
         return 0;
     }
     value = g_hash_table_lookup(cpu->pmu_event_ctr_map,
@@ -432,9 +431,12 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
 
 void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
 {
-    uint8_t pmu_num = cpu->cfg.pmu_num;
+    if (cpu->cfg.pmu_mask & (COUNTEREN_CY | COUNTEREN_TM | COUNTEREN_IR)) {
+        error_setg(errp, "\"pmu-mask\" contains invalid bits (0-2) set");
+        return;
+    }
 
-    if (pmu_num > (RV_MAX_MHPMCOUNTERS - 3)) {
+    if (ctpop32(cpu->cfg.pmu_mask) > (RV_MAX_MHPMCOUNTERS - 3)) {
         error_setg(errp, "Number of counters exceeds maximum available");
         return;
     }
@@ -445,6 +447,5 @@ void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    /* Create a bitmask of available programmable counters */
-    cpu->pmu_avail_ctrs = MAKE_32BIT_MASK(3, pmu_num);
+    cpu->pmu_avail_ctrs = cpu->cfg.pmu_mask;
 }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 144bdac1b2..08adad304d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -600,7 +600,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     }
 
     if (!cpu->cfg.ext_zihpm) {
-        cpu->cfg.pmu_num = 0;
+        cpu->cfg.pmu_mask = 0;
         cpu->pmu_avail_ctrs = 0;
     }
 
@@ -688,7 +688,7 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
         riscv_timer_init(cpu);
     }
 
-    if (cpu->cfg.pmu_num) {
+    if (cpu->cfg.pmu_mask) {
         riscv_pmu_init(cpu, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
-- 
2.41.0


