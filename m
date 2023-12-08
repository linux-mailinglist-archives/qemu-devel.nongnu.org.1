Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F063D80AC43
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 19:40:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBfka-0006CM-Gh; Fri, 08 Dec 2023 13:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rBfkT-00069b-Hv
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:38:54 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rBfkQ-0008TH-5a
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:38:53 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5c66418decaso1700083a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 10:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702060728; x=1702665528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g99zgwaBh2/HEzbH/4woDHxTvwBcpq3eb1Kqmu2F8XQ=;
 b=Nahd8Y0vsFfDlKXgC5y6y84nz2PFH0JD+Mx0GAMWWNCg9c725hHJLq5uRV+UadduIU
 HumzL3RhQYtgKc+r4mM08JYCSNwY8tp1SuqbEq3omTqKUydq9p1FGrRxezOwupg7uLeh
 wIwXBN+0g5zQBsZoakNHy9hz7KsjBQrpXTa+XNOIbGW1OaOnRYMOiAvvg2WvPe0jSllv
 sQ+f3UMWjqRIFTrAHicpkfubK00KRZ5vKco7G52Z2/SwxNzuCnnUmDjgtOKDjjGo3cGS
 Ha9S7R0EhrEm/2kcSky3Jeapez+thYBfaRVW4ksjOsoX55puQapqtNR0XJ4R5FJBbpZg
 vVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702060728; x=1702665528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g99zgwaBh2/HEzbH/4woDHxTvwBcpq3eb1Kqmu2F8XQ=;
 b=dfXshQgNKWxKn0fl6fC4Wi8CzfmqWzCV05zAw9rfNtc41p8pq3mk1MBXe068xJIjL9
 1g12Z+MDo2MaMvFDoi49p1xKePzmgmCR3ubD75LLEEo2pkh0HlmSpmb6wfF1vmuqsdPO
 esKjBgtqRj2vJH46Z2690Amhpsd5uizeiMZoO9GNWP9KR9WvnYFeZKY3L1Qf44QlmbIe
 9POuCI0KEhP3sn90Fd71qDspa7vNPa6GyV3BFWrL4BfBNkBGwF9dBcwY14lpa84CjPVN
 k6KPfuV1Yll6dpH3E/K1Na9sjLfhOe3D0IXkIybUSGJUhe4myq0mxc0GPAfJsWP/uts5
 vkWA==
X-Gm-Message-State: AOJu0Yy/5cIet/iMidOXhih6vb7v4hftHtnCusbpPwWWFzyvaJSqTaPx
 LmmGYfsJUU8CchFCMBeixJ553iblSBNKCFNViWY=
X-Google-Smtp-Source: AGHT+IEOtFRdMbkRYMtVlhsVujzhus6SMj+2Uc5PWHpp0Q9c9GMZ7d6AygFqhl+P6SStzc3fYiniUA==
X-Received: by 2002:a17:90b:890:b0:286:6cc0:b90b with SMTP id
 bj16-20020a17090b089000b002866cc0b90bmr432384pjb.66.1702060728312; 
 Fri, 08 Dec 2023 10:38:48 -0800 (PST)
Received: from grind.. ([152.234.124.8]) by smtp.gmail.com with ESMTPSA id
 sk13-20020a17090b2dcd00b002864c14063fsm2190709pjb.20.2023.12.08.10.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 10:38:47 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 2/5] target/riscv/kvm: change KVM_REG_RISCV_FP_D to u64
Date: Fri,  8 Dec 2023 15:38:32 -0300
Message-ID: <20231208183835.2411523-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208183835.2411523-1-dbarboza@ventanamicro.com>
References: <20231208183835.2411523-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x530.google.com
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

KVM_REG_RISCV_FP_D regs are always u64 size. Using kvm_riscv_reg_id() in
RISCV_FP_D_REG() ends up encoding the wrong size if we're running with
TARGET_RISCV32.

Create a new helper that returns a KVM ID with u64 size and use it with
RISCV_FP_D_REG().

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 9bfbc4ac98..34ed82ebe5 100644
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
2.41.0


