Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AD47EFEAB
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:20:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4HTs-0002U0-Ty; Sat, 18 Nov 2023 04:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HTq-0002Tm-Lz
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:19:10 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HTo-00055v-MH
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:19:10 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5bd33abbb90so1945941a12.2
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299147; x=1700903947;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SA+gp7Q4DsFINtAgCtzcNmDa0U0Sm402hHQG0dlxYmY=;
 b=zC0rodCv0Bwl00ZhFGN931Wtzzx/yNB/Uai1G14XCB6xGxkKHfA9sfZ/+GhJVOOiuW
 RURRU9CCSdqYtaMKve+Ea7nxOn79H3+bETPl8wv0RSaKtj9M7Iu/FGYn/6KH3E+LlXLJ
 kIxkJviIMsCxfiWo5WNx29ZKSe9sceH/qlezxbqTK6+rTn7wCEbz/P/QW2F9Bpk31AJ5
 aI4kUTvBYQefzTkVKSvMXvAxeccUZ/4YPyVCenL3cWmTXz/tscWYQ0BFCLJ0hT5Th0MR
 uhZeTu7kNDxGmc5KGZUCFRZ+GjMbOCXwPf41EbWhjZYHeHE2zqBJ/x22jfnibbI99eSN
 RJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299147; x=1700903947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SA+gp7Q4DsFINtAgCtzcNmDa0U0Sm402hHQG0dlxYmY=;
 b=QCJqbPFeZsgY6NwT5V79b7Crlm21TuvKkxj6f86+1VxZn2vSUyZeZfqM+iUlV9aDkx
 wNFIrP8eo5oV/s+lnkkoSkQamDCaK0lWykeWu5Shb5QGnLmfsbzls/D5YEktaHY4ZdjM
 Jv6Y22/ibAtqKv2wj0UJIkqCRGJpRfgji3Je2kj0+sXhwycAOlRZPlbk1+4+PWZz2GLs
 itAWotY9OSvBuR7N0kwElqvo5ZZ/zo2DC8ZCM88Aq9eHio+eSBthXHAnBa8ElzA9WwPa
 OILhYnjzVawzJtGOKcHWLIwW7sXadUySP/ft2s7v4kWdUgyhJt6qD+Z6mqgLa1DGcqP4
 X9EQ==
X-Gm-Message-State: AOJu0YxqJLBIZN81fgIjv35O2Z6s8kc0U09cDjlDR4ojQ2ydOqALIftv
 Kgy8MCttoZHOEnEMHkf529D1jM1jOzmA4T60840=
X-Google-Smtp-Source: AGHT+IFVwKtaUDKs9H8SawdsPGnNjg6rYzkLXoEf7lgXQHNSd1eW341yAWl2aYmxRWIZHh82uYLc2w==
X-Received: by 2002:a05:6a20:9382:b0:189:7c2:508d with SMTP id
 x2-20020a056a20938200b0018907c2508dmr1758851pzh.12.1700299146962; 
 Sat, 18 Nov 2023 01:19:06 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 ji6-20020a170903324600b001c9d6923e7dsm2631409plb.222.2023.11.18.01.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:19:06 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>
Subject: [PATCH v7 02/19] tap: Remove qemu_using_vnet_hdr()
Date: Sat, 18 Nov 2023 18:18:16 +0900
Message-ID: <20231118091837.5758-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118091837.5758-1-akihiko.odaki@daynix.com>
References: <20231118091837.5758-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52a.google.com
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

Since qemu_set_vnet_hdr_len() is always called when
qemu_using_vnet_hdr() is called, we can merge them and save some code.

For consistency, express that the virtio-net header is not in use by
returning 0 with qemu_get_vnet_hdr_len() instead of having a dedicated
function, qemu_get_using_vnet_hdr().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/net.h   |  7 -------
 hw/net/e1000e.c     |  1 -
 hw/net/igb.c        |  1 -
 hw/net/net_tx_pkt.c |  4 ++--
 hw/net/virtio-net.c |  3 ---
 hw/net/vmxnet3.c    |  2 --
 net/dump.c          |  4 +---
 net/net.c           | 24 +-----------------------
 net/netmap.c        |  5 -----
 net/tap.c           | 28 +---------------------------
 10 files changed, 5 insertions(+), 74 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index ffbd2c8d56..374a827190 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -57,8 +57,6 @@ typedef bool (HasUfo)(NetClientState *);
 typedef bool (HasUso)(NetClientState *);
 typedef bool (HasVnetHdr)(NetClientState *);
 typedef bool (HasVnetHdrLen)(NetClientState *, int);
