Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CF172F1A3
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:22:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FDK-00081A-KR; Tue, 13 Jun 2023 21:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDI-0007vG-U3
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:20 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDH-0004kF-5U
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:20 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-75d4dd6f012so152621085a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705738; x=1689297738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLwr+LJIpNpThygdPeDchVbcP/+PrMQXZxiXlfAtnPU=;
 b=LJwFNwIaGha7Wz/Ovjg0nmjIc2jtDAZmrblC0hWKGFUHGMjkmCH1F8+z/MVbjrh2LD
 /AQbUjwd+Be+VvSqJLWWPmo58PfUWeRsb0XN+pTtomxiSUR0B5H4EqaM7r1xmrYU9eXC
 2cJap0xsAqXgDxk+WRSyOGKuBnRXjzHu/9gS1vquFTM4Nkbi5S9gSLIALUtCXIRoaF4C
 uAqK9rf6iRPZpeEyvvNyufpWPR7QBzQaZdjjHrPicctkzT3Noakr9OZiCeuEnHXY56ev
 H4n0V5uduLDNruId8BNOgBDIKMTW2Uwizva1HNmjN/6pPPIT0lPb4IfA3CuWl20SIJbG
 ZNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705738; x=1689297738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLwr+LJIpNpThygdPeDchVbcP/+PrMQXZxiXlfAtnPU=;
 b=bHkjGXQe2Cu5CCjX5Hm1QowM3EOiRjyBV38Ci1PypBoNkX+bvCwvs1LKtfHz11Tgbq
 ekala1ws1f8YBy6IfcnwimAxPRSP4RH2bLI4CznsmD6RwkOYtMxwP7GwWNfWEdJf++lp
 JajfX06btxb1BJ6YESfe9+MPExGIH8WkRKm5tSbFJVbohAgGqxnMhDdHG4mSm22cSIcV
 fE1xXMi0gEBRj+0Wq7XNXh1sroyMXwCyjwy7N8/ilE3gj23VVF9zcLIIESPHUEL96OD/
 TPEj6lhj3GKIwXCiawy4qjAM4M0+xLDESoJs3jV+cTdqrfF/zmIAjjwNyHEFEioiapL2
 blwA==
X-Gm-Message-State: AC+VfDxtnf2pTGGoEJ0NvNXVH/xwu4PJtjHYICFNQ7zEAY82WpcNF+Fh
 d4Tu4lotP59AHZCRqy1PC/SmSlrx6xEJCg==
X-Google-Smtp-Source: ACHHUZ6JyhebWq1IlcnG9tb3N0kS2Yq4rW0AbVMrqO5gE32y3p/XVvsfEjCoXIwyR5LDdgg7fD/aCQ==
X-Received: by 2002:a05:620a:63c9:b0:75e:c32a:5758 with SMTP id
 pw9-20020a05620a63c900b0075ec32a5758mr14569076qkn.51.1686705737839; 
 Tue, 13 Jun 2023 18:22:17 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:17 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 26/60] hw/riscv/opentitan: Rename machine_[class]_init()
 functions
Date: Wed, 14 Jun 2023 11:19:43 +1000
Message-Id: <20230614012017.3100663-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x736.google.com
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

Follow QOM style which declares FOO_init() as instance
initializer and FOO_class_init() as class initializer:
rename the OpenTitan machine class/instance init()
accordingly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230520054510.68822-2-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/opentitan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index bc678766e7..2d21ee39c5 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -75,7 +75,7 @@ static const MemMapEntry ibex_memmap[] = {
     [IBEX_DEV_FLASH_VIRTUAL] =  {  0x80000000,  0x80000     },
 };
 
-static void opentitan_board_init(MachineState *machine)
+static void opentitan_machine_init(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const MemMapEntry *memmap = ibex_memmap;
@@ -108,17 +108,17 @@ static void opentitan_board_init(MachineState *machine)
     }
 }
 
-static void opentitan_machine_init(MachineClass *mc)
+static void opentitan_machine_class_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Board compatible with OpenTitan";
-    mc->init = opentitan_board_init;
+    mc->init = opentitan_machine_init;
     mc->max_cpus = 1;
     mc->default_cpu_type = TYPE_RISCV_CPU_IBEX;
     mc->default_ram_id = "riscv.lowrisc.ibex.ram";
     mc->default_ram_size = ibex_memmap[IBEX_DEV_RAM].size;
 }
 
-DEFINE_MACHINE("opentitan", opentitan_machine_init)
+DEFINE_MACHINE("opentitan", opentitan_machine_class_init)
 
 static void lowrisc_ibex_soc_init(Object *obj)
 {
-- 
2.40.1


