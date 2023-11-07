Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CBF7E47E0
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:10:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QUp-00070F-OF; Tue, 07 Nov 2023 13:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QUe-0006sj-0L
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:08:04 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QUY-00026Q-KT
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:08:02 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c6ed1b9a1cso80389651fa.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699380476; x=1699985276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=supSeGzfD/y8xW5AbmDpFKuvfKIZg+F8YXe+QutqV+M=;
 b=rL/VAr7OZPO/+yMuMSVFnn/XDMRRyRTFQVbczk6g+jBAxw3ONXIG43ioU7t0wPMrGj
 ckGd7a0LfdjMQ2i0g39JpIX0RmqZ+5WkUS/O7D8L9aF0I+S/IaYGQ93EsCT+eGsz2/pl
 qAKWrKfGbKEKEfpMxRyTtytNQNUo8/8l7wbg3IaGNDB+cwQs0SNZE/vy8lQ0ldHsKRQd
 vpvGz7Koh5Qtv6ROq6HJjWQwuto1l0gK5N0THpVa/A5zGnvsFEVuBWmPrYsL/xyPmgSj
 qvkDfQnInvpOJ05QAripSJZK6oVdvYV67SetUmOU7EmoB3GVftmmm6B2Oym8wae/CQb9
 y19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380476; x=1699985276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=supSeGzfD/y8xW5AbmDpFKuvfKIZg+F8YXe+QutqV+M=;
 b=wL3f40tdnEBT8lG44aY/8EeU+oPqSs2ZO0nr/2n8tHNUgcZA4/QUmJ7j3WchQdGIFv
 j9U4lnFtKjjKK5w87Gclmsh0RkzG1racwm4n4xcHmyY0qSpa5S0AyYRr5CEy7g0SgFMd
 XSYTLaCGWJ4PRwpKiOgz1ecPAALuQiGXPFR/iLYeYqPiEQ1i6cIgXfHfrSCeUzsi/3R/
 YYVNgcQdXG4bxR8yzb03a44zfB32E6vsB8G4eIv0UPu/N9DXPUap9heymMwe9yWSz2jk
 tInbP8VjKtE2lJM5/4U+4EKPziYriKDfu6AF6RbLwXTqRcN0GPlRt7VfalQsHk8l8hQu
 j0Sg==
X-Gm-Message-State: AOJu0Yzu55TwlAPwappTt+HztNmImZhOIbNMo3/NyPBQVO+zMXmiatKs
 Wo7qyNDaJ+q996z//mUwokFnEg==
X-Google-Smtp-Source: AGHT+IHlhOJtHur4ytncMUVNmopG1dQWiJtGJLBf2z71FDo+BsBRYDZ6Fpu8pdK+yb3DAm83QBQFjA==
X-Received: by 2002:a2e:b52c:0:b0:2c5:2132:24f5 with SMTP id
 z12-20020a2eb52c000000b002c5213224f5mr25347433ljm.53.1699380476034; 
 Tue, 07 Nov 2023 10:07:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o8-20020a05600c510800b00407752f5ab6sm16782492wms.6.2023.11.07.10.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:07:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CC85965759;
 Tue,  7 Nov 2023 18:07:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, virtio-fs@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v8 4/7] hw/virtio: derive vhost-user-gpio from vhost-user-base
Date: Tue,  7 Nov 2023 18:07:49 +0000
Message-Id: <20231107180752.3458672-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107180752.3458672-1-alex.bennee@linaro.org>
References: <20231107180752.3458672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Now the new base class supports config handling we can take advantage
and make vhost-user-gpio a much simpler boilerplate wrapper. Also as
this doesn't require any target specific hacks we only need to build
the stubs once.

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v7
  - s/parent/parent_obj/
---
 include/hw/virtio/vhost-user-gpio.h |  25 +-
 hw/virtio/vhost-user-gpio.c         | 406 ++--------------------------
 hw/virtio/meson.build               |   5 +-
 3 files changed, 22 insertions(+), 414 deletions(-)

