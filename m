Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E816770D51A
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:34:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MWx-0001oV-0k; Tue, 23 May 2023 03:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWt-0001ce-Cc
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWq-0004IC-Il
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oOHRUWif8BsQyskgAko4NvRtPtFcWyxMKqN8AZjsNh4=;
 b=D5wqK1Sr8m1ewSbG5fpg2So5LBQnGBYU+X16XHaGAPHi/wC4NxQgeBf5g8Y6hV7MvHnQAV
 euzCKObYVF6h/mFSaFXGFVF4HlxEgCHsijhHCE2Lu5FJXuc5gKp0tA74Ba4FitOJgytscp
 R4NaW7C5vSHZASZ3kSa4pNEyjIXbeWo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-h0u6Q8VMNGyEKIbzWLlcuA-1; Tue, 23 May 2023 03:33:51 -0400
X-MC-Unique: h0u6Q8VMNGyEKIbzWLlcuA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3035F85A5A8;
 Tue, 23 May 2023 07:33:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AC502166B25;
 Tue, 23 May 2023 07:33:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 23/50] e1000e: Reset packet state after emptying Tx queue
Date: Tue, 23 May 2023 15:32:11 +0800
Message-Id: <20230523073238.54236-24-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Keeping Tx packet state after the transmit queue is emptied has some
problems:
- The datasheet says the descriptors can be reused after the transmit
  queue is emptied, but the Tx packet state may keep references to them.
- The Tx packet state cannot be migrated so it can be reset anytime the
  migration happens.

Always reset Tx packet state always after the queue is emptied.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 6a213c0..7dce448 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -959,6 +959,8 @@ e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
     if (!ide || !e1000e_intrmgr_delay_tx_causes(core, &cause)) {
         e1000e_set_interrupt_cause(core, cause);
     }
+
+    net_tx_pkt_reset(txr->tx->tx_pkt, net_tx_pkt_unmap_frag_pci, core->owner);
 }
 
 static bool
@@ -3389,8 +3391,6 @@ e1000e_core_pci_uninit(E1000ECore *core)
     qemu_del_vm_change_state_handler(core->vmstate);
 
     for (i = 0; i < E1000E_NUM_QUEUES; i++) {
-        net_tx_pkt_reset(core->tx[i].tx_pkt,
-                         net_tx_pkt_unmap_frag_pci, core->owner);
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
     }
 
@@ -3515,8 +3515,6 @@ static void e1000e_reset(E1000ECore *core, bool sw)
     e1000x_reset_mac_addr(core->owner_nic, core->mac, core->permanent_mac);
 
     for (i = 0; i < ARRAY_SIZE(core->tx); i++) {
-        net_tx_pkt_reset(core->tx[i].tx_pkt,
-                         net_tx_pkt_unmap_frag_pci, core->owner);
         memset(&core->tx[i].props, 0, sizeof(core->tx[i].props));
         core->tx[i].skip_cp = false;
     }
-- 
2.7.4


