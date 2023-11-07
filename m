Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2447E3306
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:34:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bs1-0003Qa-Ht; Mon, 06 Nov 2023 21:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Brg-0002lH-E4
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:56 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bre-0002YU-Nu
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:52 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc5b6d6228so34029025ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324248; x=1699929048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apZgi2dZMnaIv/RO9JzrMqGR3X+qf2pnzWxe7NJn8G8=;
 b=awm2HbZUaPqMMmhowKU+zj/om6pcMdWgjCy6+gf8aAR6NptG4h/RKKOEA+tCsxBosv
 2hNbQji0cvdhYrZlvMb4OlIo5bZrSPO9VMprQ64/wMRyNoMAeLUU3oLs6XOYgoaZHLB4
 ONSsk3c4cS8QLO2rEdKvKv6XcIZU+MpK2Sl16ROCfVjaUiQBHsR39A5y2FKhfN7MetiV
 5grVeI6MEAFDjos6bNHATFpLRs3RM79xSnDjfLFwZ5espchVV/r4e8D97RQMQ8nb2DjB
 4CQGjYMgDnB+Snxzl1NI4KVemGeZ6sfwNmZRY6TdpZ8FNWywuAXEaWIcka/I+WlOtvYi
 M2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324248; x=1699929048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=apZgi2dZMnaIv/RO9JzrMqGR3X+qf2pnzWxe7NJn8G8=;
 b=bmUxDKeDdThtzBpvWe7VCRYehISoHF62uoxT3JtAYQbulmtTq6QKnnvnJ1ea/LE00w
 ug/XViybKedO8kWCvF64/gCkjEtiyTgo34fp9BcwtscD5xYdZ0BhrgjiaZrTk4xJDFpM
 iC5gqAa2hH0fNlQUUSzJtilmxBnR7Vi1PV4eDUKyStxPDrfkfdCrHGHuWQHjpH/xBFCS
 qPuxG5JLXHQ+fPJg+2oYWpJEWoHIp7I0CTS4Xm85SHGewkFKjeUWJSyDz84A1YXannVk
 viuqBgfpqhlZ5hoOrlBKiSjcnx2m6rt2GprKsdfhd7pVq+kI9CZG2C5hEkNW0Ii7w7Z+
 Grsw==
X-Gm-Message-State: AOJu0YxwPR94jzOrU/ASK9UBXULetNckezvYKYOKnIi4yN6MQgwFhYEp
 kMcuIzKTM0tjsE29IsatMNABRCgX/2W0SA==
X-Google-Smtp-Source: AGHT+IEAt5tIbwUZEILogYWkK2xPamrahIQQDOdtkL87oPiLLk5Ouzi885kNgRKAtqnSI5qqC0gCww==
X-Received: by 2002:a17:903:2883:b0:1cc:3598:4ba0 with SMTP id
 ku3-20020a170903288300b001cc35984ba0mr18423580plb.68.1699324248380; 
 Mon, 06 Nov 2023 18:30:48 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:47 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/49] target/riscv/tcg: add tcg_cpu_finalize_features()
Date: Tue,  7 Nov 2023 12:29:11 +1000
Message-ID: <20231107022946.1055027-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The query-cpu-model-expansion API is capable of passing extra properties
to a given CPU model and tell callers if this custom configuration is
valid.

The RISC-V version of the API is not quite there yet. The reason is the
realize() flow in the TCG driver, where most of the validation is done
in tcg_cpu_realizefn(). riscv_cpu_finalize_features() is then used to
validate satp_mode for both TCG and KVM CPUs.

Our ARM friends uses a concept of 'finalize_features()', a step done in
the end of realize() where the CPU features are validated. We have a
riscv_cpu_finalize_features() helper that, at this moment, is only
validating satp_mode.

Re-use this existing helper to do all CPU extension validation we
required after at the end of realize(). Make it public to allow APIs to
use it. At this moment only the TCG driver requires a realize() time
validation, thus, to avoid adding accelerator specific helpers in the
API, riscv_cpu_finalize_features() uses
riscv_tcg_cpu_finalize_features() if we are running TCG. The API will
then use riscv_cpu_finalize_features() regardless of the current
accelerator.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231018195638.211151-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.h |  1 +
 target/riscv/cpu.c         | 18 +++++++++--
 target/riscv/tcg/tcg-cpu.c | 63 +++++++++++++++++++++-----------------
 4 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7f61e17202..8c9ec59d82 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -756,6 +756,7 @@ typedef struct isa_ext_data {
 extern const RISCVIsaExtData isa_edata_arr[];
 char *riscv_cpu_get_name(RISCVCPU *cpu);
 
+void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 void riscv_add_satp_mode_properties(Object *obj);
 
 /* CSR function table */
diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-cpu.h
index 630184759d..aa00fbc253 100644
--- a/target/riscv/tcg/tcg-cpu.h
+++ b/target/riscv/tcg/tcg-cpu.h
@@ -23,5 +23,6 @@
 #include "cpu.h"
 
 void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
+void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 
 #endif
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2f98ce56e0..02db0834dd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -34,6 +34,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
 #include "kvm/kvm_riscv.h"
+#include "tcg/tcg-cpu.h"
 #include "tcg/tcg.h"
 
 /* RISC-V CPU definitions */
@@ -998,11 +999,24 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 }
 #endif
 
-static void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
+void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
-#ifndef CONFIG_USER_ONLY
     Error *local_err = NULL;
 
+    /*
+     * KVM accel does not have a specialized finalize()
+     * callback because its extensions are validated
+     * in the get()/set() callbacks of each property.
+     */
+    if (tcg_enabled()) {
+        riscv_tcg_cpu_finalize_features(cpu, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
+#ifndef CONFIG_USER_ONLY
     riscv_cpu_satp_mode_finalize(cpu, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index bbce254ee1..21a46f2a0e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -548,6 +548,39 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     riscv_cpu_disable_priv_spec_isa_exts(cpu);
 }
 
+void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
+{
+    CPURISCVState *env = &cpu->env;
+    Error *local_err = NULL;
+
+    riscv_cpu_validate_priv_spec(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    riscv_cpu_validate_misa_priv(env, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (cpu->cfg.epmp && !cpu->cfg.pmp) {
+        /*
+         * Enhanced PMP should only be available
+         * on harts with PMP support
+         */
+        error_setg(errp, "Invalid configuration: EPMP requires PMP support");
+        return;
+    }
+
+    riscv_cpu_validate_set_extensions(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
 static bool riscv_cpu_is_generic(Object *cpu_obj)
 {
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
@@ -563,7 +596,6 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
 static bool tcg_cpu_realize(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-    CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;
 
     if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
@@ -579,34 +611,9 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-    riscv_cpu_validate_priv_spec(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return false;
-    }
-
-    riscv_cpu_validate_misa_priv(env, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return false;
-    }
-
-    if (cpu->cfg.epmp && !cpu->cfg.pmp) {
-        /*
-         * Enhanced PMP should only be available
-         * on harts with PMP support
-         */
-        error_setg(errp, "Invalid configuration: EPMP requires PMP support");
-        return false;
-    }
-
-    riscv_cpu_validate_set_extensions(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return false;
-    }
-
 #ifndef CONFIG_USER_ONLY
+    CPURISCVState *env = &cpu->env;
+
     CPU(cs)->tcg_cflags |= CF_PCREL;
 
     if (cpu->cfg.ext_sstc) {
-- 
2.41.0


