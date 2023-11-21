Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4127F2C2C
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 12:55:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PJh-0003S2-Rj; Tue, 21 Nov 2023 06:53:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJe-0003Q4-A2
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJc-0004Ib-Im
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700567596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSG/PfdVjDwVCm0dpZeFqhRbyAG52BRuZYhEe8B9RYk=;
 b=gvp3Bov46R44PQ75jwLcjIWCgvyy5f4gPOOIJX8fO27BRXhqHGzI1+S/riud/s6VoD9O6k
 FlwzyZYKySkP/O7QpILBw4ys4j6AkPBlnPOPn+2MprUAdiTaaH/MCWamhbqClAzZNfYUgo
 xD4E/CgSDcVOsN9b+BfdmBjqg3uAs9A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-KkrEfVk3O66ht09nfGgopA-1; Tue, 21 Nov 2023 06:53:12 -0500
X-MC-Unique: KkrEfVk3O66ht09nfGgopA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A55280513D;
 Tue, 21 Nov 2023 11:53:12 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD2F0492BFD;
 Tue, 21 Nov 2023 11:53:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 6/9] ide/ioport: move ide_portio_list[] and ide_portio_list2[]
 definitions to IDE core
Date: Tue, 21 Nov 2023 12:52:59 +0100
Message-ID: <20231121115302.52214-7-kwolf@redhat.com>
In-Reply-To: <20231121115302.52214-1-kwolf@redhat.com>
References: <20231121115302.52214-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

These definitions are present in ioport.c which is currently only available when
CONFIG_IDE_ISA is enabled. Move them to the IDE core so that they can be made
available to PCI IDE controllers that support switching to legacy mode.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20231116103355.588580-2-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/ide/internal.h |  3 +++
 hw/ide/core.c             | 12 ++++++++++++
 hw/ide/ioport.c           | 12 ------------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 2bfa7533d6..3bdcc75597 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -354,6 +354,9 @@ enum ide_dma_cmd {
 
 extern const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT];
 
+extern const MemoryRegionPortio ide_portio_list[];
+extern const MemoryRegionPortio ide_portio2_list[];
+
 #define ide_cmd_is_read(s) \
         ((s)->dma_cmd == IDE_DMA_READ)
 
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 63ba665f3d..8a0579bff4 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -81,6 +81,18 @@ static const char *IDE_DMA_CMD_str(enum ide_dma_cmd enval)
 
 static void ide_dummy_transfer_stop(IDEState *s);
 
+const MemoryRegionPortio ide_portio_list[] = {
+    { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
+    { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
+    { 0, 1, 4, .read = ide_data_readl, .write = ide_data_writel },
+    PORTIO_END_OF_LIST(),
+};
+
+const MemoryRegionPortio ide_portio2_list[] = {
+    { 0, 1, 1, .read = ide_status_read, .write = ide_ctrl_write },
+    PORTIO_END_OF_LIST(),
+};
+
 static void padstr(char *str, const char *src, int len)
 {
     int i, v;
diff --git a/hw/ide/ioport.c b/hw/ide/ioport.c
index e2ecc6230c..0b283ac783 100644
--- a/hw/ide/ioport.c
+++ b/hw/ide/ioport.c
@@ -28,18 +28,6 @@
 #include "hw/ide/internal.h"
 #include "trace.h"
 
-static const MemoryRegionPortio ide_portio_list[] = {
-    { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
-    { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
-    { 0, 1, 4, .read = ide_data_readl, .write = ide_data_writel },
-    PORTIO_END_OF_LIST(),
-};
-
-static const MemoryRegionPortio ide_portio2_list[] = {
-    { 0, 1, 1, .read = ide_status_read, .write = ide_ctrl_write },
-    PORTIO_END_OF_LIST(),
-};
-
 int ide_init_ioport(IDEBus *bus, ISADevice *dev, int iobase, int iobase2)
 {
     int ret;
-- 
2.42.0


