Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1AA7CB996
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:11:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbPc-0007h9-LL; Tue, 17 Oct 2023 00:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPZ-0007gu-HO
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:29 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPX-0004Qb-QD
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:29 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6bd04558784so3729508a34.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515825; x=1698120625;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h70bh3tp2/gY6SAz+oI7ADTlJnpghhVAo25pFIbxkxs=;
 b=es2z5ZKdZN02sGj9PIcBrK/a6vamWUR/1Q6tqADMob6Brmtdi85qCVRxNLN/NCaDcX
 Bb7duGesqycAtpcRy0pJAgnsHjEzFp9uyWH/8K5dXF3tK10EtvDYGBNILf0fHj3CAZOT
 EwUmlPPyyBcbbq9itXXg7JsC8cY6M8UR9KqBHIKFcHy+jk3Os0+2+nhC1ECes2z3TX1q
 B8XWHTcd242f5KKWn6spZHJ6abcrXjy1QI76xBgPq+zpRniEZRfMzwzVZ0Fz1bnuaZO8
 qI09AlchsgPUrEhUZCv4DEkAlNmFcLujHfXf3kaOGVziXZGJfXrhWlPvI4xVBvGuusko
 51VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515825; x=1698120625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h70bh3tp2/gY6SAz+oI7ADTlJnpghhVAo25pFIbxkxs=;
 b=AAFw/FKOClP2AwE0uldEMgPyNUCmwVb+rhxix/Zv/kikMmbGp9oTC8tQCcaalrAx8/
 YmP8yoKxFBhj6keY1juddbcueUR2PcXz/f4Lka05JAhLzcHHcHsY/2NL5n4TXGpXk8w7
 w9J5TdQIYaIv5DKpqD6VkgjsPilZNl43eGFT6nE5qp3EaP8Kx9RHAXwWVwqWrHNwqCk6
 CysgsCt9yU1XDIC4wwgV1G9cnKCc8Zzgk7Z8HK8fNyF36oybaOyi6xXMYYepygheF/wh
 OPTCDpV9lkY+cwqo1mTEqo0tkOhqIFWfNXglPX0L1eApUxyreE0WgqArb5ZgsH9+esZz
 fPvg==
X-Gm-Message-State: AOJu0Yxxg0IBy0cf/VfTm/rsaWG+LQA5lGHiLOIAXjQ8TA8aB7+/btb6
 ffhAiUD0zpr98gdpgBi13FDn3rnF5myIsFX6+M1Ngw==
X-Google-Smtp-Source: AGHT+IEjKI2c4QgSfMzL3IIfNCi3CSFiw5jqtIxqcuzFs3uQt/gj1rL2BxZU9k+LhhyL9KHBYlS5Mg==
X-Received: by 2002:a05:6808:d0:b0:3a9:9bb4:485c with SMTP id
 t16-20020a05680800d000b003a99bb4485cmr1350531oic.8.1697515825755; 
 Mon, 16 Oct 2023 21:10:25 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 k17-20020a6568d1000000b0050f85ef50d1sm338432pgt.26.2023.10.16.21.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:10:25 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 14/21] virtio-net: Do not write hashes to peer buffer
Date: Tue, 17 Oct 2023 13:09:20 +0900
Message-ID: <20231017040932.62997-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x332.google.com
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

The peer buffer is qualified with const and not meant to be modified.
It also prevents enabling VIRTIO_NET_F_HASH_REPORT for peers without
virtio-net header support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 20df40442d..c6a92ba3db 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1762,16 +1762,9 @@ static uint8_t virtio_net_get_hash_type(bool hasip4,
     return 0xff;
 }
 
-static void virtio_set_packet_hash(const uint8_t *buf, uint8_t report,
-                                   uint32_t hash)
-{
-    struct virtio_net_hdr_v1_hash *hdr = (void *)buf;
-    hdr->hash_value = hash;
-    hdr->hash_report = report;
-}
-
 static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
-                                  size_t size)
+                                  size_t size,
+                                  struct virtio_net_hdr_v1_hash *hdr)
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
     unsigned int index = nc->queue_index, new_index = index;
@@ -1802,7 +1795,8 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
                                              n->rss_data.hash_types);
     if (net_hash_type > NetPktRssIpV6UdpEx) {
         if (n->rss_data.populate_hash) {
-            virtio_set_packet_hash(buf, VIRTIO_NET_HASH_REPORT_NONE, 0);
+            hdr->hash_value = VIRTIO_NET_HASH_REPORT_NONE;
+            hdr->hash_report = 0;
         }
         return n->rss_data.redirect ? n->rss_data.default_queue : -1;
     }
@@ -1810,7 +1804,8 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     hash = net_rx_pkt_calc_rss_hash(pkt, net_hash_type, n->rss_data.key);
 
     if (n->rss_data.populate_hash) {
-        virtio_set_packet_hash(buf, reports[net_hash_type], hash);
+        hdr->hash_value = hash;
+        hdr->hash_report = reports[net_hash_type];
     }
 
     if (n->rss_data.redirect) {
@@ -1830,7 +1825,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
     size_t lens[VIRTQUEUE_MAX_SIZE];
     struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
-    struct virtio_net_hdr_mrg_rxbuf mhdr;
+    struct virtio_net_hdr_v1_hash extra_hdr;
     unsigned mhdr_cnt = 0;
     size_t offset, i, guest_offset, j;
     ssize_t err;
@@ -1840,7 +1835,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     }
 
     if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
-        int index = virtio_net_process_rss(nc, buf, size);
+        int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {
             NetClientState *nc2 = qemu_get_subqueue(n->nic, index);
             return virtio_net_receive_rcu(nc2, buf, size, true);
@@ -1900,15 +1895,17 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
             if (n->mergeable_rx_bufs) {
                 mhdr_cnt = iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
                                     sg, elem->in_num,
-                                    offsetof(typeof(mhdr), num_buffers),
-                                    sizeof(mhdr.num_buffers));
+                                    offsetof(typeof(extra_hdr), hdr.num_buffers),
+                                    sizeof(extra_hdr.hdr.num_buffers));
             }
 
             receive_header(n, sg, elem->in_num, buf, size);
             if (n->rss_data.populate_hash) {
-                offset = sizeof(mhdr);
+                offset = offsetof(typeof(extra_hdr), hash_value);
                 iov_from_buf(sg, elem->in_num, offset,
-                             buf + offset, n->host_hdr_len - sizeof(mhdr));
+                             (char *)&extra_hdr + offset,
+                             sizeof(extra_hdr.hash_value) +
+                             sizeof(extra_hdr.hash_report));
             }
             offset = n->host_hdr_len;
             total += n->guest_hdr_len;
@@ -1938,10 +1935,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     }
 
     if (mhdr_cnt) {
-        virtio_stw_p(vdev, &mhdr.num_buffers, i);
+        virtio_stw_p(vdev, &extra_hdr.hdr.num_buffers, i);
         iov_from_buf(mhdr_sg, mhdr_cnt,
                      0,
-                     &mhdr.num_buffers, sizeof mhdr.num_buffers);
+                     &extra_hdr.hdr.num_buffers,
+                     sizeof extra_hdr.hdr.num_buffers);
     }
 
     for (j = 0; j < i; j++) {
-- 
2.42.0


