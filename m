Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC937CE209
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vS-0006ju-FL; Wed, 18 Oct 2023 11:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8vK-0005zi-Nh
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8vI-0007JF-R8
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4mhfXj45nr0zKARw7EbZ1yJ39RO40+yefJvQYbdbnLw=;
 b=HUiA9mcm3aPVd3QEeKGYL4bgUBjVIUPzYMF/gXy3O/8OGNDLK8cf6Aa8kTgLfZjUsnwXPS
 II9o06ZN6m+DzwTNjTtOdAxrT5oQYlIQTiwGc8m5iTHmDXaT19nNxzJNwHaoja6ldIeEcU
 +AAAmC2QzH6lW+D+PssnCtS3mmJOTic=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-7c3685XpM0q3jFiybGFrIQ-1; Wed, 18 Oct 2023 11:57:16 -0400
X-MC-Unique: 7c3685XpM0q3jFiybGFrIQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4053a5c6a59so44809395e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644635; x=1698249435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mhfXj45nr0zKARw7EbZ1yJ39RO40+yefJvQYbdbnLw=;
 b=bfenzwEwx3mJKcqrkXtzMLPh4nSWY5BENKyRRgCwQH3o3wcO/2IQ+efS1EZ1ySv2Sz
 Stv13cSgZKJ7VUF/JiBy7xVVkzA6QsCm+behJNqKJ8zEudgm3v9o6d+899xq9usfCh9m
 dWhdFblq8EAiQcEItxSbkVVhz42WMOb9sc685iSo2NT+wMITqruiWtICt1HxldiRUx1K
 OaJuEFXf/2Sq5V6eFv48ft8hT0Q5bOGfZgcwlcyIj8RUwmN+HEAdU+Jm7IasByt8KqdN
 JYWgBGDAjdCs90dXhl43LSKJWkMj0L0etUvpZZPF9mPlxWg7qN36yGyZaX7IgMg3nq65
 6f6w==
X-Gm-Message-State: AOJu0YwTELoiKGvly3eXvpCbKKyy2VMURjjL+O9uQztEHOYqMe0r7cFA
 g1Ah99xSTDW7rkM8HN/2cqLmZPWuxeiXELoC6xjG+h27aedHDM6fSF5AkZzqxOqH4qWkHmjuN5C
 gl6EU+CoWdEY/nyYBOqFPYkqMxMqYrDjqiebOnXQTHOFQtCQ1fxF6eu8h/n60KWGncHTuM9w=
X-Received: by 2002:a05:600c:3b2a:b0:406:847a:2934 with SMTP id
 m42-20020a05600c3b2a00b00406847a2934mr4426143wms.28.1697644634870; 
 Wed, 18 Oct 2023 08:57:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfE8AQgClSjGCnYIj1Px+ZWiGoaw4sLEpmfFVGXbzrbahUkm9t1Agci4QuFZwWnbhR8cPKJw==
X-Received: by 2002:a05:600c:3b2a:b0:406:847a:2934 with SMTP id
 m42-20020a05600c3b2a00b00406847a2934mr4426117wms.28.1697644634405; 
 Wed, 18 Oct 2023 08:57:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a1c6a0d000000b003fe23b10fdfsm1964667wmc.36.2023.10.18.08.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:57:13 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:57:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 50/83] hw/i386/pc_q35: Wire ICH9 LPC function's interrupts
 before its realize()
Message-ID: <1594e3eee0f85bdc017a7ebf089167296ef394a7.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

When the board assigns the ISA IRQs after the device's realize(), internal
devices such as the RTC can't be wired in ich9_lpc_realize() since the qemu_irqs
are still NULL. Fix that by assigning the ISA interrupts before realize().

This change is necessary for PIIX consolidation because PIIX4 wires the RTC
interrupts in its realize() method, so PIIX3 needs to do so as well. Since the
PC and Q35 boards share RTC code, and since PIIX3 needs the change, ICH9 needs
to be adapted as well.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-9-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_q35.c  | 14 +++++++-------
 hw/isa/lpc_ich9.c |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a7386f2ca2..597943ff1b 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -242,11 +242,18 @@ static void pc_q35_init(MachineState *machine)
     host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
     pcms->bus = host_bus;
 
+    /* irq lines */
+    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+
     /* create ISA bus */
     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
                                 TYPE_ICH9_LPC_DEVICE);
     qdev_prop_set_bit(DEVICE(lpc), "smm-enabled",
                       x86_machine_is_smm_enabled(x86ms));
+    lpc_dev = DEVICE(lpc);
+    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
+        qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
+    }
     pci_realize_and_unref(lpc, host_bus, &error_fatal);
 
     rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
@@ -273,13 +280,6 @@ static void pc_q35_init(MachineState *machine)
                                    "true", true);
     }
 
-    /* irq lines */
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
-
-    lpc_dev = DEVICE(lpc);
-    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
-        qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
-    }
     isa_bus = ISA_BUS(qdev_get_child_bus(lpc_dev, "isa.0"));
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 3f59980aa0..3fcefc5a8a 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -675,6 +675,9 @@ static void ich9_lpc_initfn(Object *obj)
 
     object_initialize_child(obj, "rtc", &lpc->rtc, TYPE_MC146818_RTC);
 
+    qdev_init_gpio_out_named(DEVICE(lpc), lpc->gsi, ICH9_GPIO_GSI,
+                             IOAPIC_NUM_PINS);
+
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
                                   &lpc->sci_gsi, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
@@ -691,7 +694,6 @@ static void ich9_lpc_initfn(Object *obj)
 static void ich9_lpc_realize(PCIDevice *d, Error **errp)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(d);
-    DeviceState *dev = DEVICE(d);
     PCIBus *pci_bus = pci_get_bus(d);
     ISABus *isa_bus;
 
@@ -734,8 +736,6 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
                                         ICH9_RST_CNT_IOPORT, &lpc->rst_cnt_mem,
                                         1);
 
-    qdev_init_gpio_out_named(dev, lpc->gsi, ICH9_GPIO_GSI, IOAPIC_NUM_PINS);
-
     isa_bus_register_input_irqs(isa_bus, lpc->gsi);
 
     i8257_dma_init(isa_bus, 0);
-- 
MST


