Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 075D1709A80
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:53:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01TS-0006RU-5n; Fri, 19 May 2023 10:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01TM-0006No-Qz
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01TL-0003qR-53
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2d8RLaxvH8FDWwZE15r3Lmb+RwrAhSPgfBez2s1KyE=;
 b=eVhs7UzvGWinpkfOQtHksYYEO/HYobxu8SccY4sX4YAOww2vB0BxT30B7bfB2icMQxOXGu
 WGP9/yWmR+Pgc0GIcWQLXcKV6Pis+dWO+k73b6pf/OYHdKB/Uyi2GkjaWWnd5S61Ga8cD3
 +1fb2Rx4TQUpdsx20OI+wPCozGpo4IY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-YOSOSEJ-Ooe5T5o4WycxEg-1; Fri, 19 May 2023 10:52:45 -0400
X-MC-Unique: YOSOSEJ-Ooe5T5o4WycxEg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2af1ed9514bso9205351fa.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507962; x=1687099962;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S2d8RLaxvH8FDWwZE15r3Lmb+RwrAhSPgfBez2s1KyE=;
 b=TdlmBQho0Wxc/t67cl4GzGfU+K7Ap7KB7LfDqC6fqPlKpEKMia37Zws5LUfeGL6yUj
 ZRdN3+cClMQSC8bgIT8JkQKy2WBT7c3ycmixnRGrd7EECuMoHbr1tQXyfY1tD3WPFdkb
 7kdhZZY4yXacebfIE4AdtyvjQE71SE/1qA6PxGT64gQkkVHsuq6R+flnPZ72ONrGBxaR
 IEIkeUDzCX9QnWhyTAzWhSZ9aOCQOE/McKOeIHq8eZIyETJOghOyfj5ojhEcsGIuVD6i
 TJkbp89iJ+GoEm1iDXhYFFyvZlClURPQ0OQndmNEXBjHzhnMfySXfcF/mfsnNLo83fYA
 pDLw==
X-Gm-Message-State: AC+VfDw6a25Li/NkHfua04EAWQuPuKFs6Xqzrhu0V8IevxdjlFU7h88j
 2kLIYPgY4u4MTsCUYnM15GQy4gEJBsZ61HCivqfFyKwDyL1R/3sWw6qqMSR7gayyxoMKYPi2QfU
 1i9qkQYc/DTDHcLuRQspf5ugC7zck3G/Zl21bO1oZI7V2uhyu2jbL5YyiNQrbBVZBkzIq
X-Received: by 2002:a2e:a172:0:b0:2af:21d3:a4d9 with SMTP id
 u18-20020a2ea172000000b002af21d3a4d9mr804726ljl.45.1684507962707; 
 Fri, 19 May 2023 07:52:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7vm7yj7NoHM4OakLi0nSQOHORo157Wfgpzdq0eo5GSRteZpZZ8AFgw2O6qqknS4gpaN5Evtw==
X-Received: by 2002:a2e:a172:0:b0:2af:21d3:a4d9 with SMTP id
 u18-20020a2ea172000000b002af21d3a4d9mr804716ljl.45.1684507962393; 
 Fri, 19 May 2023 07:52:42 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 e22-20020a2e9316000000b002ab3ea4e566sm857061ljh.58.2023.05.19.07.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:52:41 -0700 (PDT)
Date: Fri, 19 May 2023 10:52:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 34/40] hw/pci-host/pam: Make init_pam() usage more readable
Message-ID: <9e57b81861e05b2856ed1c4fbc2d991801c7c777.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Unlike pam_update() which takes the subject -- PAMMemoryRegion -- as
first argument, init_pam() takes it as fifth (!) argument. This makes it
quite hard to figure out what an init_pam() invocation actually
initializes. By moving the subject to the front this should become
clearer.

While at it, lower the DeviceState parameter to Object, also
communicating more clearly that this parameter is just the owner rather
than some (heavy?) dependency.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230213162004.2797-8-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci-host/pam.h |  5 +++--
 hw/pci-host/i440fx.c      | 10 +++++-----
 hw/pci-host/pam.c         | 12 ++++++------
 hw/pci-host/q35.c         |  8 ++++----
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/hw/pci-host/pam.h b/include/hw/pci-host/pam.h
index c1fd06ba2a..005916f826 100644
--- a/include/hw/pci-host/pam.h
+++ b/include/hw/pci-host/pam.h
@@ -87,8 +87,9 @@ typedef struct PAMMemoryRegion {
     unsigned current;
 } PAMMemoryRegion;
 