-typedef bool (GetUsingVnetHdr)(NetClientState *);
-typedef void (UsingVnetHdr)(NetClientState *, bool);
 typedef void (SetOffload)(NetClientState *, int, int, int, int, int, int, int);
 typedef int (GetVnetHdrLen)(NetClientState *);
 typedef void (SetVnetHdrLen)(NetClientState *, int);
@@ -88,10 +86,7 @@ typedef struct NetClientInfo {
     HasUso *has_uso;
     HasVnetHdr *has_vnet_hdr;
     HasVnetHdrLen *has_vnet_hdr_len;
-    GetUsingVnetHdr *get_using_vnet_hdr;
-    UsingVnetHdr *using_vnet_hdr;
     SetOffload *set_offload;
-    GetVnetHdrLen *get_vnet_hdr_len;
     SetVnetHdrLen *set_vnet_hdr_len;
     SetVnetLE *set_vnet_le;
     SetVnetBE *set_vnet_be;
@@ -194,8 +189,6 @@ bool qemu_has_ufo(NetClientState *nc);
 bool qemu_has_uso(NetClientState *nc);
 bool qemu_has_vnet_hdr(NetClientState *nc);
 bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
-bool qemu_get_using_vnet_hdr(NetClientState *nc);
-void qemu_using_vnet_hdr(NetClientState *nc, bool enable);
 void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
                       int ecn, int ufo, int uso4, int uso6);
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
index 80c56f0cfc..e12176acb1 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3728,9 +3728,6 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     peer_test_vnet_hdr(n);
     if (peer_has_vnet_hdr(n)) {
-        for (i = 0; i < n->max_queue_pairs; i++) {
-            qemu_using_vnet_hdr(qemu_get_subqueue(n->nic, i)->peer, true);
-        }
         n->host_hdr_len = sizeof(struct virtio_net_hdr);
     } else {
         n->host_hdr_len = 0;
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 6fb4102d03..81ab8ada55 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2091,8 +2091,6 @@ static void vmxnet3_net_init(VMXNET3State *s)
     if (s->peer_has_vhdr) {
         qemu_set_vnet_hdr_len(qemu_get_queue(s->nic)->peer,
             sizeof(struct virtio_net_hdr));
-
-        qemu_using_vnet_hdr(qemu_get_queue(s->nic)->peer, 1);
     }
 
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
diff --git a/net/dump.c b/net/dump.c
index 16073f2458..956e34a123 100644
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
index cb88651db2..f603030dd6 100644
--- a/net/net.c
+++ b/net/net.c
@@ -524,24 +524,6 @@ bool qemu_has_vnet_hdr_len(NetClientState *nc, int len)
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
                           int ecn, int ufo, int uso4, int uso6)
 {
@@ -554,11 +536,7 @@ void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
 
 int qemu_get_vnet_hdr_len(NetClientState *nc)
 {
-    if (!nc || !nc->info->get_vnet_hdr_len) {
-        return 0;
-    }
-
-    return nc->info->get_vnet_hdr_len(nc);
+    return nc->vnet_hdr_len;
 }
 
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
diff --git a/net/netmap.c b/net/netmap.c
index 241b27c8e9..297510e190 100644
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
index a1f4d9d49f..ea2dadc943 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -262,13 +262,6 @@ static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
     return tap_has_vnet_hdr(nc);
 }
 
-static int tap_get_vnet_hdr_len(NetClientState *nc)
-{
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-
-    return s->host_vnet_hdr_len;
-}
-
 static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -280,23 +273,7 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 
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
@@ -394,10 +371,7 @@ static NetClientInfo net_tap_info = {
     .has_uso = tap_has_uso,
     .has_vnet_hdr = tap_has_vnet_hdr,
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
-    .get_using_vnet_hdr = tap_get_using_vnet_hdr,
-    .using_vnet_hdr = tap_using_vnet_hdr,
     .set_offload = tap_set_offload,
-    .get_vnet_hdr_len = tap_get_vnet_hdr_len,
     .set_vnet_hdr_len = tap_set_vnet_hdr_len,
     .set_vnet_le = tap_set_vnet_le,
     .set_vnet_be = tap_set_vnet_be,
-- 
2.42.1


