Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4F07695D2
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 14:14:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQRll-0003Ak-SL; Mon, 31 Jul 2023 08:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQRlk-0003AK-12
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:13:00 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQRli-00055j-Et
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:12:59 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-686d8c8fc65so3021911b3a.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690805456; x=1691410256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eP8kuKM1qKZ8jHbFZXOAaKaPzBH+J+kNlsheIRdgb4=;
 b=l6MwkPcoFSeTJtfcu+Qss2SrtxKQFDz3+RtMs0xBMXV2jwqvSSXEJvTv9hVm0TcbGn
 sbImZ9xPsYSNjowgscDTLA/x4tv2i/IyPXsfKYZ9w3JaunHyrjsGxKVNSh64T8VNf8bG
 0+PD4HfVhomqz17ti+0S3ST6CzEL+guoixpOPiilaavAY6gTprofFABGP7MdE83UV3qC
 GqCLeCJLyyFkasu+fHfUsVIfwgS2OR27h+uHa0tZMbDjEaIw/0rQoa5vGPImllwfzbQi
 HKcbC5nfaCES4PScugIQ1ZTtDD9/w+BeGH5SaP4nchT5N/u1i37dLo4HWeJyKSXeUmAX
 s0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690805456; x=1691410256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1eP8kuKM1qKZ8jHbFZXOAaKaPzBH+J+kNlsheIRdgb4=;
 b=V9s1y02s/UWiosZpXsZATc0Ug/wOvdBE5dLQ3LSrOykIYnwlHYez8bQGgwXgmeJ1zt
 y7JjpVN6341v0xgfe3ZeE/EL8SDIzvBX8PYKnbUGvHLpd3CrWRBbxnsQTM7wmUNOjgk0
 6puUP/uLlZmCx2lAhLNT3E5Zx2hujcW8iJiQt5qipZI63u03ImzHw8d6diPbFuEbyRgq
 EdUScfEmzerZou6jZUpWElgnZcjS5ojcUUDR6jDklZtyc92Jseb43FHg3PjrrZziWcUt
 9rKs1pgHc1e4W6nMhfAXun5lDiJtYzcH6/nJQmveSz1nWoz3NZLsqMRi6vB2zLcViGl6
 89YA==
X-Gm-Message-State: ABy/qLZKN5D6h1UZaPFTtH6WmTUfpGBMiNy1xXago+I5+9QHlmVbW5Vd
 YNEcVUi61TOhjTwUMHSYpkfknw==
X-Google-Smtp-Source: APBJJlGqTzcfJy5apNff7q34wYIt59/evlmKT3SBg7bE55FG3aKWyl+4cOVca8XTAG5y5BMaSqhx7g==
X-Received: by 2002:a05:6a20:7d9d:b0:137:8ddf:464b with SMTP id
 v29-20020a056a207d9d00b001378ddf464bmr9827745pzj.36.1690805456203; 
 Mon, 31 Jul 2023 05:10:56 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a62bd0a000000b005d22639b577sm7385690pff.165.2023.07.31.05.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 05:10:55 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v3 2/5] vhost-user-common: send get_inflight_fd once
Date: Mon, 31 Jul 2023 20:10:07 +0800
Message-ID: <20230731121018.2856310-3-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731121018.2856310-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230731121018.2856310-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


