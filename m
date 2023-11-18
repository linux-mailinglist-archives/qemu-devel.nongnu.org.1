Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C6F7EFEBB
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:28:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4Hbb-0007ab-0G; Sat, 18 Nov 2023 04:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HbY-0007LD-MG
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:27:08 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HbV-0003l8-QW
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:27:08 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b5cac99cfdso2592193b3a.2
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299622; x=1700904422;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RxmJHRBMcOhAqu3Z+ygyMm15VcZ4mC+nMFxdTKA9hPU=;
 b=jUVduotGbaFaicvbHsPnPn59uDqAlNDwHoymC4w6BKTbMzFNyB8XsXwUY3/nzYaEAD
 URewJ0D9LXtp95YKspm7J6hDtIeUIfl025MIibhqKgzSKJc5Y/u3fLoxGTGt1JXcSDJy
 wh8BDbdICpZFsjt2uXTfliPh3A+G87Rxk1UPeF7x/pSXy8IpM85EVrICoIoik0/rRCsb
 1FR+wqE5R5P0oUT6A0kIutHaqX/2dbZUX/sgeAij8cTCQwdHNWeiD2xIi90oN9BDPrlC
 C1vDY87P/A1au+Fq/vrR+8d8eRyj8okNLirFA3BWnH4ultnEyJP/f9U1M0ugtR3GmRb5
 5Elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299622; x=1700904422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RxmJHRBMcOhAqu3Z+ygyMm15VcZ4mC+nMFxdTKA9hPU=;
 b=USsXvicZBf74ZvWrPfNdkbcq97bXgoVrQIQW6GPrjLaUdjV5S2wBZJ77h9LJgegaSz
 FbrDjDmAB/brtM+lVvkv8frAUPLksNHNngaxehWpafeBkYXE/n7vFxxA5uQVL4N5XwUw
 2E/MedVZXRAWZgLEHsBNoXt+jAAE1RgxOKCbEQML3Luqmuj3TCfm9Lf2pPY5tcvp4iwo
 JBibDjhWQlVnUvXbssE8sd7W70oe2kGfo28i2dF3EpnQhDmEG7xT9gw5pnMRmPjU5pKy
 yEsGk/4gOYxBmrugYVgeLARXBzsBCD5PIBC1NZU7qIU/us1rrZnUDEzuqDYJFli1fH4m
 KbEg==
X-Gm-Message-State: AOJu0Yzk552NcPhLqBYaz5GieUpP8vapm2+RysN9LGVol/Mhlhcdw3qi
 JuLKPdm3R5ykbb/m4FEsyOiIai2wt7OUE/gzmes=
X-Google-Smtp-Source: AGHT+IEDWXgl1Ex7e5mI/dOjAZKBe5I2ZGWd3m79h48eeWK0a3bvTuRRjfdK2a3pVjqpGYXe28k5yQ==
X-Received: by 2002:a05:6a00:3015:b0:6cb:4bfb:23e1 with SMTP id
 ay21-20020a056a00301500b006cb4bfb23e1mr1653764pfb.23.1700299622694; 
 Sat, 18 Nov 2023 01:27:02 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 i23-20020aa787d7000000b006c69bbf03e2sm2644408pfo.192.2023.11.18.01.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:27:02 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RESEND v7 13/19] virtio-net: Do not write hashes to peer buffer
Date: Sat, 18 Nov 2023 18:25:53 +0900
Message-ID: <20231118092601.7132-14-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118092601.7132-1-akihiko.odaki@daynix.com>
References: <20231118092601.7132-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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
2.42.1


