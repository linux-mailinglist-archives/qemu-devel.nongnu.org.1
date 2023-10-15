Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C1B7C9952
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:05:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1iB-0001Jl-OF; Sun, 15 Oct 2023 10:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1i8-0001IC-MW
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:16 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1i6-0007hd-Nc
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:16 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so23746955ad.2
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378592; x=1697983392;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9DyJgfsNaywwdF+X+Mlrm7UwaxUF7X0EYzGFK3vXhg=;
 b=hAr0KrNGvWS1A2LZ6e2qwZvfsUGK+iRoPZ8YHsiPTIYLridFcLRN4dA0zwCUjd7o61
 LVN2xwYMZqQ6dYwd8hw7HQeho8J6PSgHkkVELECxT/gTaPBEh6JCom56VZDNxaElRydn
 exsZbRST0n9mCL+s4bN+xX0pKEzMazalAKB8OXLC4RD9dyPxCT/NYP8eCkjMPKRPx032
 n1SdotVy5FuW1e974kxhadfaS8RcxtIy7OJcIwO48CErDYtYGCDVm2ZfFD3yau8B6SGu
 Km3sEAs24XS3YHhM3smoGjum6YvLwehz6JDBWw9Ln72y68hHxoLzU/ZUCbqN4QIFNE2d
 CgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378592; x=1697983392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9DyJgfsNaywwdF+X+Mlrm7UwaxUF7X0EYzGFK3vXhg=;
 b=aJJmiQ9spxbO+ikd9Xcu7aXpK3HZBd9iVU05q1u/G1Aramio3oBJkS1z3LkvUtENee
 wvzA9gKWgdYiS/zBJ3UgKIuIifQDmw0isvQr/OK/nDsEGkh8EzM9nacpMvZpZ59YdjbE
 NI5JhiGiUEfjdUTbVldF36BXbGJxV3zY74tytbzwlxLrPXLuyldczUbChf+OHRa535jf
 eEEBbBBQTI6ovUDDZiIjg9a46dWEllDbK5H6Fh0ZCvsVFNyyCR4pqVu+jv019AedvrLo
 MOngA+0NJHTWfoLVjtXmyDXn2ZWMldxne62ol1KRl/JXwpAxfRvOdxE0nH7OSWjmJK4G
 N27A==
X-Gm-Message-State: AOJu0YyUjXGes9T3zVEtsPUC2ciNR7P4Ex/1STE5EvLDz+v06Elf33wC
 FcSZUXRdFAnSKTXfgLko6DXa30N0GyS4iEOlvkeDGA==
X-Google-Smtp-Source: AGHT+IHyYSb3U2ucitGCTEMISvjTJANaoVycYPkJ0IYPNP3zjmFa4oUUZoUz0gwOBfCCi18oHXC4Lg==
X-Received: by 2002:a17:903:27ce:b0:1ca:5d1a:e77f with SMTP id
 km14-20020a17090327ce00b001ca5d1ae77fmr473832plb.43.1697378592378; 
 Sun, 15 Oct 2023 07:03:12 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 f10-20020a170902ce8a00b001c322a41188sm6802274plg.117.2023.10.15.07.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:03:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>
Subject: [PATCH v4 02/20] tap: Remove qemu_using_vnet_hdr()
Date: Sun, 15 Oct 2023 23:02:34 +0900
Message-ID: <20231015140259.259434-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Since qemu_set_vnet_hdr_len() is always called when
qemu_using_vnet_hdr() is called, we can merge them and save some code.

For consistency, express that the virtio-net header is not in use by
returning 0 with qemu_get_vnet_hdr_len() instead of having a dedicated
function, qemu_get_using_vnet_hdr().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/net.h   |  6 ------
 hw/net/e1000e.c     |  1 -
 hw/net/igb.c        |  1 -
 hw/net/net_tx_pkt.c |  4 ++--
 hw/net/virtio-net.c |  3 ---
 hw/net/vmxnet3.c    |  2 --
 net/dump.c          |  4 +---
 net/net.c           | 18 ------------------
 net/netmap.c        |  5 -----
 net/tap.c           | 22 ++--------------------
 10 files changed, 5 insertions(+), 61 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 685ec58318..011031ef77 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -56,8 +56,6 @@ typedef RxFilterInfo *(QueryRxFilter)(NetClientState *);
 typedef bool (HasUfo)(NetClientState *);
 typedef bool (HasVnetHdr)(NetClientState *);
 typedef bool (HasVnetHdrLen)(NetClientState *, int);
