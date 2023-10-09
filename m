Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B557BD2A2
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 06:49:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpiBY-0008Jc-S8; Mon, 09 Oct 2023 00:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpiBW-0008Iq-Gz
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 00:48:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpiBU-0003R1-Ew
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 00:48:02 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c5db4925f9so30053095ad.1
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 21:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696826879; x=1697431679;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtjO1lS5KyQU3h+Hf7ZgeU0iuEx8e6d6jY/0St+hkG8=;
 b=cAKNDxiBDIF8yQjNmg0FFHhW8DcLt6r+6o6+TEKCuGzddohX6l53/AeRx6BXV/BwDO
 nFcX7O7MibVtzgWqADkevBYMA4hzL5ZBQt00ATU4YT1DsNhXTU2YYYD36nkcTodHztIX
 M8lAKFRircZJ0TmZzjDtmTHO4dqfw6lLa7DglldzdRT5x0EKIxdzQ+10siYmTrBpPr8Y
 VMJYEuYJ+xNH3bEY4bA2sF0r8oprfr7wNazdl/9ebAPo/3S13PFLoLNPVSCNvAuDp85W
 6OJ4MZVdHHM/N/enRQ4nYVT4v7k6CBoT4VyHK2qZ7o+Mps3dXc6L/m/Uz+1l097ijEC5
 GcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696826879; x=1697431679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KtjO1lS5KyQU3h+Hf7ZgeU0iuEx8e6d6jY/0St+hkG8=;
 b=vWWHnwMEsmN+8hWtxAOqWhe61JqNH15vO8afmsK045IWV5oFgGd+iEi6LHIfLARki0
 8Xf0AK1prqhZg8MS0S61JMP/rTNrO0gnVePv2Vj+fRCmVxOWmhHiuiQtw2Xhmm28UO4K
 4LqgT8LM3ljO9Lca2eK4jma4gajhuuKFf9YLXmBQPspouMw4vHJjn4K1HORvCLiVWGrk
 j/ByQ4sOCbhHcsV7apwFrQNHUWCpaO2Cto5TGFbxyZQQnkwp0esS2ICyHxiM0No9xJGq
 S9ALqiQ1xYWtG3vcFurQoKA1fhTNmnhJJKbZmVu/zG8mAH9NEVjUsETbcovaybZ4lrEy
 zjnA==
X-Gm-Message-State: AOJu0YyDUf7erCqovrX2OEYv5uCwKXRXdpztkrXz91KTezbSgr5zS7V8
 QZs7YFDg0rtxL/IDt7LEIoOBwA==
X-Google-Smtp-Source: AGHT+IG8LSVkwmWrms+Ntwayfs+IJoIub9rPb0DJggaa2lavuAkUx8+2eQrMXQS1SXwJ2VNoFKIzkg==
X-Received: by 2002:a17:902:e852:b0:1c5:59dc:6e93 with SMTP id
 t18-20020a170902e85200b001c559dc6e93mr19645162plg.3.1696826879043; 
 Sun, 08 Oct 2023 21:47:59 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a170902ec0400b001c452f827casm8406010pld.257.2023.10.08.21.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 21:47:58 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v8 1/5] vhost-user-common: send get_inflight_fd once
Date: Mon,  9 Oct 2023 12:46:57 +0800
Message-ID: <20231009044735.941655-2-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009044735.941655-1-fengli@smartx.com>
References: <20231009044735.941655-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x629.google.com
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
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
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


