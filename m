Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5910178F0D0
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:04:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbk92-00034H-ML; Thu, 31 Aug 2023 12:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbk8p-0002wu-9E
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:03:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbk8m-0000Uy-Jc
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:03:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401ec23be82so10111595e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693497805; x=1694102605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AYsY15P06B1GhqO83OP+tZdcI6K7ZACYl6qQKKzmOm4=;
 b=tv9IQKFfkZqdwsQ/+E06wvbzKNj/uY/5zL8Kl5toIfxoGEb3nm9GA95T5ponTDJNc7
 zk3JiespEDRI3Mk2qv5Ixwt2WUmbtcO9b0A6KqpE315/O709aSQgfzkzR93tiKcwYdh7
 cgd3rpK+FMnQQmIHglJ1XyGfIPmLpyH6kHpqOH+rHp9lrwyb4JBgsmxEFTAMx0cMxv+r
 Jvj0D3K93K3TiVzkiSj8PTZXcSYssLob5Nri66HN5hq2RurncWtMiukUV/ajQVSx13aE
 dN+jD0TfhweMtpwvm5e43mqvkvh6q27X8wl8V60H3rAMzSDmSVN5ESPYdDfLF1JBFAjD
 pNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693497805; x=1694102605;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AYsY15P06B1GhqO83OP+tZdcI6K7ZACYl6qQKKzmOm4=;
 b=VoLbJiKMWIu1Z9KKDp6VaIpt+m06K75oHSQk582e1KIuKb8cRa6jXdGcXKJcOfH44d
 eFqml3Yxvnl+Gy9i0MxA6CbXwhc4ennHHAH9rqfbSRxvEXO+l9PuEHzc8HEa3JSkn1W0
 wFs754O7ENDcdBp4ikHf0ejEhJip5yoEF74NIbUU+szgoR6YAIZtioPFLWEeWWQJPub9
 Hg5IcFZwxVyEV+M2JwBZeYH9RjKkdboTAqN//3rhh9eF7IxJHbYrenpv7wtq/Qb7Lx32
 of4TAiieJahkkDBJ/SN7Mcgj2cVIjT4Uj1+Dolbu/lVejFIMlSkkg+crmJ7unz3KHMqx
 szMw==
X-Gm-Message-State: AOJu0YzxoNTXfv11YzfYMPW6kC6aaVG/aWzpDjHmn1D8At0Kx7ZFci7W
 4fUGgBNkd+FE6O3QuARytUT+Ow==
X-Google-Smtp-Source: AGHT+IHjzLNqG+XxuofOD+5Y4u+pU/uaEv/xOi/+0w38knsAr+OcNrcWAzMUYkcg9a8p/C/pBumWjw==
X-Received: by 2002:a5d:49c7:0:b0:317:70da:abdd with SMTP id
 t7-20020a5d49c7000000b0031770daabddmr4420653wrs.59.1693497805047; 
 Thu, 31 Aug 2023 09:03:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b4-20020adfde04000000b0031aef72a021sm2608486wrm.86.2023.08.31.09.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:02:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 05B551FFBB;
 Thu, 31 Aug 2023 17:02:54 +0100 (BST)
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
 <20230710153522.3469097-11-alex.bennee@linaro.org>
 <20230710155653-mutt-send-email-mst@kernel.org>
 <CADSE00KvkezAHR_BGGwV5MT-KstLaZzMGM+gxpfm+91aqdRwmg@mail.gmail.com>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Raphael Norwitz
 <raphael.norwitz@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Kevin Wolf <kwolf@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Mathieu
 Poirier <mathieu.poirier@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>, Eduardo Habkost <eduardo@habkost.net>, Fam
 Zheng <fam@euphon.net>, virtio-fs@redhat.com, Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH v3 10/20] hw/virtio: add config support to
 vhost-user-device
Date: Thu, 31 Aug 2023 16:47:55 +0100
In-reply-to: <CADSE00KvkezAHR_BGGwV5MT-KstLaZzMGM+gxpfm+91aqdRwmg@mail.gmail.com>
Message-ID: <87r0njp5ci.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Albert Esteve <aesteve@redhat.com> writes:

