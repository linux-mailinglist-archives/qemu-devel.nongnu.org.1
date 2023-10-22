Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E82A7D2247
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:29:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUgc-0006yt-NK; Sun, 22 Oct 2023 05:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgY-0006Ul-Eu
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgW-0000Qs-L3
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R8vGmlEfppo+TqGZX0HrmOY6HWL1WGWh7BLfVKf8if4=;
 b=IwZBPVe6oSXEP9KXKvT2Zd5Z+SLulY69J7cZpEG/syL0hkOQ6MLs+EwXMhI055ilWHva1+
 GY74Qi2fe1ciCSxYqdK2GkptMyqUUmjur2WZ4xyIS4xgD/JqLt8kO5drJTjCAv7VmR2nxG
 kbCf47hz1EU+hI5v6HPENvdpde26vN4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-BvppjtkuPnKcmbYuPwb1Og-1; Sun, 22 Oct 2023 05:23:46 -0400
X-MC-Unique: BvppjtkuPnKcmbYuPwb1Og-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507c8a8e5d1so2392877e87.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966624; x=1698571424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8vGmlEfppo+TqGZX0HrmOY6HWL1WGWh7BLfVKf8if4=;
 b=YgyEGy/Wmph80bFTLUwur4GKDexjXlZYPpg5dTx1WFoTV+OgpUvSlMaHrPSJaD1hXr
 F0LSw+/bNaiLJM6Li2gvT26bk0EOF9RoDC4iBkHXJOl5HUzmBt5P0ks5vs3KgMaOy9sv
 BPxUEFuWg91fk239nuk9uqWbkB4N+tgjuUws7FlYN97CxX0BFtwJEgaPEhn8kJ8FFbwf
 c2sjNgvxAkw7uTgt2LjcLJGOnGuh3rLx/cERAb9Fp3ojWvCQqL6NVgGSRg90WV/+5y+E
 jNrADr9ALy0bgSERjdTDO5iG7C5y6gqmeytmbLsrpQLxcVcxP2wl7Z1lLusRGqN/eZeD
 efdg==
X-Gm-Message-State: AOJu0YxF57E7LxOBLCK9ycw/UK4WPqnr685nKrIfQ39GxG1ypuS4zRfI
 FlXeAEDDVu8frsCb8+MKQSvtBHCWyqCUNTlhtckeAqv6mtug/9wUXWyYClsc9xR2NS3lvfu0hzP
 O8B+dQx0aYX+GPg0uB1XXDASuJHhJLqomUVYj6IexijNfrIzt0T4g893bpv/Jwa5q/KhC
X-Received: by 2002:a19:7015:0:b0:503:7be:c85d with SMTP id
 h21-20020a197015000000b0050307bec85dmr4090010lfc.35.1697966624370; 
 Sun, 22 Oct 2023 02:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+zBk5ONN0Dcif0eC+wvMX1hwUrXXw6+fGa/+AwmFubgaJHAZiPRTgO5n2bngAfpmuUVnRwQ==
X-Received: by 2002:a19:7015:0:b0:503:7be:c85d with SMTP id
 h21-20020a197015000000b0050307bec85dmr4089997lfc.35.1697966623973; 
 Sun, 22 Oct 2023 02:23:43 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 x9-20020a05600c420900b004065e235417sm11104894wmh.21.2023.10.22.02.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:23:43 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:23:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL v3 24/62] hw/i386/pc_piix: Assign PIIX3's ISA interrupts
 before its realize()
Message-ID: <8b6cf5128ee510729895e00a669fa7ce7457c949.1697966402.git.mst@redhat.com>
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


