Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A6B70D544
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:37:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MWc-0000g9-QB; Tue, 23 May 2023 03:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWa-0000aF-Fz
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MWY-0004GV-TG
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4pp38n8bJO67GlkGaVodP3cQFxGPWd3wh/ucB++suw=;
 b=iicBSbbYy5I90w3l3uJIgbO48BmvXUrjZXGq6DZm4edYFqn8+mxsDXFNRPTzXsTSQIhKkG
 NFbHZ2OoTyNIyO4qydnKFO+XpMmaHiZKP7jnq8Lb3twWa2Yb6hdcmNaUKH/+2KmS03JzqS
 KHQpFpodR1eHSu5G4FkUnQMX9scKgis=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-wL52UrV2MhKeyG0h8wNf4A-1; Tue, 23 May 2023 03:33:33 -0400
X-MC-Unique: wL52UrV2MhKeyG0h8wNf4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98DD229DD98C;
 Tue, 23 May 2023 07:33:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A80E62166B25;
 Tue, 23 May 2023 07:33:31 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 17/50] e1000x: Take CRC into consideration for size check
Date: Tue, 23 May 2023 15:32:05 +0800
Message-Id: <20230523073238.54236-18-jasowang@redhat.com>
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

Section 13.7.15 Receive Length Error Count says:
>  Packets over 1522 bytes are oversized if LongPacketEnable is 0b
> (RCTL.LPE). If LongPacketEnable (LPE) is 1b, then an incoming packet
> is considered oversized if it exceeds 16384 bytes.

> These lengths are based on bytes in the received packet from
> <Destination Address> through <CRC>, inclusively.

As QEMU processes packets without CRC, the number of bytes for CRC
need to be subtracted. This change adds some size definitions to be used
to derive the new size thresholds to eth.h.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000x_common.c | 10 +++++-----
 include/net/eth.h      |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
index 6cc2313..212873f 100644
--- a/hw/net/e1000x_common.c
+++ b/hw/net/e1000x_common.c
@@ -140,16 +140,16 @@ bool e1000x_hw_rx_enabled(uint32_t *mac)
 
 bool e1000x_is_oversized(uint32_t *mac, size_t size)
 {
+    size_t header_size = sizeof(struct eth_header) + sizeof(struct vlan_header);
     /* this is the size past which hardware will
        drop packets when setting LPE=0 */
-    static const int maximum_ethernet_vlan_size = 1522;
+    size_t maximum_short_size = header_size + ETH_MTU;
     /* this is the size past which hardware will
        drop packets when setting LPE=1 */
-    static const int maximum_ethernet_lpe_size = 16 * KiB;
+    size_t maximum_large_size = 16 * KiB - ETH_FCS_LEN;
 
-    if ((size > maximum_ethernet_lpe_size ||
-        (size > maximum_ethernet_vlan_size
-            && !(mac[RCTL] & E1000_RCTL_LPE)))
+    if ((size > maximum_large_size ||
+        (size > maximum_short_size && !(mac[RCTL] & E1000_RCTL_LPE)))
         && !(mac[RCTL] & E1000_RCTL_SBP)) {
         e1000x_inc_reg_if_not_full(mac, ROC);
         trace_e1000x_rx_oversized(size);
diff --git a/include/net/eth.h b/include/net/eth.h
index e8af574..05f5693 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -32,6 +32,8 @@
 #define ETH_ALEN 6
 #define ETH_HLEN 14
 #define ETH_ZLEN 60     /* Min. octets in frame without FCS */
+#define ETH_FCS_LEN 4
+#define ETH_MTU 1500
 
 struct eth_header {
     uint8_t  h_dest[ETH_ALEN];   /* destination eth addr */
-- 
2.7.4


