Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB4A749934
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:18:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHM3e-0004kN-NF; Thu, 06 Jul 2023 06:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM3d-0004jx-Bd
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:17:53 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM3a-00061M-J6
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:17:53 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6b5d5e6b086so307088a34.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688638669; x=1691230669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dzsnYR034KDJ8Bk8jT9IC3VF7Gf7HsQ5csZ2zr9bQz0=;
 b=PkHC4WrISMC43LZCxDuT3El/11M+l1TABD7bHdisG2MLrcKtMnrQq0hut9iw9bJXUW
 qJVrP2m82ABq2ADbS7YfZBpYfT9QdtmzBc/JohYwl22+e4Cgv+EGgc4+cI6txIgHZ9bt
 usa6wYuWBc/5b5HDzBPUj0plz8dV9L8BU1HDihlwRHboRmTnLFzMjrV0PrN2rz5r+vCO
 5XkIifNmeVcZ3zdsN/eWHxXoi2m4gOCCJ0bvUUXYK0oVIy/rc0Z6zRG7QKsXExpd32k8
 o2mbk+4JSG5Ys/N2272zrLT84iFPvRQEViTHWvly2XyIrYBZYIrygpCpE+YdSjV8vlwY
 czAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688638669; x=1691230669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dzsnYR034KDJ8Bk8jT9IC3VF7Gf7HsQ5csZ2zr9bQz0=;
 b=XzCa8mbA1lJWtD9xd2549Ru2x9lDv/1T4ZjKduNYSMH2YlCWg4PxLrcRYlB4HUFIPj
 ez/x3ERXFa0k2yg5pp9N0YgDfHK92dTK8xvQxJPf4T7J8AYvpi4Jm0uF8BlAWGVA8ass
 F81cRWuCkkEg+Ly1ga7ja/Ek/cIygjPDRGHdkj8cBCXgQvxnOxJqjxnWTod1PX4bQtxU
 zpiBdTN96BX0IBTTetGxjL1cjd0bb1zijFy0mL4gWLJp/HJyJ+09+c6BPQyib03PXz0w
 4AdLb2LM7q5uP/SDjaem0aEQc9T7u4KkX2ZNvpEcQC4FHVnTP7XHeRPK4sVJJTLdwxgD
 O00g==
X-Gm-Message-State: ABy/qLbZv2MgBR3W5muk8PK40mTGuGJeZl/8qUxJo84ayyfNRWJTkLQI
 Tq0l0jfJvuENLRSuzenmJ8o1o9/C57xuKflOh9A=
X-Google-Smtp-Source: APBJJlF6V0BHHr76nzstBgRYMY9dQWEwIOSLUsMHtKHaFXVhaihoQWwOwudjxOyV+s8cjT4ZpBZXaQ==
X-Received: by 2002:a9d:4c8f:0:b0:6b8:7d8a:8b79 with SMTP id
 m15-20020a9d4c8f000000b006b87d8a8b79mr2548797otf.10.1688638669046; 
 Thu, 06 Jul 2023 03:17:49 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a9d6a59000000b006b8850ad193sm511382otn.56.2023.07.06.03.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 03:17:48 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 01/20] target/riscv: skip features setup for KVM CPUs
Date: Thu,  6 Jul 2023 07:17:19 -0300
Message-ID: <20230706101738.460804-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706101738.460804-1-dbarboza@ventanamicro.com>
References: <20230706101738.460804-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

As it is today it's not possible to use '-cpu host' if the RISC-V host
has RVH enabled. This is the resulting error:

$ ./qemu/build/qemu-system-riscv64 \
    -machine virt,accel=kvm -m 2G -smp 1 \
    -nographic -snapshot -kernel ./guest_imgs/Image  \
    -initrd ./guest_imgs/rootfs_kvm_riscv64.img \
    -append "earlycon=sbi root=/dev/ram rw" \
    -cpu host
qemu-system-riscv64: H extension requires priv spec 1.12.0

This happens because we're checking for priv spec for all CPUs, and
since we're not setting  env->priv_ver for the 'host' CPU, it's being
default to zero (i.e. PRIV_SPEC_1_10_0).

In reality env->priv_ver does not make sense when running with the KVM
'host' CPU. It's used to gate certain CSRs/extensions during translation
to make them unavailable if the hart declares an older spec version. It
doesn't have any other use. E.g. OpenSBI version 1.2 retrieves the spec
checking if the CSR_MCOUNTEREN, CSR_MCOUNTINHIBIT and CSR_MENVCFG CSRs
are available [1].

'priv_ver' is just one example. We're doing a lot of feature validation
and setup during riscv_cpu_realize() that it doesn't apply to KVM CPUs.
Validating the feature set for those CPUs is a KVM problem that should
be handled in KVM specific code.

The new riscv_cpu_realize_tcg() helper contains all validation logic that
are applicable to TCG CPUs only. riscv_cpu_realize() verifies if we're
running TCG and, if it's the case, proceed with the usual TCG realize()
logic.

[1] lib/sbi/sbi_hart.c, hart_detect_features()

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fd647534cf..6232e6513b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -34,6 +34,7 @@
 #include "migration/vmstate.h"
 #include "fpu/softfloat-helpers.h"
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 #include "kvm_riscv.h"
 #include "tcg/tcg.h"
 
@@ -1386,20 +1387,12 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
     }
 }
 
-static void riscv_cpu_realize(DeviceState *dev, Error **errp)
+static void riscv_cpu_realize_tcg(DeviceState *dev, Error **errp)
 {
-    CPUState *cs = CPU(dev);
     RISCVCPU *cpu = RISCV_CPU(dev);
     CPURISCVState *env = &cpu->env;
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     riscv_cpu_validate_misa_mxl(cpu, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -1434,7 +1427,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    cs->tcg_cflags |= CF_PCREL;
+    CPU(dev)->tcg_cflags |= CF_PCREL;
 
     if (cpu->cfg.ext_sstc) {
         riscv_timer_init(cpu);
@@ -1447,6 +1440,28 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         }
      }
 #endif
+}
+
+static void riscv_cpu_realize(DeviceState *dev, Error **errp)
+{
+    CPUState *cs = CPU(dev);
+    RISCVCPU *cpu = RISCV_CPU(dev);
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    cpu_exec_realizefn(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (tcg_enabled()) {
+        riscv_cpu_realize_tcg(dev, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
 
     riscv_cpu_finalize_features(cpu, &local_err);
     if (local_err != NULL) {
-- 
2.41.0


