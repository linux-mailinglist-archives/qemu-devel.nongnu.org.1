Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8CE70D1BB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:49:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I0m-0003Df-U1; Mon, 22 May 2023 22:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0h-0003DH-0R
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:27 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0f-00047h-Dc
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:26 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2533a03388dso4624229a91.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809864; x=1687401864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/ljXeplOjVMDMpVsQpgiVTsGYssFMg5Ie0JSRz6qGk=;
 b=b483PDaFF+Fr9PnSSU3xUVZ5hOQN3Kx+OBLpV6XZ/H0PeJkSUSWjNnECeYcnh80qcX
 nLHR8ybsJoHOeuW6f29z/Db2yMrx5NN+GLsEjN6SpUDkVX26x4XBYF4D9G/LvOU7WToD
 qxk5AxUJOaMYUXuu5T0wFvROXvbJuau3M23NdEvCKtsYfsMDim7qfdn5xJNRWpX+d4nF
 4JO4HIF6C/CR/l6Ebc0qYqboc6Je7FBQ/hvavtPJJOYo3G+yMW+/iMhWUfq754oT+it0
 FjAaykXqhz8DUISSOk8LCdhw3dTRtkoTVvN+dbOPWsunFit83xHMauOgeeJb4JHxoY03
 4XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809864; x=1687401864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q/ljXeplOjVMDMpVsQpgiVTsGYssFMg5Ie0JSRz6qGk=;
 b=cwN2l7Y+RuPg1sWiL+zeKlqZSNxWB05zbRSYyoll+qzsKvoanUcjLH8I/ORGQycp2n
 iwIJtiTbhGOAlI+1MjAYgfORDSOitsaJdlu/B8KmdfG1lli1GvBmQ5re2LqoNNBHFr+V
 gqY9Md5YwdaianXTpHxA3t7BBOgZ5TWGLrAHIwRUmmDkEATDMQ2BA/O7EEAFnHvQDFlD
 71WRHygWhwm/kRBK0DBsHOkHuVMkkRoHwm48vsm2Tjq6A84ux70WSQTcZxOPT7US+V15
 nTAUtmmc8L8j83HUlytPclaE+C9rpiWK8uli2hLifuDnUjtcfvKThhUpF121TGDnXDww
 G6mg==
X-Gm-Message-State: AC+VfDyB62mu9lbQaZWHdTisi7EEnHApMf4i0O90nLrwNK6NzDzD9TXa
 SRZLWAGMItwb3V9aBtNID7GV3g==
X-Google-Smtp-Source: ACHHUZ4302CUYoYGjY9soxssO2TYFkEO9HJ6/PbOxVLsB12aCPtE/p8t29c423jmZtuerVpHPf24HA==
X-Received: by 2002:a17:90a:ea04:b0:24c:df8:8efa with SMTP id
 w4-20020a17090aea0400b0024c0df88efamr12030932pjy.39.1684809864307; 
 Mon, 22 May 2023 19:44:24 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:24 -0700 (PDT)
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
Subject: [PATCH v5 09/48] igb: Always copy ethernet header
Date: Tue, 23 May 2023 11:43:00 +0900
Message-Id: <20230523024339.50875-10-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1032.google.com
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

igb_receive_internal() used to check the iov length to determine
copy the iovs to a contiguous buffer, but the check is flawed in two
ways:
- It does not ensure that iovcnt > 0.
- It does not take virtio-net header into consideration.

The size of this copy is just 22 octets, which can be even less than
the code size required for checks. This (wrong) optimization is probably
not worth so just remove it. Removing this also allows igb to assume
aligned accesses for the ethernet header.

Fixes: 3a977deebe ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/igb_core.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 21a8d9ada4..1123df9e77 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -67,6 +67,11 @@ typedef struct IGBTxPktVmdqCallbackContext {
     NetClientState *nc;
 } IGBTxPktVmdqCallbackContext;
 
+typedef struct L2Header {
+    struct eth_header eth;
+    struct vlan_header vlan;
+} L2Header;
+
 static ssize_t
 igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
                      bool has_vnet, bool *external_tx);
