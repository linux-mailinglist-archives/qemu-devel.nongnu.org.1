Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFEF70D188
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:45:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I0P-000363-AG; Mon, 22 May 2023 22:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0N-00035n-8V
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:07 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0L-00044x-CZ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:06 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-255401f977dso1785912a91.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809844; x=1687401844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/n522ncAuLzULNyLnTDNT8SkaHFBZ7ZayT40+gnvRY0=;
 b=Ydw3+J/F8sdcVJDdqexHy2srzXdO2V+9zE1gz2mzb4dZece8lK5J55TCYd6hnO7bpM
 dVzkdpyhUqHB8Ya2Nr+JWdYHA4WxPKvKAQ8myydPfYQQYkQoN/RF9McwSk3+5eUcGjwm
 /UBLe92+LqgKBNvOMy6F3v2CGCPu8tSRu6nqCEK2qO5TDKkQw8ANd9jSKe3YJwuex92r
 z4QjXo38mQqpPvJW5mTVTOxtWpxknvRXnsfhP+cjZIiEmDS3FP/9r+pWnQpt0n2xtYjW
 MpO0zZVXxEfpg4fzMrnD+ApLDXxUTyg3xIJ1eoqlmIXgrWJhCcSGbjVqwHOZiwvvmmP+
 Ndog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809844; x=1687401844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/n522ncAuLzULNyLnTDNT8SkaHFBZ7ZayT40+gnvRY0=;
 b=iGgk0IL0VAV6hIvlLyYCqTG45x+pYWGfQpAxMJKEdbRJcSZrd/7jureqPAqoknEw5c
 VQvr4c1icHA8iA+M/gRj8R/KDxwQ6XF+LanfoO+v6traRo6U/w9fyp7Viypb1gp4dOsc
 4jPAS8LR40aoHHhqUjdxTR/2SaoApNO58v16RC3rGw2+e8zDTwKJRsXlFFx6lDQs/xyQ
 1xKeFiWRNiwE2CMQNqMMFsXaSIe2ouKeid2ve6Ab8S+sV8YYk9pX59JF6TlOMuUrrXnc
 fpTlL55eqr5pa4yRQa5HTLNcwho5ZKDQl5nH8ND4UXul980keMux4kMhLFGol3VuPvIV
 7nBQ==
X-Gm-Message-State: AC+VfDzEFfNh2ZeIazRxUNbSRiJZFdsQT81HYZjW2Z2vHkKy9YjsMIqH
 6ICGrvUCAGzNTDRW9bJpZuhenA==
X-Google-Smtp-Source: ACHHUZ4JXHOFIJhHUso2FHJTzfcMWdeFFfvKLyFisWLn6j36RvZ93Ine+B8Df9Nk7mtvNjTJcunpjA==
X-Received: by 2002:a17:90b:23c1:b0:247:3548:e470 with SMTP id
 md1-20020a17090b23c100b002473548e470mr11337779pjb.29.1684809844041; 
 Mon, 22 May 2023 19:44:04 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:03 -0700 (PDT)
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
Subject: [PATCH v5 03/48] e1000x: Fix BPRC and MPRC
Date: Tue, 23 May 2023 11:42:54 +0900
Message-Id: <20230523024339.50875-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102e.google.com
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

Before this change, e1000 and the common code updated BPRC and MPRC
depending on the matched filter, but e1000e and igb decided to update
those counters by deriving the packet type independently. This
inconsistency caused a multicast packet to be counted twice.

Updating BPRC and MPRC depending on are fundamentally flawed anyway as
a filter can be used for different types of packets. For example, it is
possible to filter broadcast packets with MTA.

Always determine what counters to update by inspecting the packets.

Fixes: 3b27430177 ("e1000: Implementing various counters")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/e1000x_common.h |  5 +++--
 hw/net/e1000.c         |  6 +++---
 hw/net/e1000e_core.c   | 20 +++-----------------
 hw/net/e1000x_common.c | 25 +++++++++++++++++++------
 hw/net/igb_core.c      | 22 +++++-----------------
 5 files changed, 33 insertions(+), 45 deletions(-)

