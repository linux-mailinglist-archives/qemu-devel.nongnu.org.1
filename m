Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1279A79CABD
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 10:57:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfzCR-0008TI-DW; Tue, 12 Sep 2023 04:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfzBi-00089f-De
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:56:05 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfzBg-0002BX-8L
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:56:02 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68fb6fd2836so2363579b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1694508839; x=1695113639;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJWI2RWxSuuHEAQnNUIufNGq1knrJeTQjKy85JEOKag=;
 b=Y0wAuHOT9T0+nagQBaUXKMVuTplmaZc32HFRKU1xdOOrAlrYZkc2vbbcD156dKKNYW
 N1ehzaOANtwbd6oL6+3cHKSJ98+zEXldJqY6pb53DM419TTb46uGyjRSEUZOYQTPkAIU
 EmRRh8pOtbech6t+2KUmGKpZjYnudHlvm6VKdJOg3xJy9zyZpn65TTpKXjObpnmzRScu
 kxJfx5yq/MR69Fm/VWO+Aqx+taMGRWKUiB/c2MXviWM/yRrw4oAYr7kkvLcRH6YJhlfp
 jUGSulHoTXsV/gf1c5lilAsraYx9UqRZDlDtl6hmqtgen+FzKpWqBET1W6uEdSF3KVN4
 4LDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694508839; x=1695113639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FJWI2RWxSuuHEAQnNUIufNGq1knrJeTQjKy85JEOKag=;
 b=uTQ1HHzC4ytAWChAMc08hqT1KeqIfblYAXNdWcmW1tXWsdh30Hgw9mzUDT/5TD1GV8
 u/uAObpABmEI1h8mIGIcb20qAAt18VgbtJS7fCXwS1JRQAnMaB7qzIeTXSHq3nfzYF21
 fF4dZwQPv3JuzlZKABmz3Gt/ZanjplIL+KNoFGgBs/O1KEH24yi+N0dXXEVDNhCYxF7o
 aQ4kteCQvW8ULjMky4PgxvgkJt+vR1kRq9sFRYeOg0d3y8lUbEydHOVVQOvofGpLTa9g
 Z+YNAETjQEyVHrt5lgMGBRuGyO0SnyYqUypnjkdLLYEgvnqHR3gA6Ymi5IjYv9N8cXou
 iDqw==
X-Gm-Message-State: AOJu0YyZ0LRgO63oteSNkd9UamPaYU+l43MEoSi/xAyAGqrmlv2rb0Vf
 wPR1fblGAkZaPmrj8fzKC3hveQ==
X-Google-Smtp-Source: AGHT+IFPaMspSeZM32zArizHLAVHaKqFe3uDNwuVgI+71gKGChYirsXrxRMYnABJ7+NAd5LH64MW1g==
X-Received: by 2002:a05:6a00:1408:b0:68e:3d83:e501 with SMTP id
 l8-20020a056a00140800b0068e3d83e501mr14065467pfu.13.1694508838902; 
 Tue, 12 Sep 2023 01:53:58 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a637d46000000b00570668ccd5bsm6523754pgn.14.2023.09.12.01.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 01:53:58 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v4 4/5] vhost-user-scsi: start vhost when guest kicks
Date: Tue, 12 Sep 2023 16:52:46 +0800
Message-ID: <20230912085315.2524857-5-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912085315.2524857-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230912085315.2524857-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
 hw/scsi/vhost-user-scsi.c | 51 +++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index dc109154ad..0effbb4787 100644
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
@@ -198,7 +238,8 @@ static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_CLOSED:
         /* defer close until later to avoid circular close */
         vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
-                               vhost_user_scsi_disconnect);
+                               vhost_user_scsi_disconnect,
+                               vhost_user_scsi_event);
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
@@ -246,9 +287,9 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
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


