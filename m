Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 538EC752F5A
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 04:25:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK8Tc-0005TI-EK; Thu, 13 Jul 2023 22:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qK8Tb-0005T1-3Y
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 22:24:11 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qK8TZ-0000DH-De
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 22:24:10 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fa48b5dc2eso2393212e87.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 19:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689301447; x=1691893447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmQGkJHuRj/4EIgZUFoPOMy4GWhUIj4lwhX/iEiX7Mg=;
 b=USlDR+hnovqY4Bi2H7hr7y2cjodNzWKaoccY9KMJ3l3j3JMfvJd3xPfc0rtKX/+RiK
 gdsDhYyqou3JHXvVS7Hw6koLUKvHgA9TacTLVFOUTdhTU7LvUCg0AJ9+sw5+DEozfAZw
 a0GzSxIlHpT6Upioxv68JV+1xSn1Nssglc8huwDpSSLGxynOJDXmHzq6ewdyPBaxOeeH
 1CjIeuBYHMU10Y2d7frieZKe0XulPHhA4U1mukIyGH0qc45tnmfQQw1Xgl+grXchf5fH
 ClzywFkKaDdOyWHpgskJSUmlGCj/m9mkPRC7YEBU7XDCV3OvSGV6SEoLYvJDtybTyTRv
 w3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689301447; x=1691893447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmQGkJHuRj/4EIgZUFoPOMy4GWhUIj4lwhX/iEiX7Mg=;
 b=MzxBUomaM4MttbIb7ntCxWgCCO93KPbvo8MsROaOMRRAkt7KVBtawwU2MdQIkNhxd4
 g6H8nrghxHnBsQBu2StOzSteQru91Y+QjlSvFQfLNfDYwRyyLYKr/z99wkDz+rctY7S3
 s0SHBVFDLqvFgR5oeEppACYeDSIj2idh5y22P8OAL/ZndU9sI/LauouuO7J0LzijsC+9
 ufQeRlgI1Nz7j18NgRW1bUHN+4x+p4U3JSvl17v3SljSy0D+6KWDnglOzT6LCJj1k5jT
 2CvrmCTZQjn7iwoh7nZEGbQnYxAajVGCayzAORdz2HKah3b7Iko7qyx6vshq1eEiFbyl
 PM3A==
X-Gm-Message-State: ABy/qLZLQUWo3WEfwpgpTjsnFaFsMS17XgDjp9/SunCeHHk/8PNXRL8k
 3l3CTxWZU2ho/cS7JyUIVIZjjA==
X-Google-Smtp-Source: APBJJlGqH4+VW8VZutxPvBjNy3lkQ5PjNWBsUIauk29Clr7DBqTdy8099pwgSFC/bE8RBQdx4QI0+Q==
X-Received: by 2002:ac2:5209:0:b0:4f6:29cf:c0dd with SMTP id
 a9-20020ac25209000000b004f629cfc0ddmr2594244lfl.8.1689301447643; 
 Thu, 13 Jul 2023 19:24:07 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 r24-20020ac24d18000000b004fbe2172f7csm1294765lfi.49.2023.07.13.19.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 19:24:07 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v4 3/6] virtio-net: Added property to load eBPF RSS with fds.
Date: Fri, 14 Jul 2023 05:23:55 +0300
Message-Id: <20230714022358.2438995-4-andrew@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714022358.2438995-1-andrew@daynix.com>
References: <20230714022358.2438995-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::130;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x130.google.com
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
index 7102ec4817..f1894f2095 100644
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
index 5f5dcb4572..44faf700b4 100644
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
2.40.1


