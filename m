Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 267657228B8
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 16:22:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6B5r-0005ag-C7; Mon, 05 Jun 2023 10:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1q6B5e-0005aJ-5Y
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:21:47 -0400
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1q6B5a-0000oG-4H
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:21:44 -0400
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MPowd-1pkOoP3IsF-00Msi4; Mon, 05 Jun 2023 16:21:26 +0200
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] virtio-net: correctly report maximum tx_queue_size value
Date: Mon,  5 Jun 2023 16:21:25 +0200
Message-Id: <20230605142125.3881859-1-lvivier@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NnTtjVkjksUbl0W3PlWN6qT9SOx5HzOuhGwuV5pSX1MDym3T2Yd
 E/UZEZk+Uer8wFVWwCd/82ZxtOqctryTtn7wFV3kCTAATnb7cOYAW9r2bYx7Wd1AwV+lKRg
 GaMZB95AHwajz6HN+y4MYSDBv+h5ElWbas9KME61/lV7wsA3A+DtKLB7RsL7y1FozBR/xkG
 6ZFFrhWfc9nOmppH/Q/yw==
UI-OutboundReport: notjunk:1;M01:P0:fo8al8goUwk=;6odRmO+7GMYiP5Gpne14Q+KqQyY
 aM52nzzpPPcqYkZ/kENb+msayLErv6DR4P0BTAhgySFAc2nIunYPQvojuHzLnfnqKfhAC7q8z
 UB4pPLNiiTbUEREsJRTtNFSUWM4iVghZAc9Urojbv/OwY/EnlBQUFxi70w4T28h9hSvu1DG1k
 4Qnaaz6/Hgl89RB5OKj5aqyrMZ4GxALPUI2pMjUfQqj8wywRzvvdcQ7Wj8epZKxHK/6OUlTIn
 YMb/4cIvED9rvYDHnWjRKwKS6yqjNqI0CB8vWkc5PisdyqBLntAHSttfOZVhgYL0uDKTDDO85
 yvurHZgd944C0bcmYE+f6q5ZYnuXX6YxRLT+9SeTKFF+m8oVoNzfAya5MtLCamteND7v9D1k3
 TQ2fmga74lE09OMe/qPIkqbrgTsKLtrjFUiEKhKfl5zzDPhrOjn/SpXRpaUGMgIws6S/PX+oy
 zUv8urqzjClGfugQkWt9OyLQZAaTMbKGVZaD34+vG8q1bxa0266bIM3mbHUBzv+Z9BrAasvI4
 s4tiLhXIWJJZLZW2hwOqz6k4nM4WFbpqk5M/OwP/wSNoQbVmrsvgpaoWeuMAcExr6E+/pWxjb
 kXFHJf0PLVuJ/8Vjhy+LLm11oSbnEGsI++bJM9A6fVmnsVDbU9AsgWJI4/X9AiuJH9g4k8kiR
 70M48cqjbop/nuDIBzhUW/YMvrl1WV/Dvnwwui0SuQ==
Received-SPF: permerror client-ip=212.227.126.131;
 envelope-from=lvivier@redhat.com; helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_FAIL=0.001,
 SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/virtio-net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6df6b7329d25..e9905aac83ad 100644
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
2.39.2


