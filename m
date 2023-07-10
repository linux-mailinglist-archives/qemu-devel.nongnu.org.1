Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3125074E203
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzus-0005Ak-PE; Mon, 10 Jul 2023 19:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuq-00058N-7U
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuo-0004GN-KZ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kEjEJwICeQiKCSVVw3Xvi2viKbcFg/KX0TNGLrPqfQ0=;
 b=ZI/xQhNJg8GILTrukW1cO7X2FjtOiVvN88zCT21ifNrhkiNhMVTIRfWhjD5yXdPMTn0CFg
 Wkrg5GGkl1aBHPwh8BgL/u2rGOjlXWVYfUByRM6eLn2DvTCucPr6NF5+6DyCI7E6gYdk75
 bkShLXowspmChO4toaoeFIkUfJ3A70c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-7iO72CKvNseVS6CrrJSxXQ-1; Mon, 10 Jul 2023 19:03:31 -0400
X-MC-Unique: 7iO72CKvNseVS6CrrJSxXQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-314326f6e23so2583646f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030210; x=1691622210;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEjEJwICeQiKCSVVw3Xvi2viKbcFg/KX0TNGLrPqfQ0=;
 b=cUDQbdTBEAkzQy7AbNspQo3SvCbsSDOIpLIhn8HaPRdodbf7og4vO4A677RT2lcG7D
 QPhvUh4+ILiwaBhNfjtybafbxqZWpkSJSJbd55A7FiZq6NqtNy2Xh5U4LprpkGhNMQ1n
 wJ22VYjKntdM1dW960HibxbpKnDkuNUbkXOBKVNJchMrYMNx8+pwA6dYoUzxUtqVrHzc
 ABABSERs1J9SPZA+MsDcjS/l50LIin7cGYTZmse1T2AE2+swJTbQBuJCMEkq35G08tZb
 Mx9cNPf/xrdK87QYx3np+21i8lq6SZdqxKAbiWoCTSECcVQgicnOnDOX4d/ebDPUFPXe
 F54w==
X-Gm-Message-State: ABy/qLbk3+p9muyfxvsSq/BgbtJfSsASgRONG1yCu78P72bfzpkh5/L3
 apjOSFfWl0HnNI/M3ylEOftGGfymXTCCmmqISlqKWhI8GQNIQPAaj5WGpHvGrkoVKYxtnPsrLNj
 LdWoFSmJElszMsDmPUAlWui0UZGv2D3FnI4gPK3LfN+FRdWQdDeiiihlIh8DPUrzYCtzc
X-Received: by 2002:adf:da4e:0:b0:314:315a:93b5 with SMTP id
 r14-20020adfda4e000000b00314315a93b5mr381020wrl.54.1689030210101; 
 Mon, 10 Jul 2023 16:03:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFkXFysj3Oo/BALje+GL6qVXc7h231LgtO42YvI9NLy4BvvdoMoGEFXc1Kl6jXdRl26JfDLZQ==
X-Received: by 2002:adf:da4e:0:b0:314:315a:93b5 with SMTP id
 r14-20020adfda4e000000b00314315a93b5mr381001wrl.54.1689030209811; 
 Mon, 10 Jul 2023 16:03:29 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 l10-20020adffe8a000000b00315995837aesm590819wrr.36.2023.07.10.16.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:29 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 22/66] hw/pci-host/q35: Make some property name macros
 reusable by i440fx
Message-ID: <3d664a9a386dd5968962b038d056caf182ef29a1.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20230630073720.21297-7-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h      | 4 ++++
 include/hw/pci-host/q35.h | 5 -----
 hw/i386/pc_q35.c          | 8 ++++----
 hw/pci-host/q35.c         | 8 ++++----
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6eec0fc51d..c34c698cdd 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -146,6 +146,10 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
 void pc_guest_info_init(PCMachineState *pcms);
 
+#define PCI_HOST_PROP_RAM_MEM          "ram-mem"
+#define PCI_HOST_PROP_PCI_MEM          "pci-mem"
+#define PCI_HOST_PROP_SYSTEM_MEM       "system-mem"
+#define PCI_HOST_PROP_IO_MEM           "io-mem"
 #define PCI_HOST_PROP_PCI_HOLE_START   "pci-hole-start"
 #define PCI_HOST_PROP_PCI_HOLE_END     "pci-hole-end"
 #define PCI_HOST_PROP_PCI_HOLE64_START "pci-hole64-start"
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index e89329c51e..1d98bbfe0d 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -74,11 +74,6 @@ struct Q35PCIHost {
  * gmch part
  */
 
-#define MCH_HOST_PROP_RAM_MEM "ram-mem"
-#define MCH_HOST_PROP_PCI_MEM "pci-mem"
-#define MCH_HOST_PROP_SYSTEM_MEM "system-mem"
-#define MCH_HOST_PROP_IO_MEM "io-mem"
-
 /* PCI configuration */
 #define MCH_HOST_BRIDGE                        "MCH"
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 852250e8cb..02dd274276 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -218,13 +218,13 @@ static void pc_q35_init(MachineState *machine)
     pc_memory_init(pcms, system_memory, rom_memory, pci_hole64_size);
 
     object_property_add_child(OBJECT(machine), "q35", phb);
-    object_property_set_link(phb, MCH_HOST_PROP_RAM_MEM,
+    object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
                              OBJECT(machine->ram), NULL);
-    object_property_set_link(phb, MCH_HOST_PROP_PCI_MEM,
+    object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
                              OBJECT(pci_memory), NULL);
-    object_property_set_link(phb, MCH_HOST_PROP_SYSTEM_MEM,
+    object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
                              OBJECT(system_memory), NULL);
-    object_property_set_link(phb, MCH_HOST_PROP_IO_MEM,
+    object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
                              OBJECT(system_io), NULL);
     object_property_set_int(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
                             x86ms->below_4g_mem_size, NULL);
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index d2830cee34..91c46df9ae 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -240,19 +240,19 @@ static void q35_host_initfn(Object *obj)
     object_property_add_uint64_ptr(obj, PCIE_HOST_MCFG_SIZE,
                                    &pehb->size, OBJ_PROP_FLAG_READ);
 
-    object_property_add_link(obj, MCH_HOST_PROP_RAM_MEM, TYPE_MEMORY_REGION,
+    object_property_add_link(obj, PCI_HOST_PROP_RAM_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->mch.ram_memory,
                              qdev_prop_allow_set_link_before_realize, 0);
 
-    object_property_add_link(obj, MCH_HOST_PROP_PCI_MEM, TYPE_MEMORY_REGION,
+    object_property_add_link(obj, PCI_HOST_PROP_PCI_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->mch.pci_address_space,
                              qdev_prop_allow_set_link_before_realize, 0);
 
-    object_property_add_link(obj, MCH_HOST_PROP_SYSTEM_MEM, TYPE_MEMORY_REGION,
+    object_property_add_link(obj, PCI_HOST_PROP_SYSTEM_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->mch.system_memory,
                              qdev_prop_allow_set_link_before_realize, 0);
 
-    object_property_add_link(obj, MCH_HOST_PROP_IO_MEM, TYPE_MEMORY_REGION,
+    object_property_add_link(obj, PCI_HOST_PROP_IO_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->mch.address_space_io,
                              qdev_prop_allow_set_link_before_realize, 0);
 }
-- 
MST


