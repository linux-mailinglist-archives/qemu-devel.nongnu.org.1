Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F877AB13D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 13:50:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjeen-00084D-L9; Fri, 22 Sep 2023 07:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qjeek-00083N-9S
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:49:10 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qjeeh-0000d1-Bn
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:49:10 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-274928c74b0so1384805a91.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1695383226; x=1695988026;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eP8kuKM1qKZ8jHbFZXOAaKaPzBH+J+kNlsheIRdgb4=;
 b=wMfVj90Rveau3e7Op4ZCb/ekipFzkWBwuucV7VZO75RNJrLqeC3hIa52z+LQxNbq9p
 NUiDflVENJGc0oTm7kh7O6cO3fQmqpG92TBL5KSFNgj7rFC9wIevdhIB+Gaw0BCQM8NX
 KexMSjE0HQ9UVcApKPwk9P5X9HNzvpahOl5YE+kkEf23suYL+4KoX7F9DiiQ83DGQqUz
 XmRt4rxGIfBbdjp/HYgQvIntiwqfd9tO8yK5V7bi7cMZqVM8Tg7iQoBmPYbSLlVKBHan
 /HM/oyJKYzPC8lbJazaXwX/ZdDQBJRL/qPpXLoelbqlJbiebKzCoGW7VZaBx8itfurDz
 guGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695383226; x=1695988026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1eP8kuKM1qKZ8jHbFZXOAaKaPzBH+J+kNlsheIRdgb4=;
 b=uTJlxeEZbYo9F2twkqH5UoTlq3k1TgtviYzCM/g1je3f6DtJh+LTt4X48HuO96chF6
 bQCvkqo+erkV+3/9Owik+9pcRuuXI13VE4halUqpdlCuDcRk1drjl/VUPYr0DgcRUXnJ
 7qxPQV8qEty/+lb3VUa8nbDFvrx8r736DjIG7sV4U2YScbIyfAEI9rdGDkjGXcyzsUVr
 o862Bjo0dGRtl8Qa376dy9uvuxj/Lerfori2wDAd5zTHJmYmeYBas/UG39Xd5Gc2f/q2
 /oLiX6yPJBCSGKmorqNLnav6px6lM6sc0HezPpFPnWr651dVeQ+Sz4V4CJi372xr1qFA
 6f0w==
X-Gm-Message-State: AOJu0Yz90pJJnssFGanSq5TxGVCJhfopdZccYTz/gWOza7zQKtb3H+ls
 HBt1qGHWbgdAo2tHIYcX/KelAg==
X-Google-Smtp-Source: AGHT+IEK7oFaVPM8D2Ye65pvi5ugoF6nWOtOEc9Npa8J9yGm9TKXCwgS4F1LTUmaXsCA8e/S8/l3GQ==
X-Received: by 2002:a17:90a:4dc6:b0:268:1e51:3496 with SMTP id
 r6-20020a17090a4dc600b002681e513496mr8004197pjl.21.1695383225373; 
 Fri, 22 Sep 2023 04:47:05 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 r6-20020a17090a438600b00263f41a655esm3303961pjg.43.2023.09.22.04.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 04:47:05 -0700 (PDT)
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
Subject: [PATCH v6 1/5] vhost-user-common: send get_inflight_fd once
Date: Fri, 22 Sep 2023 19:46:11 +0800
Message-ID: <20230922114625.5786-2-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922114625.5786-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230922114625.5786-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=fengli@smartx.com; helo=mail-pj1-x1036.google.com
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


