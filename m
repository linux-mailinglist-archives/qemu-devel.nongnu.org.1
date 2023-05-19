Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC270709A9F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:55:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01TL-0006HU-Iv; Fri, 19 May 2023 10:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01TE-0005fX-Vo
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01T9-0003mH-QI
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OedOpR3sWdkPNhnqIT9PzPMy+No4a4OcU7ka6unQxog=;
 b=hgfge2Jsho/G6kKY92g2k4gQio7tWm8/xq6vF0e1QYBeapz8ismyGNSyPWFlEDG0wbc+vA
 fVYlwIu15aUXyC3hsh3q7OHlmWHNY4S6owbWFC5EazlHJDbwg0gGxe4RSMw2Oh7PRN33Wk
 nYley2LOuLTq5A32lZDzYd0TAF3hhEc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-5WjbbZ0BNJGWvJjRRw2tlQ-1; Fri, 19 May 2023 10:52:33 -0400
X-MC-Unique: 5WjbbZ0BNJGWvJjRRw2tlQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2af1589c75aso13526861fa.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507951; x=1687099951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OedOpR3sWdkPNhnqIT9PzPMy+No4a4OcU7ka6unQxog=;
 b=iGnSLWgQDbV0gmuu/e3bphDz5mtF4DP5GhYrFgvyGNwqaVly3nF4XzHM+r/RSFopbB
 mjdC0dblBizMz3sxyKEKvfhFsEjYg3qut42+ByHKteWIwGLXp9ltmDhOzu+eOEjOi+LR
 oopNzYZ7bycraDyUO3xIFneLP5ZEWL0SG0srmrxQgLYADcCtcrCHCve7ZLqbzHxfIGZf
 orrOVK5g1zwWHtNdaC7AkWLVAeCTJ2191wufW/3QSwXv831ttUA628ZPwfJJc063lLJL
 d0qQqCIiEtQEZjNbEgkQBFQwKG5a0DAH3CDY1/kUV6fUZEV1p5I3xfXIrNhZuKADeujf
 b0tg==
X-Gm-Message-State: AC+VfDyPkPdyy8wbeEMw1wHZy5is/hjpBRDfXC6+aoGbll3MD2gsDIBh
 lQa/o8mhXpMhATr3RPX5gX13VCvsgpI3WnPahh12exkostT7YtcwjSsTsNDoqkPnytlpX7F+VpQ
 PdrugzpS3Ov265CkdLKPdgfTVnDnEx7Yxhqew+f/QRYfpqopr/F1TgHm3IwaQC0rrhBEI
X-Received: by 2002:a19:f002:0:b0:4ed:c17c:16e5 with SMTP id
 p2-20020a19f002000000b004edc17c16e5mr1086418lfc.17.1684507950897; 
 Fri, 19 May 2023 07:52:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6mK3TAp7J7+TY9GMOb92H8Gq61C1JityalPA9zk/YDkDhrRdms+jLIVknlx1S0padeVCwVtg==
X-Received: by 2002:a19:f002:0:b0:4ed:c17c:16e5 with SMTP id
 p2-20020a19f002000000b004edc17c16e5mr1086405lfc.17.1684507950659; 
 Fri, 19 May 2023 07:52:30 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 u29-20020a056512041d00b004f20d0ebe50sm626132lfk.94.2023.05.19.07.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:52:30 -0700 (PDT)
Date: Fri, 19 May 2023 10:52:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 32/40] hw/i386/pc_{q35,piix}: Minimize usage of
 get_system_memory()
Message-ID: <8631743c0968d11983a3a04939c580160bb79ac3.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230213162004.2797-6-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 2 +-
 hw/i386/pc_q35.c  | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a9c40201fb..ac7b1a9194 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -242,7 +242,7 @@ static void pc_init1(MachineState *machine,
         isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
     } else {
         pci_bus = NULL;
-        isa_bus = isa_bus_new(NULL, get_system_memory(), system_io,
+        isa_bus = isa_bus_new(NULL, system_memory, system_io,
                               &error_abort);
         i8257_dma_init(isa_bus, 0);
         pcms->hpet_enabled = false;
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 89e69737d6..1490f87adb 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -126,6 +126,7 @@ static void pc_q35_init(MachineState *machine)
     DeviceState *lpc_dev;
     BusState *idebus[MAX_SATA_PORTS];
     ISADevice *rtc_state;
+    MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     MemoryRegion *pci_memory;
     MemoryRegion *rom_memory;
@@ -192,7 +193,7 @@ static void pc_q35_init(MachineState *machine)
         rom_memory = pci_memory;
     } else {
         pci_memory = NULL;
-        rom_memory = get_system_memory();
+        rom_memory = system_memory;
     }
 
     pc_guest_info_init(pcms);
@@ -215,7 +216,7 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* allocate ram and load rom/bios */
-    pc_memory_init(pcms, get_system_memory(), rom_memory, &ram_memory,
+    pc_memory_init(pcms, system_memory, rom_memory, &ram_memory,
                    pci_hole64_size);
 
     object_property_add_child(OBJECT(machine), "q35", OBJECT(q35_host));
@@ -224,7 +225,7 @@ static void pc_q35_init(MachineState *machine)
     object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_PCI_MEM,
                              OBJECT(pci_memory), NULL);
     object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_SYSTEM_MEM,
-                             OBJECT(get_system_memory()), NULL);
+                             OBJECT(system_memory), NULL);
     object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_IO_MEM,
                              OBJECT(system_io), NULL);
     object_property_set_int(OBJECT(q35_host), PCI_HOST_BELOW_4G_MEM_SIZE,
-- 
MST


