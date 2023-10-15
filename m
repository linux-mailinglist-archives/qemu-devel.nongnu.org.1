Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A63557C9994
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:29:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs26J-0004FA-Bl; Sun, 15 Oct 2023 10:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs26G-0004Ew-LY
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:28:12 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs26E-0003Jb-Vw
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:28:12 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-27d104fa285so2935347a91.2
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697380089; x=1697984889;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5B6D6s0+oKXYblkLpvR/u04mFbhIWckspGCNETFNSvk=;
 b=1aWLDH3w9cgu8J2UDagkit+tHMyOmXCmA2tbVjKT7HOBpOjT9ptgk+gNxqJsBlHXuL
 J2Y15/NXYRv9hNpXzsYJWnW7XqDvsbTNtQJHlfwJYn3Y13vguUh1iHFAkANSfyUFuPV+
 6jSgALDgzvJGsbz77jSulfAZi6RvY1fekjdKwaUOEpY+jn18DsvIzvItU1xcIopzSIV+
 /v78sr637KZrzGWvXrU3RuRc0O5g6Yl4N3Dkm+6oth0ttm/FSCiooccbbuFM6A6JBrvu
 3AO8Aj+6WdSNqHjS0dpIYMDStq3JF+IHmmT1QNvo0Us467yGnPwxY/Ol60yLNqbqDJQC
 Q/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697380089; x=1697984889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5B6D6s0+oKXYblkLpvR/u04mFbhIWckspGCNETFNSvk=;
 b=EHPmHf48W0tgy+G3h/da6pmqYvK8ohuhkVRCTd88CrVApPKrRmIcEDVFUXljw75JkX
 20OWcHw9gRRkkrABwNcGrIxeWItpSLU4tPbX6w14CZSkhJpkTQETOP4UObBkkKpOrrOj
 wU0J/moqZuJGTQBeM7/G3Z/CyshQxjoRc7NPGhcEgdg5jwP3HMzzeR2RTUSGwx/FK+n0
 tct2bmc2zJMe8qjzLkgJQFb/lcwf48ljGZHS8WO9D47ZF/SW1npOdCk+HLpM/8bJCDLX
 FRsKml0gui3VSV+t+6Flo4FmDxmeDS7L2us+ldZ+4k03PmNH2XDiY9dHiFQeFU25nW9B
 hHGA==
X-Gm-Message-State: AOJu0Yw4B3xd+DEkmOukqxNCHvO41xyfx2sh7a6f403yxVPjDZZbqahO
 TKJB2zmR+IXb8JBpcKrA8fJfaQfZY6fukE+a840S0Q==
X-Google-Smtp-Source: AGHT+IF1PF3RnTjJ45uV567fKSkPaTdl3HFMfuT3gfdtWG1vRADlD7Lvv4tSBJ/14csgPMMsQ9ZJhA==
X-Received: by 2002:a17:90a:1c7:b0:27d:4b6e:b405 with SMTP id
 7-20020a17090a01c700b0027d4b6eb405mr4955611pjd.33.1697380089656; 
 Sun, 15 Oct 2023 07:28:09 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 a29-20020a63705d000000b0058958ea2aaesm6361272pgn.83.2023.10.15.07.28.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:28:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH v2 2/3] virtio-net: Use vnet_hash BPF program
Date: Sun, 15 Oct 2023 23:27:44 +0900
Message-ID: <20231015142755.261808-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015142755.261808-1-akihiko.odaki@daynix.com>
References: <20231015142755.261808-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
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

The vnet_hash BPF program is capable of hash reporting.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 62 ++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 8865825362..b9d01af39d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1254,8 +1254,9 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
 static void virtio_net_commit_rss_config(VirtIONet *n)
 {
     if (n->rss_data.enabled) {
-        n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
-        if (n->rss_data.populate_hash) {
+        n->rss_data.enabled_software_rss = n->rss_data.populate_hash &&
+                                           !n->ebpf_rss.hash_report;
+        if (n->rss_data.enabled_software_rss) {
             virtio_net_detach_epbf_rss(n);
         } else if (!virtio_net_attach_epbf_rss(n)) {
             n->rss_data.enabled_software_rss = true;
@@ -1280,14 +1281,42 @@ static void virtio_net_disable_rss(VirtIONet *n)
     virtio_net_commit_rss_config(n);
 }
 
-static bool virtio_net_load_ebpf(VirtIONet *n)
+static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
 {
-    if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        /* backend does't support steering ebpf */
-        return false;
+    bool rss = virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS);
+    bool hash_report = virtio_has_feature(n->host_features, VIRTIO_NET_F_HASH_REPORT);
+    bool attachable;
+
+    if (!rss && !hash_report) {
+        return true;
     }
 
-    return ebpf_rss_load(&n->ebpf_rss);
+    attachable = virtio_net_attach_ebpf_to_backend(n->nic, -1);
+
+    if (hash_report) {
+        if (attachable && ebpf_rss_hash_report_load(&n->ebpf_rss)) {
+            return true;
+        }
+
+        if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
+            error_setg(errp, "Can't report hashes with eBPF for vhost");
+            return false;
+        }
+    }
+
+    if (rss) {
+        bool loaded = attachable && ebpf_rss_load(&n->ebpf_rss);
+        if (!loaded && get_vhost_net(qemu_get_queue(n->nic)->peer)) {
+            error_setg(errp, "Can't load eBPF RSS for vhost");
+            return false;
+        }
+
+        if (hash_report || !loaded) {
+            warn_report_once("Can't use eBPF RSS - fallback to software RSS");
+        }
+    }
+
+    return true;
 }
 
 static void virtio_net_unload_ebpf(VirtIONet *n)
@@ -1639,7 +1668,7 @@ static void receive_header(VirtIONet *n, const struct iovec *iov, int iov_cnt,
         if (n->needs_vnet_hdr_swap) {
             virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
         }
-        iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hdr));
+        iov_from_buf(iov, iov_cnt, 0, buf, n->host_hdr_len);
     } else {
         struct virtio_net_hdr hdr = {
             .flags = 0,
@@ -1903,7 +1932,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
             }
 
             receive_header(n, sg, elem->in_num, buf, size);
-            if (n->rss_data.populate_hash) {
+            if (n->rss_data.enabled_software_rss && n->rss_data.populate_hash) {
                 offset = sizeof(mhdr);
                 iov_from_buf(sg, elem->in_num, offset,
                              buf + offset, n->host_hdr_len - sizeof(mhdr));
@@ -3507,9 +3536,7 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     VirtIONet *n = VIRTIO_NET(dev);
     int i, max_queue_pairs;
 
-    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_unload_ebpf(n);
-    }
+    virtio_net_unload_ebpf(n);
 
     /* This will stop vhost backend if appropriate. */
     virtio_net_set_status(vdev, 0);
@@ -3716,15 +3743,8 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     net_rx_pkt_init(&n->rx_pkt);
 
-    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
-        !virtio_net_load_ebpf(n)) {
-        if (get_vhost_net(nc->peer)) {
-            error_setg(errp, "Can't load eBPF RSS for vhost");
-            virtio_net_device_unrealize(dev);
-            return;
-        }
-
-        warn_report_once("Can't load eBPF RSS - fallback to software RSS");
+    if (!virtio_net_load_ebpf(n, errp)) {
+        virtio_net_device_unrealize(dev);
     }
 }
 
-- 
2.42.0


