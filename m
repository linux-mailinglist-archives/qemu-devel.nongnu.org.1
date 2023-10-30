Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F79B7DB2B7
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:17:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKbc-00021g-H0; Mon, 30 Oct 2023 01:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKba-00021M-W3
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:27 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbZ-0001iy-5W
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:26 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc3388621cso8518515ad.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642863; x=1699247663;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fp6hp9qLMTMpW/+UiOv8/ja0/lbK3yaufnO16OrSK3Y=;
 b=2I55Mo+ZRAFMtzPGhQs8LGv1zu0OjfB9o9CT0YhAeOAJFKCmKR5usdYZqK8oY45Zut
 vhbxOeI2T3NI8X3sPmlDwypcBLnQNtCAvDO5imqAXTjFSynEc6tRp1BgEBYZX8WACoy0
 sfq4epbrK8YKZxK5w43mW0yDJE64UVxsVbl69dYjDVC6TpKTtm4rRjxC/Ob/44evJl7P
 CzYSVKXhJ2TbEYSZOsedAqdElvl/ClgKkS6I3ygplm6kLAk0RF7Ik0qkKDv8L4iQJ8R9
 O4KvMJt+OWabWPd/DOumRDk0CLQlh86QBOLCCkFxMc07utL3APYdKBUqrWhgcusxoExj
 r4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642863; x=1699247663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fp6hp9qLMTMpW/+UiOv8/ja0/lbK3yaufnO16OrSK3Y=;
 b=UGmyVq8De/aRfw2Eq3Dm5L4/BZ/nj+opdCEflAUPZq9QCoSMx5PO9LVJuzsfzXiz0D
 WmeLrEwTjx5V44jsvwKyrCHZ6PLz3IetOg70TAF17jsaCVr6TDBF8sfv0HmjdObvF9Gx
 wtFclkxjKxVOnfrrC2VT00xHwkKYCgcrXau40sZRweRhuE3yW+gggFpf2yu0jdzAyfwV
 uf5wdrRD7074aaNevCn252DzVWyaTtcdCFIcor+RIblKHokeNMK9gvvR3HpfvnzDBoIy
 HKuCnVWDjNbE4BNtsEResHW0QMndX/gwxXTPU2DEavxjiIxctqprQhnS6wvkw52wsJcd
 wx2A==
X-Gm-Message-State: AOJu0YywPLPlN0ALOY1Y8o8TIUt3UMHhRj/enHSHifGpD8ENHbVOyYze
 Acu6bwfy1ZbbZMG7gXcYN3F3yqu7VOUoTYNBhm3foA==
X-Google-Smtp-Source: AGHT+IGx9aO1DZm18+VcEA3Me8RQBUSikhT9zX70mtBGLtkIOc3iDBiOJPPNUpJALSXe3/7r9kf4EA==
X-Received: by 2002:a17:902:dac4:b0:1cc:2be7:c0f2 with SMTP id
 q4-20020a170902dac400b001cc2be7c0f2mr6948283plx.13.1698642863477; 
 Sun, 29 Oct 2023 22:14:23 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 p18-20020a170902a41200b001c5fd2a28d3sm5329303plq.28.2023.10.29.22.14.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:14:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 04/21] net: Remove receive_raw()
Date: Mon, 30 Oct 2023 14:12:25 +0900
Message-ID: <20231030051356.33123-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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
index d98a2b136a..5bc1f82550 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -72,7 +72,6 @@ typedef struct NetClientInfo {
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
index 717d48ce15..ad8ecce5d6 100644
--- a/net/net.c
+++ b/net/net.c
@@ -761,8 +761,13 @@ ssize_t qemu_receive_packet_iov(NetClientState *nc, const struct iovec *iov,
 
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
@@ -786,11 +791,7 @@ static ssize_t nc_sendv_compat(NetClientState *nc, const struct iovec *iov,
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
@@ -823,7 +824,7 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
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
index d94731b2fa..d54e90f184 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -367,7 +367,6 @@ static NetClientInfo net_tap_info = {
     .type = NET_CLIENT_DRIVER_TAP,
     .size = sizeof(TAPState),
     .receive = tap_receive,
-    .receive_raw = tap_receive_raw,
     .receive_iov = tap_receive_iov,
     .poll = tap_poll,
     .cleanup = tap_cleanup,
-- 
2.42.0


