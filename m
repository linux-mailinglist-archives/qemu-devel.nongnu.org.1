Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC87EFEAE
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:26:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4Has-0006Br-07; Sat, 18 Nov 2023 04:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hap-0006BS-Ni
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:23 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Han-0003hP-NS
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:23 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ce618b7919so8625705ad.0
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299580; x=1700904380;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SA+gp7Q4DsFINtAgCtzcNmDa0U0Sm402hHQG0dlxYmY=;
 b=M7QXVHyA5DTkOIxsrX3UO/yev/L5fNtYD1151faeuM965I4hHmAycDpAaliuOfFBrG
 +nyTXfzB/xxz9pQQiIeGIcLOc4Bp/z0iBniKGqk70VdtCAbTbm33h/MQDt8keSZ5+btm
 2pjqjDYOxEVythGvK8bymhDxfKvrAP1ALS3xUo1n7S+VQscbRyCfFXdvyNnOyy0xZfDD
 c7lfZjf0g08YAgHOLsa4RmU+6FHZ8ZNs1rt2bJDxlPCa9Cfg2v6EVDrcRPCIWEAQuPI3
 c6ktBUtgd4/kqcwdgx+1Z6P0Lr0EpnmhlIMoO3/arrLMq0+hx7i0OUIqFyyFN++E8/IN
 fa0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299580; x=1700904380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SA+gp7Q4DsFINtAgCtzcNmDa0U0Sm402hHQG0dlxYmY=;
 b=p4MhwO6M1HqwQ3ThbTY9a2qx2trws+/oSq0H3v67gfP3FdC3JNvNhx2H3wLzK2pmTH
 Ln64+CWAl3tGx81QZ4pZLz7s2Drh0j8U5NhXifWjJ6uGm/ihM9y1V/qk/3e1XYJBq181
 TZqKm4Y0xfGtYuu91tCcfLFrShcT1mf3/06X8zpPWRYqR/ifN9H+tvEH3Wi9srdQLla+
 eUJRAtwMSfQlvtfv1Bz4OKuLFZ7DyTymUdz/M+Qa60gdJUS9UHXe+ko26kIuscCzNnqc
 zh7SH0emOThIj1tdgFXJwf40yosGJ8zXExjefCaPd42WtdXnhFMLQ/M0o/V4ieyhcIH5
 Nb8g==
X-Gm-Message-State: AOJu0YwIb/TYk4gtCIK0ES8aTwwumKb/etOWISOd5OUG1EIuPOqPo00Y
 KQIImXtfasr8l2alyQ9BmPl97QZ2SdmBmAr/rFY=
X-Google-Smtp-Source: AGHT+IGHUTzi2D4OOIRdaEYTzt8NNxjos8uUqvkHUb6Y2RrpbT/GjlIztUtslNiFSEtRTR9pbuE2Yw==
X-Received: by 2002:a17:903:32c2:b0:1cc:36fb:22ae with SMTP id
 i2-20020a17090332c200b001cc36fb22aemr2616776plr.2.1700299579825; 
 Sat, 18 Nov 2023 01:26:19 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 s3-20020a170902ea0300b001ce5b6e97a9sm2647057plg.54.2023.11.18.01.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:26:19 -0800 (PST)
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
Subject: [PATCH RESEND v7 02/19] tap: Remove qemu_using_vnet_hdr()
Date: Sat, 18 Nov 2023 18:25:42 +0900
Message-ID: <20231118092601.7132-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118092601.7132-1-akihiko.odaki@daynix.com>
References: <20231118092601.7132-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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


