Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EBA80AC47
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 19:40:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBfkZ-0006BF-UE; Fri, 08 Dec 2023 13:38:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rBfkQ-00069F-Cf
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:38:51 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rBfkN-0008Sr-Dg
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:38:49 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5c66418decaso1700061a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 10:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702060725; x=1702665525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AuGWTzZ9lGLSBA940/xkiCPkW9T/I5CIydcq77Q1d74=;
 b=KUw0OvjkbauvZ6CLuTtZRAcK5xfzERdCboFYd9wELTZ+KhF59/qZZdf0qJN6XLeV2E
 s5c7kVjsrt2mGmn4Y8kYW1H1KpiAe5V5uM3xBfjjX+M5WW0C8Uy0yoHep71u86imQ0u7
 SrD6lZLcRrCvrtEKX+a2C1h0xwieLsnWfo4bhoEEWzLeRekRbrL0vuUpeExN8xMNTK+3
 zIhaVuv45JdHrqc0EAkZTpaw1dgYFQJ3xV8+T/1jPwNOv3d8LWDhAvHn+EvZVfQ6JEqN
 Y+LoIA4Fwrkj5Yxj0bbUtFT2im/lIMnr0cILcRICbYowjytGOJm1s8Ze1/4jNi5Z9K+z
 bjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702060725; x=1702665525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AuGWTzZ9lGLSBA940/xkiCPkW9T/I5CIydcq77Q1d74=;
 b=OiLhIKDR7bO7iee+phI5PEeVGRonmr9zctgKDBGRG0Ygnzq3Q31MkvZYO6oBbCcRed
 98cuNDvjAACcVR85mnwtGMk6JkY2HLxDUXiGzenzqlfDtbI26a94cznnTfR+4QPKHyuz
 QGbhpQy06uOUKIktAvSzfjsGTErMP8xx2eNYbBArG1TUiwAQQZeKK8qhcEhfNGnfoTLy
 ioeYY7y56+ZGLibNP4iom8DVRNFR0K4sXqwEqBmUNk8LU01YJiI4wW4K+uZq+VvOaszf
 q3Zga61p4TlcoVZ0oFmrfhcVNigIkxYg0rpxJ4z/ZtLIDzEsEn47KQKKRc4XzxCZLVZz
 /nYA==
X-Gm-Message-State: AOJu0YyPcb5FVzN6k3JTW740JrkeXeXRs+mL7RQerjEkUruuzFqv6ZHj
 wYrTzJ+TgC2KWTAKNbsWo7+3Ak4Rd1obreXfBEY=
X-Google-Smtp-Source: AGHT+IGdVpXA0hlOtd7TGFa+vSPyRm7AheFjWwNpYhmjpKNSV2jZHicDPkkHQcRvH4ZCBtmPtEG5LQ==
X-Received: by 2002:a05:6a20:4caa:b0:18f:97c:5b95 with SMTP id
 fq42-20020a056a204caa00b0018f097c5b95mr307352pzb.99.1702060725281; 
 Fri, 08 Dec 2023 10:38:45 -0800 (PST)
Received: from grind.. ([152.234.124.8]) by smtp.gmail.com with ESMTPSA id
 sk13-20020a17090b2dcd00b002864c14063fsm2190709pjb.20.2023.12.08.10.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 10:38:44 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 1/5] target/riscv/kvm: change KVM_REG_RISCV_FP_F to u32
Date: Fri,  8 Dec 2023 15:38:31 -0300
Message-ID: <20231208183835.2411523-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208183835.2411523-1-dbarboza@ventanamicro.com>
References: <20231208183835.2411523-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52e.google.com
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

KVM_REG_RISCV_FP_F regs have u32 size according to the API, but by using
kvm_riscv_reg_id() in RISCV_FP_F_REG() we're returning u64 sizes when
running with TARGET_RISCV64. The most likely reason why no one noticed
this is because we're not implementing kvm_cpu_synchronize_state() in
RISC-V yet.

Create a new helper that returns a KVM ID with u32 size and use it in
RISCV_FP_F_REG().

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 45b6cf1cfa..9bfbc4ac98 100644
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
2.41.0


