Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F12B74DEA7
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 21:59:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIx1Z-0004YE-4I; Mon, 10 Jul 2023 15:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIx1W-0004Xx-F7
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:58:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIx1U-0001Xe-Sq
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689019095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MdY1hOSI/ZXoBdkiB4WO0urHhaHtKNZG+DDisbsq/78=;
 b=eDkgqOpJnMm0OmCPDYJV7BeZ+/oJgon0HgOCwTFJ/sq0UbZi/w8t5adgIKscqcABIffWxo
 jzav7K+ciJDKGnZzcEsdSiTZNCeCIWj+fna5DWibWU9PrIaUowWJYvsorW7FNFRFpcz1qY
 fb18WGpffnLuoVQoxpUwwv9RyM+y54s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-mBVpMOGiOqGJXmLSQgD5cg-1; Mon, 10 Jul 2023 15:58:14 -0400
X-MC-Unique: mBVpMOGiOqGJXmLSQgD5cg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso28949515e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 12:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689019093; x=1691611093;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MdY1hOSI/ZXoBdkiB4WO0urHhaHtKNZG+DDisbsq/78=;
 b=MKJbW9AJtwQ9sqIB5wQNDqLs43JxPMetU4rAml1zmsTDTP7Z7UkI3BrrgZY0T7v3zb
 xt7RCVMjIIoY6YeJCgQH5pm9d/GIx24g8eTPkCY9s4fgNqn/xebMe0EzDoZB878q6wRO
 lFxDIPpFwFuKAnQA7GumA3omMcrqaZNvh+6sVEXmSuDFdrikidlkLEFpYCeeZ39YkVtr
 Hz/YYwLgwhi3vBSuiEdneNBby8LZUkLiIX88VcNjQhyBDbGNsMdX0Zgxnl3UQ5eMAxF0
 jwjNzEDNxvTJX7qZ5qbpFMrgx/mF9cYXJv78NWRXOzqmQcPS9Sjev3JoeyG5L27AK/ld
 CgtQ==
X-Gm-Message-State: ABy/qLbiTUo4asOmsXJUkX7CLr8tUM+SOj05OKAnXLZYRNN92PARIOjb
 1UZFI7PCg6BgPJXZ0nfJfLwszlZqN+pdkuT04ojkiF3Fuwa3PjE6x0BYjul325Yc53WeyOGhoGJ
 LGOUeQqoT8MjGAdW4xxS5z1Q=
X-Received: by 2002:a7b:ce8e:0:b0:3fb:40ec:9483 with SMTP id
 q14-20020a7bce8e000000b003fb40ec9483mr11981372wmj.16.1689019093353; 
 Mon, 10 Jul 2023 12:58:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHdFsk+ZT+zXNgugkKCXWqSljOvfUucNbmbL6DrZtP1dGJV9SHhm3eHgUmb8bBMMAItv1mEiw==
X-Received: by 2002:a7b:ce8e:0:b0:3fb:40ec:9483 with SMTP id
 q14-20020a7bce8e000000b003fb40ec9483mr11981352wmj.16.1689019092976; 
 Mon, 10 Jul 2023 12:58:12 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 c18-20020a7bc012000000b003fb40f5f553sm11223752wmb.31.2023.07.10.12.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 12:58:12 -0700 (PDT)
Date: Mon, 10 Jul 2023 15:58:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 10/20] hw/virtio: add config support to
 vhost-user-device
Message-ID: <20230710155653-mutt-send-email-mst@kernel.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
 <20230710153522.3469097-11-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230710153522.3469097-11-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 10, 2023 at 04:35:12PM +0100, Alex Bennée wrote:
> To use the generic device the user will need to provide the config
> region size via the command line. We also add a notifier so the guest
> can be pinged if the remote daemon updates the config.
> 
> With these changes:
> 
>   -device vhost-user-device-pci,virtio-id=41,num_vqs=2,config_size=8
> 
> is equivalent to:
> 
>   -device vhost-user-gpio-pci
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>


This one I think it's best to defer until we get a better
handle on how we want the configuration to look.


