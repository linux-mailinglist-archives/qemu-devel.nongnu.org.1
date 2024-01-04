Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8234824A12
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 22:12:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUzh-0007oI-AA; Thu, 04 Jan 2024 16:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyW-0006xd-V7
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:10:04 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyT-0007VA-1F
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:09:59 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3367632ce7bso685406f8f.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704402595; x=1705007395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUt/1uqyWaURmVAVVhlqD6XH9TChabURPi6+UCY421E=;
 b=gOKRMYXj0XR5JMaNzepaez0PaMD37d/3Cr75TrriUzoOjTQPE2qu1ube7hGYyc5zRX
 UETsDwFsPs/U17YH66GL846/Wo2RnSFn5i2dPM85vZYZC5ohD+ka8wIflukQrYZh3AWe
 ebBEkfETayg6p96YdipMyFZUAsIKhy3ATnt90wr0X2PmjTvEHXzbdR4IywzSGKiFH8p7
 qEcE6cIvPdLbBd2u0D4TIlhX0BJN9Gv3xq9hPgI9FmDl8P2LBEYumTEIomdIcgqIBEL6
 nhjFcJUrbw2HHYnGcx23TU5okhuXTQK3z2M9TMejO+FeR+XBhyV7//3UA2lgLG2/Eo22
 cuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704402595; x=1705007395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YUt/1uqyWaURmVAVVhlqD6XH9TChabURPi6+UCY421E=;
 b=eGXC0efE0KXWpkpJugKDBm+jmscuARaAugvjTlgS2al5A3B/Myii5+DhGd6ab6Wl5t
 hzQ95Wft2ZnUE2i0MHI99CWuNxp8F7xH1w6YYrlZuBTcKxp4UMLUSYmr/GeOlCHp2KFn
 Wj/pFA3mN8lSska+iB1srS53dlRueOYEjT5ep0u/dqQlL/HUX0KuoMTbzu4oi3qKGSAZ
 7uvFVH5VzRtwFub4sQt1MjDqrcCsY7HH/LhmyuMeYP2CQFUEmlvd/Ex/H1foVNTOqka5
 JG7Qm13q1kznVYKuqAzv8szM42Zu1icxJvxo8l7orMzKiw6lrte7Ap5PY4+ddC1PIgcY
 nx3Q==
X-Gm-Message-State: AOJu0YySppVL5g71i/LwtwWN7xcb7jl0059/Q7YEGHLR6b5u1aX4QxAP
 IV249gvIcj034PML9VvFfRnGZwDzjjM8FQ==
X-Google-Smtp-Source: AGHT+IEeRUn11lBEN4h6LjwutqZ9pByY8GQv9DPwG573YbXlYSSuLjSqpK24Eto3Cw41wCnqiRygTQ==
X-Received: by 2002:a5d:5d0e:0:b0:336:7a5c:ffdf with SMTP id
 ch14-20020a5d5d0e000000b003367a5cffdfmr902957wrb.13.1704402595038; 
 Thu, 04 Jan 2024 13:09:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f17-20020adfc991000000b0033609b71825sm107862wrh.35.2024.01.04.13.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:09:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B0755F92F;
 Thu,  4 Jan 2024 21:09:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jason Wang <jasowang@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v9 11/11] hw/virtio: derive vhost-user-input from
 vhost-user-base
Date: Thu,  4 Jan 2024 21:09:45 +0000
Message-Id: <20240104210945.1223134-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104210945.1223134-1-alex.bennee@linaro.org>
References: <20240104210945.1223134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Leo Yan <leo.yan@linaro.org>

This patch derives vhost-user-input from vhost-user-base class, so make
the input stub as a simpler boilerplate wrapper.

With the refactoring, vhost-user-input adds the property 'chardev', this
leads to conflict with the vhost-user-input-pci adds the same property.
To resolve the error, remove the duplicate property from
vhost-user-input-pci.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20231120043721.50555-5-leo.yan@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/virtio/virtio-input.h |   6 +-
 hw/virtio/vhost-user-input-pci.c |   3 -
 hw/virtio/vhost-user-input.c     | 114 +++++--------------------------
 3 files changed, 21 insertions(+), 102 deletions(-)

diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-input.h
index a6c97036440..e69c0aeca38 100644
--- a/include/hw/virtio/virtio-input.h
+++ b/include/hw/virtio/virtio-input.h
@@ -1,6 +1,8 @@
 #ifndef QEMU_VIRTIO_INPUT_H
 #define QEMU_VIRTIO_INPUT_H
 
+#include "hw/virtio/vhost-user.h"
+#include "hw/virtio/vhost-user-base.h"
 #include "ui/input.h"
 #include "sysemu/vhost-user-backend.h"
 
@@ -97,9 +99,7 @@ struct VirtIOInputHost {
 };
 
 struct VHostUserInput {
-    VirtIOInput                       parent_obj;
-
-    VhostUserBackend                  *vhost;
+    VHostUserBase parent_obj;
 };
 
 void virtio_input_send(VirtIOInput *vinput, virtio_input_event *event);
diff --git a/hw/virtio/vhost-user-input-pci.c b/hw/virtio/vhost-user-input-pci.c
index b858898a363..3f4761ce88a 100644
--- a/hw/virtio/vhost-user-input-pci.c
+++ b/hw/virtio/vhost-user-input-pci.c
@@ -30,9 +30,6 @@ static void vhost_user_input_pci_instance_init(Object *obj)
 
     virtio_instance_init_common(obj, &dev->vhi, sizeof(dev->vhi),
                                 TYPE_VHOST_USER_INPUT);
