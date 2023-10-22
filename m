Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0F77D223A
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:28:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUgq-0000VI-I2; Sun, 22 Oct 2023 05:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgo-0000JQ-31
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgm-0000TA-Hi
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EV0w/juyamhfIdi/nYYRPk3ACWIP8V+WfsiMSqIQCVQ=;
 b=Em7IVpB4TtQk0G4LIZUnh53DPIGTQu79K1M1U38zw/8nLi04nxtL+P6o2rWkTYycVBOo4I
 hScfnPeP+3fSwV0Y+wbc13ERiGQMITZMhnQ57epN8U2fFSP4qVAShUXX9wb1Vz6u0S8cdV
 LpeFoB1J4J/+4/v5ZlcbHGHv8nWXvcY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-3V00a8lEPyuhHChYBTiduQ-1; Sun, 22 Oct 2023 05:24:01 -0400
X-MC-Unique: 3V00a8lEPyuhHChYBTiduQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40839252e81so13210695e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966640; x=1698571440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EV0w/juyamhfIdi/nYYRPk3ACWIP8V+WfsiMSqIQCVQ=;
 b=dP7HmON59K9Lx7L9A2r0XT8EpW23BA9Ctqdsx66ZonC/YJE4R1sQ+tN0JM1uhnhDSE
 T4Bg+8WY7lgiRgQBvUuEIQNFxavlon7knf+3Lcuuve3ywVrwAZ0MvhSciSgVjB3ryB5f
 eHRFb3IzY9ulLJRQBXfT9abzSVy3Nk8AqlnivR4/XnyoV+ygsYcS8HVEHMjokRmsKunW
 Wr8IIm4cf+F8L35ddDHAefNjFBtBmbnyiqw9jmCPtq6/z/IfKt72vDg0M7S7KLAzJjKh
 f3IYM9HxdRoVk9LfI6OkdiXwfUZLj7ceHrziGkvqxvdKxkUeYCNQ0c/1jHCU4OtIxw2E
 auSg==
X-Gm-Message-State: AOJu0YyQqUwlzojEbz33l02Epi+Yq7facDNvvNYQ2vHbYy37kgmFAoLx
 gnD/83a0luPFgOuw1O+e7bBXSIJZYt+iY1xK7nEz2xtMP6CBh7MjbTyhOl0PK99GZd81/dVP2rx
 1xSHsLxRWnxoaoLtlIdJccoihouQXp6UC5MqQ+jV4Nex9Khnks1+L6n+B+32l2PSGtjA3
X-Received: by 2002:a05:600c:4f91:b0:3f6:58ad:ed85 with SMTP id
 n17-20020a05600c4f9100b003f658aded85mr5366510wmq.10.1697966640202; 
 Sun, 22 Oct 2023 02:24:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY2+b5y9r3IATMamlQS5tiuLQFZuKRwCfVIpfe6/ELz4pYDr+0CESE+GytQNQYOH/cQwbVJQ==
X-Received: by 2002:a05:600c:4f91:b0:3f6:58ad:ed85 with SMTP id
 n17-20020a05600c4f9100b003f658aded85mr5366495wmq.10.1697966639888; 
 Sun, 22 Oct 2023 02:23:59 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 z6-20020a05600c220600b0040684abb623sm11114174wml.24.2023.10.22.02.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:23:59 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:23:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL v3 28/62] hw/isa/piix3: Rename "pic" attribute to "isa_irqs_in"
Message-ID: <40f70623875b4ae46e04f57cfa7c80b6af917e1b.1697966402.git.mst@redhat.com>
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

TYPE_PIIX3_DEVICE doesn't instantiate a PIC since it relies on the board to do
so. The "pic" attribute, however, suggests that there is one. Rename the
attribute to reflect that it represents ISA interrupt lines. Use the same naming
convention as in the VIA south bridges as well as in TYPE_I82378.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-8-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/piix.h | 2 +-
 hw/isa/piix3.c                | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index bb898c6c88..b07ff6bb26 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -46,7 +46,7 @@ struct PIIXState {
 #endif
     uint64_t pic_levels;
 
-    qemu_irq pic[ISA_NUM_IRQS];
+    qemu_irq isa_irqs_in[ISA_NUM_IRQS];
 
     /* This member isn't used. Just for save/load compatibility */
     int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index c17547a2c0..616f5418fa 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -36,7 +36,7 @@
 
 static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
 {
-    qemu_set_irq(piix3->pic[pic_irq],
+    qemu_set_irq(piix3->isa_irqs_in[pic_irq],
                  !!(piix3->pic_levels &
                     (((1ULL << PIIX_NUM_PIRQS) - 1) <<
                      (pic_irq * PIIX_NUM_PIRQS))));
@@ -312,7 +312,8 @@ static void pci_piix3_init(Object *obj)
 {
     PIIX3State *d = PIIX3_PCI_DEVICE(obj);
 
-    qdev_init_gpio_out_named(DEVICE(obj), d->pic, "isa-irqs", ISA_NUM_IRQS);
+    qdev_init_gpio_out_named(DEVICE(obj), d->isa_irqs_in, "isa-irqs",
+                             ISA_NUM_IRQS);
 
     object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
 }
-- 
MST


