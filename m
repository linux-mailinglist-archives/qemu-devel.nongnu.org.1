Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1D0793686
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 09:44:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdnBZ-0005xY-77; Wed, 06 Sep 2023 03:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdnBW-0005x2-9C
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 03:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdnBS-0004pX-Ng
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 03:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693986161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ImRzxhsTOwyWbSjOwu2IdQnURQvv3rHMe4eORJwyH2I=;
 b=By1pC+kXZTHD18ighSLQyVNf9V1vabvX9o/rxkxKTQBFvZ/1ky8fFLfsnxZtkOjjBperWR
 oVeh0Y/0ILoAEGmu2X7+erU2yxys8XYL8xUgO3qN29lpCaGvtmr4SjH44S10NwgHPJ7d5G
 m2mQ8tR1qKn3ifICpSrE1oN7xow3kC8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-8p9Xc0G0Mviz0rxcwXPqHw-1; Wed, 06 Sep 2023 03:42:39 -0400
X-MC-Unique: 8p9Xc0G0Mviz0rxcwXPqHw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-26f97567cb8so822976a91.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 00:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693986158; x=1694590958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ImRzxhsTOwyWbSjOwu2IdQnURQvv3rHMe4eORJwyH2I=;
 b=RZfqWWzSYT/gRPRN8fdcpQPREliloW5I6zeWwYfokJ9bA49E3Y0dOMBL4kUa+LbrY6
 NEY2d13ZUVKJ9JLZbso9whqYNV9E6WZK5XPDwTqPdEDQANAzqNp67bYQCfn5YuHKZz6X
 2V7yvyeGzdZ4TZc0w5iguu1uIW7OEyDGy2FqKMjTHFR8zdJfAlIRfdI9ZguVlYjv2SjU
 Z4/+f4mh7ZAVM+FZfn0l4AHFpxpBB/jN5GJL3ObnHIcIVhNzS6vevnF/DDe7404Rbqvz
 A45NaHcdn5/cQXTQGHOt92Z6z0Q0bNyYIJ31T2VRHDrq2E3/iG+A4nuUEMOovu8ufWNQ
 BovQ==
X-Gm-Message-State: AOJu0YzZM9t6Jpy7965+ABSeWeawQPpKNPKj4vYNczCDxfNAn5QyXQGu
 Yu7riCgkZkpqCeNbwSTmPQrSM9GNsLxcDPMboiEu/d333BrSStsPrO/hgb7A68sueOEGF7ICNCb
 bIQDvisTqvVIUj7gBgdQZMQmha190mbI=
X-Received: by 2002:a17:90a:b947:b0:26b:455b:8d61 with SMTP id
 f7-20020a17090ab94700b0026b455b8d61mr19627210pjw.22.1693986158044; 
 Wed, 06 Sep 2023 00:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBSFKYZjr7ZnZGenc6vqMl0PAeD78SQm+7gO4KOx6owWqRVArHQl15AzHGmKz6Z6S1WLpH05mVqGbNXZ7RyW0=
X-Received: by 2002:a17:90a:b947:b0:26b:455b:8d61 with SMTP id
 f7-20020a17090ab94700b0026b455b8d61mr19627199pjw.22.1693986157743; Wed, 06
 Sep 2023 00:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230802090824.91688-1-aesteve@redhat.com>
 <20230802090824.91688-3-aesteve@redhat.com>
 <e6b6abb1-921b-43d7-054a-71042b0f4e38@linaro.org>
In-Reply-To: <e6b6abb1-921b-43d7-054a-71042b0f4e38@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 6 Sep 2023 09:42:26 +0200
Message-ID: <CADSE00KS0KTXTdq+AdAd57qwz-ZNQRxSqhizhs+qaJ8MpGRChA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] virtio-dmabuf: introduce virtio-dmabuf
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, kraxel@redhat.com, 
 cohuck@redhat.com, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002fe8440604abe35e"
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

