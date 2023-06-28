Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1433B741AEA
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:32:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEckY-0001qZ-Eg; Wed, 28 Jun 2023 17:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEckW-0001q3-Fa
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:30:52 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEckU-0007wI-Pl
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:30:52 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-558a79941c6so274999eaf.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687987849; x=1690579849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeRyY4W6Wb9RKiIj7JlexHTM/tveFQwPeBLGOEUoQw0=;
 b=bRm68Dh7m1QVGslD/QW0oDiWX4Ia6LVhRqaQKbCrQntMNHfyz0xw8h4VwwZJIolFio
 wyIMkNFGPQJ+FXJuXVdy8EkTYvvLC+xYremEQq1SLq65+5pBmDx+54UBTpvPAW+aZA6a
 YudkKUla02wDgNcomREp8EK9e1DFZ7Nr8GdGUYyfkFSkZAMkPpWoQUaZuPfNcOJek2qX
 Yd/9YD0+MPawMwcS9CaA2SsOqpq35BAU2/fmccjbzUwbkZ/T1IWnmSGnqZO+OwaqqRry
 eeTu0lhCOGy9DLcgrJjk25y8Jm0JVFMlu6I90mZHdYv6+Nle3/E43yOwjEkoeMCTmFqJ
 l+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687987849; x=1690579849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xeRyY4W6Wb9RKiIj7JlexHTM/tveFQwPeBLGOEUoQw0=;
 b=YsOu2C+JKnz1L41T0aK7E0UR4xqlU0rn4rdPh7rzv5Lefi7JoKQeqIBuF6HFKt101b
 iBykgq/3iYyVtRyieS3riOdG86PcUvMxK/U3pq1hXO3It69z7UiBb3gdxUV46sApKQnc
 /DfGxFd36pnjK+QaogsTmZisorI0O6g9QHZrvPfMiNTJQUXVr7Uf5Cw9U0RWKmo2SHXj
 ns7TldHh3s5PmS0d/EP7eviO0RFXA6hCuyq4HlCTJ4Qv8IDFn+2IwuPdWajPHwdthjJj
 omUypy+Cmxp+ApNrwu6jBTrmu5+QBO1Nw04YGcPykSCUvwwe7qwMLXK7NKOqa4sqGw1+
 bavA==
X-Gm-Message-State: AC+VfDyqrP/p2RZtlm3uQZ1gQF7yuJJjVRMKvmPF9Q3k2ZqZv/zaDw1d
 ULdNjHNyXNV/mz9hcTnPVjAOGi2wDzpinxxg5Yw=
X-Google-Smtp-Source: ACHHUZ4Ea3f8LZ3P2TrVzbt2TmusGTfbmngZeQpi8Ef1bWG6nPpJdOzOoeogKuZ8IZr78zmUz6M2dg==
X-Received: by 2002:a4a:e8db:0:b0:565:84b0:845d with SMTP id
 h27-20020a4ae8db000000b0056584b0845dmr4653609ooe.6.1687987849396; 
 Wed, 28 Jun 2023 14:30:49 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a4a4511000000b0056084a91c74sm832892ooa.24.2023.06.28.14.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:30:49 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 01/20] target/riscv: skip features setup for KVM CPUs
Date: Wed, 28 Jun 2023 18:30:14 -0300
Message-ID: <20230628213033.170315-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628213033.170315-1-dbarboza@ventanamicro.com>
References: <20230628213033.170315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc32.google.com
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

$ sudo ./qemu/build/qemu-system-riscv64 \
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
---
 target/riscv/cpu.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fb8458bf74..bbb201a2b3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -34,6 +34,7 @@
 #include "migration/vmstate.h"
 #include "fpu/softfloat-helpers.h"
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 #include "kvm_riscv.h"
 #include "tcg/tcg.h"
 
@@ -1308,20 +1309,12 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
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
@@ -1356,7 +1349,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    cs->tcg_cflags |= CF_PCREL;
+    CPU(dev)->tcg_cflags |= CF_PCREL;
 
     if (cpu->cfg.ext_sstc) {
         riscv_timer_init(cpu);
@@ -1369,6 +1362,28 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
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


