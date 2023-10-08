Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3C37BCC72
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 07:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpMYw-0003Qy-Hm; Sun, 08 Oct 2023 01:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMYs-0003Qj-9O
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:42:44 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMYp-0002hP-Fw
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:42:41 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-69fc829d7b1so667733b3a.1
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 22:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696743758; x=1697348558;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIxazHACH6MI6G7hYxYW2f3e48chXpxklWeO38wFpsw=;
 b=nZD1nyy5/sUI61RwHUMJQCiC0kdD+fPpsehrEwRU9ZwmF/kaz0I4aUoeZRE0AOzAk2
 sYZQm+6YgwE/R9Zc6R6SSV/eghEhWj2Ow1vG+NrwgxkLFZAwlIYHcejcCbUU6srleRvA
 J2yGOPA91MoBJCH8zYfUC0eHYUcp6QioI+3bzMdjDDnyKPXLYBXQ84eEhBemJ7Zz9nHt
 6tb8s3S/9LGQdcf1Xx5kF06cZvn0brSEkRH+gTS3yHVFy5Aushb66xCXfsjKtt+dLDg+
 Gwles69DS0Bus5UJOjbaaGVz3KpWLAZFy+PkzfE5J1voBe8pbtp5JO8V0r6/wwNgUSDH
 RF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696743758; x=1697348558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIxazHACH6MI6G7hYxYW2f3e48chXpxklWeO38wFpsw=;
 b=fvQqLKagmhR8PS+xsYEPS0cvGEDhd++f2W8MJmoCbrLHxYMd06PRzkMl5zTvdxlhuU
 rGnbv9O84MboaIAPXwWy83fSso9KmADTlY+a7YZbqwItTy+ho2FvOCQUIw3EAzXsqvca
 a94f54CKrp7YMhWqY+JftcvGdw/A6sPwuAC/t9Hx+L1/g6i6FojSa+PdLit35CdnUzuh
 uzfaxhy1jpkjrujjhVsXu57qfZFOwFGv4z+g+zyTP8XzMUuOD8f4nMKuKJv0YLeEhAsB
 O8VyZMSzhdNn1QNgw55u/30hwGdDIqHh3Whtw6iQY6S7ictEUL60XR/gnTugW5T5zFgM
 rgMg==
X-Gm-Message-State: AOJu0Yyfabf6poA+QyiIm4QM0w/U4C7BN+wDeEtU2RnFmW6/qHz7MZ9m
 H8Zz3dPzEIASn4oJp9+BwPv8ew==
X-Google-Smtp-Source: AGHT+IGXUSJoZ8/OPm6LHLZQLe2MgKIb3Bo+DiYcwjjyI54n74FmQRmSEg3lbKhBIJRyQwpbbuik9g==
X-Received: by 2002:a05:6a00:158c:b0:690:b7a1:ac51 with SMTP id
 u12-20020a056a00158c00b00690b7a1ac51mr15606992pfk.31.1696743758168; 
 Sat, 07 Oct 2023 22:42:38 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 j19-20020aa783d3000000b00690d255b5a1sm3974566pfn.217.2023.10.07.22.42.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 22:42:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [RFC PATCH 2/4] virtio-net: Offload hashing without eBPF
Date: Sun,  8 Oct 2023 14:42:16 +0900
Message-ID: <20231008054222.146228-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008054222.146228-1-akihiko.odaki@daynix.com>
References: <20231008054222.146228-1-akihiko.odaki@daynix.com>
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

