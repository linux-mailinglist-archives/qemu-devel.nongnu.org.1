Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEDD7C6A50
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:02:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqsVR-0007CI-Bx; Thu, 12 Oct 2023 06:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qqsVM-00078I-7J
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:01:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qqsVJ-0006zk-Fi
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:01:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4060b623e64so4516805e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 03:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697104876; x=1697709676;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SYRUUfZD0yW8fyiOdJqWLzmAtXsCBoAuBwPooPofNs=;
 b=tlf1Bb9V685xA20BRANylS0DwOOYw4XbqgUe1d2kSKg0azDsDtF9A78eGn5FNeyZYh
 yVHUFWawZtqRgaI51sTB9UpD4NrpykRFvRpA7CamMJ363byKYsXtHS//l4nljHuHWbMD
 vpkgkXcjneXaLUtomky6lvf6CCbgfyrbQeM57i0xwqVff2mTSIaF/ZQLwWwtp3uTj/wH
 VqwCdn3gblqBy9OkauR2pUO+2QD3D5o7cf/NI0xH6Fw8NuwDmQRKkSR0Vsj/5vBzoUg0
 1+HxAqJvSM0jBUkkFKyH4wpul1JVqHd6PWqRfkTFb1LTcEVo079JuXDLLKZBxV+w8xWe
 5HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697104876; x=1697709676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+SYRUUfZD0yW8fyiOdJqWLzmAtXsCBoAuBwPooPofNs=;
 b=w3e8CY4UVHE0DOZY8SN4/24OP7Y5vQXqfrnBf8fh9Owyz7OQg7AZmAJY0GIS/7A5m8
 c+6Dj3+DZd/rEjJ5oc1OMmUqKYNFeQojBHaTbzzS4tnAZFOS5r9i09I/UVPEuBDLHX4b
 XUcqNd5tslwTrQU8lzmX4VYuwAnVFbtaBO8Tr21YnwfM5u39H/ewMJ0x4vkgIlogd9Fa
 gXWkoWg46sHD8hSqGFkETSjMp3eWehyQzR/YMqIm6n+TkUvjisNf4p2JkLNWI3kAN188
 +y3yZ6sPGIDRJ/liLJ0VcSX9HanqyTxk+uZogG1LXA7JxyHKGVzHp4jVaPcXYdoG0sI2
 DBZQ==
X-Gm-Message-State: AOJu0YxOKJl6zGX+RCxeMGeSuXnPubihWo5vkvl1PXpCm0AbL0tpOG/F
 TU3f9y80o352Q5+E5s+qaE/HRw==
X-Google-Smtp-Source: AGHT+IF7M2GKw9BeeMCDGoF2r5Kuoy40bCiRiPWJYXm3PIf5suV26OfwYAjsD9Ya2AAQdJfqCKfEZw==
X-Received: by 2002:a05:600c:3657:b0:406:44fc:65c9 with SMTP id
 y23-20020a05600c365700b0040644fc65c9mr19138765wmq.8.1697104876023; 
 Thu, 12 Oct 2023 03:01:16 -0700 (PDT)
Received: from localhost.localdomain
 (cpc91760-watf12-2-0-cust235.15-2.cable.virginm.net. [81.111.69.236])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056000024c00b0032d88e370basm3803122wrz.34.2023.10.12.03.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 03:01:15 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 rkanwal@rivosinc.com
Subject: [PATCH v4 4/6] target/riscv: Split interrupt logic from
 riscv_cpu_update_mip.
Date: Thu, 12 Oct 2023 11:01:01 +0100
Message-Id: <20231012100103.28612-5-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012100103.28612-1-rkanwal@rivosinc.com>
References: <20231012100103.28612-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x332.google.com
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


