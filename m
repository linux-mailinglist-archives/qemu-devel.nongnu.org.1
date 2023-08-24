Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90180787C19
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 01:48:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZK3C-0005Ph-Ht; Thu, 24 Aug 2023 19:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZK32-0005PQ-BZ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 19:47:34 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZK2x-0006Y2-KM
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 19:47:31 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2bbad32bc79so5377481fa.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 16:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692920844; x=1693525644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4ccP58l+xy2p1Ezis1yRSnjnRtX6KVp3Lf8HqHN1WS8=;
 b=MUrzAGVjJok9XUMBodgTZyqjQFSaoZAKRN6HiB7IHf9b/B/uDTDPm3hKsqd+KtpjGL
 Fae0Bfndb9bsMcBgpHFcsfAO/PogzWDupAq6xgrpXrq3NDN4rDrfECdjkHrQo2u2ZKxw
 BdQ3aCPp0wjXS76Td297o7WPDvqZWt4p23wRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692920844; x=1693525644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ccP58l+xy2p1Ezis1yRSnjnRtX6KVp3Lf8HqHN1WS8=;
 b=XRGOeOx/pV12YbvIvkoVow8dO6yT6KcoBzYfhbwKA8HoSzbxUnouBWKvJ1IOEM+cOd
 z1Wy0qorDKLVcAlf4ZD5/piMIp18aIJS4QLK27QIS6OH92XPTdhPNAFa/EflvLpE0rVg
 kF4oyJWnfX1FeXOFve6xN3eoOonDSiLAWnTofYk8c+d1CvegLpJN0Va9LEDJ+RfL9uCr
 bo40K+p8DTy44/aGG2pG9dvW0W1tvo8iROxGq2jPxpOfOhs4G98NT+SIRDqpPfdv8Bak
 0vMZzRWTAoCq98h54hHQING8lR9esz1RM7mGIRk5StpKSOUQ+7brYIuTdfen78QfNgLl
 jr3g==
X-Gm-Message-State: AOJu0YzK0H0AnzU23ZtDQOePv114cEWBEMRpsTrBL6sWUKDc+yoEy8qM
 cH90jCx5rv5bnCdF8FeaCOyUwbDL4/Sso47T95Z+cg==
X-Google-Smtp-Source: AGHT+IGEdm84dsafPcKgjiaHE0U9XDazfCMSHMuPXITIFc3eA2XAL9KjOQ/jAh+Ps61MgLFeqARfsw==
X-Received: by 2002:a05:6512:b20:b0:4fe:1681:9377 with SMTP id
 w32-20020a0565120b2000b004fe16819377mr11273868lfu.44.1692920844608; 
 Thu, 24 Aug 2023 16:47:24 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com.
 [209.85.208.54]) by smtp.gmail.com with ESMTPSA id
 l7-20020a170906938700b009a2235ed496sm214717ejx.141.2023.08.24.16.47.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 16:47:23 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-529fa243739so6560a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 16:47:23 -0700 (PDT)
X-Received: by 2002:a50:d554:0:b0:523:b133:57fe with SMTP id
 f20-20020a50d554000000b00523b13357femr67605edj.1.1692920843512; Thu, 24 Aug
 2023 16:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230817022322.466-1-gurchetansingh@google.com>
 <20230817022322.466-6-gurchetansingh@google.com>
 <ab53fab4-0d85-1279-c1fd-982af5fe3a6d@ilande.co.uk>
In-Reply-To: <ab53fab4-0d85-1279-c1fd-982af5fe3a6d@ilande.co.uk>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 24 Aug 2023 16:47:10 -0700
X-Gmail-Original-Message-ID: <CAAfnVB=8O1rR=rNhnsPh-phUZKtEw91V6WbSgYsR=VzwOZT3Hw@mail.gmail.com>
Message-ID: <CAAfnVB=8O1rR=rNhnsPh-phUZKtEw91V6WbSgYsR=VzwOZT3Hw@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] gfxstream + rutabaga prep: added need defintions, 
 fields, and options
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, kraxel@redhat.com, 
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com, hi@alyssa.is, ernunes@redhat.com, 
 manos.pitsidianakis@linaro.org
Content-Type: multipart/alternative; boundary="00000000000082f9a80603b3d9b8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=gurchetansingh@chromium.org; helo=mail-lj1-x230.google.com
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

