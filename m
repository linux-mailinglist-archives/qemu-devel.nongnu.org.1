Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4CA80AC3E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 19:40:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBfkb-0006Ca-GM; Fri, 08 Dec 2023 13:39:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rBfkX-0006Aj-DN
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:38:57 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rBfkT-0008Tv-Lx
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:38:57 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5c66988c2eeso1815498a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 10:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702060731; x=1702665531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPwJtAXApDrIUg5rSZaBlMF2+8X83cxrveamFWPFeEQ=;
 b=mw/skWcyjU2QHDhW+Zu5I9HXjcAmQIa183ljs4arSANOc4bBZ6LH2RjPgxgj7Ukzjp
 HSWiXIFZCpSV280EgpPjhKXpDU0GNGkqykhCs14ripw8IOh5aJb1G/wfzhTvGCITqo4V
 IKT5RC9zJlQDaDoe7L35YAEAZPxa9DG6uH8uuV6iVVzund13RKAmxrq1QJQ0Utlp3r+v
 fIPZzzVC0hh3WJtxXrFwH239HIVL7T6Ky1btQrQPttJhV7/kmHGp8TnBUH6/5QiJTzWJ
 uGGxk7DpcqiG29/mNGoXhZ3BTy2kcSdCFgy8fINQBlEQserHZjsryhJ/LQ9v1NQsTNhO
 0lTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702060731; x=1702665531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hPwJtAXApDrIUg5rSZaBlMF2+8X83cxrveamFWPFeEQ=;
 b=s11pRcckIP+ApbJVUV4J0rSu7HW0YkycWQCBDrOosUn74Axx5mujWSjSVT2+gRnYGO
 EUnN0Dd3YLU98hbNYDBhepGH62w9kccUwgpIS+ZCnFsNw1ln0BopojqS/ojMAlQs0vR2
 A2uBgzB6pg35Jwp2Yyp1NUjg9xgSnI6o00L/HWSsacYdYiK9181GG2amXqZVUF6+PSD5
 kbsFe3UVDwbrTkD7BsS3r6lnqme1lWVxRmoX40QNexm8+zwBYqGYV9/wWqh0Lp23vLdO
 nO9ERp8nunQquQCmdeRPGfrbd8oEpBs9QZyFDDgGmGOsL1OCGXWzoU3D4Iji77Q1AQx6
 5r4w==
X-Gm-Message-State: AOJu0YyWaiRvruPV/pzoA8THUqhzFW+qiqFysSdkDgbGD9Mr31+CNA2O
 CVPzii/g4AoJwc+unZkg/Q8SFOUbCoaFCwqZJMg=
X-Google-Smtp-Source: AGHT+IFrq3IvKskYKVKmZb7oUKn9GHMutoAffayi/XAS1SC4NHCKeQKfaVtSVkDaMn8Ir3Sm9ko/4A==
X-Received: by 2002:a17:90a:3049:b0:286:6cd8:ef12 with SMTP id
 q9-20020a17090a304900b002866cd8ef12mr1714425pjl.42.1702060731515; 
 Fri, 08 Dec 2023 10:38:51 -0800 (PST)
Received: from grind.. ([152.234.124.8]) by smtp.gmail.com with ESMTPSA id
 sk13-20020a17090b2dcd00b002864c14063fsm2190709pjb.20.2023.12.08.10.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 10:38:51 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 3/5] target/riscv/kvm: change timer regs size to u64
Date: Fri,  8 Dec 2023 15:38:33 -0300
Message-ID: <20231208183835.2411523-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208183835.2411523-1-dbarboza@ventanamicro.com>
References: <20231208183835.2411523-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x531.google.com
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

KVM_REG_RISCV_TIMER regs are always u64 according to the KVM API, but at
this moment we'll return u32 regs if we're running a RISCV32 target.

Use the kvm_riscv_reg_id_u64() helper in RISCV_TIMER_REG() to fix it.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 34ed82ebe5..476e5d4b3d 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -88,7 +88,7 @@ static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
 #define RISCV_CSR_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_CSR, \
                  KVM_REG_RISCV_CSR_REG(name))
 
-#define RISCV_TIMER_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_TIMER, \
+#define RISCV_TIMER_REG(name)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_TIMER, \
                  KVM_REG_RISCV_TIMER_REG(name))
 
 #define RISCV_FP_F_REG(idx)  kvm_riscv_reg_id_u32(KVM_REG_RISCV_FP_F, idx)
@@ -111,17 +111,17 @@ static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
         } \
     } while (0)
 
-#define KVM_RISCV_GET_TIMER(cs, env, name, reg) \
+#define KVM_RISCV_GET_TIMER(cs, name, reg) \
     do { \
-        int ret = kvm_get_one_reg(cs, RISCV_TIMER_REG(env, name), &reg); \
+        int ret = kvm_get_one_reg(cs, RISCV_TIMER_REG(name), &reg); \
         if (ret) { \
             abort(); \
         } \
     } while (0)
 
-#define KVM_RISCV_SET_TIMER(cs, env, name, reg) \
+#define KVM_RISCV_SET_TIMER(cs, name, reg) \
     do { \
-        int ret = kvm_set_one_reg(cs, RISCV_TIMER_REG(env, name), &reg); \
+        int ret = kvm_set_one_reg(cs, RISCV_TIMER_REG(name), &reg); \
         if (ret) { \
             abort(); \
         } \
@@ -649,10 +649,10 @@ static void kvm_riscv_get_regs_timer(CPUState *cs)
         return;
     }
 
-    KVM_RISCV_GET_TIMER(cs, env, time, env->kvm_timer_time);
-    KVM_RISCV_GET_TIMER(cs, env, compare, env->kvm_timer_compare);
-    KVM_RISCV_GET_TIMER(cs, env, state, env->kvm_timer_state);
-    KVM_RISCV_GET_TIMER(cs, env, frequency, env->kvm_timer_frequency);
+    KVM_RISCV_GET_TIMER(cs, time, env->kvm_timer_time);
+    KVM_RISCV_GET_TIMER(cs, compare, env->kvm_timer_compare);
+    KVM_RISCV_GET_TIMER(cs, state, env->kvm_timer_state);
+    KVM_RISCV_GET_TIMER(cs, frequency, env->kvm_timer_frequency);
 
     env->kvm_timer_dirty = true;
 }
@@ -666,8 +666,8 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
         return;
     }
 
-    KVM_RISCV_SET_TIMER(cs, env, time, env->kvm_timer_time);
-    KVM_RISCV_SET_TIMER(cs, env, compare, env->kvm_timer_compare);
+    KVM_RISCV_SET_TIMER(cs, time, env->kvm_timer_time);
+    KVM_RISCV_SET_TIMER(cs, compare, env->kvm_timer_compare);
 
     /*
      * To set register of RISCV_TIMER_REG(state) will occur a error from KVM
@@ -676,7 +676,7 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
      * TODO If KVM changes, adapt here.
      */
     if (env->kvm_timer_state) {
-        KVM_RISCV_SET_TIMER(cs, env, state, env->kvm_timer_state);
+        KVM_RISCV_SET_TIMER(cs, state, env->kvm_timer_state);
     }
 
     /*
@@ -685,7 +685,7 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
      * during the migration.
      */
     if (migration_is_running(migrate_get_current()->state)) {
-        KVM_RISCV_GET_TIMER(cs, env, frequency, reg);
+        KVM_RISCV_GET_TIMER(cs, frequency, reg);
         if (reg != env->kvm_timer_frequency) {
             error_report("Dst Hosts timer frequency != Src Hosts");
         }
-- 
2.41.0


