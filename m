Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C719788F31
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 21:10:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZcBP-0003Wt-2x; Fri, 25 Aug 2023 15:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZcBM-0003Wj-TL
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 15:09:20 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZcBK-0005eO-8I
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 15:09:20 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52a3ff5f0abso1854920a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692990556; x=1693595356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=riDa2zY+qpBu5viNHXSSocLlNuJ5IGeKJtACSjIro4A=;
 b=oHPri8fA8j8fO/ffgcqktM7buUhQk0+pDG8Jo0ma1WuTpCuWoJamKHYWs7r/0U5fO2
 vjTVtmkqhEcDZC02klQDllwG0mwTKpl0vbKc0aILwj5Rsi1f4wD4fcFzfuBlQfwini/l
 j2pgBd5+A+x52tMWa5wWete5FubCdhKb82Pr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692990556; x=1693595356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=riDa2zY+qpBu5viNHXSSocLlNuJ5IGeKJtACSjIro4A=;
 b=hxMWBPttbbGZm3VqOP2GvgDFEI5kJakR06EwR1hrQYhrhWD7B8k5SZNGtso3UszwO/
 cQkTZLLQVAH+oKv7Vgn18bH5698hNa5R6pBJh80f2V6DVJRpPvPXhh+Ui7KMVtXgpQbm
 cquSy4svbAbNIU0c7FqhIzvR/oMc9BHubfTOjjTaXf132fCxL/aC6BWzuDHx21nUMX5k
 70URZyI/c3sQnL27G6b0gmYIiYMhA9tTDQt2fuWRAAKAKAHkv5Z5wGOH17CAOxHLpfnj
 Q1v2GIeNV1sKQGgmmBZLC3eLtFFJE/CR9Mv7LIntIafvW9X5Jm3wiiCZNKA1qq+Wy2/V
 7yTA==
X-Gm-Message-State: AOJu0YwvIbWUzJJXFfCIzOpCBnl4Ol88jA6sWY+XaPPmCx/KnVOEGzO6
 i8oQZkoyKIjiZ+Y4TmhvQv25yxqElKdE8t8nnEH51Q==
X-Google-Smtp-Source: AGHT+IF1ogvbVSyXe4GwyEHcgQGyJss60Qh1vKkDWBEst2EFZBj79EgQq81WVei884bfkbjaANaHHA==
X-Received: by 2002:aa7:d952:0:b0:523:ae0a:a447 with SMTP id
 l18-20020aa7d952000000b00523ae0aa447mr15912490eds.13.1692990556443; 
 Fri, 25 Aug 2023 12:09:16 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 y12-20020aa7cccc000000b0052a3c7c9e8bsm1277599edt.56.2023.08.25.12.09.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 12:09:15 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-529fa243739so2467a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 12:09:15 -0700 (PDT)
X-Received: by 2002:a50:c051:0:b0:506:b280:4993 with SMTP id
 u17-20020a50c051000000b00506b2804993mr53475edd.2.1692990554908; Fri, 25 Aug
 2023 12:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230824234046.499-1-gurchetansingh@chromium.org>
 <20230824234046.499-9-gurchetansingh@chromium.org>
 <f051c45d-5498-c34c-1a41-286af4dd4656@quicinc.com>
In-Reply-To: <f051c45d-5498-c34c-1a41-286af4dd4656@quicinc.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Fri, 25 Aug 2023 12:09:02 -0700
X-Gmail-Original-Message-ID: <CAAfnVBkJsXe1X08pny9Z_tYuGVwTKi+oVwf=gtKQ9CMsopy_6Q@mail.gmail.com>
Message-ID: <CAAfnVBkJsXe1X08pny9Z_tYuGVwTKi+oVwf=gtKQ9CMsopy_6Q@mail.gmail.com>
Subject: Re: [PATCH v12 8/9] gfxstream + rutabaga: enable rutabaga
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com, hi@alyssa.is, ernunes@redhat.com, 
 manos.pitsidianakis@linaro.org, philmd@linaro.org, 
 mark.cave-ayland@ilande.co.uk
