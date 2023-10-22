Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A4F7D2241
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:28:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUiP-00075h-Rx; Sun, 22 Oct 2023 05:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUiN-00074o-UV
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUiM-0000tS-Fl
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XEKbyD70yRR+QPK/g+c3Uv20C9zzfiDuTxSKNieues8=;
 b=T7yR/QbvPWZn3VJ8uJScS+hLTnBE4JXwVqWwgplnaZR5+2CpfHLUXghAzsut3Y/+Qdm3up
 sTluKabyPTnX9NGezeMesvhWoh4EKSDiV5sb9bHdlLFk+eg8GYQZpDt7MbraceyW7ZDjIJ
 B7i8Q1iKQWR0cGTCtdSG8qmpOXgFTr0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-ssul3wYyN1GVafeVvN-XRw-1; Sun, 22 Oct 2023 05:25:24 -0400
X-MC-Unique: ssul3wYyN1GVafeVvN-XRw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c51a7df557so18864361fa.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966722; x=1698571522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEKbyD70yRR+QPK/g+c3Uv20C9zzfiDuTxSKNieues8=;
 b=r2mpR//69FE3s9xYWWU8+jHiHF8Oybk/WVHqP6Kgk58e469c4Ya9Jz3j+0IGdocmhl
 ikhL53ThAUXaswfLypKXcgwlBnpiRzjyFiwsRKDIjLUuOqSfoaYSYCH0Yp1l2QlmO/mP
 e9ipEzpcM3YJSmdjj2s939SjnQlL5V1ZweTAa/fHhrlVURwpRlvX+5yICQRNMruKPtMp
 LeaoSCQ0sDBlhLTgC9ANBLCJbjPwIhcbLlIxCePA5ZthM9bfbDxvsPf7VrWDoI5d0N0L
 CRgrWSARHLeWfMWaTWNpovlVX7CVlyWDQlb41qcIdI0zb2xHWUFd2t+6g79SBVwJQrcS
 nEjA==
X-Gm-Message-State: AOJu0YzXWRGi/1wrFq8ifGWc9YlhCs/jeDiAWQO8j8cnCIqXWd0mS3RF
 t0GviJXXQdtiNvLxkqQiXeU8Fpaa9bz+DuQElYh2NLmkuq6PiZCtIm01dxqAEyUM5RfFLIzigtq
 57hi4LrydCiTjFcyWDk2qCi1LXLjV5niHDAOksWVrpnTc1s+ujFd/Zm+HpnP+AkAtuMRJ
X-Received: by 2002:a05:651c:b09:b0:2c5:82c:73d3 with SMTP id
 b9-20020a05651c0b0900b002c5082c73d3mr3783194ljr.40.1697966722284; 
 Sun, 22 Oct 2023 02:25:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Ey6bFpr41sOGY8fBoKgT86UNuKxQdUBlw991KC78F5bZIYEy7EjkxSjBuJ0TcuD2MI5UQA==
X-Received: by 2002:a05:651c:b09:b0:2c5:82c:73d3 with SMTP id
 b9-20020a05651c0b0900b002c5082c73d3mr3783179ljr.40.1697966721984; 
 Sun, 22 Oct 2023 02:25:21 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 r4-20020a05600c458400b00405391f485fsm6419369wmo.41.2023.10.22.02.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:25:21 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:25:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v3 48/62] hw/isa/piix: Resolve duplicate code regarding PCI
 interrupt wiring
Message-ID: <a203cc532a18fdb89942fa8c87d332a2a3470379.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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


