Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C037D01B0
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:34:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhX-000130-6M; Thu, 19 Oct 2023 14:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXg5-0007Qw-SZ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfy-0000tM-Uq
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zb7+9uBs0aVVSmIJfkcKx4/iAP+jZ8ER447ZRZ+1lm8=;
 b=iw6LBFvDrTlrIRHEBg0CYmE3lV5FndtYd0T052QJdk/RE6+Cst7RN9sG2smDsGdBUSgmJY
 AguTC9Cq8AKp5SAiyRiIf4nHgmatSKjs6tSdvXMWaczG+LkIGtogE1MTARTiwnXucKAgfM
 lsAo1JjzujfU6ImenBklmTA9j/snpww=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-3yl65RghMNahkqbu5My3YA-1; Thu, 19 Oct 2023 14:23:09 -0400
X-MC-Unique: 3yl65RghMNahkqbu5My3YA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32d33e3aea5so6370f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739788; x=1698344588;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zb7+9uBs0aVVSmIJfkcKx4/iAP+jZ8ER447ZRZ+1lm8=;
 b=Ww1g39miHWmi0SYX3W32aJ6toeiES3xgH+N4IFcIvnZjfHmYIVnzgyJbqplXQZsr/N
 EqBtr5RhzBb4y6RQdEDsXsiHfrqpoLAzr/PrB5sYKG24X0Q3Wi5GSGNKnDd/62hM+QMp
 FfOUSWkmhn9cQRMmhSqPbhz75HxU3tPUNHPs01JVKWzTMfLTbzS0ftYOcPKa8q0TGyX+
 eZhuuUTer5MtSu24K5XQAzNJdRhTKrhoOxCfc8Z3MlL2L17SWNS/6c2xxLmVbL6RxtSf
 7GZLWrCOTXOUE+xu3EfGQWPiG+6Qx9C7y+gvrnBIGKwVmjQl95NEpBt4vhh3eHKE7XO3
 Pgnw==
X-Gm-Message-State: AOJu0YxGVqdaoY4Wog/0VhdAVn/6Z0fg2ob7YJ+Ktje00pchklAb9PM/
 TATZVppz0wmI7IywfZ6/Ha1bLoJqrmrOAjtJeoeA5n3WWx1KSpHJyG6L1AkPgZYdOll4PxNtP0X
 Arvgnj/5+GexPDha+gDdRxUfL152yEIwTfS0PhKmc0RZn04C4Euj1Bwfoul6HfpYfqrXY
X-Received: by 2002:adf:fac9:0:b0:31f:4173:2ac8 with SMTP id
 a9-20020adffac9000000b0031f41732ac8mr1753465wrs.18.1697739788070; 
 Thu, 19 Oct 2023 11:23:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuT25id7R2ll1f1we46Aq+o5/jn2FyEHJM1oibu8oAmbxUPY7MMyFLficK6kM0ouoIodLefQ==
X-Received: by 2002:adf:fac9:0:b0:31f:4173:2ac8 with SMTP id
 a9-20020adffac9000000b0031f41732ac8mr1753448wrs.18.1697739787739; 
 Thu, 19 Oct 2023 11:23:07 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 x8-20020adfec08000000b00326f0ca3566sm5006498wrn.50.2023.10.19.11.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:06 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:23:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 43/78] hw/i386/pc_piix: Remove redundant "piix3" variable
Message-ID: <17f19f20f7fd0f061a6fe2a5717e12044afd03cd.1697739629.git.mst@redhat.com>
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

The variable is never used by its declared type. Eliminate it.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-7-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 4dc7298c15..cd6c00c0b3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -261,13 +261,11 @@ static void pc_init1(MachineState *machine,
     gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
 
     if (pcmc->pci_enabled) {
-        PIIX3State *piix3;
         PCIDevice *pci_dev;
         DeviceState *dev;
         size_t i;
 
         pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
-        piix3 = PIIX3_PCI_DEVICE(pci_dev);
         dev = DEVICE(pci_dev);
         for (i = 0; i < ISA_NUM_IRQS; i++) {
             qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
@@ -288,8 +286,8 @@ static void pc_init1(MachineState *machine,
                          XEN_IOAPIC_NUM_PIRQS);
         }
 
-        piix3_devfn = piix3->dev.devfn;
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
+        piix3_devfn = pci_dev->devfn;
+        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
         rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
                                                              "rtc"));
     } else {
-- 
MST


