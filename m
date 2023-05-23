Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ECC70D521
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:35:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MWY-0000V7-A8; Tue, 23 May 2023 03:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWW-0000Ru-H9
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWU-0004Fo-MR
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=luG5dhqS+Ww9MGuePhIxHgpZxhqOPXjsSjk+cSrI1mw=;
 b=EFrYfrRA+wSJsYxVJk0lb/SdktUfFupzOOy6RMCSUggGL0ZRpLmiwx5eP/M58QxNdIKcsV
 TV1ur+TuxDoPqpye8ARHLnORbPPNIER7IHBf3rCiGD+BzjENPzz+eElsuBUeUsqOqUK92q
 g6ZT2BCdsCuadvnXbvB0g3NeK1L25lU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-aVoOATx3Na-tO_S2RDxJrg-1; Tue, 23 May 2023 03:33:28 -0400
X-MC-Unique: aVoOATx3Na-tO_S2RDxJrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B57E800B35;
 Tue, 23 May 2023 07:33:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6C472166B26;
 Tue, 23 May 2023 07:33:25 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 15/50] net/eth: Rename eth_setup_vlan_headers_ex
Date: Tue, 23 May 2023 15:32:03 +0800
Message-Id: <20230523073238.54236-16-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The old eth_setup_vlan_headers has no user so remove it and rename
eth_setup_vlan_headers_ex.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/net_tx_pkt.c | 2 +-
 include/net/eth.h   | 9 +--------
 net/eth.c           | 2 +-
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index cc36750..ce6b102 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -368,7 +368,7 @@ void net_tx_pkt_setup_vlan_header_ex(struct NetTxPkt *pkt,
     bool is_new;
     assert(pkt);
 
-    eth_setup_vlan_headers_ex(pkt->vec[NET_TX_PKT_L2HDR_FRAG].iov_base,
+    eth_setup_vlan_headers(pkt->vec[NET_TX_PKT_L2HDR_FRAG].iov_base,
         vlan, vlan_ethtype, &is_new);
 
     /* update l2hdrlen */
diff --git a/include/net/eth.h b/include/net/eth.h
index 9f19c3a..e8af574 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -351,16 +351,9 @@ eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
 uint16_t
 eth_get_l3_proto(const struct iovec *l2hdr_iov, int iovcnt, size_t l2hdr_len);
 
-void eth_setup_vlan_headers_ex(struct eth_header *ehdr, uint16_t vlan_tag,
+void eth_setup_vlan_headers(struct eth_header *ehdr, uint16_t vlan_tag,
     uint16_t vlan_ethtype, bool *is_new);
 
-static inline void
-eth_setup_vlan_headers(struct eth_header *ehdr, uint16_t vlan_tag,
-    bool *is_new)
-{
-    eth_setup_vlan_headers_ex(ehdr, vlan_tag, ETH_P_VLAN, is_new);
-}
-
 
 uint8_t eth_get_gso_type(uint16_t l3_proto, uint8_t *l3_hdr, uint8_t l4proto);
 
diff --git a/net/eth.c b/net/eth.c
index d7b30df..b6ff89c 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -21,7 +21,7 @@
 #include "net/checksum.h"
 #include "net/tap.h"
 
-void eth_setup_vlan_headers_ex(struct eth_header *ehdr, uint16_t vlan_tag,
+void eth_setup_vlan_headers(struct eth_header *ehdr, uint16_t vlan_tag,
     uint16_t vlan_ethtype, bool *is_new)
 {
     struct vlan_header *vhdr = PKT_GET_VLAN_HDR(ehdr);
-- 
2.7.4


