Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D8C7F0B74
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 05:38:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4w2f-0000EJ-83; Sun, 19 Nov 2023 23:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r4w2d-0000E8-4S
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 23:37:47 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r4w2b-0003Ak-Ak
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 23:37:46 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1f5bd86ceb3so1458023fac.2
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 20:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700455063; x=1701059863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6J3RP6xz4scGjmPj01RG5aacRVJuHKa6R4XaJ4bEqpM=;
 b=db7aJCQA0Hu3fhq+r62QV5Os3ghpEPDlEgjrHBJ5QmKS0oFc1hzu2pLhaXRrcx6m19
 ZPbNkcNDf1BK0rVNIqcdYwnIwhI/fAdnaZHHZDfeZnzTIDodk0+7AH+aRMg0d5mnK4MM
 S65wyh9VHck1u31ySSYogy/iFPEQk1DLGGlcQF8q+Q+VR54+oYedv2ArJueSXsK62zd7
 Lxg3dlfjLDN+5ozYIz4rs/A3GgWup/QjLWgTYqWojlIYxLOf6iVM9QwRsXIGP6DXsh0D
 JFt3EvOCB2KytFrtwMKiXMK3hjXV7dG4XrUOyUHcieUe9fJm40UzNAjZOSpIaeWXGQtK
 7Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700455063; x=1701059863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6J3RP6xz4scGjmPj01RG5aacRVJuHKa6R4XaJ4bEqpM=;
 b=hvHWCzsxsnhoW7i4Y34+JML6QmnENgLWmUJ3k04GOkr53057/Do/TZCd1aGgV4NwRD
 +zsrKUBB+ue0zS9ia9fkl70p19RiMxZ9G99F7I7S/tLZrI4IZeulRZvmAMY5CFGz7zX6
 A3bzlQtn8rdorL8viXNyY6Z3/Ze7ofJpwnf4VZ9xDvqwz2Ykgq+dAlRAbJYI27XrfyLc
 cmFG4GWatLDFluE4ZBM8dVGzyVvszoWD2M0383m6Q3d78eIcryMeyFDaYP0NKDfQOuuE
 zLZaIOY0+yAuALsQlnblEJBbzDRGFzWzYSdFOggZaDVKAcGg0zuJPKMBsjKUwDW+Kg9I
 y2pw==
X-Gm-Message-State: AOJu0YyGvTusa47BpxPECq4ljfhQy+aNR25mtQ8hB+fDF2bac4BCUuqC
 yUx+IL7+iPzrFrW2so3tuURu/u0wkuej6AYLNIm7ZPB7K+ygEA==
X-Google-Smtp-Source: AGHT+IG2EbVWS3B+SN1V9dGtnhj4pEf1abCdm+Gs+rZRMBBeYOyTCjJ7oiCT95tWo9XnnILYecAogw==
X-Received: by 2002:a05:6871:79a2:b0:1e9:9742:7dfd with SMTP id
 pb34-20020a05687179a200b001e997427dfdmr8381279oac.31.1700455063504; 
 Sun, 19 Nov 2023 20:37:43 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-202.hinet-ip.hinet.net.
 [211.75.219.202]) by smtp.gmail.com with ESMTPSA id
 s41-20020a056a0017a900b006926d199fdcsm5035991pfg.190.2023.11.19.20.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 20:37:42 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 4/4] hw/virtio: derive vhost-user-input from vhost-user-base
Date: Mon, 20 Nov 2023 12:37:21 +0800
Message-Id: <20231120043721.50555-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120043721.50555-1-leo.yan@linaro.org>
References: <20231120043721.50555-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=leo.yan@linaro.org; helo=mail-oa1-x2e.google.com
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
2.39.2