--0000000000002fe8440604abe35e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 6, 2023 at 7:56=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> Hi Albert,
>
> On 2/8/23 11:08, Albert Esteve wrote:
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
> >   hw/display/virtio-dmabuf.c        | 136 +++++++++++++++++++++++++++++
> >   include/hw/virtio/virtio-dmabuf.h | 103 ++++++++++++++++++++++
> >   tests/unit/meson.build            |   1 +
> >   tests/unit/test-virtio-dmabuf.c   | 137 +++++++++++++++++++++++++++++=
+
> >   6 files changed, 385 insertions(+)
> >   create mode 100644 hw/display/virtio-dmabuf.c
> >   create mode 100644 include/hw/virtio/virtio-dmabuf.h
> >   create mode 100644 tests/unit/test-virtio-dmabuf.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 12e59b6b27..cd8487785a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2158,6 +2158,13 @@ T: git https://gitlab.com/cohuck/qemu.git
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
> > index 0000000000..e852c71ba9
> > --- /dev/null
> > +++ b/hw/display/virtio-dmabuf.c
> > @@ -0,0 +1,136 @@
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
> > +static bool virtio_add_resource(QemuUUID *uuid, struct
> VirtioSharedObject *value)
>
> Per QEMU coding style we use typedefs, so "VirtioSharedObject" here.
>
> > +{
> > +    if (resource_uuids =3D=3D NULL) {
> > +        resource_uuids =3D g_hash_table_new_full(
> > +            qemu_uuid_hash, uuid_equal_func, NULL, g_free);
> > +    }
> > +    if (g_hash_table_lookup(resource_uuids, uuid) !=3D NULL) {
> > +        return false;
> > +    }
> > +
> > +    return g_hash_table_insert(resource_uuids, uuid, value);
>
> Hmm shouldn't this function take the lock to access resource_uuids?
>
> > +}
> > +
> > +static gpointer virtio_lookup_resource(const QemuUUID *uuid)
> > +{
> > +    if (resource_uuids =3D=3D NULL) {
> > +        return NULL;
> > +    }
> > +
> > +    return g_hash_table_lookup(resource_uuids, uuid);
>
> Ditto.
>
> Here you can directly return the casted type (VirtioSharedObject *),
> since a plain gpointer isn't really used / useful.
>
> > +}
> > +
> > +bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
> > +{
> > +    bool result;
> > +    struct VirtioSharedObject *vso;
> > +    if (udmabuf_fd < 0) {
> > +        return false;
> > +    }
> > +    vso =3D g_new0(struct VirtioSharedObject, 1);
>
> s/g_new0/g_new/
>
> > +    g_mutex_lock(&lock);
> > +    vso->type =3D TYPE_DMABUF;
> > +    vso->value =3D GINT_TO_POINTER(udmabuf_fd);
> > +    result =3D virtio_add_resource(uuid, vso);
> > +    g_mutex_unlock(&lock);
> > +
> > +    return result;
> > +}
> > +
> > +bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
> > +{
> > +    bool result;
> > +    struct VirtioSharedObject *vso;
> > +    if (dev =3D=3D NULL) {
> > +        return false;
> > +    }
> > +    vso =3D g_new0(struct VirtioSharedObject, 1);
> > +    g_mutex_lock(&lock);
> > +    vso->type =3D TYPE_VHOST_DEV;
> > +    vso->value =3D dev;
> > +    result =3D virtio_add_resource(uuid, vso);
>
> Ah, you lock here... I'd rather do it in the callee.
>
> > +    g_mutex_unlock(&lock);
> > +
> > +    return result;
> > +}
> > +
> > +bool virtio_remove_resource(const QemuUUID *uuid)
> > +{
> > +    bool result;
> > +    g_mutex_lock(&lock);
> > +    result =3D g_hash_table_remove(resource_uuids, uuid);
> > +    g_mutex_unlock(&lock);
>
> virtio_remove_resource() correctly locks. For API parity,
> virtio_add_resource() should too.
>
> > +
> > +    return result;
> > +}
> > +
> > +static struct VirtioSharedObject *get_shared_object(const QemuUUID
> *uuid)
> > +{
> > +    g_mutex_lock(&lock);
> > +    gpointer lookup_res =3D virtio_lookup_resource(uuid);
> > +    g_mutex_unlock(&lock);
> > +    return (struct VirtioSharedObject*) lookup_res;
>
> See earlier, this function can be merged with virtio_lookup_resource().
>
> > +}
> > +
> > +int virtio_lookup_dmabuf(const QemuUUID *uuid)
> > +{
> > +    struct VirtioSharedObject *vso =3D get_shared_object(uuid);
> > +    if (vso =3D=3D NULL) {
> > +        return -1;
> > +    }
> > +    assert(vso->type =3D=3D TYPE_DMABUF);
> > +    return GPOINTER_TO_INT(vso->value);
> > +}
> > +
> > +struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)
> > +{
> > +    struct VirtioSharedObject *vso =3D get_shared_object(uuid);
> > +    if (vso =3D=3D NULL) {
> > +        return NULL;
> > +    }
> > +    assert(vso->type =3D=3D TYPE_VHOST_DEV);
> > +    return (struct vhost_dev *) vso->value;
> > +}
> > +
> > +enum SharedObjectType virtio_object_type(const QemuUUID *uuid)
> > +{
> > +    struct VirtioSharedObject *vso =3D get_shared_object(uuid);
> > +    if (vso =3D=3D NULL) {
> > +        return TYPE_INVALID;
> > +    }
> > +    return vso->type;
> > +}
> > +
> > +void virtio_free_resources(void)
> > +{
> > +    g_hash_table_destroy(resource_uuids);
>
> Lock?
>
> > +    /* Reference count shall be 0 after the implicit unref on destroy =
*/
> > +    resource_uuids =3D NULL;
> > +}
> > diff --git a/include/hw/virtio/virtio-dmabuf.h
> b/include/hw/virtio/virtio-dmabuf.h
> > new file mode 100644
> > index 0000000000..536e622555
> > --- /dev/null
> > +++ b/include/hw/virtio/virtio-dmabuf.h
> > @@ -0,0 +1,103 @@
> > +/*
> > + * Virtio Shared dma-buf
> > + *
> > + * Copyright Red Hat, Inc. 2023
> > + *
> > + * Authors:
> > + *     Albert Esteve <aesteve@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef VIRTIO_DMABUF_H
> > +#define VIRTIO_DMABUF_H
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include <glib.h>
> > +#include "qemu/uuid.h"
> > +#include "vhost.h"
> > +
> > +enum SharedObjectType {
> > +    TYPE_INVALID =3D 0,
> > +    TYPE_DMABUF,
> > +    TYPE_VHOST_DEV,
> > +};
> > +
>
> Please declare a
>
> typedef
>
> > +struct VirtioSharedObject {
> > +    enum SharedObjectType type;
> > +    gpointer value;
> > +};
>
> VirtioSharedObject;
>
> and use it instead of 'struct VirtioSharedObject'.
>
>
You mean making the struct anonymous and typedefing?
Should I do the same with the enum? In other files I see enums are typedef
too, but not anonymous (e.g., block/qcow2.h).
So I could do the same here.

For the rest... Ack!


> Regards,
>
> Phil.
>
>

--0000000000002fe8440604abe35e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 6, 2023 at 7:56=E2=80=AFA=
M Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phil=
md@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Hi Albert,<br>
<br>
On 2/8/23 11:08, Albert Esteve wrote:<br>
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
6 +++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-dmabuf.h | 103 ++++++++++++++++++=
++++<br>
&gt;=C2=A0 =C2=A0tests/unit/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0tests/unit/test-virtio-dmabuf.c=C2=A0 =C2=A0| 137 ++++++++=
++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A06 files changed, 385 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/virtio-dmabuf.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/virtio/virtio-dmabuf.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 tests/unit/test-virtio-dmabuf.c<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 12e59b6b27..cd8487785a 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -2158,6 +2158,13 @@ T: git <a href=3D"https://gitlab.com/cohuck/qem=
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
&gt; index 0000000000..e852c71ba9<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/display/virtio-dmabuf.c<br>
&gt; @@ -0,0 +1,136 @@<br>
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
&gt; +static bool virtio_add_resource(QemuUUID *uuid, struct VirtioSharedOb=
ject *value)<br>
<br>
Per QEMU coding style we use typedefs, so &quot;VirtioSharedObject&quot; he=
re.<br>
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (resource_uuids =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_uuids =3D g_hash_table_new_full(=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_hash, uuid_equal_=
func, NULL, g_free);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (g_hash_table_lookup(resource_uuids, uuid) !=3D NULL=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return g_hash_table_insert(resource_uuids, uuid, value)=
;<br>
<br>
Hmm shouldn&#39;t this function take the lock to access resource_uuids?<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static gpointer virtio_lookup_resource(const QemuUUID *uuid)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (resource_uuids =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return g_hash_table_lookup(resource_uuids, uuid);<br>
<br>
Ditto.<br>
<br>
Here you can directly return the casted type (VirtioSharedObject *),<br>
since a plain gpointer isn&#39;t really used / useful.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool result;<br>
&gt; +=C2=A0 =C2=A0 struct VirtioSharedObject *vso;<br>
&gt; +=C2=A0 =C2=A0 if (udmabuf_fd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 vso =3D g_new0(struct VirtioSharedObject, 1);<br>
<br>
s/g_new0/g_new/<br>
<br>
&gt; +=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
&gt; +=C2=A0 =C2=A0 vso-&gt;type =3D TYPE_DMABUF;<br>
&gt; +=C2=A0 =C2=A0 vso-&gt;value =3D GINT_TO_POINTER(udmabuf_fd);<br>
&gt; +=C2=A0 =C2=A0 result =3D virtio_add_resource(uuid, vso);<br>
&gt; +=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return result;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool result;<br>
&gt; +=C2=A0 =C2=A0 struct VirtioSharedObject *vso;<br>
&gt; +=C2=A0 =C2=A0 if (dev =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 vso =3D g_new0(struct VirtioSharedObject, 1);<br>
&gt; +=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
&gt; +=C2=A0 =C2=A0 vso-&gt;type =3D TYPE_VHOST_DEV;<br>
&gt; +=C2=A0 =C2=A0 vso-&gt;value =3D dev;<br>
&gt; +=C2=A0 =C2=A0 result =3D virtio_add_resource(uuid, vso);<br>
<br>
Ah, you lock here... I&#39;d rather do it in the callee.<br>
<br>
&gt; +=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return result;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool virtio_remove_resource(const QemuUUID *uuid)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool result;<br>
&gt; +=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
&gt; +=C2=A0 =C2=A0 result =3D g_hash_table_remove(resource_uuids, uuid);<b=
r>
&gt; +=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
<br>
virtio_remove_resource() correctly locks. For API parity,<br>
virtio_add_resource() should too.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return result;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct VirtioSharedObject *get_shared_object(const QemuUUID *u=
uid)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
&gt; +=C2=A0 =C2=A0 gpointer lookup_res =3D virtio_lookup_resource(uuid);<b=
r>
&gt; +=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
&gt; +=C2=A0 =C2=A0 return (struct VirtioSharedObject*) lookup_res;<br>
<br>
See earlier, this function can be merged with virtio_lookup_resource().<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +int virtio_lookup_dmabuf(const QemuUUID *uuid)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct VirtioSharedObject *vso =3D get_shared_object(uu=
id);<br>
&gt; +=C2=A0 =C2=A0 if (vso =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 assert(vso-&gt;type =3D=3D TYPE_DMABUF);<br>
&gt; +=C2=A0 =C2=A0 return GPOINTER_TO_INT(vso-&gt;value);<br>
&gt; +}<br>
&gt; +<br>
&gt; +struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct VirtioSharedObject *vso =3D get_shared_object(uu=
id);<br>
&gt; +=C2=A0 =C2=A0 if (vso =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 assert(vso-&gt;type =3D=3D TYPE_VHOST_DEV);<br>
&gt; +=C2=A0 =C2=A0 return (struct vhost_dev *) vso-&gt;value;<br>
&gt; +}<br>
&gt; +<br>
&gt; +enum SharedObjectType virtio_object_type(const QemuUUID *uuid)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct VirtioSharedObject *vso =3D get_shared_object(uu=
id);<br>
&gt; +=C2=A0 =C2=A0 if (vso =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TYPE_INVALID;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return vso-&gt;type;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void virtio_free_resources(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_hash_table_destroy(resource_uuids);<br>
<br>
Lock?<br>
<br>
&gt; +=C2=A0 =C2=A0 /* Reference count shall be 0 after the implicit unref =
on destroy */<br>
&gt; +=C2=A0 =C2=A0 resource_uuids =3D NULL;<br>
&gt; +}<br>
&gt; diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/vir=
tio-dmabuf.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..536e622555<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/virtio/virtio-dmabuf.h<br>
&gt; @@ -0,0 +1,103 @@<br>
&gt; +/*<br>
&gt; + * Virtio Shared dma-buf<br>
&gt; + *<br>
&gt; + * Copyright Red Hat, Inc. 2023<br>
&gt; + *<br>
&gt; + * Authors:<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0Albert Esteve &lt;<a href=3D"mailto:aesteve@red=
hat.com" target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2.<b=
r>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef VIRTIO_DMABUF_H<br>
&gt; +#define VIRTIO_DMABUF_H<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +<br>
&gt; +#include &lt;glib.h&gt;<br>
&gt; +#include &quot;qemu/uuid.h&quot;<br>
&gt; +#include &quot;vhost.h&quot;<br>
&gt; +<br>
&gt; +enum SharedObjectType {<br>
&gt; +=C2=A0 =C2=A0 TYPE_INVALID =3D 0,<br>
&gt; +=C2=A0 =C2=A0 TYPE_DMABUF,<br>
&gt; +=C2=A0 =C2=A0 TYPE_VHOST_DEV,<br>
&gt; +};<br>
&gt; +<br>
<br>
Please declare a<br>
<br>
typedef<br>
<br>
&gt; +struct VirtioSharedObject {<br>
&gt; +=C2=A0 =C2=A0 enum SharedObjectType type;<br>
&gt; +=C2=A0 =C2=A0 gpointer value;<br>
&gt; +};<br>
<br>
VirtioSharedObject;<br>
<br>
and use it instead of &#39;struct VirtioSharedObject&#39;.<br>
<br></blockquote><div><br></div><div>You mean making the struct anonymous a=
nd typedefing?</div><div>Should I do the same with the enum? In other files=
 I see enums are typedef too, but not anonymous (e.g., block/qcow2.h).</div=
><div>So I could do the same here.</div><div><br></div><div>For the rest...=
 Ack!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
Regards,<br>
<br>
Phil.<br>
<br>
</blockquote></div></div>

--0000000000002fe8440604abe35e--


