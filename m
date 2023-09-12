Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA42079CAC2
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 10:57:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfzBf-0007xP-DO; Tue, 12 Sep 2023 04:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfzBa-0007qE-2d
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:55:54 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfzBX-0002AG-M4
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:55:53 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6c09d760cb9so3644534a34.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 01:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1694508828; x=1695113628;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eP8kuKM1qKZ8jHbFZXOAaKaPzBH+J+kNlsheIRdgb4=;
 b=SfVm0DpgRA9avVG/eN+qaeeHxcPKByDZtaNZJjE9n4G/pFlYMICa0clx0RUt7eoyEC
 hUcAnmroB5PWJLbPng8lBDCnu3Dd61ogcs+JTv0ZAViQ6ZgWSxecMUuzUQS1ZdXwhJyU
 hMkYKEbNsQGS2cMQEW5+VKC2wZcV1jSYATz/jJc5K+NNEJCD0l5NB9nRep9lfyDIckcb
 /TC+nf/9dSsO4WieCdxWPbUhbLO5zPfNM4yBN6NZO0O+keLehE17GhY5fllWirsXhJkz
 rq59DYO64g/bvwWtM7WfcJj/Kl6gkiWxhg+9viSZnCthn+iat8+2Y97tXC1L7r+aE0zg
 5yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694508828; x=1695113628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1eP8kuKM1qKZ8jHbFZXOAaKaPzBH+J+kNlsheIRdgb4=;
 b=rESQAXesb+oUrmsOO/4r2Ff12ZmNHUZsZef1wIzvdjdk0iRjcqqOWIXDcIJOek69XI
 L57G+8vnMhFTcvP/GZdeFB6pfncXUqhqzSHYsmT2uNmntlhPj+RismF1b1NdXKVhrb9R
 zUfGa7TZ8vN2R6pveQ4s6fuoUeix22/yOdlyo0nzDMI16r+RUNM9I9s3f4bIUX/Az8GH
 viTvpWmpk5jpAscJIEvruJ1P8MlxgvsYF7xq6kFFC7VRqGP2OT4NobYrfjwV3bLfS25b
 LV3qMxb9sETZk8hdYbMKcHCCwXEmswB0Kk2WRHDKQDUFftjOo99Io9act7g5bQhzX+tI
 nn3A==
X-Gm-Message-State: AOJu0YzvbMI/NpEPUj+6kQSX5OfcpOBro6E6HRSmRt3hGR/ZbB4uW363
 L65bNebPjVLFqlPNRrhQ7uznKg==
X-Google-Smtp-Source: AGHT+IGAFTN9ZcnfepVYRpllrKyik1MiZn5le4uC72FICNx3vX3jObJAVU1Lsohc5cCngfbfxTp2Og==
X-Received: by 2002:a05:6359:1a94:b0:141:12d2:921d with SMTP id
 rv20-20020a0563591a9400b0014112d2921dmr2333623rwb.17.1694508828161; 
 Tue, 12 Sep 2023 01:53:48 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a637d46000000b00570668ccd5bsm6523754pgn.14.2023.09.12.01.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 01:53:47 -0700 (PDT)
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
Subject: [PATCH v4 1/5] vhost-user-common: send get_inflight_fd once
Date: Tue, 12 Sep 2023 16:52:43 +0800
Message-ID: <20230912085315.2524857-2-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912085315.2524857-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230912085315.2524857-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=fengli@smartx.com; helo=mail-ot1-x331.google.com
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

Currently the get_inflight_fd will be sent every time the device is started, and
the backend will allocate shared memory to save the inflight state. If the
backend finds that it receives the second get_inflight_fd, it will release the
previous shared memory, which breaks inflight working logic.

This patch is a preparation for the following patches.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/scsi/vhost-scsi-common.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index a06f01af26..a61cd0e907 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -52,20 +52,28 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
 
     vsc->dev.acked_features = vdev->guest_features;
 
-    assert(vsc->inflight == NULL);
-    vsc->inflight = g_new0(struct vhost_inflight, 1);
-    ret = vhost_dev_get_inflight(&vsc->dev,
-                                 vs->conf.virtqueue_size,
-                                 vsc->inflight);
+    ret = vhost_dev_prepare_inflight(&vsc->dev, vdev);
     if (ret < 0) {
-        error_report("Error get inflight: %d", -ret);
+        error_report("Error setting inflight format: %d", -ret);
         goto err_guest_notifiers;
     }
 
-    ret = vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
-    if (ret < 0) {
-        error_report("Error set inflight: %d", -ret);
-        goto err_guest_notifiers;
+    if (vsc->inflight) {
+        if (!vsc->inflight->addr) {
+            ret = vhost_dev_get_inflight(&vsc->dev,
+                                        vs->conf.virtqueue_size,
+                                        vsc->inflight);
+            if (ret < 0) {
+                error_report("Error getting inflight: %d", -ret);
+                goto err_guest_notifiers;
+            }
+        }
+
+        ret = vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
+        if (ret < 0) {
+            error_report("Error setting inflight: %d", -ret);
+            goto err_guest_notifiers;
+        }
     }
 
     ret = vhost_dev_start(&vsc->dev, vdev, true);
@@ -85,9 +93,6 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
     return ret;
 
 err_guest_notifiers:
-    g_free(vsc->inflight);
-    vsc->inflight = NULL;
-
     k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
 err_host_notifiers:
     vhost_dev_disable_notifiers(&vsc->dev, vdev);
@@ -111,12 +116,6 @@ void vhost_scsi_common_stop(VHostSCSICommon *vsc)
     }
     assert(ret >= 0);
 
-    if (vsc->inflight) {
-        vhost_dev_free_inflight(vsc->inflight);
-        g_free(vsc->inflight);
-        vsc->inflight = NULL;
-    }
-
     vhost_dev_disable_notifiers(&vsc->dev, vdev);
 }
 
-- 
2.41.0


