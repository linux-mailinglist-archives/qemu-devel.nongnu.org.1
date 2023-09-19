Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A28357A6195
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 13:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiZ8N-0007lN-48; Tue, 19 Sep 2023 07:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qiZ8K-0007jI-EG
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:43:12 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qiZ8H-0004F5-Ly
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:43:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68cbbff84f6so4612244b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1695123666; x=1695728466;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eP8kuKM1qKZ8jHbFZXOAaKaPzBH+J+kNlsheIRdgb4=;
 b=2FDAJ/Sjvj5cC34b2BOMzs+MSk8wJXfzy3liqTv0cKTuODnEKCrHil8btN0zvO1V52
 kmdLLuLFdfxpG+uOa+iYPOC/5QGOZ0u4WjeqrrvKYsxQp3SwgaVARNH2WUuiYFbgHX+C
 70HCgm088xPXa+Jca771ykN2ukA+oRcSVtramvIJLIlmvUJezj5Pn68UAY2VIW+meKgK
 2y6z9fPrbls0iEbR5kbXpasn5Ld+/BsW+ZzQrtOMd9a9+KGC7w4uPnuG4potL+xk+rQs
 NA7uLpodbyXu62ocY8lROb8W0NdfXgmh8zdZKbdiKT/+buT8RknVTydmWctyiq1nst0E
 VJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695123666; x=1695728466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1eP8kuKM1qKZ8jHbFZXOAaKaPzBH+J+kNlsheIRdgb4=;
 b=sY6S80TJDzPGsNCyqyQia19R15ZzsM+tzySH6hrv9GPEZ2O1EDc3cSvl9x7PG6alZu
 AUkFTyOPIHexEkpRo8GD8iy8Kv79Ue0LY4f3hWroYNHWMK27idppOA6C3mdfW923b9pE
 JQDNsyZJBXbxgzPA24uM/6s3TJaxpJaBYe8kmmS8A1WuJ3yPRbEx/crhI6TJe+NVy0OO
 nuZDPDF40uGu0uGx4pTgb6vWraGpztxYRKf5ae7VOrdAa831tV8TFIyUWRDoflS03lj9
 lE8ITDTpY6oswQdecAy0xMQmgzVzGWcIH1A2LSuVfjb+Tw4ePQTFSf68B0gIOmZM8gAo
 Ew+g==
X-Gm-Message-State: AOJu0YzwqcALDvDSf/ckeBOic9trGdD6LQiFxoiJHU+1eew3Nkp1XDPi
 Z/IAduWDx/zOe9s5CstcwxETHQ==
X-Google-Smtp-Source: AGHT+IFXhLSk1J4/oFjctJ/Po8nD5YwHwMHiCnwaBvzK3FsmOjQgqT0VcPMdiBDJPHiaO5CfeKMAGg==
X-Received: by 2002:a05:6a00:1d29:b0:68e:16ce:f2e3 with SMTP id
 a41-20020a056a001d2900b0068e16cef2e3mr3023975pfx.0.1695123666044; 
 Tue, 19 Sep 2023 04:41:06 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 z24-20020aa791d8000000b006887be16675sm8487030pfa.205.2023.09.19.04.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 04:41:05 -0700 (PDT)
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
Subject: [PATCH v5 1/5] vhost-user-common: send get_inflight_fd once
Date: Tue, 19 Sep 2023 19:40:22 +0800
Message-ID: <20230919114030.280414-2-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919114030.280414-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230919114030.280414-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x42d.google.com
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


