Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C3270D193
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:46:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I2J-0000dI-DP; Mon, 22 May 2023 22:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2H-0000Pt-7G
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:05 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2F-0004h6-1t
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:04 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so6066824a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809962; x=1687401962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FmSXIaFJ24Yo50lPekEX5U84TFnbc1w+oUwNf6HX4PM=;
 b=nTJups1GaaXxZEQeUkIpWZgqO0TAssBrSIizPDacwJiHdHe+vJAEBC+JiGrJFBTMrn
 EyVDxvJ4ZW7lX1grCDT4+0khD07Sn3H+qzWQTPeJhXpORknDmjx8ds1Ys19a8TGujBlk
 mDp1zmRpdfFOth8zUZfV+XnlVWDqoKNR60ya280mgY7c8Qk7ThRMFNWCPutlzXtvGmRA
 kI+GFT+xtQ8q+jnVCnWMXlieRaZRdM62YefnqSDZ9kmMgspAJ8HWWx/JVhv9CWHT8APq
 0mbLx9ll2e6Q9a0XTk5fRCIZy+mwQD8NAakNwkW+HNwGoaQQs1JU0wfM78WP5ARo+3oV
 qjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809962; x=1687401962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FmSXIaFJ24Yo50lPekEX5U84TFnbc1w+oUwNf6HX4PM=;
 b=a9BWaPEhftkRGfBj7caRGArZPEcBo8QxSNnpoZpz9pe8lNouilBhFGaqylvKYFP49P
 g/HNJD/gYD601RE7C+amM2D4kXXPgfbZ3JuV/qgu230xFD7AbYCBYKEDWiHqqxhV30/7
 kuqaUX5vhf8US/frypUHMKOEF+xsiy7TJtfni/4tIw2bz/wWhF9/ORKwpte49J3wXT8d
 XzLB5l8593YEgFoEEoUpyE8oXePJYkq3b8HCpTac+yEye1p27FKijfgr1Ed2l9ZCz2ep
 Jx/7OpWUHLljIkfetC3uUpcS20ddFb6uZntaHnTCqWGXtDSz6zrl3AzNS49OHyQyEafy
 Iyuw==
X-Gm-Message-State: AC+VfDy6uAj0JsRswAvHzd0NE+84ypG4nR61ldWOGsrALUjQvLfjwCBN
 ZOOBSZa9AEGQ5YDjrLIlSz57JQ==
X-Google-Smtp-Source: ACHHUZ7um+OyOE6P2BZu9E+npsn7elF7hLCIXw4AvCmJQJFXZ783i0zEEIEBH+YwSYHpEHLp2tcjzQ==
X-Received: by 2002:a17:90b:180f:b0:255:5d65:3a86 with SMTP id
 lw15-20020a17090b180f00b002555d653a86mr6022022pjb.8.1684809961750; 
 Mon, 22 May 2023 19:46:01 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:46:01 -0700 (PDT)
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
Subject: [PATCH v5 38/48] igb: Strip the second VLAN tag for extended VLAN
Date: Tue, 23 May 2023 11:43:29 +0900
Message-Id: <20230523024339.50875-39-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
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
---
 hw/net/net_rx_pkt.h  | 19 ++++++++--------
 include/net/eth.h    |  4 ++--
 hw/net/e1000e_core.c |  3 ++-
 hw/net/igb_core.c    | 14 ++++++++++--
 hw/net/net_rx_pkt.c  | 15 +++++--------
 net/eth.c            | 52 ++++++++++++++++++++++++++++----------------
 6 files changed, 65 insertions(+), 42 deletions(-)

