Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB737E2ACA
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:16:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03CO-0006NC-Jw; Mon, 06 Nov 2023 12:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r03CM-0006Mt-QV
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:15:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r03CA-0007xU-5r
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699290922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WPNo2uzAziJjvQXVEn7h0Pfej68qiPbecXui55TJFxE=;
 b=IGB0agF8kBBNC4WUhvf0t/gv9PxKzqux44ag3WzM+uBxJ2VkRu72+nO35MiJmhtN4pOhfU
 XCkbtIsaFdIUCEtylT3KYjoY8hniAX3DaztyzDdFt5mxEbwbZTjZzNUAdG2LuTyC2uwEbx
 BuavhWWaoXvA3uZ6xOoFcA+JIThv7BY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-ZJ8ZRD7fOY68QdzLsJ12Qw-1; Mon, 06 Nov 2023 12:15:21 -0500
X-MC-Unique: ZJ8ZRD7fOY68QdzLsJ12Qw-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-7a9415f941aso450823239f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 09:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699290920; x=1699895720;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WPNo2uzAziJjvQXVEn7h0Pfej68qiPbecXui55TJFxE=;
 b=tfgmoIdNe8FWD+cRwMros0/lZfkc6y3EbzsIQYifnnaYGFRh/tX06ko8qwClHaQqIC
 t79OxhmiYMpcp+q6C0Dgic7ncsxubHEw8QQyYakFb7flWmPhQuIHq1giPlLtOnJs5MWb
 hXdd8cwylK8J7jecbdluqqmBDXQeNz+69NPn51pYXQNFbFcCYyRKKAQ2G36+XQr7nPCO
 jhjCcoelYsuYKgVUG6tTM7BFSobSNe4pZAlbco++c8iyycO94NLOLbIF/FSUbvZYqpMA
 kSZbP5Ve4Qs+AoCPhupcUF5vr2yoU++UeNBr1i4mJqEmml3vWv07yS/L/ESYnyTPht/c
 ZQAA==
X-Gm-Message-State: AOJu0YzRucmIcl3vc/fIE+IpO5IYSDB5Oeqc1PTw5/qgqLPDnMStK2Mh
 GNupZZ4BN7GpakKNELPTR8zw3fka2dFakJn2posiFDmtADarz/CLuYsTxDy/R3jUbikdl0l3jex
 EXRqHMEnZBAV/mFU=
X-Received: by 2002:a05:6e02:1565:b0:359:4269:42d7 with SMTP id
 k5-20020a056e02156500b00359426942d7mr269786ilu.4.1699290920446; 
 Mon, 06 Nov 2023 09:15:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSGVTq2xlhfVhP/BQdxp5ueQW0sjT6MxcKAgsVboC/2VjTahzfVqi3FYdTY3Nb8gZJfXP7Ew==
X-Received: by 2002:a05:6e02:1565:b0:359:4269:42d7 with SMTP id
 k5-20020a056e02156500b00359426942d7mr269759ilu.4.1699290920102; 
 Mon, 06 Nov 2023 09:15:20 -0800 (PST)
Received: from redhat.com ([5.102.242.158]) by smtp.gmail.com with ESMTPSA id
 p11-20020a056e02104b00b0035163fb9f9fsm2579373ilj.43.2023.11.06.09.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 09:15:19 -0800 (PST)
Date: Mon, 6 Nov 2023 12:15:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 virtio-fs@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Fam Zheng <fam@euphon.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH v5 3/6] hw/virtio: derive vhost-user-gpio from
 vhost-user-base
Message-ID: <20231106121400-mutt-send-email-mst@kernel.org>
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
 <20231019095610.2818087-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019095610.2818087-4-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Oct 19, 2023 at 10:56:07AM +0100, Alex Bennée wrote:
