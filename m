Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2147BCD72
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 11:14:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpPqP-0001nv-2y; Sun, 08 Oct 2023 05:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPqN-0001nN-J3
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 05:12:59 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPqK-0002Dr-ME
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 05:12:59 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c61bde0b4bso30754515ad.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 02:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696756375; x=1697361175;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtjO1lS5KyQU3h+Hf7ZgeU0iuEx8e6d6jY/0St+hkG8=;
 b=v5cXyPRQkFpnHlsmB8Dn1Anoie+sHD0D8sUyHFT6/zzzKfF2uu9HSbwfB0n92453R4
 7pYCQyPdxgNsorhuCiWKIwuF4Rfh9cjHE8g2AKyZYuZ90sVTVXhAqHb87RodAvpVBDZZ
 HibNppArgOM2o6PAc5s5xFlco8I4SUVbpiVCqvnTOCiUCqMkMMBITt3bHC++6zftqHTR
 8yJ8EN8xXGucgRBVtyNV+7ub3lTJo84QXJIL4ZFhouWUWlOfzSRYi9FclbOo7Vuh2XMI
 oJXFo9AMmh6WRelJILre/CCWg9YeVHdzLcvNyGqcgrjOSQZWHY9bSSKtssxDh9L5VpoX
 3g4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696756375; x=1697361175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KtjO1lS5KyQU3h+Hf7ZgeU0iuEx8e6d6jY/0St+hkG8=;
 b=u5RabmRf2uR4DK8WvTFqbQQIyibHv7b9OIBmdGgbKAyVHrlzBdpFuGCWlkvEMEXSbJ
 qElPnIQn5XLe8/09mLrEcogDFzTeEuXilFVlCYpllbiTPumOlL+FAG+05abAAzS3OFpb
 B+esoTVXjRgzE8IPlWv+C6yAl3vnTUggV3TNxfMymNVqkXFX12EVHg1Fn94yUUZfRcbM
 wvh8JSILj0LgMNU1y2viJQ0VtaH8+xmE8Gjp/iwWW/Hcike/9EUBC3vf4ALj9k2FGF0k
 S9lmC1RTZL1n7g8Skjn9jCecyF/ZB8wnHFoscLLvUwYsVYslErSrPD0VFq8/cfcY/0PU
 HmyQ==
X-Gm-Message-State: AOJu0Yz0jJK1QuKkb9YllpWiHCZsh/w2ZjqLvtuTJwsDvkduUL42CPBn
 ddBjSLIvQUeDQuE/Ll7ksfUXAw==
X-Google-Smtp-Source: AGHT+IG8t8Y8W45PdvoJOlZM5uJkz7QgMahd7vmW1LTACA67FyV2QbQRKM888LaQiM+tsDTfzKZP4Q==
X-Received: by 2002:a17:903:2611:b0:1c6:2fc0:9626 with SMTP id
 jd17-20020a170903261100b001c62fc09626mr11866290plb.6.1696756375321; 
 Sun, 08 Oct 2023 02:12:55 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a17090301c800b001b8a3e2c241sm7118084plh.14.2023.10.08.02.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 02:12:54 -0700 (PDT)
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
Subject: [PATCH v7 1/5] vhost-user-common: send get_inflight_fd once
Date: Sun,  8 Oct 2023 17:12:01 +0800
Message-ID: <20231008091220.870171-2-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008091220.870171-1-fengli@smartx.com>
References: <20231008091220.870171-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x62e.google.com
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


