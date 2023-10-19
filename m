Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 439407D03DE
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:23:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaTJ-0003Wm-Oa; Thu, 19 Oct 2023 17:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTH-0003UH-9S
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTE-0000T1-EV
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so1095685e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750539; x=1698355339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjY0LM6sfNsf8Lt7Ogusfq+cXidKkW/8gHbtTfWffd0=;
 b=t80FGuvgGgxJg2RXg4Ulz9G0EXznMz6V/J8/h26vBgYleLaMEjSxE+wmysjCkTYXwf
 0pfPYFjcBuwNyGJMSPJXkXoymH9srTInZDgTywezt5hrZGnmO2dy9NFmL576fKccl1Dm
 /a38xIxYEzGpERKqxaJbDR1ojcPiAsB6hMsfteSGtRlqTroC78lLulHmmvJKVe9DKGCo
 YkooqGAHOaL0ctoCy+ESOu3O52zq/qjDnin8IYM5SaXRpVpthUEtKix0YdyKcwJq+phT
 cX+HqHHvupFpxhL+lwadj1KEjV8aOvyP+wY4hoJMOEJ8VMSzAv20f+CEIVU1zKaOs2kg
 e4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750539; x=1698355339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HjY0LM6sfNsf8Lt7Ogusfq+cXidKkW/8gHbtTfWffd0=;
 b=uD2I2YfLfyZt4K6n3hXmxxZ8XoTnYkmMNZEnwIA0nvr3G4acsggsvzPziWQVjf6J0r
 YB/prRmYXqLZHXoNlzXYV6AhU8i/nQgKFdrjUlJoQLklMFDhO8COyiV3LcrqhNNvkxnf
 0iOqKkiX9mFhB3YLmEiIBbB7vyEz1yoYpQ/2+UvF080nSWw0gXBa/0NIinj/Hcd7AMO+
 Tqf783RrFfRhmCIz4KB9vGJidmdqWn4/3auOa4EU64ntZHY+qJU0h7PntydYQfNjr4/q
 RsHeOcAhidep5mqTE9U+orS26rwNoKNdOCZWXbDCmAsiZKG5wrXDbV9mM+G1hJQIY0CJ
 yvmw==
X-Gm-Message-State: AOJu0YxYhau/aSpe+Kw1V2s57a2hfN31xI95GhRlwrCfGyDf80mMD1jp
 s2HaGisacmfU/6dJWwPPh0bkl2OVguM04xbEweE74A==
X-Google-Smtp-Source: AGHT+IGavaiwOlpytcCpXVAfQxF38z6mOEUzAIdCrXxzyTk9V9fZhZ99C8RAx28ZYafl07LSxHzgPQ==
X-Received: by 2002:a05:600c:1f94:b0:405:3455:d603 with SMTP id
 je20-20020a05600c1f9400b004053455d603mr63879wmb.17.1697750538954; 
 Thu, 19 Oct 2023 14:22:18 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a05600c138300b003fc0505be19sm519161wmf.37.2023.10.19.14.22.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:22:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Song Gao <gaosong@loongson.cn>
Subject: [PULL 36/46] hw/acpi: Realize ACPI_GED sysbus device before accessing
 it
Date: Thu, 19 Oct 2023 23:18:01 +0200
Message-ID: <20231019211814.30576-37-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

sysbus_mmio_map() should not be called on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231018141151.87466-7-philmd@linaro.org>
---
 hw/arm/virt.c       | 3 +--
 hw/i386/microvm.c   | 2 +-
 hw/loongarch/virt.c | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 15e74249f9..02c7a7ff3c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -647,13 +647,12 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 
     dev = qdev_new(TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].base);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms->gic, irq));
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-
     return dev;
 }
 
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index b9c93039e2..ca55aecc3b 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -206,12 +206,12 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     if (x86_machine_is_acpi_enabled(x86ms)) {
         DeviceState *dev = qdev_new(TYPE_ACPI_GED);
         qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
         /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEMHP); */
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, GED_MMIO_BASE_REGS);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                            x86ms->gsi[GED_MMIO_IRQ]);
-        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
         x86ms->acpi_dev = HOTPLUG_HANDLER(dev);
     }
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2952fe452e..4b7dc67a2d 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -412,6 +412,7 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic, LoongArchMachineState
     }
     dev = qdev_new(TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* ged event */
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, VIRT_GED_EVT_ADDR);
@@ -422,7 +423,6 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic, LoongArchMachineState
 
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(pch_pic, VIRT_SCI_IRQ - VIRT_GSI_BASE));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     return dev;
 }
 
-- 
2.41.0