> Sorry to bring up this post, it's been a while since you posted.
> But I have been testing the patch the last couple of days.
>
> On Mon, Jul 10, 2023 at 9:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
>
>  On Mon, Jul 10, 2023 at 04:35:12PM +0100, Alex Benn=C3=A9e wrote:
>  > To use the generic device the user will need to provide the config
>  > region size via the command line. We also add a notifier so the guest
>  > can be pinged if the remote daemon updates the config.
>  >=20
>  > With these changes:
>  >=20
>  >   -device vhost-user-device-pci,virtio-id=3D41,num_vqs=3D2,config_size=
=3D8
>  >=20
>  > is equivalent to:
>  >=20
>  >   -device vhost-user-gpio-pci
>  >=20
>  > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
>  This one I think it's best to defer until we get a better
>  handle on how we want the configuration to look.
>
>  > ---
>  >  include/hw/virtio/vhost-user-device.h |  1 +
>  >  hw/virtio/vhost-user-device.c         | 58 ++++++++++++++++++++++++++-
>  >  2 files changed, 58 insertions(+), 1 deletion(-)
>  >=20
>  > diff --git a/include/hw/virtio/vhost-user-device.h b/include/hw/virtio=
/vhost-user-device.h
>  > index 9105011e25..3ddf88a146 100644
>  > --- a/include/hw/virtio/vhost-user-device.h
>  > +++ b/include/hw/virtio/vhost-user-device.h
>  > @@ -22,6 +22,7 @@ struct VHostUserBase {
>  >      CharBackend chardev;
>  >      uint16_t virtio_id;
>  >      uint32_t num_vqs;
>  > +    uint32_t config_size;
>  >      /* State tracking */
>  >      VhostUserState vhost_user;
>  >      struct vhost_virtqueue *vhost_vq;
>  > diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-devi=
ce.c
>  > index b0239fa033..2b028cae08 100644
>  > --- a/hw/virtio/vhost-user-device.c
>  > +++ b/hw/virtio/vhost-user-device.c
>  > @@ -117,6 +117,42 @@ static uint64_t vub_get_features(VirtIODevice *vd=
ev,
>  >      return vub->vhost_dev.features & ~(1ULL << VHOST_USER_F_PROTOCOL_=
FEATURES);
>  >  }
>  >=20=20
>  > +/*
>  > + * To handle VirtIO config we need to know the size of the config
>  > + * space. We don't cache the config but re-fetch it from the guest
>  > + * every time in case something has changed.
>  > + */
>  > +static void vub_get_config(VirtIODevice *vdev, uint8_t *config)
>  > +{
>  > +    VHostUserBase *vub =3D VHOST_USER_BASE(vdev);
>  > +    Error *local_err =3D NULL;
>  > +
>  > +    /*
>  > +     * There will have been a warning during vhost_dev_init, but lets
>  > +     * assert here as nothing will go right now.
>  > +     */
>  > +    g_assert(vub->config_size && vub->vhost_user.supports_config =3D=
=3D true);
>  > +
>  > +    if (vhost_dev_get_config(&vub->vhost_dev, config,
>  > +                             vub->config_size, &local_err)) {
>  > +        error_report_err(local_err);
>  > +    }
>  > +}
>  > +
>  > +/*
>  > + * When the daemon signals an update to the config we just need to
>  > + * signal the guest as we re-read the config on demand above.
>  > + */
>  > +static int vub_config_notifier(struct vhost_dev *dev)
>  > +{
>  > +    virtio_notify_config(dev->vdev);
>  > +    return 0;
>  > +}
>  > +
>  > +const VhostDevConfigOps vub_config_ops =3D {
>  > +    .vhost_dev_config_notifier =3D vub_config_notifier,
>  > +};
>  > +
>  >  static void vub_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  >  {
>  >      /*
>  > @@ -141,12 +177,21 @@ static int vub_connect(DeviceState *dev)
>  >  {
>  >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>  >      VHostUserBase *vub =3D VHOST_USER_BASE(vdev);
>  > +    struct vhost_dev *vhost_dev =3D &vub->vhost_dev;
>  >=20=20
>  >      if (vub->connected) {
>  >          return 0;
>  >      }
>  >      vub->connected =3D true;
>  >=20=20
>  > +    /*
>  > +     * If we support VHOST_USER_GET_CONFIG we must enable the notifier
>  > +     * so we can ping the guest when it updates.
>  > +     */
>  > +    if (vub->vhost_user.supports_config) {
>  > +        vhost_dev_set_config_notifier(vhost_dev, &vub_config_ops);
>  > +    }
>  > +
>  >      /* restore vhost state */
>  >      if (virtio_device_started(vdev, vdev->status)) {
>  >          vub_start(vdev);
>  > @@ -214,11 +259,20 @@ static void vub_device_realize(DeviceState *dev,=
 Error **errp)
>  >          vub->num_vqs =3D 1; /* reasonable default? */
>  >      }
>  >=20=20
>  > +    /*
>  > +     * We can't handle config requests unless we know the size of the
>  > +     * config region, specialisations of the vhost-user-device will be
>  > +     * able to set this.
>  > +     */
>  > +    if (vub->config_size) {
>  > +        vub->vhost_user.supports_config =3D true;
>  > +    }
>
> Shouldn't the `supports_config =3D true' be set before we call vhost_dev_=
init() a few lines above?
> Otherwise, we end up checking the `supports_config` attribute from within=
 `vhost_user_backend_init()` (in vhost_user
> source file)
> before the VhostUserState is set, causing this warning to pop if the back=
end supports the CONFIG feature:
> ```
> qemu-system-x86_64: warning: vhost-user backend supports VHOST_USER_PROTO=
COL_F_CONFIG but QEMU does
> not.
> ```

I allude to that in the comments for vub_get_config() further up.
However the more I look at this the more confused I am about the
original intention of the flag I added (*blush*). I think we need to
handle the following cases:

 - the virtio device has no config space
 - the virtio device has config space, emulated inside qemu
 - the virtio vhost device has config space, emulated inside qemu
 - the virtio vhost device has config space, handled by vhost

for the final case the qemu internals need to be able to handle the
signalling of updates to the config by the vhost device by way of the
notifier.

In the case of a "standalone" vhost-user daemon we won't even know if
there is a config space until we have connected to it and queried its
size via protocol messages.

Maybe we need two fields?

  - supports_remote_config (device is capable of handling remote config)
  - config_location one of { NONE, LOCAL, REMOTE }
=20=20
>=20=20
>  > +
>  >      if (!vhost_user_init(&vub->vhost_user, &vub->chardev, errp)) {
>  >          return;
>  >      }
>  >=20=20
>  > -    virtio_init(vdev, vub->virtio_id, 0);
>  > +    virtio_init(vdev, vub->virtio_id, vub->config_size);
>  >=20=20
>  >      /*
>  >       * Disable guest notifiers, by default all notifications will be =
via the
>  > @@ -268,6 +322,7 @@ static void vub_class_init(ObjectClass *klass, voi=
d *data)
>  >      vdc->realize =3D vub_device_realize;
>  >      vdc->unrealize =3D vub_device_unrealize;
>  >      vdc->get_features =3D vub_get_features;
>  > +    vdc->get_config =3D vub_get_config;
>  >      vdc->set_status =3D vub_set_status;
>  >  }
>  >=20=20
>  > @@ -295,6 +350,7 @@ static Property vud_properties[] =3D {
>  >      DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
>  >      DEFINE_PROP_UINT16("virtio-id", VHostUserBase, virtio_id, 0),
>  >      DEFINE_PROP_UINT32("num_vqs", VHostUserBase, num_vqs, 1),
>  > +    DEFINE_PROP_UINT32("config_size", VHostUserBase, config_size, 0),
>  >      DEFINE_PROP_END_OF_LIST(),
>  >  };
>  >=20=20
>  > --=20
>  > 2.39.2


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

