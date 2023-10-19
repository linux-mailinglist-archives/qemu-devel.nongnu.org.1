Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BE57D017D
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:29:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXiK-0002iJ-SD; Thu, 19 Oct 2023 14:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgw-0008UX-Er
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgu-000226-SE
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEyHp47zWZMmJ4LBbWEQwLbSqJ+uzpsgbL7RPabK7bU=;
 b=KT9QBjfS3aFDLVNr4yb830mlaWvbV8rix0bcUJJMjxTbJaLHe/qPss6qfVxFp/5jXZakbZ
 Jf1IbHI2dIu6Kogp7p4VEkM+sfvQZSdC+WnPqDtck1ZQ87vaUul0DFJJEiHe1Mn3CUtie7
 GsenayJE4vtHVDjWfe0jOCGFN9e2q1w=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-yZN_yiSVP5-_YcjlayL3bA-1; Thu, 19 Oct 2023 14:24:14 -0400
X-MC-Unique: yZN_yiSVP5-_YcjlayL3bA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c52cbb64c9so45317511fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739853; x=1698344653;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEyHp47zWZMmJ4LBbWEQwLbSqJ+uzpsgbL7RPabK7bU=;
 b=d7whFv7OXBnGlkd6WsYlXks0c03eMNy8p2OkDQEAoV36WV1Xiz3w2xZUFe9cg8l3kA
 fQ+Mpc5voZvRm97rHfkZBf5YmSdB2YuvOi3PGMg+9Z7sascH/IESYUus2bOWYR+hMXb4
 au4lzH51VxfE4gxy+aSznUQ5r8YM5FJ2w8s8tosHiTAh8GMoM9VHJgjXFNSSpeftY8lI
 imVFwrFCV3jdO79gcoRsbGbSccfOgTsmMewkD9wJX9jONt8rToWnWf8HiTp71MJhOAEx
 QzA+gR1Q60VTsy5fFj86EziHOns1wFMj5fTaELKsbUm53gBfIZ/aetKkDm3wKoa76HFd
 8Mig==
X-Gm-Message-State: AOJu0YwCG3woJC2dH2KZYzmtkC+OKmeCgKzY614TMqU/QF31bmPSBgbD
 7mD9+84PbK/BJ2dM7ULSUywXawC7/Uy0Kjv1zGCWqHKwHQKGb9OgMMuURYKNhU10Jjk8q2hDcHc
 Jfvj7xGRcBGTGW8OyXqPN7DczGhzliueXX3fON//JFRLL2Lg7m2K9HnZ28916wZvq9t4k
X-Received: by 2002:a19:7707:0:b0:507:a58f:79ac with SMTP id
 s7-20020a197707000000b00507a58f79acmr2023354lfc.33.1697739852796; 
 Thu, 19 Oct 2023 11:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXAonY27n0SDfsYA6P/4ctcBisBQNe5Ri9DgghBWKQWuHCbhUo5y7AZhHxMUMZ8wCz5/8H5A==
X-Received: by 2002:a19:7707:0:b0:507:a58f:79ac with SMTP id
 s7-20020a197707000000b00507a58f79acmr2023339lfc.33.1697739852456; 
 Thu, 19 Oct 2023 11:24:12 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a5d4489000000b003176c6e87b1sm4974275wrq.81.2023.10.19.11.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:24:11 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:24:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL v2 67/78] vhost-user-common: send get_inflight_fd once
Message-ID: <63a5c46a151c0d281d456de0474b7a27e87cd7ce.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently the get_inflight_fd will be sent every time the device is started, and
the backend will allocate shared memory to save the inflight state. If the
backend finds that it receives the second get_inflight_fd, it will release the
previous shared memory, which breaks inflight working logic.

This patch is a preparation for the following patches.

Signed-off-by: Li Feng <fengli@smartx.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <20231009044735.941655-2-fengli@smartx.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


