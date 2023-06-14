Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1373172F1B7
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:24:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FDV-0000WY-K6; Tue, 13 Jun 2023 21:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDU-0000W7-Ft
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:32 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDS-0004lR-Qo
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:32 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-66619138c1eso451554b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705749; x=1689297749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EfQyD+rPmcrJBu3nsXartEhZoHzh8XKUvycvXdnVSVw=;
 b=O55YgoRl18RvKIOg+qd6Md00n3lW6+RqQSzYVYdEChmyY/OGvjB+6g8U/kI3fTOn1F
 uiHHv7jgDWM0zXxMKrZtcXBzAqXMJxGXGAQhvtseNqOEWXv4InpCvB7AjyfNsvHWlSsJ
 3fNWd3BzBsbuwQCTTK6mMZi6dlJj3s5ZPqHeRspdtLV+a3NR33bTjfag1fFqxqhQ7Rnb
 er3vJRLUmkRRP66N4aUVxzVZXBVfrehN/SS9NEVJJUNpkABGG5K9v1WncePJm0VtXtWj
 EZXGKECJ+WH+J8tQxHWHuoeHiQW181GclyFmlTJ6iRNWKu83mnu53iwldBp4scze36M8
 VWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705749; x=1689297749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EfQyD+rPmcrJBu3nsXartEhZoHzh8XKUvycvXdnVSVw=;
 b=Th4vSBGmEUFqQ8xRXRjmuC8251QNelvixd9A38q8RBtzVNp/0x8aYgMiEjaxGMWfgz
 EMb6xKYlcKjyUakPrb2Vy/RHnLfycTJyJR0767DLc9bGMYXPz8oln1OC7wHLfgSJJCFY
 zZCiCleg3nACos75Tdkpq5eu/XNQMQGnPijolHaRLuE46/JXxvfCtBhbIRiBTGnOdJ3R
 /o6qs5sCIo0AeeWNXD6psOSqIleDJgPJ12bgyfriAfqS31WteqKukkjIUu/dFOPTOYeS
 t8flMi08h2zzpz+5bNnNF2AWHdTD5o5Gf4JDRJaLZl0KCXg1Lw2GCinBMi6/6y5vORBH
 cV3Q==
X-Gm-Message-State: AC+VfDx6RvfFu98+BN+4JiWEeNPs4UOyX8ZjhvPny5KtIw+7Bphu2ldc
 Et17BT69lwVCX15SW7lLCyZFizCRkY+GmA==
X-Google-Smtp-Source: ACHHUZ6xLQp5Hmy2MndWy5wLPO5yoBTK6wdZaqXWoAXXwc6XIW8GmjqoXBU3dPpbHIHNkAzyUbhyQQ==
X-Received: by 2002:a05:6a20:2587:b0:106:5dff:5dc6 with SMTP id
 k7-20020a056a20258700b001065dff5dc6mr552266pzd.16.1686705749369; 
 Tue, 13 Jun 2023 18:22:29 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:28 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 29/60] hw/riscv/opentitan: Explicit machine type definition
Date: Wed, 14 Jun 2023 11:19:46 +1000
Message-Id: <20230614012017.3100663-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Expand the DEFINE_MACHINE() macro, converting the class_init()
handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230520054510.68822-5-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.40.1


