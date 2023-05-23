Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF8170D52E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:36:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MY6-0004qI-No; Tue, 23 May 2023 03:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXi-0004LC-4c
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXg-0004RD-Bm
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJuLL4Fh7KJz+pK4XydvrU9QXdjX2JZjnMnpnLKo0Fg=;
 b=VoqNgNGunBkFroY3GcspEFe+809ysjPtkRQv5jQBQIIvLBoleVNgrLHsFYUhNNwY4JzeNp
 lpzLtyd7zEOZc6GjUBoDo2wIFneTrZs769hP5bAQlpL1bHK++sY6swtzaoiiuTSMGeyKgp
 Wveji+6wY0V9O07hJqrbLeI7VLnRTvU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-uBYp4GijO-eRKwEqSZQVxw-1; Tue, 23 May 2023 03:34:43 -0400
X-MC-Unique: uBYp4GijO-eRKwEqSZQVxw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E950F3814945;
 Tue, 23 May 2023 07:34:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDA292166B25;
 Tue, 23 May 2023 07:34:40 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 40/50] igb: Filter with the second VLAN tag for extended VLAN
Date: Tue, 23 May 2023 15:32:28 +0800
Message-Id: <20230523073238.54236-41-jasowang@redhat.com>
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb_core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 688eaf7..5345f57 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -69,7 +69,7 @@ typedef struct IGBTxPktVmdqCallbackContext {
 
 typedef struct L2Header {
     struct eth_header eth;
-    struct vlan_header vlan;
+    struct vlan_header vlan[2];
 } L2Header;
 
 static ssize_t
@@ -1001,7 +1001,7 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
     uint32_t f, ra[2], *macp, rctl = core->mac[RCTL];
     uint16_t queues = 0;
     uint16_t oversized = 0;
-    uint16_t vid = be16_to_cpu(l2_header->vlan.h_tci) & VLAN_VID_MASK;
+    size_t vlan_num = 0;
     int i;
 
     memset(rss_info, 0, sizeof(E1000E_RSSInfo));
@@ -1010,8 +1010,19 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
         *external_tx = true;
     }
 
-    if (e1000x_is_vlan_packet(ehdr, core->mac[VET] & 0xffff) &&
-        !e1000x_rx_vlan_filter(core->mac, PKT_GET_VLAN_HDR(ehdr))) {
+    if (core->mac[CTRL_EXT] & BIT(26)) {
+        if (be16_to_cpu(ehdr->h_proto) == core->mac[VET] >> 16 &&
+            be16_to_cpu(l2_header->vlan[0].h_proto) == (core->mac[VET] & 0xffff)) {
+            vlan_num = 2;
+        }
+    } else {
+        if (be16_to_cpu(ehdr->h_proto) == (core->mac[VET] & 0xffff)) {
+            vlan_num = 1;
+        }
+    }
+
+    if (vlan_num &&
+        !e1000x_rx_vlan_filter(core->mac, l2_header->vlan + vlan_num - 1)) {
         return queues;
     }
 
@@ -1065,7 +1076,9 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
         if (e1000x_vlan_rx_filter_enabled(core->mac)) {
             uint16_t mask = 0;
 
-            if (e1000x_is_vlan_packet(ehdr, core->mac[VET] & 0xffff)) {
+            if (vlan_num) {
+                uint16_t vid = be16_to_cpu(l2_header->vlan[vlan_num - 1].h_tci) & VLAN_VID_MASK;
+
                 for (i = 0; i < E1000_VLVF_ARRAY_SIZE; i++) {
                     if ((core->mac[VLVF0 + i] & E1000_VLVF_VLANID_MASK) == vid &&
                         (core->mac[VLVF0 + i] & E1000_VLVF_VLANID_ENABLE)) {
-- 
2.7.4


