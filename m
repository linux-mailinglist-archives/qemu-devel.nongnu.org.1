Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 029047E32F0
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:31:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bs5-0003ig-TM; Mon, 06 Nov 2023 21:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bs3-0003hi-Hy
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:15 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bs1-0002r8-Mt
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:15 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc5b7057d5so47176635ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324272; x=1699929072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHvzT4eo9HqFoFgtgO1dUwaY+gTE83YageCcu631raw=;
 b=DUdhYRm/o+/6qRsR0F1q3EWnTMOmM70CRPdWu1koEXASp+vWdscEhNcllDs3eTjq9m
 b/ftam2o6ldCopaS4F06I8uxWTRVJjoF+howX2sCo1LP4E/XJcke/CqYjRCXWw+FH/mD
 NG+wVau8ZQRI80ofyjIlyBIRCwLnko4mFvixRH4dmkh0oWG9XbRfuM9UDK8zruomPzcK
 ab8cxLhYjH27a09xgvwWFVhOGyUrPbXW3PgA/dJtKss+60UzvoGP2cZZv2kVi2XcRBgc
 /qpgP4OlGSM9w/XxuG48iHftAV16mtlMESzutgzgp2TwH8De8ig1gMNtt5SoVzF9P1tY
 ofSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324272; x=1699929072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qHvzT4eo9HqFoFgtgO1dUwaY+gTE83YageCcu631raw=;
 b=qkdDJiil59KzpyQ6ICFxVqEeiz7beFaqYL8/S55E0PWy7/GDMdtlPaZwihryofZ2Nw
 jFDkTqV9EzazebE7wMji7x+6iuUnH1Zu/2jI09MeTNSlZ0QN+Y2VQuR5mBTHbOC3Q2OE
 fSFVcGpVWBK7slAq0Mltn2cbrFV9kio2D/oKQQRXM6bnjJUQzr3b7mEMqFLgvX7BQxTF
 rtwOQYhMFahBcUUrvEAFN7fBBKT7TTkIfzzm934fJynkBhXQeTmHwof7D9umasdqAyau
 ti/F8aVpcvNAHdINAP79/MyxcVcdT/lkSTJYrVY3dG82YzVk5N2rqQ5TT35pqrBuWIej
 LhVA==
X-Gm-Message-State: AOJu0YyDeT5ykbiJjAtEXZ4CYz8T8p/8jeAKpqf4DG/uEQyKE7Bwy0ed
 r1Fz8HDAOcQJOK0FfJD11lgp839OPeaiuA==
X-Google-Smtp-Source: AGHT+IHixNZvTd1oBYeC1L0omPY3qc8N+8St+0d6E5UhyNLz5JpXKDyf0mYQqQ5VSyp3iVdkjAGxTw==
X-Received: by 2002:a17:902:f301:b0:1cc:31a8:d733 with SMTP id
 c1-20020a170902f30100b001cc31a8d733mr20943271ple.44.1699324271844; 
 Mon, 06 Nov 2023 18:31:11 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:11 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/49] target/riscv: add zicntr extension flag for TCG
Date: Tue,  7 Nov 2023 12:29:18 +1000
Message-ID: <20231107022946.1055027-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

zicntr is the Base Counters and Timers extension described in chapter 12
of the unprivileged spec. It describes support for RDCYCLE, RDTIME and
RDINSTRET.

QEMU already implements it in TCG way before it was a discrete
extension.  zicntr is part of the RVA22 profile, so let's add it to QEMU
to make the future profile implementation flag complete. Given than it
represents an already existing feature, default it to 'true' for all
CPUs.

For TCG, we need a way to disable zicntr if the user wants to. This is
done by restricting access to the CYCLE, TIME, and INSTRET counters via
the 'ctr()' predicate when we're about to access them.

Disabling zicntr happens via the command line or if its dependency,
zicsr, happens to be disabled. We'll check for zicsr during realize()
and, in case it's absent, disable zicntr. However, if the user was
explicit about having zicntr support, error out instead of disabling it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231023153927.435083-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/cpu.c         | 12 ++++++++++++
 target/riscv/csr.c         |  4 ++++
 target/riscv/tcg/tcg-cpu.c |  8 ++++++++
 4 files changed, 25 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e7ce977189..73fd4b3231 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -62,6 +62,7 @@ struct RISCVCPUConfig {
     bool ext_zksh;
     bool ext_zkt;
     bool ext_zifencei;
+    bool ext_zicntr;
     bool ext_zicsr;
     bool ext_zicbom;
     bool ext_zicboz;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a2881bfa38..69d64ec4ca 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -80,6 +80,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
+    ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_zifencei),
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
@@ -1208,6 +1209,15 @@ static void riscv_cpu_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
 #endif /* CONFIG_USER_ONLY */
+
+    /*
+     * The timer and performance counters extensions were supported
+     * in QEMU before they were added as discrete extensions in the
+     * ISA. To keep compatibility we'll always default them to 'true'
+     * for all CPUs. Each accelerator will decide what to do when
+     * users disable them.
+     */
+    RISCV_CPU(obj)->cfg.ext_zicntr = true;
 }
 
 typedef struct misa_ext_info {
@@ -1297,6 +1307,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
     MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
 
+    MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
+
     MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
     MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
     MULTI_EXT_CFG_BOOL("zbc", ext_zbc, true),
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f4e0a3962f..4ca96ddd1d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -122,6 +122,10 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
 
     if ((csrno >= CSR_CYCLE && csrno <= CSR_INSTRET) ||
         (csrno >= CSR_CYCLEH && csrno <= CSR_INSTRETH)) {
+        if (!riscv_cpu_cfg(env)->ext_zicntr) {
+            return RISCV_EXCP_ILLEGAL_INST;
+        }
+
         goto skip_ext_pmu_check;
     }
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c5ff03efce..a1e4ed2e24 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -541,6 +541,14 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zksh), true);
     }
 
+    if (cpu->cfg.ext_zicntr && !cpu->cfg.ext_zicsr) {
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicntr))) {
+            error_setg(errp, "zicntr requires zicsr");
+            return;
+        }
+        cpu->cfg.ext_zicntr = false;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.41.0


