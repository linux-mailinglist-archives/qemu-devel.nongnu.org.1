Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 057757F5C07
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:14:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66iV-0007YU-Jw; Thu, 23 Nov 2023 05:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r66iS-0007Xn-Va
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:13:48 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r66iQ-0000fI-6S
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:13:47 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b6a837a2e1so438212b6e.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 02:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700734424; x=1701339224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TBb8nbzEKb8jgIQUZRuFfiQuRX/arJLmU3ecrGkf2gw=;
 b=OAJkLAD2PErcxHuoOk9a/A8Ve8ntfgkHiklbeP43uUXeFqcAC9Trs0+FT3BdDTOduQ
 ORBgeFPYZIG2DkzfXLTfF6Jd6Oo1AqrqrIhDlrSz3/Jy1DNDeO6daHzQIjD+qJ528qZv
 AhDg0lIDhWMcRhZbJGEIlT2xFTxc8NHw8zsBXSsdKOa+6zUw2hg6t6U5QMQmJz+FM2+3
 JwDf+8sng71ncWrxKJvvyd5lVcj01TdJDEpz/4UIdmAZ5ilw2W2N/moykGk7gp/DjH1g
 IaCgMqcIM6JrcnZaaaFOibK5r6Uetzd9dLm+5hH+5TuDPzw2XXk0Z7WdubCkXUYEfhEL
 yubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700734424; x=1701339224;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TBb8nbzEKb8jgIQUZRuFfiQuRX/arJLmU3ecrGkf2gw=;
 b=EZ/YDfX0YyfoZaeCDofQk4zdbvah0UqNaLzO3wi8A/l5czYzVjvm8X3xXBBp2n8sB1
 gZytUJAv8g7jPxQjsJyPq4M2fMrKRabqJFZeiV7aVNK7c09lsyib6Rnk3M3te9AyBzWN
 8NhXSY+O3NsI3c+85Y//JFpM6ASQaqkTDspRRHhWS1efIZ/YDqeqzYhvqbY4ygzntPwd
 BIEctR5eis+aGMW6lkVRGdrjaTSdbYuUfenGhwByWGnYtTa6Lsz0tCUdoWH2hsr/IQN3
 XM+BJ+2YossOq7kmz364EounS+KzEvPF7IWd6Y1pn4qCtVSiohPRak8PRBVrsuaumVFL
 8bNw==
X-Gm-Message-State: AOJu0YzQZ5GN03KvPxtfMY+kYUBAuP+kO5lPt1ntpYTLqdYmMX3GlPb/
 4GAL4zTs48qjo8sGr5Y1fM5re0BqiHvAypbgIws=
X-Google-Smtp-Source: AGHT+IHJ/eo4vMr93VkSHqzLzvKMb6PB24N/ldpk8bJjH5ZfVzdVvwwWYC3vl31xx1f1v1HPzLACUw==
X-Received: by 2002:a05:6808:191e:b0:3b8:4cec:de9b with SMTP id
 bf30-20020a056808191e00b003b84cecde9bmr1055542oib.3.1700734424319; 
 Thu, 23 Nov 2023 02:13:44 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.250.131.119])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a631e0d000000b0057c44503835sm970665pge.65.2023.11.23.02.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 02:13:43 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2] target/riscv/kvm: fix shadowing in
 kvm_riscv_(get|put)_regs_csr
Date: Thu, 23 Nov 2023 07:13:38 -0300
Message-ID: <20231123101338.1040134-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

KVM_RISCV_GET_CSR() and KVM_RISCV_SET_CSR() use an 'int ret' variable
that is used to do an early 'return' if ret > 0. Both are being called
in functions that are also declaring a 'ret' integer, initialized with
'0', and this integer is used as return of the function.

The result is that the compiler is less than pleased and is pointing
shadowing errors:

../target/riscv/kvm/kvm-cpu.c: In function 'kvm_riscv_get_regs_csr':
../target/riscv/kvm/kvm-cpu.c:90:13: error: declaration of 'ret' shadows a previous local [-Werror=shadow=compatible-local]
   90 |         int ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
      |             ^~~
../target/riscv/kvm/kvm-cpu.c:539:5: note: in expansion of macro 'KVM_RISCV_GET_CSR'
  539 |     KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
      |     ^~~~~~~~~~~~~~~~~
../target/riscv/kvm/kvm-cpu.c:536:9: note: shadowed declaration is here
  536 |     int ret = 0;
      |         ^~~

../target/riscv/kvm/kvm-cpu.c: In function 'kvm_riscv_put_regs_csr':
../target/riscv/kvm/kvm-cpu.c:98:13: error: declaration of 'ret' shadows a previous local [-Werror=shadow=compatible-local]
   98 |         int ret = kvm_set_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
      |             ^~~
../target/riscv/kvm/kvm-cpu.c:556:5: note: in expansion of macro 'KVM_RISCV_SET_CSR'
  556 |     KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
      |     ^~~~~~~~~~~~~~~~~
../target/riscv/kvm/kvm-cpu.c:553:9: note: shadowed declaration is here
  553 |     int ret = 0;
      |         ^~~

The macros are doing early returns for non-zero returns and the local
'ret' variable for both functions is used just to do 'return 0', so
remove them from kvm_riscv_get_regs_csr() and kvm_riscv_put_regs_csr()
and do a straight 'return 0' in the end.

For good measure let's also rename the 'ret' variables in
KVM_RISCV_GET_CSR() and KVM_RISCV_SET_CSR() to '_ret' to make them more
resilient to these kind of errors.

Fixes: 937f0b4512 ("target/riscv: Implement kvm_arch_get_registers")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 78fa1fa162..45b6cf1cfa 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -87,17 +87,17 @@ static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
 
 #define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
     do { \
-        int ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
-        if (ret) { \
-            return ret; \
+        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
+        if (_ret) { \
+            return _ret; \
         } \
     } while (0)
 
 #define KVM_RISCV_SET_CSR(cs, env, csr, reg) \
     do { \
-        int ret = kvm_set_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
-        if (ret) { \
-            return ret; \
+        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
+        if (_ret) { \
+            return _ret; \
         } \
     } while (0)
 
@@ -533,7 +533,6 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
 
 static int kvm_riscv_get_regs_csr(CPUState *cs)
 {
-    int ret = 0;
     CPURISCVState *env = &RISCV_CPU(cs)->env;
 
     KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
@@ -545,12 +544,12 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
     KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
     KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
     KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
-    return ret;
+
+    return 0;
 }
 
 static int kvm_riscv_put_regs_csr(CPUState *cs)
 {
-    int ret = 0;
     CPURISCVState *env = &RISCV_CPU(cs)->env;
 
     KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
@@ -563,7 +562,7 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
     KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
 
-    return ret;
+    return 0;
 }
 
 static int kvm_riscv_get_regs_fp(CPUState *cs)
-- 
2.41.0


