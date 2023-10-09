Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CCD7BD7CB
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:00:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn3Y-0006c4-F4; Mon, 09 Oct 2023 06:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qpn3J-0006W4-At
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:59:53 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qpn39-00081o-NZ
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:59:53 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50433d8385cso5760156e87.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845581; x=1697450381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2RuA0oLkEVdOEtR9ByjpClBO/ycjZQqJdtuzZFKMt8=;
 b=CGl0JI+6BCxnY9zhzpS+cZGNAzyq1ActkY9auJ5WcmM7WN9p5Q21z4hpUXpl1Y369Q
 tRUSp4OG8hJaEybhmPTbAvhBUnZ0GKdYDB8u8c8QaRQ3lcLnHHDTNK7Ff+mXCV0u43Dp
 YC7eApu9pBzlhB6rxWyKXk09+9xc8uzChETmKb/IX87WkmciXdm+lUSV9BncsBXAUwUz
 2d4eTvMXv/xCt3swsJfBGjvQ+DlgaT1j5OIGJgzXHauJ8s/W8zL3xvgimHrQmH9Z6Cc2
 S1x/5ncigHk/kve2fkL14OIoRKhE/nEAfRgJ3IPOn/ui5XhcZav+lnQqXRw7Pc0v8H+W
 A1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845581; x=1697450381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u2RuA0oLkEVdOEtR9ByjpClBO/ycjZQqJdtuzZFKMt8=;
 b=jNJk+BMGvB3+xBiitOozPfvDNNpaeIcFPa27Umsb+tEm+Or1XVE/AXdKA9ddfwAN3B
 utWCX/nawZtHrNxRBcA+QLKpcIV1ICq4qq0ThYbrXeSlCRBvHJ7BSA++x9FLMUblmQ94
 CA+ghkII4O60g82b7UrAAXSA+Gh8vVo+2jADG/eKM+fP2FA9xOBN1wsI9JcwkOA6PzAd
 uQy8aBZw/otoRKA2H7spv3pONYj6mF5vZzSnIsUooKdESQ3udszX6PcQH8TymaziyKA7
 HTC2DBPrAhY9pq0ushkosrgZ2zxqgihU5yKZ0AfBoghh5QPTgSUXVxE8MvwrkZUwFiLG
 z9Fw==
X-Gm-Message-State: AOJu0YzK17DPCFSuxWL6OFnj8ZX20bcPOCKU8iAoqhGSth7IXTD6eEsN
 DJk0U/L1RCnxzVMCrRBs1oXyJw==
X-Google-Smtp-Source: AGHT+IEj03ceXdTk4rlkGcWfZDTfFimwlaafR1LfSW0dbJq9Aezw82clIuOPIPi34r8S+1M9RMQMVA==
X-Received: by 2002:a05:6512:3c9a:b0:503:24c7:df34 with SMTP id
 h26-20020a0565123c9a00b0050324c7df34mr14604495lfv.11.1696845581413; 
 Mon, 09 Oct 2023 02:59:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b00405391f485fsm10672854wmj.41.2023.10.09.02.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 02:59:39 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 907E41FFBE;
 Mon,  9 Oct 2023 10:59:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Fam Zheng <fam@euphon.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Viresh Kumar <viresh.kumar@linaro.org>, virtio-fs@redhat.com,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 3/6] hw/virtio: derive vhost-user-gpio from vhost-user-base
Date: Mon,  9 Oct 2023 10:59:34 +0100
Message-Id: <20231009095937.195728-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009095937.195728-1-alex.bennee@linaro.org>
References: <20231009095937.195728-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Message-Id: <20230418162140.373219-12-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

---
v2
  - use new vhost-user-base
  - move build to common code
v3
  - fix inadvertent double link
v4
  - merge conflict
  - update includes
---
 include/hw/virtio/vhost-user-gpio.h |  23 +-
 hw/virtio/vhost-user-gpio.c         | 407 ++--------------------------
 hw/virtio/meson.build               |   5 +-
 3 files changed, 22 insertions(+), 413 deletions(-)

diff --git a/include/hw/virtio/vhost-user-gpio.h b/include/hw/virtio/vhost-user-gpio.h
index a9d3f9b049..5201d5f072 100644
--- a/include/hw/virtio/vhost-user-gpio.h
+++ b/include/hw/virtio/vhost-user-gpio.h
@@ -12,33 +12,14 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
-#include "standard-headers/linux/virtio_gpio.h"
-#include "chardev/char-fe.h"
+#include "hw/virtio/vhost-user-base.h"
 
 #define TYPE_VHOST_USER_GPIO "vhost-user-gpio-device"
 OBJECT_DECLARE_SIMPLE_TYPE(VHostUserGPIO, VHOST_USER_GPIO);
 
 struct VHostUserGPIO {
     /*< private >*/
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
+    VHostUserBase parent;
     /*< public >*/
 };
 
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index 3d7fae3984..9f37c25415 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -11,388 +11,25 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vhost-user-gpio.h"
-#include "qemu/error-report.h"
 #include "standard-headers/linux/virtio_ids.h"
-#include "trace.h"
+#include "standard-headers/linux/virtio_gpio.h"
 
-#define REALIZE_CONNECTION_RETRIES 3
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
-                               vu_gpio_disconnect);
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
-    retries = REALIZE_CONNECTION_RETRIES;
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
@@ -400,31 +37,21 @@ static const VMStateDescription vu_gpio_vmstate = {
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
index d0b963199c..752d4a6905 100644
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
@@ -43,8 +46,6 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
-specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'], if_true: files('vhost-user-gpio-pci.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
 
-- 
2.39.2


