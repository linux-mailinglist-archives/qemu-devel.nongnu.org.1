Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F6B73754D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:48:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIn-00008A-LH; Tue, 20 Jun 2023 15:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7l-0004aC-Gb
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:37 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7j-0006iY-Vz
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:37 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-57338656a8aso21330257b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281994; x=1689873994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQQT2DevBFB3oDkqTww+bCq8Z+NcubvcMEbZ9kPn1/I=;
 b=fstv2AOOVoUWAQIuOJ3m6gjiU4cTxA4w47YkcRP1Rz7FBW/kBHuRMpLSFwMaTEe5b1
 BlytFKX3BaEwTZKAkeW11PgTa8oze9Czt/+yknEl/OEBfvwDwXn7SW3PG/2w8PqeoPvm
 av8TBcXKkS0ciL2D5leUNWfuF+rTprm3u/HkWbPk/mwfGv0uVvN2t3ZSUpWiiVE5OWrW
 icnEMAZo2HF7BoErM6qix14wzc9gUbIHbkcx4ZwzBkJIr1KsPb4CDkdR5gy+OyiVn6w8
 Gh4q7qXxcQBsSJwTex+JKFslShnCOfxKn4FB052N1hJQvrzjk8BGqRy3FVkARemL4CKt
 I4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281994; x=1689873994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQQT2DevBFB3oDkqTww+bCq8Z+NcubvcMEbZ9kPn1/I=;
 b=VVQUrdM+tyzoCSrAcZyKzDlD6Ux8nFUobT58ekDUZRJ+J96tIvaYei1bPXJLN3tksk
 JF/Nh8bQpWJ/qTHzUVzLRE+jrLTySZbNMN1xzD7j5qY/iEeOXAl1ftSNX9w80EXU9hdZ
 hbHr+NWc4HPKeIiQPz28e3NVlqN+fgp29+aen6B4jNO1rQrN87a1u22wBIPTzWHT44zv
 u3Bi1Pyq1bSBSgt1XNbJtI4p/E9EAE7vbwRBlJZ+y4RgRWmHVTBhV28urjVHmBaFSkYh
 ajcl3cXm5HlYfN/ySjvsHUT4gCsPIOMZwOMLWdyjz9zWHucIXFO0rfpmiHsn2RGGWZBz
 vnaA==
X-Gm-Message-State: AC+VfDy1zlK3hTJzPMcxiudkuOLlfyH8iGIhQoobQvAlhix7t3gQ+b5K
 mTXaC6lcEhlt8NeH2dSCFftpa4x0YsGAoA==
X-Google-Smtp-Source: ACHHUZ5TvogazAaiBwei1eL5eky/5rmlzL7gOMXYPR2q+pv034XN8iCHLrs6IQjYOJgREMAVTq8NZw==
X-Received: by 2002:a0d:ea01:0:b0:56c:e5a3:3e1b with SMTP id
 t1-20020a0dea01000000b0056ce5a33e1bmr12551422ywe.22.1687281994508; 
 Tue, 20 Jun 2023 10:26:34 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:26:34 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v1 20/23] xen platform: unplug ahci object
Date: Tue, 20 Jun 2023 13:24:54 -0400
Message-Id: <9b8183903cbf20db4e2f0dafda9e0ed271a86a8e.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=jupham125@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jun 2023 15:45:55 -0400
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

This will unplug the ahci device when the Xen driver calls for an unplug.
This has been tested to work in linux and Windows guests.
When q35 is detected, we will remove the ahci controller
with the hard disks.  In the libxl config, cdrom devices
are put on a seperate ahci controller. This allows for 6 cdrom
devices to be added, and 6 qemu hard disks.


Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/i386/xen/xen_platform.c | 19 ++++++++++++++++++-
 hw/pci/pci.c               | 17 +++++++++++++++++
 include/hw/pci/pci.h       |  3 +++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 57f1d742c1..0375337222 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -34,6 +34,7 @@
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "include/hw/i386/pc.h"
 #include "qom/object.h"
 
 #ifdef CONFIG_XEN
@@ -223,6 +224,12 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, void *opaque)
         if (flags & UNPLUG_NVME_DISKS) {
             object_unparent(OBJECT(d));
         }
+        break;
+
+    case PCI_CLASS_STORAGE_SATA:
+	if (!aux) {
+            object_unparent(OBJECT(d));
+        }
 
     default:
         break;
@@ -231,7 +238,17 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, void *opaque)
 
 static void pci_unplug_disks(PCIBus *bus, uint32_t flags)
 {
-    pci_for_each_device(bus, 0, unplug_disks, &flags);
+    PCIBus *q35 = find_q35();
+    if (q35) {
+        /* When q35 is detected, we will remove the ahci controller
+	 * with the hard disks.  In the libxl config, cdrom devices
+	 * are put on a seperate ahci controller. This allows for 6 cdrom
+	 * devices to be added, and 6 qemu hard disks.
+	 */
+        pci_function_for_one_bus(bus, unplug_disks, &flags);
+    } else {
+        pci_for_each_device(bus, 0, unplug_disks, &flags);
+    }
 }
 
 static void platform_fixed_ioport_writew(void *opaque, uint32_t addr, uint32_t val)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1cc7c89036..8eac3d751a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1815,6 +1815,23 @@ void pci_for_each_device_reverse(PCIBus *bus, int bus_num,
     }
 }
 
+void pci_function_for_one_bus(PCIBus *bus,
+                          void (*fn)(PCIBus *b, PCIDevice *d, void *opaque),
+                          void *opaque)
+{
+    bus = pci_find_bus_nr(bus, 0);
+
+    if (bus) {
+        PCIDevice *d;
+
+        d = bus->devices[PCI_DEVFN(4,0)];
+        if (d) {
+            fn(bus, d, opaque);
+            return;
+        }
+    }
+}
+
 void pci_for_each_device_under_bus(PCIBus *bus,
                                    pci_bus_dev_fn fn, void *opaque)
 {
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e6d0574a29..c53e21082a 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -343,6 +343,9 @@ void pci_for_each_device_under_bus(PCIBus *bus,
 void pci_for_each_device_under_bus_reverse(PCIBus *bus,
                                            pci_bus_dev_fn fn,
                                            void *opaque);
+void pci_function_for_one_bus(PCIBus *bus,
+                         void (*fn)(PCIBus *bus, PCIDevice *d, void *opaque),
+                         void *opaque);
 void pci_for_each_bus_depth_first(PCIBus *bus, pci_bus_ret_fn begin,
                                   pci_bus_fn end, void *parent_state);
 PCIDevice *pci_get_function_0(PCIDevice *pci_dev);
-- 
2.34.1