diff --git a/hw/net/net_rx_pkt.h b/hw/net/net_rx_pkt.h
index ce8dbdb284..55ec67a1a7 100644
--- a/hw/net/net_rx_pkt.h
+++ b/hw/net/net_rx_pkt.h
@@ -223,18 +223,19 @@ void net_rx_pkt_attach_iovec(struct NetRxPkt *pkt,
 /**
 * attach scatter-gather data to rx packet
 *
-* @pkt:            packet
-* @iov:            received data scatter-gather list
-* @iovcnt          number of elements in iov
-* @iovoff          data start offset in the iov
-* @strip_vlan:     should the module strip vlan from data
-* @vet:            VLAN tag Ethernet type
+* @pkt:              packet
+* @iov:              received data scatter-gather list
+* @iovcnt:           number of elements in iov
+* @iovoff:           data start offset in the iov
+* @strip_vlan_index: index of Q tag if it is to be stripped. negative otherwise.
+* @vet:              VLAN tag Ethernet type
+* @vet_ext:          outer VLAN tag Ethernet type
 *
 */
 void net_rx_pkt_attach_iovec_ex(struct NetRxPkt *pkt,
-                                   const struct iovec *iov, int iovcnt,
-                                   size_t iovoff, bool strip_vlan,
-                                   uint16_t vet);
+                                const struct iovec *iov, int iovcnt,
+                                size_t iovoff, int strip_vlan_index,
+                                uint16_t vet, uint16_t vet_ext);
 
 /**
  * attach data to rx packet
diff --git a/include/net/eth.h b/include/net/eth.h
index 75e7f1551c..3b80b6e07f 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -347,8 +347,8 @@ eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
                uint16_t *payload_offset, uint16_t *tci);
 
 size_t
-eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
-                  uint16_t vet, void *new_ehdr_buf,
+eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff, int index,
+                  uint16_t vet, uint16_t vet_ext, void *new_ehdr_buf,
                   uint16_t *payload_offset, uint16_t *tci);
 
 uint16_t
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 0b939ff5a3..d601386992 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1711,7 +1711,8 @@ e1000e_receive_internal(E1000ECore *core, const struct iovec *iov, int iovcnt,
     }
 
     net_rx_pkt_attach_iovec_ex(core->rx_pkt, iov, iovcnt, iov_ofs,
-                               e1000x_vlan_enabled(core->mac), core->mac[VET]);
+                               e1000x_vlan_enabled(core->mac) ? 0 : -1,
+                               core->mac[VET], 0);
 
     e1000e_rss_parse_packet(core, core->rx_pkt, &rss_info);
     e1000e_rx_ring_init(core, &rxr, rss_info.queue);
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 5eacf1cd8c..688eaf7319 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1611,6 +1611,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
     E1000E_RxRing rxr;
     E1000E_RSSInfo rss_info;
     size_t total_size;
+    int strip_vlan_index;
     int i;
 
     trace_e1000e_rx_receive_iov(iovcnt);
@@ -1672,9 +1673,18 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
 
         igb_rx_ring_init(core, &rxr, i);
 
+        if (!igb_rx_strip_vlan(core, rxr.i)) {
+            strip_vlan_index = -1;
+        } else if (core->mac[CTRL_EXT] & BIT(26)) {
+            strip_vlan_index = 1;
+        } else {
+            strip_vlan_index = 0;
+        }
+
         net_rx_pkt_attach_iovec_ex(core->rx_pkt, iov, iovcnt, iov_ofs,
-                                   igb_rx_strip_vlan(core, rxr.i),
-                                   core->mac[VET] & 0xffff);
+                                   strip_vlan_index,
+                                   core->mac[VET] & 0xffff,
+                                   core->mac[VET] >> 16);
 
         total_size = net_rx_pkt_get_total_len(core->rx_pkt) +
             e1000x_fcs_len(core->mac);
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 3575c8b9f9..32e5f3f9cf 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -137,20 +137,17 @@ void net_rx_pkt_attach_iovec(struct NetRxPkt *pkt,
 
 void net_rx_pkt_attach_iovec_ex(struct NetRxPkt *pkt,
                                 const struct iovec *iov, int iovcnt,
-                                size_t iovoff, bool strip_vlan,
-                                uint16_t vet)
+                                size_t iovoff, int strip_vlan_index,
+                                uint16_t vet, uint16_t vet_ext)
 {
     uint16_t tci = 0;
     uint16_t ploff = iovoff;
     assert(pkt);
 
-    if (strip_vlan) {
-        pkt->ehdr_buf_len = eth_strip_vlan_ex(iov, iovcnt, iovoff, vet,
-                                              &pkt->ehdr_buf,
-                                              &ploff, &tci);
-    } else {
-        pkt->ehdr_buf_len = 0;
-    }
+    pkt->ehdr_buf_len = eth_strip_vlan_ex(iov, iovcnt, iovoff,
+                                          strip_vlan_index, vet, vet_ext,
+                                          &pkt->ehdr_buf,
+                                          &ploff, &tci);
 
     pkt->tci = tci;
 
diff --git a/net/eth.c b/net/eth.c
index 7f02aea010..649e66bb1f 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -269,36 +269,50 @@ eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
 }
 
 size_t
-eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
-                  uint16_t vet, void *new_ehdr_buf,
+eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff, int index,
+                  uint16_t vet, uint16_t vet_ext, void *new_ehdr_buf,
                   uint16_t *payload_offset, uint16_t *tci)
 {
     struct vlan_header vlan_hdr;
-    struct eth_header *new_ehdr = (struct eth_header *) new_ehdr_buf;
-
-    size_t copied = iov_to_buf(iov, iovcnt, iovoff,
-                               new_ehdr, sizeof(*new_ehdr));
-
-    if (copied < sizeof(*new_ehdr)) {
-        return 0;
-    }
+    uint16_t *new_ehdr_proto;
+    size_t new_ehdr_size;
+    size_t copied;
 
-    if (be16_to_cpu(new_ehdr->h_proto) == vet) {
-        copied = iov_to_buf(iov, iovcnt, iovoff + sizeof(*new_ehdr),
-                            &vlan_hdr, sizeof(vlan_hdr));
+    switch (index) {
+    case 0:
+        new_ehdr_proto = &PKT_GET_ETH_HDR(new_ehdr_buf)->h_proto;
+        new_ehdr_size = sizeof(struct eth_header);
+        copied = iov_to_buf(iov, iovcnt, iovoff, new_ehdr_buf, new_ehdr_size);
+        break;
 
-        if (copied < sizeof(vlan_hdr)) {
+    case 1:
+        new_ehdr_proto = &PKT_GET_VLAN_HDR(new_ehdr_buf)->h_proto;
+        new_ehdr_size = sizeof(struct eth_header) + sizeof(struct vlan_header);
+        copied = iov_to_buf(iov, iovcnt, iovoff, new_ehdr_buf, new_ehdr_size);
+        if (be16_to_cpu(PKT_GET_ETH_HDR(new_ehdr_buf)->h_proto) != vet_ext) {
             return 0;
         }
+        break;
 
-        new_ehdr->h_proto = vlan_hdr.h_proto;
+    default:
+        return 0;
+    }
 
-        *tci = be16_to_cpu(vlan_hdr.h_tci);
-        *payload_offset = iovoff + sizeof(*new_ehdr) + sizeof(vlan_hdr);
-        return sizeof(struct eth_header);
+    if (copied < new_ehdr_size || be16_to_cpu(*new_ehdr_proto) != vet) {
+        return 0;
+    }
+
+    copied = iov_to_buf(iov, iovcnt, iovoff + new_ehdr_size,
+                        &vlan_hdr, sizeof(vlan_hdr));
+    if (copied < sizeof(vlan_hdr)) {
+        return 0;
     }
 
-    return 0;
+    *new_ehdr_proto = vlan_hdr.h_proto;
+    *payload_offset = iovoff + new_ehdr_size + sizeof(vlan_hdr);
+    *tci = be16_to_cpu(vlan_hdr.h_tci);
+
+    return new_ehdr_size;
 }
 
 void
-- 
2.40.1


