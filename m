Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2E27C5853
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:43:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbKX-0003PP-Uh; Wed, 11 Oct 2023 11:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbK1-0002ep-W0
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:30 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbJj-0001yl-V8
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:29 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-692eed30152so5382747b3a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697038810; x=1697643610;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=motSgxT4NUbVePod9AMFlemp/F4twy5b08NyOAQoZcE=;
 b=ZFhqQyTR3NrVWkJbYmDpbMLia7D6bZjxLg+I9lKie/d8x98DtT5TgDOzRRtTFxqapH
 xX5sudVAu+zQnmltF4fmDyXh+lLxnWXnJ2ObW3gRw/jVDoE83gliA70TunFO6NH+c1mn
 NaaMihlGJ4liXHPzP0oYBAWGTYnXyjMWnmxyoku4iuq65iJcfIV+8s5r/JQCQkaX/P5i
 Z4vP57ZwVJHN6ZMbZhI1PKSA0yqPe48FuZdRz5fYHY40k4VJ1ocU0Kg0nxEXYtk4xGZh
 OQPt/2QxEfvlfZRZhLWQGVdNyJaYPZ5T1HB7zysm50q4wT1e3g+Z2dOiG9ZVMU7sWrM6
 q1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697038810; x=1697643610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=motSgxT4NUbVePod9AMFlemp/F4twy5b08NyOAQoZcE=;
 b=GMjbVpWBdq8F09aOP9MLb+Hpe/vmHX88FSlp57791lKyPaULrXg8ul2EXr35dT4BxY
 9zNce2WoJHE+Mg5DmO2QokIg1BgF5WOP0qAZRwuIkKQYzhVEoD053VO9eOzM/P1KVCKk
 YZh9GtjK4nrhorH70sITg4AVvnaeyWPMGb3oWXFkCe2gIJdQmmZdro2RkDcRCBIP5MDH
 Szk7FK+6UBUGxfuxzLvDPOtN2iwVOkVUW83GHpDl360FgsNWKfMXF8YgAMJF+qJFk2Xk
 vv0juVmfQM84an80u/HuUPyfB9Qh/a9NUzL070pRtwgcikONNxum5ZlQDqmzuzTYW7Je
 Bb2A==
X-Gm-Message-State: AOJu0Yw/MoUXhy6uEvEtkK04LMmp9t7YGsM0PjniJdGv2Jr5ditcRH91
 HgUTKxFbxJqhm87I6Un3Dj+ym/d0/zqyNLyG7GK+DA==
X-Google-Smtp-Source: AGHT+IGMF2v5t+o3P9qCS8CaoInQTP0FuS+zhnveZX6lg1uuud+4IcklVDcGPRDI0g9H6kzJrskxFg==
X-Received: by 2002:a05:6a20:3213:b0:172:913c:ba37 with SMTP id
 hl19-20020a056a20321300b00172913cba37mr3814895pzc.38.1697038809673; 
 Wed, 11 Oct 2023 08:40:09 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 ci22-20020a17090afc9600b00277560ecd5dsm49070pjb.46.2023.10.11.08.40.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 08:40:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 04/11] net: Remove receive_raw()
Date: Thu, 12 Oct 2023 00:39:35 +0900
Message-ID: <20231011153944.39572-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011153944.39572-1-akihiko.odaki@daynix.com>
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

While netmap implements virtio-net header, it does not implement
receive_raw(). Instead of implementing receive_raw for netmap, add
virtio-net headers in the common code and use receive_iov()/receive()
instead. This also fixes the buffer size for the virtio-net header.

Fixes: fbbdbddec0 ("tap: allow extended virtio header with hash info")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/filter.h    |  3 ---
 include/net/net.h       |  1 -
 include/net/queue.h     |  7 -----
 include/sysemu/replay.h |  2 +-
 net/dump.c              |  4 +--
 net/filter-buffer.c     |  4 +--
 net/filter-mirror.c     |  4 +--
 net/filter-replay.c     |  3 +--
 net/filter-rewriter.c   |  5 ++--
 net/filter.c            |  8 +++---
 net/net.c               | 60 ++++++++++++++++-------------------------
 net/queue.c             | 30 +++++++--------------
 net/tap.c               | 37 -------------------------
 replay/replay-net.c     |  8 ++----
 14 files changed, 47 insertions(+), 129 deletions(-)

