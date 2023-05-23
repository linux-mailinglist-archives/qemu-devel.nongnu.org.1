Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DD070D538
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:36:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MXk-0003x9-Gz; Tue, 23 May 2023 03:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXR-0003mL-2s
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXP-0004No-0a
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=isH0x3Is63o2SVLK7u7/2nLvAeemYKpZ/xUkVxPqjlI=;
 b=V5m9AWcdzax4snwVHRFJN3EW+/FfxOCLmB7b8mWwycOPQyqtqu95ANKVTB32zp77uOrL5l
 CjOLb2q79O7UyyXsv7G31qninUGnZu0aKFrjkL+PCm+7kpZ7xVDhX0A5VxUpvomPsx8LB5
 UKu+iHABk6FCwOuDKRkuIfUBQrBYgHM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-X4w5TOlzM82xYkuyCnnxNA-1; Tue, 23 May 2023 03:34:22 -0400
X-MC-Unique: X4w5TOlzM82xYkuyCnnxNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1F88802A55;
 Tue, 23 May 2023 07:34:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EE822166B26;
 Tue, 23 May 2023 07:34:19 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 33/50] hw/net/net_rx_pkt: Enforce alignment for eth_header
Date: Tue, 23 May 2023 15:32:21 +0800
Message-Id: <20230523073238.54236-34-jasowang@redhat.com>
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

eth_strip_vlan and eth_strip_vlan_ex refers to ehdr_buf as struct
eth_header. Enforce alignment for the structure.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/net_rx_pkt.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 6125a06..1de42b4 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -23,7 +23,10 @@
 
 struct NetRxPkt {
     struct virtio_net_hdr virt_hdr;
-    uint8_t ehdr_buf[sizeof(struct eth_header) + sizeof(struct vlan_header)];
+    struct {
+        struct eth_header eth;
+        struct vlan_header vlan;
+    } ehdr_buf;
     struct iovec *vec;
     uint16_t vec_len_total;
     uint16_t vec_len;
@@ -89,7 +92,7 @@ net_rx_pkt_pull_data(struct NetRxPkt *pkt,
     if (pkt->ehdr_buf_len) {
         net_rx_pkt_iovec_realloc(pkt, iovcnt + 1);
 
-        pkt->vec[0].iov_base = pkt->ehdr_buf;
+        pkt->vec[0].iov_base = &pkt->ehdr_buf;
         pkt->vec[0].iov_len = pkt->ehdr_buf_len;
 
         pkt->tot_len = pllen + pkt->ehdr_buf_len;
@@ -120,7 +123,7 @@ void net_rx_pkt_attach_iovec(struct NetRxPkt *pkt,
     assert(pkt);
 
     if (strip_vlan) {
-        pkt->ehdr_buf_len = eth_strip_vlan(iov, iovcnt, iovoff, pkt->ehdr_buf,
+        pkt->ehdr_buf_len = eth_strip_vlan(iov, iovcnt, iovoff, &pkt->ehdr_buf,
                                            &ploff, &tci);
     } else {
         pkt->ehdr_buf_len = 0;
@@ -142,7 +145,7 @@ void net_rx_pkt_attach_iovec_ex(struct NetRxPkt *pkt,
 
     if (strip_vlan) {
         pkt->ehdr_buf_len = eth_strip_vlan_ex(iov, iovcnt, iovoff, vet,
-                                              pkt->ehdr_buf,
+                                              &pkt->ehdr_buf,
                                               &ploff, &tci);
     } else {
         pkt->ehdr_buf_len = 0;
-- 
2.7.4


