Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0567CA690
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 13:19:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsLbo-0002bk-5r; Mon, 16 Oct 2023 07:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qsLbj-0002bO-Ln
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:17:59 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qsLbb-0005bc-FJ
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:17:59 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32799639a2aso3961280f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697455065; x=1698059865;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SYRUUfZD0yW8fyiOdJqWLzmAtXsCBoAuBwPooPofNs=;
 b=b2miz+NFXLcI6R6jpYdZFF8Uv4b5bGGHAxJbg8rqvUDpF3XS+o6dvb090R3q0rTZ7k
 qdjT4T55PazkLi15UvSXqMN6Fgcq7tsw5FQHo89uxBrfmntkFFWDhA6Fn4vNG3vBiWzJ
 GbMKnUS22haK+8DZcJW4BjM4NyGXJFCE/zr/EPVCHezxDwLS/5SApVmMFOtpySom81Zm
 jryEQ0iyTP1TFkhRJ8ODTXddEaTeZP2dIXKlE7BCXHjBXUuVWNEPLk/kiBCnU3r8n28M
 3hmRSd59qJsYUgpTypM0DHfNF2Rnk6hlpvfyfjbHSNKDz0RRYwAAJITqTF6jrQy6SGt4
 Q9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697455065; x=1698059865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+SYRUUfZD0yW8fyiOdJqWLzmAtXsCBoAuBwPooPofNs=;
 b=tpESU3ToamCedfrAUBKU0n7aldvpHqbil0NkKedY6GyFp0FTnkXjFFeMJ5gDGe+VX7
 k5GAgS71o3USJCheQS/WIoi+4NNddExUw+B5qsgkDVBehg55JPj1tMvgVv1qlH4nmZGQ
 nezfz9wBMM1mR+2dJMqDgrXI0ff3Io62M0v5LQM0ED0qzKup0Fo9eA+qlyS5BEoECJIc
 mgFBGZEhH9YxMtG1L467YUjxs8yc/VPtz8Fr6TDpQ4TQu8dXAz5fweO+mn7tNMENKdXW
 oLWbUCiKP7L/uTKjgQp/p4Deji/H21ryLWTWPXCILIRz7TRpcL7fBhP3sSTqaYc6YUUB
 /pWg==
X-Gm-Message-State: AOJu0YzO399fHWRJpGkMbHazXRh9bXb/CssYAYy/2amTHx216Kh9f5sJ
 Vjm4CywUrLTKgIsCe9KK7XMAVw==
X-Google-Smtp-Source: AGHT+IGETa2xr2qjsPg/C9znX15emz3SW8P1/CEl8ZE7FsZvHa0mVVWxLcx9ujjOrQ/twD/NLmDXKA==
X-Received: by 2002:a5d:4e8b:0:b0:32d:a688:8813 with SMTP id
 e11-20020a5d4e8b000000b0032da6888813mr4006683wru.32.1697455064974; 
 Mon, 16 Oct 2023 04:17:44 -0700 (PDT)
Received: from localhost.localdomain
 (cpc91760-watf12-2-0-cust235.15-2.cable.virginm.net. [81.111.69.236])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a056000010f00b0032daf848f68sm3114299wrx.59.2023.10.16.04.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 04:17:44 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 rkanwal@rivosinc.com
Subject: [PATCH v5 4/6] target/riscv: Split interrupt logic from
 riscv_cpu_update_mip.
Date: Mon, 16 Oct 2023 12:17:34 +0100
Message-Id: <20231016111736.28721-5-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016111736.28721-1-rkanwal@rivosinc.com>
References: <20231016111736.28721-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index f8ffa5ee38..6fe32e6b38 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -463,6 +463,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
 uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
                               uint64_t value);
+void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
 void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
                              void *arg);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index aaeb1d0d5c..581b8c6380 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -620,11 +620,12 @@ int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
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
@@ -633,15 +634,25 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
 
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


