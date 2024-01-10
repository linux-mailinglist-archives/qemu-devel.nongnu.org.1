Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D35829578
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 09:59:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUPe-0001PW-6l; Wed, 10 Jan 2024 03:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPb-0001No-6z
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:11 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPZ-0003Qe-K3
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:10 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5cdfed46372so2926073a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877088; x=1705481888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mI2EZpLl3aeKnOvhBM+B+MVkGjLo6WuRuI3uYWA2A8=;
 b=mGKXKlWrOAeq7HxfznHMukF2oONCOknxMe2xBOA1Q7SsQ9BLrfoJU/lZ2RFM/1PacH
 d7kvuugwjuH81CijsGIKdivnGhmXmEXTG5HzRta4PsZQBqMZoCHL0QJ16r+pmiepGCJs
 fetLGfpK4tzfM+6zhNKfJHrgFY57wX/EM7EevuOAeDCffKJaa17SHiy4R2uOSnOZNqgO
 FSx+H3PEdZT6AaKHLNZNXlY+1829A4YNucxGF0qgUHQrFASHrUq32Qz43zAiz5Q31m3U
 9pVymbnL5SKSk7MzEcZiKo2O8p/Fr/i8wLI0ZWUCSajlrDYRJmAoLE12ie3DgGJecbgr
 PXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877088; x=1705481888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mI2EZpLl3aeKnOvhBM+B+MVkGjLo6WuRuI3uYWA2A8=;
 b=u3w+VPQ/1oNXsV5/qLcnNSUs6s29SEtzT0sgTmfQ3lC00Gevb6Ims2zZUp7TTLY6ts
 KCPDGjxytk4EM7tjMI+BBvlIh2LBT46rzoI2kD/i6J4BSR6JWtfksqybrAOAcyatx41Q
 ikjnrzoeUmadjVzVGUZYeaS5NezyC1qjLE/VNEjSt+x6JHy18gI2IBo+YdSsi3e54ZjH
 qDVaaVvDboXPxTsWhZBx2+HZ6/VM7TYSdOBn6ZRKYy1cXrRerMn8sh7aM6QquVHtfRKl
 llVokzh/+t5LGyyN0ydEkUeGRBau2qkoa0iceiR0k4g0paPh5+2FqR7QkCvTVfLq4wYJ
 LfXw==
X-Gm-Message-State: AOJu0Ywfw4z/2Vr5FrPCvy9wfDQjWkA/OpVHb2OWTKROzsSfbL1xInuk
 3n7NRW/L6ofxUvXZrIPNOpTHrhNVqL8gM7TQ
X-Google-Smtp-Source: AGHT+IFnUZUJsV3W3MVt8lK0fwLs9WFgwFDqGVJptJpvJQSSbXkib4rq1IahHsNKNZ1DdygRaAiBBw==
X-Received: by 2002:a05:6a20:914e:b0:19a:2f3f:88b7 with SMTP id
 x14-20020a056a20914e00b0019a2f3f88b7mr190350pzc.80.1704877087932; 
 Wed, 10 Jan 2024 00:58:07 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:58:07 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/65] target/riscv/kvm: change KVM_REG_RISCV_FP_F to u32
Date: Wed, 10 Jan 2024 18:56:35 +1000
Message-ID: <20240110085733.1607526-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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

KVM_REG_RISCV_FP_F regs have u32 size according to the API, but by using
kvm_riscv_reg_id() in RISCV_FP_F_REG() we're returning u64 sizes when
running with TARGET_RISCV64. The most likely reason why no one noticed
this is because we're not implementing kvm_cpu_synchronize_state() in
RISC-V yet.

Create a new helper that returns a KVM ID with u32 size and use it in
RISCV_FP_F_REG().

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231208183835.2411523-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 117e33cf90..375c8e7f33 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -72,6 +72,11 @@ static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
     return id;
 }
 
+static uint64_t kvm_riscv_reg_id_u32(uint64_t type, uint64_t idx)
+{
+    return KVM_REG_RISCV | KVM_REG_SIZE_U32 | type | idx;
+}
+
 #define RISCV_CORE_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_CORE, \
                  KVM_REG_RISCV_CORE_REG(name))
 
@@ -81,7 +86,7 @@ static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
 #define RISCV_TIMER_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_TIMER, \
                  KVM_REG_RISCV_TIMER_REG(name))
 
-#define RISCV_FP_F_REG(env, idx)  kvm_riscv_reg_id(env, KVM_REG_RISCV_FP_F, idx)
+#define RISCV_FP_F_REG(idx)  kvm_riscv_reg_id_u32(KVM_REG_RISCV_FP_F, idx)
 
 #define RISCV_FP_D_REG(env, idx)  kvm_riscv_reg_id(env, KVM_REG_RISCV_FP_D, idx)
 
@@ -586,7 +591,7 @@ static int kvm_riscv_get_regs_fp(CPUState *cs)
     if (riscv_has_ext(env, RVF)) {
         uint32_t reg;
         for (i = 0; i < 32; i++) {
-            ret = kvm_get_one_reg(cs, RISCV_FP_F_REG(env, i), &reg);
+            ret = kvm_get_one_reg(cs, RISCV_FP_F_REG(i), &reg);
             if (ret) {
                 return ret;
             }
@@ -620,7 +625,7 @@ static int kvm_riscv_put_regs_fp(CPUState *cs)
         uint32_t reg;
         for (i = 0; i < 32; i++) {
             reg = env->fpr[i];
-            ret = kvm_set_one_reg(cs, RISCV_FP_F_REG(env, i), &reg);
+            ret = kvm_set_one_reg(cs, RISCV_FP_F_REG(i), &reg);
             if (ret) {
                 return ret;
             }
-- 
2.43.0


