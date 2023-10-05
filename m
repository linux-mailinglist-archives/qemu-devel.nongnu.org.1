Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0407B9A52
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:46:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFGt-0001kX-Sc; Wed, 04 Oct 2023 23:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGr-0001hW-I3
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGp-00008q-OY
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VdkDMoSG0ALTkXUGlr32gq6+4cpswzQxj8odNE61Qs8=;
 b=b+ENg8Gkeez0uM84C0e3SqesSOQtIjAlzSUxIiMBrT/DBmNOU1U/aovh/NgL6OyduNiMzt
 cAelQO+PQOP66QB5ogR+7eJ5X/Mf1ROTJqcYOdKmTAyNWATCfwC3ojc9HZ1qVxHSy4TwkH
 wIsC/34xut5r00V2zn5NEctjmEs8/n8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-bMnsi3nAPLGi0j89S_jJQw-1; Wed, 04 Oct 2023 23:43:01 -0400
X-MC-Unique: bMnsi3nAPLGi0j89S_jJQw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32588c87716so430646f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477380; x=1697082180;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VdkDMoSG0ALTkXUGlr32gq6+4cpswzQxj8odNE61Qs8=;
 b=qv/0rbFysPr0b7ZkkPW2lk3HqHnZuJjnYUjYK0BB0CMaMFkcTV3Gkn/ltWJo/QeLeS
 ybfYmFFVt13vCdZZhHKBj0+P3TzB53jW+gncvi+hEe8GqHt1EiS3M3V3SDIBYuoow8yi
 7dGkSKtzKV2wbJ7Qd2tDFSmYdKdShq6RYM4sgW6SX1LeON08Wp1Hd3Juh3+ldg2mlui5
 A2ATtdLGUa6pkVuBkaklPVDITVkHDOJg9ZGw07/jHEOAvMhGzN/3vstJQcL9AV8cMLY/
 33aeQhyww1gMDOVdswj8ml7oUEOJeQaF4krLAI7zSln5ahKOHRpHJKA1VJWeLanryJiq
 DgZA==
X-Gm-Message-State: AOJu0YzB2vZ9AwGwx3jaUbPnuu5YLGpRYJHYYcWLRQU/VuXxFpKrvrlj
 vtVWykLKa5JsuQw8+1XTaYpuVCEB/0g3OFFaIWLc5Drc7/8KQSqf+e/925GUVEkvIc6lDdxpOfJ
 7XOyOzt3r0rDI/i0FA8eWLhNpMcn/+kW9oqBjo1PlLegAoNwrUUQiQ7DohKOKljwbau55
X-Received: by 2002:adf:f286:0:b0:31f:db1b:7296 with SMTP id
 k6-20020adff286000000b0031fdb1b7296mr3834108wro.21.1696477379834; 
 Wed, 04 Oct 2023 20:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkONeCN8cY9mi+KGPe1bRx5/TiXl93iR27le+VC1JDIIRm2q2VxHA230oRi+aILvdPcthHxA==
X-Received: by 2002:adf:f286:0:b0:31f:db1b:7296 with SMTP id
 k6-20020adff286000000b0031fdb1b7296mr3834100wro.21.1696477379520; 
 Wed, 04 Oct 2023 20:42:59 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 p14-20020a056000018e00b0031984b370f2sm632633wrx.47.2023.10.04.20.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:42:58 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:42:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 09/53] hw/virtio: add config support to vhost-user-device
Message-ID: <f92a2d61cd86fd585b1b2a57295fcde278aebd78.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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


