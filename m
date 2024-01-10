Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1986829588
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:00:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUPv-0001Y0-Iz; Wed, 10 Jan 2024 03:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPr-0001XY-QT
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:27 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPk-0003TH-2C
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:26 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9b51093a0so3296854b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877096; x=1705481896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yMicriNP9FRxv1gu/4gdBxKprzQt1ebDJy/63beWZc=;
 b=MyRYMJjLpkEynsFj7Sa87OZgKhY0kMX1Qp/uB5hFoyTOFRv2WVW3qSNrrtsyuC5tBz
 V3twqfSeloZKmcxsX5pb9mKobl6GP0pJorlgSRSgLwpBPj0B7QFR4zb99NiOibO95Y5A
 QCyDWKvWiE/f35gdorKxlMYer4CZZjr2hV+XN/CxoeUiQGuAm0UhSA3Egf39scCqk2xf
 yABg67xNjlZVQmq6Ip8NvBg2x1czxPpViQho2hknntNMgdDYBVdZKWdXlwR0JAsHs3z4
 19jC0PY4gMhYZ9dREbJunD2RzqwsGrCGj1xvnSUvOMOZ4E2HftEk62f1eMFhv9LK3mXo
 wLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877096; x=1705481896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+yMicriNP9FRxv1gu/4gdBxKprzQt1ebDJy/63beWZc=;
 b=LIcM2ynqVMvimknEwedSlGQWxraXSxFFk/bQu+B494FKsXkHGYuhaQMXOXY4+TcAFN
 5C8iZWwSrNWyBIF5+MsNQz87lhzIRrxWnTFa3zqwDM0ZbXJM+wM9BfKpKP1j7RvlHK/E
 da+ED9TdnK326VcKK1PITgOP8vtzL5HkBFA/sRxE79Zk5+XoF3Cb/HSMAlyU50IOrbSu
 NHCoO2J9ObZKMWBqsSOvb7lvU48HlMdgiGBMdAzy8pV/66jw2mPvU1JDdrATo6MgbugM
 0cfpkUjaCkO9P/fnHrSRtnfZHxNCzv2N63CQii0v5rYOs5WDZ5CyIcRKNOf9l4y8p8P+
 psPA==
X-Gm-Message-State: AOJu0Yy8rYa9QaPM/t+lfyN4dSA8CYZPOctxqBOp0Sj2EZiffk8itZm/
 dbd7MYZrhIIYSuDD3M5cnmYgmiPKT0mOc40j
X-Google-Smtp-Source: AGHT+IH4yl0D5EtW6Y5ogt8P/0TXti7/sFTsly4JxPnI11xRYmtgOrCzKHdVP+kbgyMfO1KCRgy+IA==
X-Received: by 2002:a05:6a00:d66:b0:6d9:b320:94c9 with SMTP id
 n38-20020a056a000d6600b006d9b32094c9mr737704pfv.33.1704877095415; 
 Wed, 10 Jan 2024 00:58:15 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:58:14 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/65] target/riscv/kvm: change timer regs size to u64
Date: Wed, 10 Jan 2024 18:56:37 +1000
Message-ID: <20240110085733.1607526-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

KVM_REG_RISCV_TIMER regs are always u64 according to the KVM API, but at
this moment we'll return u32 regs if we're running a RISCV32 target.

Use the kvm_riscv_reg_id_u64() helper in RISCV_TIMER_REG() to fix it.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231208183835.2411523-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 9370c72f9b..b7871b2f8f 100644
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
2.43.0