--00000000000082f9a80603b3d9b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 7:32=E2=80=AFAM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> On 17/08/2023 03:23, Gurchetan Singh wrote:
>
> > From: Gurchetan Singh <gurchetansingh@chromium.org>
> >
> > This modifies the common virtio-gpu.h file have the fields and
> > defintions needed by gfxstream/rutabaga, by VirtioGpuRutabaga.
> >
> > Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> > Tested-by: Alyssa Ross <hi@alyssa.is>
> > Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> > Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> > v1: void *rutabaga --> struct rutabaga *rutabaga (Akihiko)
> >      have a separate rutabaga device instead of using GL device (Bernar=
d)
> >
> > v2: VirtioGpuRutabaga --> VirtIOGPURutabaga (Akihiko)
> >      move MemoryRegionInfo into VirtIOGPURutabaga (Akihiko)
> >      remove 'ctx' field (Akihiko)
> >      remove 'rutabaga_active'
> >
> > v6: remove command from commit message, refer to docs instead (Manos)
> >
> >   include/hw/virtio/virtio-gpu.h | 28 ++++++++++++++++++++++++++++
> >   1 file changed, 28 insertions(+)
> >
> > diff --git a/include/hw/virtio/virtio-gpu.h
> b/include/hw/virtio/virtio-gpu.h
> > index 55973e112f..e2a07e68d9 100644
> > --- a/include/hw/virtio/virtio-gpu.h
> > +++ b/include/hw/virtio/virtio-gpu.h
> > @@ -38,6 +38,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPUGL, VIRTIO_GPU_GL=
)
> >   #define TYPE_VHOST_USER_GPU "vhost-user-gpu"
> >   OBJECT_DECLARE_SIMPLE_TYPE(VhostUserGPU, VHOST_USER_GPU)
> >
> > +#define TYPE_VIRTIO_GPU_RUTABAGA "virtio-gpu-rutabaga-device"
> > +OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPURutabaga, VIRTIO_GPU_RUTABAGA)
> > +
> >   struct virtio_gpu_simple_resource {
> >       uint32_t resource_id;
> >       uint32_t width;
> > @@ -94,6 +97,7 @@ enum virtio_gpu_base_conf_flags {
> >       VIRTIO_GPU_FLAG_DMABUF_ENABLED,
> >       VIRTIO_GPU_FLAG_BLOB_ENABLED,
> >       VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
> > +    VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
> >   };
> >
> >   #define virtio_gpu_virgl_enabled(_cfg) \
> > @@ -108,6 +112,8 @@ enum virtio_gpu_base_conf_flags {
> >       (_cfg.flags & (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED))
> >   #define virtio_gpu_context_init_enabled(_cfg) \
> >       (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
> > +#define virtio_gpu_rutabaga_enabled(_cfg) \
> > +    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
> >   #define virtio_gpu_hostmem_enabled(_cfg) \
> >       (_cfg.hostmem > 0)
> >
> > @@ -232,6 +238,28 @@ struct VhostUserGPU {
> >       bool backend_blocked;
> >   };
> >
> > +#define MAX_SLOTS 4096
> > +
> > +struct MemoryRegionInfo {
> > +    int used;
> > +    MemoryRegion mr;
> > +    uint32_t resource_id;
> > +};
> > +
> > +struct rutabaga;
> > +
> > +struct VirtIOGPURutabaga {
> > +    struct VirtIOGPU parent_obj;
>
> The QOM macro should define a typedef for you, so you can drop the
> "struct" here.
>
> > +
> > +    struct MemoryRegionInfo memory_regions[MAX_SLOTS];
> > +    char *capset_names;
> > +    char *wayland_socket_path;
> > +    char *wsi;
> > +    bool headless;
> > +    uint32_t num_capsets;
> > +    struct rutabaga *rutabaga;
> > +};
> > +
>
> Shouldn't the VIRTIO_GPU_RUTABAGA QOM declaration and this structure be i=
n
> a separate
> virtio-gpu-rutabaga header file which also includes the header defining
> struct
> rutabaga? The fact that you're having to pre-declare struct rutabaga in
> this header
> when rutabaga support is an optional dependency doesn't seem right.
>

It is the prevailing style of the virtio-gpu code.  For example, we do have
"virtio_gpu_virgl_*" functions, vhost-user, and udmabuf stubs in the same
file.  So for now, I didn't add an extra header file in v12.  In the
future, separating out optional dependencies into constituent header files
could be future refactoring/cleanup.


>
> >   #define VIRTIO_GPU_FILL_CMD(out) do {
>  \
> >           size_t s;
>  \
> >           s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,
>   \
>
>
> ATB,
>
> Mark.
>
>

--00000000000082f9a80603b3d9b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 23, 2023 at 7:32=E2=80=AF=
AM Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk" ta=
rget=3D"_blank">mark.cave-ayland@ilande.co.uk</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On 17/08/2023 03:23, Gurchetan=
 Singh wrote:<br>
<br>
&gt; From: Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromium.or=
g" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;<br>
&gt; <br>
&gt; This modifies the common virtio-gpu.h file have the fields and<br>
&gt; defintions needed by gfxstream/rutabaga, by VirtioGpuRutabaga.<br>
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
&gt; v1: void *rutabaga --&gt; struct rutabaga *rutabaga (Akihiko)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 have a separate rutabaga device instead of using G=
L device (Bernard)<br>
&gt; <br>
&gt; v2: VirtioGpuRutabaga --&gt; VirtIOGPURutabaga (Akihiko)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 move MemoryRegionInfo into VirtIOGPURutabaga (Akih=
iko)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 remove &#39;ctx&#39; field (Akihiko)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 remove &#39;rutabaga_active&#39;<br>
&gt; <br>
&gt; v6: remove command from commit message, refer to docs instead (Manos)<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-gpu.h | 28 ++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 28 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio=
-gpu.h<br>
&gt; index 55973e112f..e2a07e68d9 100644<br>
&gt; --- a/include/hw/virtio/virtio-gpu.h<br>
&gt; +++ b/include/hw/virtio/virtio-gpu.h<br>
&gt; @@ -38,6 +38,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPUGL, VIRTIO_GPU_G=
L)<br>
&gt;=C2=A0 =C2=A0#define TYPE_VHOST_USER_GPU &quot;vhost-user-gpu&quot;<br>
&gt;=C2=A0 =C2=A0OBJECT_DECLARE_SIMPLE_TYPE(VhostUserGPU, VHOST_USER_GPU)<b=
r>
&gt;=C2=A0 =C2=A0<br>
&gt; +#define TYPE_VIRTIO_GPU_RUTABAGA &quot;virtio-gpu-rutabaga-device&quo=
t;<br>
&gt; +OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPURutabaga, VIRTIO_GPU_RUTABAGA)<br=
>
&gt; +<br>
&gt;=C2=A0 =C2=A0struct virtio_gpu_simple_resource {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t resource_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t width;<br>
&gt; @@ -94,6 +97,7 @@ enum virtio_gpu_base_conf_flags {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_FLAG_DMABUF_ENABLED,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_FLAG_BLOB_ENABLED,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,<br>
&gt; +=C2=A0 =C2=A0 VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define virtio_gpu_virgl_enabled(_cfg) \<br>
&gt; @@ -108,6 +112,8 @@ enum virtio_gpu_base_conf_flags {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(_cfg.flags &amp; (1 &lt;&lt; VIRTIO_GPU_FLA=
G_BLOB_ENABLED))<br>
&gt;=C2=A0 =C2=A0#define virtio_gpu_context_init_enabled(_cfg) \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(_cfg.flags &amp; (1 &lt;&lt; VIRTIO_GPU_FLA=
G_CONTEXT_INIT_ENABLED))<br>
&gt; +#define virtio_gpu_rutabaga_enabled(_cfg) \<br>
&gt; +=C2=A0 =C2=A0 (_cfg.flags &amp; (1 &lt;&lt; VIRTIO_GPU_FLAG_RUTABAGA_=
ENABLED))<br>
&gt;=C2=A0 =C2=A0#define virtio_gpu_hostmem_enabled(_cfg) \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(_cfg.hostmem &gt; 0)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -232,6 +238,28 @@ struct VhostUserGPU {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool backend_blocked;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#define MAX_SLOTS 4096<br>
&gt; +<br>
&gt; +struct MemoryRegionInfo {<br>
&gt; +=C2=A0 =C2=A0 int used;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion mr;<br>
&gt; +=C2=A0 =C2=A0 uint32_t resource_id;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct rutabaga;<br>
&gt; +<br>
&gt; +struct VirtIOGPURutabaga {<br>
&gt; +=C2=A0 =C2=A0 struct VirtIOGPU parent_obj;<br>
<br>
The QOM macro should define a typedef for you, so you can drop the &quot;st=
ruct&quot; here.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 struct MemoryRegionInfo memory_regions[MAX_SLOTS];<br>
&gt; +=C2=A0 =C2=A0 char *capset_names;<br>
&gt; +=C2=A0 =C2=A0 char *wayland_socket_path;<br>
&gt; +=C2=A0 =C2=A0 char *wsi;<br>
&gt; +=C2=A0 =C2=A0 bool headless;<br>
&gt; +=C2=A0 =C2=A0 uint32_t num_capsets;<br>
&gt; +=C2=A0 =C2=A0 struct rutabaga *rutabaga;<br>
&gt; +};<br>
&gt; +<br>
<br>
Shouldn&#39;t the VIRTIO_GPU_RUTABAGA QOM declaration and this structure be=
 in a separate <br>
virtio-gpu-rutabaga header file which also includes the header defining str=
uct <br>
rutabaga? The fact that you&#39;re having to pre-declare struct rutabaga in=
 this header <br>
when rutabaga support is an optional dependency doesn&#39;t seem right.<br>=
</blockquote><div><br></div><div>It is the prevailing style of the virtio-g=
pu code.=C2=A0 For example, we do have &quot;virtio_gpu_virgl_*&quot; funct=
ions, vhost-user, and udmabuf stubs in the same file.=C2=A0 So for now, I d=
idn&#39;t add an extra header file in v12.=C2=A0 In the future, separating =
out optional dependencies into constituent=C2=A0header files could be futur=
e refactoring/cleanup.</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0#define VIRTIO_GPU_FILL_CMD(out) do {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t s;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s =3D iov_to_buf(cmd-&gt;elem.=
out_sg, cmd-&gt;elem.out_num, 0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div></div>

--00000000000082f9a80603b3d9b8--

