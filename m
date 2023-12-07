Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88232808423
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 10:19:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBAWk-0006NP-9J; Thu, 07 Dec 2023 04:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rBAWU-0006NF-NW
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 04:18:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rBAWS-0007rF-HN
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 04:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701940699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xlqmoi2Udl0/hvOySjv5Ba0b1cKwOvfivfdXrWSNMEs=;
 b=TeuAuXmZBI2qpadHvvj+fgYKl+6VXtJQBnKBIoQukV60oqtOGqxy8DBhtDTUUt69DPUOjS
 Q9grdwrgqmqt4WAGOgOxu3sygMfjKczpAEr7i0QMUv2tLqFOM4uWUV8cKXl/ulYuHEw2gp
 j9d+fOo5EfEkwcJPwgNwwNzcDs2FOeI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-Mxdt1vXBMOS4FPQX4tKuRQ-1; Thu, 07 Dec 2023 04:18:17 -0500
X-MC-Unique: Mxdt1vXBMOS4FPQX4tKuRQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2865681dcb4so722423a91.3
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 01:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701940696; x=1702545496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xlqmoi2Udl0/hvOySjv5Ba0b1cKwOvfivfdXrWSNMEs=;
 b=YYF8md5ybn2g5o2bSaPThjQJnKDx7N95IH6GXLNA/CBjwp8qj7u5NQy/JtlXq/8Tux
 eDx++vfZoKMCXNyUSXQzoavEIJzXK+vbLn+s2/Pn4VaeglUmY0gd4aHQJQykn6VT5T2P
 AmH/QstVYk7WVXf9MwgJZlTh6TBWIwwuf/WqZYJ29GgNGYb615NhozBQyqQru4IJolfe
 KATJMBsJWuLv5rMjyQH237BoIZ0M+jHcVupQOg79RdciazRTowZKU14Fu/UB0zdr27Yz
 3XzU96xuUP4sVogYcxnYCGcfAJgs4hb0NybYjVrliUq68+ngw6M8bpkglMRJIstBFQbn
 2YPg==
X-Gm-Message-State: AOJu0YxjMYXSvPCdGf3gRyqb5NVC4ZsbXxtEP3qfwi4u6kRI3Xpc+DMd
 AcdpIzw6mHmXD7093To7bM3cd+05DlbjQZ0sADOwwdWhGIYn1Wxqo02piJBaRowkL5ErxhxHZWA
 n7bFZRIYyZ5lcEkxfJSzQuDxzr8UvA+/Aq8iIWVc=
X-Received: by 2002:a17:90b:4b45:b0:286:bdb5:d07d with SMTP id
 mi5-20020a17090b4b4500b00286bdb5d07dmr1904059pjb.18.1701940696628; 
 Thu, 07 Dec 2023 01:18:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYecc4vu4++kn96KP9TKQxTur4K8U17MGgTKjxtaJqrqQe67/77VO+dI5iW+iPj4qxkMT0+WEq/TGPsEiJ42U=
X-Received: by 2002:a17:90b:4b45:b0:286:bdb5:d07d with SMTP id
 mi5-20020a17090b4b4500b00286bdb5d07dmr1904053pjb.18.1701940696382; Thu, 07
 Dec 2023 01:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20231107093744.388099-1-aesteve@redhat.com>
 <20231107093744.388099-3-aesteve@redhat.com>
 <CAJ+F1C+2WXmKFCYJxNuz0mWW92JM9RxfizgU5uFtpOPEagxPFA@mail.gmail.com>
In-Reply-To: <CAJ+F1C+2WXmKFCYJxNuz0mWW92JM9RxfizgU5uFtpOPEagxPFA@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 7 Dec 2023 10:18:05 +0100
Message-ID: <CADSE00+fpr71BvfGCMUjKTEu-qFV9kPDexwt977jZ83TiGfuyw@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/virtio: cleanup shared resources
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 kraxel@redhat.com, stefanha@gmail.com
Content-Type: multipart/alternative; boundary="000000000000a3130b060be7f2a7"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--000000000000a3130b060be7f2a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 9:00=E2=80=AFAM Marc-Andr=C3=A9 Lureau <marcandre.lu=
reau@gmail.com>
wrote:

