Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BAF7B7A6D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:44:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUL-0003je-W2; Wed, 04 Oct 2023 04:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUB-0003BS-Dc
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxU9-00016k-E4
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VdkDMoSG0ALTkXUGlr32gq6+4cpswzQxj8odNE61Qs8=;
 b=Oby9UZPOeEEhzzHgMmsY2KvsmOxmyoepmJnV0MjAseNik1/Dc02Pm+mVYuWvZGEMpLe2U5
 yjsnGxbtVhp+BdXtZvxmLsy/Dhmg8UIuw5W+te42utVIG1eveeGyj/qHlNbjFXnp/umN6i
 aydvo1gUYLkSYwDRscMwPtaoRVBVhTY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-8cDxAEQqPNSrp_baVY66aw-1; Wed, 04 Oct 2023 04:43:42 -0400
X-MC-Unique: 8cDxAEQqPNSrp_baVY66aw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40566c578b7so14656265e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409021; x=1697013821;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VdkDMoSG0ALTkXUGlr32gq6+4cpswzQxj8odNE61Qs8=;
 b=X7EoW6PuuDVWOoFNc7gylmin2WZcwXSvUKenq/tvE3Urs/HY7K6Uvlmnnd7hbaqxmw
 6qLutxbJkNv+QYNE9evAoMcEiuPQnF1lExLn7HVOJcRtK6i05NuTKAoQkRyGFNECnAtm
 aRzUApjp96RNY7Z1pu73YSObADj/xcfrt2brgcp/+7kSXtzpGWTMGYg0o+hXOxNvbv2d
 ej8szOfixn/k6JOhwEqUVpLts9Albx7vxAvqgb6JvCpPb4baXaN9tRwJBwgT0x2eMnBc
 m3WL3sSev8qd4EQ5y46Q4kI6ghiZVI+uaKVmIUtLXx4l4upy6mGhMk+1cIUd5SC83Xgw
 0bJA==
X-Gm-Message-State: AOJu0Yw2NM+jPgqOScAGxVM0rWoBF2Ux7DCTMLBUSjQrLln1aBJTHXbv
 FBeDIVR4c8bn4RSMCEARdR2yeqfn6EACvMZUZ7Kh2VKdYMRya75lLnk2VznWb0LA8sM7bnbNOGj
 +WedjdCsgh8J2T9yskr0laocwN0mgNwCsMZMKqmRxnC8lZweq6UHYCDxZL3+C1lyLWe1j
X-Received: by 2002:a05:600c:2146:b0:401:daf2:2735 with SMTP id
 v6-20020a05600c214600b00401daf22735mr1581552wml.31.1696409020961; 
 Wed, 04 Oct 2023 01:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESpypAYa3OXbmQaCyX7j15DzTwAubeV6clAb0EFmMrV6z7kIqCdA/i4yac+dPZzQ6TzdIJkw==
X-Received: by 2002:a05:600c:2146:b0:401:daf2:2735 with SMTP id
 v6-20020a05600c214600b00401daf22735mr1581537wml.31.1696409020581; 
 Wed, 04 Oct 2023 01:43:40 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 t25-20020a1c7719000000b004065daba6casm932528wmi.46.2023.10.04.01.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:39 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 09/63] hw/virtio: add config support to vhost-user-device
Message-ID: <45387e1d94f4c7bad460b98bbf6b929b0fda27e6.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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

From: Alex Bennée <alex.bennee@linaro.org>

To use the generic device the user will need to provide the config
region size via the command line. We also add a notifier so the guest
can be pinged if the remote daemon updates the config.

With these changes:

  -device vhost-user-device-pci,virtio-id=41,num_vqs=2,config_size=8

is equivalent to:

  -device vhost-user-gpio-pci

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230710153522.3469097-11-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user-device.h |  1 +
 hw/virtio/vhost-user-device.c         | 58 ++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/vhost-user-device.h b/include/hw/virtio/vhost-user-device.h
