Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 837227D2226
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:24:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUgi-0007tL-4z; Sun, 22 Oct 2023 05:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgg-0007jq-4q
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUge-0000RX-FM
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o+ER8U4zTaPMQSzbJAzk8GehGsCBqp1JYIJr1D7ENQ0=;
 b=GxppYIC6uD5EmQXm+C+Sbz/jr8OCFd6qazfHZ8GWzaXBokzwgfLA2y6yepVYBo2P7r1X+L
 /jRopDUA6FCHpRQEHEX9zXCQPN4+ST5KolFqXHuDJxIiDNCJSkLBORh0A7QqsTPelluE59
 adB7pEv5dsPnk3UWS2jVer4KsoOIEsw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-zQxErQypPrebsYaqhlLCuQ-1; Sun, 22 Oct 2023 05:23:54 -0400
X-MC-Unique: zQxErQypPrebsYaqhlLCuQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32db6a28e24so932124f8f.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966632; x=1698571432;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+ER8U4zTaPMQSzbJAzk8GehGsCBqp1JYIJr1D7ENQ0=;
 b=dRFXZsknZtUxVRWl4oMgWaGiAElso3BvEZT1gS34CgX+ofoOfzzt9HWVyW4Fnglmjj
 DKO+F9/Y6Wyjqq5RuECfLyLlNa1yW95x0qiG6/GwtbvtKwU8VpfDTp5a7Py+BKTf1NQx
 Wi48+FvF730g7v6SjYmA6mX88+vvC6vTvi2NBKogSCxM5YeI3BauraMojYL7NqbGk5OX
 +HEZic7io72o+Wtn7xxD9mxx5ea1z3/ejE1gxR5D3z7od84AE3wEL7FWMvouu8DBhQUS
 szjivKB6e6OJADrCLnnGm5uPQ/DXa0RapOw8UP+LskX2iudo6Voh2YnfmsgPm4/0Q4N6
 5QlA==
X-Gm-Message-State: AOJu0Yxz68m0zmHDZUV3Ns163RuKTU015mJ2eSpOIQgbOQA833tm1SIV
 hq7s3ZPtucHtdy7DoWpTi9CgZueDLDd7ERzr8Ejqtbdd8/d4tw4UPUYxqe9PaS8bIyrznwYvxOl
 cXzwR8ru1q5Gl4eAtP5CkJEV+vueJOFU8Nbfwr2SWNXBXZtRPMETs2/B0p/I9pTgKPVCh
X-Received: by 2002:a05:6000:b41:b0:32d:8f4c:a70b with SMTP id
 dk1-20020a0560000b4100b0032d8f4ca70bmr5014890wrb.9.1697966632265; 
 Sun, 22 Oct 2023 02:23:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8n6n8WTkF9R4xRimvLadXYvlJa1hS6SOlK6EL6ZPhHXrHE1CT2q1CC3HO1o5s5QLB5vHzUg==
X-Received: by 2002:a05:6000:b41:b0:32d:8f4c:a70b with SMTP id
 dk1-20020a0560000b4100b0032d8f4ca70bmr5014872wrb.9.1697966631971; 
 Sun, 22 Oct 2023 02:23:51 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 l7-20020a5d6687000000b00327bf4f2f14sm5228813wru.88.2023.10.22.02.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:23:51 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:23:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL v3 26/62] hw/i386/pc_piix: Wire PIIX3's ISA interrupts by new
 "isa-irqs" property
Message-ID: <001cb25f3fb84768db4c1fb0ffd77779e0676745.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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

Avoid assigning the private member of struct PIIX3State from outside which goes
against best QOM practices. Instead, implement best QOM practice by adding an
"isa-irqs" array property to TYPE_PIIX3_DEVICE and assign it in board code, i.e.
from outside.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-6-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/piix.h | 2 +-
 hw/i386/pc_piix.c             | 7 ++++++-
 hw/isa/piix3.c                | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 2317bb7974..bb898c6c88 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -46,7 +46,7 @@ struct PIIXState {
 #endif
     uint64_t pic_levels;
 
-    qemu_irq *pic;
+    qemu_irq pic[ISA_NUM_IRQS];
 
     /* This member isn't used. Just for save/load compatibility */
     int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a003923788..4dc7298c15 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -263,10 +263,15 @@ static void pc_init1(MachineState *machine,
     if (pcmc->pci_enabled) {
         PIIX3State *piix3;
         PCIDevice *pci_dev;
+        DeviceState *dev;
+        size_t i;
 
         pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
         piix3 = PIIX3_PCI_DEVICE(pci_dev);
-        piix3->pic = x86ms->gsi;
+        dev = DEVICE(pci_dev);
+        for (i = 0; i < ISA_NUM_IRQS; i++) {
+            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+        }
         pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
 
         if (xen_enabled()) {
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 7240c91440..c17547a2c0 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -312,6 +312,8 @@ static void pci_piix3_init(Object *obj)
 {
     PIIX3State *d = PIIX3_PCI_DEVICE(obj);
 
+    qdev_init_gpio_out_named(DEVICE(obj), d->pic, "isa-irqs", ISA_NUM_IRQS);
+
     object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
 }
 
-- 
MST


