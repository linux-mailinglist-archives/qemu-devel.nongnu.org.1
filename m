Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 063217BF127
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 05:00:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq2yS-00047K-R0; Mon, 09 Oct 2023 22:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq2yR-00047B-Ii
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 22:59:55 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq2yP-0007xV-Ti
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 22:59:55 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so3417756a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 19:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696906790; x=1697511590;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9XCCtGoA5l5bdW6uetTj/eGIjTzGN0RtdgyGLy36eM=;
 b=Hi2dnA9Rxac+V6aOA2LZJfo2Bw9BPVZ1p9LerejojDbqlCRCotrt59Sp/l2YC8uye9
 Ikq25YhKBKR/EuNgnb+UpG8XKTWpru7Y8zob2XnOzLRMyIFjUR93tIVuXeD+Wx5tXDkj
 fSDvU0k4eyMGOR7JikYn9pFcxHjCkfYbDVuXw/Njv5It9yB/H5JotrGSj26CHjWRtrzn
 VqpX3W8n9SwcmLFAHNSFnyvliokXVRQAQIHpVXDW4dms+//x06fEwD35snJEjXwrzARD
 p1oSDje0ugycplRfbpU63foyhjIX14SNZa74vzPADRIBMFHPdp4Hwu82C8yTSDQq0/wA
 3Upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696906790; x=1697511590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9XCCtGoA5l5bdW6uetTj/eGIjTzGN0RtdgyGLy36eM=;
 b=XUilT81eYh4SembP94LuHGLLpYXGFcChSq5mfAgNjXfwYqim/HU5cO5II5CZ9N7XKb
 EeaH7/FycOTkoytQiKtl8+M6I/HH5TT4WrRQhWG57MgQJ3VTXV216oQh0+fAZX0N1lLg
 z38V5B4O4HzENlMhtMMqNB8flJc42C0OkY5hM2NOA7IpX8ILgURFttoBQykNMuKjXjuI
 WljI2y/0b7l4YyF77Bs2JX5ah3SNSiFSCdhUcTZBwzhPqdqlwVo3zwZSDjhoJiNM4yJe
 4zRLZeDRlunX6weaQhfEXqRXUH1cXnIOx/GBkXrypN1yHRwPCZVm+yHPSwHNgdCpCpaz
 TjKw==
X-Gm-Message-State: AOJu0YzIRyyHSYVoGLfTCtywluR4P8f+mX/XK3GYegoROQfxtZqBBXuk
 eH4WQtqlQqPG/lNV2yIv+fnpAtpnvL/aNV0AIUY7KA==
X-Google-Smtp-Source: AGHT+IFj9YpDwORIIyD6S1U3P6SQ/pUZaY3jmWsxp6SLSoo4QnikbQLi7jgkQroVaqLtWRhbaAl0tA==
X-Received: by 2002:a05:6a20:3d1e:b0:16b:80d3:7f10 with SMTP id
 y30-20020a056a203d1e00b0016b80d37f10mr10105130pzi.34.1696906790539; 
 Mon, 09 Oct 2023 19:59:50 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 y5-20020a170902ed4500b001b86dd825e7sm10433955plb.108.2023.10.09.19.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 19:59:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 4/7] virtio-net: Unify the logic to update NIC state for RSS
Date: Tue, 10 Oct 2023 11:59:18 +0900
Message-ID: <20231010025924.14593-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010025924.14593-1-akihiko.odaki@daynix.com>
References: <20231010025924.14593-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52f.google.com
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

The code to attach or detach the eBPF program to RSS were duplicated so
unify them into one function to save some code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 90 ++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 54 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 83bac9a98a..3c3440ab72 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1212,18 +1212,6 @@ static int virtio_net_handle_announce(VirtIONet *n, uint8_t cmd,
     }
 }
 
-static void virtio_net_detach_epbf_rss(VirtIONet *n);
-
-static void virtio_net_disable_rss(VirtIONet *n)
-{
-    if (n->rss_data.enabled) {
-        trace_virtio_net_rss_disable();
-    }
-    n->rss_data.enabled = false;
-
-    virtio_net_detach_epbf_rss(n);
-}
-
 static bool virtio_net_attach_ebpf_to_backend(NICState *nic, int prog_fd)
 {
     NetClientState *nc = qemu_get_peer(qemu_get_queue(nic), 0);
@@ -1271,6 +1259,40 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
     virtio_net_attach_ebpf_to_backend(n->nic, -1);
 }
 
+static void virtio_net_commit_rss_config(VirtIONet *n)
+{
+    if (n->rss_data.enabled) {
+        n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
+        if (n->rss_data.populate_hash) {
+            virtio_net_detach_epbf_rss(n);
+        } else if (!virtio_net_attach_epbf_rss(n)) {
+            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
+                warn_report("Can't use eBPF RSS for vhost");
+            } else {
+                warn_report("Can't use eBPF RSS - fallback to software RSS");
+                n->rss_data.enabled_software_rss = true;
+            }
+        }
+
+        trace_virtio_net_rss_enable(n->rss_data.hash_types,
+                                    n->rss_data.indirections_len,
+                                    sizeof(n->rss_data.key));
+    } else {
+        virtio_net_detach_epbf_rss(n);
+        trace_virtio_net_rss_disable();
+    }
+}
+
+static void virtio_net_disable_rss(VirtIONet *n)
+{
+    if (!n->rss_data.enabled) {
+        return;
+    }
+
+    n->rss_data.enabled = false;
+    virtio_net_commit_rss_config(n);
+}
+
 static bool virtio_net_load_ebpf(VirtIONet *n)
 {
     if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
@@ -1399,28 +1421,7 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         goto error;
     }
     n->rss_data.enabled = true;
-
-    if (!n->rss_data.populate_hash) {
-        if (!virtio_net_attach_epbf_rss(n)) {
-            /* EBPF must be loaded for vhost */
-            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
-                warn_report("Can't load eBPF RSS for vhost");
-                goto error;
-            }
-            /* fallback to software RSS */
-            warn_report("Can't load eBPF RSS - fallback to software RSS");
-            n->rss_data.enabled_software_rss = true;
-        }
-    } else {
-        /* use software RSS for hash populating */
-        /* and detach eBPF if was loaded before */
-        virtio_net_detach_epbf_rss(n);
-        n->rss_data.enabled_software_rss = true;
-    }
-
-    trace_virtio_net_rss_enable(n->rss_data.hash_types,
-                                n->rss_data.indirections_len,
-                                temp.b);
+    virtio_net_commit_rss_config(n);
     return queue_pairs;
 error:
     trace_virtio_net_rss_error(err_msg, err_value);
@@ -3016,26 +3017,7 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
         }
     }
 
-    if (n->rss_data.enabled) {
-        n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
-        if (!n->rss_data.populate_hash) {
-            if (!virtio_net_attach_epbf_rss(n)) {
-                if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
-                    warn_report("Can't post-load eBPF RSS for vhost");
-                } else {
-                    warn_report("Can't post-load eBPF RSS - "
-                                "fallback to software RSS");
-                    n->rss_data.enabled_software_rss = true;
-                }
-            }
-        }
-
-        trace_virtio_net_rss_enable(n->rss_data.hash_types,
-                                    n->rss_data.indirections_len,
-                                    sizeof(n->rss_data.key));
-    } else {
-        trace_virtio_net_rss_disable();
-    }
+    virtio_net_commit_rss_config(n);
     return 0;
 }
 
-- 
2.42.0


