Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E7B7D0165
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:26:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhS-0000kk-D5; Thu, 19 Oct 2023 14:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgB-0007XY-CA
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXg3-0000u4-MD
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uLW4nacuIeTJ5EH0RbV4BQZpdBCvivCuyeSzP1OfKNM=;
 b=cTe+qIxHDabRGMxXVjdlCD2czH0uKVVyE/v82U6Y9U4IawF36t0TbcXhWxhJa/GJbpY56P
 7tW2nBHCGkHexeRz+Py0ZpOEo7e76BZm0vgZr39LilodLWQCnR5DOKNEidVn/IXwv9j1An
 bWWoyGdLCfr9svFYtGZywTHYh0YigcA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-Yoj6jOnzNNmoYJZ-x54-ng-1; Thu, 19 Oct 2023 14:23:18 -0400
X-MC-Unique: Yoj6jOnzNNmoYJZ-x54-ng-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32da47641b5so7877f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739796; x=1698344596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLW4nacuIeTJ5EH0RbV4BQZpdBCvivCuyeSzP1OfKNM=;
 b=L0R1Lzq9vHAO9vXToGvHk6oFKJExfiCgdm+/2ls2hXHur32vTBY4bTwWu0dfz+EfFA
 000Gb4mlXlwNzhFcAvIRG4vW0GBV+Ltvte1uR3veGP0EA1dHzBa94jp198BUct7lGAon
 bSSiqeyrPDvlpVeQZ3ZYj5pVCtwu+QkC8pUD9lvl5BvuA0BrDEnIc3VvQ4ncoPd6DAEN
 745rtsQC5xDimrxedM2jb83NIuDl7uz/NcPvIrk49Kc31nKC+9hSLxlJIAvddPcKYlbo
 q5GCMpuFt4JI4SRs/bJR2eFW0X9WCbZXrzOmnW+apjWOJk3WMHaaBUJCjpXehRjjQVel
 yoDg==
X-Gm-Message-State: AOJu0Yz4Jpo3pOcrhvTBsKFZc0NGkHY1IeLApQdDVsGdQ9SrAhJPC8+a
 L/vHD0kPCyqUpxW0u4rcNLpBROSizqEQlLVhq+jhU1YnYS7Ocy8rDFvGhxyAYVs2mjmHDgOGPf2
 pVgWWPQ0tRmRmx7TNcqjipJcY0fstJtjdIWFJXIo+70He72yiWPw0rRdP7ClLVISdDWqL
X-Received: by 2002:adf:fc91:0:b0:329:6e92:8d77 with SMTP id
 g17-20020adffc91000000b003296e928d77mr2436082wrr.51.1697739796294; 
 Thu, 19 Oct 2023 11:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH9wqekwcYerPMUpfQWQevpcUNt4KaEvh+rTuGsSOqhianqIoaU0LvpfMSiSxn6A5sTwTBDg==
X-Received: by 2002:adf:fc91:0:b0:329:6e92:8d77 with SMTP id
 g17-20020adffc91000000b003296e928d77mr2436065wrr.51.1697739796001; 
 Thu, 19 Oct 2023 11:23:16 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 p14-20020adfcc8e000000b0032db1d741a6sm5031045wrj.99.2023.10.19.11.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:15 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:23:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 46/78] hw/isa/piix3: Wire PIC IRQs to ISA bus in host device
Message-ID: <952fe2040017ba2f7712b56a9bd8f788c7a2bb67.1697739629.git.mst@redhat.com>
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


