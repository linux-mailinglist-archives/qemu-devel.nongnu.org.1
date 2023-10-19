Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DAF7CF0F9
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:19:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNIf-0006PC-4p; Thu, 19 Oct 2023 03:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNHW-0005bz-W3
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:17:23 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNHV-0003HV-3J
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:17:22 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32db188e254so3105832f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697699839; x=1698304639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U89S9kSKuyZ/3CV61Or9NVPwfS9oQzSn+IyXDgGKbBI=;
 b=lxAwCtZgYcfK3pY1DoFeS/QZcZxNGrAS1zjJY2p0FJ1W8ebdFmEoAE1/4gEpHYt9JM
 q1IAkUbTr+ATcY+/acJLhPNOW8cf7xygf4KpKxBp0M7DSUM/u3G7dJ2LqUKRSTpbTxFe
 tO8aA2bryf/+UOL6aF8y8fKuO4LzQGJu2nZPLuDRmU0KsKDCB8JSUQBg+xJ/KVjoFcte
 3O3DVa0SRtxKzwkRih/9uEV4UzeIINs/q+7CRxWl5j/af2YO6BvDPPVxYtVKuIoqjJYB
 Urxk05P7l3pYFhWMmXUw+/Ot8pZmI3ciyeiyblfrfoztv86X9GIwyCwtPmj7E0TLfpNH
 H7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697699839; x=1698304639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U89S9kSKuyZ/3CV61Or9NVPwfS9oQzSn+IyXDgGKbBI=;
 b=v2iXbpPGInPSar5NxLHWpoxBhcf1saJqlR40/esx7fO9m3bDmgPfY+VxMS/IHKhz3A
 OlnyR8OtvhKTp7XJ++seHaaccs+aBnnkOb3QgzZaNbY/+fnxnBsMgjE6dx2+HxiAZjRK
 UPUfbA5dLqHE/qNfHSDX3PXs4YM6h333qF4mdoM0w81G4sjbCl0rtEpfTTGsiF9ARcJ4
 M8oDcCCfTcCiN++MwsB3Ay7VD3cDpZt0udN1yr786SGgQhBgkVPh5JTfjf5WD+5tTT4w
 It0zySg9SZS8ikAh6nhNh9ADCgJal0fkvOsZFMu3nNyTNV1hjfFp1aJiJGEv0XGtoXs1
 BD9A==
X-Gm-Message-State: AOJu0YyQcNv6IlAT4WvHX0/6WS59F4WMlAUkxAy9nFbD9RoedZXZeBBY
 lnlxY5WyzRU6//fJaRB4DNXgzRnzOgm6RuCvzNHNIw==
X-Google-Smtp-Source: AGHT+IFaHkNJUYCsbixe1AIqoj4FtZdLSMRwcOlgosJtCxO6BgbZd32vHdPzP216ECFF1kIdkO45IA==
X-Received: by 2002:adf:f50d:0:b0:32d:b114:fc96 with SMTP id
 q13-20020adff50d000000b0032db114fc96mr790162wro.37.1697699839316; 
 Thu, 19 Oct 2023 00:17:19 -0700 (PDT)
Received: from localhost.localdomain (92.red-88-28-12.dynamicip.rima-tde.net.
 [88.28.12.92]) by smtp.gmail.com with ESMTPSA id
 e11-20020adffd0b000000b0032dbf26e7aesm3754965wrr.65.2023.10.19.00.17.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 00:17:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eric Farman <farman@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 06/12] hw/acpi: Realize ACPI_GED sysbus device before
 accessing it
Date: Thu, 19 Oct 2023 09:16:04 +0200
Message-ID: <20231019071611.98885-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019071611.98885-1-philmd@linaro.org>
References: <20231019071611.98885-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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