diff --git a/include/net/filter.h b/include/net/filter.h
index 27ffc630df..e523771e72 100644
--- a/include/net/filter.h
+++ b/include/net/filter.h
@@ -26,7 +26,6 @@ typedef void (FilterCleanup) (NetFilterState *nf);
  */
 typedef ssize_t (FilterReceiveIOV)(NetFilterState *nc,
                                    NetClientState *sender,
-                                   unsigned flags,
                                    const struct iovec *iov,
                                    int iovcnt,
                                    NetPacketSent *sent_cb);
@@ -65,14 +64,12 @@ struct NetFilterState {
 ssize_t qemu_netfilter_receive(NetFilterState *nf,
                                NetFilterDirection direction,
                                NetClientState *sender,
-                               unsigned flags,
                                const struct iovec *iov,
                                int iovcnt,
                                NetPacketSent *sent_cb);
 
 /* pass the packet to the next filter */
 ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
-                                    unsigned flags,
                                     const struct iovec *iov,
                                     int iovcnt,
                                     void *opaque);
diff --git a/include/net/net.h b/include/net/net.h
index 011031ef77..971dc54897 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -71,7 +71,6 @@ typedef struct NetClientInfo {
     NetClientDriver type;
     size_t size;
     NetReceive *receive;
-    NetReceive *receive_raw;
     NetReceiveIOV *receive_iov;
     NetCanReceive *can_receive;
     NetStart *start;
diff --git a/include/net/queue.h b/include/net/queue.h
index 9f2f289d77..571f4e1436 100644
--- a/include/net/queue.h
+++ b/include/net/queue.h
@@ -30,16 +30,12 @@ typedef struct NetQueue NetQueue;
 
 typedef void (NetPacketSent) (NetClientState *sender, ssize_t ret);
 
-#define QEMU_NET_PACKET_FLAG_NONE  0
-#define QEMU_NET_PACKET_FLAG_RAW  (1<<0)
-
 /* Returns:
  *   >0 - success
  *    0 - queue packet for future redelivery
  *   <0 - failure (discard packet)
  */
 typedef ssize_t (NetQueueDeliverFunc)(NetClientState *sender,
-                                      unsigned flags,
                                       const struct iovec *iov,
                                       int iovcnt,
                                       void *opaque);
@@ -48,7 +44,6 @@ NetQueue *qemu_new_net_queue(NetQueueDeliverFunc *deliver, void *opaque);
 
 void qemu_net_queue_append_iov(NetQueue *queue,
                                NetClientState *sender,
-                               unsigned flags,
                                const struct iovec *iov,
                                int iovcnt,
                                NetPacketSent *sent_cb);
@@ -65,14 +60,12 @@ ssize_t qemu_net_queue_receive_iov(NetQueue *queue,
 
 ssize_t qemu_net_queue_send(NetQueue *queue,
                             NetClientState *sender,
-                            unsigned flags,
                             const uint8_t *data,
                             size_t size,
                             NetPacketSent *sent_cb);
 
 ssize_t qemu_net_queue_send_iov(NetQueue *queue,
                                 NetClientState *sender,
-                                unsigned flags,
                                 const struct iovec *iov,
                                 int iovcnt,
                                 NetPacketSent *sent_cb);
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 08aae5869f..67b2d3ac73 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -158,7 +158,7 @@ ReplayNetState *replay_register_net(NetFilterState *nfs);
 /*! Unregisters replay network filter. */
 void replay_unregister_net(ReplayNetState *rns);
 /*! Called to write network packet to the replay log. */
-void replay_net_packet_event(ReplayNetState *rns, unsigned flags,
+void replay_net_packet_event(ReplayNetState *rns,
                              const struct iovec *iov, int iovcnt);
 
 /* Audio */
diff --git a/net/dump.c b/net/dump.c
index d2defe4ed9..968ac7a82a 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -150,8 +150,8 @@ struct NetFilterDumpState {
 };
 
 static ssize_t filter_dump_receive_iov(NetFilterState *nf, NetClientState *sndr,
-                                       unsigned flags, const struct iovec *iov,
-                                       int iovcnt, NetPacketSent *sent_cb)
+                                       const struct iovec *iov, int iovcnt,
+                                       NetPacketSent *sent_cb)
 {
     NetFilterDumpState *nfds = FILTER_DUMP(nf);
 
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 283dc9cbe6..6d8b581cd8 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -58,7 +58,6 @@ static void filter_buffer_release_timer(void *opaque)
 /* filter APIs */
 static ssize_t filter_buffer_receive_iov(NetFilterState *nf,
                                          NetClientState *sender,
-                                         unsigned flags,
                                          const struct iovec *iov,
                                          int iovcnt,
                                          NetPacketSent *sent_cb)
@@ -79,8 +78,7 @@ static ssize_t filter_buffer_receive_iov(NetFilterState *nf,
      * the packets without caring about the receiver. This is suboptimal.
      * May need more thoughts (e.g keeping sent_cb).
      */
-    qemu_net_queue_append_iov(s->incoming_queue, sender, flags,
-                              iov, iovcnt, NULL);
+    qemu_net_queue_append_iov(s->incoming_queue, sender, iov, iovcnt, NULL);
     return iov_size(iov, iovcnt);
 }
 
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 34a63b5dbb..8a618f26c0 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -145,12 +145,12 @@ static void redirector_to_filter(NetFilterState *nf,
 
     if (nf->direction == NET_FILTER_DIRECTION_ALL ||
         nf->direction == NET_FILTER_DIRECTION_TX) {
-        qemu_netfilter_pass_to_next(nf->netdev, 0, &iov, 1, nf);
+        qemu_netfilter_pass_to_next(nf->netdev, &iov, 1, nf);
     }
 
     if (nf->direction == NET_FILTER_DIRECTION_ALL ||
         nf->direction == NET_FILTER_DIRECTION_RX) {
-        qemu_netfilter_pass_to_next(nf->netdev->peer, 0, &iov, 1, nf);
+        qemu_netfilter_pass_to_next(nf->netdev->peer, &iov, 1, nf);
      }
 }
 
diff --git a/net/filter-replay.c b/net/filter-replay.c
index 54690676ef..ab132f6f24 100644
--- a/net/filter-replay.c
+++ b/net/filter-replay.c
@@ -31,7 +31,6 @@ struct NetFilterReplayState {
 
 static ssize_t filter_replay_receive_iov(NetFilterState *nf,
                                          NetClientState *sndr,
-                                         unsigned flags,
                                          const struct iovec *iov,
                                          int iovcnt, NetPacketSent *sent_cb)
 {
@@ -39,7 +38,7 @@ static ssize_t filter_replay_receive_iov(NetFilterState *nf,
     switch (replay_mode) {
     case REPLAY_MODE_RECORD:
         if (nf->netdev == sndr) {
-            replay_net_packet_event(nfrs->rns, flags, iov, iovcnt);
+            replay_net_packet_event(nfrs->rns, iov, iovcnt);
             return iov_size(iov, iovcnt);
         }
         return 0;
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index c18c4c2019..5da0b097db 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -251,7 +251,6 @@ static int handle_secondary_tcp_pkt(RewriterState *rf,
 
 static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
                                          NetClientState *sender,
-                                         unsigned flags,
                                          const struct iovec *iov,
                                          int iovcnt,
                                          NetPacketSent *sent_cb)
@@ -294,7 +293,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
         if (sender == nf->netdev) {
             /* NET_FILTER_DIRECTION_TX */
             if (!handle_primary_tcp_pkt(s, conn, pkt, &key)) {
-                qemu_net_queue_send(s->incoming_queue, sender, 0,
+                qemu_net_queue_send(s->incoming_queue, sender,
                 (const uint8_t *)pkt->data, pkt->size, NULL);
                 packet_destroy(pkt, NULL);
                 pkt = NULL;
@@ -307,7 +306,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
         } else {
             /* NET_FILTER_DIRECTION_RX */
             if (!handle_secondary_tcp_pkt(s, conn, pkt, &key)) {
-                qemu_net_queue_send(s->incoming_queue, sender, 0,
+                qemu_net_queue_send(s->incoming_queue, sender,
                 (const uint8_t *)pkt->data, pkt->size, NULL);
                 packet_destroy(pkt, NULL);
                 pkt = NULL;
diff --git a/net/filter.c b/net/filter.c
index 3fe88fa43f..14dfb6fa36 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -28,7 +28,6 @@ static inline bool qemu_can_skip_netfilter(NetFilterState *nf)
 ssize_t qemu_netfilter_receive(NetFilterState *nf,
                                NetFilterDirection direction,
                                NetClientState *sender,
-                               unsigned flags,
                                const struct iovec *iov,
                                int iovcnt,
                                NetPacketSent *sent_cb)
@@ -39,7 +38,7 @@ ssize_t qemu_netfilter_receive(NetFilterState *nf,
     if (nf->direction == direction ||
         nf->direction == NET_FILTER_DIRECTION_ALL) {
         return NETFILTER_GET_CLASS(OBJECT(nf))->receive_iov(
-                                   nf, sender, flags, iov, iovcnt, sent_cb);
+                                   nf, sender, iov, iovcnt, sent_cb);
     }
 
     return 0;
@@ -62,7 +61,6 @@ static NetFilterState *netfilter_next(NetFilterState *nf,
 }
 
 ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
-                                    unsigned flags,
                                     const struct iovec *iov,
                                     int iovcnt,
                                     void *opaque)
@@ -96,7 +94,7 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
          * to the sender, so sent_cb shouldn't be called later, just
          * pass NULL to next.
          */
-        ret = qemu_netfilter_receive(next, direction, sender, flags, iov,
+        ret = qemu_netfilter_receive(next, direction, sender, iov,
                                      iovcnt, NULL);
         if (ret) {
             return ret;
@@ -111,7 +109,7 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
      */
     if (sender && sender->peer) {
         qemu_net_queue_send_iov(sender->peer->incoming_queue,
-                                sender, flags, iov, iovcnt, NULL);
+                                sender, iov, iovcnt, NULL);
     }
 
 out:
diff --git a/net/net.c b/net/net.c
index 6d2fa8d40f..9334fd166e 100644
--- a/net/net.c
+++ b/net/net.c
@@ -250,7 +250,6 @@ static void qemu_net_client_destructor(NetClientState *nc)
     g_free(nc);
 }
 static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
-                                       unsigned flags,
                                        const struct iovec *iov,
                                        int iovcnt,
                                        void *opaque);
@@ -604,7 +603,6 @@ int qemu_can_send_packet(NetClientState *sender)
 static ssize_t filter_receive_iov(NetClientState *nc,
                                   NetFilterDirection direction,
                                   NetClientState *sender,
-                                  unsigned flags,
                                   const struct iovec *iov,
                                   int iovcnt,
                                   NetPacketSent *sent_cb)
@@ -614,7 +612,7 @@ static ssize_t filter_receive_iov(NetClientState *nc,
 
     if (direction == NET_FILTER_DIRECTION_TX) {
         QTAILQ_FOREACH(nf, &nc->filters, next) {
-            ret = qemu_netfilter_receive(nf, direction, sender, flags, iov,
+            ret = qemu_netfilter_receive(nf, direction, sender, iov,
                                          iovcnt, sent_cb);
             if (ret) {
                 return ret;
@@ -622,7 +620,7 @@ static ssize_t filter_receive_iov(NetClientState *nc,
         }
     } else {
         QTAILQ_FOREACH_REVERSE(nf, &nc->filters, next) {
-            ret = qemu_netfilter_receive(nf, direction, sender, flags, iov,
+            ret = qemu_netfilter_receive(nf, direction, sender, iov,
                                          iovcnt, sent_cb);
             if (ret) {
                 return ret;
@@ -636,7 +634,6 @@ static ssize_t filter_receive_iov(NetClientState *nc,
 static ssize_t filter_receive(NetClientState *nc,
                               NetFilterDirection direction,
                               NetClientState *sender,
-                              unsigned flags,
                               const uint8_t *data,
                               size_t size,
                               NetPacketSent *sent_cb)
@@ -646,7 +643,7 @@ static ssize_t filter_receive(NetClientState *nc,
         .iov_len = size
     };
 
-    return filter_receive_iov(nc, direction, sender, flags, &iov, 1, sent_cb);
+    return filter_receive_iov(nc, direction, sender, &iov, 1, sent_cb);
 }
 
 void qemu_purge_queued_packets(NetClientState *nc)
@@ -683,10 +680,9 @@ void qemu_flush_queued_packets(NetClientState *nc)
     qemu_flush_or_purge_queued_packets(nc, false);
 }
 
-static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
-                                                 unsigned flags,
-                                                 const uint8_t *buf, int size,
-                                                 NetPacketSent *sent_cb)
+ssize_t qemu_send_packet_async(NetClientState *sender,
+                               const uint8_t *buf, int size,
+                               NetPacketSent *sent_cb)
 {
     NetQueue *queue;
     int ret;
@@ -702,28 +698,20 @@ static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
 
     /* Let filters handle the packet first */
     ret = filter_receive(sender, NET_FILTER_DIRECTION_TX,
-                         sender, flags, buf, size, sent_cb);
+                         sender, buf, size, sent_cb);
     if (ret) {
         return ret;
     }
 
     ret = filter_receive(sender->peer, NET_FILTER_DIRECTION_RX,
-                         sender, flags, buf, size, sent_cb);
+                         sender, buf, size, sent_cb);
     if (ret) {
         return ret;
     }
 
     queue = sender->peer->incoming_queue;
 
-    return qemu_net_queue_send(queue, sender, flags, buf, size, sent_cb);
-}
-
-ssize_t qemu_send_packet_async(NetClientState *sender,
-                               const uint8_t *buf, int size,
-                               NetPacketSent *sent_cb)
-{
-    return qemu_send_packet_async_with_flags(sender, QEMU_NET_PACKET_FLAG_NONE,
-                                             buf, size, sent_cb);
+    return qemu_net_queue_send(queue, sender, buf, size, sent_cb);
 }
 
 ssize_t qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size)
@@ -752,12 +740,17 @@ ssize_t qemu_receive_packet_iov(NetClientState *nc, const struct iovec *iov,
 
 ssize_t qemu_send_packet_raw(NetClientState *nc, const uint8_t *buf, int size)
 {
-    return qemu_send_packet_async_with_flags(nc, QEMU_NET_PACKET_FLAG_RAW,
-                                             buf, size, NULL);
+    struct virtio_net_hdr_v1_hash vnet_hdr = { };
+    struct iovec iov[] = {
+        { .iov_base = &vnet_hdr, .iov_len = nc->vnet_hdr_len },
+        { .iov_base = (void *)buf, .iov_len = size }
+    };
+
+    return qemu_sendv_packet_async(nc, iov, ARRAY_SIZE(iov), NULL);
 }
 
 static ssize_t nc_sendv_compat(NetClientState *nc, const struct iovec *iov,
-                               int iovcnt, unsigned flags)
+                               int iovcnt)
 {
     uint8_t *buf = NULL;
     uint8_t *buffer;
@@ -777,18 +770,13 @@ static ssize_t nc_sendv_compat(NetClientState *nc, const struct iovec *iov,
         offset = iov_to_buf(iov, iovcnt, 0, buf, offset);
     }
 
-    if (flags & QEMU_NET_PACKET_FLAG_RAW && nc->info->receive_raw) {
-        ret = nc->info->receive_raw(nc, buffer, offset);
-    } else {
-        ret = nc->info->receive(nc, buffer, offset);
-    }
+    ret = nc->info->receive(nc, buffer, offset);
 
     g_free(buf);
     return ret;
 }
 
 static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
-                                       unsigned flags,
                                        const struct iovec *iov,
                                        int iovcnt,
                                        void *opaque)
@@ -814,10 +802,10 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
         owned_reentrancy_guard->engaged_in_io = true;
     }
 
-    if (nc->info->receive_iov && !(flags & QEMU_NET_PACKET_FLAG_RAW)) {
+    if (nc->info->receive_iov) {
         ret = nc->info->receive_iov(nc, iov, iovcnt);
     } else {
-        ret = nc_sendv_compat(nc, iov, iovcnt, flags);
+        ret = nc_sendv_compat(nc, iov, iovcnt);
     }
 
     if (owned_reentrancy_guard) {
@@ -849,22 +837,20 @@ ssize_t qemu_sendv_packet_async(NetClientState *sender,
 
     /* Let filters handle the packet first */
     ret = filter_receive_iov(sender, NET_FILTER_DIRECTION_TX, sender,
-                             QEMU_NET_PACKET_FLAG_NONE, iov, iovcnt, sent_cb);
+                             iov, iovcnt, sent_cb);
     if (ret) {
         return ret;
     }
 
     ret = filter_receive_iov(sender->peer, NET_FILTER_DIRECTION_RX, sender,
-                             QEMU_NET_PACKET_FLAG_NONE, iov, iovcnt, sent_cb);
+                             iov, iovcnt, sent_cb);
     if (ret) {
         return ret;
     }
 
     queue = sender->peer->incoming_queue;
 
-    return qemu_net_queue_send_iov(queue, sender,
-                                   QEMU_NET_PACKET_FLAG_NONE,
-                                   iov, iovcnt, sent_cb);
+    return qemu_net_queue_send_iov(queue, sender, iov, iovcnt, sent_cb);
 }
 
 ssize_t
diff --git a/net/queue.c b/net/queue.c
index c872d51df8..70d29d7ac0 100644
--- a/net/queue.c
+++ b/net/queue.c
@@ -43,7 +43,6 @@
 struct NetPacket {
     QTAILQ_ENTRY(NetPacket) entry;
     NetClientState *sender;
-    unsigned flags;
     int size;
     NetPacketSent *sent_cb;
     uint8_t data[];
@@ -92,7 +91,6 @@ void qemu_del_net_queue(NetQueue *queue)
 
 static void qemu_net_queue_append(NetQueue *queue,
                                   NetClientState *sender,
-                                  unsigned flags,
                                   const uint8_t *buf,
                                   size_t size,
                                   NetPacketSent *sent_cb)
@@ -104,7 +102,6 @@ static void qemu_net_queue_append(NetQueue *queue,
     }
     packet = g_malloc(sizeof(NetPacket) + size);
     packet->sender = sender;
-    packet->flags = flags;
     packet->size = size;
     packet->sent_cb = sent_cb;
     memcpy(packet->data, buf, size);
@@ -115,7 +112,6 @@ static void qemu_net_queue_append(NetQueue *queue,
 
 void qemu_net_queue_append_iov(NetQueue *queue,
                                NetClientState *sender,
-                               unsigned flags,
                                const struct iovec *iov,
                                int iovcnt,
                                NetPacketSent *sent_cb)
@@ -134,7 +130,6 @@ void qemu_net_queue_append_iov(NetQueue *queue,
     packet = g_malloc(sizeof(NetPacket) + max_len);
     packet->sender = sender;
     packet->sent_cb = sent_cb;
-    packet->flags = flags;
     packet->size = 0;
 
     for (i = 0; i < iovcnt; i++) {
@@ -150,7 +145,6 @@ void qemu_net_queue_append_iov(NetQueue *queue,
 
 static ssize_t qemu_net_queue_deliver(NetQueue *queue,
                                       NetClientState *sender,
-                                      unsigned flags,
                                       const uint8_t *data,
                                       size_t size)
 {
@@ -161,7 +155,7 @@ static ssize_t qemu_net_queue_deliver(NetQueue *queue,
     };
 
     queue->delivering = 1;
-    ret = queue->deliver(sender, flags, &iov, 1, queue->opaque);
+    ret = queue->deliver(sender, &iov, 1, queue->opaque);
     queue->delivering = 0;
 
     return ret;
@@ -169,14 +163,13 @@ static ssize_t qemu_net_queue_deliver(NetQueue *queue,
 
 static ssize_t qemu_net_queue_deliver_iov(NetQueue *queue,
                                           NetClientState *sender,
-                                          unsigned flags,
                                           const struct iovec *iov,
                                           int iovcnt)
 {
     ssize_t ret = -1;
 
     queue->delivering = 1;
-    ret = queue->deliver(sender, flags, iov, iovcnt, queue->opaque);
+    ret = queue->deliver(sender, iov, iovcnt, queue->opaque);
     queue->delivering = 0;
 
     return ret;
@@ -190,7 +183,7 @@ ssize_t qemu_net_queue_receive(NetQueue *queue,
         return 0;
     }
 
-    return qemu_net_queue_deliver(queue, NULL, 0, data, size);
+    return qemu_net_queue_deliver(queue, NULL, data, size);
 }
 
 ssize_t qemu_net_queue_receive_iov(NetQueue *queue,
@@ -201,12 +194,11 @@ ssize_t qemu_net_queue_receive_iov(NetQueue *queue,
         return 0;
     }
 
-    return qemu_net_queue_deliver_iov(queue, NULL, 0, iov, iovcnt);
+    return qemu_net_queue_deliver_iov(queue, NULL, iov, iovcnt);
 }
 
 ssize_t qemu_net_queue_send(NetQueue *queue,
                             NetClientState *sender,
-                            unsigned flags,
                             const uint8_t *data,
                             size_t size,
                             NetPacketSent *sent_cb)
@@ -214,13 +206,13 @@ ssize_t qemu_net_queue_send(NetQueue *queue,
     ssize_t ret;
 
     if (queue->delivering || !qemu_can_send_packet(sender)) {
-        qemu_net_queue_append(queue, sender, flags, data, size, sent_cb);
+        qemu_net_queue_append(queue, sender, data, size, sent_cb);
         return 0;
     }
 
-    ret = qemu_net_queue_deliver(queue, sender, flags, data, size);
+    ret = qemu_net_queue_deliver(queue, sender, data, size);
     if (ret == 0) {
-        qemu_net_queue_append(queue, sender, flags, data, size, sent_cb);
+        qemu_net_queue_append(queue, sender, data, size, sent_cb);
         return 0;
     }
 
@@ -231,7 +223,6 @@ ssize_t qemu_net_queue_send(NetQueue *queue,
 
 ssize_t qemu_net_queue_send_iov(NetQueue *queue,
                                 NetClientState *sender,
-                                unsigned flags,
                                 const struct iovec *iov,
                                 int iovcnt,
                                 NetPacketSent *sent_cb)
@@ -239,13 +230,13 @@ ssize_t qemu_net_queue_send_iov(NetQueue *queue,
     ssize_t ret;
 
     if (queue->delivering || !qemu_can_send_packet(sender)) {
-        qemu_net_queue_append_iov(queue, sender, flags, iov, iovcnt, sent_cb);
+        qemu_net_queue_append_iov(queue, sender, iov, iovcnt, sent_cb);
         return 0;
     }
 
-    ret = qemu_net_queue_deliver_iov(queue, sender, flags, iov, iovcnt);
+    ret = qemu_net_queue_deliver_iov(queue, sender, iov, iovcnt);
     if (ret == 0) {
-        qemu_net_queue_append_iov(queue, sender, flags, iov, iovcnt, sent_cb);
+        qemu_net_queue_append_iov(queue, sender, iov, iovcnt, sent_cb);
         return 0;
     }
 
@@ -285,7 +276,6 @@ bool qemu_net_queue_flush(NetQueue *queue)
 
         ret = qemu_net_queue_deliver(queue,
                                      packet->sender,
-                                     packet->flags,
                                      packet->data,
                                      packet->size);
         if (ret == 0) {
diff --git a/net/tap.c b/net/tap.c
index 57389cacc3..668d69c0de 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -131,41 +131,6 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
     return tap_write_packet(s, iovp, iovcnt);
 }
 
-static ssize_t tap_receive_raw(NetClientState *nc, const uint8_t *buf, size_t size)
-{
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    struct iovec iov[2];
-    int iovcnt = 0;
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
-
-    if (s->host_vnet_hdr_len) {
-        iov[iovcnt].iov_base = &hdr;
-        iov[iovcnt].iov_len  = s->host_vnet_hdr_len;
-        iovcnt++;
-    }
-
-    iov[iovcnt].iov_base = (char *)buf;
-    iov[iovcnt].iov_len  = size;
-    iovcnt++;
-
-    return tap_write_packet(s, iov, iovcnt);
-}
-
-static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_t size)
-{
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    struct iovec iov[1];
-
-    if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
-        return tap_receive_raw(nc, buf, size);
-    }
-
-    iov[0].iov_base = (char *)buf;
-    iov[0].iov_len  = size;
-
-    return tap_write_packet(s, iov, 1);
-}
-
 #ifndef __sun__
 ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen)
 {
@@ -355,8 +320,6 @@ int tap_get_fd(NetClientState *nc)
 static NetClientInfo net_tap_info = {
     .type = NET_CLIENT_DRIVER_TAP,
     .size = sizeof(TAPState),
-    .receive = tap_receive,
-    .receive_raw = tap_receive_raw,
     .receive_iov = tap_receive_iov,
     .poll = tap_poll,
     .cleanup = tap_cleanup,
diff --git a/replay/replay-net.c b/replay/replay-net.c
index 3b70f71cf1..87e6d68f4e 100644
--- a/replay/replay-net.c
+++ b/replay/replay-net.c
@@ -24,7 +24,6 @@ struct ReplayNetState {
 
 typedef struct NetEvent {
     uint8_t id;
-    uint32_t flags;
     uint8_t *data;
     size_t size;
 } NetEvent;
@@ -50,11 +49,10 @@ void replay_unregister_net(ReplayNetState *rns)
     g_free(rns);
 }
 
-void replay_net_packet_event(ReplayNetState *rns, unsigned flags,
+void replay_net_packet_event(ReplayNetState *rns,
                              const struct iovec *iov, int iovcnt)
 {
     NetEvent *event = g_new(NetEvent, 1);
-    event->flags = flags;
     event->data = g_malloc(iov_size(iov, iovcnt));
     event->size = iov_size(iov, iovcnt);
     event->id = rns->id;
@@ -74,7 +72,7 @@ void replay_event_net_run(void *opaque)
     assert(event->id < network_filters_count);
 
     qemu_netfilter_pass_to_next(network_filters[event->id]->netdev,
-        event->flags, &iov, 1, network_filters[event->id]);
+        &iov, 1, network_filters[event->id]);
 
     g_free(event->data);
     g_free(event);
@@ -85,7 +83,6 @@ void replay_event_net_save(void *opaque)
     NetEvent *event = opaque;
 
     replay_put_byte(event->id);
-    replay_put_dword(event->flags);
     replay_put_array(event->data, event->size);
 }
 
@@ -94,7 +91,6 @@ void *replay_event_net_load(void)
     NetEvent *event = g_new(NetEvent, 1);
 
     event->id = replay_get_byte();
-    event->flags = replay_get_dword();
     replay_get_array_alloc(&event->data, &event->size);
 
     return event;
-- 
2.42.0


