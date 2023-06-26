Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA7973DF3A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:30:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlM2-0003o3-Bx; Mon, 26 Jun 2023 08:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLI-0002hd-Iw
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLF-00034w-Id
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oxD0qVGpFZfM6ssT+tppltDSBoyNs1nLWG55cRcTQec=;
 b=hfvYsDcfHaL9oUGcS2dz3Z5aXOF59DZkHCVBRNMqLh7WOT2e12sw9uGJtIt6cUUKA8M7hb
 9jStRWb4rzNCEBewUrqzKHm1usrO87ywghlnzQQH6xvIHIhNF9rxYg7hNhNSbBW432uijk
 okzY3HOTnuYbhRCPlu1JY+m9lxBg8nc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-3I-cKAvGPS-_F82eMmOZcw-1; Mon, 26 Jun 2023 08:29:09 -0400
X-MC-Unique: 3I-cKAvGPS-_F82eMmOZcw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fa8db49267so6436235e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782548; x=1690374548;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oxD0qVGpFZfM6ssT+tppltDSBoyNs1nLWG55cRcTQec=;
 b=NXe7q4TU4ip3m4u+25+0IDRvbEIuaMDi6oyIR6Hlpmhx5wE3tjNNht34q7TnuXylqI
 cQ6S+g+crMjA/80ULQDaw7CgWBiKFOqybtfCi7H+n4cYIn1Wzy3+dAwJdTuTfgP7aVMi
 tXFcH+80EWgLjICdTcberUc/xiZh6t7ZEkvxV2W/Q0eXclkYrB6s7/tQdtHIN43VYH9O
 sTVfDZagwfKZ5ebLJE7XBpEkUHNgnmQ9GWOuvstwmenfuPJ2iySpYhT8kk3kI6J/KfY8
 gbL5MfzCDlprtepovc8naRSaDnRgJC3qwYlHKc3J42snIVWS5DBtQtAgYDGJjEdDl6iN
 QoUA==
X-Gm-Message-State: AC+VfDywr6suAT3HCzCpfDEamKr8cRYmQJ8a7PbF/bzgjg/tnLLpaO6T
 BqX9egux3SWh16SChjDeAhC3oIsfHanqoyFdtn0FVhR5F1UYkSgS2AfY8GcqvluOSz0coN4smek
 NMTZN8hywY6+fHCD9Zr3+N7LH770I9MEM/Ofln3Ucq6olalcRuKnnM5IohUwViQaNBG1p
X-Received: by 2002:a1c:791a:0:b0:3fa:76e2:e6d5 with SMTP id
 l26-20020a1c791a000000b003fa76e2e6d5mr9421378wme.37.1687782548249; 
 Mon, 26 Jun 2023 05:29:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4teelUdCRr5kW51oNM2c2I52EzvjDSU3befidHJy8Kvc0wHu7RBuK5pqPCQl/HMO+y2CRW1g==
X-Received: by 2002:a1c:791a:0:b0:3fa:76e2:e6d5 with SMTP id
 l26-20020a1c791a000000b003fa76e2e6d5mr9421359wme.37.1687782547917; 
 Mon, 26 Jun 2023 05:29:07 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 a17-20020a05600c225100b003f42314832fsm7595282wmm.18.2023.06.26.05.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:07 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 25/53] pci: ROM preallocation for incoming migration
Message-ID: <8eb85fb5ac60bfb6ee4c729cc087078d490670c4.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

On incoming migration we have the following sequence to load option
ROM:

1. On device realize we do normal load ROM from the file

2. Than, on incoming migration we rewrite ROM from the incoming RAM
   block. If sizes mismatch we fail, like this:

    Size mismatch: 0000:00:03.0/virtio-net-pci.rom: 0x40000 != 0x80000: Invalid argument

This is not ideal when we migrate to updated distribution: we have to
keep old ROM files in new distribution and be careful around romfile
property to load correct ROM file. Which is loaded actually just to
allocate the ROM with correct length.

Note, that romsize property doesn't really help: if we try to specify
it when default romfile is larger, it fails with something like:

    romfile "efi-virtio.rom" (160768 bytes) is too large for ROM size 65536

Let's just ignore ROM file when romsize is specified and we are in
incoming migration state. In other words, we need only to preallocate
ROM of specified size, local ROM file is unrelated.

This way:

If romsize was specified on source, we just use same commandline as on
source, and migration will work independently of local ROM files on
target.

If romsize was not specified on source (and we have mismatching local
ROM file on target host), we have to specify romsize on target to match
source romsize. romfile parameter may be kept same as on source or may
be dropped, the file is not loaded anyway.

