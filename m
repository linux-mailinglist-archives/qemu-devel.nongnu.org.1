Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9697695C4
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 14:13:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQRm8-0003RP-R9; Mon, 31 Jul 2023 08:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQRm4-0003MU-5J
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:13:20 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQRm2-00059q-4C
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:13:19 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686b9964ae2so2930204b3a.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 05:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690805476; x=1691410276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9PoeHQ72MxcC2TaPE9HsDberM+yq2oYNtqnB7MFftuE=;
 b=pISqWFbCwW9ucqWlz66+soLewmbIPUhI8FE2tBVSQJGxtRVdwdQts9r3x7OhIeTffh
 l7S1B2v5+WQgIAE/96wfoEpdc0h0AQEkjo8M+rbagzh4MlmsUgThzw9Vp6v2k5DJr327
 7A3joGei3XMEr4CiUMKV+IfOuiyhn6y0GSLQYNohGgMbCAeX7xQYTqaz9FOT885uszn2
 ZLbPtvglVO9NHqInthjSzcGn4Mc2Qqc0GiM5PRE5Kg/9ptB4iCgHRLn+LF/dFRsKnO5b
 GVhUGKygfTOv3+UA8B/k7DnpeCB6Wl+n6dpk/EKNS2t58CEnzpxRR84Uyvj23Pwuob6H
 vSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690805476; x=1691410276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9PoeHQ72MxcC2TaPE9HsDberM+yq2oYNtqnB7MFftuE=;
 b=Td7K3oF+4mapJLZD7BYhyoCOiaiqDgdIVMMeF22DfS7dkD0iZJn7Y/mQSdyNFpIBx1
 oyEwITI6GOvKNSx7qGwLCYOqfOu2CKeUOBjhaxUoBjLyJy8qMxkEB2Rej56Kmyxalblv
 zRuNa8WAww8/YF4pzkJSzqT6h5OYBEeYh8VntO9hg9zO44BI9h7FdcdeAirxdkxh4qFY
 ouD0loQ3Kq51hJKe3MMUjwk79gIGFTFbcSBcZNxKn3SLhswPBtoDjhfA2qXkJcUNlyPZ
 cgDNNHUooARzyUGo4qtKDHew+mmXwvptJtUWYM3Z6a6lzYU3PuuI5ixMnlYLu34pYrQ9
 +1oQ==
X-Gm-Message-State: ABy/qLbRnRROAcUcAGWqi88tkSY8+C+l104vtPnYF+JesbXNjVb71PnM
 mYHQn15wMgiwSEfO4a9IjKJuFw==
X-Google-Smtp-Source: APBJJlGvs5vbuz3clvEV1NOqCyUvCsVXlIsFRSq9+nYD0/K6ffo41A3QvOpsdxDarHmIXPIEEb6l5A==
X-Received: by 2002:a05:6a20:7492:b0:133:c12a:4d6 with SMTP id
 p18-20020a056a20749200b00133c12a04d6mr9289657pzd.1.1690805476490; 
 Mon, 31 Jul 2023 05:11:16 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a62bd0a000000b005d22639b577sm7385690pff.165.2023.07.31.05.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 05:11:15 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v3 5/5] vhost-user-scsi: start vhost when guest kicks
Date: Mon, 31 Jul 2023 20:10:10 +0800
Message-ID: <20230731121018.2856310-6-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731121018.2856310-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230731121018.2856310-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x42f.google.com
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

Let's keep the same behavior as vhost-user-blk.

Some old guests kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/scsi/vhost-user-scsi.c | 48 +++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 5bf012461b..a7fa8e8df2 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -113,8 +113,48 @@ static void vhost_user_scsi_reset(VirtIODevice *vdev)
     }
 }
 
-static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+static void vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
+    VHostUserSCSI *s = (VHostUserSCSI *)vdev;
+    DeviceState *dev = &s->parent_obj.parent_obj.parent_obj.parent_obj;
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
+    ret = vhost_user_scsi_start(s);
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
@@ -243,9 +283,9 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
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
2.41.0


