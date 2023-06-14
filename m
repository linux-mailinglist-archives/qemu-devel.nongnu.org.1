Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82AD730AB3
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 00:31:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Z03-00043B-BL; Wed, 14 Jun 2023 18:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1q9Z01-00042a-47
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 18:29:57 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1q9Yzz-0001Fr-D4
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 18:29:56 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f64fb05a8aso9536736e87.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1686781794; x=1689373794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8y2m75WdRAUoOVZlVFJT6+Q63GoENOy7L83c/HzsBo=;
 b=p+0WEryF8pb+iDtFcQ2kEeYdT0nmijBpne0eAZbsXp0TYY4lK1ueM5PC60xCHD95yU
 YBPWpBxeUYR5mZEcIOESR9+bHvqVl54pp8WdcE9w/nntgTTrfTUOAsE9pKPBtMg6yAXm
 y9hvlafPMCP6hS+HVB17P40uLD6aJsulOPrMm5nDA7bkiTH//hfYef08WJDZCFWchzrq
 g0hBWwzH5B7Ta0f4hxXQNSvHYBYmIkU0nhO0RFPOexyo8I5AwqA29xFBD1J4rSZk7SmJ
 zcXnhBGfRwGsErBN2ytkHjMavYDq5vm3ZvD+GhtjyvlV0/jnJkE0ibFCeE9QUxdH61fh
 GN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686781794; x=1689373794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q8y2m75WdRAUoOVZlVFJT6+Q63GoENOy7L83c/HzsBo=;
 b=UYZmwya6MVygMbofQEr8kxy6WNkAs7/nhdgPQ/RneDOf7vD3FUhI5nNYYHaHl8jyYh
 UK45ss5wUjdZ2Cl8RZKxr8Kd+DV9fnqCZBZsSJ8Jp56BSxwd5aAkJnK6sZq15wvevQ5y
 42stFsMlQ4B+2Z+tNjVWZCSWKIWxxrKgHr8FT3fqOgcpM0npNW82yukCtNAFLRK3Vf85
 mivtLjwRC5nUEIpa0nXI5Pi0vSLH3sqldjFmmICJ93rnFoNuztCPVkUFc/Ew+wh2EoRi
 bep7yBeyD3EJ2srpian9h6UidTdj2UvenuAaf/6ATlHpPLuTQvdnI0+71P7uFimp1PzZ
 msgw==
X-Gm-Message-State: AC+VfDwszk6T/lyFj5o4mJTCRzJ4E/5qyAY7sA9TgZmPwZfIwQ+Z3tS5
 IUQQehr2/EhYyHDTPPpCGcXlFw==
X-Google-Smtp-Source: ACHHUZ6rKHVNCL8pv4CA2lFjf0CQ3rqv5meeaZfbQNxa2nd63YksW/qutp+vCZEo67ymKUPPcgL3oA==
X-Received: by 2002:ac2:5616:0:b0:4f6:2a65:8087 with SMTP id
 v22-20020ac25616000000b004f62a658087mr8844402lfd.25.1686781793801; 
 Wed, 14 Jun 2023 15:29:53 -0700 (PDT)
Received: from localhost.localdomain ([46.98.110.34])
 by smtp.gmail.com with ESMTPSA id
 x8-20020ac24888000000b004f39837204fsm2279483lfc.85.2023.06.14.15.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 15:29:53 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v3 3/6] virtio-net: Added property to load eBPF RSS with fds.
Date: Thu, 15 Jun 2023 01:10:23 +0300
Message-Id: <20230614221026.56950-4-andrew@daynix.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230614221026.56950-1-andrew@daynix.com>
References: <20230614221026.56950-1-andrew@daynix.com>
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
index 6df6b7329d2..9a5443aaef1 100644
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
index ef234ffe7ef..e10ce88f918 100644
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
2.39.1