diff --git a/hw/net/e1000x_common.h b/hw/net/e1000x_common.h
index 911abd8a90..0298e06283 100644
--- a/hw/net/e1000x_common.h
+++ b/hw/net/e1000x_common.h
@@ -91,8 +91,9 @@ e1000x_update_regs_on_link_up(uint32_t *mac, uint16_t *phy)
 }
 
 void e1000x_update_rx_total_stats(uint32_t *mac,
-                                  size_t data_size,
-                                  size_t data_fcs_size);
+                                  eth_pkt_types_e pkt_type,
+                                  size_t pkt_size,
+                                  size_t pkt_fcs_size);
 
 void e1000x_core_prepare_eeprom(uint16_t       *eeprom,
                                 const uint16_t *templ,
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 59bacb5d3b..18eb6d8876 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -826,12 +826,10 @@ receive_filter(E1000State *s, const uint8_t *buf, int size)
     }
 
     if (ismcast && (rctl & E1000_RCTL_MPE)) {          /* promiscuous mcast */
-        e1000x_inc_reg_if_not_full(s->mac_reg, MPRC);
         return 1;
     }
 
     if (isbcast && (rctl & E1000_RCTL_BAM)) {          /* broadcast enabled */
-        e1000x_inc_reg_if_not_full(s->mac_reg, BPRC);
         return 1;
     }
 
@@ -922,6 +920,7 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
     size_t desc_offset;
     size_t desc_size;
     size_t total_size;
+    eth_pkt_types_e pkt_type;
 
     if (!e1000x_hw_rx_enabled(s->mac_reg)) {
         return -1;
@@ -971,6 +970,7 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
         size -= 4;
     }
 
+    pkt_type = get_eth_packet_type(PKT_GET_ETH_HDR(filter_buf));
     rdh_start = s->mac_reg[RDH];
     desc_offset = 0;
     total_size = size + e1000x_fcs_len(s->mac_reg);
@@ -1036,7 +1036,7 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
         }
     } while (desc_offset < total_size);
 
-    e1000x_update_rx_total_stats(s->mac_reg, size, total_size);
+    e1000x_update_rx_total_stats(s->mac_reg, pkt_type, size, total_size);
 
     n = E1000_ICS_RXT0;
     if ((rdt = s->mac_reg[RDT]) < s->mac_reg[RDH])
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 15821a75e0..c2d864a504 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1488,24 +1488,10 @@ e1000e_write_to_rx_buffers(E1000ECore *core,
 }
 
 static void
-e1000e_update_rx_stats(E1000ECore *core,
-                       size_t data_size,
-                       size_t data_fcs_size)
+e1000e_update_rx_stats(E1000ECore *core, size_t pkt_size, size_t pkt_fcs_size)
 {
-    e1000x_update_rx_total_stats(core->mac, data_size, data_fcs_size);
-
-    switch (net_rx_pkt_get_packet_type(core->rx_pkt)) {
-    case ETH_PKT_BCAST:
-        e1000x_inc_reg_if_not_full(core->mac, BPRC);
-        break;
-
-    case ETH_PKT_MCAST:
-        e1000x_inc_reg_if_not_full(core->mac, MPRC);
-        break;
-
-    default:
-        break;
-    }
+    eth_pkt_types_e pkt_type = net_rx_pkt_get_packet_type(core->rx_pkt);
+    e1000x_update_rx_total_stats(core->mac, pkt_type, pkt_size, pkt_fcs_size);
 }
 
 static inline bool
diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
index 4c8e7dcf70..7694673bcc 100644
--- a/hw/net/e1000x_common.c
+++ b/hw/net/e1000x_common.c
@@ -80,7 +80,6 @@ bool e1000x_rx_group_filter(uint32_t *mac, const uint8_t *buf)
     f = mta_shift[(rctl >> E1000_RCTL_MO_SHIFT) & 3];
     f = (((buf[5] << 8) | buf[4]) >> f) & 0xfff;
     if (mac[MTA + (f >> 5)] & (1 << (f & 0x1f))) {
-        e1000x_inc_reg_if_not_full(mac, MPRC);
         return true;
     }
 
@@ -212,13 +211,14 @@ e1000x_rxbufsize(uint32_t rctl)
 
 void
 e1000x_update_rx_total_stats(uint32_t *mac,
-                             size_t data_size,
-                             size_t data_fcs_size)
+                             eth_pkt_types_e pkt_type,
+                             size_t pkt_size,
+                             size_t pkt_fcs_size)
 {
     static const int PRCregs[6] = { PRC64, PRC127, PRC255, PRC511,
                                     PRC1023, PRC1522 };
 
-    e1000x_increase_size_stats(mac, PRCregs, data_fcs_size);
+    e1000x_increase_size_stats(mac, PRCregs, pkt_fcs_size);
     e1000x_inc_reg_if_not_full(mac, TPR);
     e1000x_inc_reg_if_not_full(mac, GPRC);
     /* TOR - Total Octets Received:
@@ -226,8 +226,21 @@ e1000x_update_rx_total_stats(uint32_t *mac,
     * Address> field through the <CRC> field, inclusively.
     * Always include FCS length (4) in size.
     */
-    e1000x_grow_8reg_if_not_full(mac, TORL, data_size + 4);
-    e1000x_grow_8reg_if_not_full(mac, GORCL, data_size + 4);
+    e1000x_grow_8reg_if_not_full(mac, TORL, pkt_size + 4);
+    e1000x_grow_8reg_if_not_full(mac, GORCL, pkt_size + 4);
+
+    switch (pkt_type) {
+    case ETH_PKT_BCAST:
+        e1000x_inc_reg_if_not_full(mac, BPRC);
+        break;
+
+    case ETH_PKT_MCAST:
+        e1000x_inc_reg_if_not_full(mac, MPRC);
+        break;
+
+    default:
+        break;
+    }
 }
 
 void
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index abfdce9aaf..464a41d0aa 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1438,29 +1438,17 @@ igb_write_to_rx_buffers(IGBCore *core,
 
 static void
 igb_update_rx_stats(IGBCore *core, const E1000E_RingInfo *rxi,
-                    size_t data_size, size_t data_fcs_size)
+                    size_t pkt_size, size_t pkt_fcs_size)
 {
-    e1000x_update_rx_total_stats(core->mac, data_size, data_fcs_size);
-
-    switch (net_rx_pkt_get_packet_type(core->rx_pkt)) {
-    case ETH_PKT_BCAST:
-        e1000x_inc_reg_if_not_full(core->mac, BPRC);
-        break;
-
-    case ETH_PKT_MCAST:
-        e1000x_inc_reg_if_not_full(core->mac, MPRC);
-        break;
-
-    default:
-        break;
-    }
+    eth_pkt_types_e pkt_type = net_rx_pkt_get_packet_type(core->rx_pkt);
+    e1000x_update_rx_total_stats(core->mac, pkt_type, pkt_size, pkt_fcs_size);
 
     if (core->mac[MRQC] & 1) {
         uint16_t pool = rxi->idx % IGB_NUM_VM_POOLS;
 
-        core->mac[PVFGORC0 + (pool * 64)] += data_size + 4;
+        core->mac[PVFGORC0 + (pool * 64)] += pkt_size + 4;
         core->mac[PVFGPRC0 + (pool * 64)]++;
-        if (net_rx_pkt_get_packet_type(core->rx_pkt) == ETH_PKT_MCAST) {
+        if (pkt_type == ETH_PKT_MCAST) {
             core->mac[PVFMPRC0 + (pool * 64)]++;
         }
     }
-- 
2.40.1


