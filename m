Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8177C863A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:57:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHih-00035E-VI; Fri, 13 Oct 2023 08:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHie-0002rq-Hl
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:56:44 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHic-0002YQ-AH
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:56:44 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53dd752685fso3686898a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697201800; x=1697806600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJG9hKwu+wpRvVwz3i5zPTfZu546zhwzoj0NQVluILM=;
 b=kgzeKRoZ1mvc42qI+U/KAu1/G1eNQwordEIAeW3ChGXYDGAZXGo0akFh6Iu4HTHz8g
 XYYHtdT4HHhaOYrmRjIMVSNWvT2717cJqi5iyKONvym2pHPkaqUly7YquVZN04Mfpklh
 LB+JgxzZYviZ/OyouOUcTKRbXowZXXqhQA3tl390p897OTbBhmIY08KBbF8DM5CPEwJT
 ZXeQhvRcyA/cXE1BzUfm1vVkbB2IvRLHhb2mWQ3yogvQbefeZXFfCkO2QXfFDBAAPB2f
 MOheE6A07XtDcoPEKLww7i2mxQWpGLEh/dMZ0ZnHsUVGR0UV1xXDcdcDq+AipJDtk8Dy
 ZD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697201800; x=1697806600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJG9hKwu+wpRvVwz3i5zPTfZu546zhwzoj0NQVluILM=;
 b=T2PwJowxjYvmwlUpoaoPn4OEg/BYhKn85bp6g0Rp0K8SkdLaslOX8q7WRP7bL6XWbQ
 Kn/naV4/rkmod3u4MWw4u9N8M+0GtcBjobVlPwBj55dTeENLqXQJbsz4vKVyLkXDI3qN
 37zxsndVhDDiPmH0DsTSG0Hs0ImWCDi5P7pD6oGaEN/n/0njGpYZKdT4602e8ElcdyQU
 lI2tdEqrc1pEQkSoqKl8JLjGRyrU/BeoGVGiYbH/Gpx1B1ryxIFZ8D69yt3Qq6UgvHT4
 CVUGMmSusL8AYN2YQQKOLhFsEZMy80/de81oAA1GZAUvcjvokmbCj/ZMZQ4HTZRtRA6p
 iXxw==
X-Gm-Message-State: AOJu0YwtwDTHtLm2x/57cOSKqz4t/h6ABT2ratcyk9p+hF0VxOF97yYQ
 9GTQNBYv4OpjFPm0w6UMiSz5rrho8QNSLsEEK48=
X-Google-Smtp-Source: AGHT+IHXm04fa/4ltJrEAslN/c6jb1nfaurjSJ3rrHbVJnPBC0yrzDb7waDIuC3pzUFfrxsjSQglhw==
X-Received: by 2002:a05:6402:150d:b0:523:bfec:4915 with SMTP id
 f13-20020a056402150d00b00523bfec4915mr25184247edw.0.1697201800089; 
 Fri, 13 Oct 2023 05:56:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 da6-20020a056402176600b0053dfd3519f4sm2439193edb.22.2023.10.13.05.56.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 05:56:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/7] hw/ppc/spapr: Restrict PPCTimebase structure declaration
 to sPAPR
Date: Fri, 13 Oct 2023 14:56:24 +0200
Message-ID: <20231013125630.95116-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013125630.95116-1-philmd@linaro.org>
References: <20231013125630.95116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The PPCTimebase structure is only used by the sPAPR machine.
Move its declaration to "hw/ppc/spapr.h".
Move vmstate_ppc_timebase and the VMSTATE_PPC_TIMEBASE_V()
macro to hw/ppc/spapr.c, along with the timebase_foo()
migration helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h |   6 +++
 target/ppc/cpu-qom.h   |  22 --------
 hw/ppc/ppc.c           | 107 -------------------------------------
 hw/ppc/spapr.c         | 116 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 129 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index e91791a1a9..3cf9978cba 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -163,6 +163,12 @@ struct SpaprMachineClass {
     SpaprIrq *irq;
 };
 
+typedef struct PPCTimebase {
+    uint64_t guest_timebase;
+    int64_t time_of_the_day_ns;
+    bool runstate_paused;
+} PPCTimebase;
+
 #define WDT_MAX_WATCHDOGS       4      /* Maximum number of watchdog devices */
 
 #define TYPE_SPAPR_WDT "spapr-wdt"
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index be33786bd8..b5deef5ca5 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -197,26 +197,4 @@ struct PowerPCCPUClass {
     int  (*check_pow)(CPUPPCState *env);
 };
 
