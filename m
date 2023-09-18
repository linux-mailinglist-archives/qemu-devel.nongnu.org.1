Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFFD7A44C6
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:33:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9ga-0006aB-BF; Mon, 18 Sep 2023 04:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9g5-00064t-NE
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9g1-0004DR-0S
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695025936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03wYiwxNKHwdUVh62jeqpGytwnLxIyJF9wiiRcQP/2g=;
 b=SrfEn0j22a4d1lgC00NiKxWyy0AwOqSvEs0G8w2kRBsM/+ge4z0WZFCgL5Il7UGBNHnZJ4
 bgI7fxnpeRA21hnY5b6ndZ8z6FLfuC+Nw4K9otnGkQPc0BVJp1fx4/AcFM4TJMhInyvtNS
 ACLsO1peNJwkiGxL3YrcABbRBMB13os=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-685-AIDZvYL3PWmgysr20LVwhw-1; Mon, 18 Sep 2023 04:32:10 -0400
X-MC-Unique: AIDZvYL3PWmgysr20LVwhw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C45E1C0512E;
 Mon, 18 Sep 2023 08:32:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09A372156701;
 Mon, 18 Sep 2023 08:32:06 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 11/17] e1000e: rename e1000e_ba_state and
 e1000e_write_hdr_to_rx_buffers
Date: Mon, 18 Sep 2023 16:31:26 +0800
Message-Id: <20230918083132.55423-12-jasowang@redhat.com>
In-Reply-To: <20230918083132.55423-1-jasowang@redhat.com>
References: <20230918083132.55423-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>

Rename e1000e_ba_state according and e1000e_write_hdr_to_rx_buffers for
consistency with IGB.

Signed-off-by: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index cc243b7..e324c02 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1397,17 +1397,17 @@ e1000e_pci_dma_write_rx_desc(E1000ECore *core, dma_addr_t addr,
     }
 }
 
-typedef struct e1000e_ba_state_st {
+typedef struct E1000EBAState {
     uint16_t written[MAX_PS_BUFFERS];
     uint8_t cur_idx;
-} e1000e_ba_state;
+} E1000EBAState;
 
 static inline void
-e1000e_write_hdr_to_rx_buffers(E1000ECore *core,
-                               hwaddr ba[MAX_PS_BUFFERS],
-                               e1000e_ba_state *bastate,
-                               const char *data,
-                               dma_addr_t data_len)
+e1000e_write_hdr_frag_to_rx_buffers(E1000ECore *core,
+                                    hwaddr ba[MAX_PS_BUFFERS],
+                                    E1000EBAState *bastate,
+                                    const char *data,
+                                    dma_addr_t data_len)
 {
     assert(data_len <= core->rxbuf_sizes[0] - bastate->written[0]);
 
@@ -1420,7 +1420,7 @@ e1000e_write_hdr_to_rx_buffers(E1000ECore *core,
 static void
 e1000e_write_payload_frag_to_rx_buffers(E1000ECore *core,
                                         hwaddr ba[MAX_PS_BUFFERS],
-                                        e1000e_ba_state *bastate,
+                                        E1000EBAState *bastate,
                                         const char *data,
                                         dma_addr_t data_len)
 {
@@ -1530,7 +1530,7 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
 
     do {
         hwaddr ba[MAX_PS_BUFFERS];
-        e1000e_ba_state bastate = { { 0 } };
+        E1000EBAState bastate = { { 0 } };
         bool is_last = false;
 
         desc_size = total_size - desc_offset;
@@ -1568,8 +1568,10 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
                             iov_copy = MIN(ps_hdr_len - ps_hdr_copied,
                                            iov->iov_len - iov_ofs);
 
-                            e1000e_write_hdr_to_rx_buffers(core, ba, &bastate,
-                                                      iov->iov_base, iov_copy);
+                            e1000e_write_hdr_frag_to_rx_buffers(core, ba,
+                                                                &bastate,
+                                                                iov->iov_base,
+                                                                iov_copy);
 
                             copy_size -= iov_copy;
                             ps_hdr_copied += iov_copy;
@@ -1585,8 +1587,8 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
                     } else {
                         /* Leave buffer 0 of each descriptor except first */
                         /* empty as per spec 7.1.5.1                      */
-                        e1000e_write_hdr_to_rx_buffers(core, ba, &bastate,
-                                                       NULL, 0);
+                        e1000e_write_hdr_frag_to_rx_buffers(core, ba, &bastate,
+                                                            NULL, 0);
                     }
                 }
 
-- 
2.7.4


