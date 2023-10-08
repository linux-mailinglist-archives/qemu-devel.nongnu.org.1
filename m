Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B33057BCC66
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 07:31:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpMNY-0004eO-Sy; Sun, 08 Oct 2023 01:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMMd-00049A-01
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:30:04 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMMO-00076e-D0
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:30:02 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1e5602c12e5so2068532fac.3
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 22:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696742984; x=1697347784;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9XCCtGoA5l5bdW6uetTj/eGIjTzGN0RtdgyGLy36eM=;
 b=fCy8X0GKd9iLwB14pp3PVcAjkYy7FzhSZlNgzY9Ug61fuB3R2Di61GIn90kDyqk6jN
 3RDBzD5jpAnvJS2D0sYWkhs59DlJrqLEEpONJQdbjwlwZH8yo2KYoekneC9uEtSP2/Ab
 fQRo8p194T6ETJrNAVGitSwl2WGKnuniWvcsyuxGamOuj7VoQbSxYF3pPR0h7nM5bmcJ
 fIR/ZOuGJCJJsUj72xcsr+gbzilD9EYaFCDVTTNGDVogxxHkw+ZcuEjIyRs0R1dqMsjX
 ZgsPwFgKjfmLpsYuLWwswfHTxBEqjo8VwQvBl5ByqGS1uYwqSHiVYp6P8Y/HtZofVX9p
 Rv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696742984; x=1697347784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9XCCtGoA5l5bdW6uetTj/eGIjTzGN0RtdgyGLy36eM=;
 b=neRz+4X6JMtH3cdK1zrH94aGzTGXpSsa6M+6caW2iHVvHVogM4qeDZzuBDdGz6nCrf
 Ye858zaGHSFRcsGRJ4RFxwX0tQPeE6rBYjO3uGO6h51In5ur1Q9Y2pgtqs35mNbgbZHA
 B2dIPSu+SaF/8MMv5W4rxqNdAlSbCxXOkzJOeQ9tD0klnb+ns872ZcigKeGcoFgs8RuH
 a37kpLmiVgUxC6e/YytJVtYYsP0pgt4d6uZ5XXPG7BlBnoL8Kl12aW0OMPwPfE9dxTga
 9U20KtF9wtZWrOeb6FTq+5T0Sv8lctHUe/2sQhjgC374kDGTITzqlLSAN+Q80mBeyQIw
 3N3A==
X-Gm-Message-State: AOJu0YzddEbHKYnB254eO1XEJRndxRY9nelx3Y5sVJ5JbngUMCK7YttC
 f00JDr4TNlve2Kcs6hE6n57XTg==
X-Google-Smtp-Source: AGHT+IEEVMJAgf7VNGrGOvK7X1hhXjRFJJbOzLkuf4bxYIgT8Ine6m7/o/URewOBJFbA1lHhTYLMpA==
X-Received: by 2002:a05:6870:14c1:b0:1b0:89e0:114f with SMTP id
 l1-20020a05687014c100b001b089e0114fmr14578333oab.31.1696742983833; 
 Sat, 07 Oct 2023 22:29:43 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 ji2-20020a170903324200b001b8b2b95068sm6795601plb.204.2023.10.07.22.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 22:29:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 4/6] virtio-net: Unify the logic to update NIC state for RSS
Date: Sun,  8 Oct 2023 14:29:13 +0900
Message-ID: <20231008052917.145245-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008052917.145245-1-akihiko.odaki@daynix.com>
References: <20231008052917.145245-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2a.google.com
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