-void init_pam(DeviceState *dev, MemoryRegion *ram, MemoryRegion *system,
-              MemoryRegion *pci, PAMMemoryRegion *mem, uint32_t start, uint32_t size);
+void init_pam(PAMMemoryRegion *mem, Object *owner, MemoryRegion *ram,
+              MemoryRegion *system, MemoryRegion *pci,
+              uint32_t start, uint32_t size);
 void pam_update(PAMMemoryRegion *mem, int idx, uint8_t val);
 
 #endif /* QEMU_PAM_H */
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 9c6882d3fc..61e7b97ff4 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -292,12 +292,12 @@ PCIBus *i440fx_init(const char *pci_type,
     object_property_add_const_link(qdev_get_machine(), "smram",
                                    OBJECT(&f->smram));
 
-    init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
-             &f->pam_regions[0], PAM_BIOS_BASE, PAM_BIOS_SIZE);
+    init_pam(&f->pam_regions[0], OBJECT(d), f->ram_memory, f->system_memory,
+             f->pci_address_space, PAM_BIOS_BASE, PAM_BIOS_SIZE);
     for (i = 0; i < ARRAY_SIZE(f->pam_regions) - 1; ++i) {
-        init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
-                 &f->pam_regions[i+1], PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE,
-                 PAM_EXPAN_SIZE);
+        init_pam(&f->pam_regions[i + 1], OBJECT(d), f->ram_memory,
+                 f->system_memory, f->pci_address_space,
+                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
     }
 
     ram_size = ram_size / 8 / 1024 / 1024;
diff --git a/hw/pci-host/pam.c b/hw/pci-host/pam.c
index 454dd120db..68e9884d27 100644
--- a/hw/pci-host/pam.c
+++ b/hw/pci-host/pam.c
@@ -30,24 +30,24 @@
 #include "qemu/osdep.h"
 #include "hw/pci-host/pam.h"
 
-void init_pam(DeviceState *dev, MemoryRegion *ram_memory,
+void init_pam(PAMMemoryRegion *mem, Object *owner, MemoryRegion *ram_memory,
               MemoryRegion *system_memory, MemoryRegion *pci_address_space,
-              PAMMemoryRegion *mem, uint32_t start, uint32_t size)
+              uint32_t start, uint32_t size)
 {
     int i;
 
     /* RAM */
-    memory_region_init_alias(&mem->alias[3], OBJECT(dev), "pam-ram", ram_memory,
+    memory_region_init_alias(&mem->alias[3], owner, "pam-ram", ram_memory,
                              start, size);
     /* ROM (XXX: not quite correct) */
-    memory_region_init_alias(&mem->alias[1], OBJECT(dev), "pam-rom", ram_memory,
+    memory_region_init_alias(&mem->alias[1], owner, "pam-rom", ram_memory,
                              start, size);
     memory_region_set_readonly(&mem->alias[1], true);
 
     /* XXX: should distinguish read/write cases */
-    memory_region_init_alias(&mem->alias[0], OBJECT(dev), "pam-pci", pci_address_space,
+    memory_region_init_alias(&mem->alias[0], owner, "pam-pci", pci_address_space,
                              start, size);
-    memory_region_init_alias(&mem->alias[2], OBJECT(dev), "pam-pci", ram_memory,
+    memory_region_init_alias(&mem->alias[2], owner, "pam-pci", ram_memory,
                              start, size);
 
     memory_region_transaction_begin();
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index fa05844319..fd18920e7f 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -645,12 +645,12 @@ static void mch_realize(PCIDevice *d, Error **errp)
     object_property_add_const_link(qdev_get_machine(), "smram",
                                    OBJECT(&mch->smram));
 
-    init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
-             mch->pci_address_space, &mch->pam_regions[0],
+    init_pam(&mch->pam_regions[0], OBJECT(mch), mch->ram_memory,
+             mch->system_memory, mch->pci_address_space,
              PAM_BIOS_BASE, PAM_BIOS_SIZE);
     for (i = 0; i < ARRAY_SIZE(mch->pam_regions) - 1; ++i) {
-        init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
-                 mch->pci_address_space, &mch->pam_regions[i+1],
+        init_pam(&mch->pam_regions[i + 1], OBJECT(mch), mch->ram_memory,
+                 mch->system_memory, mch->pci_address_space,
                  PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
     }
 }
-- 
MST