-
-    object_property_add_alias(obj, "chardev",
-                              OBJECT(&dev->vhi), "chardev");
 }
 
 static const VirtioPCIDeviceTypeInfo vhost_user_input_pci_info = {
diff --git a/hw/virtio/vhost-user-input.c b/hw/virtio/vhost-user-input.c
index 4ee3542106e..bedec0468c3 100644
--- a/hw/virtio/vhost-user-input.c
+++ b/hw/virtio/vhost-user-input.c
@@ -5,83 +5,25 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
-#include "qapi/error.h"
-
 #include "hw/virtio/virtio-input.h"
 
-static int vhost_input_config_change(struct vhost_dev *dev)
-{
-    error_report("vhost-user-input: unhandled backend config change");
-    return -1;
-}
-
-static const VhostDevConfigOps config_ops = {
-    .vhost_dev_config_notifier = vhost_input_config_change,
+static Property vinput_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+    DEFINE_PROP_END_OF_LIST(),
 };
 
-static void vhost_input_realize(DeviceState *dev, Error **errp)
-{
-    VHostUserInput *vhi = VHOST_USER_INPUT(dev);
-    VirtIOInput *vinput = VIRTIO_INPUT(dev);
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-
-    vhost_dev_set_config_notifier(&vhi->vhost->dev, &config_ops);
-    vinput->cfg_size = sizeof_field(virtio_input_config, u);
-    if (vhost_user_backend_dev_init(vhi->vhost, vdev, 2, errp) == -1) {
-        return;
-    }
-}
-
-static void vhost_input_change_active(VirtIOInput *vinput)
-{
-    VHostUserInput *vhi = VHOST_USER_INPUT(vinput);
-
-    if (vinput->active) {
-        vhost_user_backend_start(vhi->vhost);
-    } else {
-        vhost_user_backend_stop(vhi->vhost);
-    }
-}
-
-static void vhost_input_get_config(VirtIODevice *vdev, uint8_t *config_data)
-{
-    VirtIOInput *vinput = VIRTIO_INPUT(vdev);
-    VHostUserInput *vhi = VHOST_USER_INPUT(vdev);
-    Error *local_err = NULL;
-    int ret;
-
-    memset(config_data, 0, vinput->cfg_size);
-
-    ret = vhost_dev_get_config(&vhi->vhost->dev, config_data, vinput->cfg_size,
-                               &local_err);
-    if (ret) {
-        error_report_err(local_err);
-        return;
-    }
-}
-
-static void vhost_input_set_config(VirtIODevice *vdev,
-                                   const uint8_t *config_data)
+static void vinput_realize(DeviceState *dev, Error **errp)
 {
-    VHostUserInput *vhi = VHOST_USER_INPUT(vdev);
-    int ret;
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_GET_CLASS(dev);
 
-    ret = vhost_dev_set_config(&vhi->vhost->dev, config_data,
-                               0, sizeof(virtio_input_config),
-                               VHOST_SET_CONFIG_TYPE_FRONTEND);
-    if (ret) {
-        error_report("vhost-user-input: set device config space failed");
-        return;
-    }
+    /* Fixed for input device */
+    vub->virtio_id = VIRTIO_ID_INPUT;
+    vub->num_vqs = 2;
+    vub->vq_size = 4;
+    vub->config_size = sizeof(virtio_input_config);
 
-    virtio_notify_config(vdev);
-}
-
-static struct vhost_dev *vhost_input_get_vhost(VirtIODevice *vdev)
-{
-    VHostUserInput *vhi = VHOST_USER_INPUT(vdev);
-    return &vhi->vhost->dev;
+    vubc->parent_realize(dev, errp);
 }
 
 static const VMStateDescription vmstate_vhost_input = {
@@ -91,40 +33,20 @@ static const VMStateDescription vmstate_vhost_input = {
 
 static void vhost_input_class_init(ObjectClass *klass, void *data)
 {
-    VirtIOInputClass *vic = VIRTIO_INPUT_CLASS(klass);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_vhost_input;
-    vdc->get_config = vhost_input_get_config;
-    vdc->set_config = vhost_input_set_config;
-    vdc->get_vhost = vhost_input_get_vhost;
-    vic->realize = vhost_input_realize;
-    vic->change_active = vhost_input_change_active;
-}
-
-static void vhost_input_init(Object *obj)
-{
-    VHostUserInput *vhi = VHOST_USER_INPUT(obj);
-
-    vhi->vhost = VHOST_USER_BACKEND(object_new(TYPE_VHOST_USER_BACKEND));
-    object_property_add_alias(obj, "chardev",
-                              OBJECT(vhi->vhost), "chardev");
-}
-
-static void vhost_input_finalize(Object *obj)
-{
-    VHostUserInput *vhi = VHOST_USER_INPUT(obj);
-
-    object_unref(OBJECT(vhi->vhost));
+    device_class_set_props(dc, vinput_properties);
+    device_class_set_parent_realize(dc, vinput_realize,
+                                    &vubc->parent_realize);
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
 static const TypeInfo vhost_input_info = {
     .name          = TYPE_VHOST_USER_INPUT,
-    .parent        = TYPE_VIRTIO_INPUT,
+    .parent        = TYPE_VHOST_USER_BASE,
     .instance_size = sizeof(VHostUserInput),
-    .instance_init = vhost_input_init,
-    .instance_finalize = vhost_input_finalize,
     .class_init    = vhost_input_class_init,
 };
 
-- 
2.39.2


