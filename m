Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 059717D2249
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:29:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUiU-0007Hl-Ip; Sun, 22 Oct 2023 05:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUiS-0007EX-Ps
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUiR-0000tg-7D
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEyHp47zWZMmJ4LBbWEQwLbSqJ+uzpsgbL7RPabK7bU=;
 b=LGG8ylTTzCQYbHbHKUSEkNyxWCXxO4T9PP8hLwe+N2jePCo+zjxzhaTh2p35ViyVWQiYbf
 b/70lPYHPTECqnOgU9LXgrB9yxU46faDJHyMaokkU8D95M0wfV5gWbWafHOiyYV/gPY6rq
 5iZn6w2++t1st6GELLF5kgbRhlRJyGU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-NP7j4HmeMim1TQPaOYMErg-1; Sun, 22 Oct 2023 05:25:44 -0400
X-MC-Unique: NP7j4HmeMim1TQPaOYMErg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5079f6c127cso2176125e87.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966742; x=1698571542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEyHp47zWZMmJ4LBbWEQwLbSqJ+uzpsgbL7RPabK7bU=;
 b=gpNszoVYwu7S4aO1YgHcz42mb2bAseS8R6b8RltL3KsoxoyAEIEW2g4QSnXJfw1bbT
 Anxa5GS2Mt/c6waBBc3pb9A4r13G1U7fVvr97wvbGfgan602K+Jzxz/ewHfUGqfK9uIn
 BMLXMrJ9GK5eGutrr8L51ESvk2+n1yPR+pbUFp6j2+TpRu2E4dStIA1UOcE6JJe6elfu
 LBEdJ9pwBFR0fDWyOGBTsSvo0BUnd4dKTaktzErdB5fWpSzvpis45ZJx7IBRcF0BArMu
 Z+fU/t5/Mb1h3X7q0Nv2zLscwfebaZEutSG3tu4eug25WsN5t3gqstx9w2o1yPZu7X00
 +PIA==
X-Gm-Message-State: AOJu0Yy2ngWiCbhuJKh2+x/ejUL9WmB9a8LfhIDeqo1LiGI48vloIVwQ
 SCu8GUxq0Nf7vZssGHV2CSMq46+c3Wy1Wq3MQ9G3jUbrt9UN+qX8yPNIityyIU+BRh7rfU9A7mE
 h8dbz4W+I4iyjhvdhFtgs7GT7UFi4lSuri9RTlatRCf8guIIwO3tCb1Fk5sc5TYWVy3jk
X-Received: by 2002:a05:6512:23a0:b0:503:343a:829f with SMTP id
 c32-20020a05651223a000b00503343a829fmr5437095lfv.23.1697966742779; 
 Sun, 22 Oct 2023 02:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA9HxvUMiXLe64W4lUmSchfSS3jdyLd5CLbs6fPpeHoHQsE1TqeS3RuOi9vAQP6ThYdV5zAA==
X-Received: by 2002:a05:6512:23a0:b0:503:343a:829f with SMTP id
 c32-20020a05651223a000b00503343a829fmr5437078lfv.23.1697966742396; 
 Sun, 22 Oct 2023 02:25:42 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 v3-20020a05600c428300b003fee8793911sm6375126wmc.44.2023.10.22.02.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:25:41 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:25:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL v3 51/62] vhost-user-common: send get_inflight_fd once
Message-ID: <f7bd1437ba877e6509fff2b5ffce82500bc79559.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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