diff --git a/include/hw/virtio/vhost-user-gpio.h b/include/hw/virtio/vhost-user-gpio.h
index a9d3f9b049..5814a8400a 100644
--- a/include/hw/virtio/vhost-user-gpio.h
+++ b/include/hw/virtio/vhost-user-gpio.h
@@ -12,34 +12,13 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
-#include "standard-headers/linux/virtio_gpio.h"
-#include "chardev/char-fe.h"
+#include "hw/virtio/vhost-user-base.h"
 
 #define TYPE_VHOST_USER_GPIO "vhost-user-gpio-device"
 OBJECT_DECLARE_SIMPLE_TYPE(VHostUserGPIO, VHOST_USER_GPIO);
 
 struct VHostUserGPIO {
-    /*< private >*/
-    VirtIODevice parent_obj;
-    CharBackend chardev;
-    struct virtio_gpio_config config;
-    struct vhost_virtqueue *vhost_vqs;
-    struct vhost_dev vhost_dev;
-    VhostUserState vhost_user;
-    VirtQueue *command_vq;
-    VirtQueue *interrupt_vq;
-    /**
-     * There are at least two steps of initialization of the
-     * vhost-user device. The first is a "connect" step and
-     * second is a "start" step. Make a separation between
-     * those initialization phases by using two fields.
-     *
-     * @connected: see vu_gpio_connect()/vu_gpio_disconnect()
-     * @started_vu: see vu_gpio_start()/vu_gpio_stop()
-     */
-    bool connected;
-    bool started_vu;
-    /*< public >*/
+    VHostUserBase parent_obj;
 };
 
 #endif /* _QEMU_VHOST_USER_GPIO_H */
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index aff2d7eff6..9f37c25415 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -11,387 +11,25 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vhost-user-gpio.h"
-#include "qemu/error-report.h"
 #include "standard-headers/linux/virtio_ids.h"
-#include "trace.h"
+#include "standard-headers/linux/virtio_gpio.h"
 
-#define VHOST_NVQS 2
-
-/* Features required from VirtIO */
-static const int feature_bits[] = {
-    VIRTIO_F_VERSION_1,
-    VIRTIO_F_NOTIFY_ON_EMPTY,
-    VIRTIO_RING_F_INDIRECT_DESC,
-    VIRTIO_RING_F_EVENT_IDX,
-    VIRTIO_GPIO_F_IRQ,
-    VIRTIO_F_RING_RESET,
-    VHOST_INVALID_FEATURE_BIT
-};
-
-static void vu_gpio_get_config(VirtIODevice *vdev, uint8_t *config)
-{
-    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
-
-    memcpy(config, &gpio->config, sizeof(gpio->config));
-}
-
-static int vu_gpio_config_notifier(struct vhost_dev *dev)
-{
-    VHostUserGPIO *gpio = VHOST_USER_GPIO(dev->vdev);
-
-    memcpy(dev->vdev->config, &gpio->config, sizeof(gpio->config));
-    virtio_notify_config(dev->vdev);
-
-    return 0;
-}
-
-const VhostDevConfigOps gpio_ops = {
-    .vhost_dev_config_notifier = vu_gpio_config_notifier,
+static Property vgpio_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+    DEFINE_PROP_END_OF_LIST(),
 };
 
