Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE67FBC53
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:11:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ymW-0002MG-6q; Tue, 28 Nov 2023 09:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7ymR-0002JO-3j
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:09:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7ymP-0006U2-Ij
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701180576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=umnPBK3VGu358F8xxkox0fj9KssCnkBOku4pq7Ecm5c=;
 b=GCNJolN+xxykwHUyyHOM7JcHYQbXeDfb9io+QN+8xiUsK21Ojz7a0GH0r4AYsinPPf6TPb
 GTG4j1ADUxE/uBdiGGgEdk6DyRpDx0oCuc2RGywFHmq06TmfoHZ0yOZ4Q/zc208tVcf9Ww
 paUgxm/pgE7kr/smDJiML/43pJg6CY0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-xClDPnsiP32GbcxDyIOmLA-1; Tue, 28 Nov 2023 09:09:35 -0500
X-MC-Unique: xClDPnsiP32GbcxDyIOmLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B64B8678B1;
 Tue, 28 Nov 2023 14:09:34 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD0E3502A;
 Tue, 28 Nov 2023 14:09:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 4/4] ide/via: Fix BAR4 value in legacy mode
Date: Tue, 28 Nov 2023 15:09:26 +0100
Message-ID: <20231128140926.106077-5-kwolf@redhat.com>
In-Reply-To: <20231128140926.106077-1-kwolf@redhat.com>
References: <20231128140926.106077-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Return default value in legacy mode for BAR4 when unset. This can't be
set in reset method because BARs are cleared on reset so we return it
instead when BARs are read in legacy mode. This fixes UDMA on amigaone
with AmigaOS.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20231125140135.AF6A075A4C3@zero.eik.bme.hu>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/ide/via.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 2d3124ebd7..3f3c484253 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -163,14 +163,19 @@ static uint32_t via_ide_cfg_read(PCIDevice *pd, uint32_t addr, int len)
     uint32_t val = pci_default_read_config(pd, addr, len);
     uint8_t mode = pd->config[PCI_CLASS_PROG];
 
-    if ((mode & 0xf) == 0xa && ranges_overlap(addr, len,
-                                              PCI_BASE_ADDRESS_0, 16)) {
-        /* BARs always read back zero in legacy mode */
-        for (int i = addr; i < addr + len; i++) {
-            if (i >= PCI_BASE_ADDRESS_0 && i < PCI_BASE_ADDRESS_0 + 16) {
-                val &= ~(0xffULL << ((i - addr) << 3));
+    if ((mode & 0xf) == 0xa) {
+        if (ranges_overlap(addr, len, PCI_BASE_ADDRESS_0, 16)) {
+            /* BARs 0-3 always read back zero in legacy mode */
+            for (int i = addr; i < addr + len; i++) {
+                if (i >= PCI_BASE_ADDRESS_0 && i < PCI_BASE_ADDRESS_0 + 16) {
+                    val &= ~(0xffULL << ((i - addr) << 3));
+                }
             }
         }
+        if (addr == PCI_BASE_ADDRESS_4 && val == PCI_BASE_ADDRESS_SPACE_IO) {
+            /* BAR4 default value if unset */
+            val = 0xcc00 | PCI_BASE_ADDRESS_SPACE_IO;
+        }
     }
 
     return val;
-- 
2.43.0


