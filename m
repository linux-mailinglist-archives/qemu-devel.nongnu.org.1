Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2282D7AF31D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 20:42:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlCzI-0007K5-Jx; Tue, 26 Sep 2023 14:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlCz9-0007Ig-W7
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 14:40:41 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlCz6-0006Uq-CP
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 14:40:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c5ff5f858dso41522145ad.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695753634; x=1696358434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEmwZ9vMlhj3Ze5psNqYIbXyqepgesAeFvMZiBAsj+4=;
 b=QPLC7qGm03G5czWD+vFGMBaPBTdeKqPjSNGwS4vTpQ5z3sjTn7zJN7uQCqYjqmIN9i
 YcJYKD+RmPCkPCzCNdbziBRnV4X0EYU0szlmM5YyozR4f8lcR8yxs3gOCrReK0N3o2G/
 TnCkiT5iF/3XA5kanjWLj18XBGIKEB8dzENCmZyB0GkzkidLcBRybyDp1g4udgMerZ6H
 Po86nfdctPnyKN1fWKGNsLoVpBTpFX7uauoSM/gxv5uTuPrmdwYRydQEGcwZEIoZGd7W
 KFZg0OzejN/jdVBDB2pVqXFvisoUfe6FKgN9opFJcyfDxD6Jx+kKtuoTf0d1wnLfHVhm
 Zn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695753634; x=1696358434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nEmwZ9vMlhj3Ze5psNqYIbXyqepgesAeFvMZiBAsj+4=;
 b=pkYBHHm1l0Ddx+68zLaILzwPHtqhd/0ltBooOrNuk1qirjvA4dW49zcVMxcIOtPzka
 YYBohrEZLLCLpdrfR9gpJ+aiFyPYB6kRYWKYn4Q4lYajXbZKUGApl7iHglrDp8zEzlmV
 F6G/BV9tQy9YjuVNieLVYimTiFbSalyadFZiFLDq9fjH4945aTZ8D+6SaqGgTde7m/ga
 sMbFYADFSUuCNrBsFNkH54Z7063Cq5i/uB/DlJCldybPB1yPoSFiNG5HfyM0WI8W7Sev
 5nQlQw1HBnJrhl58buJ7ji7ZkjKaK3m9wNyo4gC0K9S3lnJRpZ0fJ1lTO/P1rQ/4bRhX
 kISw==
X-Gm-Message-State: AOJu0YxxwTlyUflHNU6SZR3bJhemSmYi/Z5lyfXB3yrFPBEVBQsUI9sV
 aKqQC+cNyK/bvaeh6CE9soakRpNZi92UNhpzypE=
X-Google-Smtp-Source: AGHT+IF97cq+mridn0chfYrkz4SQTbddkkAmgHq5zIBpxVP5vweEpKokDlqwWMfsCUo8ovkuBLfkMA==
X-Received: by 2002:a17:903:2308:b0:1c6:2acc:62ea with SMTP id
 d8-20020a170903230800b001c62acc62eamr4878571plh.57.1695753634508; 
 Tue, 26 Sep 2023 11:40:34 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 a11-20020a170902eccb00b001b9cdf11764sm11268306plh.31.2023.09.26.11.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 11:40:34 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 3/6] target/riscv/tcg: add tcg_cpu_finalize_features()
Date: Tue, 26 Sep 2023 15:40:16 -0300
Message-ID: <20230926184019.166352-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926184019.166352-1-dbarboza@ventanamicro.com>
References: <20230926184019.166352-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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


