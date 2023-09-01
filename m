Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ACC78F83C
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 07:58:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbx9Z-0002Xq-D7; Fri, 01 Sep 2023 01:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erik.schilling@linaro.org>)
 id 1qbx9X-0002XY-DM
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 01:57:07 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <erik.schilling@linaro.org>)
 id 1qbx9T-0003Al-SM
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 01:57:07 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4fe27849e6aso2789715e87.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 22:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693547821; x=1694152621; darn=nongnu.org;
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maNIWersR24a2ieoFGMm9n+vquHsYIujgFp3vvnaJwE=;
 b=hVfapbgT92SQh2QCpro5+1je4BKtdL5PQwOLH75Gsttm0GG2svxj4IcqsviV81lO3D
 vlgqha697kffxOJtU5vPKKGMFU3ypYiSAomQEb0OXqTVX1Cwf8IJc5uXEUKwrTy8Gns1
 HEmJ5PAFvop/0EgbTWuwAs1sTUMPndkmLHnX/EhWUfwqF24ou4ECLbGz0Elo4FE7RP5v
 jxwPiebWu1bPrLrPqj2UK/muQ+MjfoptvfQX4yO4Y4BlNMmMbV4Uk42jMFWvBiLwxSHB
 bTlk6NrqqomQpLdzreYARdEBIFYKetPCBOfD/0bhqSWt9f7wo+vWACa2JkdlLvqBK0qj
 GgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693547821; x=1694152621;
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=maNIWersR24a2ieoFGMm9n+vquHsYIujgFp3vvnaJwE=;
 b=hIVtpYsdI6ymlblAUkGrwrr54hEI2y/JuFlfSljL+d1kmBqO9RM+Uw5/xRANUJ9BRX
 8vHpWItAOq47P+SPkk1RKa7WCccDBdCubRqEVBRnTlZv6rFtEzoh/TDG8bIj1cz+9xuP
 pdAtCtSq4nHBMFqBIESt0rxas7u5hAVcmZyan6AtqG6aH/55/dwdgwtQuOGKRnWbZRy2
 6z5rHIiFNGAGk+vBKKBfk3DY2Bxb6FtqTJGWSHLOy6VVkZzM/a+B2IM3d6vz6Tfq6x5Q
 yxNNVY/8ie3ZLMSC5fUK+sGHmA6RTjpoP3UPe92nVByQFzHr8tB8zSnTvi+sIPS67idW
 tQXg==
X-Gm-Message-State: AOJu0Yx23tMtjLC1exZhskX00lKCYqg33D/E917y0NYICkpYz4L36YMD
 ma9fWdcFUlTNczhYEQO6RmKCIg==
X-Google-Smtp-Source: AGHT+IGVBZH7BSdk1MlmTSnc3HL2tzA+yMuaZL0U/MSDj2AjLZ8vo8uaCoHFGkXTAliIT5w2mQfBPA==
X-Received: by 2002:ac2:5f48:0:b0:4fd:bc33:e508 with SMTP id
 8-20020ac25f48000000b004fdbc33e508mr777344lfz.49.1693547820393; 
 Thu, 31 Aug 2023 22:57:00 -0700 (PDT)
Received: from localhost (i53878940.versanet.de. [83.135.137.64])
 by smtp.gmail.com with ESMTPSA id
 dy20-20020a05640231f400b0052a48f4065esm1637738edb.39.2023.08.31.22.56.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 22:56:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Sep 2023 07:56:58 +0200
Message-Id: <CV7CLJGPFZ26.HU9GCD8MLZHK@ablu-work>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, "Jason
 Wang" <jasowang@redhat.com>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Raphael Norwitz" <raphael.norwitz@nutanix.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>, =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, <qemu-block@nongnu.org>, "Eric Blake"
 <eblake@redhat.com>, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 "Kevin Wolf" <kwolf@redhat.com>, "Markus Armbruster" <armbru@redhat.com>,
 "Gerd Hoffmann" <kraxel@redhat.com>, "Mathieu Poirier"
 <mathieu.poirier@linaro.org>, "Hanna Reitz" <hreitz@redhat.com>, "Gonglei
 (Arei)" <arei.gonglei@huawei.com>, "Eduardo Habkost" <eduardo@habkost.net>,
 "Fam Zheng" <fam@euphon.net>, <virtio-fs@redhat.com>, "Stefan Hajnoczi"
 <stefanha@redhat.com>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, "Albert Esteve"
 <aesteve@redhat.com>
From: "Erik Schilling" <erik.schilling@linaro.org>
Subject: Re: [PATCH v3 10/20] hw/virtio: add config support to
 vhost-user-device
