Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18897746272
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 20:32:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGOLA-0007aM-JN; Mon, 03 Jul 2023 14:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGOL8-0007Zb-6X
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 14:31:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGOL6-00007y-C5
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 14:31:57 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-311367a3e12so6315374f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688409115; x=1691001115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMsBShz4C7A1YrSDPbppIGD5ps17qyWqJYLBfgbzYNs=;
 b=BC+SB7mnKNlR4pjYmT6LyjDiL3lYJfs2d1mxokhx86DjKVqazk7dx5Xza9vPiq7mei
 o3TzBlYH9DwrvGlDD8qMMno0izkWU9Fio2scqV3u6aF+YaURAfNvYk8cglpAJXiukuOr
 br6xhOGLEQTSdMXjrTm4cYPDHfJxUkrCkDh5dW/ZiDnOA1Z3IkIpjJiIZt0ixl0sJKOH
 6e61kZud+2TeRQx5cC62d+i0iuoyJ8kZRO8plfMwtyYIU0S1MTg1OH0yKB0hW8kB3z1Y
 pJRIc20NBYxuhMgpdtdIoKrIzuFCjZe+UR96E/7sqZpFCv+Js6prCUgI1LB2h9sOUFzM
 EqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688409115; x=1691001115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tMsBShz4C7A1YrSDPbppIGD5ps17qyWqJYLBfgbzYNs=;
 b=kJlEgbGUYfA0Z+mOf54mVI39BODmjlkf92/NFMdHXzI+nrWd1SRmmQX3cjRXps4hew
 2YPr/+huRzI90KvEcsF+oFHDPSjvP0CIl7S0f+BDe6ti0AFQt6GTTsFL0+r6jQeuu0pe
 mpJS8hM98S6iHb/nomp+S1MiZoY/BjFxBhVVHv8piNzmpJZmVo1w+k0/L5IsFqXFhRFN
 CTVOTuaueswmTnDBXPsTxfyso6sUIUvrDuD1gFkHMJm1tq7uSJcW4palbWgI4448xs4L
 dmxydGyfCeKQZKnG7SnIqeNqKSm+GjPdJXhd30UX4BCdSj7GsyUorszOsBjzMjz3F7AX
 nE8Q==
X-Gm-Message-State: ABy/qLYG9qA7EvJpjx15DVWccwj02bmXSrxYjSRQdWdn9fTzq853LKMI
 HpF8m0/jWgzIL2L0rID6lbEuQ3fFSlUXwRTJ3fMLzw==
X-Google-Smtp-Source: APBJJlE3GwiR2HJVCApX/Q+cUmnurOaqUoNuoEEtQvpP9gspwD3JEwNcbOB2bGBXU5ghTqVD07S7aw==
X-Received: by 2002:a05:6000:1152:b0:314:2b0a:dac6 with SMTP id
 d18-20020a056000115200b003142b0adac6mr6770036wrx.41.1688409114864; 
 Mon, 03 Jul 2023 11:31:54 -0700 (PDT)
Received: from localhost.localdomain ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 u11-20020adfdd4b000000b003143765e207sm3323297wrm.49.2023.07.03.11.31.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Jul 2023 11:31:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 01/16] target/riscv: Remove unuseful KVM stubs
Date: Mon,  3 Jul 2023 20:31:30 +0200
Message-Id: <20230703183145.24779-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230703183145.24779-1-philmd@linaro.org>
References: <20230703183145.24779-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Tested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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
index 7f56c5f88d..e3ab3df4e5 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -22,7 +22,7 @@ riscv_ss.add(files(
   'crypto_helper.c',
   'zce_helper.c'
 ))
-riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
+riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
 
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
-- 
2.38.1


