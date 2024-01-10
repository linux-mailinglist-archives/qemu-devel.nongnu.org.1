Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A24BB82957C
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 09:59:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUPi-0001QD-7K; Wed, 10 Jan 2024 03:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPg-0001Q1-4d
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:16 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPe-0003SM-4o
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:15 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d9bec20980so2059330b3a.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877092; x=1705481892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5ZPOEp/Bgg3nxSrbT4RIPE8g35MEWBNgL4Nz/T7n2g=;
 b=NiXf905RaANO+SJCFZqzQzXL+/+FVZfk/jquWwWcaPnV9tMR3nkIeMxTVfc7d1opQH
 Nhh6IXs5yGYdzlyYBz9mUuE8W0srqdJAf1sjVR14OZGFkC2zP2lUAeQWcMJjRfwawg1N
 cB7ju2Cnt1akPE3KBLKESio6zYQp0r/WwZY4unIAa/NMjcN+b63HXRWmYd8zFmKrmpgI
 l5u0VD0wFSsMT+U/FFsfbHSozYvvn7LgWpoLeDjkV/3fHc29ihESgc1OAgU7CaJ1vB4O
 HQIvmUxZdgaSraJQ5jZM34zWIW2N/iFmMfh4+1nbYf9K6SII2D0fUMuI1GnAnhqOmUsC
 b7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877092; x=1705481892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5ZPOEp/Bgg3nxSrbT4RIPE8g35MEWBNgL4Nz/T7n2g=;
 b=PzHd1W44dXP1pCeo+IoJ9+pz21knM4MPj1Qp+1U5JUtxYhm17ZRNWf09YpdAxcVzez
 l5n7fSAtKn/uci6AlYDzH6tGvSDvWysCPP8sPwbd28VHrTbqXAxB9MayG4g4eJl6h6v+
 UdMbChFBQJ/HUs1b/Jc8ldxnf1RmYHbUUVr0hCZ7Wjigs1p6Cf7UlbOUNy8DaQ1okR90
 VeL0eSI0XCWLZ7sXQ/Y1nIjWlmA6P0gEflgSlYBt45Ye/0J6Riw6uywPUYdY20zBkO0A
 82qcoGrZX46qZR13WVtPIr/Ibkh+YpxncIAradGTEYoqtDwKZUqDCkjFJA8CXdseY5ls
 Ihzg==
X-Gm-Message-State: AOJu0YznZgWlwq2DY3f6MF2Uk5MtQ+ls8uWzX2wKWQCJZtf0s9JBHA8r
 kCezbVgVpTFRKHqU4/NbEFwauBkRR91kNRSR
X-Google-Smtp-Source: AGHT+IFGAyfi/CH1TCePImlVKOxhd8huavaQENEMb+hGD8hl93yrGvcvqDODWeNUZqljdMxwk4sY1Q==
X-Received: by 2002:a05:6a00:2e92:b0:6da:4d92:a098 with SMTP id
 fd18-20020a056a002e9200b006da4d92a098mr745241pfb.0.1704877091834; 
 Wed, 10 Jan 2024 00:58:11 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:58:11 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/65] target/riscv/kvm: change KVM_REG_RISCV_FP_D to u64
Date: Wed, 10 Jan 2024 18:56:36 +1000
Message-ID: <20240110085733.1607526-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

KVM_REG_RISCV_FP_D regs are always u64 size. Using kvm_riscv_reg_id() in
RISCV_FP_D_REG() ends up encoding the wrong size if we're running with
TARGET_RISCV32.

Create a new helper that returns a KVM ID with u64 size and use it with
RISCV_FP_D_REG().

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231208183835.2411523-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 375c8e7f33..9370c72f9b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -77,6 +77,11 @@ static uint64_t kvm_riscv_reg_id_u32(uint64_t type, uint64_t idx)
     return KVM_REG_RISCV | KVM_REG_SIZE_U32 | type | idx;
 }
 
+static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
+{
+    return KVM_REG_RISCV | KVM_REG_SIZE_U64 | type | idx;
+}
+
 #define RISCV_CORE_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_CORE, \
                  KVM_REG_RISCV_CORE_REG(name))
 
@@ -88,7 +93,7 @@ static uint64_t kvm_riscv_reg_id_u32(uint64_t type, uint64_t idx)
 
 #define RISCV_FP_F_REG(idx)  kvm_riscv_reg_id_u32(KVM_REG_RISCV_FP_F, idx)
 
-#define RISCV_FP_D_REG(env, idx)  kvm_riscv_reg_id(env, KVM_REG_RISCV_FP_D, idx)
+#define RISCV_FP_D_REG(idx)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_FP_D, idx)
 
 #define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
     do { \
@@ -579,7 +584,7 @@ static int kvm_riscv_get_regs_fp(CPUState *cs)
     if (riscv_has_ext(env, RVD)) {
         uint64_t reg;
         for (i = 0; i < 32; i++) {
-            ret = kvm_get_one_reg(cs, RISCV_FP_D_REG(env, i), &reg);
+            ret = kvm_get_one_reg(cs, RISCV_FP_D_REG(i), &reg);
             if (ret) {
                 return ret;
             }
@@ -613,7 +618,7 @@ static int kvm_riscv_put_regs_fp(CPUState *cs)
         uint64_t reg;
         for (i = 0; i < 32; i++) {
             reg = env->fpr[i];
-            ret = kvm_set_one_reg(cs, RISCV_FP_D_REG(env, i), &reg);
+            ret = kvm_set_one_reg(cs, RISCV_FP_D_REG(i), &reg);
             if (ret) {
                 return ret;
             }
-- 
2.43.0