-typedef bool (GetUsingVnetHdr)(NetClientState *);
-typedef void (UsingVnetHdr)(NetClientState *, bool);
 typedef void (SetOffload)(NetClientState *, int, int, int, int, int);
 typedef int (GetVnetHdrLen)(NetClientState *);
 typedef void (SetVnetHdrLen)(NetClientState *, int);
@@ -86,8 +84,6 @@ typedef struct NetClientInfo {
     HasUfo *has_ufo;
     HasVnetHdr *has_vnet_hdr;
     HasVnetHdrLen *has_vnet_hdr_len;
-    GetUsingVnetHdr *get_using_vnet_hdr;
-    UsingVnetHdr *using_vnet_hdr;
     SetOffload *set_offload;
     GetVnetHdrLen *get_vnet_hdr_len;
     SetVnetHdrLen *set_vnet_hdr_len;
@@ -191,8 +187,6 @@ void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
 bool qemu_has_ufo(NetClientState *nc);
 bool qemu_has_vnet_hdr(NetClientState *nc);
 bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
-bool qemu_get_using_vnet_hdr(NetClientState *nc);
-void qemu_using_vnet_hdr(NetClientState *nc, bool enable);
 void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
                       int ecn, int ufo);
 int qemu_get_vnet_hdr_len(NetClientState *nc);
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index e41a6c1038..4edb58858e 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -352,7 +352,6 @@ e1000e_init_net_peer(E1000EState *s, PCIDevice *pci_dev, uint8_t *macaddr)
     for (i = 0; i < s->conf.peers.queues; i++) {
         nc = qemu_get_subqueue(s->nic, i);
         qemu_set_vnet_hdr_len(nc->peer, sizeof(struct virtio_net_hdr));
-        qemu_using_vnet_hdr(nc->peer, true);
     }
 }
 
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 8b713843d9..cfdb148051 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -339,7 +339,6 @@ igb_init_net_peer(IGBState *s, PCIDevice *pci_dev, uint8_t *macaddr)
     for (i = 0; i < s->conf.peers.queues; i++) {
         nc = qemu_get_subqueue(s->nic, i);
         qemu_set_vnet_hdr_len(nc->peer, sizeof(struct virtio_net_hdr));
-        qemu_using_vnet_hdr(nc->peer, true);
     }
 }
 
diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 2e5f58b3c9..668871f8d8 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -578,7 +578,7 @@ static void net_tx_pkt_sendv(
 {
     NetClientState *nc = opaque;
 
-    if (qemu_get_using_vnet_hdr(nc->peer)) {
+    if (qemu_get_vnet_hdr_len(nc->peer)) {
         qemu_sendv_packet(nc, virt_iov, virt_iov_cnt);
     } else {
         qemu_sendv_packet(nc, iov, iov_cnt);
@@ -808,7 +808,7 @@ static bool net_tx_pkt_do_sw_fragmentation(struct NetTxPkt *pkt,
 
 bool net_tx_pkt_send(struct NetTxPkt *pkt, NetClientState *nc)
 {
-    bool offload = qemu_get_using_vnet_hdr(nc->peer);
+    bool offload = !!qemu_get_vnet_hdr_len(nc->peer);
     return net_tx_pkt_send_custom(pkt, offload, net_tx_pkt_sendv, nc);
 }
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9a93a2df01..cab79f19cb 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3709,9 +3709,6 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     peer_test_vnet_hdr(n);
     if (peer_has_vnet_hdr(n)) {
-        for (i = 0; i < n->max_queue_pairs; i++) {
-            qemu_using_vnet_hdr(qemu_get_subqueue(n->nic, i)->peer, true);
-        }
         n->host_hdr_len = sizeof(struct virtio_net_hdr);
     } else {
         n->host_hdr_len = 0;
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 3df1d1b101..a9619108ca 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2086,8 +2086,6 @@ static void vmxnet3_net_init(VMXNET3State *s)
     if (s->peer_has_vhdr) {
         qemu_set_vnet_hdr_len(qemu_get_queue(s->nic)->peer,
             sizeof(struct virtio_net_hdr));
-
-        qemu_using_vnet_hdr(qemu_get_queue(s->nic)->peer, 1);
     }
 
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
diff --git a/net/dump.c b/net/dump.c
index 7d05f16ca7..d2defe4ed9 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -154,10 +154,8 @@ static ssize_t filter_dump_receive_iov(NetFilterState *nf, NetClientState *sndr,
                                        int iovcnt, NetPacketSent *sent_cb)
 {
     NetFilterDumpState *nfds = FILTER_DUMP(nf);
-    int offset = qemu_get_using_vnet_hdr(nf->netdev) ?
-                 qemu_get_vnet_hdr_len(nf->netdev) : 0;
 
-    dump_receive_iov(&nfds->ds, iov, iovcnt, offset);
+    dump_receive_iov(&nfds->ds, iov, iovcnt, qemu_get_vnet_hdr_len(nf->netdev));
     return 0;
 }
 
diff --git a/net/net.c b/net/net.c
index 3523cceafc..1bb4f33a63 100644
--- a/net/net.c
+++ b/net/net.c
@@ -515,24 +515,6 @@ bool qemu_has_vnet_hdr_len(NetClientState *nc, int len)
     return nc->info->has_vnet_hdr_len(nc, len);
 }
 
-bool qemu_get_using_vnet_hdr(NetClientState *nc)
-{
-    if (!nc || !nc->info->get_using_vnet_hdr) {
-        return false;
-    }
-
-    return nc->info->get_using_vnet_hdr(nc);
-}
-
-void qemu_using_vnet_hdr(NetClientState *nc, bool enable)
-{
-    if (!nc || !nc->info->using_vnet_hdr) {
-        return;
-    }
-
-    nc->info->using_vnet_hdr(nc, enable);
-}
-
 void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
                           int ecn, int ufo)
 {
diff --git a/net/netmap.c b/net/netmap.c
index 9e0cec58d3..b7a669f862 100644
--- a/net/netmap.c
+++ b/net/netmap.c
@@ -351,10 +351,6 @@ static bool netmap_has_vnet_hdr(NetClientState *nc)
     return netmap_has_vnet_hdr_len(nc, sizeof(struct virtio_net_hdr));
 }
 
-static void netmap_using_vnet_hdr(NetClientState *nc, bool enable)
-{
-}
-
 static void netmap_set_vnet_hdr_len(NetClientState *nc, int len)
 {
     NetmapState *s = DO_UPCAST(NetmapState, nc, nc);
@@ -393,7 +389,6 @@ static NetClientInfo net_netmap_info = {
     .has_ufo = netmap_has_vnet_hdr,
     .has_vnet_hdr = netmap_has_vnet_hdr,
     .has_vnet_hdr_len = netmap_has_vnet_hdr_len,
-    .using_vnet_hdr = netmap_using_vnet_hdr,
     .set_offload = netmap_set_offload,
     .set_vnet_hdr_len = netmap_set_vnet_hdr_len,
 };
diff --git a/net/tap.c b/net/tap.c
index 0403729739..4667933ffe 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -255,7 +255,7 @@ static int tap_get_vnet_hdr_len(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
-    return s->host_vnet_hdr_len;
+    return s->using_vnet_hdr ? s->host_vnet_hdr_len : 0;
 }
 
 static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
@@ -269,23 +269,7 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 
     tap_fd_set_vnet_hdr_len(s->fd, len);
     s->host_vnet_hdr_len = len;
-}
-
-static bool tap_get_using_vnet_hdr(NetClientState *nc)
-{
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-
-    return s->using_vnet_hdr;
-}
-
-static void tap_using_vnet_hdr(NetClientState *nc, bool using_vnet_hdr)
-{
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-
-    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
-    assert(!!s->host_vnet_hdr_len == using_vnet_hdr);
-
-    s->using_vnet_hdr = using_vnet_hdr;
+    s->using_vnet_hdr = true;
 }
 
 static int tap_set_vnet_le(NetClientState *nc, bool is_le)
@@ -382,8 +366,6 @@ static NetClientInfo net_tap_info = {
     .has_ufo = tap_has_ufo,
     .has_vnet_hdr = tap_has_vnet_hdr,
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
-    .get_using_vnet_hdr = tap_get_using_vnet_hdr,
-    .using_vnet_hdr = tap_using_vnet_hdr,
     .set_offload = tap_set_offload,
     .get_vnet_hdr_len = tap_get_vnet_hdr_len,
     .set_vnet_hdr_len = tap_set_vnet_hdr_len,
-- 
2.42.0