> Hi
>
> On Tue, Nov 7, 2023 at 1:37=E2=80=AFPM Albert Esteve <aesteve@redhat.com>=
 wrote:
> >
> > Ensure that we cleanup all virtio shared
> > resources when the vhost devices is cleaned
> > up (after a hot unplug, or a crash).
> >
> > To track all owned uuids of a device, add
> > a GSList to the vhost_dev struct. This way
> > we can avoid traversing the full table
> > for every cleanup, whether they actually
> > own any shared resource or not.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  hw/virtio/vhost-user.c    | 2 ++
> >  hw/virtio/vhost.c         | 4 ++++
> >  include/hw/virtio/vhost.h | 6 ++++++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 5fdff0241f..04848d1fa0 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -1598,6 +1598,7 @@ vhost_user_backend_handle_shared_object_add(struc=
t
> vhost_dev *dev,
> >      QemuUUID uuid;
> >
> >      memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> > +    dev->shared_uuids =3D g_slist_append(dev->shared_uuids, &uuid);
>
> This will point to the stack variable.
>
> >      return virtio_add_vhost_device(&uuid, dev);
> >  }
> >
> > @@ -1623,6 +1624,7 @@
> vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
> >      }
> >
> >      memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> > +    dev->shared_uuids =3D g_slist_remove_all(dev->shared_uuids, &uuid)=
;
> >      return virtio_remove_resource(&uuid);
> >  }
> >
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 9c9ae7109e..3aff94664b 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -16,6 +16,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qapi/error.h"
> >  #include "hw/virtio/vhost.h"
> > +#include "hw/virtio/virtio-dmabuf.h"
> >  #include "qemu/atomic.h"
> >  #include "qemu/range.h"
> >  #include "qemu/error-report.h"
> > @@ -1599,6 +1600,9 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
> >      migrate_del_blocker(&hdev->migration_blocker);
> >      g_free(hdev->mem);
> >      g_free(hdev->mem_sections);
> > +    /* free virtio shared objects */
> > +    g_slist_foreach(hdev->shared_uuids, (GFunc)virtio_remove_resource,
> NULL);
> > +    g_slist_free_full(g_steal_pointer(&hdev->shared_uuids), g_free);
>
> (and will crash here)
>
> Imho, you should just traverse the hashtable, instead of introducing
> another list.
>

Ok, I was probably doing premature optimization. I guess it should
not happen as often, or track as many resources, as to require
a separate list. I will just traverse.

Thanks!


