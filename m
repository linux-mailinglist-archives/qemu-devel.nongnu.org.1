Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C408010F7
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:17:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r977S-000399-Ub; Fri, 01 Dec 2023 12:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r977K-0002yA-Ok
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r977J-0007qD-7c
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/1346WFPfT2DlqplCYFNEXbcgwKMGa8XcJVKkLgfMI=;
 b=DKpcbK2p99K9MENXy87fYYuMl+Ph5p/KLrxa+tLNQeha2jg1SXvjzFILSlW0Ot18ig6Uza
 8twExL/nQSzt2DIOWVDRTka8f2VFopYWVvWSFs/ug33Uf32TasB9OhHPZHXoyiEPvgIkRR
 WJf32GRcC+Wav+FLrMPenM3Ns4KpbL4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-HBvZZZsmM7mzxcnfTj0sdg-1; Fri, 01 Dec 2023 12:15:50 -0500
X-MC-Unique: HBvZZZsmM7mzxcnfTj0sdg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40b3d81399dso15777695e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450948; x=1702055748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/1346WFPfT2DlqplCYFNEXbcgwKMGa8XcJVKkLgfMI=;
 b=ufzpyUlhrIQvJF80hIdinP+bWRKY0yINHpJVif1K7nELI91WTTDaRbE0j68KKYc+W1
 1CEovyznzWmxpx1qgtlpeXyFl9PyyHsabdJX62A0OX6vFA63E38uEVruBfRPU8xI19RV
 dspKEZ2YWzPEQMjACJshvs9BnZf+QuP+RqLcFrv6G9KrerSOnbKPRwXeBmBbuNHFUWf7
 +9rSw1SfRAbZmJOyg1HtvfkWsQIWXtTBnbJyfxNmPmSbcFrA4apv6zRAEcKsjviZ2D8B
 RK+gIH3Uu5H8P20EbU/QbP0+AXVbu0VwodfwbGIU+fyIOQ3ac+GzWBC4Q5IArbtcRIaB
 Vk6w==
X-Gm-Message-State: AOJu0YzJPrwontMdeUVxKvqOpHhY+1JJfr6rI005nwmtDhf0ic7bgh7l
 +PqmapGIOzzylXsLqJ5+Fzk49c1FN5M7k7OlaoKoBtE3Qg0Lr1ei2E1KdBk6Ml49jC9MQoa5PsS
 s9s1ob9Tc95J0MvrflVoHxxq3O93RoeIKDucmWDlEBW71mZDqnjvY6oQiuXw2VvzcMOrR
X-Received: by 2002:a05:600c:502c:b0:40b:5f03:b430 with SMTP id
 n44-20020a05600c502c00b0040b5f03b430mr234461wmr.338.1701450948579; 
 Fri, 01 Dec 2023 09:15:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMPpLHmOqUohWYI4rLkYBzQ+qPC1wO5ht+svhYyNRWVUQIjzXqUVCIKlRM12adwtSyXLtJjQ==
X-Received: by 2002:a05:600c:502c:b0:40b:5f03:b430 with SMTP id
 n44-20020a05600c502c00b0040b5f03b430mr234450wmr.338.1701450948303; 
 Fri, 01 Dec 2023 09:15:48 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a05600c0a4400b0040b4ccdcffbsm6041208wmq.2.2023.12.01.09.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:47 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 15/15] vhost-user-scsi: free the inflight area when reset
Message-ID: <d4ad718733df4c87b9133bb57ea77b0040923541.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Keep it the same to vhost-user-blk.
At the same time, fix the vhost_reset_device.

Signed-off-by: Li Feng <fengli@smartx.com>
Message-Id: <20231123055431.217792-3-fengli@smartx.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/scsi/vhost-user-scsi.c | 16 ++++++++++++++++
 hw/virtio/virtio.c        |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 2060f9f94b..780f10559d 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -360,6 +360,20 @@ static Property vhost_user_scsi_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void vhost_user_scsi_reset(VirtIODevice *vdev)
+{
+    VHostUserSCSI *s = VHOST_USER_SCSI(vdev);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+
+    vhost_dev_free_inflight(vsc->inflight);
+}
+
+static struct vhost_dev *vhost_user_scsi_get_vhost(VirtIODevice *vdev)
+{
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(vdev);
+    return &vsc->dev;
+}
+
 static const VMStateDescription vmstate_vhost_scsi = {
     .name = "virtio-scsi",
     .minimum_version_id = 1,
@@ -385,6 +399,8 @@ static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
     vdc->set_config = vhost_scsi_common_set_config;
     vdc->set_status = vhost_user_scsi_set_status;
     fwc->get_dev_path = vhost_scsi_common_get_fw_dev_path;
+    vdc->reset = vhost_user_scsi_reset;
+    vdc->get_vhost = vhost_user_scsi_get_vhost;
 }
 
 static void vhost_user_scsi_instance_init(Object *obj)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e5105571cf..3a160f86ed 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2137,7 +2137,7 @@ void virtio_reset(void *opaque)
         vdev->device_endian = virtio_default_endian();
     }
 
-    if (vdev->vhost_started) {
+    if (vdev->vhost_started && k->get_vhost) {
         vhost_reset_device(k->get_vhost(vdev));
     }
 
-- 
MST


