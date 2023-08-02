Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BA976D91F
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:03:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRIym-0003Ox-A5; Wed, 02 Aug 2023 17:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qRIyj-0003O4-HK
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:01:57 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qRIyh-00067y-SA
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:01:57 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b9dc1bff38so3521611fa.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 14:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691010114; x=1691614914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwQQrGVBM8lbrZRRtV/yaJEMn2keHudQbcKH2ZVbryA=;
 b=qID7XHCeCMFA2j/1yOVF7eYGczvP5P/MQOUvaMUfCmHEXcvlNIsep8QAvC6LDXkmi+
 KM5vDLGcL1/Mtyg3w23Q6WkH6mm/hAPRCg4ak8Y4YwwjmGqvHBln7BwOJBOxDV+oyD0C
 KIwSGAveh9Q2H62BBUJBLIKI3m3ugxGmM2acVs3IxLDzI4W54P6XSbxHhNxclf4aIt/i
 S2JV0C+FweyaGZDsAvHKRDxNdgWfCzeDH3U95O5cCsxvAkU839/jCY6qnK5p7ZubygDB
 J1qA/m6VAnwe6Rd6vkDKowqgykbictkm9r+6nvAaqyoyCw9tOhLrNNVyR5jHClRNa2jK
 RLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691010114; x=1691614914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwQQrGVBM8lbrZRRtV/yaJEMn2keHudQbcKH2ZVbryA=;
 b=iv8gOvkUuhGMSFgNBrdytar9b8WyZj++ZxRLA6QfQpAG1+t6gHG5BndB+wiR7MOR6Z
 qGRamXP4cjPrsPLBHnkcLqzIL7e4ZARYqQRNDv7r/X4N1WXEPbGiYOidtCXAR1t1+f+F
 jVwMVpEpUOIZ9Q88pcnTMjwXZg7Qv07UOjxYQf22wHBvT9xhytOeEr1szoI1U84lm1JL
 S4Zr6jbKJlgj7/6qLgiCeEAVbtogcKvL7GjkPTqQxD52Gd+KTM6g3iQnX55xJ1QCHKDb
 mqUmLHpF/x/chohZJ4SWHHW4A9nEfHJC8zK5miyy+GPpueAYbmM3OH0eZ01NgjWHnobf
 8ayA==
X-Gm-Message-State: ABy/qLYxH+RYFTCorFi0f49+9+ld5xbdF4FeruACEaMJyYplryVW/39E
 qWgGheawILw1AFBy4x9Hn6wCCA==
X-Google-Smtp-Source: APBJJlHcvxA9mDkUj6nRv3dCDjSOCGozySer7KATfY6LCiMOlQdJrptk4qqTfiFJ50kAqysBkB39FA==
X-Received: by 2002:a2e:7c18:0:b0:2b9:e0ba:752a with SMTP id
 x24-20020a2e7c18000000b002b9e0ba752amr5861209ljc.53.1691010114294; 
 Wed, 02 Aug 2023 14:01:54 -0700 (PDT)
Received: from localhost.localdomain ([194.126.180.172])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05651c00c800b002ba045496d0sm391880ljr.125.2023.08.02.14.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 14:01:53 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, qemu-devel@nongnu.org
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v5 3/5] virtio-net: Added property to load eBPF RSS with fds.
Date: Wed,  2 Aug 2023 23:41:21 +0300
Message-ID: <20230802204125.33688-4-andrew@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802204125.33688-1-andrew@daynix.com>
References: <20230802204125.33688-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::229;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x229.google.com
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

eBPF RSS program and maps may now be passed during initialization.
Initially was implemented for libvirt to launch qemu without permissions,
and initialized eBPF program through the helper.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/virtio-net.c            | 55 ++++++++++++++++++++++++++++++----
 include/hw/virtio/virtio-net.h |  1 +
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7102ec4817f..f1894f20950 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -42,6 +42,7 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
 #include "monitor/qdev.h"
+#include "monitor/monitor.h"
 #include "hw/pci/pci_device.h"
 #include "net_rx_pkt.h"
 #include "hw/virtio/vhost.h"
@@ -1304,14 +1305,55 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
     virtio_net_attach_ebpf_to_backend(n->nic, -1);
 }
 
-static bool virtio_net_load_ebpf(VirtIONet *n)
+static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
 {
-    if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        /* backend does't support steering ebpf */
-        return false;
+    int fds[EBPF_RSS_MAX_FDS] = { [0 ... EBPF_RSS_MAX_FDS - 1] = -1};
+    int nfds = 0;
+    int ret = true;
+    int i = 0;
+    g_auto(GStrv) fds_strs = g_strsplit(n->ebpf_rss_fds, ":", 0);
+
+    ERRP_GUARD();
+
+    if (g_strv_length(fds_strs) != EBPF_RSS_MAX_FDS) {
+        error_setg(errp,
+                  "Expected %d file descriptors but got %d",
+                  EBPF_RSS_MAX_FDS, g_strv_length(fds_strs));
+       return false;
+   }
+
+    for (i = 0; i < nfds; i++) {
+        fds[i] = monitor_fd_param(monitor_cur(), fds_strs[i], errp);
+        if (*errp) {
+            ret = false;
+            goto exit;
+        }
+    }
+
+    ret = ebpf_rss_load_fds(&n->ebpf_rss, fds[0], fds[1], fds[2], fds[3]);
+
+exit:
+    if (!ret || *errp) {
+        for (i = 0; i < nfds && fds[i] != -1; i++) {
+            close(fds[i]);
+        }
     }
 
-    return ebpf_rss_load(&n->ebpf_rss);
+    return ret;
+}
+
+static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
+{
+    bool ret = false;
+
+    if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
+        if (!(n->ebpf_rss_fds
+                && virtio_net_load_ebpf_fds(n, errp))) {
+            ret = ebpf_rss_load(&n->ebpf_rss);
+        }
+    }
+
+    return ret;
 }
 
 static void virtio_net_unload_ebpf(VirtIONet *n)
@@ -3741,7 +3783,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     net_rx_pkt_init(&n->rx_pkt);
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_load_ebpf(n);
+        virtio_net_load_ebpf(n, errp);
     }
 }
 
@@ -3903,6 +3945,7 @@ static Property virtio_net_properties[] = {
                     VIRTIO_NET_F_RSS, false),
     DEFINE_PROP_BIT64("hash", VirtIONet, host_features,
                     VIRTIO_NET_F_HASH_REPORT, false),
+    DEFINE_PROP_STRING("ebpf_rss_fds", VirtIONet, ebpf_rss_fds),
     DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
                     VIRTIO_NET_F_RSC_EXT, false),
     DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5f5dcb4572b..44faf700b4d 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -219,6 +219,7 @@ struct VirtIONet {
     VirtioNetRssData rss_data;
     struct NetRxPkt *rx_pkt;
     struct EBPFRSSContext ebpf_rss;
+    char *ebpf_rss_fds;
 };
 
 size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
-- 
2.41.0


