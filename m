Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 917047D2246
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:29:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUh7-0001kv-Od; Sun, 22 Oct 2023 05:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgx-00018g-UC
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgw-0000VS-AM
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uLW4nacuIeTJ5EH0RbV4BQZpdBCvivCuyeSzP1OfKNM=;
 b=UOqk+/By/hBMKcSCSSl/TiXW6dwB9fMJT8k1jHwSt4UDRs7EowxHJRBWTYbkG3yvuLoOfg
 +yLSRZe6EL8r71F8hQ+uvBiLD2i7/I+kplTzrIlgaebTLpL0BJhsJ0ZKl6IP5qZTkkprR+
 P3RDCsSOw0tNCFfMtwUq4EgPrf/e2wQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-ktvprGjIMuKoyfpRexVPOw-1; Sun, 22 Oct 2023 05:24:09 -0400
X-MC-Unique: ktvprGjIMuKoyfpRexVPOw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5079a3362afso2079685e87.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966647; x=1698571447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLW4nacuIeTJ5EH0RbV4BQZpdBCvivCuyeSzP1OfKNM=;
 b=QKt7eHbxi20FkWqNVLmxBu+tPSyX6ynYDeL2iJHN+TXHpKDxqkBWZnclhuhy1KrGpM
 nP0S7F45JP/vVPL3tYTwenbwM319UT5JDG09XfDPRJ+cAgLaFwcWdT0x2nyFDI1hEwqU
 R2GxBa6wwUcImhIxyFXOguh2dduJiB0IdRrVb9l6YGhqrIWpZIhRuORWFgQzxqsxCgOQ
 yPSDDxEQ2S2l6H/NSdidJ48hbe1aBJZkeCyy8dhEDwqYM5PTBE2cGtUkNGFIIoTBv5bJ
 iklBGz+Pyoc9WVydH66Tv//aL4HiDb9txeWrWk3pEAIkjZ6SLXM1VlC6tCDAqkcb+EoQ
 /4/w==
X-Gm-Message-State: AOJu0YzEeLtfJ6UmIHMGTzMIruoB30fEkJvqH7UWoXGRJlIsLvY0T3Kd
 z2ss1/FD2i8DqhFlP+y2WWIZgdIMpzqQ0DeV3JM2fytivMWzI+/YhcIML3AINY0W1tDpoBlXoos
 prm65uj1noY1FhhpXbOu0dV/ilgGXvAxS5DT/uhMdQs9ecwm/gmKequYsf2hgY89dUl/2
X-Received: by 2002:a05:6512:348d:b0:507:9b4a:21bf with SMTP id
 v13-20020a056512348d00b005079b4a21bfmr4737469lfr.45.1697966647718; 
 Sun, 22 Oct 2023 02:24:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQrVji0W1LqpY1Gctlh4vByISi3JzOVKhtMJDgT2rmhndugWugEZMdkxkuKdsmClhy2bmu2Q==
X-Received: by 2002:a05:6512:348d:b0:507:9b4a:21bf with SMTP id
 v13-20020a056512348d00b005079b4a21bfmr4737460lfr.45.1697966647474; 
 Sun, 22 Oct 2023 02:24:07 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 cc17-20020a5d5c11000000b0031c52e81490sm5371989wrb.72.2023.10.22.02.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:24:06 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:24:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v3 30/62] hw/isa/piix3: Wire PIC IRQs to ISA bus in host device
Message-ID: <64127940aeb674cb5d9d8d0ea4ca20591bf2b010.1697966402.git.mst@redhat.com>
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

Thie PIIX3 south bridge implements both the PIC and the ISA bus, so wiring the
interrupts there makes the device model more self-contained. Furthermore, this
allows the ISA interrupts to be wired to internal child devices in
pci_piix3_realize() which will be performed in subsequent patches.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-10-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 2 +-
 hw/isa/piix3.c    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index cd6c00c0b3..5988656279 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -293,6 +293,7 @@ static void pc_init1(MachineState *machine,
     } else {
         isa_bus = isa_bus_new(NULL, system_memory, system_io,
                               &error_abort);
+        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
         rtc_state = isa_new(TYPE_MC146818_RTC);
         qdev_prop_set_int32(DEVICE(rtc_state), "base_year", 2000);
@@ -301,7 +302,6 @@ static void pc_init1(MachineState *machine,
         i8257_dma_init(isa_bus, 0);
         pcms->hpet_enabled = false;
     }
-    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 616f5418fa..3e7c42fa68 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -278,6 +278,8 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
     memory_region_add_subregion_overlap(pci_address_space_io(dev),
                                         PIIX_RCR_IOPORT, &d->rcr_mem, 1);
 
+    isa_bus_register_input_irqs(isa_bus, d->isa_irqs_in);
+
     i8257_dma_init(isa_bus, 0);
 
     /* RTC */
-- 
MST