-#ifndef CONFIG_USER_ONLY
-typedef struct PPCTimebase {
-    uint64_t guest_timebase;
-    int64_t time_of_the_day_ns;
-    bool runstate_paused;
-} PPCTimebase;
-
-extern const VMStateDescription vmstate_ppc_timebase;
-
-#define VMSTATE_PPC_TIMEBASE_V(_field, _state, _version) {            \
-    .name       = (stringify(_field)),                                \
-    .version_id = (_version),                                         \
-    .size       = sizeof(PPCTimebase),                                \
-    .vmsd       = &vmstate_ppc_timebase,                              \
-    .flags      = VMS_STRUCT,                                         \
-    .offset     = vmstate_offset_value(_state, _field, PPCTimebase),  \
-}
-
-void cpu_ppc_clock_vm_state_change(void *opaque, bool running,
-                                   RunState state);
-#endif
-
 #endif
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index be167710a3..340cd6192f 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -32,7 +32,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
-#include "sysemu/replay.h"
 #include "sysemu/runstate.h"
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
@@ -967,112 +966,6 @@ void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value)
     _cpu_ppc_store_purr(env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), value);
 }
 
-static void timebase_save(PPCTimebase *tb)
-{
-    uint64_t ticks = cpu_get_host_ticks();
-    PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
-
-    if (!first_ppc_cpu->env.tb_env) {
-        error_report("No timebase object");
-        return;
-    }
-
-    if (replay_mode == REPLAY_MODE_NONE) {
-        /* not used anymore, we keep it for compatibility */
-        tb->time_of_the_day_ns = qemu_clock_get_ns(QEMU_CLOCK_HOST);
-    } else {
-        /* simpler for record-replay to avoid this event, compat not needed */
-        tb->time_of_the_day_ns = 0;
-    }
-
-    /*
-     * tb_offset is only expected to be changed by QEMU so
-     * there is no need to update it from KVM here
-     */
-    tb->guest_timebase = ticks + first_ppc_cpu->env.tb_env->tb_offset;
-
-    tb->runstate_paused =
-        runstate_check(RUN_STATE_PAUSED) || runstate_check(RUN_STATE_SAVE_VM);
-}
-
-static void timebase_load(PPCTimebase *tb)
-{
-    CPUState *cpu;
-    PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
-    int64_t tb_off_adj, tb_off;
-    unsigned long freq;
-
-    if (!first_ppc_cpu->env.tb_env) {
-        error_report("No timebase object");
-        return;
-    }
-
-    freq = first_ppc_cpu->env.tb_env->tb_freq;
-
-    tb_off_adj = tb->guest_timebase - cpu_get_host_ticks();
-
-    tb_off = first_ppc_cpu->env.tb_env->tb_offset;
-    trace_ppc_tb_adjust(tb_off, tb_off_adj, tb_off_adj - tb_off,
-                        (tb_off_adj - tb_off) / freq);
-
-    /* Set new offset to all CPUs */
-    CPU_FOREACH(cpu) {
-        PowerPCCPU *pcpu = POWERPC_CPU(cpu);
-        pcpu->env.tb_env->tb_offset = tb_off_adj;
-        kvmppc_set_reg_tb_offset(pcpu, pcpu->env.tb_env->tb_offset);
-    }
-}
-
-void cpu_ppc_clock_vm_state_change(void *opaque, bool running,
-                                   RunState state)
-{
-    PPCTimebase *tb = opaque;
-
-    if (running) {
-        timebase_load(tb);
-    } else {
-        timebase_save(tb);
-    }
-}
-
-/*
- * When migrating a running guest, read the clock just
- * before migration, so that the guest clock counts
- * during the events between:
- *
- *  * vm_stop()
- *  *
- *  * pre_save()
- *
- *  This reduces clock difference on migration from 5s
- *  to 0.1s (when max_downtime == 5s), because sending the
- *  final pages of memory (which happens between vm_stop()
- *  and pre_save()) takes max_downtime.
- */
-static int timebase_pre_save(void *opaque)
-{
-    PPCTimebase *tb = opaque;
-
-    /* guest_timebase won't be overridden in case of paused guest or savevm */
-    if (!tb->runstate_paused) {
-        timebase_save(tb);
-    }
-
-    return 0;
-}
-
-const VMStateDescription vmstate_ppc_timebase = {
-    .name = "timebase",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .pre_save = timebase_pre_save,
-    .fields      = (VMStateField []) {
-        VMSTATE_UINT64(guest_timebase, PPCTimebase),
-        VMSTATE_INT64(time_of_the_day_ns, PPCTimebase),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
 /* Set up (once) timebase frequency (in Hz) */
 void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cb840676d3..fe8b425ffd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -37,6 +37,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
+#include "sysemu/replay.h"
 #include "sysemu/runstate.h"
 #include "qemu/log.h"
 #include "hw/fw-path-provider.h"
@@ -1809,6 +1810,100 @@ static bool spapr_vga_init(PCIBus *pci_bus, Error **errp)
     }
 }
 
