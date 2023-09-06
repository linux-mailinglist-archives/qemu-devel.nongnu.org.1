Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBC179407A
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:36:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qduYY-0000pe-90; Wed, 06 Sep 2023 11:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qduYV-0000ol-SO
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qduYS-00086c-RY
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694014495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=641qS3wJod5tEfVKWH4yGhoCUGWHL1BvoCyewwAIMqc=;
 b=Y7GpK0jJ0yiJSU0YE7EH5gMyqchdB+mfLDr0Smtigp6Schc4Zlouq9BPreo1IDqozUfVGa
 n0Ys4O0v8hm5BMzC6/Xazcue+0Cu6zQRltNyhmLpbDMfoXPryU6PbxEjiOmxETw+MfQGGB
 0UuqQdt6Enhjk9qk0o+hvIcMPhrQvRY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-FmR3YRMCMK-2PE0fCKQ_Cg-1; Wed, 06 Sep 2023 11:34:54 -0400
X-MC-Unique: FmR3YRMCMK-2PE0fCKQ_Cg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5703f4f8acdso42418a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 08:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694014493; x=1694619293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=641qS3wJod5tEfVKWH4yGhoCUGWHL1BvoCyewwAIMqc=;
 b=gYvb6a2c6T/JunFoSgthjqJZvfJP3OO2a2qzYF5t9/SabGZ9SbREMqEQ1kN1DZB3pX
 tPmBHr/nNtrs95YwOoAop53/fzOaKxXsmsfcV1ynqH7sSya8EgHkgworALYJXhqmoEuM
 346PEfEmxFBeAsya3P1OdlKs5k2jF8nFGg33cOLt2ZarsK0yGhtzppqeDssu/KP0pOnN
 W20voR/QaABq1JuBwAcUFp7ls8M+4wB6KeTccGf9afwSdb0z8nXt6A1u39NzABzAttx4
 ILp+drihiq/NBNd6NJg4ejoXihzskqb1FR6JRW5IV3tk/icosKKYU2xs5BhZYue0vLuo
 9Jtg==
X-Gm-Message-State: AOJu0Yx/RJthHExuUyFUFQbeiZqmmIKqx0GGAuPd9RVYaoPbICobPPx2
 8ZOpFcuo+X05YbTzRMkjQaXo/mijy9aV6dreSg1eSUCJTKee3Hbi11sg+kOO7Rvb3hOoj/bfuaB
 CV64FvcqmaNsa6XUxKp27bzmF3LR/GbU=
X-Received: by 2002:a05:6a20:8e1b:b0:14c:83a0:2aa with SMTP id
 y27-20020a056a208e1b00b0014c83a002aamr17105653pzj.53.1694014493142; 
 Wed, 06 Sep 2023 08:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmtmktPirzCivsBJxb5fliiTaLe6LOYkZ9rSEdAQp3dTMh0wYviU0axRkQa6KgiHv/c+xc4lC+ZHOhLA/r3IE=
X-Received: by 2002:a05:6a20:8e1b:b0:14c:83a0:2aa with SMTP id
 y27-20020a056a208e1b00b0014c83a002aamr17105622pzj.53.1694014492774; Wed, 06
 Sep 2023 08:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230906111549.357178-1-aesteve@redhat.com>
 <20230906111549.357178-3-aesteve@redhat.com>
 <c53f4cae-7014-066a-de3d-09f47b27dbc6@linaro.org>
In-Reply-To: <c53f4cae-7014-066a-de3d-09f47b27dbc6@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 6 Sep 2023 17:34:41 +0200
Message-ID: <CADSE00K43g+uz8kcTOhJAUe-X8-Ea1L4EWePS0ZoUkX4Dfs=+A@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] virtio-dmabuf: introduce virtio-dmabuf
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com, kraxel@redhat.com, 
 marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="000000000000162c750604b27cfe"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000162c750604b27cfe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 6, 2023 at 4:21=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> On 6/9/23 13:15, Albert Esteve wrote:
> > This API manages objects (in this iteration,
> > dmabuf fds) that can be shared along different
> > virtio devices, associated to a UUID.
> >
> > The API allows the different devices to add,
> > remove and/or retrieve the objects by simply
> > invoking the public functions that reside in the
> > virtio-dmabuf file.
> >
> > For vhost backends, the API stores the pointer
> > to the backend holding the object.
> >
> > Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >   MAINTAINERS                       |   7 ++
> >   hw/display/meson.build            |   1 +
> >   hw/display/virtio-dmabuf.c        | 134 +++++++++++++++++++++++++++++
> >   include/hw/virtio/virtio-dmabuf.h | 103 ++++++++++++++++++++++
> >   tests/unit/meson.build            |   1 +
> >   tests/unit/test-virtio-dmabuf.c   | 137 +++++++++++++++++++++++++++++=
+
> >   6 files changed, 383 insertions(+)
> >   create mode 100644 hw/display/virtio-dmabuf.c
> >   create mode 100644 include/hw/virtio/virtio-dmabuf.h
> >   create mode 100644 tests/unit/test-virtio-dmabuf.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3b29568ed4..fb0f7b823f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2150,6 +2150,13 @@ T: git https://gitlab.com/cohuck/qemu.git
> s390-next
> >   T: git https://github.com/borntraeger/qemu.git s390-next
> >   L: qemu-s390x@nongnu.org
> >
> > +virtio-dmabuf
> > +M: Albert Esteve <aesteve@redhat.com>
> > +S: Supported
> > +F: hw/display/virtio-dmabuf.c
> > +F: include/hw/virtio/virtio-dmabuf.h
> > +F: tests/unit/test-virtio-dmabuf.c
> > +
> >   virtiofs
> >   M: Stefan Hajnoczi <stefanha@redhat.com>
> >   S: Supported
> > diff --git a/hw/display/meson.build b/hw/display/meson.build
> > index 413ba4ab24..05619c6968 100644
> > --- a/hw/display/meson.build
> > +++ b/hw/display/meson.build
> > @@ -37,6 +37,7 @@ system_ss.add(when: 'CONFIG_MACFB', if_true:
> files('macfb.c'))
> >   system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
> >
> >   system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
> > +system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c')=
)
> >
> >   if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
> >       config_all_devices.has_key('CONFIG_VGA_PCI') or
> > diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> > new file mode 100644
> > index 0000000000..268ffe81ec
> > --- /dev/null
> > +++ b/hw/display/virtio-dmabuf.c
> > @@ -0,0 +1,134 @@
> > +/*
> > + * Virtio Shared dma-buf
> > + *
> > + * Copyright Red Hat, Inc. 2023
> > + *
> > + * Authors:
> > + *     Albert Esteve <aesteve@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "hw/virtio/virtio-dmabuf.h"
> > +
> > +
> > +static GMutex lock;
> > +static GHashTable *resource_uuids;
> > +
> > +/*
> > + * uuid_equal_func: wrapper for UUID is_equal function to
> > + * satisfy g_hash_table_new expected parameters signatures.
> > + */
> > +static int uuid_equal_func(const void *lhv, const void *rhv)
> > +{
> > +    return qemu_uuid_is_equal(lhv, rhv);
> > +}
> > +
> > +static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject
> *value)
> > +{
> > +    bool result;
> > +    g_mutex_lock(&lock);
> > +    if (resource_uuids =3D=3D NULL) {
> > +        resource_uuids =3D g_hash_table_new_full(
> > +            qemu_uuid_hash, uuid_equal_func, NULL, g_free);
> > +    }
> > +    if (g_hash_table_lookup(resource_uuids, uuid) !=3D NULL) {
> > +        g_mutex_unlock(&lock);
> > +        return false;
> > +    }
> > +    result =3D g_hash_table_insert(resource_uuids, uuid, value);
> > +    g_mutex_unlock(&lock);
> > +
> > +    return result;
> > +}
>
> Alternatively same logic, but simpler / safer:
>
> static bool virtio_add_resource(...)
> {
>      bool result =3D false;
>
>      g_mutex_lock(&lock);
>      if (resource_uuids =3D=3D NULL) {
>          resource_uuids =3D g_hash_table_new_full(qemu_uuid_hash,
>                                                 uuid_equal_func,
>                                                 NULL,
>                                                 g_free);
>      }
>      if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NULL) {
>         result =3D g_hash_table_insert(resource_uuids, uuid, value);
>      }
>      g_mutex_unlock(&lock);
>
>      return result;
> }
>
> > +static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)
> > +{
> > +    g_mutex_lock(&lock);
> > +    if (resource_uuids =3D=3D NULL) {
> > +        g_mutex_unlock(&lock);
> > +        return NULL;
> > +    }
> > +    gpointer lookup_res =3D g_hash_table_lookup(resource_uuids, uuid);
> > +    g_mutex_unlock(&lock);
> > +    return (VirtioSharedObject*) lookup_res;
> > +}
>
> Similarly:
>
> static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)
> {
>      gpointer lookup_res =3D NULL;
>
>      g_mutex_lock(&lock);
>      if (resource_uuids !=3D NULL) {
>          lookup_res =3D g_hash_table_lookup(resource_uuids, uuid);
>      }
>      g_mutex_unlock(&lock);
>
>      return (VirtioSharedObject *)lookup_res;
> }
>
> > +int main(int argc, char **argv)
> > +{
> > +    g_test_init(&argc, &argv, NULL);
> > +    g_test_add_func("/virtio-dmabuf/add_rm_res",
> test_add_remove_resources);
> > +        g_test_add_func("/virtio-dmabuf/add_rm_dev",
> test_add_remove_dev);
>
> Mis-indent.
>
> > +    g_test_add_func("/virtio-dmabuf/rm_invalid_res",
> > +                    test_remove_invalid_resource);
> > +    g_test_add_func("/virtio-dmabuf/add_invalid_res",
> > +                    test_add_invalid_resource);
> > +    g_test_add_func("/virtio-dmabuf/free_res", test_free_resources);
> > +
> > +    return g_test_run();
> > +}
>
> Thanks for updating, LGTM!
>
> Suggestions look good, and is true that will lead to more safe and
maintanable code in the future,
if we add more branches where the mutex has to be handled.
I will send another revision then, thanks!

