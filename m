Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4DC7C55D0
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:46:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZXe-0004Eo-KF; Wed, 11 Oct 2023 09:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qqZWc-0003rd-Ry
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:45:23 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qqZWP-0001W3-K4
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:45:22 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so6209196f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697031907; x=1697636707;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgjYiWrRAnOVB1lMpMitgXOQmvnNlVuniYuwRkkmmR0=;
 b=pIaKtiUD7yPkXdc3NiSNGTWRaZHDX+mx8YqvJt5e4PPMSCg1FBGd68/dRxJz6LxNfh
 4FHMNJ1KEajtfMdjVgO6apafqv0QiHa6XtarHra5a+VsmVXgnJlpurCqT3kgp514FZIg
 rYN+4d4IOt8YMhLMwIXwG5i4Pwlk3JjI+cipelQzKjFbB6jA1eCIJzCJ3RgrDQPuY/5S
 FqpwNFIw7U+mzda1iisSJQvd4ApPhPmfj2lXAkoUWNG/scFL3ie+ykO/sphof2SjiENx
 MxL2JG/ngpbNOoAVjlJSslPjGJ2smajHi6xxLAjptTSVOPdcf8Haow79f2IDlc9tGMqU
 /BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697031907; x=1697636707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QgjYiWrRAnOVB1lMpMitgXOQmvnNlVuniYuwRkkmmR0=;
 b=hCryHk8v58azqDl/zIBA5kS1Vii2FKf0UKNZeBjq4wzf79LD096tU9MY/TSExwaTXj
 Zgux86BdyDQr5XifnKPrFztcTAzKdbaiCQcCC8DCyE2bqnBtPa1DlDKdpQb5OjCcmLQr
 BC8ORlTnEzucnvswA5VzSRwcZ+TwrE0OvTvPFZ8rRwJvPh5wy59b2EZdivGg7+N8wdtK
 ML0iwTCpu5LJQjzmo7qqiYpeJe+UWtCK36KQt2aKfqIYM9jfHOkRnJTcvHhWoFH6epD6
 3OASPfa5Z1orYQ0hEWFinEptxtKBZMFsV/r0MZ8GAPV+50xcu/ixM5qzv4TkeMpoIiAU
 dH3A==
X-Gm-Message-State: AOJu0YxENvDRrnrcIIIRA9zgP2+JjjXJ26IXL75kd4JgRivG1T/SKyPz
 q2MQkZJY+y7nxqYhSk6Tk5D94g==
X-Google-Smtp-Source: AGHT+IErv32X2+DeHfFm0P+f3XW9YdrseUACH3rElgboZNsA39qLSxwmky5St8ea4wgrS5udKfcjVg==
X-Received: by 2002:a5d:4c50:0:b0:31c:8880:5d0f with SMTP id
 n16-20020a5d4c50000000b0031c88805d0fmr17824917wrt.11.1697031907317; 
 Wed, 11 Oct 2023 06:45:07 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.ba.rivosinc.com
 (cpc91760-watf12-2-0-cust235.15-2.cable.virginm.net. [81.111.69.236])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a5d4f10000000b00324ae863ac1sm15583141wru.35.2023.10.11.06.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 06:45:06 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 rkanwal@rivosinc.com
Subject: [PATCH v3 4/6] target/riscv: Split interrupt logic from
 riscv_cpu_update_mip.
Date: Wed, 11 Oct 2023 14:44:48 +0100
Message-Id: <20231011134450.117629-5-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011134450.117629-1-rkanwal@rivosinc.com>
References: <20231011134450.117629-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This is to allow virtual interrupts to be inserted into S and VS
modes. Given virtual interrupts will be maintained in separate
mvip and hvip CSRs, riscv_cpu_update_mip will no longer be in the
path and interrupts need to be triggered for these cases from
rmw_hvip64 and rmw_mvip64 functions.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_helper.c | 25 ++++++++++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ef9cf21c0c..7092aeb7f0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -460,6 +460,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
 uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
                               uint64_t value);
+void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
 void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
                              void *arg);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8ffb31b607..a182336cd2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -621,11 +621,12 @@ int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
     }
 }
 
-uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
-                              uint64_t value)
+void riscv_cpu_interrupt(CPURISCVState *env)
 {
+    uint64_t gein, vsgein = 0, vstip = 0;
     CPUState *cs = env_cpu(env);
-    uint64_t gein, vsgein = 0, vstip = 0, old = env->mip;
+
+    QEMU_IOTHREAD_LOCK_GUARD();
 
     if (env->virt_enabled) {
         gein = get_field(env->hstatus, HSTATUS_VGEIN);
@@ -634,15 +635,25 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
 
     vstip = env->vstime_irq ? MIP_VSTIP : 0;
 
-    QEMU_IOTHREAD_LOCK_GUARD();
-
-    env->mip = (env->mip & ~mask) | (value & mask);
-
     if (env->mip | vsgein | vstip) {
         cpu_interrupt(cs, CPU_INTERRUPT_HARD);
     } else {
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
+}
+
+uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
+{
+    uint64_t old = env->mip;
+
+    /* No need to update mip for VSTIP */
+    mask = ((mask == MIP_VSTIP) && env->vstime_irq) ? 0 : mask;
+
+    QEMU_IOTHREAD_LOCK_GUARD();
+
+    env->mip = (env->mip & ~mask) | (value & mask);
+
+    riscv_cpu_interrupt(env);
 
     return old;
 }
-- 
2.34.1


