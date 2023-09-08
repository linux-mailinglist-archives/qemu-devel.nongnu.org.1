Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 451B7798227
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:14:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUec-00087x-5d; Fri, 08 Sep 2023 02:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUeY-0007qr-1W
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:38 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUeM-0007WZ-LQ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:37 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso14066755ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153245; x=1694758045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSYhbUljQLmwwhGQ4cyo7MT1zkKpeBlZTKYRcuPWFf8=;
 b=JQgewvFVTAaBmeJjF5B5mzBOF8UfK7CPvy6P9XhfB0shsWlx3Q6S/E+1B4vN3slcj+
 RHNS2OGQ6LQnU0uG9DLvzovkHuQ+IUZo+LSRzNSdgsG/jkhA4NLcLuBOUVoyVfcJuUyM
 Vh0iQGolUP19yf0tE9OzUwBPAkAnMdydclzfkncqgmnw41PKF3h1OkZTMv6zlsS3tCxx
 /91RA+qyHNuhZGGEc4BEhuxGTUgy9Rmr9EFOpKdoCVxNUm5NApX4aL2YRXvKptzXYKNM
 MigujSTlO2uq8zdFudmZUMqEq5fEpAFA+pRmzgVyYIlJaIYh3yyo/zEXoJS/IvFKFKUp
 2E7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153245; x=1694758045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZSYhbUljQLmwwhGQ4cyo7MT1zkKpeBlZTKYRcuPWFf8=;
 b=kXErJeOxjPUljpkXwJ6iV7sIZlIpp+4KIV8bZ6ffwU6sZ15/W/6ywAi9NOut580DW5
 2YkTirJpTriXCerkR7j+3yePs44HfZxIrGgb07+zkQ4nTiktnROWHjwcNRxHAy7QURNV
 HlTccdbHzlymHQ3bwY7N4FYMLz6Gu3UsRxzQAnwTDxXtw733LKmcdDwZqeeuVlk+Z9w4
 lPj/LSpXAfRqWW+TL1ZtYmuT9ZZ4OL5IhyUoKIBAtLiat6jLj+27SkwDUN879v0qsPiW
 KFuDvnpfBPQkqI45msQvq4YD+fKuLF5pIr23wgH1an0BlGmZ6iAD3B+pT6OlW/S6WSJ/
 fM+g==
X-Gm-Message-State: AOJu0Yx9dNoTw8Rxl8Z7FMcKKfz7rAo0YgdT8dZfI//LWXPw7vMj+JcU
 cRT116Qlh7UKZX0rzLCIgWKEFq136J9cxa+q
X-Google-Smtp-Source: AGHT+IEevPaL7hfRFmVfQ1ZyULUnjOfDZO7RDXIgYD4mqcpW5HEHKvToSWUTm+R0YSmYjjyKQZDvjg==
X-Received: by 2002:a17:903:48d:b0:1b8:987f:3f34 with SMTP id
 jj13-20020a170903048d00b001b8987f3f34mr1633063plb.25.1694153244879; 
 Thu, 07 Sep 2023 23:07:24 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:07:23 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 39/65] hw/intc/riscv_aplic.c fix non-KVM --enable-debug build
Date: Fri,  8 Sep 2023 16:04:05 +1000
Message-ID: <20230908060431.1903919-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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


