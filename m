Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B1470D52C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:35:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MYX-00059u-C5; Tue, 23 May 2023 03:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXs-0004VS-0C
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MXo-0004ST-Tb
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tx0GbOCznOuuOVpDx+j4kwLqokUzXGhDSbN/fwVoxQ4=;
 b=a7JEVDK9TPHyVl+fk4NQWK0GpULwy+SxUXSKlKd6duLxAQuqw4aO5ER4miuc8CuHXBfnmq
 85SBHEUZ59c/yXA42j8KTAb5Syed6ojFbFgQQNOCSbC1l7qMEm9FMn3dc9JIJKeagq4yqt
 FSERETMaCJTgoS+n9MsA4i+qQ/x6zHg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-tOcmzvaSMsCrHa8Vdec3ig-1; Tue, 23 May 2023 03:34:53 -0400
X-MC-Unique: tOcmzvaSMsCrHa8Vdec3ig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92FAB185A78F;
 Tue, 23 May 2023 07:34:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 652B02166B25;
 Tue, 23 May 2023 07:34:50 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 43/50] igb: Implement Tx timestamp
Date: Tue, 23 May 2023 15:32:31 +0800
Message-Id: <20230523073238.54236-44-jasowang@redhat.com>
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb_core.c | 7 +++++++
 hw/net/igb_regs.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 43d23c7..49d1917 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -659,6 +659,13 @@ igb_process_tx_desc(IGBCore *core,
                 tx->ctx[idx].vlan_macip_lens >> IGB_TX_FLAGS_VLAN_SHIFT,
                 !!(tx->first_cmd_type_len & E1000_TXD_CMD_VLE));
 
+            if ((tx->first_cmd_type_len & E1000_ADVTXD_MAC_TSTAMP) &&
+                (core->mac[TSYNCTXCTL] & E1000_TSYNCTXCTL_ENABLED) &&
+                !(core->mac[TSYNCTXCTL] & E1000_TSYNCTXCTL_VALID)) {
+                core->mac[TSYNCTXCTL] |= E1000_TSYNCTXCTL_VALID;
+                e1000x_timestamp(core->mac, core->timadj, TXSTMPL, TXSTMPH);
+            }
+
             if (igb_tx_pkt_send(core, tx, queue_index)) {
                 igb_on_tx_done_update_stats(core, tx->tx_pkt, queue_index);
             }
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 8947055..82ff195 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -322,6 +322,9 @@ union e1000_adv_rx_desc {
 /* E1000_EITR_CNT_IGNR is only for 82576 and newer */
 #define E1000_EITR_CNT_IGNR     0x80000000 /* Don't reset counters on write */
 
+#define E1000_TSYNCTXCTL_VALID    0x00000001 /* tx timestamp valid */
+#define E1000_TSYNCTXCTL_ENABLED  0x00000010 /* enable tx timestampping */
+
 /* PCI Express Control */
 #define E1000_GCR_CMPL_TMOUT_MASK       0x0000F000
 #define E1000_GCR_CMPL_TMOUT_10ms       0x00001000
-- 
2.7.4


