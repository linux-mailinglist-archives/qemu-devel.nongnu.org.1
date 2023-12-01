Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D78010F3
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:17:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r977U-0003Ch-0p; Fri, 01 Dec 2023 12:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r977I-0002y3-0x
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r977G-0007p5-Dw
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IfkBTC+cT96iRnuRxUUQuNhdFAJP0iI08TGdiS5NaxU=;
 b=VxAsmGm1U4NFvW9s+SvGhSmoiFBlm82nYGM501hrcQ5ssjRzpQLZVfmaAOo+7HxgOEGMlc
 h8Xec/CI6fyqRLD1MUpU0W8VXd7Xomb+nQC1RnXLx/qg1HwOVQrhj1NdIM3pSMXhQQ6Lls
 AtcHCxIcLszjfsRm4P1xxGa2Z9CzcQM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-xsawoGKkMkuWCnCo325D8A-1; Fri, 01 Dec 2023 12:15:47 -0500
X-MC-Unique: xsawoGKkMkuWCnCo325D8A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40b296a4450so16585305e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450946; x=1702055746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IfkBTC+cT96iRnuRxUUQuNhdFAJP0iI08TGdiS5NaxU=;
 b=iyncNoUJwZyL3fGMkf3OPXb52Co6eWOOHO+f20/OiXdlGzYmUSCgXaMG7er0nSSa/g
 zokk8p4HVCFCmqrtnSMWNNm7jwdnBkyhwlg21X/+81+pWSXcf96YPFGfIb88TwFbR09Q
 DMT5RLfnrLcEpOG/NoicifAZn62oufFZ+kFZKJGF2TX0J/C8zwRBDZSb+VpvNmSObsYH
 1/2KydiI8aKEjRjsiYR012jdmiVzhLKWePWBJKMJLV6GiXwAJbLZx5rxNJ5/rmi6k05W
 NBLrS/xnp7z5M8aEUYTzinDMYvconMZY2KcSJVBVsK9uArSwQdTOEZQ6MjpgkGBxhOfo
 8X5g==
X-Gm-Message-State: AOJu0YzgtZbJSsR01afxuLnBD9RiFmgMNvHI5cAjYx7Ud5jryPv7LarE
 ElXcD7teObL+TYroR0aLhnJe5cOeG2ZoQm8D+TYjCPQtodWgWUl7QWkJnzGa+q3kTyRoZhTXO2o
 k5nVzmKyuQ0mc14Ss+Ux4Y82ccF4uq+5jyVfxSo7pN+w2ZdHsMZMpRfEYBsSajYMHEPku
X-Received: by 2002:a05:600c:22da:b0:40b:5e21:c5b1 with SMTP id
 26-20020a05600c22da00b0040b5e21c5b1mr343201wmg.127.1701450946171; 
 Fri, 01 Dec 2023 09:15:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9qxrBYhppFeCU3sBalU3aRCFKCA7HPzQrHej0Imk8f+tXMicUef/Mk0fr41AZxtsLCDSPOg==
X-Received: by 2002:a05:600c:22da:b0:40b:5e21:c5b1 with SMTP id
 26-20020a05600c22da00b0040b5e21c5b1mr343185wmg.127.1701450945774; 
 Fri, 01 Dec 2023 09:15:45 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 j11-20020a05600c190b00b0040b4c26d2dasm6058392wmq.32.2023.12.01.09.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:45 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, qemu-block@nongnu.org
Subject: [PULL 14/15] vhost-user: fix the reconnect error
Message-ID: <cf1afed5e60ac560b093722fdc94fa08de22dc28.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

If the error occurs in vhost_dev_init, the value of s->connected is set to true
in advance, and there is no chance to enter this function execution again
in the future.

Signed-off-by: Li Feng <fengli@smartx.com>
Message-Id: <20231123055431.217792-2-fengli@smartx.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/vhost-user-blk.c   | 8 +++-----
 hw/scsi/vhost-user-scsi.c   | 3 ++-
 hw/virtio/vhost-user-gpio.c | 3 ++-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 818b833108..2863d80d15 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -326,7 +326,6 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
     if (s->connected) {
         return 0;
     }
-    s->connected = true;
 
     s->dev.num_queues = s->num_queues;
     s->dev.nvqs = s->num_queues;
@@ -343,15 +342,14 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
         return ret;
     }
 
+    s->connected = true;
+
     /* restore vhost state */
     if (virtio_device_started(vdev, vdev->status)) {
         ret = vhost_user_blk_start(vdev, errp);
-        if (ret < 0) {
-            return ret;
-        }
     }
 
-    return 0;
+    return ret;
 }
 
 static void vhost_user_blk_disconnect(DeviceState *dev)
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 4486500cac..2060f9f94b 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -147,7 +147,6 @@ static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
     if (s->connected) {
         return 0;
     }
-    s->connected = true;
 
     vsc->dev.num_queues = vs->conf.num_queues;
     vsc->dev.nvqs = VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
@@ -161,6 +160,8 @@ static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
         return ret;
     }
 
+    s->connected = true;
+
     /* restore vhost state */
     if (virtio_device_started(vdev, vdev->status)) {
         ret = vhost_user_scsi_start(s, errp);
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index aff2d7eff6..a83437a5da 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -229,7 +229,6 @@ static int vu_gpio_connect(DeviceState *dev, Error **errp)
     if (gpio->connected) {
         return 0;
     }
-    gpio->connected = true;
 
     vhost_dev_set_config_notifier(vhost_dev, &gpio_ops);
     gpio->vhost_user.supports_config = true;
@@ -243,6 +242,8 @@ static int vu_gpio_connect(DeviceState *dev, Error **errp)
         return ret;
     }
 
+    gpio->connected = true;
+
     /* restore vhost state */
     if (virtio_device_started(vdev, vdev->status)) {
         vu_gpio_start(vdev);
-- 
MST


