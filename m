Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 287A87F2C2E
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 12:55:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PJi-0003Sg-8s; Tue, 21 Nov 2023 06:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJf-0003Qe-B1
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJd-0004Is-DN
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700567596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zOJjZM3lOQ0hZlLOlkek/qu6DTt2VFvJHbwdU5aXXG0=;
 b=AD0Pf3Ipx8RKBSk6j4reyyS31aULfd5/O4qCHqmOY68bQ0irV+bKQehLOb1NZAXZmNn21X
 +fqtrlC6/4hzLmj4tW5/93KYmXuS7ksbczDDQdL7qROQqzqpOWdTJXQlnLnr7b3o1mbv7I
 fMGVgzpsF/CSJp5i/4n+8fj33S3lv50=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-Q-rvEX8iNFqPuaLIbhMNww-1; Tue, 21 Nov 2023 06:53:13 -0500
X-MC-Unique: Q-rvEX8iNFqPuaLIbhMNww-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C7C91019C83;
 Tue, 21 Nov 2023 11:53:13 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A037B492BFC;
 Tue, 21 Nov 2023 11:53:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 7/9] ide/pci: introduce pci_ide_update_mode() function
Date: Tue, 21 Nov 2023 12:53:00 +0100
Message-ID: <20231121115302.52214-8-kwolf@redhat.com>
In-Reply-To: <20231121115302.52214-1-kwolf@redhat.com>
References: <20231121115302.52214-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This function reads the value of the PCI_CLASS_PROG register for PCI IDE
controllers and configures the PCI BARs and/or IDE ioports accordingly.

In the case where we switch to legacy mode, the PCI BARs are set to return zero
(as suggested in the "PCI IDE Controller" specification), the legacy IDE ioports
are enabled, and the PCI interrupt pin cleared to indicate legacy IRQ routing.

Conversely when we switch to native mode, the legacy IDE ioports are disabled
and the PCI interrupt pin set to indicate native IRQ routing. The contents of
the PCI BARs are unspecified, but this is not an issue since if a PCI IDE
controller has been switched to native mode then its BARs will need to be
programmed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20231116103355.588580-3-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/ide/pci.h |  1 +
 hw/ide/pci.c         | 84 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
index 1ff469de87..a814a0a7c3 100644
--- a/include/hw/ide/pci.h
+++ b/include/hw/ide/pci.h
@@ -61,6 +61,7 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val);
 void bmdma_status_writeb(BMDMAState *bm, uint32_t val);
 extern MemoryRegionOps bmdma_addr_ioport_ops;
 void pci_ide_create_devs(PCIDevice *dev);
+void pci_ide_update_mode(PCIIDEState *s);
 
 extern const VMStateDescription vmstate_ide_pci;
 extern const MemoryRegionOps pci_ide_cmd_le_ops;
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index a25b352537..810c6b6d98 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -104,6 +104,90 @@ const MemoryRegionOps pci_ide_data_le_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+void pci_ide_update_mode(PCIIDEState *s)
+{
+    PCIDevice *d = PCI_DEVICE(s);
+    uint8_t mode = d->config[PCI_CLASS_PROG];
+
+    /*
+     * This function only configures the BARs/ioports for now: PCI IDE
+     * controllers must manage their own IRQ routing
+     */
+
+    switch (mode & 0xf) {
+    case 0xa:
+        /* Both channels legacy mode */
+
+        /*
+         * TODO: according to the PCI IDE specification the BARs should
+         * be completely disabled, however Linux for the pegasos2
+         * machine stil accesses the BAR addresses after switching to legacy
+         * mode. Hence we leave them active for now.
+         */
+
+        /* Clear interrupt pin */
+        pci_config_set_interrupt_pin(d->config, 0);
+
+        /* Add legacy IDE ports */
+        if (!s->bus[0].portio_list.owner) {
+            portio_list_init(&s->bus[0].portio_list, OBJECT(d),
+                             ide_portio_list, &s->bus[0], "ide");
+            portio_list_add(&s->bus[0].portio_list,
+                            pci_address_space_io(d), 0x1f0);
+        }
+
+        if (!s->bus[0].portio2_list.owner) {
+            portio_list_init(&s->bus[0].portio2_list, OBJECT(d),
+                             ide_portio2_list, &s->bus[0], "ide");
+            portio_list_add(&s->bus[0].portio2_list,
+                            pci_address_space_io(d), 0x3f6);
+        }
+
+        if (!s->bus[1].portio_list.owner) {
+            portio_list_init(&s->bus[1].portio_list, OBJECT(d),
+                                ide_portio_list, &s->bus[1], "ide");
+            portio_list_add(&s->bus[1].portio_list,
+                            pci_address_space_io(d), 0x170);
+        }
+
+        if (!s->bus[1].portio2_list.owner) {
+            portio_list_init(&s->bus[1].portio2_list, OBJECT(d),
+                             ide_portio2_list, &s->bus[1], "ide");
+            portio_list_add(&s->bus[1].portio2_list,
+                            pci_address_space_io(d), 0x376);
+        }
+        break;
+
+    case 0xf:
+        /* Both channels native mode */
+
+        /* Set interrupt pin */
+        pci_config_set_interrupt_pin(d->config, 1);
+
+        /* Remove legacy IDE ports */
+        if (s->bus[0].portio_list.owner) {
+            portio_list_del(&s->bus[0].portio_list);
+            portio_list_destroy(&s->bus[0].portio_list);
+        }
+
+        if (s->bus[0].portio2_list.owner) {
+            portio_list_del(&s->bus[0].portio2_list);
+            portio_list_destroy(&s->bus[0].portio2_list);
+        }
+
+        if (s->bus[1].portio_list.owner) {
+            portio_list_del(&s->bus[1].portio_list);
+            portio_list_destroy(&s->bus[1].portio_list);
+        }
+
+        if (s->bus[1].portio2_list.owner) {
+            portio_list_del(&s->bus[1].portio2_list);
+            portio_list_destroy(&s->bus[1].portio2_list);
+        }
+        break;
+    }
+}
+
 static IDEState *bmdma_active_if(BMDMAState *bmdma)
 {
     assert(bmdma->bus->retry_unit != (uint8_t)-1);
-- 
2.42.0


