Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F577A8E95
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 23:39:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj4te-000564-4e; Wed, 20 Sep 2023 17:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qj4tc-00054y-A5
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 17:38:08 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qj4ta-0006Wx-IM
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 17:38:08 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6bf58009a8dso220903a34.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695245885; x=1695850685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEmwZ9vMlhj3Ze5psNqYIbXyqepgesAeFvMZiBAsj+4=;
 b=NnW8xNju4nvONb4FXdMMiFLlFq03mlHrhhhfn2F3p16J2BWSvL29czD/GcfYvnP2Cu
 /dW/5Zckaar3hFI+kuColmB5Kfz6hT7hCxyLz3vpp/dYkWnjUAFkHFBdsMQ+A0MC9qFy
 oLLZIA3pak+/cBB5ajZnkQTskrZo9zKOFdGq/6+WAFnKkIgqdE6GECOBDjtvKQW8K5f4
 Y3jnPVTZKIMsfcz0Ny0T6DrQcQOswrRxnNYpj3QNLxy7DBBgCQMxNu1QJiaFBHqyzn0Z
 dloRblcc0k2W9oIyEtQmCkC/ObtHvTaORSDDN6UfQrO1tQPnaKW1P2Fmj6PuzONNNasP
 zYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695245885; x=1695850685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nEmwZ9vMlhj3Ze5psNqYIbXyqepgesAeFvMZiBAsj+4=;
 b=nZkWKOgdJ7l/Q0ox4pMM/LkvH/ScUljZHeRcIrzLvqrLgDnSjCoHt5vbUI45GFmuLp
 6VAVwhBMxEQJtnpE08WuZ4khGkToMJ+9jtmB5CvgbJ+nE1DLeUDyGnm4mZ4Pd/ieEkbE
 sTuiMQV4X/CnmMLPHD/ArI9lf+O3IS0nxBX+xQgafQUR/KLtkGUjXbV4x9azPFl3QECD
 aHjyL6xo7LzRfIE1BtOjtaQTEZHPv7A1q6GU2za85UA4ojULezjM45ia21+ycE0RsYRF
 +0yusNH9TIR6DdldHvDY1yZCOu/M34T0Z+8rMozH8S+VnrkiTduahcizjqI7vzjuhYM7
 6PCQ==
X-Gm-Message-State: AOJu0Ywdm00y9UnixO58Y+dKgmj/p7rQjT6oP0ZnygsffQH5JxZ6Pf02
 6+nIxX0qM+QnEbVmQs1HkGRyQODTrpP8QWOEcts=
X-Google-Smtp-Source: AGHT+IHIL609JKU+0zd48ptLpF20l/XE+KZTRSJ7xQIPQWspkM0Tkm2bmWNkp/1neyTvmrLnGd89BQ==
X-Received: by 2002:a05:6830:181:b0:6b9:350e:4051 with SMTP id
 q1-20020a056830018100b006b9350e4051mr3641340ota.4.1695245885059; 
 Wed, 20 Sep 2023 14:38:05 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 e1-20020a9d7301000000b006b83a36c08bsm64415otk.53.2023.09.20.14.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 14:38:04 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 5/8] target/riscv/tcg: add tcg_cpu_finalize_features()
Date: Wed, 20 Sep 2023 18:37:40 -0300
Message-ID: <20230920213743.716265-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920213743.716265-1-dbarboza@ventanamicro.com>
References: <20230920213743.716265-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/cpu.c         | 18 +++++++++--
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 61 +++++++++++++++++++++-----------------
 target/riscv/tcg/tcg-cpu.h |  1 +
 4 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 521bb88538..272baaf6c7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -34,6 +34,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
 #include "kvm/kvm_riscv.h"
+#include "tcg/tcg-cpu.h"
 #include "tcg/tcg.h"
 
 /* RISC-V CPU definitions */
@@ -996,11 +997,24 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
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
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3f11e69223..1bfa3da55b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -732,6 +732,7 @@ typedef struct isa_ext_data {
 extern const RISCVIsaExtData isa_edata_arr[];
 char *riscv_cpu_get_name(RISCVCPU *cpu);
 
+void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 void riscv_add_satp_mode_properties(Object *obj);
 
 /* CSR function table */
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a90ee63b06..52cd87db0c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -549,6 +549,39 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -564,7 +597,6 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
 static bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-    CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;
 
     if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
@@ -580,33 +612,6 @@ static bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
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
     CPU(cs)->tcg_cflags |= CF_PCREL;
 
diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-cpu.h
index 630184759d..aa00fbc253 100644
--- a/target/riscv/tcg/tcg-cpu.h
+++ b/target/riscv/tcg/tcg-cpu.h
@@ -23,5 +23,6 @@
 #include "cpu.h"
 
 void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
+void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 
 #endif
-- 
2.41.0