X-Mailer: aerc 0.15.2
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
 <20230710153522.3469097-11-alex.bennee@linaro.org>
 <20230710155653-mutt-send-email-mst@kernel.org>
 <CADSE00KvkezAHR_BGGwV5MT-KstLaZzMGM+gxpfm+91aqdRwmg@mail.gmail.com>
 <87r0njp5ci.fsf@linaro.org>
In-Reply-To: <87r0njp5ci.fsf@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=erik.schilling@linaro.org; helo=mail-lf1-x12c.google.com
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

On Thu Aug 31, 2023 at 5:47 PM CEST, Alex Benn=C3=A9e wrote:
>
> Albert Esteve <aesteve@redhat.com> writes:
>
> > Sorry to bring up this post, it's been a while since you posted.
> > But I have been testing the patch the last couple of days.
> >
> > On Mon, Jul 10, 2023 at 9:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> >
> >  On Mon, Jul 10, 2023 at 04:35:12PM +0100, Alex Benn=C3=A9e wrote:
> >  > To use the generic device the user will need to provide the config
> >  > region size via the command line. We also add a notifier so the gues=
t
> >  > can be pinged if the remote daemon updates the config.
> >  >=20
> >  > With these changes:
> >  >=20
> >  >   -device vhost-user-device-pci,virtio-id=3D41,num_vqs=3D2,config_si=
ze=3D8
> >  >=20
> >  > is equivalent to:
> >  >=20
> >  >   -device vhost-user-gpio-pci
> >  >=20
> >  > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> >  This one I think it's best to defer until we get a better
> >  handle on how we want the configuration to look.
> >
> >  > ---
> >  >  include/hw/virtio/vhost-user-device.h |  1 +
> >  >  hw/virtio/vhost-user-device.c         | 58 ++++++++++++++++++++++++=
++-
> >  >  2 files changed, 58 insertions(+), 1 deletion(-)
> >  >=20
> >  > diff --git a/include/hw/virtio/vhost-user-device.h b/include/hw/virt=
io/vhost-user-device.h
> >  > index 9105011e25..3ddf88a146 100644
> >  > --- a/include/hw/virtio/vhost-user-device.h
> >  > +++ b/include/hw/virtio/vhost-user-device.h
> >  > @@ -22,6 +22,7 @@ struct VHostUserBase {
> >  >      CharBackend chardev;
> >  >      uint16_t virtio_id;
> >  >      uint32_t num_vqs;
> >  > +    uint32_t config_size;
> >  >      /* State tracking */
> >  >      VhostUserState vhost_user;
> >  >      struct vhost_virtqueue *vhost_vq;
> >  > diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-de=
vice.c
> >  > index b0239fa033..2b028cae08 100644
> >  > --- a/hw/virtio/vhost-user-device.c
> >  > +++ b/hw/virtio/vhost-user-device.c
> >  > @@ -117,6 +117,42 @@ static uint64_t vub_get_features(VirtIODevice *=
vdev,
> >  >      return vub->vhost_dev.features & ~(1ULL << VHOST_USER_F_PROTOCO=
L_FEATURES);
> >  >  }
> >  > =20
> >  > +/*
> >  > + * To handle VirtIO config we need to know the size of the config
> >  > + * space. We don't cache the config but re-fetch it from the guest
> >  > + * every time in case something has changed.
> >  > + */
> >  > +static void vub_get_config(VirtIODevice *vdev, uint8_t *config)
> >  > +{
> >  > +    VHostUserBase *vub =3D VHOST_USER_BASE(vdev);
> >  > +    Error *local_err =3D NULL;
> >  > +
> >  > +    /*
> >  > +     * There will have been a warning during vhost_dev_init, but le=
ts
> >  > +     * assert here as nothing will go right now.
> >  > +     */
> >  > +    g_assert(vub->config_size && vub->vhost_user.supports_config =
=3D=3D true);
> >  > +
> >  > +    if (vhost_dev_get_config(&vub->vhost_dev, config,
> >  > +                             vub->config_size, &local_err)) {
> >  > +        error_report_err(local_err);
> >  > +    }
> >  > +}
> >  > +
> >  > +/*
> >  > + * When the daemon signals an update to the config we just need to
> >  > + * signal the guest as we re-read the config on demand above.
> >  > + */
> >  > +static int vub_config_notifier(struct vhost_dev *dev)
> >  > +{
> >  > +    virtio_notify_config(dev->vdev);
> >  > +    return 0;
> >  > +}
> >  > +
> >  > +const VhostDevConfigOps vub_config_ops =3D {
> >  > +    .vhost_dev_config_notifier =3D vub_config_notifier,
> >  > +};
> >  > +
> >  >  static void vub_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> >  >  {
> >  >      /*
> >  > @@ -141,12 +177,21 @@ static int vub_connect(DeviceState *dev)
> >  >  {
> >  >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >  >      VHostUserBase *vub =3D VHOST_USER_BASE(vdev);
> >  > +    struct vhost_dev *vhost_dev =3D &vub->vhost_dev;
> >  > =20
> >  >      if (vub->connected) {
> >  >          return 0;
> >  >      }
> >  >      vub->connected =3D true;
> >  > =20
> >  > +    /*
> >  > +     * If we support VHOST_USER_GET_CONFIG we must enable the notif=
ier
> >  > +     * so we can ping the guest when it updates.
> >  > +     */
> >  > +    if (vub->vhost_user.supports_config) {
> >  > +        vhost_dev_set_config_notifier(vhost_dev, &vub_config_ops);
> >  > +    }
> >  > +
> >  >      /* restore vhost state */
> >  >      if (virtio_device_started(vdev, vdev->status)) {
> >  >          vub_start(vdev);
> >  > @@ -214,11 +259,20 @@ static void vub_device_realize(DeviceState *de=
v, Error **errp)
> >  >          vub->num_vqs =3D 1; /* reasonable default? */
> >  >      }
> >  > =20
> >  > +    /*
> >  > +     * We can't handle config requests unless we know the size of t=
he
> >  > +     * config region, specialisations of the vhost-user-device will=
 be
> >  > +     * able to set this.
> >  > +     */
> >  > +    if (vub->config_size) {
> >  > +        vub->vhost_user.supports_config =3D true;
> >  > +    }
> >
> > Shouldn't the `supports_config =3D true' be set before we call vhost_de=
v_init() a few lines above?
> > Otherwise, we end up checking the `supports_config` attribute from with=
in `vhost_user_backend_init()` (in vhost_user
> > source file)
> > before the VhostUserState is set, causing this warning to pop if the ba=
ckend supports the CONFIG feature:
> > ```
> > qemu-system-x86_64: warning: vhost-user backend supports VHOST_USER_PRO=
TOCOL_F_CONFIG but QEMU does
> > not.
> > ```
>
> I allude to that in the comments for vub_get_config() further up.
> However the more I look at this the more confused I am about the
> original intention of the flag I added (*blush*). I think we need to
> handle the following cases:
>
>  - the virtio device has no config space
>  - the virtio device has config space, emulated inside qemu
>  - the virtio vhost device has config space, emulated inside qemu
>  - the virtio vhost device has config space, handled by vhost
>
> for the final case the qemu internals need to be able to handle the
> signalling of updates to the config by the vhost device by way of the
> notifier.
>
> In the case of a "standalone" vhost-user daemon we won't even know if
> there is a config space until we have connected to it and queried its
> size via protocol messages.
>
> Maybe we need two fields?
>
>   - supports_remote_config (device is capable of handling remote config)
>   - config_location one of { NONE, LOCAL, REMOTE }

Hm... Shouldn't the F_CONFIG flag already indicate
`supports_remote_config` (you mean "backend-handled" config, right?) and
the negotiation of the flag would clarify the location?

Of course, there would be a disambiguity between case 3 and 4. But
wouldn't that be decidable by the configured QEMU device? The new
standalone device could default to just forwarding the backend config
while the existing devices could continue providing their proxies where
required?

- Erik

>  =20
> > =20
> >  > +
> >  >      if (!vhost_user_init(&vub->vhost_user, &vub->chardev, errp)) {
> >  >          return;
> >  >      }
> >  > =20
> >  > -    virtio_init(vdev, vub->virtio_id, 0);
> >  > +    virtio_init(vdev, vub->virtio_id, vub->config_size);
> >  > =20
> >  >      /*
> >  >       * Disable guest notifiers, by default all notifications will b=
e via the
> >  > @@ -268,6 +322,7 @@ static void vub_class_init(ObjectClass *klass, v=
oid *data)
> >  >      vdc->realize =3D vub_device_realize;
> >  >      vdc->unrealize =3D vub_device_unrealize;
> >  >      vdc->get_features =3D vub_get_features;
> >  > +    vdc->get_config =3D vub_get_config;
> >  >      vdc->set_status =3D vub_set_status;
> >  >  }
> >  > =20
> >  > @@ -295,6 +350,7 @@ static Property vud_properties[] =3D {
> >  >      DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> >  >      DEFINE_PROP_UINT16("virtio-id", VHostUserBase, virtio_id, 0),
> >  >      DEFINE_PROP_UINT32("num_vqs", VHostUserBase, num_vqs, 1),
> >  > +    DEFINE_PROP_UINT32("config_size", VHostUserBase, config_size, 0=
),
> >  >      DEFINE_PROP_END_OF_LIST(),
> >  >  };
> >  > =20
> >  > --=20
> >  > 2.39.2


