Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B16D7184D5
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:24:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Mji-0005EN-6g; Wed, 31 May 2023 10:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q4MjZ-000545-RO
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:23:31 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q4MjX-0002kh-NM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:23:29 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-557c7ffea48so2540904eaf.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 07:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685543003; x=1688135003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyoyB7K4g21QQhSn1QlP7nYODAnnSF7DtjAfnzuKxh8=;
 b=l+NmEqRlqVYQRt5S0el11LHigb1LLWJ0X5CTKyzXz53ke4wbVWnqf7DSMgUn32DcLe
 4gBryK9FctZBndF2Ynem89TzbKnLDa0ZijJ0WOZds8i3zvRHaKlk8TyVpv/MXxCpsFW7
 sczTvEhOiHiqI3nyNk8KsNzNFivYX4hVS4C1kNSw2hXtk2osycsMVJY/cJinFt4P7eu/
 WcLdgAqXlXz1nEcFTw5SZaz9R8YyRHB556K/lSuynyU3tCQiM4Yd2LvNQiMuqdD9UsY0
 EIySgr7LLEeyo7bI25vLqD5y320J6TodeGxCtqyQ1CrW77tOzNlhnk+1yGcVvA0tcgKW
 6T6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685543003; x=1688135003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyoyB7K4g21QQhSn1QlP7nYODAnnSF7DtjAfnzuKxh8=;
 b=CLHwH+XEmWOBKcjPeiYwg8vKdZ/JOE3aPDRR2PDFprtFp1zsTx+xlgEPmT9c8kY105
 r03fGMR8c2zSaWH/q5n20VuDbmLim2Y7R10NsISxdk6lf87TA5VAou8r08j0Qw4AS0u6
 RmRTcAiRPT39EyXCY2RLbVfNeU2lxIybDMuosVKEbB/n6X3DOTzuaiQamZyDnKAQ9gY0
 bw1AuUwNX1Pncbc6BkbePDt+FXkO85xNsGOdRJUn6cLlH8keeat3fpHR28DtagOIYDS5
 RaR+2RmSJXNWjSKLt+f5mmPW5Xh0U69VMjTFULIGZWbDkib/spX50LbNwXoWC/CIaFCk
 NT7w==
X-Gm-Message-State: AC+VfDylFCv284ZmnCcmVKToB3h8xMwyQenIjqEj1ib8J21XF3bR9HKX
 TSQRytOfy7IgGnYSFlO0JuzhLw==
X-Google-Smtp-Source: ACHHUZ40VWyNhmseqQpCpsqyJDMOmeRbzGCWseQz2akmllPrHb2GG37vFhf3igDUukzzknj6eKGE4A==
X-Received: by 2002:aca:d957:0:b0:398:2bbb:a2ea with SMTP id
 q84-20020acad957000000b003982bbba2eamr3996221oig.42.1685543003014; 
 Wed, 31 May 2023 07:23:23 -0700 (PDT)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.186.3])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a05680802d300b00397c07e8061sm574548oid.6.2023.05.31.07.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 07:23:22 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 2/3] riscv/virt: Support using pflash via -blockdev option
Date: Wed, 31 May 2023 19:52:59 +0530
Message-Id: <20230531142300.9114-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531142300.9114-1-sunilvl@ventanamicro.com>
References: <20230531142300.9114-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oo1-xc31.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/virt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 3e5dc649c3..76c7a3ba3b 100644
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
         qdev_get_gpio_in(DEVICE(mmio_irqchip), RTC_IRQ));
 
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
2.34.1


