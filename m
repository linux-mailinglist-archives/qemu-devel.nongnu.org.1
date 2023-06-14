Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AE872F1C4
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:26:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FFF-0005Lb-MO; Tue, 13 Jun 2023 21:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FF5-00050w-Md
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:14 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FF2-0004zL-MB
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:10 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-662f0feafb2so4529968b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705847; x=1689297847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKxUeaeX1j5XB7BNXbGdK7jp39DBBUSpT+MazWQZo80=;
 b=XYypENE71IWwI7mzdsrF2VU7ZvKzxPaDT/SH2Wif1lNHAyP530KzSwUfukOyGFrBgD
 onLtKxtOOH8Bhd6Q9ePa9qY4qLcsLfDHWGeqM8w8g/KzV/2SuvdLlW0ead8VRxUFBaa+
 r+GF3RCCe29G0/T/F8LnWhYwFpw7fL/ObdoHU/uo8ZugcA0aNuTCJMC0C4nNX+j7qXkL
 EupRhGTgvZxRBRQhlwDnGcroQRvvviCXUcN3scYotGgNYNKtBHQXHgdmqMzwNpdOBwNs
 7xYUBhuBcKakm0MF4Z4lp3lGi/obvLU+GAdw0edQspByVRCnjH0qfUlUzqOe8ZZg6TYA
 EniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705847; x=1689297847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKxUeaeX1j5XB7BNXbGdK7jp39DBBUSpT+MazWQZo80=;
 b=d+OsLaz7AZpr0K51/4r6syKyuQaFxYoOsaE7BDakMzROJ9Msz4ojs4fOJI95WyY+5P
 ow1xrqMa5Qv+/BO/K5DPwTx9VwsoKj2ep5SW2Z5X+OQ73HqLnQG3KMA9TPcIMVeAvXGX
 qDBC/E6dCcMAnzrniBPRvk0Nb9aGcGx8nVojwHyoW8LyJVxNhKULtphWAh0z1/p5qVXA
 I3CQowt3Acdd6Hr0qBxAyXxoJfHsSq72x7zDxpnu0/C/8Y/kIth0EM+4pKSsU3Cpe6+M
 mM/TEHDv4DuiQaQt8GYZHRyNKOvoi/0ajxobmABdYJyzuSPzhtsYqs5LJCFpytLcAqeK
 P9Xg==
X-Gm-Message-State: AC+VfDz+6yEMOdzvS90WTpHx7RrKWlTCELxXAqHvFK5Sx5m7E+1/hykl
 Tq4mLUWTOlC2P2s5+wrjTJfYopbB6YXQ2A==
X-Google-Smtp-Source: ACHHUZ4er1coUWAqJO2AXdDBEo3gFoQGoLencbtocg26YVxXfD7Hy0FljVw2sf/7P751R7hzc6le0A==
X-Received: by 2002:a05:6a20:7347:b0:10b:bf2d:71bb with SMTP id
 v7-20020a056a20734700b0010bbf2d71bbmr251147pzc.27.1686705846983; 
 Tue, 13 Jun 2023 18:24:06 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:24:06 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 53/60] riscv/virt: Support using pflash via -blockdev option
Date: Wed, 14 Jun 2023 11:20:10 +1000
Message-Id: <20230614012017.3100663-54-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

From: Sunil V L <sunilvl@ventanamicro.com>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230601045910.18646-3-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 17fdcef223..95708d890e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1246,6 +1246,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
     const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
     uint32_t fdt_load_addr;
     uint64_t kernel_entry = 0;
+    BlockBackend *pflash_blk0;
 
     /*
      * Only direct boot kernel is currently supported for KVM VM,
@@ -1266,7 +1267,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
                                                      start_addr, NULL);
 
-    if (drive_get(IF_PFLASH, 0, 0)) {
+    pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
+    if (pflash_blk0) {
         if (machine->firmware && !strcmp(machine->firmware, "none") &&
             !kvm_enabled()) {
             /*
@@ -1499,8 +1501,6 @@ static void virt_machine_init(MachineState *machine)
     sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
         qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
 
-    virt_flash_create(s);
-
     for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
         /* Map legacy -drive if=pflash to machine properties */
         pflash_cfi01_legacy_drive(s->flash[i],
@@ -1527,6 +1527,8 @@ static void virt_machine_instance_init(Object *obj)
 {
     RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
 
+    virt_flash_create(s);
+
     s->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     s->acpi = ON_OFF_AUTO_AUTO;
-- 
2.40.1


