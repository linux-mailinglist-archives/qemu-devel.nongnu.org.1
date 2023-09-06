Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 272247937EB
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:19:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdofH-0003bz-CK; Wed, 06 Sep 2023 05:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdofF-0003YV-AO
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:33 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdofB-0005mb-LC
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:32 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1c0fcbf7ae4so2863382fac.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693991848; x=1694596648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GNwYRcF/ah5M2Lkpnd1nk5/sQynl6I3tpewm61MeLZQ=;
 b=o6wL7xJ8RjxOvcIWRf1OTfKJtc6uorbwRZcvxOC5BiqomUwLhuxmKzxCmsX+1KENVb
 atRg5fYlH0ldpkM2O94ZvP5vlixZN8WZHnjmTRU5w7sQy0OpuPrHXTxpRqDjYdmZG0yG
 vJE25PypzLFVSBqlcELTN+KaBWDSJHoG1fLMCgqqrDzSXXVEqFEyJLl2/on8ynfs6j5O
 G0TkhIH36ambIIgS/OQWj6L7QYYBfWFOMWHEhEXf8YiGtWFOOUSx03jgnk7kLoCbwcpJ
 aKFEE/nNXQCdEWAHPOYx+gDWm8nK3HQ3dS6O1sjsnFRz3pF8ae3T7kr2AvDJ4e+ygvyQ
 eOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693991848; x=1694596648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GNwYRcF/ah5M2Lkpnd1nk5/sQynl6I3tpewm61MeLZQ=;
 b=dnUhDp7pzRG2CmBP9vj4IXgK/wQN2w71JmpPXxCraeThMoOqyJFMLkb2leMGgw1Odp
 aiyPJasKi8HIeyLFsSmfMw5dWtFA0brkPHpM7kyuQOKGHiVrkh3I5htodSRs+dGTRJUN
 Oz+IkOm641q9jkaRXFAYoY+imTg1ZVA8zgwWPhJZM/niJKZho7cxceCWndu6l4RD9cnK
 /9tKhCD08aVo3gNCrdU91oCs8uN1LORLO+AiIfyQfDEjOC7qlO+UuW8liRyTGZYKWNVU
 K7L+c8z//rgY/GnHasolyyZv9eg3ZV8Z8sa+foRXI2ZIBBexnvyt5vWe/BuzbAruSBzQ
 ScTw==
X-Gm-Message-State: AOJu0YzdllmYctmmRf3pFmFDuhlu6zrIcZYYUZpprkMSFnFSGWvq+7iS
 R6e6XP/HuHqHx9/XwB1JtMw8SJSvH91/BVi+0nQ=
X-Google-Smtp-Source: AGHT+IHFQ4EkSxqGoIHbB3RTkajHV65iDPmkwyK8//RmWZ/Es18IkKBG7rDeZKso01u/y6Hc30fE8Q==
X-Received: by 2002:a05:6870:c21e:b0:1bb:7d24:eabb with SMTP id
 z30-20020a056870c21e00b001bb7d24eabbmr18856215oae.0.1693991847936; 
 Wed, 06 Sep 2023 02:17:27 -0700 (PDT)
Received: from grind.. ([177.94.15.194]) by smtp.gmail.com with ESMTPSA id
 n21-20020a9d6f15000000b006b75242d6c3sm6229228otq.38.2023.09.06.02.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 02:17:27 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 10/19] target/riscv: remove kvm-stub.c
Date: Wed,  6 Sep 2023 06:16:37 -0300
Message-ID: <20230906091647.1667171-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This file is not needed for some time now. All the stubs implemented in
it (kvm_riscv_reset_vcpu() and kvm_riscv_set_irq()) are wrapped in 'if
kvm_enabled()' blocks that the compiler will rip it out in non-KVM
builds.

We'll also add non-KVM stubs for all functions declared in kvm_riscv.h.
All stubs are implemented as g_asserted_not_reached(), meaning that we
won't support them in non-KVM builds. This is done by other kvm headers
like kvm_arm.h and kvm_ppc.h.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm-stub.c  | 30 ------------------------------
 target/riscv/kvm_riscv.h | 31 +++++++++++++++++++++++++++++++
 target/riscv/meson.build |  2 +-
 3 files changed, 32 insertions(+), 31 deletions(-)
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
diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
index f6501e68e2..c9ecd9a967 100644
--- a/target/riscv/kvm_riscv.h
+++ b/target/riscv/kvm_riscv.h
@@ -19,6 +19,7 @@
 #ifndef QEMU_KVM_RISCV_H
 #define QEMU_KVM_RISCV_H
 
+#ifdef CONFIG_KVM
 void kvm_riscv_cpu_add_kvm_properties(Object *obj);
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
@@ -27,5 +28,35 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num);
 void riscv_kvm_aplic_request(void *opaque, int irq, int level);
+#else
+static inline void kvm_riscv_cpu_add_kvm_properties(Object *obj)
+{
+    g_assert_not_reached();
+}
+
+static inline void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+static inline void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
+{
+    g_assert_not_reached();
+}
+
+static inline void kvm_riscv_aia_create(MachineState *machine,
+                          uint64_t group_shift, uint64_t aia_irq_num,
+                          uint64_t aia_msi_num, uint64_t aplic_base,
+                          uint64_t imsic_base, uint64_t guest_num)
+{
+    g_assert_not_reached();
+}
+
+static inline void riscv_kvm_aplic_request(void *opaque, int irq, int level)
+{
+    g_assert_not_reached();
+}
+
+#endif /* CONFIG_KVM */
 
 #endif
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index f0486183fa..3323b78b84 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -24,7 +24,7 @@ riscv_ss.add(files(
   'zce_helper.c',
   'vcrypto_helper.c'
 ))
-riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
+riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
 
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
-- 
2.41.0


