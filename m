Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B2F7082D6
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:35:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdlO-0006Mo-4B; Thu, 18 May 2023 09:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1pzbyo-0000El-Dk
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:39:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1pzbyl-0002Wq-9X
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:39:34 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f49bf0223cso18663045e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684409969; x=1687001969; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2S4ErOgaYneqPGjObFFVVohgOMNaPVx36RIW3tMfIo=;
 b=PMCKD+FQ3iRO0DYvSpyglrPCRkRd9JX3p22rpm+Q4eYmn6arfMvXeHaXGOBHmK8Kob
 mshIwvosIVhDZOOevrs8771G2AjMzSr5q9EuqdWVskgmmz6gEcp1MAbuV4U/WprvJJvH
 Il5P/ung5znCPPhpdjQBPvgNF75hwCLKFxGKVrKVi8wSCPgNN44oFWhN/cxo1IlZa6de
 hDFgamIxAvEBcrzzh6oJc74jeIF2tvGXhwZC2rKK5FEVhKSQ8DwERq/DYfvb5cmMDX3n
 iWFdfM4jd184cEzNurdMjAKEjkzc/WO6CG2CWFPPtVV4OJUrX3ytFbUnEQfWX+U18adS
 dEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684409969; x=1687001969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2S4ErOgaYneqPGjObFFVVohgOMNaPVx36RIW3tMfIo=;
 b=LRqWRyJPUnc0CqdlTOMxOnSTiv9KmIBUl70Ak6EbHFNxxlm3xSKeRUwCOBzUV4nxU3
 KC/dbKAlzqI4e6cps+4BgwMYiFbpj/+JBGwq9t6WCy/hLOiYfk87HbuPhIC3hP9dasBd
 sksWnlQclQfX8GjryZ7Kj892OT17vAOHBui4XNrwntAqhQT9Tw0+gG05k3FmSq4sLbBA
 AxXqx6OtHphHX5u1dVfRmTWNQz1gdBl+cBaTrWSPDn6Bbzv8r8kzxMkREvmwdVeDL6VN
 QEqiOQ+teVMCMEtr/+ZZeLFXpMlLh6nQtFNVKoDTPdoznnNgfL/TgisTtQPSE+KQsgyb
 Y7Tg==
X-Gm-Message-State: AC+VfDxTzKhXMWVaWtJrNDPASCOYKFACDQLoiAg0VaTS9xGV4K7BvgeQ
 Jcq1Zq0CuO1Cp17BFDjIY4UxIA==
X-Google-Smtp-Source: ACHHUZ5oStCtXfde0F+jSfpbR373w84M7AUF5XlC3tO3zu1Kvkwrioph0GXu9lc4oPwbZs3YCB7LkA==
X-Received: by 2002:a05:600c:210e:b0:3f4:2737:a016 with SMTP id
 u14-20020a05600c210e00b003f42737a016mr1348684wml.29.1684409969215; 
 Thu, 18 May 2023 04:39:29 -0700 (PDT)
Received: from localhost.localdomain
 (cpc98982-watf12-2-0-cust57.15-2.cable.virginm.net. [82.26.13.58])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a1c7406000000b003f4272c2d10sm5083982wmc.1.2023.05.18.04.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:39:28 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH 4/6] target/riscv: Split interrupt logic from
 riscv_cpu_update_mip.
Date: Thu, 18 May 2023 12:38:36 +0100
Message-Id: <20230518113838.130084-5-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518113838.130084-1-rkanwal@rivosinc.com>
References: <20230518113838.130084-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 May 2023 09:33:46 -0400
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
---
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_helper.c | 21 ++++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de7e43126a..de55bfb775 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -562,6 +562,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
 uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
                               uint64_t value);
+void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
 void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
                              void *arg);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c78a2a9514..035437e0fb 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -609,11 +609,10 @@ int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
     }
 }
 
-uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
-                              uint64_t value)
+void riscv_cpu_interrupt(CPURISCVState *env)
 {
+    uint64_t gein, vsgein = 0, vstip = 0;
     CPUState *cs = env_cpu(env);
-    uint64_t gein, vsgein = 0, vstip = 0, old = env->mip;
 
     if (env->virt_enabled) {
         gein = get_field(env->hstatus, HSTATUS_VGEIN);
@@ -624,13 +623,25 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
 
     QEMU_IOTHREAD_LOCK_GUARD();
 
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
2.25.1


