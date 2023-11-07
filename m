Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A057E3307
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:34:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BrM-0002cL-Jn; Mon, 06 Nov 2023 21:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BrH-0002bG-W1
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:28 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BrG-0002Qk-FC
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:27 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc3bc5df96so37209685ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324223; x=1699929023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Cxgq+z4H6+MtdHdsVhNB5iBvxhwxRKMsjaHMjb2zVc=;
 b=G41O2BGM/e3s2dqaOyX1mn5SIAeVYAN5Yph+TfN2g0dyJfhIgu3jytKHYdIRCRZ/HE
 9hPl4sRfgWlGqMmgM2K8xG1KUpxogXt7t1he8VDZmV5Cqzkoh5kmUP+/OvPnxYYjrWAi
 /o8OCj+YdrNyy5lsO3nt5Yt9DA+DJMXJvOTE3ki1hKU3AHeuK3db3dYdx/+WMTlpPpFp
 6L2o9GtgurluziIONflFUZ9i1UWh1SWA55NijY9/+5InlP8bz/RXG8S9lLdHghYwo8xy
 Lyvd7xtcxS1oprSUCdyFExU7jl3uNeZNI5P6z1b11SR0ykUJ7iT+zVEEkZp6b9vwbEvI
 Sjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324223; x=1699929023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Cxgq+z4H6+MtdHdsVhNB5iBvxhwxRKMsjaHMjb2zVc=;
 b=jwSh5FHRD5DrR3YSJ5OkKeZ7DKBoD20GgT6tXiVJyor4en/JNvcG/ld7rX2Tka9rhw
 M+EzMk7yQbro3qkKiyXftLbguT+Sypk0275aSfUMHgJ721+lwxX0f7e40D8ig/YfeGPR
 5iSx1xGxQBWLdREpusgP1X87G/ShYtzB5/F2XYijZ+2J17gDS2t2XipE98KKlFMobS5r
 bwdaHHslRm0a+jr5QtBcvGOiOaLKvdg/GZCY3g7K0eGpebh1lPT67rDjzyy3JRAS4ZhJ
 O4bqRtWoEU9ljG032CkjQ0JJJQy5L4J9mUGWkxaEAmFEmhvBatJ5THY9ohzKr9oRzCN2
 BwSA==
X-Gm-Message-State: AOJu0Yz3Bg0rs7s2fCD+KMQqL6OBfsQVJeHk57f5uW88bQibdd/+BrBE
 SWwa7asVorsngQS9/IpMwzJ1eJQe0EdD8g==
X-Google-Smtp-Source: AGHT+IEWZcDJytByY5xlP3+DI0TgNxmSwluBP4fXmeiLgUsAH2mpxYR7NbG009qPwwxoCuwXzyuZjg==
X-Received: by 2002:a17:902:e744:b0:1cc:6cc3:d9fa with SMTP id
 p4-20020a170902e74400b001cc6cc3d9famr19392955plf.67.1699324223423; 
 Mon, 06 Nov 2023 18:30:23 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:22 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/49] target/riscv: Split interrupt logic from
 riscv_cpu_update_mip.
Date: Tue,  7 Nov 2023 12:29:04 +1000
Message-ID: <20231107022946.1055027-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

This is to allow virtual interrupts to be inserted into S and VS
modes. Given virtual interrupts will be maintained in separate
mvip and hvip CSRs, riscv_cpu_update_mip will no longer be in the
path and interrupts need to be triggered for these cases from
rmw_hvip64 and rmw_mvip64 functions.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231016111736.28721-5-rkanwal@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.41.0


