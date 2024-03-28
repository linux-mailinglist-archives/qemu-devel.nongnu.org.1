Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F788C6B9
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Mar 2024 16:21:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp8aM-0005vz-84; Tue, 26 Mar 2024 11:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <breno.debian@gmail.com>)
 id 1rp8aH-0005vW-KJ
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:19:29 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <breno.debian@gmail.com>)
 id 1rp8aE-0002jg-1Z
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:19:29 -0400
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-515b69e8f38so955673e87.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711466363; x=1712071163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUVslbHxJBsutcvQ73cVdAnF0u3jUnm/TB9Hv1RCS88=;
 b=BYjIR3yeZ8aAPOefDQtLAHrR4I8J4EB3L5nSdArCyE3zJrmL/aUHCMgp/vKm3GK0y9
 vcuvJeqm20JzBf6GEj6pjwpRopWNuJLsWwv86e7AtBSYJ470HwlQm++FJEOghMrvZopa
 WZ0UTM9Z4avfV8WISC2bu31YFoVvHsaF3bzznBWJEjK/tZy24cbRrD9YnBdOH8/YCpn7
 N3HipuTCOlymX3WPdh9JpoHA78rgiIEb/uQ18GYWa2/lyaNAw5Z8wRIzHObnqSLOOkbb
 3jZneo6E2D1SXr4Ixpn82PgTCX+zhSS0H0BSeaeyyyPhru9UXmpfKOGg5UC+CXf0fDsB
 903g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIvc3IJ+P/3WCH89TCNppMbreZp+AV2BTnk6rSiDLIyJI1HqmPhvoRM3rP2USj8XUkWxBvMi+xX1/Vp9Y0LV7ronFqzbE=
X-Gm-Message-State: AOJu0Yww5lJKyGzRHbO7srNh0Yd/ic6eaqKVW0QkbxaH8Wt2HHxn5E7q
 cDzRLiW0Unuh4BV629GKDN93bxbrjm4DFoPSKSrkMF22LwUv8Qpj
X-Google-Smtp-Source: AGHT+IFP2FZZbpvO9c2stqUmT05DnUhkBn3keNu/tRQhmT0rhlV567sSQvXWBoBrIb87kTJm2cF7ag==
X-Received: by 2002:a05:6512:54e:b0:513:d522:b58c with SMTP id
 h14-20020a056512054e00b00513d522b58cmr6423792lfl.56.1711466363049; 
 Tue, 26 Mar 2024 08:19:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net.
 [2a03:2880:30ff::face:b00c]) by smtp.gmail.com with ESMTPSA id
 i16-20020a170906091000b00a4735fc654fsm4295335ejd.205.2024.03.26.08.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 08:19:22 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Melnychenko <andrew@daynix.com>
Cc: rbc@meta.com, riel@surriel.com, stable@vger.kernel.org,
 qemu-devel@nongnu.org,
 virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 2/2] virtio_net: Do not send RSS key if it is not
 supported
Date: Tue, 26 Mar 2024 08:19:09 -0700
Message-ID: <20240326151911.2155689-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326151911.2155689-1-leitao@debian.org>
References: <20240326151911.2155689-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.167.53;
 envelope-from=breno.debian@gmail.com; helo=mail-lf1-f53.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

There is a bug when setting the RSS options in virtio_net that can break
the whole machine, getting the kernel into an infinite loop.

Running the following command in any QEMU virtual machine with virtionet
will reproduce this problem:

    # ethtool -X eth0  hfunc toeplitz

This is how the problem happens:

1) ethtool_set_rxfh() calls virtnet_set_rxfh()

2) virtnet_set_rxfh() calls virtnet_commit_rss_command()

3) virtnet_commit_rss_command() populates 4 entries for the rss
scatter-gather

4) Since the command above does not have a key, then the last
scatter-gatter entry will be zeroed, since rss_key_size == 0.
sg_buf_size = vi->rss_key_size;

5) This buffer is passed to qemu, but qemu is not happy with a buffer
with zero length, and do the following in virtqueue_map_desc() (QEMU
function):

  if (!sz) {
      virtio_error(vdev, "virtio: zero sized buffers are not allowed");

6) virtio_error() (also QEMU function) set the device as broken

    vdev->broken = true;

7) Qemu bails out, and do not repond this crazy kernel.

8) The kernel is waiting for the response to come back (function
virtnet_send_command())

9) The kernel is waiting doing the following :

      while (!virtqueue_get_buf(vi->cvq, &tmp) &&
	     !virtqueue_is_broken(vi->cvq))
	      cpu_relax();

10) None of the following functions above is true, thus, the kernel
loops here forever. Keeping in mind that virtqueue_is_broken() does
not look at the qemu `vdev->broken`, so, it never realizes that the
vitio is broken at QEMU side.

Fix it by not sending RSS commands if the feature is not available in
the device.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Cc: stable@vger.kernel.org
Cc: qemu-devel@nongnu.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c640fdf28fc5..e6b0eaf08ac2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3809,6 +3809,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
+	if (!vi->has_rss && !vi->has_rss_hash_report)
+		return -EOPNOTSUPP;
+
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
-- 
2.43.0


