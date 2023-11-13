Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 081557EA33E
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 20:03:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2cCz-0002el-MN; Mon, 13 Nov 2023 14:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2cCp-0002eU-VF
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:02:44 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2cCl-0000LT-2x
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:02:43 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41cb615c6fbso30100991cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 11:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699902158; x=1700506958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwfL1MMbcUd8gBQwuRg85QiTdLCeCUniVkLUUu4iwTE=;
 b=kGKjfWRfkUYZatdcGS5Jv91JIqdZvcfAg4CJH2mOl3N0XR/Ehy6pNYTsyQzYPSjCD8
 gi+4Ohsd3VNXCPa1lTtwyWnTedbqPit6PyoZQzCHZr5541u+nuVaCCmghQ7L5aOjoPQB
 8IS7s7EX8zAaQXax7Xcc74ZtD417Bt88Od9Rj/TG8U3oITlHZbjA/7LLYFQ1BeQLlDzn
 usCz/rIQLZkfaL1zRD1zeG1E05ZGzoka2133Qd2qCMWKOMyrrjL+uL4YOWa7eicMWUf2
 E0n81fwQgXt0SG+ocACAdS69c7JE2c4kGtSweSdVz3EHJU/hvbAnPrV5UqPb4fISsSPY
 P/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699902158; x=1700506958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LwfL1MMbcUd8gBQwuRg85QiTdLCeCUniVkLUUu4iwTE=;
 b=H9MfHF+51VpTcB6pJlcjmEjNiv+3bPFeGKrYohhLRh5Md4LdpxnvM8mhAeYhqqcZWx
 g0zDLaTbutICmuER0rt0ONh7snDiCKnN4h7I2ZT0BmuQ0Qx8hQmnkSLjUV3w1DJ8rT11
 6388E14FdTv/Z7kAd/KPudAC4+xP74KIepUVbgfYwNVsfp2uX1gH3gtUK8gDNxTOqN+J
 Mf+9G0zj2N3FGhpGatEcOrsfDElWEBmvVcVEGCPLD+jFbU5PiE77DQ74KVAdGOIbIKak
 J5R4p9ovmSLoFyPIAl+VI2PaELbxTYYyZ33iPbG2nbqQdImrvl+ZIvDeqPmjp9VahDyk
 LNaQ==
X-Gm-Message-State: AOJu0YykiUZr3qQn2lw66RqhkN6qD2a+4OrQ/iJeG0YJ+kAWYPl8R/wR
 KIuFiLALCOTGox6yfDymFqrCYYwWB2s1TZf0f50fuz60RZQ=
X-Google-Smtp-Source: AGHT+IHMwhGxEm29W18CsnP44pWmxKmrYqXtwg4Rbs5f9xyIhqZTCjUumIgOXotTyRIjwQUBqPOMIQ==
X-Received: by 2002:ac8:5bc2:0:b0:41c:dd22:e7c0 with SMTP id
 b2-20020ac85bc2000000b0041cdd22e7c0mr11728863qtb.29.1699902157983; 
 Mon, 13 Nov 2023 11:02:37 -0800 (PST)
Received: from localhost.localdomain ([12.186.190.1])
 by smtp.gmail.com with ESMTPSA id
 kq4-20020ac86184000000b004181c32dcc3sm2124834qtb.16.2023.11.13.11.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 11:02:36 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/4] hw/virtio: derive vhost-user-input from vhost-user-base
Date: Tue, 14 Nov 2023 03:02:11 +0800
Message-Id: <20231113190211.92412-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113190211.92412-1-leo.yan@linaro.org>
References: <20231113190211.92412-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=leo.yan@linaro.org; helo=mail-qt1-x830.google.com
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

This patch derives vhost-user-input from vhost-user-base class, so make
the input stub as a simpler boilerplate wrapper.

With the refactoring, vhost-user-input adds the property 'chardev', this
leads to conflict with the vhost-user-input-pci adds the same property.
To resolve the error, remove the duplicate property from
vhost-user-input-pci.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 hw/virtio/vhost-user-input-pci.c |   3 -
 hw/virtio/vhost-user-input.c     | 114 +++++--------------------------
 include/hw/virtio/virtio-input.h |   6 +-
 3 files changed, 21 insertions(+), 102 deletions(-)

diff --git a/hw/virtio/vhost-user-input-pci.c b/hw/virtio/vhost-user-input-pci.c
index b858898a36..3f4761ce88 100644
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
index 4ee3542106..bedec0468c 100644
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
+static void vinput_realize(DeviceState *dev, Error **errp)
 {
-    VHostUserInput *vhi = VHOST_USER_INPUT(dev);
-    VirtIOInput *vinput = VIRTIO_INPUT(dev);
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_GET_CLASS(dev);
 
-    vhost_dev_set_config_notifier(&vhi->vhost->dev, &config_ops);
-    vinput->cfg_size = sizeof_field(virtio_input_config, u);
-    if (vhost_user_backend_dev_init(vhi->vhost, vdev, 2, errp) == -1) {
-        return;
-    }
-}
+    /* Fixed for input device */
+    vub->virtio_id = VIRTIO_ID_INPUT;
+    vub->num_vqs = 2;
+    vub->vq_size = 4;
+    vub->config_size = sizeof(virtio_input_config);
 
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
-{
-    VHostUserInput *vhi = VHOST_USER_INPUT(vdev);
-    int ret;
-
-    ret = vhost_dev_set_config(&vhi->vhost->dev, config_data,
-                               0, sizeof(virtio_input_config),
-                               VHOST_SET_CONFIG_TYPE_FRONTEND);
-    if (ret) {
-        error_report("vhost-user-input: set device config space failed");
-        return;
-    }
-
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
 
diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-input.h
index a6c9703644..e69c0aeca3 100644
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
-- 
2.34.1