> Now the new base class supports config handling we can take advantage
> and make vhost-user-gpio a much simpler boilerplate wrapper. Also as
> this doesn't require any target specific hacks we only need to build
> the stubs once.
> 
> Message-Id: <20230418162140.373219-12-alex.bennee@linaro.org>
> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231009095937.195728-4-alex.bennee@linaro.org>
> ---
>  include/hw/virtio/vhost-user-gpio.h |  23 +-
>  hw/virtio/vhost-user-gpio.c         | 407 ++--------------------------
>  hw/virtio/meson.build               |   5 +-
>  3 files changed, 22 insertions(+), 413 deletions(-)
> 
> diff --git a/include/hw/virtio/vhost-user-gpio.h b/include/hw/virtio/vhost-user-gpio.h
> index a9d3f9b049..5201d5f072 100644
> --- a/include/hw/virtio/vhost-user-gpio.h
> +++ b/include/hw/virtio/vhost-user-gpio.h
> @@ -12,33 +12,14 @@
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/vhost.h"
>  #include "hw/virtio/vhost-user.h"
> -#include "standard-headers/linux/virtio_gpio.h"
> -#include "chardev/char-fe.h"
> +#include "hw/virtio/vhost-user-base.h"
>  
>  #define TYPE_VHOST_USER_GPIO "vhost-user-gpio-device"
>  OBJECT_DECLARE_SIMPLE_TYPE(VHostUserGPIO, VHOST_USER_GPIO);
>  
>  struct VHostUserGPIO {
>      /*< private >*/
> -    VirtIODevice parent_obj;
> -    CharBackend chardev;
> -    struct virtio_gpio_config config;
> -    struct vhost_virtqueue *vhost_vqs;
> -    struct vhost_dev vhost_dev;
> -    VhostUserState vhost_user;
> -    VirtQueue *command_vq;
> -    VirtQueue *interrupt_vq;
> -    /**
> -     * There are at least two steps of initialization of the
> -     * vhost-user device. The first is a "connect" step and
> -     * second is a "start" step. Make a separation between
> -     * those initialization phases by using two fields.
> -     *
> -     * @connected: see vu_gpio_connect()/vu_gpio_disconnect()
> -     * @started_vu: see vu_gpio_start()/vu_gpio_stop()
> -     */
> -    bool connected;
> -    bool started_vu;
> +    VHostUserBase parent;
>      /*< public >*/
>  };
>  
> diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
> index 3d7fae3984..9f37c25415 100644
> --- a/hw/virtio/vhost-user-gpio.c
> +++ b/hw/virtio/vhost-user-gpio.c
> @@ -11,388 +11,25 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/vhost-user-gpio.h"
> -#include "qemu/error-report.h"
>  #include "standard-headers/linux/virtio_ids.h"
> -#include "trace.h"
> +#include "standard-headers/linux/virtio_gpio.h"
>  
> -#define REALIZE_CONNECTION_RETRIES 3
> -#define VHOST_NVQS 2
> -
> -/* Features required from VirtIO */
> -static const int feature_bits[] = {
> -    VIRTIO_F_VERSION_1,
> -    VIRTIO_F_NOTIFY_ON_EMPTY,
> -    VIRTIO_RING_F_INDIRECT_DESC,
> -    VIRTIO_RING_F_EVENT_IDX,
> -    VIRTIO_GPIO_F_IRQ,
> -    VIRTIO_F_RING_RESET,
> -    VHOST_INVALID_FEATURE_BIT
> -};
> -
> -static void vu_gpio_get_config(VirtIODevice *vdev, uint8_t *config)
> -{
> -    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
> -
> -    memcpy(config, &gpio->config, sizeof(gpio->config));
> -}
> -
> -static int vu_gpio_config_notifier(struct vhost_dev *dev)
> -{
> -    VHostUserGPIO *gpio = VHOST_USER_GPIO(dev->vdev);
> -
> -    memcpy(dev->vdev->config, &gpio->config, sizeof(gpio->config));
> -    virtio_notify_config(dev->vdev);
> -
> -    return 0;
> -}
> -
> -const VhostDevConfigOps gpio_ops = {
> -    .vhost_dev_config_notifier = vu_gpio_config_notifier,
> +static Property vgpio_properties[] = {
> +    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> +    DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -static int vu_gpio_start(VirtIODevice *vdev)
> -{
> -    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
> -    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> -    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
> -    struct vhost_dev *vhost_dev = &gpio->vhost_dev;
> -    int ret, i;
> -
> -    if (!k->set_guest_notifiers) {
> -        error_report("binding does not support guest notifiers");
> -        return -ENOSYS;
> -    }
> -
> -    ret = vhost_dev_enable_notifiers(vhost_dev, vdev);
> -    if (ret < 0) {
> -        error_report("Error enabling host notifiers: %d", ret);
> -        return ret;
> -    }
> -
> -    ret = k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, true);
> -    if (ret < 0) {
> -        error_report("Error binding guest notifier: %d", ret);
> -        goto err_host_notifiers;
> -    }
> -
> -    /*
> -     * Before we start up we need to ensure we have the final feature
> -     * set needed for the vhost configuration. The backend may also
> -     * apply backend_features when the feature set is sent.
> -     */
> -    vhost_ack_features(&gpio->vhost_dev, feature_bits, vdev->guest_features);
> -
> -    ret = vhost_dev_start(&gpio->vhost_dev, vdev, false);
> -    if (ret < 0) {
> -        error_report("Error starting vhost-user-gpio: %d", ret);
> -        goto err_guest_notifiers;
> -    }
> -    gpio->started_vu = true;
> -
> -    /*
> -     * guest_notifier_mask/pending not used yet, so just unmask
> -     * everything here. virtio-pci will do the right thing by
> -     * enabling/disabling irqfd.
> -     */
> -    for (i = 0; i < gpio->vhost_dev.nvqs; i++) {
> -        vhost_virtqueue_mask(&gpio->vhost_dev, vdev, i, false);
> -    }
> -
> -    /*
> -     * As we must have VHOST_USER_F_PROTOCOL_FEATURES (because
> -     * VHOST_USER_GET_CONFIG requires it) we need to explicitly enable
> -     * the vrings.
> -     */
> -    g_assert(vhost_dev->vhost_ops &&
> -             vhost_dev->vhost_ops->vhost_set_vring_enable);
> -    ret = vhost_dev->vhost_ops->vhost_set_vring_enable(vhost_dev, true);
> -    if (ret == 0) {
> -        return 0;
> -    }
> -
> -    error_report("Failed to start vrings for vhost-user-gpio: %d", ret);
> -
> -err_guest_notifiers:
> -    k->set_guest_notifiers(qbus->parent, gpio->vhost_dev.nvqs, false);
> -err_host_notifiers:
> -    vhost_dev_disable_notifiers(&gpio->vhost_dev, vdev);
> -
> -    return ret;
> -}
> -
> -static void vu_gpio_stop(VirtIODevice *vdev)
> -{
> -    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
> -    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
> -    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> -    struct vhost_dev *vhost_dev = &gpio->vhost_dev;
> -    int ret;
> -
> -    if (!gpio->started_vu) {
> -        return;
> -    }
> -    gpio->started_vu = false;
> -
> -    if (!k->set_guest_notifiers) {
> -        return;
> -    }
> -
> -    vhost_dev_stop(vhost_dev, vdev, false);
> -
> -    ret = k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, false);
> -    if (ret < 0) {
> -        error_report("vhost guest notifier cleanup failed: %d", ret);
> -        return;
> -    }
> -
> -    vhost_dev_disable_notifiers(vhost_dev, vdev);
> -}
> -
> -static void vu_gpio_set_status(VirtIODevice *vdev, uint8_t status)
> -{
> -    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
> -    bool should_start = virtio_device_should_start(vdev, status);
> -
> -    trace_virtio_gpio_set_status(status);
> -
> -    if (!gpio->connected) {
> -        return;
> -    }
> -
> -    if (vhost_dev_is_started(&gpio->vhost_dev) == should_start) {
> -        return;
> -    }
> -
> -    if (should_start) {
> -        if (vu_gpio_start(vdev)) {
> -            qemu_chr_fe_disconnect(&gpio->chardev);
> -        }
> -    } else {
> -        vu_gpio_stop(vdev);
> -    }
> -}
> -
> -static uint64_t vu_gpio_get_features(VirtIODevice *vdev, uint64_t features,
> -                                     Error **errp)
> -{
> -    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
> -
> -    return vhost_get_features(&gpio->vhost_dev, feature_bits, features);
> -}
> -
> -static void vu_gpio_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> -{
> -    /*
> -     * Not normally called; it's the daemon that handles the queue;
> -     * however virtio's cleanup path can call this.
> -     */
> -}
> -
> -static void vu_gpio_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
> -{
> -    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
> -
> -    /*
> -     * Add the check for configure interrupt, Use VIRTIO_CONFIG_IRQ_IDX -1
> -     * as the macro of configure interrupt's IDX, If this driver does not
> -     * support, the function will return
> -     */
> -
> -    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
> -        return;
> -    }
> -
> -    vhost_virtqueue_mask(&gpio->vhost_dev, vdev, idx, mask);
> -}
> -
> -static struct vhost_dev *vu_gpio_get_vhost(VirtIODevice *vdev)
> -{
> -    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
> -    return &gpio->vhost_dev;
> -}
> -
> -static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserGPIO *gpio)
> -{
> -    virtio_delete_queue(gpio->command_vq);
> -    virtio_delete_queue(gpio->interrupt_vq);
> -    g_free(gpio->vhost_vqs);
> -    virtio_cleanup(vdev);
> -    vhost_user_cleanup(&gpio->vhost_user);
> -}
> -
> -static int vu_gpio_connect(DeviceState *dev, Error **errp)
> -{
> -    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> -    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
> -    struct vhost_dev *vhost_dev = &gpio->vhost_dev;
> -    int ret;
> -
> -    if (gpio->connected) {
> -        return 0;
> -    }
> -    gpio->connected = true;
> -
> -    vhost_dev_set_config_notifier(vhost_dev, &gpio_ops);
> -    gpio->vhost_user.supports_config = true;
> -
> -    gpio->vhost_dev.nvqs = VHOST_NVQS;
> -    gpio->vhost_dev.vqs = gpio->vhost_vqs;
> -
> -    ret = vhost_dev_init(vhost_dev, &gpio->vhost_user,
> -                         VHOST_BACKEND_TYPE_USER, 0, errp);
> -    if (ret < 0) {
> -        return ret;
> -    }
> -
> -    /* restore vhost state */
> -    if (virtio_device_started(vdev, vdev->status)) {
> -        vu_gpio_start(vdev);
> -    }
> -
> -    return 0;
> -}
> -
> -static void vu_gpio_event(void *opaque, QEMUChrEvent event);
> -
> -static void vu_gpio_disconnect(DeviceState *dev)
> -{
> -    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> -    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
> -
> -    if (!gpio->connected) {
> -        return;
> -    }
> -    gpio->connected = false;
> -
> -    vu_gpio_stop(vdev);
> -    vhost_dev_cleanup(&gpio->vhost_dev);
> -
> -    /* Re-instate the event handler for new connections */
> -    qemu_chr_fe_set_handlers(&gpio->chardev,
> -                             NULL, NULL, vu_gpio_event,
> -                             NULL, dev, NULL, true);
> -}
> -
> -static void vu_gpio_event(void *opaque, QEMUChrEvent event)
> -{
> -    DeviceState *dev = opaque;
> -    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> -    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
> -    Error *local_err = NULL;
> -
> -    switch (event) {
> -    case CHR_EVENT_OPENED:
> -        if (vu_gpio_connect(dev, &local_err) < 0) {
> -            qemu_chr_fe_disconnect(&gpio->chardev);
> -            return;
> -        }
> -        break;
> -    case CHR_EVENT_CLOSED:
> -        /* defer close until later to avoid circular close */
> -        vhost_user_async_close(dev, &gpio->chardev, &gpio->vhost_dev,
> -                               vu_gpio_disconnect);

Hmm. Looking at this, it seems that the base device will handle close
synchronously. No? Why isn't this a problem?


> -        break;
> -    case CHR_EVENT_BREAK:
> -    case CHR_EVENT_MUX_IN:
> -    case CHR_EVENT_MUX_OUT:
> -        /* Ignore */
> -        break;
> -    }
> -}
> -
> -static int vu_gpio_realize_connect(VHostUserGPIO *gpio, Error **errp)
> +static void vgpio_realize(DeviceState *dev, Error **errp)
>  {
> -    VirtIODevice *vdev = &gpio->parent_obj;
> -    DeviceState *dev = &vdev->parent_obj;
> -    struct vhost_dev *vhost_dev = &gpio->vhost_dev;
> -    int ret;
> -
> -    ret = qemu_chr_fe_wait_connected(&gpio->chardev, errp);
> -    if (ret < 0) {
> -        return ret;
> -    }
> -
> -    /*
> -     * vu_gpio_connect() may have already connected (via the event
> -     * callback) in which case it will just report success.
> -     */
> -    ret = vu_gpio_connect(dev, errp);
> -    if (ret < 0) {
> -        qemu_chr_fe_disconnect(&gpio->chardev);
> -        return ret;
> -    }
> -    g_assert(gpio->connected);
> -
> -    ret = vhost_dev_get_config(vhost_dev, (uint8_t *)&gpio->config,
> -                               sizeof(gpio->config), errp);
> -
> -    if (ret < 0) {
> -        error_report("vhost-user-gpio: get config failed");
> -
> -        qemu_chr_fe_disconnect(&gpio->chardev);
> -        vhost_dev_cleanup(vhost_dev);
> -        return ret;
> -    }
> -
> -    return 0;
> -}
> -
> -static void vu_gpio_device_realize(DeviceState *dev, Error **errp)
> -{
> -    ERRP_GUARD();
> -
> -    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> -    VHostUserGPIO *gpio = VHOST_USER_GPIO(dev);
> -    int retries, ret;
> -
> -    if (!gpio->chardev.chr) {
> -        error_setg(errp, "vhost-user-gpio: chardev is mandatory");
> -        return;
> -    }
> +    VHostUserBase *vub = VHOST_USER_BASE(dev);
> +    VHostUserBaseClass *vubc = VHOST_USER_BASE_GET_CLASS(dev);
>  
> -    if (!vhost_user_init(&gpio->vhost_user, &gpio->chardev, errp)) {
> -        return;
> -    }
> +    /* Fixed for GPIO */
> +    vub->virtio_id = VIRTIO_ID_GPIO;
> +    vub->num_vqs = 2;
> +    vub->config_size = sizeof(struct virtio_gpio_config);
>  
> -    virtio_init(vdev, VIRTIO_ID_GPIO, sizeof(gpio->config));
> -
> -    gpio->command_vq = virtio_add_queue(vdev, 256, vu_gpio_handle_output);
> -    gpio->interrupt_vq = virtio_add_queue(vdev, 256, vu_gpio_handle_output);
> -    gpio->vhost_vqs = g_new0(struct vhost_virtqueue, VHOST_NVQS);
> -
> -    gpio->connected = false;
> -
> -    qemu_chr_fe_set_handlers(&gpio->chardev, NULL, NULL, vu_gpio_event, NULL,
> -                             dev, NULL, true);
> -
> -    retries = REALIZE_CONNECTION_RETRIES;
> -    g_assert(!*errp);
> -    do {
> -        if (*errp) {
> -            error_prepend(errp, "Reconnecting after error: ");
> -            error_report_err(*errp);
> -            *errp = NULL;
> -        }
> -        ret = vu_gpio_realize_connect(gpio, errp);
> -    } while (ret < 0 && retries--);
> -
> -    if (ret < 0) {
> -        do_vhost_user_cleanup(vdev, gpio);
> -    }
> -
> -    return;
> -}
> -
> -static void vu_gpio_device_unrealize(DeviceState *dev)
> -{
> -    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> -    VHostUserGPIO *gpio = VHOST_USER_GPIO(dev);
> -
> -    vu_gpio_set_status(vdev, 0);
> -    qemu_chr_fe_set_handlers(&gpio->chardev, NULL, NULL, NULL, NULL, NULL, NULL,
> -                             false);
> -    vhost_dev_cleanup(&gpio->vhost_dev);
> -    do_vhost_user_cleanup(vdev, gpio);
> +    vubc->parent_realize(dev, errp);
>  }
>  
>  static const VMStateDescription vu_gpio_vmstate = {
> @@ -400,31 +37,21 @@ static const VMStateDescription vu_gpio_vmstate = {
>      .unmigratable = 1,
>  };
>  
> -static Property vu_gpio_properties[] = {
> -    DEFINE_PROP_CHR("chardev", VHostUserGPIO, chardev),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static void vu_gpio_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
> +    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
>  
> -    device_class_set_props(dc, vu_gpio_properties);
>      dc->vmsd = &vu_gpio_vmstate;
> +    device_class_set_props(dc, vgpio_properties);
> +    device_class_set_parent_realize(dc, vgpio_realize,
> +                                    &vubc->parent_realize);
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> -    vdc->realize = vu_gpio_device_realize;
> -    vdc->unrealize = vu_gpio_device_unrealize;
> -    vdc->get_features = vu_gpio_get_features;
> -    vdc->get_config = vu_gpio_get_config;
> -    vdc->set_status = vu_gpio_set_status;
> -    vdc->guest_notifier_mask = vu_gpio_guest_notifier_mask;
> -    vdc->get_vhost = vu_gpio_get_vhost;
>  }
>  
>  static const TypeInfo vu_gpio_info = {
>      .name = TYPE_VHOST_USER_GPIO,
> -    .parent = TYPE_VIRTIO_DEVICE,
> +    .parent = TYPE_VHOST_USER_BASE,
>      .instance_size = sizeof(VHostUserGPIO),
>      .class_init = vu_gpio_class_init,
>  };
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index b5c1a461e3..87042e5901 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -21,10 +21,13 @@ if have_vhost
>  
>      # MMIO Stubs
>      system_virtio_ss.add(files('vhost-user-device.c'))
> +    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
>  
>      # PCI Stubs
>      system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
> +    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'],
> +                         if_true: files('vhost-user-gpio-pci.c'))
>      system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_RNG'],
>                           if_true: files('vhost-user-rng-pci.c'))
>    endif
> @@ -44,8 +47,6 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-us
>  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
> -specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
> -specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'], if_true: files('vhost-user-gpio-pci.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
>  specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
>  
> -- 
> 2.39.2


