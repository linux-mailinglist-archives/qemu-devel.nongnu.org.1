Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A727A6192
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 13:44:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiZ8U-0007rP-G2; Tue, 19 Sep 2023 07:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qiZ8R-0007q5-Qw
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:43:19 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qiZ8Q-0004GS-BX
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:43:19 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68fac16ee5fso4740902b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1695123677; x=1695728477;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPRPD1pbMza8Qy14aglX4a9WyhzajqmGhD+mOHsf0R4=;
 b=sXDdvsIKOYI6WDGVfZbGo6THa5Udot+nWRZGQL3kY0cry4iQaaVSE0mWLSzk/RAzJo
 f5ndTPy6pUOe6tWSK2YL8LEEjoEkMy6el5UbgOyCam9BDdRSdMuCzvTVcRpg2rvxh1iB
 anxZgbAZd1xSumclwS7UYvkqLFz6bD4oz3upQM+hOvu641R1UZ0JUZiE74muWulCaW+h
 PoEuUK1LPm1SRik8rhnb+cuWbJ28yN3onvEZj9WKZf1ycRgYpkbtkoBqKrxOwlCSM+9o
 skmSnk+q4f6cFJT8O6zE11WXLYh/yXsxo8JVUXUTqwX0G0WMFcrcv3J7CWZIMYXJz47X
 FbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695123677; x=1695728477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HPRPD1pbMza8Qy14aglX4a9WyhzajqmGhD+mOHsf0R4=;
 b=QqpY1mmvv4jks9/8bIm1F+eb4FT4XfTqR7mWDsKd93gNXMCCaoYps7siO0tvdBez5K
 oF/wEZyRqIYtVggUVH6e3fEV+q0CjUYMAAYF+PRQJ6rHdDfoOMjL45q9p8JE2cDzlM0p
 lqy3BrK3DVOaMdClNre+hrGdfKCQBXw7C7L1QM5JoPEUb8RplHeO0qVcZz9lbRKRhrW0
 tkRfSog6RAh6LyiYbfEpVyMEtZ0oH/GRN3UfBNnPnqsDcLehg+BydArQ909hzQ/YAOwn
 bvf+8smzIamgvgLL7rIljeHt9StgvyZ6FIvVSGjcSwSaqMzoPhqJrwIiV515Z+/boO6X
 P5EQ==
X-Gm-Message-State: AOJu0Yxs7pGMngI3DSWL/6ZJgM5c/5DjFrKC9unagx2gZeWKhDpkWLPE
 W/TAoExc9gOpYsCuc9X/Sq+fGdrYWHKdw5iTqRKJb62gU5Y=
X-Google-Smtp-Source: AGHT+IGLhCT1WiQUD3MxhVzBqZJUtCW5aNOdZvJCjNJhqSVr1oHpo+i+po+25R7JkIPlvLRxpKzJVQ==
X-Received: by 2002:a05:6a20:2446:b0:147:fd40:2482 with SMTP id
 t6-20020a056a20244600b00147fd402482mr11970103pzc.44.1695123676784; 
 Tue, 19 Sep 2023 04:41:16 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 z24-20020aa791d8000000b006887be16675sm8487030pfa.205.2023.09.19.04.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 04:41:16 -0700 (PDT)
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
Subject: [PATCH v5 4/5] vhost-user-scsi: start vhost when guest kicks
Date: Tue, 19 Sep 2023 19:40:25 +0800
Message-ID: <20230919114030.280414-5-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919114030.280414-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230919114030.280414-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x434.google.com
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
---
 hw/scsi/vhost-user-scsi.c | 48 +++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index dc109154ad..53a62c3170 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -115,8 +115,48 @@ static void vhost_user_scsi_reset(VirtIODevice *vdev)
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
@@ -246,9 +286,9 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
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


