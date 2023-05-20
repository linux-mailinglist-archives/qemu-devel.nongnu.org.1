Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FE470A5C1
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 07:46:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0FPR-0007NC-CO; Sat, 20 May 2023 01:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0FPO-0007Lk-B1
 for qemu-devel@nongnu.org; Sat, 20 May 2023 01:45:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0FPM-0007dO-I3
 for qemu-devel@nongnu.org; Sat, 20 May 2023 01:45:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f4271185daso39042495e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 22:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684561535; x=1687153535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9RyvUr1lBMxRBlxutUWdrrmWw/Nx1e27AsLVC25y0F4=;
 b=PKELuvhix3C+uVNxCIR8DvVIH2Yt+Ib+Vzmkog7WpfbrdAojUOlmjgCbrklPZ2y4Fe
 vZ4M1Bmhj3NE0JgJnPEbhQb4rmV9wPevKq20o8wHnaajeW3kJv224xJiTdQHs/6egrsl
 VoNumvN/q8EyZekG29cbMjPCkI5uaKO7UkbzxsoSSls3edKdMTYWt9yH0MhEnqOMxXxk
 xpFQ5qMi4Bbc1T3KlfTL5Dcc5CUgGIBteypjqR4zllWwuO2CtIuCgYSgL1gVfno5AQCi
 irnDNunFBORvfSku4lo8wv0XPepcGx6zj+1+12DCdopoDcHlXIA5cgBVL/vC9E8o7rPE
 UMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684561535; x=1687153535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9RyvUr1lBMxRBlxutUWdrrmWw/Nx1e27AsLVC25y0F4=;
 b=UhiiRlFnyViAJ17+1EdLzx5wpVCc10C3mZ1en1pEi87r5MQVXIcF7gp2zjLGrGnorL
 kn8Gca3DOmj/SWrNz+PQg55U5eiWToociAPfv22tRLkOrrKHq2pZmEijiYMhzn1JFOP9
 iBjFhkQqArC4+RBuqQu4vreTAHojvuz/LtfIStSh85ITlSeeX56uhguenGQpzdU08mtf
 bmd+DJX4+NRGGiV7WeSqR2jvhzo9EBpQcJHq7pvbAWpnQJtDOh68A6I4OJTWGgSphDXI
 7tdDEwwjwaehb5sRKq2zenBcgHj/wdD7hDVtcEdKiTfAJG7kshPOd8cgHcH8DhqgLCMF
 KoWQ==
X-Gm-Message-State: AC+VfDzUC5pejhwuWU+6fctdq9q7pejv+KXaRXCspiYnNRyhvAo58vsh
 4ijbRN0cSFigOlaaegFpkPHeL9H+rxxj7AXOfrw=
X-Google-Smtp-Source: ACHHUZ5indZZtlhR4htSlNxfXZ69jjfj5/lLARRLYmoUQWRVX6L9s0yNgpxOZSMEpp/OXlDFMspxyQ==
X-Received: by 2002:a7b:cc11:0:b0:3f0:9564:f4f6 with SMTP id
 f17-20020a7bcc11000000b003f09564f4f6mr2980027wmh.1.1684561534942; 
 Fri, 19 May 2023 22:45:34 -0700 (PDT)
Received: from localhost.localdomain
 (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr. [176.184.41.228])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a7bc3c1000000b003f42158288dsm4377319wmj.20.2023.05.19.22.45.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 May 2023 22:45:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] hw/riscv/opentitan: Explicit machine type definition
Date: Sat, 20 May 2023 07:45:09 +0200
Message-Id: <20230520054510.68822-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230520054510.68822-1-philmd@linaro.org>
References: <20230520054510.68822-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Expand the DEFINE_MACHINE() macro, converting the class_init()
handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/riscv/opentitan.h |  3 ++-
 hw/riscv/opentitan.c         | 10 +++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index fd70226ed8..806ff73528 100644
--- a/include/hw/riscv/opentitan.h
+++ b/include/hw/riscv/opentitan.h
@@ -24,6 +24,7 @@
 #include "hw/char/ibex_uart.h"
 #include "hw/timer/ibex_timer.h"
 #include "hw/ssi/ibex_spi_host.h"
+#include "hw/boards.h"
 #include "qom/object.h"
 
 #define TYPE_RISCV_IBEX_SOC "riscv.lowrisc.ibex.soc"
@@ -53,7 +54,7 @@ struct LowRISCIbexSoCState {
     MemoryRegion flash_alias;
 };
 
-#define TYPE_OPENTITAN_MACHINE "opentitan"
+#define TYPE_OPENTITAN_MACHINE MACHINE_TYPE_NAME("opentitan")
 
 typedef struct OpenTitanState {
     /*< private >*/
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 7d7159ea30..9535308197 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -108,8 +108,10 @@ static void opentitan_machine_init(MachineState *machine)
     }
 }
 
-static void opentitan_machine_class_init(MachineClass *mc)
+static void opentitan_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "RISC-V Board compatible with OpenTitan";
     mc->init = opentitan_machine_init;
     mc->max_cpus = 1;
@@ -118,8 +120,6 @@ static void opentitan_machine_class_init(MachineClass *mc)
     mc->default_ram_size = ibex_memmap[IBEX_DEV_RAM].size;
 }
 
-DEFINE_MACHINE(TYPE_OPENTITAN_MACHINE, opentitan_machine_class_init)
-
 static void lowrisc_ibex_soc_init(Object *obj)
 {
     LowRISCIbexSoCState *s = RISCV_IBEX_SOC(obj);
@@ -327,6 +327,10 @@ static const TypeInfo open_titan_types[] = {
         .instance_size  = sizeof(LowRISCIbexSoCState),
         .instance_init  = lowrisc_ibex_soc_init,
         .class_init     = lowrisc_ibex_soc_class_init,
+    }, {
+        .name           = TYPE_OPENTITAN_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .class_init     = opentitan_machine_class_init,
     }
 };
 
-- 
2.38.1