>
> >      if (hdev->vhost_ops) {
> >          hdev->vhost_ops->vhost_backend_cleanup(hdev);
> >      }
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 5e8183f64a..376bc8446d 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -118,6 +118,12 @@ struct vhost_dev {
> >       */
> >      uint64_t protocol_features;
> >
> > +    /**
> > +     * @shared_uuids: contains the UUIDs of all the exported
> > +     * virtio objects owned by the vhost device.
> > +     */
> > +    GSList *shared_uuids;
> > +
> >      uint64_t max_queues;
> >      uint64_t backend_cap;
> >      /* @started: is the vhost device started? */
> > --
> > 2.41.0
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>
>

--000000000000a3130b060be7f2a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 4, 2023 at 9:00=
=E2=80=AFAM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@g=
mail.com">marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Hi<br>
<br>
On Tue, Nov 7, 2023 at 1:37=E2=80=AFPM Albert Esteve &lt;<a href=3D"mailto:=
aesteve@redhat.com" target=3D"_blank">aesteve@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Ensure that we cleanup all virtio shared<br>
&gt; resources when the vhost devices is cleaned<br>
&gt; up (after a hot unplug, or a crash).<br>
&gt;<br>
&gt; To track all owned uuids of a device, add<br>
&gt; a GSList to the vhost_dev struct. This way<br>
&gt; we can avoid traversing the full table<br>
&gt; for every cleanup, whether they actually<br>
&gt; own any shared resource or not.<br>
&gt;<br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/vhost-user.c=C2=A0 =C2=A0 | 2 ++<br>
&gt;=C2=A0 hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++++<br>
&gt;=C2=A0 include/hw/virtio/vhost.h | 6 ++++++<br>
&gt;=C2=A0 3 files changed, 12 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
&gt; index 5fdff0241f..04848d1fa0 100644<br>
&gt; --- a/hw/virtio/vhost-user.c<br>
&gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; @@ -1598,6 +1598,7 @@ vhost_user_backend_handle_shared_object_add(stru=
ct vhost_dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuUUID uuid;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memcpy(uuid.data, object-&gt;uuid, sizeof(object-&=
gt;uuid));<br>
&gt; +=C2=A0 =C2=A0 dev-&gt;shared_uuids =3D g_slist_append(dev-&gt;shared_=
uuids, &amp;uuid);<br>
<br>
This will point to the stack variable.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return virtio_add_vhost_device(&amp;uuid, dev);<br=
>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; @@ -1623,6 +1624,7 @@ vhost_user_backend_handle_shared_object_remove(s=
truct vhost_dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memcpy(uuid.data, object-&gt;uuid, sizeof(object-&=
gt;uuid));<br>
&gt; +=C2=A0 =C2=A0 dev-&gt;shared_uuids =3D g_slist_remove_all(dev-&gt;sha=
red_uuids, &amp;uuid);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return virtio_remove_resource(&amp;uuid);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c<br>
&gt; index 9c9ae7109e..3aff94664b 100644<br>
&gt; --- a/hw/virtio/vhost.c<br>
&gt; +++ b/hw/virtio/vhost.c<br>
&gt; @@ -16,6 +16,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/virtio/vhost.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-dmabuf.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/atomic.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/range.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/error-report.h&quot;<br>
&gt; @@ -1599,6 +1600,9 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 migrate_del_blocker(&amp;hdev-&gt;migration_blocke=
r);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(hdev-&gt;mem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(hdev-&gt;mem_sections);<br>
&gt; +=C2=A0 =C2=A0 /* free virtio shared objects */<br>
&gt; +=C2=A0 =C2=A0 g_slist_foreach(hdev-&gt;shared_uuids, (GFunc)virtio_re=
move_resource, NULL);<br>
&gt; +=C2=A0 =C2=A0 g_slist_free_full(g_steal_pointer(&amp;hdev-&gt;shared_=
uuids), g_free);<br>
<br>
(and will crash here)<br>
<br>
Imho, you should just traverse the hashtable, instead of introducing<br>
another list.<br></blockquote><div><br></div><div>Ok, I was probably doing =
premature optimization. I guess it should</div><div>not happen as often, or=
 track as many resources, as to require</div><div>a separate list. I will j=
ust traverse.</div><div><br></div><div>Thanks!</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (hdev-&gt;vhost_ops) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdev-&gt;vhost_ops-&gt;vhost_backend=
_cleanup(hdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h<br>
&gt; index 5e8183f64a..376bc8446d 100644<br>
&gt; --- a/include/hw/virtio/vhost.h<br>
&gt; +++ b/include/hw/virtio/vhost.h<br>
&gt; @@ -118,6 +118,12 @@ struct vhost_dev {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t protocol_features;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 /**<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* @shared_uuids: contains the UUIDs of all the ex=
ported<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* virtio objects owned by the vhost device.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 GSList *shared_uuids;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t max_queues;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t backend_cap;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* @started: is the vhost device started? */<br>
&gt; --<br>
&gt; 2.41.0<br>
&gt;<br>
<br>
<br>
-- <br>
Marc-Andr=C3=A9 Lureau<br>
<br>
</blockquote></div></div>

--000000000000a3130b060be7f2a7--


