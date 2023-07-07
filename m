Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5755E74AD86
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:07:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHhQJ-00034H-69; Fri, 07 Jul 2023 05:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQH-00033G-Fj
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQF-0006Fd-Qp
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688720797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZueWIlzZKgbf8cX82y5M/LaOOy0KlmpgFG8PxZZoKZ0=;
 b=IwK/+LyKCEzO4ep50kqEyv1uwvYVAFGCzd/JmUacCJ+hJWohJxbEQADQ9reWXM8AAGD1wx
 TJ4K4RrhO+9PMq8y3g/7bQFMpkXJDsQC2dOuO8icNO7IFF5GZYctG3TSn8mmDW0U3wAl4D
 z7R/qeSgH2Xvk+KLrR2Z6138SC0h0Kw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-CMDg-QY_MKC-BWX5peFdqw-1; Fri, 07 Jul 2023 05:06:36 -0400
X-MC-Unique: CMDg-QY_MKC-BWX5peFdqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8E76280BC5F;
 Fri,  7 Jul 2023 09:06:35 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 197151121330;
 Fri,  7 Jul 2023 09:06:32 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: Laurent Vivier <lvivier@redhat.com>, mst@redhat.com,
 qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: [PULL 01/15] virtio-net: correctly report maximum tx_queue_size value
Date: Fri,  7 Jul 2023 05:06:14 -0400
Message-Id: <20230707090628.2210346-2-jasowang@redhat.com>
In-Reply-To: <20230707090628.2210346-1-jasowang@redhat.com>
References: <20230707090628.2210346-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

From: Laurent Vivier <lvivier@redhat.com>

Maximum value for tx_queue_size depends on the backend type.
1024 for vDPA/vhost-user, 256 for all the others.

The value is returned by virtio_net_max_tx_queue_size() to set the
parameter:

    n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
                                    n->net_conf.tx_queue_size);

But the parameter checking uses VIRTQUEUE_MAX_SIZE (1024).

So the parameter is silently ignored and ethtool reports a different
value than the one provided by the user.

   ... -netdev tap,... -device virtio-net,tx_queue_size=1024

    # ethtool -g enp0s2
    Ring parameters for enp0s2:
    Pre-set maximums:
    RX:		256
    RX Mini:	n/a
    RX Jumbo:	n/a
    TX:		256
    Current hardware settings:
    RX:		256
    RX Mini:	n/a
    RX Jumbo:	n/a
    TX:		256

   ... -netdev vhost-user,... -device virtio-net,tx_queue_size=2048

    Invalid tx_queue_size (= 2048), must be a power of 2 between 256 and 1024

With this patch the correct maximum value is checked and displayed.

For vDPA/vhost-user:

    Invalid tx_queue_size (= 2048), must be a power of 2 between 256 and 1024

For all the others:

    Invalid tx_queue_size (= 512), must be a power of 2 between 256 and 256

Fixes: 2eef278b9e63 ("virtio-net: fix tx queue size for !vhost-user")
Cc: mst@redhat.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index aa421a9..04783f5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3630,12 +3630,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     }
 
     if (n->net_conf.tx_queue_size < VIRTIO_NET_TX_QUEUE_MIN_SIZE ||
-        n->net_conf.tx_queue_size > VIRTQUEUE_MAX_SIZE ||
+        n->net_conf.tx_queue_size > virtio_net_max_tx_queue_size(n) ||
         !is_power_of_2(n->net_conf.tx_queue_size)) {
         error_setg(errp, "Invalid tx_queue_size (= %" PRIu16 "), "
                    "must be a power of 2 between %d and %d",
                    n->net_conf.tx_queue_size, VIRTIO_NET_TX_QUEUE_MIN_SIZE,
-                   VIRTQUEUE_MAX_SIZE);
+                   virtio_net_max_tx_queue_size(n));
         virtio_cleanup(vdev);
         return;
     }
-- 
2.7.4


