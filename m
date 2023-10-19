Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E72CF7D017A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhn-0001bS-2m; Thu, 19 Oct 2023 14:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgy-0008VH-Hl
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgx-00023t-2A
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XEKbyD70yRR+QPK/g+c3Uv20C9zzfiDuTxSKNieues8=;
 b=e6VxD3zvLkpfHv+dq1mFegadXBXnQ5ND8mCG90rBCJ8OjvbuE9S1m+/54O5+0IP68NNE0y
 T2WSEfhYTWk1TlYPxPLAYWfMNneYlrEokdVmsbe0olfRYQ8gb4DZgcF5vv5pVouOeIHWm7
 nYHTCtf703Ck5ucixljj/TIpiBFdh3Y=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-9U4KaKgtMYS0EFLRvAwhag-1; Thu, 19 Oct 2023 14:24:07 -0400
X-MC-Unique: 9U4KaKgtMYS0EFLRvAwhag-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c5047f94bdso53554271fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739845; x=1698344645;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEKbyD70yRR+QPK/g+c3Uv20C9zzfiDuTxSKNieues8=;
 b=iegFu3mGMHK1A0naynyhRxHvZbyGxS9K6S4kJPLFCzVjTEa6K4W6kXiUCBwKoKAg2w
 7SniTRg0Qiwr+fxO3puzu6/S6xu7P+UXQdbcduUipGGBwkEiT1ebmhQa+XA4RY65o12G
 DiMxLZihR4bIYQf288IKPsF2zPIFAZzM/fS4mnQt4Ob4cFwm6GGj3EYu1Fcwue3BTCt9
 P+afJNaSCMnRSA0ldNrPExwrjwggE/rft8NgAFinWcGbhIiGDE+OAdQsf6E2DACcj0L9
 GWHInSX/okqlpfW1rYV/EZtGVxZAlegogySNHbQqo7Eyo4ERuixNDMgtLKDpzUorBD63
 nesw==
X-Gm-Message-State: AOJu0YzB4lSaNXeCPUff4Fs/7fXDIIa7ogvepKUcq1KZVsA/KN1POPfA
 c/mb6nBmihgiSikZ2yZNBri/do3yk8sriGOY/8oNEDIxBchMN4cFtSO6iYP2a0pciboQ8NuPTaD
 5MIrXj3lbZT2BCerRkIO3e98MevxYZUml2bZRNq615B4a5KN4RYmUvQjqKE2CI9FggVJ3
X-Received: by 2002:a2e:7e08:0:b0:2c5:18a9:620b with SMTP id
 z8-20020a2e7e08000000b002c518a9620bmr1856528ljc.23.1697739844965; 
 Thu, 19 Oct 2023 11:24:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0gPct7iIZN7U0V5vJfusj2WOHnOzYVU/1w58du5x+spPshaBN9azkFK/3EmheMkJ+d/+dNA==
X-Received: by 2002:a2e:7e08:0:b0:2c5:18a9:620b with SMTP id
 z8-20020a2e7e08000000b002c518a9620bmr1856513ljc.23.1697739844648; 
 Thu, 19 Oct 2023 11:24:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a05600c1c8600b003fe1c332810sm5040066wms.33.2023.10.19.11.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:24:04 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:24:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL v2 64/78] hw/isa/piix: Resolve duplicate code regarding PCI
 interrupt wiring
Message-ID: <852a2968b658d709d5fa20785b3e0975bbe5e740.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