Offloading virtio-net hashing to the client can improve the performance
since the performance can reuse the hash calculated for RSS for hash
reporting as well.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-net.h |   5 +-
 hw/net/virtio-net.c            | 164 +++++++++++++++++++++++++++------
 2 files changed, 142 insertions(+), 27 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5f5dcb4572..deba793ec2 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -138,7 +138,10 @@ typedef struct VirtioNetRssData {
     bool    enabled_software_rss;
     bool    redirect;
     bool    populate_hash;
-    uint32_t hash_types;
+    bool    peer_hash_available;
+    uint32_t runtime_hash_types;
+    uint32_t supported_hash_types;
+    uint32_t peer_hash_types;
     uint8_t key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
     uint16_t indirections_len;
     uint16_t *indirections_table;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3bb4bf136d..3bf1fec2ac 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -158,7 +158,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
                  virtio_host_has_feature(vdev, VIRTIO_NET_F_RSS) ?
                  VIRTIO_NET_RSS_MAX_TABLE_LEN : 1);
     virtio_stl_p(vdev, &netcfg.supported_hash_types,
-                 VIRTIO_NET_RSS_SUPPORTED_HASHES);
+                 n->rss_data.supported_hash_types);
     memcpy(config, &netcfg, n->config_size);
 
     /*
@@ -931,6 +931,10 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         features &= ~(1ULL << VIRTIO_NET_F_MTU);
     }
 
+    if (!virtio_has_feature(features, VIRTIO_F_VERSION_1)) {
+        features &= ~(1ULL << VIRTIO_NET_F_HASH_REPORT);
+    }
+
     virtio_net_set_multiqueue(n,
                               virtio_has_feature(features, VIRTIO_NET_F_RSS) ||
                               virtio_has_feature(features, VIRTIO_NET_F_MQ));
@@ -1224,7 +1228,7 @@ static void rss_data_to_rss_config(struct VirtioNetRssData *data,
 {
     config->redirect = data->redirect;
     config->populate_hash = data->populate_hash;
-    config->hash_types = data->hash_types;
+    config->hash_types = data->runtime_hash_types;
     config->indirections_len = data->indirections_len;
     config->default_queue = data->default_queue;
 }
@@ -1255,18 +1259,62 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
 static void virtio_net_commit_rss_config(VirtIONet *n)
 {
     if (n->rss_data.enabled) {
-        n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
-        if (n->rss_data.populate_hash) {
-            virtio_net_detach_epbf_rss(n);
-        } else if (!virtio_net_attach_epbf_rss(n)) {
-            n->rss_data.enabled_software_rss = true;
+        if (n->rss_data.peer_hash_types &&
+            (n->rss_data.peer_hash_types & n->rss_data.runtime_hash_types) ==
+            n->rss_data.runtime_hash_types) {
+            size_t indirection_table_size =
+                n->rss_data.indirections_len *
+                sizeof(*n->rss_data.indirections_table);
+
+            size_t hash_size = sizeof(NetVnetHash) + indirection_table_size +
+                               sizeof(n->rss_data.key);
+
+            g_autofree struct {
+                NetVnetHash header;
+                uint8_t footer[];
+            } *hash = g_malloc(hash_size);
+
+            hash->header.flags =
+                (n->rss_data.redirect ? NET_VNET_HASH_RSS : 0) |
+                (n->rss_data.populate_hash ? NET_VNET_HASH_REPORT : 0);
+            hash->header.types = n->rss_data.supported_hash_types;
+            hash->header.indirection_table_mask =
+                n->rss_data.indirections_len - 1;
+            hash->header.unclassified_queue = n->rss_data.default_queue;
+
+            memcpy(hash->footer, n->rss_data.indirections_table,
+                   indirection_table_size);
+
+            memcpy(hash->footer + indirection_table_size, n->rss_data.key,
+                   sizeof(n->rss_data.key));
+
+            qemu_set_vnet_hash(qemu_get_queue(n->nic)->peer, hash);
+            n->rss_data.enabled_software_rss = false;
+        } else {
+            if (n->rss_data.peer_hash_types) {
+                NetVnetHash hash = { .flags = 0 };
+                qemu_set_vnet_hash(qemu_get_queue(n->nic)->peer, &hash);
+            }
+
+            n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
+            if (n->rss_data.populate_hash) {
+                virtio_net_detach_epbf_rss(n);
+            } else if (!virtio_net_attach_epbf_rss(n)) {
+                n->rss_data.enabled_software_rss = true;
+            }
         }
 
-        trace_virtio_net_rss_enable(n->rss_data.hash_types,
+        trace_virtio_net_rss_enable(n->rss_data.runtime_hash_types,
                                     n->rss_data.indirections_len,
                                     sizeof(n->rss_data.key));
     } else {
-        virtio_net_detach_epbf_rss(n);
+        if (n->rss_data.peer_hash_types) {
+            NetVnetHash hash = { .flags = 0 };
+            qemu_set_vnet_hash(qemu_get_queue(n->nic)->peer, &hash);
+        } else {
+            virtio_net_detach_epbf_rss(n);
+        }
+
         trace_virtio_net_rss_disable();
     }
 }
@@ -1297,6 +1345,54 @@ static void virtio_net_unload_ebpf(VirtIONet *n)
     ebpf_rss_unload(&n->ebpf_rss);
 }
 
+static bool virtio_net_commit_rss_host_config(VirtIONet *n, Error **errp)
+{
+    bool hash_report = virtio_has_feature(n->host_features, VIRTIO_NET_F_HASH_REPORT);
+    bool rss = virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS);
+    bool peer_hash_available = n->rss_data.peer_hash_available;
+    uint32_t supported_hash_types = n->rss_data.supported_hash_types;
+    uint32_t peer_hash_types = n->rss_data.peer_hash_types;
+
+    if (peer_hash_available &&
+        (supported_hash_types & peer_hash_types) == supported_hash_types) {
+        return true;
+    }
+
+    if ((!rss || ebpf_rss_is_loaded(&n->ebpf_rss) || virtio_net_load_ebpf(n)) &&
+        !hash_report) {
+        return true;
+    }
+
+    if (!get_vhost_net(qemu_get_queue(n->nic)->peer)) {
+        if (rss) {
+            warn_report_once("Can't offload RSS - fallback to software RSS");
+        }
+
+        return true;
+    }
+
+    error_setg(errp, "vhost cannot fulfill hash feature requirements");
+    return false;
+}
+
+static bool virtio_net_configure_rss_host(VirtIONet *n, Error **errp)
+{
+    NetVnetHashCap cap;
+
+    if (qemu_get_vnet_hash_cap(qemu_get_queue(n->nic)->peer, &cap) &&
+        cap.max_indirection_table_length >= VIRTIO_NET_RSS_MAX_TABLE_LEN) {
+        n->rss_data.peer_hash_available = true;
+        n->rss_data.supported_hash_types = cap.types;
+        n->rss_data.peer_hash_types = cap.types;
+
+        return true;
+    }
+
+    n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
+
+    return virtio_net_commit_rss_host_config(n, errp);
+}
+
 static uint16_t virtio_net_handle_rss(VirtIONet *n,
                                       struct iovec *iov,
                                       unsigned int iov_cnt,
@@ -1328,7 +1424,7 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         err_value = (uint32_t)s;
         goto error;
     }
-    n->rss_data.hash_types = virtio_ldl_p(vdev, &cfg.hash_types);
+    n->rss_data.runtime_hash_types = virtio_ldl_p(vdev, &cfg.hash_types);
     n->rss_data.indirections_len =
         virtio_lduw_p(vdev, &cfg.indirection_table_mask);
     n->rss_data.indirections_len++;
@@ -1391,12 +1487,12 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         err_value = temp.b;
         goto error;
     }
-    if (!temp.b && n->rss_data.hash_types) {
+    if (!temp.b && n->rss_data.runtime_hash_types) {
         err_msg = "No key provided";
         err_value = 0;
         goto error;
     }
-    if (!temp.b && !n->rss_data.hash_types) {
+    if (!temp.b && !n->rss_data.runtime_hash_types) {
         virtio_net_disable_rss(n);
         return queue_pairs;
     }
@@ -1798,7 +1894,7 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     net_rx_pkt_set_protocols(pkt, &iov, 1, n->host_hdr_len);
     net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
     net_hash_type = virtio_net_get_hash_type(hasip4, hasip6, l4hdr_proto,
-                                             n->rss_data.hash_types);
+                                             n->rss_data.runtime_hash_types);
     if (net_hash_type > NetPktRssIpV6UdpEx) {
         if (n->rss_data.populate_hash) {
             virtio_set_packet_hash(buf, VIRTIO_NET_HASH_REPORT_NONE, 0);
@@ -1904,7 +2000,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
             }
 
             receive_header(n, sg, elem->in_num, buf, size);
-            if (n->rss_data.populate_hash) {
+            if (n->rss_data.populate_hash && n->rss_data.enabled_software_rss) {
                 offset = sizeof(mhdr);
                 iov_from_buf(sg, elem->in_num, offset,
                              buf + offset, n->host_hdr_len - sizeof(mhdr));
@@ -2952,6 +3048,7 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     int i, link_down;
 
     trace_virtio_net_post_load_device();
+
     virtio_net_set_mrg_rx_bufs(n, n->mergeable_rx_bufs,
                                virtio_vdev_has_feature(vdev,
                                                        VIRTIO_F_VERSION_1),
@@ -3183,21 +3280,43 @@ static const VMStateDescription vmstate_virtio_net_has_vnet = {
     },
 };
 
+static int virtio_net_rss_post_load(void *opaque, int version_id)
+{
+    VirtIONet *n = VIRTIO_NET(opaque);
+    Error *err;
+
+    if (version_id == 1) {
+        n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
+    }
+
+    if (!virtio_net_commit_rss_host_config(n, &err)) {
+        error_report_err(err);
+        return -ENOTSUP;
+    }
+
+    return 0;
+}
+
 static bool virtio_net_rss_needed(void *opaque)
 {
-    return VIRTIO_NET(opaque)->rss_data.enabled;
+    VirtIONet *n = VIRTIO_NET(opaque);
+
+    return virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) ||
+           virtio_has_feature(n->host_features, VIRTIO_NET_F_HASH_REPORT);
 }
 
 static const VMStateDescription vmstate_virtio_net_rss = {
     .name      = "virtio-net-device/rss",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
+    .post_load = virtio_net_rss_post_load,
     .needed = virtio_net_rss_needed,
     .fields = (VMStateField[]) {
         VMSTATE_BOOL(rss_data.enabled, VirtIONet),
         VMSTATE_BOOL(rss_data.redirect, VirtIONet),
         VMSTATE_BOOL(rss_data.populate_hash, VirtIONet),
-        VMSTATE_UINT32(rss_data.hash_types, VirtIONet),
+        VMSTATE_UINT32(rss_data.runtime_hash_types, VirtIONet),
+        VMSTATE_UINT32_V(rss_data.supported_hash_types, VirtIONet, 2),
         VMSTATE_UINT16(rss_data.indirections_len, VirtIONet),
         VMSTATE_UINT16(rss_data.default_queue, VirtIONet),
         VMSTATE_UINT8_ARRAY(rss_data.key, VirtIONet,
@@ -3720,15 +3839,8 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
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
+    if (!virtio_net_configure_rss_host(n, errp)) {
+        virtio_net_device_unrealize(dev);
     }
 }
 
-- 
2.42.0