Content-Type: multipart/alternative; boundary="000000000000a2d0e80603c4149c"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000a2d0e80603c4149c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 6:55=E2=80=AFAM Antonio Caggiano <quic_acaggian@qui=
cinc.com>
wrote:

> Hi Gurchetan,
>
> Thank you for this series and for including some of my patches :)
>
> On 25/08/2023 01:40, Gurchetan Singh wrote:
> > This change enables rutabaga to receive virtio-gpu-3d hypercalls
> > when it is active.
> >
> > Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> > Tested-by: Alyssa Ross <hi@alyssa.is>
> > Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> > Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> > v3: Whitespace fix (Akihiko)
> > v9: reorder virtio_gpu_have_udmabuf() after checking if rutabaga
> >      is enabled to avoid spurious warnings (Akihiko)
> >
> >   hw/display/virtio-gpu-base.c | 3 ++-
> >   hw/display/virtio-gpu.c      | 5 +++--
> >   softmmu/qdev-monitor.c       | 3 +++
> >   softmmu/vl.c                 | 1 +
> >   4 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.=
c
> > index 4f2b0ba1f3..50c5373b65 100644
> > --- a/hw/display/virtio-gpu-base.c
> > +++ b/hw/display/virtio-gpu-base.c
> > @@ -223,7 +223,8 @@ virtio_gpu_base_get_features(VirtIODevice *vdev,
> uint64_t features,
> >   {
> >       VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(vdev);
> >
> > -    if (virtio_gpu_virgl_enabled(g->conf)) {
> > +    if (virtio_gpu_virgl_enabled(g->conf) ||
> > +        virtio_gpu_rutabaga_enabled(g->conf)) {
> >           features |=3D (1 << VIRTIO_GPU_F_VIRGL);
> >       }
> >       if (virtio_gpu_edid_enabled(g->conf)) {
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 3e658f1fef..fe094addef 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1361,8 +1361,9 @@ void virtio_gpu_device_realize(DeviceState *qdev,
> Error **errp)
> >       VirtIOGPU *g =3D VIRTIO_GPU(qdev);
> >
> >       if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
> > -        if (!virtio_gpu_have_udmabuf()) {
> > -            error_setg(errp, "cannot enable blob resources without
> udmabuf");
> > +        if (!virtio_gpu_rutabaga_enabled(g->parent_obj.conf) &&
> > +            !virtio_gpu_have_udmabuf()) {
> > +            error_setg(errp, "need rutabaga or udmabuf for blob
> resources");
>
> Does that mean udmabuf is not required at all when using rutabaga?
> How does rutabaga handle blob resources?
>

It's not required, since it's a Linux-only thing.  Some use cases do prefer
to use guest memory and we do have provisional support for that (see
`handle` field of `rutabaga_resource_create_blob`).  Though more testing is
required on the target platform, and likely virtio-gpu spec changes for a
full-functional solution.



>
> >               return;
> >           }
> >
> > diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> > index 74f4e41338..1b8005ae55 100644
> > --- a/softmmu/qdev-monitor.c
> > +++ b/softmmu/qdev-monitor.c
> > @@ -86,6 +86,9 @@ static const QDevAlias qdev_alias_table[] =3D {
> >       { "virtio-gpu-pci", "virtio-gpu", QEMU_ARCH_VIRTIO_PCI },
> >       { "virtio-gpu-gl-device", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_MMIO =
},
> >       { "virtio-gpu-gl-pci", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_PCI },
> > +    { "virtio-gpu-rutabaga-device", "virtio-gpu-rutabaga",
> > +      QEMU_ARCH_VIRTIO_MMIO },
> > +    { "virtio-gpu-rutabaga-pci", "virtio-gpu-rutabaga",
> QEMU_ARCH_VIRTIO_PCI },
> >       { "virtio-input-host-device", "virtio-input-host",
> QEMU_ARCH_VIRTIO_MMIO },
> >       { "virtio-input-host-ccw", "virtio-input-host",
> QEMU_ARCH_VIRTIO_CCW },
> >       { "virtio-input-host-pci", "virtio-input-host",
> QEMU_ARCH_VIRTIO_PCI },
> > diff --git a/softmmu/vl.c b/softmmu/vl.c
> > index b0b96f67fa..2f98eefdf3 100644
> > --- a/softmmu/vl.c
> > +++ b/softmmu/vl.c
> > @@ -216,6 +216,7 @@ static struct {
> >       { .driver =3D "ati-vga",              .flag =3D &default_vga     =
  },
> >       { .driver =3D "vhost-user-vga",       .flag =3D &default_vga     =
  },
> >       { .driver =3D "virtio-vga-gl",        .flag =3D &default_vga     =
  },
> > +    { .driver =3D "virtio-vga-rutabaga",  .flag =3D &default_vga      =
 },
> >   };
> >
> >   static QemuOptsList qemu_rtc_opts =3D {
>
> Patches 5 to 9:
> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
>
> Cheers,
> Antonio
>

--000000000000a2d0e80603c4149c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 25, 2023 at 6:55=E2=80=AF=
AM Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc.com">quic_a=
caggian@quicinc.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Hi Gurchetan,<br>
<br>
Thank you for this series and for including some of my patches :)<br>
<br>
On 25/08/2023 01:40, Gurchetan Singh wrote:<br>
&gt; This change enables rutabaga to receive virtio-gpu-3d hypercalls<br>
&gt; when it is active.<br>
&gt; <br>
&gt; Signed-off-by: Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@ch=
romium.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;<br>
&gt; Tested-by: Alyssa Ross &lt;<a href=3D"mailto:hi@alyssa.is" target=3D"_=
blank">hi@alyssa.is</a>&gt;<br>
&gt; Tested-by: Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidi=
anakis@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;=
<br>
&gt; Reviewed-by: Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsi=
dianakis@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&g=
t;<br>
&gt; ---<br>
&gt; v3: Whitespace fix (Akihiko)<br>
&gt; v9: reorder virtio_gpu_have_udmabuf() after checking if rutabaga<br>
&gt;=C2=A0 =C2=A0 =C2=A0 is enabled to avoid spurious warnings (Akihiko)<br=
>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/display/virtio-gpu-base.c | 3 ++-<br>
&gt;=C2=A0 =C2=A0hw/display/virtio-gpu.c=C2=A0 =C2=A0 =C2=A0 | 5 +++--<br>
&gt;=C2=A0 =C2=A0softmmu/qdev-monitor.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 3 +++<b=
r>
&gt;=C2=A0 =C2=A0softmmu/vl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 1 +<br>
&gt;=C2=A0 =C2=A04 files changed, 9 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base=
.c<br>
&gt; index 4f2b0ba1f3..50c5373b65 100644<br>
&gt; --- a/hw/display/virtio-gpu-base.c<br>
&gt; +++ b/hw/display/virtio-gpu-base.c<br>
&gt; @@ -223,7 +223,8 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, u=
int64_t features,<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(vdev);<=
br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (virtio_gpu_virgl_enabled(g-&gt;conf)) {<br>
&gt; +=C2=A0 =C2=A0 if (virtio_gpu_virgl_enabled(g-&gt;conf) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_rutabaga_enabled(g-&gt;conf)) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0features |=3D (1 &lt;&lt; VIRT=
IO_GPU_F_VIRGL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (virtio_gpu_edid_enabled(g-&gt;conf)) {<b=
r>
&gt; diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
&gt; index 3e658f1fef..fe094addef 100644<br>
&gt; --- a/hw/display/virtio-gpu.c<br>
&gt; +++ b/hw/display/virtio-gpu.c<br>
&gt; @@ -1361,8 +1361,9 @@ void virtio_gpu_device_realize(DeviceState *qdev=
, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VirtIOGPU *g =3D VIRTIO_GPU(qdev);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (virtio_gpu_blob_enabled(g-&gt;parent_obj=
.conf)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!virtio_gpu_have_udmabuf()) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;cann=
ot enable blob resources without udmabuf&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!virtio_gpu_rutabaga_enabled(g-&gt;pa=
rent_obj.conf) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !virtio_gpu_have_udmabuf())=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;need=
 rutabaga or udmabuf for blob resources&quot;);<br>
<br>
Does that mean udmabuf is not required at all when using rutabaga?<br>
How does rutabaga handle blob resources?<br></blockquote><div><br></div><di=
v>It&#39;s not required, since it&#39;s a Linux-only thing.=C2=A0 Some use =
cases do prefer to use guest memory and we do have provisional support for =
that (see `handle` field of `rutabaga_resource_create_blob`).=C2=A0 Though =
more testing is required on the target platform, and likely virtio-gpu spec=
 changes for a full-functional solution.=C2=A0=C2=A0</div><div><br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c<br>
&gt; index 74f4e41338..1b8005ae55 100644<br>
&gt; --- a/softmmu/qdev-monitor.c<br>
&gt; +++ b/softmmu/qdev-monitor.c<br>
&gt; @@ -86,6 +86,9 @@ static const QDevAlias qdev_alias_table[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;virtio-gpu-pci&quot;, &quot;virtio-g=
pu&quot;, QEMU_ARCH_VIRTIO_PCI },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;virtio-gpu-gl-device&quot;, &quot;vi=
rtio-gpu-gl&quot;, QEMU_ARCH_VIRTIO_MMIO },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;virtio-gpu-gl-pci&quot;, &quot;virti=
o-gpu-gl&quot;, QEMU_ARCH_VIRTIO_PCI },<br>
&gt; +=C2=A0 =C2=A0 { &quot;virtio-gpu-rutabaga-device&quot;, &quot;virtio-=
gpu-rutabaga&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 QEMU_ARCH_VIRTIO_MMIO },<br>
&gt; +=C2=A0 =C2=A0 { &quot;virtio-gpu-rutabaga-pci&quot;, &quot;virtio-gpu=
-rutabaga&quot;, QEMU_ARCH_VIRTIO_PCI },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;virtio-input-host-device&quot;, &quo=
t;virtio-input-host&quot;, QEMU_ARCH_VIRTIO_MMIO },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;virtio-input-host-ccw&quot;, &quot;v=
irtio-input-host&quot;, QEMU_ARCH_VIRTIO_CCW },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;virtio-input-host-pci&quot;, &quot;v=
irtio-input-host&quot;, QEMU_ARCH_VIRTIO_PCI },<br>
&gt; diff --git a/softmmu/vl.c b/softmmu/vl.c<br>
&gt; index b0b96f67fa..2f98eefdf3 100644<br>
&gt; --- a/softmmu/vl.c<br>
&gt; +++ b/softmmu/vl.c<br>
&gt; @@ -216,6 +216,7 @@ static struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ .driver =3D &quot;ati-vga&quot;,=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flag =3D &amp;default_vga=C2=A0 =C2=
=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ .driver =3D &quot;vhost-user-vga&quot;,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0.flag =3D &amp;default_vga=C2=A0 =C2=A0 =C2=A0 =C2=
=A0},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ .driver =3D &quot;virtio-vga-gl&quot;,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 .flag =3D &amp;default_vga=C2=A0 =C2=A0 =C2=A0 =C2=
=A0},<br>
&gt; +=C2=A0 =C2=A0 { .driver =3D &quot;virtio-vga-rutabaga&quot;,=C2=A0 .f=
lag =3D &amp;default_vga=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static QemuOptsList qemu_rtc_opts =3D {<br>
<br>
Patches 5 to 9:<br>
Reviewed-by: Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc.c=
om" target=3D"_blank">quic_acaggian@quicinc.com</a>&gt;<br>
<br>
Cheers,<br>
Antonio<br>
</blockquote></div></div>

--000000000000a2d0e80603c4149c--

