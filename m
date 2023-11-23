Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BA67F57E9
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 06:59:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r62iK-0003fy-C9; Thu, 23 Nov 2023 00:57:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1r62iA-0003ej-Oc
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 00:57:15 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1r62i6-0005Qs-9B
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 00:57:14 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc0d0a0355so3650195ad.3
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 21:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1700718907; x=1701323707;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=964uo+5Y+U8YzWWZaokHxWreZ+eFgGhXnwjQzLz2WuU=;
 b=kJRxibFf6d+gjRjQ8V0CIQe1D3ogG6FxLJc0m/tFefKUDUl2nHOA8qPt5V5bylllup
 mI5aN/125kwmrbxhcUNB+c2ZvIpOQfUYAXmABk3HUXWQIwtOkjewaPYEFvKZFZ1VekkD
 AUn+cYHRRiPcbpjtildt5dzObyUwkApDQzskY9dJ1n2hEqoaFIptQZ+L+IxM0qqFr0M6
 WhtJkPqjeOta2heUz+YMCjgY+XcOPRuFn+6mT5BNYIZGR938ZNiVW1+Ve8F/Cb83GCif
 HWinVLt2ifZdYfxGdSICBVYtkt+OXzBOWahwabGNsXE3y39dOzEjhwCqKj3A4jJ5wtNm
 aVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700718907; x=1701323707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=964uo+5Y+U8YzWWZaokHxWreZ+eFgGhXnwjQzLz2WuU=;
 b=VNJDmTOCd3d3K9+8DGaArRcdmRDmrlDbTRcNNhUs0Lmh7OouyvEa4oh7KvyrU1buG3
 FDwar9Ex//GYsHZREYux+tjTlLi2mIg4XbT4DdXf8tRDiF6NhvMAyztagq2h9VZrHq0i
 Ms7p3TLDo0m/hIXTezsYG8iOU83c+ngvazGxgZ3MmDtsN9+JoD8lizWq60T2C13K2H1v
 3i3GFN/zbjPeI8CKLZi57GU5t/qwiAVXoaa3dNMc7cdLxGx+emwbozxqAODUpCJmCJo2
 6BGX2j9pev7s2KHi2qhX0CVWQmX6xsTDKbf2iCHn9kP37zgejRDAgGmTzqFwLRRaDpo/
 +GDg==
X-Gm-Message-State: AOJu0Yx5LI39caoUzNw4UeYwLULZByageWxPp8bLqcidGzt+pPg/kSQI
 03cBthvVoVudRzsOyhVKAaUL3g==
X-Google-Smtp-Source: AGHT+IHs93kLRNzvba/VUnnn0N7gKQr5FX516kpOaIX7sOJrgiA4V4iSrrjJ+QFGg8ldUcXYKiK1Dg==
X-Received: by 2002:a17:902:f7c6:b0:1cf:8c88:51cb with SMTP id
 h6-20020a170902f7c600b001cf8c8851cbmr476181plw.62.1700718907245; 
 Wed, 22 Nov 2023 21:55:07 -0800 (PST)
Received: from localhost.localdomain.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 jl14-20020a170903134e00b001cf6453b237sm417071plb.236.2023.11.22.21.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 21:55:06 -0800 (PST)
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
Subject: [PATCH 1/2] vhost-user: fix the reconnect error
Date: Thu, 23 Nov 2023 13:54:11 +0800
Message-ID: <20231123055431.217792-2-fengli@smartx.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123055431.217792-1-fengli@smartx.com>
References: <20231123055431.217792-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x62a.google.com
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

If the error occurs in vhost_dev_init, the value of s->connected is set to true
in advance, and there is no chance to enter this function execution again
in the future.

Signed-off-by: Li Feng <fengli@smartx.com>
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
2.42.0


