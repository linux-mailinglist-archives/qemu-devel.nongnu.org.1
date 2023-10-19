Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5B27D0164
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:26:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhe-0001Ii-7i; Thu, 19 Oct 2023 14:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhF-0000Da-0X
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhC-0002eB-Kq
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YyodsRp2ZRofBm0jV3rXv9QfLn6gfTg2fAVnLonYmZE=;
 b=IOYSez5S9+Q33kibRPTu5UzpjxLh0nc5beHf/5AHOu7bzeJ4m7QqT9A0a2tgl9O3dj8pzm
 KJSEHHmi1XCGPFzCFzQ5i71PkxoiXFmmtFjZlmprvreJJFekPR5TR+oxhRrWG9XSYmFSmJ
 LGDYDadv+4iwfJXYqrAVIA0IsWMYwNs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-WW5Ks96ZOcW9mnrYrK1dFQ-1; Thu, 19 Oct 2023 14:24:22 -0400
X-MC-Unique: WW5Ks96ZOcW9mnrYrK1dFQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507b0270b7fso5129503e87.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739860; x=1698344660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YyodsRp2ZRofBm0jV3rXv9QfLn6gfTg2fAVnLonYmZE=;
 b=Ca8xnwlrX/YWGKkbPR6owHkzf9ykMIIDq941YWfLuyc1gsVpowMBhyrYpVeO9zqxfN
 jpazq5qMDernEeU3oVeI0A8QD4yiFBo9Oy+rAbuxzhN/5sXlUj6/Qaq5zt3B/6k6nX/N
 jBOqyuBgOy5DjF7YWHFhziLQhg+gSPAtn5plk5Kd1P85V0KUvB0HgAUVTt7qldZInJ1o
 UvsRUnqkE+0SWcTHsfawBtZWFeq/1bTEVSIMKY3wC58g+2TVCIxU6/CMnDMREPB9azl8
 d/vpBzvHA2SF9E/Z2G3PeD0CsmYSfJ2anhymBRckMpbFxoAIBFuXzlJItPzEOYaMv5oU
 8oYg==
X-Gm-Message-State: AOJu0YxtAdaJJolEDPHNs3nNlZFifIrXt7jF8/JdI3jLVu/P+Qucd4zp
 FPqpOYZyB95cdN6cpPh3HuI/MmQ1cwZ1Wo/bVhFr3JTrb0LBfTAH/tL8THWzkZ/U4vbduI+0Aun
 iL82ikZEVpPa3lE9s+TzxPzzGfKz6omgb0U6/vgUjkB3RDdgk54JcGB0vz0u/nTa/uqH/
X-Received: by 2002:ac2:4a6c:0:b0:500:aed0:cb1b with SMTP id
 q12-20020ac24a6c000000b00500aed0cb1bmr2038521lfp.24.1697739860627; 
 Thu, 19 Oct 2023 11:24:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU/IrbH8veRbo9ciNRbCEAfUFGMXRM80sXbaWklNI+HgaqFjbY+FE0moH9jNd5GsNe7tB6Hw==
X-Received: by 2002:ac2:4a6c:0:b0:500:aed0:cb1b with SMTP id
 q12-20020ac24a6c000000b00500aed0cb1bmr2038506lfp.24.1697739860346; 
 Thu, 19 Oct 2023 11:24:20 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 z3-20020adfe543000000b0031f82743e25sm4993875wrm.67.2023.10.19.11.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:24:19 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:24:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL v2 70/78] vhost-user-scsi: start vhost when guest kicks
Message-ID: <b52f98549a2ec1627a601d8debd87129d42b38af.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Li Feng <fengli@smartx.com>

Let's keep the same behavior as vhost-user-blk.

Some old guests kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK.

Signed-off-by: Li Feng <fengli@smartx.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <20231009044735.941655-5-fengli@smartx.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/scsi/vhost-user-scsi.c | 48 +++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 24c250d3f8..258fba5c69 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -92,8 +92,48 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
     }
 }
 
-static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+static void vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
+    VHostUserSCSI *s = (VHostUserSCSI *)vdev;
+    DeviceState *dev = DEVICE(vdev);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
+
+    Error *local_err = NULL;
+    int i, ret;
+
+    if (!vdev->start_on_kick) {
+        return;
+    }
+
+    if (!s->connected) {
+        return;
+    }
+
+    if (vhost_dev_is_started(&vsc->dev)) {
+        return;
+    }
+
+    /*
+     * Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
+     * vhost here instead of waiting for .set_status().
+     */
+    ret = vhost_user_scsi_start(s, &local_err);
+    if (ret < 0) {
+        error_reportf_err(local_err, "vhost-user-scsi: vhost start failed: ");
+        qemu_chr_fe_disconnect(&vs->conf.chardev);
+        return;
+    }
+
+    /* Kick right away to begin processing requests already in vring */
+    for (i = 0; i < vsc->dev.nvqs; i++) {
+        VirtQueue *kick_vq = virtio_get_queue(vdev, i);
+
+        if (!virtio_queue_get_desc_addr(vdev, i)) {
+            continue;
+        }
+        event_notifier_set(virtio_queue_get_host_notifier(kick_vq));
+    }
 }
 
 static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
@@ -220,9 +260,9 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    virtio_scsi_common_realize(dev, vhost_dummy_handle_output,
-                               vhost_dummy_handle_output,
-                               vhost_dummy_handle_output, &err);
+    virtio_scsi_common_realize(dev, vhost_user_scsi_handle_output,
+                               vhost_user_scsi_handle_output,
+                               vhost_user_scsi_handle_output, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
-- 
MST


