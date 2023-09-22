Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F16ED7AB133
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 13:50:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjeew-00087W-ML; Fri, 22 Sep 2023 07:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qjeet-000867-CO
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:49:19 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qjeer-0000fJ-QE
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:49:19 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2746889aa89so1411840a91.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 04:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1695383236; x=1695988036;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPRPD1pbMza8Qy14aglX4a9WyhzajqmGhD+mOHsf0R4=;
 b=U9PPXlgSSCnQ4ijxQsUGctJ/WWeHKI1D8t2SYOYJ7A174b21NYkVtjrc1qmhcg1gPr
 TUJVWfEsExxzU2hFVGl3F0Plz+dtFEnQrsZYdmQgRMkvXP5I86Pntz05AmC5C0H3QXsB
 p9/3nwTd993vDsYuXYINQRI22EOTM9ICXDF/5pj2Zufbk301WblTedjdhiNrX68VEM4u
 KLFzEZivhMCtDxr7faaIkfESz81Dv137phJLvnM0xK8HcQBUAnq2mRhRGCibHkcio4cR
 W8O9/2zBrgdOObF5pWl6h4/Efmm2FVKcWwAl97WoMGe+emIyCbY64vHder9gX4Cy5+VB
 GRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695383236; x=1695988036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HPRPD1pbMza8Qy14aglX4a9WyhzajqmGhD+mOHsf0R4=;
 b=k+jX6QfoQ+Nq9Ylb47rYJ40JEuZbT5+ah+49WZB2xUCOj0nCwBqaNjmiN2mBFmtlth
 ak85gQaE5njRoKGFvvsdknXvJlySI+VzlXGI8/x8b83iexaVArGeVx4wR7LirH6BDnI4
 9Lr1AM1ULxq9sqcNQWhwIeNtMmzim3QguR1IibM5uvkmVL3/sKS6hQTOtLQ4LB1lB1I+
 wJCTD5fY/6YQunIq05bEhaz3vRUFFRBEl9yepoJZcLp53hkIeDecLvzYRC989WMOYs9M
 nuN9DQXNA9PGf+diaMC2/0OwyYBTi8i6KNmVN9twgCDHGus3oU8l4Lma7sf/mLHW4+3N
 syxw==
X-Gm-Message-State: AOJu0Yx8cFmbxL/WLxy57OD5GhZTvY6aFT5VQfbLJD10CkJYrVmd7p77
 bnsIvvUr9DL24BmcG1I7ifSAKZxdKeWS8T9Tb6F3LQI1cQI=
X-Google-Smtp-Source: AGHT+IFbkJUqEYMMiLa7hpQvpDG8YePygkhZ3/l3nZvT5O/2TkZdiataQrR/Zh0Hvu8FWKfoZ92wAQ==
X-Received: by 2002:a17:90a:f297:b0:274:e8e0:1503 with SMTP id
 fs23-20020a17090af29700b00274e8e01503mr8264491pjb.16.1695383236107; 
 Fri, 22 Sep 2023 04:47:16 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 r6-20020a17090a438600b00263f41a655esm3303961pjg.43.2023.09.22.04.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 04:47:15 -0700 (PDT)
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
Subject: [PATCH v6 4/5] vhost-user-scsi: start vhost when guest kicks
Date: Fri, 22 Sep 2023 19:46:14 +0800
Message-ID: <20230922114625.5786-5-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922114625.5786-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230922114625.5786-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1031;
 envelope-from=fengli@smartx.com; helo=mail-pj1-x1031.google.com
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