As a bonus we avoid extra reading from ROM file on target.

Note: when we don't have romsize parameter on source command line and
need it for target, it may be calculated as aligned up to power of two
size of ROM file on source (if we know, which file is it) or,
alternatively it may be retrieved from source QEMU by QMP qom-get
command, like

  { "execute": "qom-get",
    "arguments": {
      "path": "/machine/peripheral/CARD_ID/virtio-net-pci.rom[0]",
      "property": "size" } }

Note: we have extra initialization of size variable to zero in
      pci_add_option_rom to avoid false-positive
      "error: ‘size’ may be used uninitialized"

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230522201740.88960-2-vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 79 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index bf38905b7d..e2eb4c3b4a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -36,6 +36,7 @@
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "sysemu/numa.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
@@ -2308,12 +2309,18 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
 static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
                                Error **errp)
 {
-    int64_t size;
+    int64_t size = 0;
     g_autofree char *path = NULL;
-    void *ptr;
     char name[32];
     const VMStateDescription *vmsd;
 
+    /*
+     * In case of incoming migration ROM will come with migration stream, no
+     * reason to load the file.  Neither we want to fail if local ROM file
+     * mismatches with specified romsize.
+     */
+    bool load_file = !runstate_check(RUN_STATE_INMIGRATE);
+
     if (!pdev->romfile || !strlen(pdev->romfile)) {
         return;
     }
@@ -2343,32 +2350,35 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         return;
     }
 
-    path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
-    if (path == NULL) {
-        path = g_strdup(pdev->romfile);
-    }
+    if (load_file || pdev->romsize == -1) {
+        path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
+        if (path == NULL) {
+            path = g_strdup(pdev->romfile);
+        }
 
-    size = get_image_size(path);
-    if (size < 0) {
-        error_setg(errp, "failed to find romfile \"%s\"", pdev->romfile);
-        return;
-    } else if (size == 0) {
-        error_setg(errp, "romfile \"%s\" is empty", pdev->romfile);
-        return;
-    } else if (size > 2 * GiB) {
-        error_setg(errp, "romfile \"%s\" too large (size cannot exceed 2 GiB)",
-                   pdev->romfile);
-        return;
-    }
-    if (pdev->romsize != -1) {
-        if (size > pdev->romsize) {
-            error_setg(errp, "romfile \"%s\" (%u bytes) "
-                       "is too large for ROM size %u",
-                       pdev->romfile, (uint32_t)size, pdev->romsize);
+        size = get_image_size(path);
+        if (size < 0) {
+            error_setg(errp, "failed to find romfile \"%s\"", pdev->romfile);
+            return;
+        } else if (size == 0) {
+            error_setg(errp, "romfile \"%s\" is empty", pdev->romfile);
+            return;
+        } else if (size > 2 * GiB) {
+            error_setg(errp,
+                       "romfile \"%s\" too large (size cannot exceed 2 GiB)",
+                       pdev->romfile);
             return;
         }
-    } else {
-        pdev->romsize = pow2ceil(size);
+        if (pdev->romsize != -1) {
+            if (size > pdev->romsize) {
+                error_setg(errp, "romfile \"%s\" (%u bytes) "
+                           "is too large for ROM size %u",
+                           pdev->romfile, (uint32_t)size, pdev->romsize);
+                return;
+            }
+        } else {
+            pdev->romsize = pow2ceil(size);
+        }
     }
 
     vmsd = qdev_get_vmsd(DEVICE(pdev));
@@ -2379,15 +2389,18 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
     memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, pdev->romsize,
                            &error_fatal);
 
-    ptr = memory_region_get_ram_ptr(&pdev->rom);
-    if (load_image_size(path, ptr, size) < 0) {
-        error_setg(errp, "failed to load romfile \"%s\"", pdev->romfile);
-        return;
-    }
+    if (load_file) {
+        void *ptr = memory_region_get_ram_ptr(&pdev->rom);
 
-    if (is_default_rom) {
-        /* Only the default rom images will be patched (if needed). */
-        pci_patch_ids(pdev, ptr, size);
+        if (load_image_size(path, ptr, size) < 0) {
+            error_setg(errp, "failed to load romfile \"%s\"", pdev->romfile);
+            return;
+        }
+
+        if (is_default_rom) {
+            /* Only the default rom images will be patched (if needed). */
+            pci_patch_ids(pdev, ptr, size);
+        }
     }
 
     pci_register_bar(pdev, PCI_ROM_SLOT, 0, &pdev->rom);
-- 
MST


