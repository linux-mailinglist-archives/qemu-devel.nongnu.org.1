Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B749580B902
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:31:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCPG-0002mQ-IB; Sun, 10 Dec 2023 00:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCP9-0002Ym-Ur
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:31:04 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCP4-000399-5l
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:31:02 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-58e256505f7so1771712eaf.3
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186256; x=1702791056;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a8QzPgjV+X/mbtVY3d/vPrBHOXZ2PTpofFgfHL329zI=;
 b=T2b981GeZaGHW4v4zmUct5ruucns7wutJczZSkJgNNn7NlKcbWgmoJeQhwJhrF+PGl
 unhxte6cMNd1TeU90lm6LJtcn7b7Awkh840lsJMWu7D/UjowrMW8Y1o51pNygHJ4VkkW
 Ph0lhBqcqVCUXD9iWN7cBf1n+KOVh5u++/BqLKNtfHejYynzcX+X5yaYJKmfKo9sM0Ry
 hVsu+RLc6q4OLMHVmDsAIrDfLCAippN3i4m0qzXYhzp3kS73URjYGcm2dYDWR3NCRdk4
 hkT9TbLzz3sb2SEnlU5xZ04bDkDeHM4l8vidWvi5MPQl7YOVaNXw/0ySCVtgejKZT+Fm
 G5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186256; x=1702791056;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a8QzPgjV+X/mbtVY3d/vPrBHOXZ2PTpofFgfHL329zI=;
 b=n49Sd1yM6iUcy2ts/M+oxUE1cpNZwdOv5gh2hHg5IbCgs7PDrNdICRvxFSlfUutxnB
 VoOmpzBW9v52W/kbQPHHSjjx6ibUE+VBbLvQ3UjY1nIS0pQf5NIZiqKGGPcG6UOs+x8H
 K/JCmSe3gObGeVD6A5hmDGvsn5idUmVjWKQ4wi5hjdsXs0fhqwCEOyI7OhuVu8qyj2uM
 O0jMCUcY+6aNlTe0aHVFyhrTWwxp2jEYdnxPm/1+sivBoOPIIM2oSbiVfAkLwrYmaleM
 oEoDZmdML180/gwf/l63mka/IFOPyP5pGG2xdc87OKXhnhKh7P262dymf44SGohzawFE
 Kcjg==
X-Gm-Message-State: AOJu0YyARcK8ir1MMrrWySrdDS7YkhcMBlpTb69gs7ZWnIQ1bhgVqSU4
 yJxiEhoiZBaDhkzGbW0r7SDc+g==
X-Google-Smtp-Source: AGHT+IE2OWEQELMK4UCL5dKiPm5yuxOQC8RKTRIRkeuLN3oQQau4ex18oyfIwo1pUDL8Q1by+Se4Jg==
X-Received: by 2002:a05:6808:648a:b0:3b8:b6f6:4f6d with SMTP id
 fh10-20020a056808648a00b003b8b6f64f6dmr3143432oib.5.1702186256744; 
 Sat, 09 Dec 2023 21:30:56 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 s7-20020a656447000000b005c693386cb6sm3409251pgv.13.2023.12.09.21.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:30:56 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:51 +0900
Subject: [PATCH v8 13/19] virtio-net: Do not write hashes to peer buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-13-9553ee714d38@daynix.com>
References: <20231210-rss-v8-0-9553ee714d38@daynix.com>
In-Reply-To: <20231210-rss-v8-0-9553ee714d38@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::c34;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc34.google.com
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

The peer buffer is qualified with const and not meant to be modified.
It also prevents enabling VIRTIO_NET_F_HASH_REPORT for peers without
virtio-net header support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index eed5a9bc46..abab503ac1 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1786,16 +1786,9 @@ static uint8_t virtio_net_get_hash_type(bool hasip4,
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
@@ -1826,7 +1819,8 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
                                              n->rss_data.hash_types);
     if (net_hash_type > NetPktRssIpV6UdpEx) {
         if (n->rss_data.populate_hash) {
-            virtio_set_packet_hash(buf, VIRTIO_NET_HASH_REPORT_NONE, 0);
+            hdr->hash_value = VIRTIO_NET_HASH_REPORT_NONE;
+            hdr->hash_report = 0;
         }
         return n->rss_data.redirect ? n->rss_data.default_queue : -1;
     }
@@ -1834,7 +1828,8 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     hash = net_rx_pkt_calc_rss_hash(pkt, net_hash_type, n->rss_data.key);
 
     if (n->rss_data.populate_hash) {
-        virtio_set_packet_hash(buf, reports[net_hash_type], hash);
+        hdr->hash_value = hash;
+        hdr->hash_report = reports[net_hash_type];
     }
 
     if (n->rss_data.redirect) {
@@ -1854,7 +1849,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
     size_t lens[VIRTQUEUE_MAX_SIZE];
     struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
-    struct virtio_net_hdr_mrg_rxbuf mhdr;
+    struct virtio_net_hdr_v1_hash extra_hdr;
     unsigned mhdr_cnt = 0;
     size_t offset, i, guest_offset, j;
     ssize_t err;
@@ -1864,7 +1859,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     }
 
     if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
-        int index = virtio_net_process_rss(nc, buf, size);
+        int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {
             NetClientState *nc2 = qemu_get_subqueue(n->nic, index);
             return virtio_net_receive_rcu(nc2, buf, size, true);
@@ -1924,15 +1919,17 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
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
@@ -1962,10 +1959,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
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
2.43.0


