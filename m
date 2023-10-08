Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2131C7BCD77
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 11:14:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpPqd-0001rY-2Q; Sun, 08 Oct 2023 05:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPqa-0001qV-Lm
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 05:13:12 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPqY-0002H5-7i
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 05:13:12 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6c49f781855so2388092a34.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 02:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696756388; x=1697361188;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9JY+QhbHyxCnkbfdAPQGdcFe4vb0ent2G3OkgeTOTY=;
 b=tIE++MCi58aXxV4EphPbrn2S8PzIbhdfMct16WVd3RT8WIYS5SCFWuG4HnTZX+3KVS
 mwRNKkvLchHATfRs3in/DaerQrMwKDDwqa8pQXL8f0udk7ZyND2Un3i/ACo14jVvOl7Y
 Qmj5Vi+jzY7UvjCrGbdFzfFFZNQSQSbo4WJDVv9I9VQle8orOLZWM3Y8RIgHUsDF9VZY
 NVzvxRP8rPXA4QTFOINdbEnjm0g05pJdrTC5t98/euf3kCL+chRIHw+oa8D1Sla0lJZk
 uDaKWwfYwqIIsbeL+vHNLJ3uTlfsG80s5HOwP50CrYXBSh5exsx5PyoQSS/SkhevwT1D
 tN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696756388; x=1697361188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9JY+QhbHyxCnkbfdAPQGdcFe4vb0ent2G3OkgeTOTY=;
 b=cQwv83sqKLwNNz2dufYZdnMyk2oW5haoLQ1treHIJiykMts5QqLPfrvRvPk2+BjNPR
 AW8/PZcv7N3OxU3KxmR8Ir+JENk437Z5IdHYamSTyy0hQi222VY9XlJAW5u8M+fd6Ze0
 iEhaBxpII6ZJY4LQC+mxutxoXH/O4UbpPaqTqTNCji2Y/CXsUUoIp7JKFqwvFmv+PjEJ
 IEBKzxGDbMla33Ex4tbsXDcvHsg7s9yVfQzMJxdXwy6ccBPEEVja1MEHgZ2ILfA0Q5fR
 D7HsKwkI3cC1U0/S5eMteU3ReiqtZ7h7KpgnQoiZtqe9v43jWu+T1PYlz6QwHhi2bx5p
 uJtg==
X-Gm-Message-State: AOJu0YyOM1+vndMEXy8fRcoGB3sjgjM0btb3+lmNTjQwx0U2ym9dgloI
 mv+pu8wcI+UqMRKH7Gs6eN1eSA==
X-Google-Smtp-Source: AGHT+IGvYT2b+Ug85U66Tpr72P6g6YvdjhFu/58CFO7RIOU2++nlY4bkorkxcA8xkY2KE/6vj151VA==
X-Received: by 2002:a05:6871:7a7:b0:1bb:c50d:7437 with SMTP id
 o39-20020a05687107a700b001bbc50d7437mr15302280oap.53.1696756387995; 
 Sun, 08 Oct 2023 02:13:07 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a17090301c800b001b8a3e2c241sm7118084plh.14.2023.10.08.02.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 02:13:07 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v7 4/5] vhost-user-scsi: start vhost when guest kicks
Date: Sun,  8 Oct 2023 17:12:04 +0800
Message-ID: <20231008091220.870171-5-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008091220.870171-1-fengli@smartx.com>
References: <20231008091220.870171-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=fengli@smartx.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/scsi/vhost-user-scsi.c | 48 +++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 5df24faff4..5afb514398 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -111,8 +111,48 @@ static void vhost_user_scsi_reset(VirtIODevice *vdev)
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
@@ -242,9 +282,9 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
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


