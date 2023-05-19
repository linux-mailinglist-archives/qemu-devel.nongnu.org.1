Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A71709A9B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:55:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01S0-0002kQ-Ko; Fri, 19 May 2023 10:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Rx-0002NZ-OJ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Rw-0003cj-3R
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUPTcE5SdErzr0Z7x7ic8k6+QHDhF6znZOeSZPOw6AA=;
 b=VU8K2YzT3EjYdMCeDyTB8Vk5jJzrAaOpY211HUUnOYFpFGGaGF+bZcxTaDztudS/kYCb7i
 /kTDWWX5+/rO3TDFx3gR+m6HNvamOGsaek3v1Y5D55/lSrBMqqmAch+tHYW0ryyUJ6stde
 6YVlNeebTg0cDX6kQcd3NipqEyBs6pI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-6krmOWalOWui2e98PNB_QQ-1; Fri, 19 May 2023 10:51:17 -0400
X-MC-Unique: 6krmOWalOWui2e98PNB_QQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f3932e595dso2263608e87.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507876; x=1687099876;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XUPTcE5SdErzr0Z7x7ic8k6+QHDhF6znZOeSZPOw6AA=;
 b=M1q5megnNpDCuZ3BhekafJMLuMWAWuRvZTT2WcA7OCulLJ0pmxHdMZczGbrJ761SZn
 6fRmyoz6ZXwv0vhJrlf/Qmeok0oVviWANhR2Cq1xttexRsbq+6zpCZZXtKsVfWW+hwiC
 xq/WuSybgVg8XHADZe/oHK8HPI7LaDMpt+MK41Ranlhe168IOhDcMQHvCZgdYz3Lem5C
 w7pKT6GhS7hVk/7FpOTt7oeEzZ1CcB289Pp51nwkNIy1oQUT8j/Evkp9cRnDhrX9TWnu
 UJR/CCYY00gWi3YHDdVRU+TCBX4bIUydTS7zODXEnkVEogIroG8EeIJjUBhCLz48r60q
 8xjg==
X-Gm-Message-State: AC+VfDzBdoUuVM3SU1TzbJb4Yi0URgiffhkPUDe0as2zVvb7dYFIHY2J
 gs5mgAcj8YTyqIvpIsgrhED1GlZa37KCkBruYxJ8eWRQv7a7izdzwumHiyAZz6zmCJXFu+F7XP0
 Wq3ucGkUHWlJTutjUvSOILqe0Z86fhvJjYg23AVeq8lbSKqSPfy0ctWpOLEbnMj7Nb6Li
X-Received: by 2002:a05:6512:21c7:b0:4ed:cc6d:61fe with SMTP id
 d7-20020a05651221c700b004edcc6d61femr929482lft.24.1684507876021; 
 Fri, 19 May 2023 07:51:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7E+3eeDRP9NAS0QGzPyRlsE8329J3c2Rl63BEpeUJrNdkzMexNXDv6OPEaYbVVQ7fJtGp4OQ==
X-Received: by 2002:a05:6512:21c7:b0:4ed:cc6d:61fe with SMTP id
 d7-20020a05651221c700b004edcc6d61femr929471lft.24.1684507875780; 
 Fri, 19 May 2023 07:51:15 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 q1-20020ac24a61000000b004f3b38cd311sm33542lfp.78.2023.05.19.07.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:51:15 -0700 (PDT)
Date: Fri, 19 May 2023 10:51:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cindy Lu <lulu@redhat.com>,
 Yajun Wu <yajunw@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 18/40] vhost-user: send SET_STATUS 0 after GET_VRING_BASE
Message-ID: <6f8be29ec17d44496b9ed67599bceaaba72d1864.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Setting the VIRTIO Device Status Field to 0 resets the device. The
device's state is lost, including the vring configuration.

vhost-user.c currently sends SET_STATUS 0 before GET_VRING_BASE. This
risks confusion about the lifetime of the vhost-user state (e.g. vring
last_avail_idx) across VIRTIO device reset.

Eugenio Pérez <eperezma@redhat.com> adjusted the order for vhost-vdpa.c
in commit c3716f260bff ("vdpa: move vhost reset after get vring base")
and in that commit description suggested doing the same for vhost-user
in the future.

Go ahead and adjust vhost-user.c now. I ran various online code searches
to identify vhost-user backends implementing SET_STATUS. It seems only
DPDK implements SET_STATUS and Yajun Wu <yajunw@nvidia.com> has
confirmed that it is safe to make this change.

Fixes: commit 923b8921d210763359e96246a58658ac0db6c645 ("vhost-user: Support vhost_dev_start")
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>
Cc: Yajun Wu <yajunw@nvidia.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20230501230409.274178-1-stefanha@redhat.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Yajun Wu <yajunw@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e5285df4ba..40974afd06 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2677,7 +2677,20 @@ static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
                                           VIRTIO_CONFIG_S_DRIVER |
                                           VIRTIO_CONFIG_S_DRIVER_OK);
     } else {
-        return vhost_user_set_status(dev, 0);
+        return 0;
+    }
+}
+
+static void vhost_user_reset_status(struct vhost_dev *dev)
+{
+    /* Set device status only for last queue pair */
+    if (dev->vq_index + dev->nvqs != dev->vq_index_end) {
+        return;
+    }
+
+    if (virtio_has_feature(dev->protocol_features,
+                           VHOST_USER_PROTOCOL_F_STATUS)) {
+        vhost_user_set_status(dev, 0);
     }
 }
 
@@ -2716,4 +2729,5 @@ const VhostOps user_ops = {
         .vhost_get_inflight_fd = vhost_user_get_inflight_fd,
         .vhost_set_inflight_fd = vhost_user_set_inflight_fd,
         .vhost_dev_start = vhost_user_dev_start,
+        .vhost_reset_status = vhost_user_reset_status,
 };
-- 
MST


