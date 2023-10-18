Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF927CE229
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:06:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8wy-0001PX-6x; Wed, 18 Oct 2023 11:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8wg-0001DK-DO
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8we-0007Tj-ON
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XEKbyD70yRR+QPK/g+c3Uv20C9zzfiDuTxSKNieues8=;
 b=MRX9gjnlxzSnrgraJtp5Aml82JCSR1gaxsMUAfoSl4rcW8u99qgRmAYdvzo10OqOKdKhYB
 MouEa6Uu2YUm6k16soifHji/H77sVoXtVyNkGKn/NYomhgaNAVMhCQW8P7YOcDmERjgDtP
 frZg/7dOOWq5A6Z/P1SSj5FPZDvXoRo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-JNZLvar3OlqKoLLwF6D3ag-1; Wed, 18 Oct 2023 11:58:44 -0400
X-MC-Unique: JNZLvar3OlqKoLLwF6D3ag-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso46863395e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644722; x=1698249522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEKbyD70yRR+QPK/g+c3Uv20C9zzfiDuTxSKNieues8=;
 b=H2LXzHn877MWzLbrhu/vbeqFGFb0A/NwBAB0p5ATKJBq6k3GPEyZo7T6yUeo3RtCO4
 xX/1rzfCth98CNF6pQF8AZOBmJWrUaDoKVQ0730/1telosP+cRM/R3VCz4Ya6u57dOB4
 +3eUBnnxlONokNzFK4Nn8BKdeFnp8FJTieisIv8fZDNCZ+zYrc8fR/OXUZCQ4RWuJq7T
 sQ7AdK0MiTchDGVRCtQEzkT0O2hl/Ry6V9wzISi7O6np/99s4/QwyDZE0kuKCV1EK+K9
 /qpX7boD9SsbGJc/1/dw/zVmbyn1aiIO21jQLzEcVkrh+ZmEbMHfPr1O8MkyYdB/h1X9
 0lVA==
X-Gm-Message-State: AOJu0YzQXlfu4blhKkT9zEgRYeRIEPyq/EmZ+1ZN2NgdxXsYY2tIajyo
 Az8+4AEye0FmWBTnWCKK6II4U6dl4f5lNedDDfNzWQFLJUGW3SWQ5HDTs7td/zA/sXJknkIm0X/
 JKezABf8Zbx5IXR4qkAtLYHNEjLgvzXxNgr8YToNoJCzVvDOaCFhXw7W5NveKKtjCFYCFIGE=
X-Received: by 2002:a5d:510e:0:b0:32d:a0d9:2124 with SMTP id
 s14-20020a5d510e000000b0032da0d92124mr4216332wrt.35.1697644722709; 
 Wed, 18 Oct 2023 08:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv73jpTfjeQbiY9r37C5PWRnj33CUVtf1dqOS5J/5BP9pCedeR97jfDBrAob9gmHDSZX0D4g==
X-Received: by 2002:a5d:510e:0:b0:32d:a0d9:2124 with SMTP id
 s14-20020a5d510e000000b0032da0d92124mr4216318wrt.35.1697644722470; 
 Wed, 18 Oct 2023 08:58:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 j4-20020adfe504000000b0032da7454ebesm2396161wrm.79.2023.10.18.08.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:58:41 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:58:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL 69/83] hw/isa/piix: Resolve duplicate code regarding PCI
 interrupt wiring
Message-ID: <2731d8bd2b8b9ed842fe2c7928b702f97b5852a3.1697644299.git.mst@redhat.com>
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

Now that both PIIX3 and PIIX4 use piix_set_irq() to trigger PCI IRQs the wiring
in the respective realize methods can be shared, too.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-28-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 17677c2126..cba2098ca2 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -372,6 +372,8 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
         }
         qdev_connect_gpio_out(DEVICE(&d->pm), 0, d->isa_irqs_in[9]);
     }
+
+    pci_bus_irqs(pci_bus, piix_set_pci_irq, d, PIIX_NUM_PIRQS);
 }
 
 static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
@@ -453,7 +455,6 @@ static const TypeInfo piix_pci_type_info = {
 static void piix3_realize(PCIDevice *dev, Error **errp)
 {
     ERRP_GUARD();
-    PIIXState *piix3 = PIIX_PCI_DEVICE(dev);
     PCIBus *pci_bus = pci_get_bus(dev);
 
     pci_piix_realize(dev, TYPE_PIIX3_USB_UHCI, errp);
@@ -461,7 +462,6 @@ static void piix3_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    pci_bus_irqs(pci_bus, piix_set_pci_irq, piix3, PIIX_NUM_PIRQS);
     pci_bus_set_route_irq_fn(pci_bus, piix_route_intx_pin_to_irq);
 }
 
@@ -492,16 +492,7 @@ static const TypeInfo piix3_info = {
 
 static void piix4_realize(PCIDevice *dev, Error **errp)
 {
-    ERRP_GUARD();
-    PIIXState *s = PIIX_PCI_DEVICE(dev);
-    PCIBus *pci_bus = pci_get_bus(dev);
-
     pci_piix_realize(dev, TYPE_PIIX4_USB_UHCI, errp);
-    if (*errp) {
-        return;
-    }
-
-    pci_bus_irqs(pci_bus, piix_set_pci_irq, s, PIIX_NUM_PIRQS);
 }
 
 static void piix4_init(Object *obj)
-- 
MST


