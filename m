Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C3C71264E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 14:11:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2WHQ-0004rQ-GC; Fri, 26 May 2023 08:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q2WHB-0004oj-VW
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:10:34 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q2WH7-0005Hl-7l
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:10:33 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-19f22575d89so23314fac.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 05:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685103025; x=1687695025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIbZJJsOcm3S8IEVd1te65HPg1fVUwZXpCiyeQi07lA=;
 b=mQkYLwqxmn/+up7zWPEW78xfkz7JUifMhUmMmQDJsU+5bpfL8htIQOlfJXkdLE2sCE
 6KYP+MJPs5Wb94/Eup5qNld43/xgmVQGkNFq4EPaBEgLSLeyEhfYjKVDcdPYADuWHacK
 S57de4IoQtRJTfm3JMyRIz9R1cMIqFM6kCWeFvXQDTxsEyhaCIV/BU0VfOTzsIqUzJjv
 CHZXgvb3p++pjuh+tkws+loxJFgEe0pJD2VMKYRUI4ZFz++UkRl/4fmF48+Bx228H3u1
 kYVNMc1Opo8e1Hi+Igm6sdqrKgCteCW9bcoSUi9SFQho+7hr3cfZfGCbAY0P9OpCkfdh
 GiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685103025; x=1687695025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIbZJJsOcm3S8IEVd1te65HPg1fVUwZXpCiyeQi07lA=;
 b=UacoXAB6KOYBd/lr71u3V97Mj5YjP4YGGP04VbtgyFFv+XYleAEZCkgxfHH44SDPJs
 kPtZeVmP53bVdietf5nU+VMNrsAGbVolXJa+KEgXy6cjm+t5S38ChksO775r8vZYeRR4
 V6VRaeLKHxP0isYX1F6Umb7PmAV6i9Q2piG0orgSPl/wrUjUFhDAcTuIhjzGANr4NL0X
 zBrEHouA58qQm85D7AC6rj27VIxwaYl/pWE4obAoizq4H80RolJ/+s8SUzzmEIpt0RHO
 V7qptErEv+kN6eu5Dd06R+P+v2HOxLHebOnKmpk27wUI1sIXxxPDpLcJYIROFQTZWVDX
 wrEA==
X-Gm-Message-State: AC+VfDxR8ubJrrorQYI831nSZ4oOnHuP3rVHuBRHPqpzJSZRpScvk7Ix
 UArcTl1Io85JWQfCZr4UptDKQg==
X-Google-Smtp-Source: ACHHUZ5D5YNR4vtXDWgJU5o4l0xKuwWuAPxtr5i9kRX76op/nc8XOe0mw8FCWwekvKWCoSx9NdfJ1Q==
X-Received: by 2002:a05:6870:1728:b0:192:8632:aca9 with SMTP id
 h40-20020a056870172800b001928632aca9mr817720oae.23.1685103025499; 
 Fri, 26 May 2023 05:10:25 -0700 (PDT)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.186.3])
 by smtp.gmail.com with ESMTPSA id
 g10-20020a9d618a000000b006abb3b660a9sm1611602otk.54.2023.05.26.05.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 05:10:25 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 2/3] riscv/virt: Support using pflash via -blockdev option
Date: Fri, 26 May 2023 17:40:05 +0530
Message-Id: <20230526121006.76388-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526121006.76388-1-sunilvl@ventanamicro.com>
References: <20230526121006.76388-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Currently, pflash devices can be configured only via -pflash
or -drive options. This is the legacy way and the
better way is to use -blockdev as in other architectures.
libvirt also has moved to use -blockdev method.

To support -blockdev option, pflash devices need to be
created in instance_init itself. So, update the code to
move the virt_flash_create() to instance_init. Also, use
standard interfaces to detect whether pflash0 is
configured or not.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reported-by: Andrea Bolognani <abologna@redhat.com>
Tested-by: Andrea Bolognani <abologna@redhat.com>
---
 hw/riscv/virt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 1187a60d6e..b450248a21 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1246,6 +1246,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
     const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
     uint32_t fdt_load_addr;
     uint64_t kernel_entry = 0;
+    BlockBackend *pflash_blk0;
 
     /*
      * Only direct boot kernel is currently supported for KVM VM,
@@ -1265,8 +1266,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
 
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
                                                      start_addr, NULL);
-
-    if (drive_get(IF_PFLASH, 0, 0)) {
+    pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
+    if (pflash_blk0) {
         if (machine->firmware && !strcmp(machine->firmware, "none")) {
             /*
              * Pflash was supplied but bios is none, let's overwrite the
@@ -1497,8 +1498,6 @@ static void virt_machine_init(MachineState *machine)
     sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
         qdev_get_gpio_in(DEVICE(mmio_irqchip), RTC_IRQ));
 
-    virt_flash_create(s);
-
     for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
         /* Map legacy -drive if=pflash to machine properties */
         pflash_cfi01_legacy_drive(s->flash[i],
@@ -1525,6 +1524,8 @@ static void virt_machine_instance_init(Object *obj)
 {
     RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
 
+    virt_flash_create(s);
+
     s->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     s->acpi = ON_OFF_AUTO_AUTO;
-- 
2.34.1


