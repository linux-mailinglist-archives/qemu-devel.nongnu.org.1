Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D03EB712A8F
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:25:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2aDp-0000f9-EM; Fri, 26 May 2023 12:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1q2aDn-0000eW-Kl
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:23:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1q2aDm-0005M5-2s
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:23:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f6d01d390bso10108955e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685118196; x=1687710196; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2nbxyLEKk6fa/UJP4XgVDgMH+wCuN5B2ep72HWVfSmk=;
 b=YOej39fJdmRNnY9S4g2+wOgARxZQFNQtAC0ZHZ9TiHliRfQ9M4CWraSiXYIp+4868z
 hwVvlKrbIVrTBkE8EBpM2Xshzdt+wz0f/F+Zu0BI8A5OMCQYnBscb5niBpPO2obJ9V8O
 KHlayi1D0Bi3W7oPLyadtuLcoILPKqNGVYl9Vwu26PtjlJjvlV2NCv5WsbzgmXrK1SQR
 sPM9gXgfR83GAGLvEkCcxc1VIKRVHMtvhBbyVO85WGHkva6RZBNLcz7/TZLclWRHKi1O
 sQ4J0Y8hEXPEfWQODDqKc0cIA55ydnF/v/PgFg4LwDriNQin5htdwyf8bKYlcgUf95XJ
 Ff8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685118196; x=1687710196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2nbxyLEKk6fa/UJP4XgVDgMH+wCuN5B2ep72HWVfSmk=;
 b=LWyEsQj0rm8IE4i9zsi0eLJWpHwaijvQDd/VZUjGiuMtiG7F91VOPhOg6Pin26Ds+U
 YdW5SZrIReVFFNMBkRtMXTVJn3lRKh/43cprFE/VYIo03Z9x4E0iucfNR5oViaoLbQkE
 vmoSr+lwNdpDw5nOm/A2W+AtL5ACi84zEz8hsiTOzwAlMtvVAsCGFrkgcMUlB8h4EPKt
 9zLaBaoaO4Yt2vBOlBlyqp+vD2+c7xq+mXw6eTfzpQIwOQGm9VsSNVSuwic/2+gUo/Bm
 YCGBCWyYLIZ8WlUYv0bUSH6zmSckG7mj+dIcprhNQGDszs7xSmY/GpOx61i2xyHarCtl
 KWuQ==
X-Gm-Message-State: AC+VfDxEkXdqvvXIQffBaUytdTBNBlnmV/+ePqrZi7Uubtr74HjU5aUH
 BlrAoGefM37/UJ+Pplra+DJOgg==
X-Google-Smtp-Source: ACHHUZ4Jx/NaeK6V86rhwN8IiBMmWdUiUCLDPZV0I77v2+fL94Rb/t5mkHtX6DhwH6qgP42gKCIl1w==
X-Received: by 2002:a05:600c:2297:b0:3f6:2ee:699d with SMTP id
 23-20020a05600c229700b003f602ee699dmr2269595wmf.37.1685118196559; 
 Fri, 26 May 2023 09:23:16 -0700 (PDT)
Received: from localhost.localdomain
 (cpc98982-watf12-2-0-cust57.15-2.cable.virginm.net. [82.26.13.58])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a05600c294b00b003f6129d2e30sm9312090wmd.1.2023.05.26.09.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:23:16 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 rkanwal@rivosinc.com
Subject: [PATCH v2 4/6] target/riscv: Split interrupt logic from
 riscv_cpu_update_mip.
Date: Fri, 26 May 2023 17:23:06 +0100
Message-Id: <20230526162308.22892-5-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230526162308.22892-1-rkanwal@rivosinc.com>
References: <20230526162308.22892-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_helper.c | 25 ++++++++++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

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
index b25ee179e9..c79ec4db76 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -609,11 +609,12 @@ int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
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
@@ -622,15 +623,25 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
 
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
2.25.1


