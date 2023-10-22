Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1977D224A
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:29:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUhW-0004Wv-ET; Sun, 22 Oct 2023 05:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhU-0004La-KG
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhS-0000bv-Ja
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Znu+ot2If10k79VuPHcVlyjtAkby0fPqJ4/KsGVlXE=;
 b=TzJo+/N92jT8zKbfMey5/xjIJrZbqYHYZez0ig8/oARy5hCa03Vh8vaHILxsh/6TY3Y2M3
 rhGA9KojldYrasPraKxXMELC2CFMk8O9UqjWb+7PdSwxjn8XHf/PXbwVbFrtLGII5Cq3qT
 UZsBu7EFO/RDcyERqNBSWnshXFAB/6E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-HbYj1B1HNRaDyGXg0CkYtw-1; Sun, 22 Oct 2023 05:24:38 -0400
X-MC-Unique: HbYj1B1HNRaDyGXg0CkYtw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32d931872cbso1110204f8f.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966676; x=1698571476;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Znu+ot2If10k79VuPHcVlyjtAkby0fPqJ4/KsGVlXE=;
 b=tX5PUCHcPljSO01NHUwiLy2DEQYLkeahM78yt7vcun3X1HWAsKFOPPxRxupXA89nR2
 j8Egjx/ox2I1o8l1me4s4sw6esCEIwaDm5ozm4rD2HEVpkbXfp8nXlW9pSmx+8qvXXyv
 1Cll/pv+xh6W/9LH+kgQogDWLjNot4eXb2hkUdsX6HDp+ZdHPmXw/ynXwPSGd8MQs4ak
 yoBWKvou01scLPljRogKfcbziQOyitYFXp84X3j8jWa1seDccnqBwEUdAWdrogBqyxGH
 7j31jr/JQcSLyrYaxQ/7Y+Nw76j/kPVQ2+aAwKu79htJ9Ij9OOVC8p78Ar7l89ojV2sb
 aJwA==
X-Gm-Message-State: AOJu0YyyVRssBuNSXStYSQ7BRrFoZYvNu+9LbZfubLV05ZErFtVISVr5
 P6lhXos5CDERhiiT6mkNgfi5yWVDaz6OoFD9HQZfbO6nKJ08UUzafkSZtflPrSFLu9qaugMeE//
 r06qv8fwaRdtGFoydQuZUQelPDvLBuI6QqF7lLG/hxaX6QhGOQ9WwVj6FGbHcDUrWCUQ4
X-Received: by 2002:a5d:4bc2:0:b0:32d:88dc:b219 with SMTP id
 l2-20020a5d4bc2000000b0032d88dcb219mr4067273wrt.45.1697966676403; 
 Sun, 22 Oct 2023 02:24:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrzodywWsXjBwhaSH+wpfanVae4ocBkcjlfFeuV8yphwAggL2+MIOoZZqRiix+GmUWcbrXNA==
X-Received: by 2002:a5d:4bc2:0:b0:32d:88dc:b219 with SMTP id
 l2-20020a5d4bc2000000b0032d88dcb219mr4067262wrt.45.1697966676060; 
 Sun, 22 Oct 2023 02:24:36 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 g18-20020adfa492000000b003232380ffd5sm5286360wrb.106.2023.10.22.02.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:24:35 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:24:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 37/62] hw/isa/piix4: Rename "isa" attribute to "isa_irqs_in"
Message-ID: <de710ac40867a409d5e3fbd83940ce9e1f6922d7.1697966402.git.mst@redhat.com>
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

Rename the "isa" attribute to align it with PIIX3 for consolidation.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-17-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix4.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 3c3c7a094c..9c8b6c98ab 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -45,7 +45,7 @@
 struct PIIX4State {
     PCIDevice dev;
     qemu_irq cpu_intr;
-    qemu_irq *isa;
+    qemu_irq *isa_irqs_in;
 
     MC146818RtcState rtc;
     PCIIDEState ide;
@@ -75,7 +75,7 @@ static void piix4_set_irq(void *opaque, int irq_num, int level)
                 pic_level |= pci_bus_get_irq_level(bus, i);
             }
         }
-        qemu_set_irq(s->isa[pic_irq], pic_level);
+        qemu_set_irq(s->isa_irqs_in[pic_irq], pic_level);
     }
 }
 
@@ -201,10 +201,10 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
 
     /* initialize i8259 pic */
     i8259_out_irq = qemu_allocate_irqs(piix4_request_i8259_irq, s, 1);
-    s->isa = i8259_init(isa_bus, *i8259_out_irq);
+    s->isa_irqs_in = i8259_init(isa_bus, *i8259_out_irq);
 
     /* initialize ISA irqs */
-    isa_bus_register_input_irqs(isa_bus, s->isa);
+    isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
 
     /* initialize pit */
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
@@ -236,7 +236,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
     if (!qdev_realize(DEVICE(&s->pm), BUS(pci_bus), errp)) {
         return;
     }
-    qdev_connect_gpio_out(DEVICE(&s->pm), 0, s->isa[9]);
+    qdev_connect_gpio_out(DEVICE(&s->pm), 0, s->isa_irqs_in[9]);
 
     pci_bus_irqs(pci_bus, piix4_set_irq, s, PIIX_NUM_PIRQS);
 }
-- 
MST


