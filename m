Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF870D1BF
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:49:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I2Q-0001jP-Uc; Mon, 22 May 2023 22:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2N-0001P9-M8
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:11 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2L-0004iG-P5
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:11 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-52c40be1417so2959845a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809968; x=1687401968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlwseQIq7Pe/ykDWpn+LcKkQsTfB+W+frpzEOLEN7FE=;
 b=GLCRKKYSkxpFfvd22QcW3kmIlLX0xYeyXM4VJS/nGx6n+xMJgjUX9+FnfnfnzT5uZB
 bfDwxc/vFyweQCu+ASkUmS0dV9KZ1rDE7p4vYrJzr/Cj7AjoGRi4JBMB6Vb9UuEcucaS
 vUw9kAYqgxq7cbBKMmrW5gQw3CLBb1a7paJkj4HCwdVowsLkzq28PANevMGMKyNFr8n6
 sLIKs9pbOjpYRWONNMQdB5FXb73eUl8CnqNtNx7kV2C7Uke84Tt03UvBrEFI5kzdYTrt
 q7YgLmTOPj58fjZkA0nx1LWyL2tSwJ/Luabotyd6stFS/F2K066lHzMvgGghB13bsuYK
 3rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809968; x=1687401968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OlwseQIq7Pe/ykDWpn+LcKkQsTfB+W+frpzEOLEN7FE=;
 b=ZrdCErswcl1sfMv/w7TK8W7cTSfurnUjWmCBVMPzx+NQHAou94EFB9kLCg+rTZcggB
 sUrFwcahJZF+wIhb2VWMNATPc9DV068GqlQzZUI6cZVsrrXUNqgw81/HGw2R5Ly78wYA
 5pAbFYmVttxhiMDTXFKxSOCzlcWjQ0QvDZJppKW00cfWMTSqONnJ4B/RUwjvGqSOziOp
 H2FAv4tO7X5K1JwXSD0Pj3R+w50Wn9RWdfaiHAIAJn+VxN+e64vbxuEgZTW7fqXidbTj
 C5Tl+xLg2GSVUx3CylMwmRg8sHLP4mO1DktOGhiP/r+veCtwLyhIEk1frLGq/67RHahK
 r5+Q==
X-Gm-Message-State: AC+VfDw1vQWpseLy18MXijxLUmmhurc+l968eE+CQ5DlAhEeZqq87sK+
 IekrxEeBGYCmFlIXnwsQYqq2Cg==
X-Google-Smtp-Source: ACHHUZ60tJ5o656Gh3bscZKQBj13PhaTclHE15L+qIYBObbuwYnbjH6y7UhsyWZ7TLow9cQKTQYqZA==
X-Received: by 2002:a17:90b:3e8d:b0:253:4b01:30d with SMTP id
 rj13-20020a17090b3e8d00b002534b01030dmr16839056pjb.11.1684809968407; 
 Mon, 22 May 2023 19:46:08 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:46:08 -0700 (PDT)
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
Subject: [PATCH v5 40/48] igb: Implement igb-specific oversize check
Date: Tue, 23 May 2023 11:43:31 +0900
Message-Id: <20230523024339.50875-41-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
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

igb has a configurable size limit for LPE, and uses different limits
depending on whether the packet is treated as a VLAN packet.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/igb_core.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 5345f57031..c04ec01117 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -980,16 +980,13 @@ igb_rx_l4_cso_enabled(IGBCore *core)
     return !!(core->mac[RXCSUM] & E1000_RXCSUM_TUOFLD);
 }
 
-static bool
-igb_rx_is_oversized(IGBCore *core, uint16_t qn, size_t size)
+static bool igb_rx_is_oversized(IGBCore *core, const struct eth_header *ehdr,
+                                size_t size, size_t vlan_num,
+                                bool lpe, uint16_t rlpml)
 {
-    uint16_t pool = qn % IGB_NUM_VM_POOLS;
-    bool lpe = !!(core->mac[VMOLR0 + pool] & E1000_VMOLR_LPE);
-    int max_ethernet_lpe_size =
-        core->mac[VMOLR0 + pool] & E1000_VMOLR_RLPML_MASK;
-    int max_ethernet_vlan_size = 1522;
-
-    return size > (lpe ? max_ethernet_lpe_size : max_ethernet_vlan_size);
+    size_t vlan_header_size = sizeof(struct vlan_header) * vlan_num;
+    size_t header_size = sizeof(struct eth_header) + vlan_header_size;
+    return lpe ? size + ETH_FCS_LEN > rlpml : size > header_size + ETH_MTU;
 }
 
 static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
@@ -1002,6 +999,8 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
     uint16_t queues = 0;
     uint16_t oversized = 0;
     size_t vlan_num = 0;
+    bool lpe;
+    uint16_t rlpml;
     int i;
 
     memset(rss_info, 0, sizeof(E1000E_RSSInfo));
@@ -1021,6 +1020,14 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
         }
     }
 
+    lpe = !!(core->mac[RCTL] & E1000_RCTL_LPE);
+    rlpml = core->mac[RLPML];
+    if (!(core->mac[RCTL] & E1000_RCTL_SBP) &&
+        igb_rx_is_oversized(core, ehdr, size, vlan_num, lpe, rlpml)) {
+        trace_e1000x_rx_oversized(size);
+        return queues;
+    }
+
     if (vlan_num &&
         !e1000x_rx_vlan_filter(core->mac, l2_header->vlan + vlan_num - 1)) {
         return queues;
@@ -1106,7 +1113,11 @@ static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
         queues &= core->mac[VFRE];
         if (queues) {
             for (i = 0; i < IGB_NUM_VM_POOLS; i++) {
-                if ((queues & BIT(i)) && igb_rx_is_oversized(core, i, size)) {
+                lpe = !!(core->mac[VMOLR0 + i] & E1000_VMOLR_LPE);
+                rlpml = core->mac[VMOLR0 + i] & E1000_VMOLR_RLPML_MASK;
+                if ((queues & BIT(i)) &&
+                    igb_rx_is_oversized(core, ehdr, size, vlan_num,
+                                        lpe, rlpml)) {
                     oversized |= BIT(i);
                 }
             }
@@ -1662,11 +1673,6 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
         iov_to_buf(iov, iovcnt, iov_ofs, &buf, sizeof(buf.l2_header));
     }
 
-    /* Discard oversized packets if !LPE and !SBP. */
-    if (e1000x_is_oversized(core->mac, size)) {
-        return orig_size;
-    }
-
     net_rx_pkt_set_packet_type(core->rx_pkt,
                                get_eth_packet_type(&buf.l2_header.eth));
     net_rx_pkt_set_protocols(core->rx_pkt, iov, iovcnt, iov_ofs);
-- 
2.40.1


