Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F4B7F57EE
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 06:59:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r62iK-0003gI-OZ; Thu, 23 Nov 2023 00:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1r62iC-0003fA-8v
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 00:57:17 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1r62iA-0005RK-P3
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 00:57:15 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cf8e569c35so842805ad.0
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 21:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1700718910; x=1701323710;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FsMw/oeJf/DV053RoR/5vAo/XSeXb8kX5EmtXDw9AA=;
 b=mCVlfxHR8dx2akPG75S+H7fbfR0GCEN03tQ/Wa0cRPhvFmrGNUvkzgjnK6w7NIyTV7
 3Qoa2hZuuIemdG5HQgu+FVxa8opqm6QZp2BY0DoXAjelq/xgwhG6PVbZ6yADWnzee5vT
 HTV1q2bU4cVQ3nTZoMWyc0KtH3id6nTTDJfFaiDz8QFqLEY/MUG/a28O9zVTlTvyS322
 pHB8NZn0GjmlJ7xBxxW4dE3Ox0IQxFZLHlYH7/Oy7DLt0XLNBIzxmgYLeqQgPSjpxj2Q
 NtTnrv8j6yTuOwfsTRhVdDFpXFVJBe2lL9C6UwAaIvpN7RmTxVEsJMC2qiKhJWp+jMZv
 42XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700718910; x=1701323710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4FsMw/oeJf/DV053RoR/5vAo/XSeXb8kX5EmtXDw9AA=;
 b=BC1imRl/TZrXH14xa13zHsuevAN2sY+DzbitCInkvfAq6XoWfYa0wYrBgdFZZj4Ucl
 ADnmfNJGLdoUVs+r0OkO24UGRcPUgxbnDLWUUu5nEU3oa9agVAdH/QF9VCBOEcsndVfB
 adwHweHNCdaFvjGo6/PasWsjPBRCGMUlqpN+FcKfRpiEV7gNDRdllbPHOq4qdG/IYxZY
 7HvBLAnOTJSQIv4oZVGdNbCp5edhyQgLxDfgIbaEaKXuzOvOFLujs2oYdSV9KzTdHzgX
 k+8ggaynpovIIi/Unabb4l8ySSL3YN8G+I0QReuf5AGcGp0BIiruisbI64f7Y3ZEF/HE
 RoTg==
X-Gm-Message-State: AOJu0YyDmitzRHg3QrQR6G/KE6PHzFSFjQqSwmqLVY93V+Wdu/rlYS+o
 6Chtc0TjyYget0TmIl0x97KmSg==
X-Google-Smtp-Source: AGHT+IH1T72oO522Ax8cX3y8cixR59S6B9shjsGzqO1kYwVANzQyoNBSDfZeRQcsNUxuNR46z4opOg==
X-Received: by 2002:a17:903:32c7:b0:1cf:51c5:d427 with SMTP id
 i7-20020a17090332c700b001cf51c5d427mr5502082plr.65.1700718909978; 
 Wed, 22 Nov 2023 21:55:09 -0800 (PST)
Received: from localhost.localdomain.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 jl14-20020a170903134e00b001cf6453b237sm417071plb.236.2023.11.22.21.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 21:55:09 -0800 (PST)
From: Li Feng <fengli@smartx.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH 2/2] vhost-user-scsi: free the inflight area when reset
Date: Thu, 23 Nov 2023 13:54:12 +0800
Message-ID: <20231123055431.217792-3-fengli@smartx.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123055431.217792-1-fengli@smartx.com>
References: <20231123055431.217792-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Keep it the same to vhost-user-blk.
At the same time, fix the vhost_reset_device.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/scsi/vhost-user-scsi.c | 16 ++++++++++++++++
 hw/virtio/virtio.c        |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 2060f9f94b..780f10559d 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -360,6 +360,20 @@ static Property vhost_user_scsi_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void vhost_user_scsi_reset(VirtIODevice *vdev)
+{
+    VHostUserSCSI *s = VHOST_USER_SCSI(vdev);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+
+    vhost_dev_free_inflight(vsc->inflight);
+}
+
+static struct vhost_dev *vhost_user_scsi_get_vhost(VirtIODevice *vdev)
+{
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(vdev);
+    return &vsc->dev;
+}
+
 static const VMStateDescription vmstate_vhost_scsi = {
     .name = "virtio-scsi",
     .minimum_version_id = 1,
@@ -385,6 +399,8 @@ static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
     vdc->set_config = vhost_scsi_common_set_config;
     vdc->set_status = vhost_user_scsi_set_status;
     fwc->get_dev_path = vhost_scsi_common_get_fw_dev_path;
+    vdc->reset = vhost_user_scsi_reset;
+    vdc->get_vhost = vhost_user_scsi_get_vhost;
 }
 
 static void vhost_user_scsi_instance_init(Object *obj)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4259fefeb6..d0a640af63 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2137,7 +2137,7 @@ void virtio_reset(void *opaque)
         vdev->device_endian = virtio_default_endian();
     }
 
-    if (vdev->vhost_started) {
+    if (vdev->vhost_started && k->get_vhost) {
         vhost_reset_device(k->get_vhost(vdev));
     }
 
-- 
2.42.0


