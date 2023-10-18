Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F87CE23D
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:08:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8wm-0001G5-Ll; Wed, 18 Oct 2023 11:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8v3-0004YV-MG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8uz-0007DM-LR
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o+ER8U4zTaPMQSzbJAzk8GehGsCBqp1JYIJr1D7ENQ0=;
 b=URqiGQBQtfrp1wOPWiEIfyhtx8W9Ng/5Jgq1VzNVnCK/IyJpARPfQy3GOnHuFYyXqHr8Rl
 flBOtowsyIOPcnyQjbBDwwVE8iqa65q0IaNM1wVV+6EVHws8iCEB5gSkizrszyXotSYoEM
 K4mV2BIDxyJG7mQzCbH2jMVMV0FETPk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-naKvYCdJPj6HGLThrM2dBg-1; Wed, 18 Oct 2023 11:57:01 -0400
X-MC-Unique: naKvYCdJPj6HGLThrM2dBg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084001846eso3580815e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644620; x=1698249420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+ER8U4zTaPMQSzbJAzk8GehGsCBqp1JYIJr1D7ENQ0=;
 b=S8cNKgufEPFBcnHYlMMnR5x7b5ITnkkUB4xXHuOtwhjTFvog4WBIExnQg4950VbtZu
 fDp5X34m/J7+zHjbibqGT1gQmIsz7I/o99wTY3FwELAAd0tIJskupHopHC2Z3WhFUU1K
 tJjaImNXYHcqIGEGVkk4Gy7Ri7l2pZJtUVwlVVKxIFp2A90pqP9uSU0volkrphXn1dSH
 YftH+TC0V2Nkd+cSUB8lnlW1+PTHqcpPunLLR+E1uZQK40e7oZWZWiWO1DnC4gUr/g6q
 5H3ru4RR2ycrzDj5NayqmySkdvlKJmsaWbulNB0EWK0H+IYTihzJyUCoqUVuPRBX5j0L
 CefA==
X-Gm-Message-State: AOJu0YwCqxwMgWWKtt/HZwamnWIUcIt6Nl8hae9RYSWASN5mW9KETImx
 0wYzIgjlMv3mrA1nLZ3XhXjPtXF1XiW9ysPDTF5Hb3Iz05Y+hEYYFeIdprz1EGCxqmKBt09Gbrp
 PkxWPm6da0acx1ZorpGHETRvr6dwyCzgfcZhBqmGr7KHufk5u32V1zEAK0MvGhL6kAcrGU9Q=
X-Received: by 2002:a5d:6308:0:b0:32d:a6f5:a511 with SMTP id
 i8-20020a5d6308000000b0032da6f5a511mr4208135wru.13.1697644620158; 
 Wed, 18 Oct 2023 08:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbKurOWUKoDT/MGxEF9R3whiG8pe13SZgkGotCctbNjS+W67QN9JQoZ7M8zk6ntZUnyRhrNw==
X-Received: by 2002:a5d:6308:0:b0:32d:a6f5:a511 with SMTP id
 i8-20020a5d6308000000b0032da6f5a511mr4208117wru.13.1697644619716; 
 Wed, 18 Oct 2023 08:56:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 b3-20020adff243000000b003258934a4bcsm2401664wrp.42.2023.10.18.08.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:56:59 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:56:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL 47/83] hw/i386/pc_piix: Wire PIIX3's ISA interrupts by new
 "isa-irqs" property
Message-ID: <c794a1fd25b256f3d56a382b395dcd87981ff0a4.1697644299.git.mst@redhat.com>
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