@@ -961,15 +966,16 @@ igb_rx_is_oversized(IGBCore *core, uint16_t qn, size_t size)
     return size > (lpe ? max_ethernet_lpe_size : max_ethernet_vlan_size);
 }
 
-static uint16_t igb_receive_assign(IGBCore *core, const struct eth_header *ehdr,
+static uint16_t igb_receive_assign(IGBCore *core, const L2Header *l2_header,
                                    size_t size, E1000E_RSSInfo *rss_info,
                                    bool *external_tx)
 {
     static const int ta_shift[] = { 4, 3, 2, 0 };
+    const struct eth_header *ehdr = &l2_header->eth;
     uint32_t f, ra[2], *macp, rctl = core->mac[RCTL];
     uint16_t queues = 0;
     uint16_t oversized = 0;
-    uint16_t vid = lduw_be_p(&PKT_GET_VLAN_HDR(ehdr)->h_tci) & VLAN_VID_MASK;
+    uint16_t vid = be16_to_cpu(l2_header->vlan.h_tci) & VLAN_VID_MASK;
     bool accepted = false;
     int i;
 
@@ -1590,14 +1596,13 @@ static ssize_t
 igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
                      bool has_vnet, bool *external_tx)
 {
-    static const int maximum_ethernet_hdr_len = (ETH_HLEN + 4);
-
     uint16_t queues = 0;
     uint32_t n = 0;
-    uint8_t min_buf[ETH_ZLEN];
+    union {
+        L2Header l2_header;
+        uint8_t octets[ETH_ZLEN];
+    } buf;
     struct iovec min_iov;
-    struct eth_header *ehdr;
-    uint8_t *filter_buf;
     size_t size, orig_size;
     size_t iov_ofs = 0;
     E1000E_RxRing rxr;
@@ -1623,24 +1628,21 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
         net_rx_pkt_unset_vhdr(core->rx_pkt);
     }
 
-    filter_buf = iov->iov_base + iov_ofs;
     orig_size = iov_size(iov, iovcnt);
     size = orig_size - iov_ofs;
 
     /* Pad to minimum Ethernet frame length */
-    if (size < sizeof(min_buf)) {
-        iov_to_buf(iov, iovcnt, iov_ofs, min_buf, size);
-        memset(&min_buf[size], 0, sizeof(min_buf) - size);
+    if (size < sizeof(buf)) {
+        iov_to_buf(iov, iovcnt, iov_ofs, &buf, size);
+        memset(&buf.octets[size], 0, sizeof(buf) - size);
         e1000x_inc_reg_if_not_full(core->mac, RUC);
-        min_iov.iov_base = filter_buf = min_buf;
-        min_iov.iov_len = size = sizeof(min_buf);
+        min_iov.iov_base = &buf;
+        min_iov.iov_len = size = sizeof(buf);
         iovcnt = 1;
         iov = &min_iov;
         iov_ofs = 0;
-    } else if (iov->iov_len < maximum_ethernet_hdr_len) {
-        /* This is very unlikely, but may happen. */
-        iov_to_buf(iov, iovcnt, iov_ofs, min_buf, maximum_ethernet_hdr_len);
-        filter_buf = min_buf;
+    } else {
+        iov_to_buf(iov, iovcnt, iov_ofs, &buf, sizeof(buf.l2_header));
     }
 
     /* Discard oversized packets if !LPE and !SBP. */
@@ -1648,11 +1650,12 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
         return orig_size;
     }
 
-    ehdr = PKT_GET_ETH_HDR(filter_buf);
-    net_rx_pkt_set_packet_type(core->rx_pkt, get_eth_packet_type(ehdr));
+    net_rx_pkt_set_packet_type(core->rx_pkt,
+                               get_eth_packet_type(&buf.l2_header.eth));
     net_rx_pkt_set_protocols(core->rx_pkt, iov, iovcnt, iov_ofs);
 
-    queues = igb_receive_assign(core, ehdr, size, &rss_info, external_tx);
+    queues = igb_receive_assign(core, &buf.l2_header, size,
+                                &rss_info, external_tx);
     if (!queues) {
         trace_e1000e_rx_flt_dropped();
         return orig_size;
-- 
2.40.1