--000000000000162c750604b27cfe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 6, 2023 at 4:21=
=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro=
.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On 6/9/23 13:15, Albert Esteve wrote:<br>
&gt; This API manages objects (in this iteration,<br>
&gt; dmabuf fds) that can be shared along different<br>
&gt; virtio devices, associated to a UUID.<br>
&gt; <br>
&gt; The API allows the different devices to add,<br>
&gt; remove and/or retrieve the objects by simply<br>
&gt; invoking the public functions that reside in the<br>
&gt; virtio-dmabuf file.<br>
&gt; <br>
&gt; For vhost backends, the API stores the pointer<br>
&gt; to the backend holding the object.<br>
&gt; <br>
&gt; Suggested-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" t=
arget=3D"_blank">kraxel@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 ++<br>
&gt;=C2=A0 =C2=A0hw/display/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/display/virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 13=
4 +++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-dmabuf.h | 103 ++++++++++++++++++=
++++<br>
&gt;=C2=A0 =C2=A0tests/unit/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0tests/unit/test-virtio-dmabuf.c=C2=A0 =C2=A0| 137 ++++++++=
++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A06 files changed, 383 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/virtio-dmabuf.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/virtio/virtio-dmabuf.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 tests/unit/test-virtio-dmabuf.c<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 3b29568ed4..fb0f7b823f 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -2150,6 +2150,13 @@ T: git <a href=3D"https://gitlab.com/cohuck/qem=
u.git" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/cohuck/qemu.=
git</a> s390-next<br>
&gt;=C2=A0 =C2=A0T: git <a href=3D"https://github.com/borntraeger/qemu.git"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/borntraeger/qemu.g=
it</a> s390-next<br>
&gt;=C2=A0 =C2=A0L: <a href=3D"mailto:qemu-s390x@nongnu.org" target=3D"_bla=
nk">qemu-s390x@nongnu.org</a><br>
&gt;=C2=A0 =C2=A0<br>
&gt; +virtio-dmabuf<br>
&gt; +M: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" target=3D"=
_blank">aesteve@redhat.com</a>&gt;<br>
&gt; +S: Supported<br>
&gt; +F: hw/display/virtio-dmabuf.c<br>
&gt; +F: include/hw/virtio/virtio-dmabuf.h<br>
&gt; +F: tests/unit/test-virtio-dmabuf.c<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0virtiofs<br>
&gt;=C2=A0 =C2=A0M: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.c=
om" target=3D"_blank">stefanha@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0S: Supported<br>
&gt; diff --git a/hw/display/meson.build b/hw/display/meson.build<br>
&gt; index 413ba4ab24..05619c6968 100644<br>
&gt; --- a/hw/display/meson.build<br>
&gt; +++ b/hw/display/meson.build<br>
&gt; @@ -37,6 +37,7 @@ system_ss.add(when: &#39;CONFIG_MACFB&#39;, if_true:=
 files(&#39;macfb.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_NEXTCUBE&#39;, if_true: fi=
les(&#39;next-fb.c&#39;))<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_VGA&#39;, if_true: files(&=
#39;vga.c&#39;))<br>
&gt; +system_ss.add(when: &#39;CONFIG_VIRTIO&#39;, if_true: files(&#39;virt=
io-dmabuf.c&#39;))<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0if (config_all_devices.has_key(&#39;CONFIG_VGA_CIRRUS&#39;=
) or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0config_all_devices.has_key(&#39;CONFIG_VGA_P=
CI&#39;) or<br>
&gt; diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c<b=
r>
&gt; new file mode 100644<br>
&gt; index 0000000000..268ffe81ec<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/display/virtio-dmabuf.c<br>
&gt; @@ -0,0 +1,134 @@<br>
&gt; +/*<br>
&gt; + * Virtio Shared dma-buf<br>
&gt; + *<br>
&gt; + * Copyright Red Hat, Inc. 2023<br>
&gt; + *<br>
&gt; + * Authors:<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0Albert Esteve &lt;<a href=3D"mailto:aesteve@red=
hat.com" target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;hw/virtio/virtio-dmabuf.h&quot;<br>
&gt; +<br>
&gt; +<br>
&gt; +static GMutex lock;<br>
&gt; +static GHashTable *resource_uuids;<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * uuid_equal_func: wrapper for UUID is_equal function to<br>
&gt; + * satisfy g_hash_table_new expected parameters signatures.<br>
&gt; + */<br>
&gt; +static int uuid_equal_func(const void *lhv, const void *rhv)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return qemu_uuid_is_equal(lhv, rhv);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *v=
alue)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool result;<br>
&gt; +=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
&gt; +=C2=A0 =C2=A0 if (resource_uuids =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_uuids =3D g_hash_table_new_full(=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_hash, uuid_equal_=
func, NULL, g_free);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (g_hash_table_lookup(resource_uuids, uuid) !=3D NULL=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 result =3D g_hash_table_insert(resource_uuids, uuid, va=
lue);<br>
&gt; +=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return result;<br>
&gt; +}<br>
<br>
Alternatively same logic, but simpler / safer:<br>
<br>
static bool virtio_add_resource(...)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0bool result =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_mutex_lock(&amp;lock);<br>
=C2=A0 =C2=A0 =C2=A0if (resource_uuids =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resource_uuids =3D g_hash_table_new_full(=
qemu_uuid_hash,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 uuid_equal_func,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 g_free);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NU=
LL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_hash_table_insert(resource_uuids, =
uuid, value);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0g_mutex_unlock(&amp;lock);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return result;<br>
}<br>
<br>
&gt; +static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
&gt; +=C2=A0 =C2=A0 if (resource_uuids =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 gpointer lookup_res =3D g_hash_table_lookup(resource_uu=
ids, uuid);<br>
&gt; +=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
&gt; +=C2=A0 =C2=A0 return (VirtioSharedObject*) lookup_res;<br>
&gt; +}<br>
<br>
Similarly:<br>
<br>
static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0gpointer lookup_res =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_mutex_lock(&amp;lock);<br>
=C2=A0 =C2=A0 =C2=A0if (resource_uuids !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lookup_res =3D g_hash_table_lookup(resour=
ce_uuids, uuid);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0g_mutex_unlock(&amp;lock);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return (VirtioSharedObject *)lookup_res;<br>
}<br>
<br>
&gt; +int main(int argc, char **argv)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_test_init(&amp;argc, &amp;argv, NULL);<br>
&gt; +=C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/add_rm_res&quot;, =
test_add_remove_resources);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/add_=
rm_dev&quot;, test_add_remove_dev);<br>
<br>
Mis-indent.<br>
<br>
&gt; +=C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/rm_invalid_res&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 test_remove_invalid_resource);<br>
&gt; +=C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/add_invalid_res&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 test_add_invalid_resource);<br>
&gt; +=C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/free_res&quot;, te=
st_free_resources);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return g_test_run();<br>
&gt; +}<br>
<br>
Thanks for updating, LGTM!<br>
<br></blockquote><div>Suggestions look good, and is true that will lead to =
more safe and maintanable code in the future,</div><div>if we add more bran=
ches where the mutex has to be handled.</div><div>I will send another revis=
ion then, thanks!</div></div></div>

--000000000000162c750604b27cfe--


