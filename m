Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBC97CE228
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:06:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8x0-0001UT-T5; Wed, 18 Oct 2023 11:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8vF-0005JS-H0
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8vD-0007J0-TB
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uLW4nacuIeTJ5EH0RbV4BQZpdBCvivCuyeSzP1OfKNM=;
 b=c1cSMVqWC0dXTI64PjN3M/sSh4SBc2X27TaHEPV3DfXeKTYc0WYw27VQh5/CpwGvwnUWaw
 vGCDOkFzTtXt1SVb8DiMsZuHIfiMPK0BMf/X46CsrGJ4S1JEkMDMX/AC6J5weownaPcz17
 gg2DTdgMQpnrdrF2gdQFmH2CLgLFT/E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-iCJRQtHZPda8w0ahRN18Uw-1; Wed, 18 Oct 2023 11:57:21 -0400
X-MC-Unique: iCJRQtHZPda8w0ahRN18Uw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40566c578b7so50252355e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644640; x=1698249440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLW4nacuIeTJ5EH0RbV4BQZpdBCvivCuyeSzP1OfKNM=;
 b=lCkCQ3Tn+Lf5iBIbnk4Tzz4dR6u3L4yqTvAdZKva6NvEGXONAppfGwSvNuZIjarS6N
 r0BZ8+oJ5pjLqLgIsXGWU8WPbdeetqKHBbyFiKaPmRcMJ1l3Y+1swMzO/qggUzDef+4x
 Ps+xFVlG/8/0byE/WjbdTWr1U6ediVzQx80/DbJURXCXStN30phKBqpjL11YiIv/ePxi
 RiMBYZd8OIwOpaJl9Rb7pEwPRYjj4TDdNY7QfcidezLh2zR8y6dpxcihW8vUCKVlR0OA
 1IIyRlPU6wYgjR8I2ZydVPB/F0XseCdHjyH13eKjQ3io4C4/lbVQuVfCnQv6FeIBaZyn
 KO+A==
X-Gm-Message-State: AOJu0Yxmxy4aE81NNK/H3ciBFJYeG33MpOIrBSNA4T4QjAq34YD3YgwN
 XKkQDrkVAPESCKIo0qeuLInzc3rWkEyzt34iLReeqy7gEeCv0TeBXXliuvH4yMOowc+YvlhX4sn
 3w6UVSR/Mis0GcgQY8n9SIyEkRIkFyWgulCg4FkzB5N4/4uzcNMgIPEG0fqRm7UZDKc/G9+c=
X-Received: by 2002:adf:f20e:0:b0:32d:a781:111 with SMTP id
 p14-20020adff20e000000b0032da7810111mr4872921wro.15.1697644639773; 
 Wed, 18 Oct 2023 08:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhF8nQF+ovBq1uagItTQQS/ECiw8zvrwiOCNT68g+hghMkMgwPeoQeBP5lhsAq21OWCNPzWQ==
X-Received: by 2002:adf:f20e:0:b0:32d:a781:111 with SMTP id
 p14-20020adff20e000000b0032da7810111mr4872898wro.15.1697644639374; 
 Wed, 18 Oct 2023 08:57:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 f12-20020adfb60c000000b00318147fd2d3sm2385909wre.41.2023.10.18.08.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:57:18 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:57:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 51/83] hw/isa/piix3: Wire PIC IRQs to ISA bus in host device
Message-ID: <3cccc57a6adad904fe5e94e05326160965cfc4a6.1697644299.git.mst@redhat.com>
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


