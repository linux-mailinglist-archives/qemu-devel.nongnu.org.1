Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6383D74E1F4
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwg-0003h0-EE; Mon, 10 Jul 2023 19:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwY-0003Cr-2A
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwW-0004qg-K5
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9kWFuRvPt5D6YBoQYP7DIO/LugHsQbLIi6mRC8bw7F8=;
 b=G8InDX2Ik1gSkZEgn+tEwCiDQAynzyqqbAcI9UDcS5OsIhl0BKkocyGjmb3V1Pa31J32ZA
 H6dvp52vbYebO5bTi3RIaKoUdraVCHltj3S2Ne70jA/z566PkHK40XMzMOLQjmBbbvpymv
 Q7uI9ms8Q4yAkIoFP8/upmm9VwdeJRk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-0vyH7E1uO-yVrluR34qvKA-1; Mon, 10 Jul 2023 19:05:18 -0400
X-MC-Unique: 0vyH7E1uO-yVrluR34qvKA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3141325af78so3112140f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030317; x=1691622317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kWFuRvPt5D6YBoQYP7DIO/LugHsQbLIi6mRC8bw7F8=;
 b=EIhiSU2/w0cJNUFkmUVejn5YK6LWtiOe68ew7PSvWE7/wezqmPvS1GtUd+UUf2/k8H
 6DVVmNjOpj6JUeyMRoNmCRdqq4ID31qyQUYkjKF1YH5JoTpNvFoNFbqaYZyT7wAc1nAX
 eN2KMvLiJjayYLIW/NMJ3Cwm4eUoZk02OdnUN/3DujM0K3OSLwsuDow4TsNWIkGgmG6w
 NSX9QmtBOWMRKivE9bQrcMv7zVSLM3uqySJtSfxW2xvuyAjXzenCg7Kk7LCKCWR4H0oD
 AL40PcwSXYiSpViVTADK/H4ZpCH7jvo44jjYE6QzCDLp27irb0GKSYnE8bgOyAdXyNWy
 fEFw==
X-Gm-Message-State: ABy/qLZtd4MmKKq2uf+Y+dXrMSPGPQQ8hbkc33W3jTWL+TW1NdvgBZrF
 VPZmLr1iE4ZUd9QKDzlyE0PMzAae7ys1wYa6tBaurpWyiLKxN5TiYQ3TZuhdY143JM8PaupYnvk
 rsHBXITxF18XLrTJVAINM/dy39NLJ5x4kRWkv6LTs95CCTAVnIBt3YpvCq+0d6JJYpHao
X-Received: by 2002:a5d:540c:0:b0:315:8f4f:81b8 with SMTP id
 g12-20020a5d540c000000b003158f4f81b8mr6805398wrv.50.1689030317166; 
 Mon, 10 Jul 2023 16:05:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE0kkayp1aiYW5byVitcUXZE0fUC8zhW6605czqEoKzdx8UVBo77zwf6P+7BuMK2vB49D3dew==
X-Received: by 2002:a5d:540c:0:b0:315:8f4f:81b8 with SMTP id
 g12-20020a5d540c000000b003158f4f81b8mr6805382wrv.50.1689030316927; 
 Mon, 10 Jul 2023 16:05:16 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 i10-20020a5d558a000000b0030fb828511csm563401wrv.100.2023.07.10.16.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:05:16 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:05:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 59/66] vdpa: Restore MAC address filtering state
Message-ID: <0ddcecb8f2e14b5aa6781ae3403ffa2ac4b25197.1689030052.git.mst@redhat.com>
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

This patch refactors vhost_vdpa_net_load_mac() to
restore the MAC address filtering state at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <4b9550c14bc8c98c8f48e04dbf3d3ac41489d3fd.1688743107.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e192217a96..126afbc7a5 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -666,6 +666,58 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
         }
     }
 
+    /*
+     * According to VirtIO standard, "The device MUST have an
+     * empty MAC filtering table on reset.".
+     *
+     * Therefore, there is no need to send this CVQ command if the
+     * driver also sets an empty MAC filter table, which aligns with
+     * the device's defaults.
+     *
+     * Note that the device's defaults can mismatch the driver's
+     * configuration only at live migration.
+     */
+    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX) ||
+        n->mac_table.in_use == 0) {
+        return 0;
+    }
+
+    uint32_t uni_entries = n->mac_table.first_multi,
+             uni_macs_size = uni_entries * ETH_ALEN,
+             mul_entries = n->mac_table.in_use - uni_entries,
+             mul_macs_size = mul_entries * ETH_ALEN;
+    struct virtio_net_ctrl_mac uni = {
+        .entries = cpu_to_le32(uni_entries),
+    };
+    struct virtio_net_ctrl_mac mul = {
+        .entries = cpu_to_le32(mul_entries),
+    };
+    const struct iovec data[] = {
+        {
+            .iov_base = &uni,
+            .iov_len = sizeof(uni),
+        }, {
+            .iov_base = n->mac_table.macs,
+            .iov_len = uni_macs_size,
+        }, {
+            .iov_base = &mul,
+            .iov_len = sizeof(mul),
+        }, {
+            .iov_base = &n->mac_table.macs[uni_macs_size],
+            .iov_len = mul_macs_size,
+        },
+    };
+    ssize_t dev_written = vhost_vdpa_net_load_cmd(s,
+                                VIRTIO_NET_CTRL_MAC,
+                                VIRTIO_NET_CTRL_MAC_TABLE_SET,
+                                data, ARRAY_SIZE(data));
+    if (unlikely(dev_written < 0)) {
+        return dev_written;
+    }
+    if (*s->status != VIRTIO_NET_OK) {
+        return -EIO;
+    }
+
     return 0;
 }
 
-- 
MST


