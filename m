Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C8480B909
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:32:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCPB-0002VX-He; Sun, 10 Dec 2023 00:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOz-0002RV-P2
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:53 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOp-00036K-Iv
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:53 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-77f37772ab6so202324685a.0
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186240; x=1702791040;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s6st9V5VsEY1w+MMBtU2OLcUDHFdim7qLZTOU1Uc5fY=;
 b=Bsm+AR0H4qQnZ22EPdpjLx6W82m8zBtI7XwH95z/HakY/hDbHx4ZirBa1g1xcwbapF
 O2WCeX9L1Wvybt+wImlAg8bf9ch6wlRwD7AiID31HXfzmNkO4Va+rNLqVsg/8LeHimwm
 eq26/3m32IomWKzUTMLNHuoT6gR7Jqk30pzTT5ffXmnRKRKakG3D2OKV3nggag/gA2Ag
 GKXqwV992AOcZuFMDfQvhLKe6NgHwmhsdXKRP2dMaHnNPdE+DhLacbynkJE181ZAyOVT
 h8F9hTDAUigQBAq9iwYHx8Pbu2qxjpeJ8OsEkCdHs6TXxkEgRDxxkX4L8Tx/JHvzFyEx
 UKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186240; x=1702791040;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s6st9V5VsEY1w+MMBtU2OLcUDHFdim7qLZTOU1Uc5fY=;
 b=lQkbN4AUcIRFXZ0DgDGDfTHSSzU3e8+xMFHBNdwlct2QL2quYzixDENEVV3txln4R2
 RVL4980vBtCVqqMkJcqk+C1AKd63c+cBBNGhfCyxAzdkR/o4Ni44W2Yth72BYGdrBEmX
 /FQOxz2S7aTtNGL1j9sfIZBQVH3ulD1HTxogHqQbPZM2tkhEgYQIPCO43mwQ2c7bMrp0
 g0S99MtSatmnWNHg+/550ynVuPGx6n4VPoqMVlBiBXlaiYPyKWKwmwvTRUdHjjrsuDMb
 TqOl6jaS9n+f4/6tIqQHu3hU+w9DFz1RePN2mdeS7iabO0l5WbmtDjpXiCjD0NfEt2b7
 BFoA==
X-Gm-Message-State: AOJu0YwCwIamdJhkRsmAubGb/4mrXfKZ1KbKGOSHmKsR4adkoQ6oXFWH
 IBGxC9GRIidafzmy8xmdEQCDvg==
X-Google-Smtp-Source: AGHT+IGadtj3jXFpKX9EjkxjHGCs0Ydmu3Zhr5+NlzHYSFr/3NoGVifFrCKSKB2d3t9zhAo7/JepVw==
X-Received: by 2002:a05:620a:4e1:b0:77f:3b1c:1802 with SMTP id
 b1-20020a05620a04e100b0077f3b1c1802mr3714380qkh.6.1702186240097; 
 Sat, 09 Dec 2023 21:30:40 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 q6-20020a17090ac10600b00286ead49257sm4493270pjt.21.2023.12.09.21.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:30:39 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:47 +0900
Subject: [PATCH v8 09/19] virtio-net: Unify the logic to update NIC state
 for RSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-9-9553ee714d38@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::72a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-qk1-x72a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
 hw/net/virtio-net.c | 90 +++++++++++++++++++++--------------------------------
 1 file changed, 36 insertions(+), 54 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4c528baad9..5d4afd12b2 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1231,18 +1231,6 @@ static int virtio_net_handle_announce(VirtIONet *n, uint8_t cmd,
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
@@ -1290,6 +1278,40 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
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
+                warn_report("Can't load eBPF RSS for vhost");
+            } else {
+                warn_report("Can't load eBPF RSS - fallback to software RSS");
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
@@ -1418,28 +1440,7 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
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
@@ -3035,26 +3036,7 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
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
2.43.0


