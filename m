Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 726D574E1FA
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwi-00048o-J6; Mon, 10 Jul 2023 19:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwc-0003Q8-8d
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwZ-0004rQ-Gt
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0+kiq79YBkXbXg7G5M89/OfLyf3rOZ0UzS1jeywjCIc=;
 b=Iju3N0gzl9xxb5iIu3Le/378KXSvrG7/GQqaTxm+s3tVvBz2DozxqOXjka0OLvjUrNfehc
 ecvGANV0UIhuYJbrFvyTJTl3tC49koplUL3HcGhdeZP1yj08P5pQzrqCppeBeHgsQcGDaW
 1Hq2b4yRCbZ7ByblIKawzWmH3+EDZ3I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-qgeD9gsjMQKAx0xBlp4ktw-1; Mon, 10 Jul 2023 19:05:21 -0400
X-MC-Unique: qgeD9gsjMQKAx0xBlp4ktw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3faabd8fd33so31736565e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030319; x=1691622319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+kiq79YBkXbXg7G5M89/OfLyf3rOZ0UzS1jeywjCIc=;
 b=Xj6zUDYtU7x0k333AqwiAP5/lu57/JxmNytcsCsvG8r28/CRtUMIyeGqiKOOnLhO4M
 KcPP4AeOydrJjMBBlnk2AT286PFu/uDpzyLMPyMwk4rXTwRsZrouaCP24+r/2jihF8fq
 DFgwrbeguVD/fixZ56ahYN8gj2DPpw1luMifDFtbIvNyHMUYgSasLkGk8NbZy+ZUpQ6J
 5zx1GqfuNuxJY1+KHh92Mgtb41EtS+xzUXq79pK5GWM9VY+scMXeZfF1ABU7FeoZAYFI
 XWz6dAVd8B6Pb7137FYN6E9mSL/1jzOlPlEu/C+pIP/rC1S6QCs7bGp43674b7D3Aull
 emMQ==
X-Gm-Message-State: ABy/qLaFSd8PqPpGmF12QVJkPRmegT2vGJQxMUq2kCe1E6vzFf4LCn4X
 bpJUyNLKnXZcN9qjIT8yxjrXO8RqYueoV+/mFrvmgFxecu8L8AmeJtspBTW6yt2EVzcUAqWsmzZ
 sqb2SoJWYB6dRZX3Iev5qdl2oZdx26CoObEwqUmBWhbYGV4ylFANuzmw2PchB0Rx+N/r2
X-Received: by 2002:a1c:770c:0:b0:3fc:e7d:ca57 with SMTP id
 t12-20020a1c770c000000b003fc0e7dca57mr4873033wmi.2.1689030319578; 
 Mon, 10 Jul 2023 16:05:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE5C3g2jyvPe9+3XBil7ypmreD1JIqn5tUfHns9zVOxOc00Ow65kMtswE0Xp3/3srGkeuLcZg==
X-Received: by 2002:a1c:770c:0:b0:3fc:e7d:ca57 with SMTP id
 t12-20020a1c770c000000b003fc0e7dca57mr4873017wmi.2.1689030319293; 
 Mon, 10 Jul 2023 16:05:19 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 j11-20020a056000124b00b0031417fd473csm583481wrx.78.2023.07.10.16.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:05:18 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:05:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 60/66] vdpa: Restore packet receive filtering state relative
 with _F_CTRL_RX feature
Message-ID: <b12f907eeaad7bd4d282502bd7f7773f95e1ee96.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hawkins Jiawei <yin31149@gmail.com>

This patch introduces vhost_vdpa_net_load_rx_mode()
and vhost_vdpa_net_load_rx() to restore the packet
receive filtering state in relation to
VIRTIO_NET_F_CTRL_RX feature at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <804cedac93e19ba3b810d52b274ca5ec11469f09.1688743107.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 126afbc7a5..f299e446b0 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -794,6 +794,87 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
     return 0;
 }
 
+static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
+                                       uint8_t cmd,
+                                       uint8_t on)
+{
+    const struct iovec data = {
+        .iov_base = &on,
+        .iov_len = sizeof(on),
+    };
+    return vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
+                                   cmd, &data, 1);
+}
+
+static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
+                                  const VirtIONet *n)
+{
+    ssize_t dev_written;
+
+    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) {
+        return 0;
+    }
+
+    /*
+     * According to virtio_net_reset(), device turns promiscuous mode
+     * on by default.
+     *
+     * Addtionally, according to VirtIO standard, "Since there are
+     * no guarantees, it can use a hash filter or silently switch to
+     * allmulti or promiscuous mode if it is given too many addresses.".
+     * QEMU marks `n->mac_table.uni_overflow` if guest sets too many
+     * non-multicast MAC addresses, indicating that promiscuous mode
+     * should be enabled.
+     *
+     * Therefore, QEMU should only send this CVQ command if the
+     * `n->mac_table.uni_overflow` is not marked and `n->promisc` is off,
+     * which sets promiscuous mode on, different from the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (!n->mac_table.uni_overflow && !n->promisc) {
+        dev_written = vhost_vdpa_net_load_rx_mode(s,
+                                            VIRTIO_NET_CTRL_RX_PROMISC, 0);
+        if (unlikely(dev_written < 0)) {
+            return dev_written;
+        }
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
+    }
+
+    /*
+     * According to virtio_net_reset(), device turns all-multicast mode
+     * off by default.
+     *
+     * According to VirtIO standard, "Since there are no guarantees,
+     * it can use a hash filter or silently switch to allmulti or
+     * promiscuous mode if it is given too many addresses.". QEMU marks
+     * `n->mac_table.multi_overflow` if guest sets too many
+     * non-multicast MAC addresses.
+     *
+     * Therefore, QEMU should only send this CVQ command if the
+     * `n->mac_table.multi_overflow` is marked or `n->allmulti` is on,
+     * which sets all-multicast mode on, different from the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (n->mac_table.multi_overflow || n->allmulti) {
+        dev_written = vhost_vdpa_net_load_rx_mode(s,
+                                            VIRTIO_NET_CTRL_RX_ALLMULTI, 1);
+        if (unlikely(dev_written < 0)) {
+            return dev_written;
+        }
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EIO;
+        }
+    }
+
+    return 0;
+}
+
 static int vhost_vdpa_net_load(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
@@ -820,6 +901,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
     if (unlikely(r)) {
         return r;
     }
+    r = vhost_vdpa_net_load_rx(s, n);
+    if (unlikely(r)) {
+        return r;
+    }
 
     return 0;
 }
-- 
MST


