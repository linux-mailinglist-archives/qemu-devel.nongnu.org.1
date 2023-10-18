Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3DD7CE22E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:07:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8x5-0001cg-9J; Wed, 18 Oct 2023 11:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8wq-0001Nt-AT
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8wn-0007cQ-2R
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEyHp47zWZMmJ4LBbWEQwLbSqJ+uzpsgbL7RPabK7bU=;
 b=DKZ26dpPQOyc7nLYRxP/hK220V4/ft6iaGPorxZm/bVf+YfubO4YTeGoIZk2Run2QZbk0O
 jiFqIptPHrrvreZ8OVaNQpokfFEhi7ToF1PYW4BMfBA/F4ST0Ho9Xnk109hORzsift0bPl
 CqLL4OpV8M6aBJ/Y448Vwo0ql7J3ors=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-B2YKg24JPXOIFtr4yN5jJA-1; Wed, 18 Oct 2023 11:58:58 -0400
X-MC-Unique: B2YKg24JPXOIFtr4yN5jJA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507c8a8e5d1so917254e87.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644736; x=1698249536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEyHp47zWZMmJ4LBbWEQwLbSqJ+uzpsgbL7RPabK7bU=;
 b=c6Ca2AFHj/99vdUWT7anrqaiEu4apXGyhqNr7FC1cSCm9VBpJdWsrMw8KearU6YkT9
 hemhSTeTyUjgkLns+PHEmiuMDYjNhFE/sbpTeodBfefUJTyUAcoyA9EPLC9RYL721x6v
 8MK4ylv1jnGPQqLUTGjK13w/UAoFLw9tl2c1SkMOA/begVddYU89xVwM4j9XQcqfo6h2
 N/rTPZmsfnR3pfJJpvILltKiPzAq5tzJ72ZhY3xeBzcfOqENKr+0uHeBmGb8rQCZhRpD
 08aFhwTx0abIZMpLjiIm3WPKoznNb5EzsCmhWY74tYqBIUP0YA0eEqvGRx3idm14HiEY
 iwVg==
X-Gm-Message-State: AOJu0YxiMjh39qd+lzjRPdZzwT+7QtDkythddsF1cr+1QNj2yOfIA4hR
 qG2iGA/FqqT0sDuoncXJZu8CrexjITFSFKFxOtYheCDpJ+ks84UVWJmygqtmkmBNL/B7qHHM5oV
 aeBk0FbC/lmO3BB38SS5C8OCHmnZRhlti5S9Glk6IrSX3ZLMcubrr2Yl1T5asz45bLiaCP5M=
X-Received: by 2002:a05:6512:b9e:b0:500:92f1:c341 with SMTP id
 b30-20020a0565120b9e00b0050092f1c341mr5424890lfv.54.1697644736076; 
 Wed, 18 Oct 2023 08:58:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9BBpiZFk2AtITs+j1wRjrBHVJap4nDNjUb86Dfxu1ZIGEoqCxpdYf7QusEt9qkk58+wXBQg==
X-Received: by 2002:a05:6512:b9e:b0:500:92f1:c341 with SMTP id
 b30-20020a0565120b9e00b0050092f1c341mr5424879lfv.54.1697644735786; 
 Wed, 18 Oct 2023 08:58:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a05600c3b8d00b004053e9276easm2053317wms.32.2023.10.18.08.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:58:54 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:58:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 72/83] vhost-user-common: send get_inflight_fd once
Message-ID: <772346132e16f493c1cd354a0b9bd8561a1372b7.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


