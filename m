Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 313747C994F
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:04:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1iG-0001Kq-GO; Sun, 15 Oct 2023 10:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1iF-0001KP-67
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:23 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1iD-0007i7-9F
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:22 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5ab2cb900fcso1077852a12.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378599; x=1697983399;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IM7j9wG12KtNICZT4CSpMjd0Sd4taix73pSnL6JqzFs=;
 b=TFe1XRN5oLqCPTn8C6OVFuZdroVPkZBp3LExcgGT9WbaUNR+Jyk2ZZ8y2gfQPTqD/F
 DkpVsaW5bqq0NoBtX+0RcijAkdwonfBkLcICFxKps74jMFVg9oeIJ/wMX7SlG2J1PR4e
 okwOrSusXdGVo55sSVLCqmd3n9ZUn//X+h2ntOgwSsqIFNq23T7+kyZSOmkUwBPeKKyH
 B8rW5k6bS6gy1bbjQ7eBDx2OA3DUyXaLYSHWhNwgsAf6da8wgL1WXMaZtQgGDtnJ702C
 SI8Xd0BNMjWaA2SHR2m+7mkeblwxNVKddgn27txK+jZviv43H0Dma7IbfjBdA2wQXXhy
 vMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378599; x=1697983399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IM7j9wG12KtNICZT4CSpMjd0Sd4taix73pSnL6JqzFs=;
 b=ONS0GyrBHfNcksVYTaWeDrL/XQJarKN91635M+vdJ3hDcrTPJF6j8T8NYCoLVT1ByW
 1dYYmlGfKdbMMJDcAVMwM3rhjye1OTMQBiA1aKEhvDgzhUpTYKN2oSRgAebNDG5pRuby
 SKnbyHOVltCuCejRtu6p7A6hce4VxrB0UU1eidMKNghdJvJgcZtmzdPGjOcuCw250Hpd
 UezNh19DZ7IfDeTcPiD9ssDG1U95Z2Dta5mHaeo7kg6L3cKKLc7L3gMZKgyPGNoZ8Mil
 VpBk/pQMkl9C4SPoxZfvlrTl7K5zQTSWZQPY+bff2kjQCd4Amj0a94gtBusgZYh4I/V2
 YhGQ==
X-Gm-Message-State: AOJu0YzyKCdurNilfP+JEmWnyZTVN1kA9PfJRIHfhR9Wk2O//3mAi73b
 wPvRZqRZYtz4FuzrOSj6VzyGbZiLiaFSntk23DbLng==
X-Google-Smtp-Source: AGHT+IEYTt3mpb2lDCMUDDBxLQOIk+8V/9C+0iMo/d7o2dTv6yE0zvkUB+2NGEZ/AfOfG47SWi66bQ==
X-Received: by 2002:a17:90b:1b4b:b0:27d:3290:dee3 with SMTP id
 nv11-20020a17090b1b4b00b0027d3290dee3mr5256057pjb.2.1697378599687; 
 Sun, 15 Oct 2023 07:03:19 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 ep20-20020a17090ae65400b00274bbfc34c8sm3043100pjb.16.2023.10.15.07.03.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:03:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 04/20] net: Remove receive_raw()
Date: Sun, 15 Oct 2023 23:02:36 +0900
Message-ID: <20231015140259.259434-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
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

While netmap implements virtio-net header, it does not implement
receive_raw(). Instead of implementing receive_raw for netmap, add
virtio-net headers in the common code and use receive_iov()/receive()
instead. This also fixes the buffer size for the virtio-net header.

Fixes: fbbdbddec0 ("tap: allow extended virtio header with hash info")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/net.h   |  1 -
 include/net/queue.h |  1 -
 net/net.c           | 17 +++++++++--------
 net/queue.c         | 30 ++++++++++--------------------
 net/tap.c           |  1 -
 5 files changed, 19 insertions(+), 31 deletions(-)

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
index 9f2f289d77..7a43863be2 100644
--- a/include/net/queue.h
+++ b/include/net/queue.h
@@ -31,7 +31,6 @@ typedef struct NetQueue NetQueue;
 typedef void (NetPacketSent) (NetClientState *sender, ssize_t ret);
 
 #define QEMU_NET_PACKET_FLAG_NONE  0
-#define QEMU_NET_PACKET_FLAG_RAW  (1<<0)
 
 /* Returns:
  *   >0 - success
diff --git a/net/net.c b/net/net.c
index 6d2fa8d40f..2d94d23c07 100644
--- a/net/net.c
+++ b/net/net.c
@@ -752,8 +752,13 @@ ssize_t qemu_receive_packet_iov(NetClientState *nc, const struct iovec *iov,
 
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
@@ -777,11 +782,7 @@ static ssize_t nc_sendv_compat(NetClientState *nc, const struct iovec *iov,
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
@@ -814,7 +815,7 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
         owned_reentrancy_guard->engaged_in_io = true;
     }
 
-    if (nc->info->receive_iov && !(flags & QEMU_NET_PACKET_FLAG_RAW)) {
+    if (nc->info->receive_iov) {
         ret = nc->info->receive_iov(nc, iov, iovcnt);
     } else {
         ret = nc_sendv_compat(nc, iov, iovcnt, flags);
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
index 57389cacc3..087b2d3bc6 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -356,7 +356,6 @@ static NetClientInfo net_tap_info = {
     .type = NET_CLIENT_DRIVER_TAP,
     .size = sizeof(TAPState),
     .receive = tap_receive,
-    .receive_raw = tap_receive_raw,
     .receive_iov = tap_receive_iov,
     .poll = tap_poll,
     .cleanup = tap_cleanup,
-- 
2.42.0


