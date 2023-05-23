Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CABA70D514
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:33:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MWT-0000NV-15; Tue, 23 May 2023 03:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWR-0000JZ-Cs
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWP-0004EN-OR
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWwxoIFMhXmVfy8zDYHjTLgc3zy64f1eoR5xSxbh6mU=;
 b=Q2f/zHWU+7u9w4x9yWMFTbOfzoUkmvGmI/ww4tqtPn/F+GKUsU0pgqrpUfjrKJ0sGtcMAn
 CquYevu7Q3//EpSFMD69jwpRuzN/mSnpQEop041dfW9Yku7yTa1YGGu8RcUJw7tQBAvDsp
 NlJuiVAGVOvv2R5iC7f/X6EteCYGvxk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-vH3V76PYOsSo9OznhnaGHw-1; Tue, 23 May 2023 03:33:25 -0400
X-MC-Unique: vH3V76PYOsSo9OznhnaGHw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20B8C85A5A8;
 Tue, 23 May 2023 07:33:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01F2F2166B26;
 Tue, 23 May 2023 07:33:22 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 14/50] hw/net/net_tx_pkt: Remove net_rx_pkt_get_l4_info
Date: Tue, 23 May 2023 15:32:02 +0800
Message-Id: <20230523073238.54236-15-jasowang@redhat.com>
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

This function is not used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/net_rx_pkt.c | 5 -----
 hw/net/net_rx_pkt.h | 9 ---------
 2 files changed, 14 deletions(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 63be6e0..6125a06 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -236,11 +236,6 @@ eth_ip4_hdr_info *net_rx_pkt_get_ip4_info(struct NetRxPkt *pkt)
     return &pkt->ip4hdr_info;
 }
 
-eth_l4_hdr_info *net_rx_pkt_get_l4_info(struct NetRxPkt *pkt)
-{
-    return &pkt->l4hdr_info;
-}
-
 static inline void
 _net_rx_rss_add_chunk(uint8_t *rss_input, size_t *bytes_written,
                       void *ptr, size_t size)
diff --git a/hw/net/net_rx_pkt.h b/hw/net/net_rx_pkt.h
index a06f5c2..ce8dbdb 100644
--- a/hw/net/net_rx_pkt.h
+++ b/hw/net/net_rx_pkt.h
@@ -119,15 +119,6 @@ eth_ip6_hdr_info *net_rx_pkt_get_ip6_info(struct NetRxPkt *pkt);
  */
 eth_ip4_hdr_info *net_rx_pkt_get_ip4_info(struct NetRxPkt *pkt);
 
-/**
- * fetches L4 header analysis results
- *
- * Return:  pointer to analysis results structure which is stored in internal
- *          packet area.
- *
- */
-eth_l4_hdr_info *net_rx_pkt_get_l4_info(struct NetRxPkt *pkt);
-
 typedef enum {
     NetPktRssIpV4,
     NetPktRssIpV4Tcp,
-- 
2.7.4