> ---
>  include/hw/virtio/vhost-user-device.h |  1 +
>  hw/virtio/vhost-user-device.c         | 58 ++++++++++++++++++++++++++-
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/virtio/vhost-user-device.h b/include/hw/virtio/vhost-user-device.h
> index 9105011e25..3ddf88a146 100644
> --- a/include/hw/virtio/vhost-user-device.h
> +++ b/include/hw/virtio/vhost-user-device.h
> @@ -22,6 +22,7 @@ struct VHostUserBase {
>      CharBackend chardev;
>      uint16_t virtio_id;
>      uint32_t num_vqs;
> +    uint32_t config_size;
>      /* State tracking */
>      VhostUserState vhost_user;
>      struct vhost_virtqueue *vhost_vq;
> diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
> index b0239fa033..2b028cae08 100644
> --- a/hw/virtio/vhost-user-device.c
> +++ b/hw/virtio/vhost-user-device.c
> @@ -117,6 +117,42 @@ static uint64_t vub_get_features(VirtIODevice *vdev,
>      return vub->vhost_dev.features & ~(1ULL << VHOST_USER_F_PROTOCOL_FEATURES);
>  }
>  
> +/*
> + * To handle VirtIO config we need to know the size of the config
> + * space. We don't cache the config but re-fetch it from the guest
> + * every time in case something has changed.
> + */
> +static void vub_get_config(VirtIODevice *vdev, uint8_t *config)
> +{
> +    VHostUserBase *vub = VHOST_USER_BASE(vdev);
> +    Error *local_err = NULL;
> +
> +    /*
> +     * There will have been a warning during vhost_dev_init, but lets
> +     * assert here as nothing will go right now.
> +     */
> +    g_assert(vub->config_size && vub->vhost_user.supports_config == true);
> +
> +    if (vhost_dev_get_config(&vub->vhost_dev, config,
> +                             vub->config_size, &local_err)) {
> +        error_report_err(local_err);
> +    }
> +}
> +
> +/*
> + * When the daemon signals an update to the config we just need to
> + * signal the guest as we re-read the config on demand above.
> + */
> +static int vub_config_notifier(struct vhost_dev *dev)
> +{
> +    virtio_notify_config(dev->vdev);
> +    return 0;
> +}
> +
> +const VhostDevConfigOps vub_config_ops = {
> +    .vhost_dev_config_notifier = vub_config_notifier,
> +};
> +
>  static void vub_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      /*
> @@ -141,12 +177,21 @@ static int vub_connect(DeviceState *dev)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      VHostUserBase *vub = VHOST_USER_BASE(vdev);
> +    struct vhost_dev *vhost_dev = &vub->vhost_dev;
>  
>      if (vub->connected) {
>          return 0;
>      }
>      vub->connected = true;
>  
> +    /*
> +     * If we support VHOST_USER_GET_CONFIG we must enable the notifier
> +     * so we can ping the guest when it updates.
> +     */
> +    if (vub->vhost_user.supports_config) {
> +        vhost_dev_set_config_notifier(vhost_dev, &vub_config_ops);
> +    }
> +
>      /* restore vhost state */
>      if (virtio_device_started(vdev, vdev->status)) {
>          vub_start(vdev);
> @@ -214,11 +259,20 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
>          vub->num_vqs = 1; /* reasonable default? */
>      }
>  
> +    /*
> +     * We can't handle config requests unless we know the size of the
> +     * config region, specialisations of the vhost-user-device will be
> +     * able to set this.
> +     */
> +    if (vub->config_size) {
> +        vub->vhost_user.supports_config = true;
> +    }
> +
>      if (!vhost_user_init(&vub->vhost_user, &vub->chardev, errp)) {
>          return;
>      }
>  
> -    virtio_init(vdev, vub->virtio_id, 0);
> +    virtio_init(vdev, vub->virtio_id, vub->config_size);
>  
>      /*
>       * Disable guest notifiers, by default all notifications will be via the
> @@ -268,6 +322,7 @@ static void vub_class_init(ObjectClass *klass, void *data)
>      vdc->realize = vub_device_realize;
>      vdc->unrealize = vub_device_unrealize;
>      vdc->get_features = vub_get_features;
> +    vdc->get_config = vub_get_config;
>      vdc->set_status = vub_set_status;
>  }
>  
> @@ -295,6 +350,7 @@ static Property vud_properties[] = {
>      DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
>      DEFINE_PROP_UINT16("virtio-id", VHostUserBase, virtio_id, 0),
>      DEFINE_PROP_UINT32("num_vqs", VHostUserBase, num_vqs, 1),
> +    DEFINE_PROP_UINT32("config_size", VHostUserBase, config_size, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -- 
> 2.39.2


