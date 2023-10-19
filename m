Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 179217D01C6
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:36:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhV-0000x1-MK; Thu, 19 Oct 2023 14:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgJ-0007ci-In
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgI-000185-1z
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Znu+ot2If10k79VuPHcVlyjtAkby0fPqJ4/KsGVlXE=;
 b=A5W1J+Rjz4l30b5+a8uY0gtOBBdSwI6HRnpud/qX9HS+numpUO3h/Uy5Gjp7typaf2M6Xo
 tEs0YXcTih2tv3/GlZvLdL7R0GLo5sIibWIs9QHtfk2hcscaMz20C2xWMz0cckIKoyh7wK
 P5qO0JMuIL6Wp+aIDluT0LoxTsVOrVk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-dakfV37uO6m3UvYcpUuWEQ-1; Thu, 19 Oct 2023 14:23:36 -0400
X-MC-Unique: dakfV37uO6m3UvYcpUuWEQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40566c578b7so58470955e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739814; x=1698344614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Znu+ot2If10k79VuPHcVlyjtAkby0fPqJ4/KsGVlXE=;
 b=aM5NiMPdoT+Yp763JwG0DCaX5aheCiZZOUTJHZ8UlkKcFixKqPooaM096ssS8F1cjy
 eraHfBXHBg4yeaQD8gKLCCZo/1E90rvyBENP35chW1JThy29K5GwJpw/AQ6iUuL0Bqxk
 120GPahdn/WjXcj2iFjGsf8i6/NMExnrxtX2oCrM21uizAdm2WNwcesLNrPV4fa9lk/m
 2CpZJF76lLIJXvuMOC2JjQfYW55VQJGr3dZLmJIjeeW6d7bqRFgiFZaa2sdGMTG8+vfE
 Nh2VVVpYOz6QE2WoHnQodqNujFMiLskBcrQq4Jx69EJIgT7W618wNCRgsENiJwdkX7Nq
 2ddQ==
X-Gm-Message-State: AOJu0YxcMY/+R8qrmuByYBCDPNpkSpA9yVeNxRhUs+YkmWrQOToxRSBn
 N6vZT28bpCo9YD9OZQIgqu0aHTTY9FbhZKI99XDx61CMfUm63q190Yeov2VXMt58wDVIa5/bHLS
 IL5IgQJkDuuFKjmFcR8LB0+uyztc+6JG9YfUgr21g2jPoAhvieOdvj1i4XTYFg+eWdOhv
X-Received: by 2002:a05:600c:4f02:b0:405:3885:490a with SMTP id
 l2-20020a05600c4f0200b004053885490amr2483475wmq.0.1697739814452; 
 Thu, 19 Oct 2023 11:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHag+OIC9wYmgn9XXXqPzfBMyI8pli+yrI7wc4krbX/n1Q+WbdTe9Ffh+hVaUpQSje/lu/07w==
X-Received: by 2002:a05:600c:4f02:b0:405:3885:490a with SMTP id
 l2-20020a05600c4f0200b004053885490amr2483463wmq.0.1697739814142; 
 Thu, 19 Oct 2023 11:23:34 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 r6-20020a05600c458600b00406443c8b4fsm5084043wmo.19.2023.10.19.11.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:33 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:23:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 53/78] hw/isa/piix4: Rename "isa" attribute to "isa_irqs_in"
Message-ID: <03a4bf0885c29cc240fbef0598c4e248d01ffd04.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


