Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B0D7BD2A3
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 06:49:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpiBo-0008Ns-Qb; Mon, 09 Oct 2023 00:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpiBm-0008Mx-KE
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 00:48:19 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpiBi-0003Sx-EG
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 00:48:18 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c7373cff01so37510935ad.1
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 21:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696826892; x=1697431692;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KG8VQi2GXb0p0w8Q2r0ivPYIxJV3b+oHVY+rlGAvLEo=;
 b=AqRmcdmzuW85TeDob8M4LzYD9smAYwxWUr5AW6B+8LcTnOBKCSeFxPy1NDmNy3Fbwd
 uZRJa5+5edO6KHPhZeM71AIDo/iv9AEpc9vVhQMGxhfGquJj/bolj36jhw6K2QFY9Vjj
 XepRIK9pUOm5Nv80DuXxmySHOrOfiHsWodjxos7JIce9Nqv3gVJH5NYdvXpjbbFhfFL4
 ayZpnk70fSAgKGTKU0Z94iK8IgE3JVyQQX3e3gon66c/Efu+sXZIAtoG9tGCC0Fc84yy
 T9/Brj70CtYR2SXbBzqb5cER01H8DjXrHrjSdw9PJRCr5H3gUVRxZ9/skyCjAmvi5Qh9
 09jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696826892; x=1697431692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KG8VQi2GXb0p0w8Q2r0ivPYIxJV3b+oHVY+rlGAvLEo=;
 b=DjkIQGB4vmucYSyZte3Dot8QRRJ1Cu0M2ri3hWX20wIvp4AG0Eq4kd6WuvUUFiO2jP
 SXWWGHZtW5uq/3FeGl7eajLgdta5PlOxzfgPIsgTPmHqxUEDroZFS0v13tT+1ps+s8Jg
 26DbC5cncxgWZVG5PFXQVMVMI1pc7Z+dg7d60D8RaQ8I3aQwWhZ8ECmnFmffx5eoAGal
 wfqQUDewwGs37wavnQ8/VxF+UCf5Qlry4X/q/DHo4D0ln3ogyg3cc51lYipLcYrv4qcA
 FAVFE0W/3fIW3BCw666jQx24ozm51rXgWnGAPbe2bcIUhxe1ZYG4DrMHCq6MmbbQezJZ
 epog==
X-Gm-Message-State: AOJu0YwzR2xO/ZhDLRanfwO/mUt3Ab+5R0vIaTP6EV+XBjaVvOQI/Frw
 Ogd+w9Qiau0WkvyvMLLD03HYlQ==
X-Google-Smtp-Source: AGHT+IHzCWw1VUfFvi7nXfBkrQ7JKilnCoROzCoevVpVQnYNuwh2f48GSM4FrAZ/o68fxOTFp2KnIA==
X-Received: by 2002:a17:902:ec90:b0:1c7:27a1:a9e5 with SMTP id
 x16-20020a170902ec9000b001c727a1a9e5mr18458878plg.33.1696826892040; 
 Sun, 08 Oct 2023 21:48:12 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a170902ec0400b001c452f827casm8406010pld.257.2023.10.08.21.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 21:48:11 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v8 4/5] vhost-user-scsi: start vhost when guest kicks
Date: Mon,  9 Oct 2023 12:47:00 +0800
Message-ID: <20231009044735.941655-5-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009044735.941655-1-fengli@smartx.com>
References: <20231009044735.941655-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index 1e5d853cdd..2457b950e1 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -111,8 +111,48 @@ static void vhost_user_scsi_reset(VirtIODevice *vdev)
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
@@ -239,9 +279,9 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
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


