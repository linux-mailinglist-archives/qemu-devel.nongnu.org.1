Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 326B070D19C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:47:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I2M-0000zu-F6; Mon, 22 May 2023 22:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2J-0000nN-Lu
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:07 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2C-0004gh-La
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:07 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-253520adb30so4132393a91.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809958; x=1687401958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdfIsUMpSoaKQYSoeQ7UeQ/0Z3tWW4MKA7oDVXSunB0=;
 b=z+GfDDUkB3WxCyaxOotVo4BfWbiAv4TgAwqFHY3SIe0Izq/PCQk/BTkzyQl48nh9Vg
 3LX0i861Ajm30JP0pLT+txJJ6v0bFn9YULrsJ3kFSgxgtz/bwlTcjGrlVJM0gKFq3wbu
 ZKnTtmhrigFXIZZ4h+YAOX/ZcJdOu5qpreEyU/PYnGqCedE6yR1t8eWoK6m5PVeDCWek
 ffpsKAHR0ALPCYn5XxXILpNDUeqZLd1aHiXhAjFdA7tUtWvUuHjTVA5pQVi2848efSfz
 H2YXm8wvJypQkAOcv24lI5T20PnK5yVMEDOuBK+exykrMPyPmmnwMzo22LhoeareL+w8
 oLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809958; x=1687401958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BdfIsUMpSoaKQYSoeQ7UeQ/0Z3tWW4MKA7oDVXSunB0=;
 b=V5dGdAWK1EBhlGdTwXKO55aTfGHD9QUdSBssgByFWAii0aRt3kXkZBNzmxTd6tiM3p
 C73M0R8Ze0sZ6TduEvG2U+xhq5xZEjklZPogjNB8Vj32LIJ2ctSnNExrZ07TbJ8p2jls
 pApgRgJZ3GQAZN+EGLevSGvSDYjrm5TeOUXz58j3KpDAJmKgFHQNlVLjQ/js4cyIrY3j
 fPEQZCRFrzt8AoyqTmCD9vliWwSx0bAumR8QfTs/oLJ8UBp5lmQChZ9rAtvcaysp0kF0
 SxJ2T+sjGo0BimfxhzhJ1RdDZFTHZz1RrpQceJF2aC5OeSUfJ21EXI5rgyfIk5uNq3Ns
 LcXQ==
X-Gm-Message-State: AC+VfDyyGIDiL5GTa0C2Pskk20J/zuijrvphTZ37bbINlukjrTfBYrsk
 4fS+p7fWH7WtChbXLOEbWIQjqg==
X-Google-Smtp-Source: ACHHUZ6KzoHgK8trWgIfOiEv5GfJrgdGW9dB4Sh7MK/TUCJBEGA5fIPNNd3HTF72HLBpYn4v7/X71Q==
X-Received: by 2002:a17:90a:b012:b0:250:2ad4:b459 with SMTP id
 x18-20020a17090ab01200b002502ad4b459mr11893676pjq.39.1684809958416; 
 Mon, 22 May 2023 19:45:58 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 37/48] igb: Implement Tx SCTP CSO
Date: Tue, 23 May 2023 11:43:28 +0900
Message-Id: <20230523024339.50875-38-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/net_tx_pkt.h |  8 ++++++++
 hw/net/igb_core.c   | 12 +++++++-----
 hw/net/net_tx_pkt.c | 18 ++++++++++++++++++
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
index 4d7233e975..0a716e74a5 100644
--- a/hw/net/net_tx_pkt.h
+++ b/hw/net/net_tx_pkt.h
@@ -116,6 +116,14 @@ void net_tx_pkt_update_ip_checksums(struct NetTxPkt *pkt);
  */
 void net_tx_pkt_update_ip_hdr_checksum(struct NetTxPkt *pkt);
 
+/**
+ * Calculate the SCTP checksum.
+ *
+ * @pkt:            packet
+ *
+ */
+bool net_tx_pkt_update_sctp_checksum(struct NetTxPkt *pkt);
+
 /**
  * get length of all populated data.
  *
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 95d46d6e6d..5eacf1cd8c 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -440,8 +440,9 @@ igb_tx_insert_vlan(IGBCore *core, uint16_t qn, struct igb_tx *tx,
 static bool
 igb_setup_tx_offloads(IGBCore *core, struct igb_tx *tx)
 {
+    uint32_t idx = (tx->first_olinfo_status >> 4) & 1;
+
     if (tx->first_cmd_type_len & E1000_ADVTXD_DCMD_TSE) {
-        uint32_t idx = (tx->first_olinfo_status >> 4) & 1;
         uint32_t mss = tx->ctx[idx].mss_l4len_idx >> E1000_ADVTXD_MSS_SHIFT;
         if (!net_tx_pkt_build_vheader(tx->tx_pkt, true, true, mss)) {
             return false;
@@ -452,10 +453,11 @@ igb_setup_tx_offloads(IGBCore *core, struct igb_tx *tx)
         return true;
     }
 
-    if (tx->first_olinfo_status & E1000_ADVTXD_POTS_TXSM) {
-        if (!net_tx_pkt_build_vheader(tx->tx_pkt, false, true, 0)) {
-            return false;
-        }
+    if ((tx->first_olinfo_status & E1000_ADVTXD_POTS_TXSM) &&
+        !((tx->ctx[idx].type_tucmd_mlhl & E1000_ADVTXD_TUCMD_L4T_SCTP) ?
+          net_tx_pkt_update_sctp_checksum(tx->tx_pkt) :
+          net_tx_pkt_build_vheader(tx->tx_pkt, false, true, 0))) {
+        return false;
     }
 
     if (tx->first_olinfo_status & E1000_ADVTXD_POTS_IXSM) {
diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index af8f77a3f0..2e5f58b3c9 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/crc32c.h"
 #include "net/eth.h"
 #include "net/checksum.h"
 #include "net/tap.h"
@@ -135,6 +136,23 @@ void net_tx_pkt_update_ip_checksums(struct NetTxPkt *pkt)
                  pkt->virt_hdr.csum_offset, &csum, sizeof(csum));
 }
 
+bool net_tx_pkt_update_sctp_checksum(struct NetTxPkt *pkt)
+{
+    uint32_t csum = 0;
+    struct iovec *pl_start_frag = pkt->vec + NET_TX_PKT_PL_START_FRAG;
+
+    if (iov_from_buf(pl_start_frag, pkt->payload_frags, 8, &csum, sizeof(csum)) < sizeof(csum)) {
+        return false;
+    }
+
+    csum = cpu_to_le32(iov_crc32c(0xffffffff, pl_start_frag, pkt->payload_frags));
+    if (iov_from_buf(pl_start_frag, pkt->payload_frags, 8, &csum, sizeof(csum)) < sizeof(csum)) {
+        return false;
+    }
+
+    return true;
+}
+
 static void net_tx_pkt_calculate_hdr_len(struct NetTxPkt *pkt)
 {
     pkt->hdr_len = pkt->vec[NET_TX_PKT_L2HDR_FRAG].iov_len +
-- 
2.40.1


