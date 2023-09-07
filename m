Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9703797202
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:53:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDXr-0000Dd-TR; Thu, 07 Sep 2023 07:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qeDXp-0000Cf-Jl
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qeDXm-0006iQ-QP
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694087489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f2xxkmSvyCPTQdfAvkkhwJIqh9Twjhm6hdIFi6cNaFI=;
 b=EtirAOigPaqAPe3RdhXiOrgwdoXi5dJNmC9fN+6CEL2CbTIhpf0Zr0y1mkhqRK7qvb+HOk
 7tNnC6xgChRiYCe/FdoA+jQh3TWmoPrNltyWVddaWHTGKc+Mh7gPrmKA0Kp0+geBoR4be/
 gEHWlgilij9C3hzy+t+0WkpPcZyPKTA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-XpdHXdmKM5qONEZb4AFXAQ-1; Thu, 07 Sep 2023 07:51:28 -0400
X-MC-Unique: XpdHXdmKM5qONEZb4AFXAQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-68beedc7d7eso1083320b3a.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 04:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694087487; x=1694692287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f2xxkmSvyCPTQdfAvkkhwJIqh9Twjhm6hdIFi6cNaFI=;
 b=RbMAO2dRr0yw3mv7YZn9a/O10ED+yTGom93QN94ICclMJ5pCqgXONJ+VGU0hMmbV9I
 7yYVUncwXf8Y6vmtMbAlqF6435mLbP2v4quUwKPbCrwe1gP1gD9W8F28e4BFCe1G1MIj
 QbJOQ16Ov9DHPrmxqXFN9D1883LYO0ZaW2yaUQbF0vO68MN/uH/E3C8PCnhdGLjmSakY
 Em/C989XrQlGncpxjVDED8JIz9bEcZdwR1LH1HHV3AdFBcKhwUpIyr8O7v30IcL2ppD2
 t+U0KwGDd6giDGyjLqRycpet+wi3cGxYoDg5xLlUbZmrQE+XUYBsWVvXuaFLJNZT411C
 XuhA==
X-Gm-Message-State: AOJu0YwYQiyJmpHZ+nSrSPvS65LBpVtlRqXDTT3U8+T+Tnupqox/Sth5
 hKYTA4WZXZL7wrLlJTT4xQzAzYy6CMZzXeAUGT4NdUOKc8JwGXtr/Q9bDT8vgclzqisNnCU/IOE
 Di4D48IQgdU7Kyy3jPq8FzZnlNB5JQ3o=
X-Received: by 2002:a05:6a00:1786:b0:68a:3e68:f8ab with SMTP id
 s6-20020a056a00178600b0068a3e68f8abmr19238094pfg.14.1694087487136; 
 Thu, 07 Sep 2023 04:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgcyiOAaa5FA78MqluT8WtZaH7AVNtDeySfIAFBKfngpgYfaXxHeLaM5fRlEoSsp6ED6PGVi9lN3Y1i+Q3iaY=
X-Received: by 2002:a05:6a00:1786:b0:68a:3e68:f8ab with SMTP id
 s6-20020a056a00178600b0068a3e68f8abmr19238072pfg.14.1694087486711; Thu, 07
 Sep 2023 04:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230907074318.528064-1-aesteve@redhat.com>
 <20230907074318.528064-3-aesteve@redhat.com>
 <200d8e04-ffec-5aee-0a2b-84b947a57086@linaro.org>
In-Reply-To: <200d8e04-ffec-5aee-0a2b-84b947a57086@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 7 Sep 2023 13:51:15 +0200
Message-ID: <CADSE00JfmfC5XhPBb6o04TLCvuRfi7TE5O9KV4hW+Z29fm1hCg@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] virtio-dmabuf: introduce virtio-dmabuf
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, cohuck@redhat.com, 
 kraxel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Fam Zheng <fam@euphon.net>
Content-Type: multipart/alternative; boundary="000000000000dd43c10604c37ad6"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--000000000000dd43c10604c37ad6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 7, 2023 at 10:19=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 7/9/23 09:43, Albert Esteve wrote:
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
>
>
> > diff --git a/include/hw/virtio/virtio-dmabuf.h
> b/include/hw/virtio/virtio-dmabuf.h
> > new file mode 100644
> > index 0000000000..202eec5868
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
>
> See https://www.qemu.org/docs/master/devel/style.html#include-directives
>
>    Do not include =E2=80=9Cqemu/osdep.h=E2=80=9D from header files since =
the .c
>    file will have already included it.
>
> > +#include <glib.h>
>
> This one is also included via "qemu/osdep.h" -> "glib-compat.h"
>
> > +#include "qemu/uuid.h"
> > +#include "vhost.h"
> > +
> > +typedef enum SharedObjectType {
> > +    TYPE_INVALID =3D 0,
> > +    TYPE_DMABUF,
> > +    TYPE_VHOST_DEV,
> > +} SharedObjectType;
> > +
> > +typedef struct VirtioSharedObject {
> > +    SharedObjectType type;
> > +    gpointer value;
> > +} VirtioSharedObject;
>
> Since this need a repost, better use "hw/display: Introduce
> virtio-dmabuf" as patch subject (and "util/uuid" prefix for the previous
> patch).
>
> Otherwise LGTM, so with these changes:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>
Thanks a lot! I'll do it for the next review.
Any other comment on the other commits?

--000000000000dd43c10604c37ad6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 7, 2023 at 10:19=
=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro=
.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On 7/9/23 09:43, Albert Esteve wrote:<br>
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
<br>
<br>
&gt; diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/vir=
tio-dmabuf.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..202eec5868<br>
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
<br>
See <a href=3D"https://www.qemu.org/docs/master/devel/style.html#include-di=
rectives" rel=3D"noreferrer" target=3D"_blank">https://www.qemu.org/docs/ma=
ster/devel/style.html#include-directives</a><br>
<br>
=C2=A0 =C2=A0Do not include =E2=80=9Cqemu/osdep.h=E2=80=9D from header file=
s since the .c<br>
=C2=A0 =C2=A0file will have already included it.<br>
<br>
&gt; +#include &lt;glib.h&gt;<br>
<br>
This one is also included via &quot;qemu/osdep.h&quot; -&gt; &quot;glib-com=
pat.h&quot;<br>
<br>
&gt; +#include &quot;qemu/uuid.h&quot;<br>
&gt; +#include &quot;vhost.h&quot;<br>
&gt; +<br>
&gt; +typedef enum SharedObjectType {<br>
&gt; +=C2=A0 =C2=A0 TYPE_INVALID =3D 0,<br>
&gt; +=C2=A0 =C2=A0 TYPE_DMABUF,<br>
&gt; +=C2=A0 =C2=A0 TYPE_VHOST_DEV,<br>
&gt; +} SharedObjectType;<br>
&gt; +<br>
&gt; +typedef struct VirtioSharedObject {<br>
&gt; +=C2=A0 =C2=A0 SharedObjectType type;<br>
&gt; +=C2=A0 =C2=A0 gpointer value;<br>
&gt; +} VirtioSharedObject;<br>
<br>
Since this need a repost, better use &quot;hw/display: Introduce <br>
virtio-dmabuf&quot; as patch subject (and &quot;util/uuid&quot; prefix for =
the previous <br>
patch).<br>
<br>
Otherwise LGTM, so with these changes:<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br></blockquote><div><br></div><div>Thanks a lot! I&#39;ll do it for the n=
ext review.</div><div>Any other comment on the other commits?</div></div></=
div>

--000000000000dd43c10604c37ad6--