index 9105011e25..3ddf88a146 100644
--- a/include/hw/virtio/vhost-user-device.h
+++ b/include/hw/virtio/vhost-user-device.h
@@ -22,6 +22,7 @@ struct VHostUserBase {
     CharBackend chardev;
     uint16_t virtio_id;
     uint32_t num_vqs;
+    uint32_t config_size;
     /* State tracking */
     VhostUserState vhost_user;
     struct vhost_virtqueue *vhost_vq;
diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
index b0239fa033..2b028cae08 100644
--- a/hw/virtio/vhost-user-device.c
+++ b/hw/virtio/vhost-user-device.c
@@ -117,6 +117,42 @@ static uint64_t vub_get_features(VirtIODevice *vdev,
     return vub->vhost_dev.features & ~(1ULL << VHOST_USER_F_PROTOCOL_FEATURES);
 }
 
+/*
+ * To handle VirtIO config we need to know the size of the config
+ * space. We don't cache the config but re-fetch it from the guest
+ * every time in case something has changed.
+ */
+static void vub_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    Error *local_err = NULL;
+
+    /*
+     * There will have been a warning during vhost_dev_init, but lets
+     * assert here as nothing will go right now.
+     */
+    g_assert(vub->config_size && vub->vhost_user.supports_config == true);
+
+    if (vhost_dev_get_config(&vub->vhost_dev, config,
+                             vub->config_size, &local_err)) {
+        error_report_err(local_err);
+    }
+}
+
+/*
+ * When the daemon signals an update to the config we just need to
+ * signal the guest as we re-read the config on demand above.
+ */
+static int vub_config_notifier(struct vhost_dev *dev)
+{
+    virtio_notify_config(dev->vdev);
+    return 0;
+}
+
+const VhostDevConfigOps vub_config_ops = {
+    .vhost_dev_config_notifier = vub_config_notifier,
+};
+
 static void vub_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     /*
@@ -141,12 +177,21 @@ static int vub_connect(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    struct vhost_dev *vhost_dev = &vub->vhost_dev;
 
     if (vub->connected) {
         return 0;
     }
     vub->connected = true;
 
+    /*
+     * If we support VHOST_USER_GET_CONFIG we must enable the notifier
+     * so we can ping the guest when it updates.
+     */
+    if (vub->vhost_user.supports_config) {
+        vhost_dev_set_config_notifier(vhost_dev, &vub_config_ops);
+    }
+
     /* restore vhost state */
     if (virtio_device_started(vdev, vdev->status)) {
         vub_start(vdev);
@@ -214,11 +259,20 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
         vub->num_vqs = 1; /* reasonable default? */
     }
 
+    /*
+     * We can't handle config requests unless we know the size of the
+     * config region, specialisations of the vhost-user-device will be
+     * able to set this.
+     */
+    if (vub->config_size) {
+        vub->vhost_user.supports_config = true;
+    }
+
     if (!vhost_user_init(&vub->vhost_user, &vub->chardev, errp)) {
         return;
     }
 
-    virtio_init(vdev, vub->virtio_id, 0);
+    virtio_init(vdev, vub->virtio_id, vub->config_size);
 
     /*
      * Disable guest notifiers, by default all notifications will be via the
@@ -268,6 +322,7 @@ static void vub_class_init(ObjectClass *klass, void *data)
     vdc->realize = vub_device_realize;
     vdc->unrealize = vub_device_unrealize;
     vdc->get_features = vub_get_features;
+    vdc->get_config = vub_get_config;
     vdc->set_status = vub_set_status;
 }
 
@@ -295,6 +350,7 @@ static Property vud_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
     DEFINE_PROP_UINT16("virtio-id", VHostUserBase, virtio_id, 0),
     DEFINE_PROP_UINT32("num_vqs", VHostUserBase, num_vqs, 1),
+    DEFINE_PROP_UINT32("config_size", VHostUserBase, config_size, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST


