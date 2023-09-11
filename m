Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC04679A3D3
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:48:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagg-0004yn-PT; Mon, 11 Sep 2023 02:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagX-0003ox-6g
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:14 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagU-0005Ft-EM
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:12 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1d544a4a2f2so2851082fac.3
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414768; x=1695019568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSYhbUljQLmwwhGQ4cyo7MT1zkKpeBlZTKYRcuPWFf8=;
 b=hiqDz9zwqHM1mCL1WzsBnIaBpHOxSUxNdUbHomYSmfzLVT0qxJKLawIpj5Bry8VbRd
 19rKzxmR2hMkLe6WeBEvq4dqvX79Yr1xus/EXvmS8XhuH0HkI4BV9ZgQFSWe0eTDYzZq
 p0xsabxXA+QP7H3L2bJ38WDzGvw1mbkK0ciuSJUgdLuGwZeB4/T1m1rrDKWq5j76ARNq
 to2djK6+qDMpdOwbJ/YTKbrGTXg11wBi+wqxKNXeJZzJCOnbngAumiTBBd6SClWgHuku
 yutekaLfi5eBk4T8IlMnEGLwiiyDk9jpoMLpbSZljXWMkWMSF5ffuXVveRAd2UAtD8PZ
 kAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414768; x=1695019568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZSYhbUljQLmwwhGQ4cyo7MT1zkKpeBlZTKYRcuPWFf8=;
 b=g1njohBdR0uZkNzP1nC5T/srvzlMYi7NgC6L3Dddh1d9GSU1MhgqbgtDSIjDdxLo6K
 jj8UuZEn4ByIWbLUYC7iODs31RNPpvUpROTOMPC3f1Fejk2Ma1cdkliI5S7BUk+8kpCm
 xWWyqCOW/1FJeodslP8gXOy4O0/5Ji8yee6a86givbeRqIJX3CWtQ6rFFUpJa4/Bt2Fc
 lflLSHm4IwDpst6owyEMHzONVC8KzqVZKoblPI97hph6DNNlXTSxJzcvuqMAj55p9jlA
 oEaHdeqarnojQzaghfg9ftxLyF9pf5zpylMw78nYsJtGsoJHIEmTefWXGQjxLMVl5rRF
 LGVA==
X-Gm-Message-State: AOJu0YxYGd+GVDDv+0EAZbzmnQ57y9E54A3+bgpDBADVANYNMbhPi6vP
 3kRgAY813RfkGcsCMOpbTfSHTzrE8OGC2Q==
X-Google-Smtp-Source: AGHT+IHo/FLd0mab7/j7DFUSSHu7JhMcH1OAkkY/yaJdmApVmqZc0GFAKsOb8YY8M0mgnQjRqPdz4Q==
X-Received: by 2002:a05:6870:70a9:b0:1d4:cebb:63ba with SMTP id
 v41-20020a05687070a900b001d4cebb63bamr11003004oae.1.1694414768594; 
 Sun, 10 Sep 2023 23:46:08 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:46:07 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 39/45] hw/intc/riscv_aplic.c fix non-KVM --enable-debug build
Date: Mon, 11 Sep 2023 16:43:14 +1000
Message-ID: <20230911064320.939791-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Commit 6df0b37e2ab breaks a --enable-debug build in a non-KVM
environment with the following error:

/usr/bin/ld: libqemu-riscv64-softmmu.fa.p/hw_intc_riscv_aplic.c.o: in function `riscv_kvm_aplic_request':
./qemu/build/../hw/intc/riscv_aplic.c:486: undefined reference to `kvm_set_irq'
collect2: error: ld returned 1 exit status

This happens because the debug build will poke into the
'if (is_kvm_aia(aplic->msimode))' block and fail to find a reference to
the KVM only function riscv_kvm_aplic_request().

There are multiple solutions to fix this. We'll go with the same
solution from the previous patch, i.e. add a kvm_enabled() conditional
to filter out the block. But there's a catch: riscv_kvm_aplic_request()
is a local function that would end up being used if the compiler crops
the block, and this won't work. Quoting Richard Henderson's explanation
in [1]:

"(...) the compiler won't eliminate entire unused functions with -O0"

We'll solve it by moving riscv_kvm_aplic_request() to kvm.c and add its
declaration in kvm_riscv.h, where all other KVM specific public
functions are already declared. Other archs handles KVM specific code in
this manner and we expect to do the same from now on.

[1] https://lore.kernel.org/qemu-riscv/d2f1ad02-eb03-138f-9d08-db676deeed05@linaro.org/

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230830133503.711138-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm_riscv.h | 1 +
 hw/intc/riscv_aplic.c    | 8 ++------
 target/riscv/kvm.c       | 5 +++++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
index 7d4b7c60e2..de8c209ebc 100644
--- a/target/riscv/kvm_riscv.h
+++ b/target/riscv/kvm_riscv.h
@@ -26,5 +26,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num);
+void riscv_kvm_aplic_request(void *opaque, int irq, int level);
 
 #endif
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 592c3ce768..99aae8ccbe 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -32,6 +32,7 @@
 #include "target/riscv/cpu.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
+#include "kvm_riscv.h"
 #include "migration/vmstate.h"
 
 #define APLIC_MAX_IDC                  (1UL << 14)
@@ -481,11 +482,6 @@ static uint32_t riscv_aplic_idc_claimi(RISCVAPLICState *aplic, uint32_t idc)
     return topi;
 }
 
-static void riscv_kvm_aplic_request(void *opaque, int irq, int level)
-{
-    kvm_set_irq(kvm_state, irq, !!level);
-}
-
 static void riscv_aplic_request(void *opaque, int irq, int level)
 {
     bool update = false;
@@ -840,7 +836,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
      * have IRQ lines delegated by their parent APLIC.
      */
     if (!aplic->parent) {
-        if (is_kvm_aia(aplic->msimode)) {
+        if (kvm_enabled() && is_kvm_aia(aplic->msimode)) {
             qdev_init_gpio_in(dev, riscv_kvm_aplic_request, aplic->num_irqs);
         } else {
             qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs);
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 6e909d0fdd..c01cfb03f4 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -46,6 +46,11 @@
 #include "sysemu/runstate.h"
 #include "hw/riscv/numa.h"
 
+void riscv_kvm_aplic_request(void *opaque, int irq, int level)
+{
+    kvm_set_irq(kvm_state, irq, !!level);
+}
+
 static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
                                  uint64_t idx)
 {
-- 
2.41.0


