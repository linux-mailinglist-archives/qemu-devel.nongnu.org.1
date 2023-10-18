Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE22E7CE210
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:02:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8x7-0001gC-RP; Wed, 18 Oct 2023 11:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8vk-00085g-EM
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8vi-0007MJ-VL
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Znu+ot2If10k79VuPHcVlyjtAkby0fPqJ4/KsGVlXE=;
 b=HoB9mQTxKNFUwLAICv/MHId/rkmlsXe71JWdI6lCznn75P3eqia/ZZMtFBgWJX3pTBMfIl
 mkWinUvxkeS66pWaxwnLizEKxUENPz6RyF3NJ6Ehk1n6DvhXXY7FkxQe12dvk9jyOAzHNb
 K8tyBVhKZclCs7YLqLt/WHZgceIQvBo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-8uggM64XPz2atV_2ISPUwA-1; Wed, 18 Oct 2023 11:57:52 -0400
X-MC-Unique: 8uggM64XPz2atV_2ISPUwA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4055ce1e8c4so36995575e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644670; x=1698249470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Znu+ot2If10k79VuPHcVlyjtAkby0fPqJ4/KsGVlXE=;
 b=mXnJXi5ubQL2BZJT3EOeqqUby9XDvimlEPG554/wLwn1hOG8TxZ/3iFiNGAptVUejF
 kDyDwiueBBkhd7Q2MvMroHgKGPJBUq4v5IKW0kqs2YyPGyfiGbdkEE68YHK2YXhsEBvj
 2XZ2F37GbIb8981roqHNZrdiDYrGpbHfQziWVgteI8JT7GFGhy5swXh3XH6DhxDvSZ7Q
 G0ZGGPllSb3XJj+vNQ0rC6PRDUCsCgqyuNsgwt/2q0l7al4YNi+pV1kndT92naR4QbaV
 Pye883YtAoceSlPx1bkAtMJ+Gv9bqDII0btO0A0Udq2CnnthUV/LfyegdKLDDNx1eXfj
 VpOA==
X-Gm-Message-State: AOJu0YyVB2LU3s4RHS8xZdydTmyzRJVSFxyofw4eAHDzQJZlrr/Gtv0Z
 KTdf0yYbyv5ztOD0ToR4otQHWvxVDEpXhf1JF26xJM5XZboCTNK2hZVxDmaySGMNLCCmQDOMD1w
 5KCmDCs0R3CyIfSwiGnZF1h9Gn1uxSrJohSLdTKjt8rOvQwISRU+ND9glILFvlIMJFTllI2g=
X-Received: by 2002:a05:6000:23a:b0:319:8c99:989a with SMTP id
 l26-20020a056000023a00b003198c99989amr5670408wrz.8.1697644670296; 
 Wed, 18 Oct 2023 08:57:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzNKBDiLuRbSIta0ccA8G7xXAt6Zd/v2wKe9deqhBteDyNSZORhKYKYVovZRuDg5qyK9hwzg==
X-Received: by 2002:a05:6000:23a:b0:319:8c99:989a with SMTP id
 l26-20020a056000023a00b003198c99989amr5670386wrz.8.1697644670021; 
 Wed, 18 Oct 2023 08:57:50 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 c12-20020adfe70c000000b0031c6e1ea4c7sm2368769wrm.90.2023.10.18.08.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:57:49 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:57:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 58/83] hw/isa/piix4: Rename "isa" attribute to "isa_irqs_in"
Message-ID: <9f6357a5404fada0723c324f237293f9395e0020.1697644299.git.mst@redhat.com>
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


