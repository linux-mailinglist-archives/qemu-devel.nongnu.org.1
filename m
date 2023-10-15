Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 636277C9953
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:05:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1ic-0001U3-Vo; Sun, 15 Oct 2023 10:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1ib-0001Tu-T6
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:45 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1ia-0007lo-8A
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:45 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-27d087c4276so2247105a91.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378623; x=1697983423;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+GdkLFLQD0hE2TPUW8o7BtXmdE7blAvUTaedUpx1vc=;
 b=BFTNJnNMxzLDrBRlEJQ5G0lvNzKAU4cP6vMHisq7HD1aUBb0NxuzCXtH10txPUuCic
 i4jM1Le8cvlSMShGM0QDVbUd2ZqJibZyCCQ24lLCsJGqLEv3iV5cP1HTmTPiCUHBy7tu
 hTTxll9YWk7wUo3mM+lgLVt0MUXMlutBx+MndzHDtb79wgHgGGU+azijvNshmD06OG3q
 4xwZXWuQkCdZ6ibp+34SkNvkVU1XpTzX9yST/n0ThKdq65EICZFkfA1FZzgqkrMthSx+
 NVehDudH2hQABRRYYvPujXpUhYVvTdSO2COa2dw4+bOmnOObUlvr5hVFwsuya1i356Fv
 stew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378623; x=1697983423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+GdkLFLQD0hE2TPUW8o7BtXmdE7blAvUTaedUpx1vc=;
 b=VK7E5siLvm4Z0CmQOoif4kUx/2sfWniwniev6b6YN8hx0hrIySWJrmOnFZeoAxFYMh
 /JkvKwUfKsh/cPIfM8YU403vRtE2dQgIL1sOTrHwIJFdPoP+qEZ6dL8vhKbsjluVeYAJ
 86yVzLjJeH6la3UTw+4ik4+B8Ep6bPsBdQLMIr8ydEHXBI0WOurZ7XxB5uIsl5bJpPlw
 3RTCfd2Y2zIsOfSnzx88d4HOrBTjLcS43jkLWYNCnnbk1xnrM1cmwTYCHpz8mS9/IzmS
 toO2pvnR4isp2ZqhXwNhMuCvYDyfIfqXUY3ierelAWzGUBQXW7a6maOUtFKE8gypcwkp
 ug5g==
X-Gm-Message-State: AOJu0YzEf/UkbnD31LxqGJxCntNnYB+mmY0EFlRS56feV1WJlNpJ8LTd
 O+ykZvuInihuUOnTwvZeXALLx/ZUYBJJ53vHLuEbAw==
X-Google-Smtp-Source: AGHT+IEALgJEgr4GLxdyiD4O57hW4sjocWX92VvV5DIU1/Hrcd1cLuqB4Ull5O5oebJPWYrfiSorZw==
X-Received: by 2002:a17:90a:8d07:b0:27d:c36:e12d with SMTP id
 c7-20020a17090a8d0700b0027d0c36e12dmr9164838pjo.6.1697378622931; 
 Sun, 15 Oct 2023 07:03:42 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 mf13-20020a17090b184d00b0026f919ff9a1sm3060991pjb.10.2023.10.15.07.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:03:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 10/20] virtio-net: Unify the logic to update NIC state for
 RSS
Date: Sun, 15 Oct 2023 23:02:42 +0900
Message-ID: <20231015140259.259434-11-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
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
index cd533fb91a..25fc06bd93 100644
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


