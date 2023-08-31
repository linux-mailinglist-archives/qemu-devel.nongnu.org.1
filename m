Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDDC78EF88
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 16:24:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbiaN-0001Cx-6A; Thu, 31 Aug 2023 10:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qbiaL-0001Cd-8Y
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 10:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qbiaH-00045U-Po
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 10:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693491824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vw213T7Ecc+0liAHY6D9H7FvAQTdMgJy8cTW6qK++bc=;
 b=PMO2Wld0rrp0A6BwRpRa1vA9zaYvLHjwfjJrjJRrrM88+SjB7uLXEC9hD7ucWxdWDg6CTS
 0j4RmWMszUUcPTl8+2v90ZO43CZe2O0jRCEhaNpJlMZAe5n3Ooj8KIiFwylNOxT+UGzJE1
 eAJ82HOEIgthQeujktyFKx45U+luPVE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-4IVfZbFmOhOMVeob_NRkxQ-1; Thu, 31 Aug 2023 10:23:42 -0400
X-MC-Unique: 4IVfZbFmOhOMVeob_NRkxQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-26f49625bffso969223a91.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 07:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693491821; x=1694096621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vw213T7Ecc+0liAHY6D9H7FvAQTdMgJy8cTW6qK++bc=;
 b=KiT3WG02v0FgODTF3+l451d0G91KEUWnENl0l31kUAuiLIN0m8rx6g+OHvUdGhTHxf
 nIhzFW5sNfL4gX+zPUgjsfDweNEb/wxb+3D7o3VBYiLrbks7OBOTedEo2ly+1HQpTT82
 0I8kO8o9fMHICWG9MRIiCltou2J+s+fYXrBcu4i8Aau4LzRhWxAyw5BrF9V0i33pHOpU
 l6I2E4z1BrdcvXk3WlWZJ6PKmVUuS+cm4lwCwLxPPmNH33fAdphel208YF387YiTnaMz
 YTLbOQWCr+flB5wANLqEl/PRcRKYE65dCYtDF0GUYnnsgPnpduCP96rJ+N0qzdk9bb6T
 DH0Q==
X-Gm-Message-State: AOJu0YxEZWNrYOJ1UoNUvr8CEsIXLS6HvaG1LkKnZBczcoD0sVGD3FGp
 loRGEov+aW4DTKZh3hOEsMOoMiWcZ5syA5GMsS14q8R6YxKH3KNi5UpXMZezMVyi6C2p8v8VM39
 C2nRVHJHKy+4kcs2zvLbkDoXVs9B3lQs=
X-Received: by 2002:a17:90a:c252:b0:26d:ae3:f6a6 with SMTP id
 d18-20020a17090ac25200b0026d0ae3f6a6mr4977766pjx.18.1693491821354; 
 Thu, 31 Aug 2023 07:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA+gFHBjprhcgTkI3XOivDlD8hOU3FdCwgvII8i0dvQJrcTGhB6wpM9ULjhvZnsreQNUe3tT+sKQviC7dqCgo=
X-Received: by 2002:a17:90a:c252:b0:26d:ae3:f6a6 with SMTP id
 d18-20020a17090ac25200b0026d0ae3f6a6mr4977726pjx.18.1693491821037; Thu, 31
 Aug 2023 07:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
 <20230710153522.3469097-11-alex.bennee@linaro.org>
 <20230710155653-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230710155653-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 31 Aug 2023 16:23:29 +0200
Message-ID: <CADSE00KvkezAHR_BGGwV5MT-KstLaZzMGM+gxpfm+91aqdRwmg@mail.gmail.com>
Subject: Re: [PATCH v3 10/20] hw/virtio: add config support to
 vhost-user-device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Hanna Reitz <hreitz@redhat.com>, 
 Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006c62e5060438ca4c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000006c62e5060438ca4c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry to bring up this post, it's been a while since you posted.
But I have been testing the patch the last couple of days.