+static void timebase_save(PPCTimebase *tb)
+{
+    uint64_t ticks = cpu_get_host_ticks();
+    PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
+
+    if (!first_ppc_cpu->env.tb_env) {
+        error_report("No timebase object");
+        return;
+    }
+
+    if (replay_mode == REPLAY_MODE_NONE) {
+        /* not used anymore, we keep it for compatibility */
+        tb->time_of_the_day_ns = qemu_clock_get_ns(QEMU_CLOCK_HOST);
+    } else {
+        /* simpler for record-replay to avoid this event, compat not needed */
+        tb->time_of_the_day_ns = 0;
+    }
+
+    /*
+     * tb_offset is only expected to be changed by QEMU so
+     * there is no need to update it from KVM here
+     */
+    tb->guest_timebase = ticks + first_ppc_cpu->env.tb_env->tb_offset;
+
+    tb->runstate_paused =
+        runstate_check(RUN_STATE_PAUSED) || runstate_check(RUN_STATE_SAVE_VM);
+}
+
+static void timebase_load(PPCTimebase *tb)
+{
+    CPUState *cpu;
+    PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
+    int64_t tb_off_adj, tb_off;
+    unsigned long freq;
+
+    if (!first_ppc_cpu->env.tb_env) {
+        error_report("No timebase object");
+        return;
+    }
+
+    freq = first_ppc_cpu->env.tb_env->tb_freq;
+
+    tb_off_adj = tb->guest_timebase - cpu_get_host_ticks();
+
+    tb_off = first_ppc_cpu->env.tb_env->tb_offset;
+    trace_ppc_tb_adjust(tb_off, tb_off_adj, tb_off_adj - tb_off,
+                        (tb_off_adj - tb_off) / freq);
+
+    /* Set new offset to all CPUs */
+    CPU_FOREACH(cpu) {
+        PowerPCCPU *pcpu = POWERPC_CPU(cpu);
+        pcpu->env.tb_env->tb_offset = tb_off_adj;
+        kvmppc_set_reg_tb_offset(pcpu, pcpu->env.tb_env->tb_offset);
+    }
+}
+
+static void cpu_ppc_clock_vm_state_change(void *opaque, bool running,
+                                          RunState state)
+{
+    PPCTimebase *tb = opaque;
+
+    if (running) {
+        timebase_load(tb);
+    } else {
+        timebase_save(tb);
+    }
+}
+
+/*
+ * When migrating a running guest, read the clock just
+ * before migration, so that the guest clock counts
+ * during the events between:
+ *
+ *  * vm_stop()
+ *  *
+ *  * pre_save()
+ *
+ *  This reduces clock difference on migration from 5s
+ *  to 0.1s (when max_downtime == 5s), because sending the
+ *  final pages of memory (which happens between vm_stop()
+ *  and pre_save()) takes max_downtime.
+ */
+static int timebase_pre_save(void *opaque)
+{
+    PPCTimebase *tb = opaque;
+
+    /* guest_timebase won't be overridden in case of paused guest or savevm */
+    if (!tb->runstate_paused) {
+        timebase_save(tb);
+    }
+
+    return 0;
+}
+
 static int spapr_pre_load(void *opaque)
 {
     int rc;
@@ -2081,6 +2176,27 @@ static const VMStateDescription vmstate_spapr_fwnmi = {
     },
 };
 
+static const VMStateDescription vmstate_spapr_timebase = {
+    .name = "timebase",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_save = timebase_pre_save,
+    .fields      = (VMStateField []) {
+        VMSTATE_UINT64(guest_timebase, PPCTimebase),
+        VMSTATE_INT64(time_of_the_day_ns, PPCTimebase),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+#define VMSTATE_PPC_TIMEBASE_V(_field, _state, _version) {            \
+    .name       = (stringify(_field)),                                \
+    .version_id = (_version),                                         \
+    .size       = sizeof(PPCTimebase),                                \
+    .vmsd       = &vmstate_spapr_timebase,                            \
+    .flags      = VMS_STRUCT,                                         \
+    .offset     = vmstate_offset_value(_state, _field, PPCTimebase),  \
+}
+
 static const VMStateDescription vmstate_spapr = {
     .name = "spapr",
     .version_id = 3,
-- 
2.41.0


