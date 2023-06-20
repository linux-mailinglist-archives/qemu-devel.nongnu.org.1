Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B56377365EB
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:17:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWXO-0001Fi-4N; Tue, 20 Jun 2023 04:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBWXC-0001D6-08
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:16:18 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBWXA-0003nK-5w
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:16:17 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-988e6fc41ccso170590366b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687248974; x=1689840974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GmJDGJJlkA2GivjH5EJMWL239y4z1jUH4kX5hcFkTlI=;
 b=CNjrjnDsBq+ZtWF/mCUovMcnTU+fu15kXKvnK0hR57qOJHgEJmYNKtrsRlaQQHqcBc
 Tsc+Lp2tr3Z+Ng2zQNQtiJTFV1iclwb+Ku5sjy8LIWdRjCVL5+Z7ywuN+6DPdQneeNIX
 H7JyTFPdJfxduHXR33UfPi+o8NMH2uj9ZBv2/ErWgiDqBNQEaAZmEj17lF62pq1BkPyw
 r1YBtRGBvAVi6pPD/gG4ZpR7K+9igTBfdLDUpimFLisJAm/+ZMMaZHO9zodLUoSkLp1m
 ey1te+A4DHBKo4XlNMkDpMQbzhwSHPwJ6wSNUDzW5db2CAfJkkGYLYCzc5U+xPoa+d41
 2f9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687248974; x=1689840974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GmJDGJJlkA2GivjH5EJMWL239y4z1jUH4kX5hcFkTlI=;
 b=UCilGGC5nhrHKe+TdKoqUMg8TTiRWtzclJUVkTnJwVCiAffDe8pUNmCAK7CqulzEX0
 jYLtlUt/qiyyxAKqYZ02nasSHNWzlq9Y7YT9UzETlczppPyNME85FznVYLIt1eb5kvZ1
 FPIlD73ufSYlgqZzxr4323WDTQSuwdIfD0CRb0/bSnoCGi+3US24WKJ3d/7veJ+hEgBq
 UNfJKkwFR0eR0Gb5VufcmeBhtgJ//x7U7qdLXspwPT45PYr+v6d5LXy1xA2bhBwPB/7H
 WQ6uRpxhxM+8F2osBKRmvM/750w1dt8mi9LVUrDzFj39lk+sy7ooZmKp2I50QTqiMbB7
 ni3Q==
X-Gm-Message-State: AC+VfDyRrDTNJaQE0rXclfmor5Eo2qWLG7Vn1cSGa7zFcSPahN8tEU2x
 idccYh5GYG8sOXzskw30hHaKeq9DPLZvkJyCj2e07A==
X-Google-Smtp-Source: ACHHUZ7ETb8h8N9D0eWOS21wHebIZRZxpgXhgJYbRk2e7VTE35fj/rfWgZdfSPA4j1v6j8qOMFvo0g==
X-Received: by 2002:a17:907:9692:b0:988:71c8:9f44 with SMTP id
 hd18-20020a170907969200b0098871c89f44mr4801788ejc.2.1687248974119; 
 Tue, 20 Jun 2023 01:16:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a17090617c900b0098768661505sm935598eje.117.2023.06.20.01.16.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jun 2023 01:16:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 kvm@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/riscv: Remove unuseful KVM stubs
Date: Tue, 20 Jun 2023 10:16:11 +0200
Message-Id: <20230620081611.88158-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Since we always check whether KVM is enabled before calling
kvm_riscv_reset_vcpu() and kvm_riscv_set_irq(), their call
is elided by the compiler when KVM is not available.
Therefore the stubs are not even linked. Remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/kvm-stub.c  | 30 ------------------------------
 target/riscv/kvm.c       |  4 +---
 target/riscv/meson.build |  2 +-
 3 files changed, 2 insertions(+), 34 deletions(-)
 delete mode 100644 target/riscv/kvm-stub.c

diff --git a/target/riscv/kvm-stub.c b/target/riscv/kvm-stub.c
deleted file mode 100644
index 4e8fc31a21..0000000000
--- a/target/riscv/kvm-stub.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * QEMU KVM RISC-V specific function stubs
- *
- * Copyright (c) 2020 Huawei Technologies Co., Ltd
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2 or later, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "kvm_riscv.h"
-
-void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
-{
-    abort();
-}
-
-void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
-{
-    abort();
-}
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 0f932a5b96..52884bbe15 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -503,9 +503,7 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
 {
     CPURISCVState *env = &cpu->env;
 
-    if (!kvm_enabled()) {
-        return;
-    }
+    assert(kvm_enabled());
     env->pc = cpu->env.kernel_addr;
     env->gpr[10] = kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
     env->gpr[11] = cpu->env.fdt_addr;          /* a1 */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index e1ff6d9b95..37fc2cf487 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -22,7 +22,7 @@ riscv_ss.add(files(
   'crypto_helper.c',
   'zce_helper.c'
 ))
-riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
+riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
 
 riscv_softmmu_ss = ss.source_set()
 riscv_softmmu_ss.add(files(
-- 
2.38.1


