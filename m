Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4BA7DB2A8
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:15:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKbW-00020Q-Uw; Mon, 30 Oct 2023 01:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbV-0001zt-LD
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:21 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbT-0001iH-JU
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:21 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso4042117b3a.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642855; x=1699247655;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uce4xtiVEZcohhMWmT1071H9L+AyitWBlOt7Mj+EGv0=;
 b=KUfh45PU3aXgjn5Bmu7RrIMOtaUSbwznuAbMGsZwpDORq4/tpAfWUWXOtg//NhOve1
 P2PZv4PntCr4v053JDhw7L3/owjQg6f0SIWfdKSa7HeJV1ojVM1MevoDE7cEvgzSDKYz
 PaFxStgh/aHDE0jdcEgUIHLRB/QIEk1KNvujsA2nqIbucRi8V49CcRu/nLkB6n1+H1ZK
 F0p1ekchbAPxk0AFGjjs0y73rrgzQKYnk6vvVdMh+hAaNV0XJCMYA4Ze8bbD4e8emePK
 b7UoDyfajZMMCKwpZP76A3r4kLeJc1zqlGvgVBxn39dBtfDFfhFfHLy1s8n1rOVD6Vgk
 D7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642855; x=1699247655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uce4xtiVEZcohhMWmT1071H9L+AyitWBlOt7Mj+EGv0=;
 b=Souwcy0W+yCcbq3JdxanTIJ9xOcSwJkUobFKMsrwyvfK+ah8AYJRYdH2j59KWScHox
 JpFewmDd9oSVlFuNsQQuslaePj4MLCF78Azn/oOKYD4cjMpGvHLFATwae+UBPGCIp+vW
 /z/rMfS3/g9plnmafbiuOnoL5jZ490bDeThkSQ7eVtyXkEvs4L6nEXZy0AUMcgzLkVpJ
 56HyfCqdlAbqLp11It84P14QhErTLYQCAfyZFTG573IQvkoUfXEwquKiSV+ZROhK1aga
 8RS5BkNVe0n9SMPY73gL2DiGJgqd/eeNdkI9W7A5R12EXftQinTAuFcwwYgfbBKQNygW
 6Dsw==
X-Gm-Message-State: AOJu0YwkSX6LXmKt1ZIragLCVAOTkR37p+G9ws1fKd1qexpuCTTaFcSX
 RTO87uenJ0xVfIaea3t4ZVXMAJVHDZ5xQMvh9Sgk/g==
X-Google-Smtp-Source: AGHT+IG5B6mvfJxMdHIQZ/AQWFnIU3kdqKTCTbgo6P7iVpuICL68KJBrVAio/WeABpohLUTb+7VWLg==
X-Received: by 2002:a05:6a00:23d5:b0:690:ce36:8b00 with SMTP id
 g21-20020a056a0023d500b00690ce368b00mr11679585pfc.2.1698642855669; 
 Sun, 29 Oct 2023 22:14:15 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 fc2-20020a056a002e0200b006be2f94e92asm5037064pfb.84.2023.10.29.22.14.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:14:15 -0700 (PDT)
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
Subject: [PATCH v6 02/21] tap: Remove qemu_using_vnet_hdr()
Date: Mon, 30 Oct 2023 14:12:23 +0900
Message-ID: <20231030051356.33123-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
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
index ffbd2c8d56..d98a2b136a 100644
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
@@ -88,8 +86,6 @@ typedef struct NetClientInfo {
     HasUso *has_uso;
     HasVnetHdr *has_vnet_hdr;
     HasVnetHdrLen *has_vnet_hdr_len;
-    GetUsingVnetHdr *get_using_vnet_hdr;
-    UsingVnetHdr *using_vnet_hdr;
     SetOffload *set_offload;
     GetVnetHdrLen *get_vnet_hdr_len;
     SetVnetHdrLen *set_vnet_hdr_len;
@@ -194,8 +190,6 @@ bool qemu_has_ufo(NetClientState *nc);
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
index cb88651db2..fda9a8f994 100644
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
index 5d6f292cfe..0e031ee9fa 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -266,7 +266,7 @@ static int tap_get_vnet_hdr_len(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
-    return s->host_vnet_hdr_len;
+    return s->using_vnet_hdr ? s->host_vnet_hdr_len : 0;
 }
 
 static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
@@ -280,23 +280,7 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 
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
@@ -394,8 +378,6 @@ static NetClientInfo net_tap_info = {
     .has_uso = tap_has_uso,
     .has_vnet_hdr = tap_has_vnet_hdr,
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
-    .get_using_vnet_hdr = tap_get_using_vnet_hdr,
-    .using_vnet_hdr = tap_using_vnet_hdr,
     .set_offload = tap_set_offload,
     .get_vnet_hdr_len = tap_get_vnet_hdr_len,
     .set_vnet_hdr_len = tap_set_vnet_hdr_len,
-- 
2.42.0