On Mon, Jul 10, 2023 at 9:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Mon, Jul 10, 2023 at 04:35:12PM +0100, Alex Benn=C3=A9e wrote:
> > To use the generic device the user will need to provide the config
> > region size via the command line. We also add a notifier so the guest
> > can be pinged if the remote daemon updates the config.
> >
> > With these changes:
> >
> >   -device vhost-user-device-pci,virtio-id=3D41,num_vqs=3D2,config_size=
=3D8
> >
> > is equivalent to:
> >
> >   -device vhost-user-gpio-pci
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
>
> This one I think it's best to defer until we get a better
> handle on how we want the configuration to look.
>
>
> > ---
> >  include/hw/virtio/vhost-user-device.h |  1 +
> >  hw/virtio/vhost-user-device.c         | 58 ++++++++++++++++++++++++++-
> >  2 files changed, 58 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/hw/virtio/vhost-user-device.h
> b/include/hw/virtio/vhost-user-device.h
> > index 9105011e25..3ddf88a146 100644
> > --- a/include/hw/virtio/vhost-user-device.h
> > +++ b/include/hw/virtio/vhost-user-device.h
> > @@ -22,6 +22,7 @@ struct VHostUserBase {
> >      CharBackend chardev;
> >      uint16_t virtio_id;
> >      uint32_t num_vqs;
> > +    uint32_t config_size;
> >      /* State tracking */
> >      VhostUserState vhost_user;
> >      struct vhost_virtqueue *vhost_vq;
> > diff --git a/hw/virtio/vhost-user-device.c
> b/hw/virtio/vhost-user-device.c
> > index b0239fa033..2b028cae08 100644
> > --- a/hw/virtio/vhost-user-device.c
> > +++ b/hw/virtio/vhost-user-device.c
> > @@ -117,6 +117,42 @@ static uint64_t vub_get_features(VirtIODevice *vde=
v,
> >      return vub->vhost_dev.features & ~(1ULL <<
> VHOST_USER_F_PROTOCOL_FEATURES);
> >  }
> >
> > +/*
> > + * To handle VirtIO config we need to know the size of the config
> > + * space. We don't cache the config but re-fetch it from the guest
> > + * every time in case something has changed.
> > + */
> > +static void vub_get_config(VirtIODevice *vdev, uint8_t *config)
> > +{
> > +    VHostUserBase *vub =3D VHOST_USER_BASE(vdev);
> > +    Error *local_err =3D NULL;
> > +
> > +    /*
> > +     * There will have been a warning during vhost_dev_init, but lets
> > +     * assert here as nothing will go right now.
> > +     */
> > +    g_assert(vub->config_size && vub->vhost_user.supports_config =3D=
=3D
> true);
> > +
> > +    if (vhost_dev_get_config(&vub->vhost_dev, config,
> > +                             vub->config_size, &local_err)) {
> > +        error_report_err(local_err);
> > +    }
> > +}
> > +
> > +/*
> > + * When the daemon signals an update to the config we just need to
> > + * signal the guest as we re-read the config on demand above.
> > + */
> > +static int vub_config_notifier(struct vhost_dev *dev)
> > +{
> > +    virtio_notify_config(dev->vdev);
> > +    return 0;
> > +}
> > +
> > +const VhostDevConfigOps vub_config_ops =3D {
> > +    .vhost_dev_config_notifier =3D vub_config_notifier,
> > +};
> > +
> >  static void vub_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> >  {
> >      /*
> > @@ -141,12 +177,21 @@ static int vub_connect(DeviceState *dev)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >      VHostUserBase *vub =3D VHOST_USER_BASE(vdev);
> > +    struct vhost_dev *vhost_dev =3D &vub->vhost_dev;
> >
> >      if (vub->connected) {
> >          return 0;
> >      }
> >      vub->connected =3D true;
> >
> > +    /*
> > +     * If we support VHOST_USER_GET_CONFIG we must enable the notifier
> > +     * so we can ping the guest when it updates.
> > +     */
> > +    if (vub->vhost_user.supports_config) {
> > +        vhost_dev_set_config_notifier(vhost_dev, &vub_config_ops);
> > +    }
> > +
> >      /* restore vhost state */
> >      if (virtio_device_started(vdev, vdev->status)) {
> >          vub_start(vdev);
> > @@ -214,11 +259,20 @@ static void vub_device_realize(DeviceState *dev,
> Error **errp)
> >          vub->num_vqs =3D 1; /* reasonable default? */
> >      }
> >
> > +    /*
> > +     * We can't handle config requests unless we know the size of the
> > +     * config region, specialisations of the vhost-user-device will be
> > +     * able to set this.
> > +     */
> > +    if (vub->config_size) {
> > +        vub->vhost_user.supports_config =3D true;
> > +    }
>

Shouldn't the `supports_config =3D true' be set before we
call vhost_dev_init() a few lines above?
Otherwise, we end up checking the `supports_config` attribute from within
`vhost_user_backend_init()` (in vhost_user source file)
before the VhostUserState is set, causing this warning to pop if the
backend supports the CONFIG feature:
```
qemu-system-x86_64: warning: vhost-user backend supports
VHOST_USER_PROTOCOL_F_CONFIG but QEMU does not.
```


> > +
> >      if (!vhost_user_init(&vub->vhost_user, &vub->chardev, errp)) {
> >          return;
> >      }
> >
> > -    virtio_init(vdev, vub->virtio_id, 0);
> > +    virtio_init(vdev, vub->virtio_id, vub->config_size);
> >
> >      /*
> >       * Disable guest notifiers, by default all notifications will be
> via the
> > @@ -268,6 +322,7 @@ static void vub_class_init(ObjectClass *klass, void
> *data)
> >      vdc->realize =3D vub_device_realize;
> >      vdc->unrealize =3D vub_device_unrealize;
> >      vdc->get_features =3D vub_get_features;
> > +    vdc->get_config =3D vub_get_config;
> >      vdc->set_status =3D vub_set_status;
> >  }
> >
> > @@ -295,6 +350,7 @@ static Property vud_properties[] =3D {
> >      DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> >      DEFINE_PROP_UINT16("virtio-id", VHostUserBase, virtio_id, 0),
> >      DEFINE_PROP_UINT32("num_vqs", VHostUserBase, num_vqs, 1),
> > +    DEFINE_PROP_UINT32("config_size", VHostUserBase, config_size, 0),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > --
> > 2.39.2
>
>
>

--0000000000006c62e5060438ca4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr">Sorry to bring up this post, it&#39;s been a while =
since you posted.<br></div></div></div><div>But I have been testing the=C2=
=A0patch the last couple of days.</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 10, 2023 at 9:58=E2=80=
=AFPM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Mon, Jul 10, 2023 at 04:35:12PM +0100, Alex Benn=C3=A9e wrote:<br>
&gt; To use the generic device the user will need to provide the config<br>
&gt; region size via the command line. We also add a notifier so the guest<=
br>
&gt; can be pinged if the remote daemon updates the config.<br>
&gt; <br>
&gt; With these changes:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0-device vhost-user-device-pci,virtio-id=3D41,num_vqs=3D2,c=
onfig_size=3D8<br>
&gt; <br>
&gt; is equivalent to:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0-device vhost-user-gpio-pci<br>
&gt; <br>
&gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@lina=
ro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br>
<br>
This one I think it&#39;s best to defer until we get a better<br>
handle on how we want the configuration to look.<br>
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 include/hw/virtio/vhost-user-device.h |=C2=A0 1 +<br>
&gt;=C2=A0 hw/virtio/vhost-user-device.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 58 ++++++++++++++++++++++++++-<br>
&gt;=C2=A0 2 files changed, 58 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/include/hw/virtio/vhost-user-device.h b/include/hw/virtio=
/vhost-user-device.h<br>
&gt; index 9105011e25..3ddf88a146 100644<br>
&gt; --- a/include/hw/virtio/vhost-user-device.h<br>
&gt; +++ b/include/hw/virtio/vhost-user-device.h<br>
&gt; @@ -22,6 +22,7 @@ struct VHostUserBase {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CharBackend chardev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint16_t virtio_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t num_vqs;<br>
&gt; +=C2=A0 =C2=A0 uint32_t config_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* State tracking */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VhostUserState vhost_user;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct vhost_virtqueue *vhost_vq;<br>
&gt; diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-devi=
ce.c<br>
&gt; index b0239fa033..2b028cae08 100644<br>
&gt; --- a/hw/virtio/vhost-user-device.c<br>
&gt; +++ b/hw/virtio/vhost-user-device.c<br>
&gt; @@ -117,6 +117,42 @@ static uint64_t vub_get_features(VirtIODevice *vd=
ev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return vub-&gt;vhost_dev.features &amp; ~(1ULL &lt=
;&lt; VHOST_USER_F_PROTOCOL_FEATURES);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +/*<br>
&gt; + * To handle VirtIO config we need to know the size of the config<br>
&gt; + * space. We don&#39;t cache the config but re-fetch it from the gues=
t<br>
&gt; + * every time in case something has changed.<br>
&gt; + */<br>
&gt; +static void vub_get_config(VirtIODevice *vdev, uint8_t *config)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VHostUserBase *vub =3D VHOST_USER_BASE(vdev);<br>
&gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* There will have been a warning during vhost_dev=
_init, but lets<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* assert here as nothing will go right now.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 g_assert(vub-&gt;config_size &amp;&amp; vub-&gt;vhost_u=
ser.supports_config =3D=3D true);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vhost_dev_get_config(&amp;vub-&gt;vhost_dev, config=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vub-&gt;config_size, &amp;local_err)) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * When the daemon signals an update to the config we just need to<br=
>
&gt; + * signal the guest as we re-read the config on demand above.<br>
&gt; + */<br>
&gt; +static int vub_config_notifier(struct vhost_dev *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 virtio_notify_config(dev-&gt;vdev);<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +const VhostDevConfigOps vub_config_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .vhost_dev_config_notifier =3D vub_config_notifier,<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 static void vub_handle_output(VirtIODevice *vdev, VirtQueue *vq)=
<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; @@ -141,12 +177,21 @@ static int vub_connect(DeviceState *dev)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHostUserBase *vub =3D VHOST_USER_BASE(vdev);<br>
&gt; +=C2=A0 =C2=A0 struct vhost_dev *vhost_dev =3D &amp;vub-&gt;vhost_dev;=
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (vub-&gt;connected) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vub-&gt;connected =3D true;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* If we support VHOST_USER_GET_CONFIG we must ena=
ble the notifier<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* so we can ping the guest when it updates.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (vub-&gt;vhost_user.supports_config) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_dev_set_config_notifier(vhost_dev, =
&amp;vub_config_ops);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* restore vhost state */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (virtio_device_started(vdev, vdev-&gt;status)) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vub_start(vdev);<br>
&gt; @@ -214,11 +259,20 @@ static void vub_device_realize(DeviceState *dev,=
 Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vub-&gt;num_vqs =3D 1; /* reasonable=
 default? */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* We can&#39;t handle config requests unless we k=
now the size of the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* config region, specialisations of the vhost-use=
r-device will be<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* able to set this.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (vub-&gt;config_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vub-&gt;vhost_user.supports_config =3D tr=
ue;<br>
&gt; +=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Shouldn&#39;t the=
 `supports_config =3D true&#39; be set before we call=C2=A0vhost_dev_init()=
 a few lines above?</div><div>Otherwise, we end up checking the `supports_c=
onfig` attribute from within `vhost_user_backend_init()` (in vhost_user sou=
rce file)</div><div>before the VhostUserState is set, causing this warning =
to pop if the backend supports the CONFIG feature:</div><div>```<br></div><=
div>qemu-system-x86_64: warning: vhost-user backend supports VHOST_USER_PRO=
TOCOL_F_CONFIG but QEMU does not.<br></div><div>```</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!vhost_user_init(&amp;vub-&gt;vhost_user, &amp=
;vub-&gt;chardev, errp)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 virtio_init(vdev, vub-&gt;virtio_id, 0);<br>
&gt; +=C2=A0 =C2=A0 virtio_init(vdev, vub-&gt;virtio_id, vub-&gt;config_siz=
e);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Disable guest notifiers, by default all no=
tifications will be via the<br>
&gt; @@ -268,6 +322,7 @@ static void vub_class_init(ObjectClass *klass, voi=
d *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vdc-&gt;realize =3D vub_device_realize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vdc-&gt;unrealize =3D vub_device_unrealize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vdc-&gt;get_features =3D vub_get_features;<br>
&gt; +=C2=A0 =C2=A0 vdc-&gt;get_config =3D vub_get_config;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vdc-&gt;set_status =3D vub_set_status;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -295,6 +350,7 @@ static Property vud_properties[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_CHR(&quot;chardev&quot;, VHostUserBase=
, chardev),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_UINT16(&quot;virtio-id&quot;, VHostUse=
rBase, virtio_id, 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;num_vqs&quot;, VHostUserB=
ase, num_vqs, 1),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;config_size&quot;, VHostUserBa=
se, config_size, 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; -- <br>
&gt; 2.39.2<br>
<br>
<br>
</blockquote></div></div>

--0000000000006c62e5060438ca4c--


