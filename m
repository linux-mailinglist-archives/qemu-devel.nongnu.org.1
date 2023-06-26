Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2016973EE51
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:06:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuIP-0001cr-EN; Mon, 26 Jun 2023 18:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuHu-0001U3-QY
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:02:23 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuHs-0005rE-24
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:02:22 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1a9a2724a62so3252040fac.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687816938; x=1690408938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYM0A7uhWQTD7Fcgtx52OKl1AAN477E4boZNXUg2Gdg=;
 b=letQgr5RWrAPDW8UckUKZMLyZDBDIB5bg2Hcjvt1nh2aJmyy2GaqiCyyS/HZ7lPrKe
 P0N+e9d+/WCcn/9RC9aTV7j5IpRym9GgnqE8Qd7KOQdtc2/21egRzthW4GDfq69BpE2p
 3xu9g/eUXwlCCxG1XJZtAyzHnFM87rMNvBIUdyVKXf1RXovbUJ0yiVeIoCFWNAkmrUCz
 vFPV97VdxGjUZIJWib4ywLukDgpWGsmDVJ9AyEAdeWEKwDi/V5mKKen++w0XbeOwSPSX
 eBOsuBWesMIOWEcfdVuCDviDpdYEtqQyPhMHjkyvaW/3bqWyc+lpXc6slNcKboxqTltN
 1bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816938; x=1690408938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYM0A7uhWQTD7Fcgtx52OKl1AAN477E4boZNXUg2Gdg=;
 b=LniH1Rc58fwHwXF5GuMrDpdYaB0UqOZNCS8s9gqqK3hpOTlx/YoIXLmmTFcSG4AwoJ
 a9NoyYOcRPX8aHDDyZ9y2q7Mqi0xbGbF8tevefWjHjDz1wp3x9HeebUc51o5tii9sPJB
 QKp99zg0VU/mAmMmzGJ2e2X2OHn5yW/bjdt4CVpi4qu2ivddLWA1B16MXNroBYNfO2Ls
 IFfCMcK+rSE+paEn0aoNKn5wJd6fiAbjaa5Ja6SeIHvn7Ypn/ZEdiJBajaTm6sz2MSXc
 iKzjGg/y8ydJDtMBD+f0QIKl0aqOmvklk4ASBgZSmxonc+MSt6ae7NT3ovFfIZy3ZC+j
 CjKg==
X-Gm-Message-State: AC+VfDxTePWM38MT2D5YBpU+NGFA/saWjSK0rEFzdI+n+2/2pnejvgaR
 mNhUi8+IWfQrg0hhJ5A8SKYeOVFTfeUvsHZkbqM=
X-Google-Smtp-Source: ACHHUZ4Pf3Z1CkXU19TsGHH7hm0V84Apl8BQrRevtIqHhB4qhCPbWbNBKAtNoxpI+Vvu3r/8DaP28A==
X-Received: by 2002:a05:6870:768f:b0:1b0:2de8:f14a with SMTP id
 dx15-20020a056870768f00b001b02de8f14amr3683755oab.28.1687816937985; 
 Mon, 26 Jun 2023 15:02:17 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056870a10c00b001b03fbfa0c5sm1831419oae.39.2023.06.26.15.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:02:17 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 01/19] target/riscv: skip features setup for KVM CPUs
Date: Mon, 26 Jun 2023 19:01:51 -0300
Message-ID: <20230626220209.22142-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626220209.22142-1-dbarboza@ventanamicro.com>
References: <20230626220209.22142-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x31.google.com
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
and setup during riscv_cpu_realize() that it doesn't apply KVM CPUs.
Validating the feature set for those CPUs is a KVM problem that should
be handled in KVM specific code.

The new riscv_cpu_realize_features() helper contains all validation
logic that are not applicable to KVM CPUs. riscv_cpu_realize() verifies
if we're dealing with a KVM CPU and, if not, execute the new helper to
proceed with the usual realize() logic for all other CPUs.

[1] lib/sbi/sbi_hart.c, hart_detect_features()

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fb8458bf74..e515dde208 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -331,6 +331,15 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 }
 #endif
 
+static bool riscv_running_kvm(void)
+{
+#ifndef CONFIG_USER_ONLY
+    return kvm_enabled();
+#else
+    return false;
+#endif
+}
+
 static void riscv_any_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -1308,20 +1317,12 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
     }
 }
 
-static void riscv_cpu_realize(DeviceState *dev, Error **errp)
+static void riscv_cpu_realize_features(DeviceState *dev, Error **errp)
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
@@ -1356,7 +1357,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    cs->tcg_cflags |= CF_PCREL;
+    CPU(dev)->tcg_cflags |= CF_PCREL;
 
     if (cpu->cfg.ext_sstc) {
         riscv_timer_init(cpu);
@@ -1369,6 +1370,28 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
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
+    if (!riscv_running_kvm()) {
+        riscv_cpu_realize_features(dev, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
 
     riscv_cpu_finalize_features(cpu, &local_err);
     if (local_err != NULL) {
-- 
2.41.0


