Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C3B7D01BB
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:36:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhV-0000xC-Ku; Thu, 19 Oct 2023 14:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfm-00079Z-Js
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfk-0000sY-Cc
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R8vGmlEfppo+TqGZX0HrmOY6HWL1WGWh7BLfVKf8if4=;
 b=fvK0cVkhs9j6qdkCW5RhkKOOtQmo/6Pr2Cqa7DabVFByBXxXIJXYLZoTqd3RjIaUO5AgAQ
 iVSFDL+MUG+Z5VmPwiBtAAowxW0UliLwExQ7hZE5MQX6Y/umgNYiJbN78YZnH0aCkDdhDt
 pNW94cvW6QpTxyfZLXakVp8tTFTFdjU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-AhuK6bSHOL6yM5kVqo41zg-1; Thu, 19 Oct 2023 14:23:02 -0400
X-MC-Unique: AhuK6bSHOL6yM5kVqo41zg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-507d4583c4cso817828e87.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739779; x=1698344579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8vGmlEfppo+TqGZX0HrmOY6HWL1WGWh7BLfVKf8if4=;
 b=OfwVHLTXZamJ1kZcJ3htE75Jy6mgfx4k+2XU6vH3f2X3/71JZ+QYwkQomqG4CD9n4v
 5bhfWxhFt8OfbXy7ehdzxWBrzPO8s5+2yw+136dM1s2ENsGtbSgO6mHwJ52sBn9R5mdb
 eh113D6CGkBobdGIHAEP04mLKCkOmB06auzMplNn4TSrRZml4fPnZhEv48NPqhDktnDJ
 FFOLLSM4CeT/4FGzi4umOMQL9S+Ixp7Igv7/zqpMghfJDt+1LejwrmePnjOVlB0RX8Pf
 vjvi5eDGrIap/wsa6NPdryeSWroRiKFy/Z/oTT5FTKxZeqjrHV3yX/bshS+VtNzf99Fg
 D56A==
X-Gm-Message-State: AOJu0Yy/+AG/GOzFtMVlj9dExGrpgG9HJkkib8gMCzPAe4TK/3KTc83M
 ZgfSyJ6cle6+THG+B+QWHO0ukIEgTn0CQNRnH1s+SWKnajTyohkx/TECx5gNeBIgKMU8Ir6/hlh
 a/3gyTKZV1HG/LnBPekNqV1VUtXQAOIz2hjuCbH9CfGf2c9XWblEtWl+XmwehAmfk6Jt9
X-Received: by 2002:ac2:560f:0:b0:506:8d2a:5654 with SMTP id
 v15-20020ac2560f000000b005068d2a5654mr1958302lfd.28.1697739779673; 
 Thu, 19 Oct 2023 11:22:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm+Dy3aCy53oL1BgzSVme9Hx0o53BroJONPtaxgX1dzVi6emQypyolB8MBJ1C+uZOcJ1SiOA==
X-Received: by 2002:ac2:560f:0:b0:506:8d2a:5654 with SMTP id
 v15-20020ac2560f000000b005068d2a5654mr1958282lfd.28.1697739779285; 
 Thu, 19 Oct 2023 11:22:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c1d8f00b00402d34ea099sm5055156wms.29.2023.10.19.11.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:58 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL v2 40/78] hw/i386/pc_piix: Assign PIIX3's ISA interrupts
 before its realize()
Message-ID: <171ded8387d45813c90fe564daeaaab57080985b.1697739629.git.mst@redhat.com>
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

Unlike its PIIX4 counterpart, TYPE_PIIX3_DEVICE doesn't instantiate a PIC
itself. Instead, it relies on the board to do so. This means that the board
needs to wire the ISA IRQs to the PIIX3 device model. As long as the board
assigns the ISA IRQs after PIIX3's realize(), internal devices can't be wired in
pci_piix3_realize() since the qemu_irqs are still NULL. Fix that by assigning
the ISA interrupts before realize(). This will allow for embedding child devices
into the host device as already done for PIIX4.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Message-Id: <20231007123843.127151-4-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6d2f5509e6..a003923788 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -265,6 +265,8 @@ static void pc_init1(MachineState *machine,
         PCIDevice *pci_dev;
 
         pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
+        piix3 = PIIX3_PCI_DEVICE(pci_dev);
+        piix3->pic = x86ms->gsi;
         pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
 
         if (xen_enabled()) {
@@ -281,8 +283,6 @@ static void pc_init1(MachineState *machine,
                          XEN_IOAPIC_NUM_PIRQS);
         }
 
-        piix3 = PIIX3_PCI_DEVICE(pci_dev);
-        piix3->pic = x86ms->gsi;
         piix3_devfn = piix3->dev.devfn;
         isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
         rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-- 
MST