-static int vu_gpio_start(VirtIODevice *vdev)
-{
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
-    struct vhost_dev *vhost_dev = &gpio->vhost_dev;
-    int ret, i;
-
-    if (!k->set_guest_notifiers) {
-        error_report("binding does not support guest notifiers");
-        return -ENOSYS;
-    }
-
-    ret = vhost_dev_enable_notifiers(vhost_dev, vdev);
-    if (ret < 0) {
-        error_report("Error enabling host notifiers: %d", ret);
-        return ret;
-    }
-
-    ret = k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, true);
-    if (ret < 0) {
-        error_report("Error binding guest notifier: %d", ret);
-        goto err_host_notifiers;
-    }
-
-    /*
-     * Before we start up we need to ensure we have the final feature
-     * set needed for the vhost configuration. The backend may also
-     * apply backend_features when the feature set is sent.
-     */
-    vhost_ack_features(&gpio->vhost_dev, feature_bits, vdev->guest_features);
-
-    ret = vhost_dev_start(&gpio->vhost_dev, vdev, false);
-    if (ret < 0) {
-        error_report("Error starting vhost-user-gpio: %d", ret);
-        goto err_guest_notifiers;
-    }
-    gpio->started_vu = true;
-
-    /*
-     * guest_notifier_mask/pending not used yet, so just unmask
-     * everything here. virtio-pci will do the right thing by
-     * enabling/disabling irqfd.
-     */
-    for (i = 0; i < gpio->vhost_dev.nvqs; i++) {
-        vhost_virtqueue_mask(&gpio->vhost_dev, vdev, i, false);
-    }
-
-    /*
-     * As we must have VHOST_USER_F_PROTOCOL_FEATURES (because
-     * VHOST_USER_GET_CONFIG requires it) we need to explicitly enable
-     * the vrings.
-     */
-    g_assert(vhost_dev->vhost_ops &&
-             vhost_dev->vhost_ops->vhost_set_vring_enable);
-    ret = vhost_dev->vhost_ops->vhost_set_vring_enable(vhost_dev, true);
-    if (ret == 0) {
-        return 0;
-    }
-
-    error_report("Failed to start vrings for vhost-user-gpio: %d", ret);
-
-err_guest_notifiers:
-    k->set_guest_notifiers(qbus->parent, gpio->vhost_dev.nvqs, false);
-err_host_notifiers:
-    vhost_dev_disable_notifiers(&gpio->vhost_dev, vdev);
-
-    return ret;
-}
-
-static void vu_gpio_stop(VirtIODevice *vdev)
-{
-    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    struct vhost_dev *vhost_dev = &gpio->vhost_dev;
-    int ret;
-
-    if (!gpio->started_vu) {
-        return;
-    }
-    gpio->started_vu = false;
-
-    if (!k->set_guest_notifiers) {
-        return;
-    }
-
-    vhost_dev_stop(vhost_dev, vdev, false);
-
-    ret = k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, false);
-    if (ret < 0) {
-        error_report("vhost guest notifier cleanup failed: %d", ret);
-        return;
-    }
-
-    vhost_dev_disable_notifiers(vhost_dev, vdev);
-}
-
-static void vu_gpio_set_status(VirtIODevice *vdev, uint8_t status)
-{
-    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
-    bool should_start = virtio_device_should_start(vdev, status);
-
-    trace_virtio_gpio_set_status(status);
-
-    if (!gpio->connected) {
-        return;
-    }
-
-    if (vhost_dev_is_started(&gpio->vhost_dev) == should_start) {
-        return;
-    }
-
-    if (should_start) {
-        if (vu_gpio_start(vdev)) {
-            qemu_chr_fe_disconnect(&gpio->chardev);
-        }
-    } else {
-        vu_gpio_stop(vdev);
-    }
-}
-
-static uint64_t vu_gpio_get_features(VirtIODevice *vdev, uint64_t features,
-                                     Error **errp)
-{
-    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
-
-    return vhost_get_features(&gpio->vhost_dev, feature_bits, features);
-}
-
-static void vu_gpio_handle_output(VirtIODevice *vdev, VirtQueue *vq)
-{
-    /*
-     * Not normally called; it's the daemon that handles the queue;
-     * however virtio's cleanup path can call this.
-     */
-}
-
-static void vu_gpio_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
-{
-    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
-
-    /*
-     * Add the check for configure interrupt, Use VIRTIO_CONFIG_IRQ_IDX -1
-     * as the macro of configure interrupt's IDX, If this driver does not
-     * support, the function will return
-     */
-
-    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
-        return;
-    }
-
-    vhost_virtqueue_mask(&gpio->vhost_dev, vdev, idx, mask);
-}
-
-static struct vhost_dev *vu_gpio_get_vhost(VirtIODevice *vdev)
-{
-    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
-    return &gpio->vhost_dev;
-}
-
-static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserGPIO *gpio)
-{
-    virtio_delete_queue(gpio->command_vq);
-    virtio_delete_queue(gpio->interrupt_vq);
-    g_free(gpio->vhost_vqs);
-    virtio_cleanup(vdev);
-    vhost_user_cleanup(&gpio->vhost_user);
-}
-
-static int vu_gpio_connect(DeviceState *dev, Error **errp)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
-    struct vhost_dev *vhost_dev = &gpio->vhost_dev;
-    int ret;
-
-    if (gpio->connected) {
-        return 0;
-    }
-    gpio->connected = true;
-
-    vhost_dev_set_config_notifier(vhost_dev, &gpio_ops);
-    gpio->vhost_user.supports_config = true;
-
-    gpio->vhost_dev.nvqs = VHOST_NVQS;
-    gpio->vhost_dev.vqs = gpio->vhost_vqs;
-
-    ret = vhost_dev_init(vhost_dev, &gpio->vhost_user,
-                         VHOST_BACKEND_TYPE_USER, 0, errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    /* restore vhost state */
-    if (virtio_device_started(vdev, vdev->status)) {
-        vu_gpio_start(vdev);
-    }
-
-    return 0;
-}
-
-static void vu_gpio_event(void *opaque, QEMUChrEvent event);
-
-static void vu_gpio_disconnect(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
-
-    if (!gpio->connected) {
-        return;
-    }
-    gpio->connected = false;
-
-    vu_gpio_stop(vdev);
-    vhost_dev_cleanup(&gpio->vhost_dev);
-
-    /* Re-instate the event handler for new connections */
-    qemu_chr_fe_set_handlers(&gpio->chardev,
-                             NULL, NULL, vu_gpio_event,
-                             NULL, dev, NULL, true);
-}
-
-static void vu_gpio_event(void *opaque, QEMUChrEvent event)
-{
-    DeviceState *dev = opaque;
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
-    Error *local_err = NULL;
-
-    switch (event) {
-    case CHR_EVENT_OPENED:
-        if (vu_gpio_connect(dev, &local_err) < 0) {
-            qemu_chr_fe_disconnect(&gpio->chardev);
-            return;
-        }
-        break;
-    case CHR_EVENT_CLOSED:
-        /* defer close until later to avoid circular close */
-        vhost_user_async_close(dev, &gpio->chardev, &gpio->vhost_dev,
-                               vu_gpio_disconnect, vu_gpio_event);
-        break;
-    case CHR_EVENT_BREAK:
-    case CHR_EVENT_MUX_IN:
-    case CHR_EVENT_MUX_OUT:
-        /* Ignore */
-        break;
-    }
-}
-
-static int vu_gpio_realize_connect(VHostUserGPIO *gpio, Error **errp)
+static void vgpio_realize(DeviceState *dev, Error **errp)
 {
-    VirtIODevice *vdev = &gpio->parent_obj;
-    DeviceState *dev = &vdev->parent_obj;
-    struct vhost_dev *vhost_dev = &gpio->vhost_dev;
-    int ret;
-
-    ret = qemu_chr_fe_wait_connected(&gpio->chardev, errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    /*
-     * vu_gpio_connect() may have already connected (via the event
-     * callback) in which case it will just report success.
-     */
-    ret = vu_gpio_connect(dev, errp);
-    if (ret < 0) {
-        qemu_chr_fe_disconnect(&gpio->chardev);
-        return ret;
-    }
-    g_assert(gpio->connected);
-
-    ret = vhost_dev_get_config(vhost_dev, (uint8_t *)&gpio->config,
-                               sizeof(gpio->config), errp);
-
-    if (ret < 0) {
-        error_report("vhost-user-gpio: get config failed");
-
-        qemu_chr_fe_disconnect(&gpio->chardev);
-        vhost_dev_cleanup(vhost_dev);
-        return ret;
-    }
-
-    return 0;
-}
-
-static void vu_gpio_device_realize(DeviceState *dev, Error **errp)
-{
-    ERRP_GUARD();
-
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserGPIO *gpio = VHOST_USER_GPIO(dev);
-    int retries, ret;
-
-    if (!gpio->chardev.chr) {
-        error_setg(errp, "vhost-user-gpio: chardev is mandatory");
-        return;
-    }
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_GET_CLASS(dev);
 
-    if (!vhost_user_init(&gpio->vhost_user, &gpio->chardev, errp)) {
-        return;
-    }
+    /* Fixed for GPIO */
+    vub->virtio_id = VIRTIO_ID_GPIO;
+    vub->num_vqs = 2;
+    vub->config_size = sizeof(struct virtio_gpio_config);
 
-    virtio_init(vdev, VIRTIO_ID_GPIO, sizeof(gpio->config));
-
-    gpio->command_vq = virtio_add_queue(vdev, 256, vu_gpio_handle_output);
-    gpio->interrupt_vq = virtio_add_queue(vdev, 256, vu_gpio_handle_output);
-    gpio->vhost_vqs = g_new0(struct vhost_virtqueue, VHOST_NVQS);
-
-    gpio->connected = false;
-
-    qemu_chr_fe_set_handlers(&gpio->chardev, NULL, NULL, vu_gpio_event, NULL,
-                             dev, NULL, true);
-
-    retries = VU_REALIZE_CONN_RETRIES;
-    g_assert(!*errp);
-    do {
-        if (*errp) {
-            error_prepend(errp, "Reconnecting after error: ");
-            error_report_err(*errp);
-            *errp = NULL;
-        }
-        ret = vu_gpio_realize_connect(gpio, errp);
-    } while (ret < 0 && retries--);
-
-    if (ret < 0) {
-        do_vhost_user_cleanup(vdev, gpio);
-    }
-
-    return;
-}
-
-static void vu_gpio_device_unrealize(DeviceState *dev)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostUserGPIO *gpio = VHOST_USER_GPIO(dev);
-
-    vu_gpio_set_status(vdev, 0);
-    qemu_chr_fe_set_handlers(&gpio->chardev, NULL, NULL, NULL, NULL, NULL, NULL,
-                             false);
-    vhost_dev_cleanup(&gpio->vhost_dev);
-    do_vhost_user_cleanup(vdev, gpio);
+    vubc->parent_realize(dev, errp);
 }
 
 static const VMStateDescription vu_gpio_vmstate = {
@@ -399,31 +37,21 @@ static const VMStateDescription vu_gpio_vmstate = {
     .unmigratable = 1,
 };
 
-static Property vu_gpio_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserGPIO, chardev),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void vu_gpio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
 
