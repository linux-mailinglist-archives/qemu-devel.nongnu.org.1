Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 312787CE23F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:08:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8x2-0001XO-1l; Wed, 18 Oct 2023 11:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8wV-00010X-8D
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8wT-0007RN-H2
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fiCWXY5zmRdQNGyxHv3gzp1e9XV+cYxYi5n0fzse+pU=;
 b=TgOuSGogRzxDovkP9q0xLvcpA8bbbiSQvHXOMtNhF3OzkdKltfkh207H/yYwShHdWUWuIV
 30CDpDl/EnbP7JAD9vUmn3uVuAoEPF/MNrLd4ao+3YS3SBNp6OO9oKpAqhJ0NimI7yDslm
 6UqfgFtOIhz5aOyACg8bE2SX6c1fXC8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-ZDeoNrVdNXSC7N2W2ax3Lw-1; Wed, 18 Oct 2023 11:58:39 -0400
X-MC-Unique: ZDeoNrVdNXSC7N2W2ax3Lw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32d9b520d15so2819848f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644717; x=1698249517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fiCWXY5zmRdQNGyxHv3gzp1e9XV+cYxYi5n0fzse+pU=;
 b=GQHM78TaffZgih9SyJpnczmVoyy1yhsXbTCBCWRMy269qE8YSrddr7TTBUIZIgopph
 crdqertDOlEFfj4ntdpmRLxSs1cULYs/+qfwqvPqbUyt04oQORKGOmLX4UFyAw1FIOFP
 AirELzN6NrjeaFvdjplzPZFGRoY7KzYdjnhkTc+ZvRXFpeduhkVdFu9UThxd8pcevmAP
 pqmeJqqdz2dDGwqD9owFfvPhHvBk1TJsrM7dgEQ8PHKKldmjP0VLLrXqrRQV6eLc/Bhc
 GVDzAIoWrjS5yxsgaNmLm1EoRmo48BbFiyf62haNHwgDE9uxt9G0faoqJywScc/Npodz
 thTA==
X-Gm-Message-State: AOJu0YzZjsPV+1Zjsw/Oivn36g1l0fKFJ2qW2blNvRNOt5NDLW7yuIh0
 QrjyAcp8pubi/lAnZa8J+sA9Q9zBRbgS9r4BrjU6EONn36czzkryKWrKyzCJzluGMwl87IV5VpU
 J/njZuV1/3HbuWLz9FkpRqN/s5E+AjxVaGQEz2C++4Y0BZcA1LaNLXkgkbqo5QGAhMh4Fles=
X-Received: by 2002:adf:f847:0:b0:32d:aabf:1db3 with SMTP id
 d7-20020adff847000000b0032daabf1db3mr4613982wrq.24.1697644717763; 
 Wed, 18 Oct 2023 08:58:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4gNQGeSOzSovDtRcMuO2O6Z98JJO62/LarZvDeApv5IeG1JsVk28S2bL8RCqejDMzbKb8NA==
X-Received: by 2002:adf:f847:0:b0:32d:aabf:1db3 with SMTP id
 d7-20020adff847000000b0032daabf1db3mr4613961wrq.24.1697644717511; 
 Wed, 18 Oct 2023 08:58:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a056000055000b00326f5d0ce0asm2440158wrf.21.2023.10.18.08.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:58:37 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:58:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL 68/83] hw/isa/piix: Reuse PIIX3's PCI interrupt triggering in
 PIIX4
Message-ID: <e81b6c46133d12aa94d06464affc40e64faa5d0d.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Speeds up PIIX4 which resolves an old TODO. Also makes PIIX4 compatible with Xen
which relies on pci_bus_fire_intx_routing_notifier() to be fired.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-27-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 449c1baaab..17677c2126 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -81,27 +81,6 @@ static void piix_set_pci_irq(void *opaque, int pirq, int level)
     piix_set_pci_irq_level(s, pirq, level);
 }
 
-static void piix4_set_irq(void *opaque, int irq_num, int level)
-{
-    int i, pic_irq, pic_level;
-    PIIXState *s = opaque;
-    PCIBus *bus = pci_get_bus(&s->dev);
-
-    /* now we change the pic irq level according to the piix irq mappings */
-    /* XXX: optimize */
-    pic_irq = s->dev.config[PIIX_PIRQCA + irq_num];
-    if (pic_irq < ISA_NUM_IRQS) {
-        /* The pic level is the logical OR of all the PCI irqs mapped to it. */
-        pic_level = 0;
-        for (i = 0; i < PIIX_NUM_PIRQS; i++) {
-            if (pic_irq == s->dev.config[PIIX_PIRQCA + i]) {
-                pic_level |= pci_bus_get_irq_level(bus, i);
-            }
-        }
-        qemu_set_irq(s->isa_irqs_in[pic_irq], pic_level);
-    }
-}
-
 static void piix_request_i8259_irq(void *opaque, int irq, int level)
 {
     PIIXState *s = opaque;
@@ -223,7 +202,7 @@ static int piix4_post_load(void *opaque, int version_id)
         s->rcr = 0;
     }
 
-    return 0;
+    return piix_post_load(opaque, version_id);
 }
 
 static int piix3_pre_save(void *opaque)
@@ -442,6 +421,7 @@ static void pci_piix_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
 
+    k->config_write = piix_write_config;
     dc->reset       = piix_reset;
     dc->desc        = "ISA bridge";
     dc->hotpluggable   = false;
@@ -497,7 +477,6 @@ static void piix3_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->config_write = piix_write_config;
     k->realize = piix3_realize;
     /* 82371SB PIIX3 PCI-to-ISA bridge (Step A1) */
     k->device_id = PCI_DEVICE_ID_INTEL_82371SB_0;
@@ -522,7 +501,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    pci_bus_irqs(pci_bus, piix4_set_irq, s, PIIX_NUM_PIRQS);
+    pci_bus_irqs(pci_bus, piix_set_pci_irq, s, PIIX_NUM_PIRQS);
 }
 
 static void piix4_init(Object *obj)
-- 
MST


