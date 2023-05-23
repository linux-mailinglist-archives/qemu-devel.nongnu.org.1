Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D4470D545
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:37:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MXV-0003nr-Na; Tue, 23 May 2023 03:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXE-0003Mh-4s
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXB-0004Mx-Mi
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3RnZGYK2GPCDYSG5dii0f5PQxzkflHYR6nN2snRxtg=;
 b=hFZVIhjqhtVgK/n10JZwHQ/cm3U2vjfo5D0jWnqe4dl2CMS82eLXWQkVnDbVceWJmajUxH
 VcZsZXFUkmK+bVhvGNwzc3aCSa/f/oVgbUQbHDPP/I6UeIigidZ/SQjUmnQsqLTCMoRbsV
 txWPOVBURZcYjvIKXgwc8/XnSrRIHO0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-22mc6fG5MqyVCmDou8Gnhw-1; Tue, 23 May 2023 03:34:13 -0400
X-MC-Unique: 22mc6fG5MqyVCmDou8Gnhw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DFB21C0512A;
 Tue, 23 May 2023 07:34:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A82BD2166B25;
 Tue, 23 May 2023 07:34:10 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 30/50] igb: Rename a variable in igb_receive_internal()
Date: Tue, 23 May 2023 15:32:18 +0800
Message-Id: <20230523073238.54236-31-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
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

Rename variable "n" to "causes", which properly represents the content
of the variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index edda07e..c954369 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1569,7 +1569,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
                      bool has_vnet, bool *external_tx)
 {
     uint16_t queues = 0;
-    uint32_t n = 0;
+    uint32_t causes = 0;
     union {
         L2Header l2_header;
         uint8_t octets[ETH_ZLEN];
@@ -1649,19 +1649,19 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
             e1000x_fcs_len(core->mac);
 
         if (!igb_has_rxbufs(core, rxr.i, total_size)) {
-            n |= E1000_ICS_RXO;
+            causes |= E1000_ICS_RXO;
             trace_e1000e_rx_not_written_to_guest(rxr.i->idx);
             continue;
         }
 
-        n |= E1000_ICR_RXDW;
+        causes |= E1000_ICR_RXDW;
 
         igb_rx_fix_l4_csum(core, core->rx_pkt);
         igb_write_packet_to_guest(core, core->rx_pkt, &rxr, &rss_info);
 
         /* Check if receive descriptor minimum threshold hit */
         if (igb_rx_descr_threshold_hit(core, rxr.i)) {
-            n |= E1000_ICS_RXDMT0;
+            causes |= E1000_ICS_RXDMT0;
         }
 
         core->mac[EICR] |= igb_rx_wb_eic(core, rxr.i->idx);
@@ -1669,8 +1669,8 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
         trace_e1000e_rx_written_to_guest(rxr.i->idx);
     }
 
-    trace_e1000e_rx_interrupt_set(n);
-    igb_set_interrupt_cause(core, n);
+    trace_e1000e_rx_interrupt_set(causes);
+    igb_set_interrupt_cause(core, causes);
 
     return orig_size;
 }
-- 
2.7.4