-    device_class_set_props(dc, vu_gpio_properties);
     dc->vmsd = &vu_gpio_vmstate;
+    device_class_set_props(dc, vgpio_properties);
+    device_class_set_parent_realize(dc, vgpio_realize,
+                                    &vubc->parent_realize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
-    vdc->realize = vu_gpio_device_realize;
-    vdc->unrealize = vu_gpio_device_unrealize;
-    vdc->get_features = vu_gpio_get_features;
-    vdc->get_config = vu_gpio_get_config;
-    vdc->set_status = vu_gpio_set_status;
-    vdc->guest_notifier_mask = vu_gpio_guest_notifier_mask;
-    vdc->get_vhost = vu_gpio_get_vhost;
 }
 
 static const TypeInfo vu_gpio_info = {
     .name = TYPE_VHOST_USER_GPIO,
-    .parent = TYPE_VIRTIO_DEVICE,
+    .parent = TYPE_VHOST_USER_BASE,
     .instance_size = sizeof(VHostUserGPIO),
     .class_init = vu_gpio_class_init,
 };
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index b5c1a461e3..87042e5901 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -21,10 +21,13 @@ if have_vhost
 
     # MMIO Stubs
     system_virtio_ss.add(files('vhost-user-device.c'))
+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
 
     # PCI Stubs
     system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'],
+                         if_true: files('vhost-user-gpio-pci.c'))
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_RNG'],
                          if_true: files('vhost-user-rng-pci.c'))
   endif
@@ -44,8 +47,6 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-us
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
-specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'], if_true: files('vhost-user-gpio-pci.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
 
-- 
2.39.2


