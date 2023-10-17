Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DFD7CB98E
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbP3-0007PQ-Bq; Tue, 17 Oct 2023 00:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbP1-0007PI-KY
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:09:55 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbOy-00048p-NB
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:09:54 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b3c2607d9bso2769110b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515791; x=1698120591;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IM7j9wG12KtNICZT4CSpMjd0Sd4taix73pSnL6JqzFs=;
 b=kiO4WE9QHcSa7UWMzLs5eepcz3AenbcsuQmjhM1po5K5dlS9iyXcH8Dkju35HhvDTz
 HZc1AMgolq871hJ7gkgBL8I6EwhYSDyyu5H3HThSu/CvWiDE2fUkYmNzOKpNlwAPZBbu
 0smpqifhVkLz3hLQeK9F6FhCA5OauBLI2UGVnixTOEKQadpOwY6dydZJQZ9LliNFMzGD
 CnqroN7tsAFi2BT+XUHfpOXkR2y2hWUNq2b2HsgglpE/7+T9bGdJnl9/lxsnLVMOHYo3
 EDgVTdA79Yf4n8BjwUwg3v8fgdH5hkX2MSVxbU8mOcPGTwqgHjmXfi6d4kmLTJlD8sIh
 gg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515791; x=1698120591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IM7j9wG12KtNICZT4CSpMjd0Sd4taix73pSnL6JqzFs=;
 b=I8ul5EbLgit8xvGppqpJdwtETYqvDxgbYZc4WugZ1qsnaYJw481yQF8c3f7CxCqwg8
 eJ0EuwN3wDxTjVtQ+ihJQ2v5NZDwqyjmhbTHLBIR7TlEBAUJOKP3Ag3mMeBrcAm7J8b2
 0yRmWb1HK0XBjdHh5xtLtYO/GiN6DkVDXkl5KUFhGPf99HK56Ybe09ZHFfQZatoAW/72
 HJgUBINnrkRKXU2dWvW2V/ysD/x1h+fpxclgMQuNQKDcpb0uSe8cn44/uUEHsD6rLUdV
 Ry4BCWZNk4rgd/OMAXm+wl44Fh4q25qIyuV0CXux4AZE6jlV7QdilC6ajpiy9sdA6+VJ
 IRFA==
X-Gm-Message-State: AOJu0YymTw7vD8PmnEOPNAWp0bIMAgvtEpY35YkQ3/+k9IuT493v0jn0
 Ih09rvSvXId2jrMoHHIH2nI9bPHvTNHF+NCdbDUBMQ==
X-Google-Smtp-Source: AGHT+IGLGzyxpnG1iKnuRspoeUK8r8ihlsR8fQd26/cIbnjaEJwOV4DaH0DkNnjSY0p31oSL8KnofQ==
X-Received: by 2002:a05:6a00:22cb:b0:690:c75e:25d7 with SMTP id
 f11-20020a056a0022cb00b00690c75e25d7mr1232174pfj.18.1697515791258; 
 Mon, 16 Oct 2023 21:09:51 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 a6-20020aa78e86000000b0068fbaea118esm359919pfr.45.2023.10.16.21.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:09:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 04/21] net: Remove receive_raw()
Date: Tue, 17 Oct 2023 13:09:10 +0900
Message-ID: <20231017040932.62997-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
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


