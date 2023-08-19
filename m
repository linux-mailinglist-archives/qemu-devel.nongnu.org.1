Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C146781662
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:14:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAXo-0000S6-F1; Fri, 18 Aug 2023 21:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qXAXm-0000KK-Bb
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:14:22 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qXAXj-0001KN-Lo
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:14:22 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3175f17a7baso1268245f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692407658; x=1693012458;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zvli0R/gTet5wkfA0CfcrxygTBrQ3lnF0OsusSC4Vio=;
 b=N4JlfT9hbwJTMtTCs+LIII3cUMaLKpgaaBvzVHN7WzK2h81zSKnwzDvYuu8VAEvx9e
 xs9FKWf1+/E0Ei0LVQ+H3IPog3zrMimESKofqR3aEqHJILNeIWEuiJ66Hho2QrKqmy6y
 0gOXCEqNVpKvksN4EWdRNwUvhzrYf1jihvcxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692407658; x=1693012458;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zvli0R/gTet5wkfA0CfcrxygTBrQ3lnF0OsusSC4Vio=;
 b=FZogIjetdWTaAPkDP0n++tvO1CdjID2LExG3aiIzyKwNR8fKb1RbzH0TjLxM2BZ0Sh
 UxFpLbh0mMb9y3CsR2pvyjAIJ977W0z2Sz/5ISBeR+HAOktPy5nwaLl5UHjnQGxDMIrG
 ALH9Nz94WK5Y1L8bsBIliSwqeAKz3hfWSXxPF0kro6oJ98Awc/SwzvxdApHq1mIxs2Y8
 2LOHC6oIm8SDBxsQ6S8fYRx4Tyhz9LKWqO3tslfnlyC0q71Id2atU0wOFWeExpEbO26K
 yhQLsRcR9zpYQshyrqoFu43fZ32oP11uCbWJodxIXk3gniYfn5Xwq1VEotlrehKED4Sv
 cNUw==
X-Gm-Message-State: AOJu0Yyn9tmTUHR+JC1sCpHyF0c+KaWZUi8+dg2Edsbrof2jv9ibN3Y4
 MN8ACcXSkjbyiIDBUOzQrof3WA+NHGvGeOtAsokpww==
X-Google-Smtp-Source: AGHT+IGsyy1wgp2Hs1M2+fntD7NsjHprgZ9HPTWV5Mc7BRuryBKM1Ry79ZPE9TvOFG+xLCaPAVYH9Q==
X-Received: by 2002:a5d:6084:0:b0:31a:d9bc:47a2 with SMTP id
 w4-20020a5d6084000000b0031ad9bc47a2mr524850wrt.53.1692407657945; 
 Fri, 18 Aug 2023 18:14:17 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com.
 [209.85.208.52]) by smtp.gmail.com with ESMTPSA id
 v13-20020aa7d80d000000b00522828d438csm1683720edq.7.2023.08.18.18.14.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 18:14:17 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-51e24210395so4536a12.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:14:17 -0700 (PDT)
X-Received: by 2002:a50:874f:0:b0:523:bdc9:48a9 with SMTP id
 15-20020a50874f000000b00523bdc948a9mr181409edv.0.1692407657269; Fri, 18 Aug
 2023 18:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230817022322.466-1-gurchetansingh@google.com>
 <20230817022322.466-9-gurchetansingh@google.com>
 <91b1ced0-4a41-4878-af35-18895927eabc@gmail.com>
In-Reply-To: <91b1ced0-4a41-4878-af35-18895927eabc@gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Fri, 18 Aug 2023 18:14:05 -0700
X-Gmail-Original-Message-ID: <CAAfnVB=KdJ_XgA4xkaGc1jYo5y4UvSNE8=RWtCc+ov2o3wN7DA@mail.gmail.com>
Message-ID: <CAAfnVB=KdJ_XgA4xkaGc1jYo5y4UvSNE8=RWtCc+ov2o3wN7DA@mail.gmail.com>
Subject: Re: [PATCH v7 8/9] gfxstream + rutabaga: enable rutabaga
To: Akihiko Odaki <akihiko.odaki@gmail.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, kraxel@redhat.com, 
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, 
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Content-Type: multipart/alternative; boundary="0000000000003a63d706033c5df3"
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=gurchetansingh@chromium.org; helo=mail-wr1-x42b.google.com
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

--0000000000003a63d706033c5df3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 4:58=E2=80=AFAM Akihiko Odaki <akihiko.odaki@gmail.=
com>
wrote:

> On 2023/08/17 11:23, Gurchetan Singh wrote:
> > From: Gurchetan Singh <gurchetansingh@chromium.org>
> >
> > This change enables rutabaga to receive virtio-gpu-3d hypercalls
> > when it is active.
> >
> > Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> > Tested-by: Alyssa Ross <hi@alyssa.is>
> > Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> > Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> > v3: Whitespace fix (Akihiko)
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
> > index 3e658f1fef..08e170e029 100644
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
> > +        if (!virtio_gpu_have_udmabuf() &&
>
> virtio_gpu_have_udmabuf() emits a warning if udmabuf is not available,
> which is spurious when using Rutabaga.
>
> I think virtio_gpu_have_udmabuf() should be renamed to
> virtio_gpu_init_udmabuf() or something, let it set errp instead of
> emitting a warning, and call it only when Rutabaga is not in use.


Not too familiar with udmabuf case, so just reordered the if rutabaga check
to avoid the spurious warning.  Probably an udmabuf cleanups should in an
additional patch series.


> That
> clarifies the timing when an error message will be shown.
>

--0000000000003a63d706033c5df3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 18, 2023 at 4:58=E2=80=AF=
AM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@gmail.com">akihiko.oda=
ki@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On 2023/08/17 11:23, Gurchetan Singh wrote:<br>
&gt; From: Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromium.or=
g" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;<br>
&gt; <br>
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
&gt; index 3e658f1fef..08e170e029 100644<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!virtio_gpu_have_udmabuf() &amp;&amp;=
<br>
<br>
virtio_gpu_have_udmabuf() emits a warning if udmabuf is not available, <br>
which is spurious when using Rutabaga.<br>
<br>
I think virtio_gpu_have_udmabuf() should be renamed to <br>
virtio_gpu_init_udmabuf() or something, let it set errp instead of <br>
emitting a warning, and call it only when Rutabaga is not in use.</blockquo=
te><div><br></div><div>Not too familiar with udmabuf case, so just reordere=
d the if rutabaga check to avoid the spurious warning.=C2=A0 Probably an ud=
mabuf cleanups should in an additional patch series.</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"> That <br>
clarifies the timing when an error message will be shown.<br>
</blockquote></div></div>

--0000000000003a63d706033c5df3--

