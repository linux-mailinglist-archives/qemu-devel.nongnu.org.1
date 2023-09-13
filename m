Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5473279F1D8
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 21:18:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgVNm-00045k-Pi; Wed, 13 Sep 2023 15:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qgVNl-0003vU-0P
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:18:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qgVNh-0001V9-7t
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694632712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ee3A+c55EnfTKgpCh3JNggXw5bb6VJE32g+BKTFo8dg=;
 b=DBNXuN7P9m1N/uFWz19omipeg4npzwRybqySlpy5BhzdGX3owsBJ/M0r9n8HDHPxUmOBq+
 KSyk3clhbYSLiRsfnwoBnd/K4uKoH8b+z6qDw3JChL1y2SnxYU2XNwCHzU1pn6Pq1KAUZa
 ndR2oi5nc50s7aBYVnVuhQLPNDtia6w=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-ewv7L81cPcqLTiwMKbwmeA-1; Wed, 13 Sep 2023 15:18:30 -0400
X-MC-Unique: ewv7L81cPcqLTiwMKbwmeA-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-77e41268d40so11402239f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 12:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694632709; x=1695237509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ee3A+c55EnfTKgpCh3JNggXw5bb6VJE32g+BKTFo8dg=;
 b=Sod+iNFapry79fqPSpO2AROTemW69zryA3HLR/SO3OXo64dhr3ilgTofzefZYRfsC/
 i95kIG8F760ISr3kJjRtltViXSzUk5hZwQjgjR1wr8ecaPtZbpIcW2bJKaC5bDAEf2nM
 sbG0DNlo3zM7146vMgWgjMTyvR2VGAvpEbduAy6AIan1S7P+9TypUR6pA091Y0HwYE48
 qtpsXbHRIxzcaune0vnP5jPiP1QNDdT2KB5rxJqxFhJ97/9y7tvWVqGp+Xn3zaDpbmuJ
 H5TaUMUZZREeGwLvgKLM8mEi16ebreQ3vfKNXk1ENo3w7pVIzc0TGZh7vliCizd/2EtC
 j68w==
X-Gm-Message-State: AOJu0Yw41W4q+oW+gLSMDIxSWHdmhb/+XrdLQ5ebnrnXh/Iu9FgfuFdB
 I86UVgRyoG7QdDA1cVs6ltKBE2Q3zS+8NWKNi3CbT06gbcULALIi5Na0KSMKKaKG35D5q52qdJX
 zGS2L2Q9/saBlhNk=
X-Received: by 2002:a05:6602:2254:b0:794:ed2b:2520 with SMTP id
 o20-20020a056602225400b00794ed2b2520mr3824019ioo.15.1694632709650; 
 Wed, 13 Sep 2023 12:18:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYRwNR+rPTlwBkw/fMfJk7uGIgvGUWe/n8SsHhC4M2mKrIRnmaxTB8taowqRdqy9f70rMC1A==
X-Received: by 2002:a05:6602:2254:b0:794:ed2b:2520 with SMTP id
 o20-20020a056602225400b00794ed2b2520mr3824001ioo.15.1694632709280; 
 Wed, 13 Sep 2023 12:18:29 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 d24-20020a5d9518000000b007836e9ff198sm3572504iom.55.2023.09.13.12.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 12:18:28 -0700 (PDT)
Date: Wed, 13 Sep 2023 13:18:27 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: kraxel@redhat.com
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>, "Kim,
 Dongwon" <dongwon.kim@intel.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin"
 <mst@redhat.com>
Subject: Re: [PATCH for-8.1] vfio/display: Fix missing update to set backing
 fields
Message-ID: <20230913131827.3bfe7bcb.alex.williamson@redhat.com>
In-Reply-To: <20230905090907.2b70b6a0.alex.williamson@redhat.com>
References: <20230816215550.1723696-1-alex.williamson@redhat.com>
 <a3a6f8ec-ca61-4472-45b4-1077dd27bb52@linaro.org>
 <acddfb4a-fe42-ba8c-e920-edc7e9ff5268@intel.com>
 <CAJ+F1C+YiDgRuyWcGeUPhaNO4SdjOSFSHKBY1wBS3dJFLO-k2w@mail.gmail.com>
 <20230904081129.3908c083.alex.williamson@redhat.com>
 <CAJ+F1CJFiHCu4FTbSFfLgSANiHJHEowJg7Um3j+ZMiHb_S21aQ@mail.gmail.com>
 <20230905090907.2b70b6a0.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Hi Gerd,

Some consultation would be appreciated on this thread to get this patch
out of limbo.  Is there a better solution that what I've proposed?
AFAICT, we don't have position fields to indicate the dmabuf plane is
relative to some scanout, so I think it represents the entire display.
Thanks,

Alex

On Tue, 5 Sep 2023 09:09:07 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Mon, 4 Sep 2023 21:00:53 +0400
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>=20
> > Hi
> >=20
> > On Mon, Sep 4, 2023 at 6:11=E2=80=AFPM Alex Williamson
> > <alex.williamson@redhat.com> wrote: =20
> > >
> > > On Mon, 4 Sep 2023 15:06:21 +0400
> > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> > >   =20
> > > > Hi
> > > >
> > > > On Thu, Aug 17, 2023 at 8:29=E2=80=AFPM Kim, Dongwon <dongwon.kim@i=
ntel.com> wrote:   =20
> > > > >
> > > > > Ok, this regression happened not just because of renaming. Origin=
ally
> > > > > width and height were representing the size of whole surface that=
 guest
> > > > > shares while scanout width and height are for the each scanout. We
> > > > > realized backing_width/height are more commonly used to specify t=
he size
> > > > > of the whole guest surface so put them in the place of width/heig=
ht then
> > > > > replaced scanout_width/height as well with normal width/height.
> > > > >
> > > > > On 8/16/2023 3:31 PM, Philippe Mathieu-Daud=C3=A9 wrote:   =20
> > > > > > On 16/8/23 23:55, Alex Williamson wrote:   =20
> > > > > >> The below referenced commit renames scanout_width/height to
> > > > > >> backing_width/height, but also promotes these fields in variou=
s portions
> > > > > >> of the egl interface.  Meanwhile vfio dmabuf support has never=
 used the
> > > > > >> previous scanout fields and is therefore missed in the update.=
 This
> > > > > >> results in a black screen when transitioning from ramfb to dma=
buf
> > > > > >> display
> > > > > >> when using Intel vGPU with these features.   =20
> > > > > >
> > > > > > Referenced commit isn't trivial. Maybe because it is too late h=
ere.
> > > > > > I'd have tried to split it. Anyhow, too late (again).
> > > > > >
> > > > > > Is vhost-user-gpu also affected? (see VHOST_USER_GPU_DMABUF_SCA=
NOUT
> > > > > > in vhost_user_gpu_handle_display()).   =20
> > > > >
> > > > > Yeah, backing_width/height should be programmed with plane.width/=
height
> > > > > as well in vhost_user_gpu_handle_display().
> > > > >
> > > > > Link: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg02=
726.html   =20
> > > > > >> Fixes: 9ac06df8b684 ("virtio-gpu-udmabuf: correct naming of
> > > > > >> QemuDmaBuf size properties")
> > > > > >> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > > >> ---
> > > > > >>
> > > > > >> This fixes a regression in dmabuf/EGL support for Intel GVT-g =
and
> > > > > >> potentially the mbochs mdev driver as well.  Once validated by=
 those
> > > > > >> that understand dmabuf/EGL integration, I'd welcome QEMU maint=
ainers to
> > > > > >> take this directly for v8.1 or queue it as soon as possible fo=
r v8.1.1.
> > > > > >>
> > > > > >>   hw/vfio/display.c | 2 ++
> > > > > >>   1 file changed, 2 insertions(+)
> > > > > >>
> > > > > >> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> > > > > >> index bec864f482f4..837d9e6a309e 100644
> > > > > >> --- a/hw/vfio/display.c
> > > > > >> +++ b/hw/vfio/display.c
> > > > > >> @@ -243,6 +243,8 @@ static VFIODMABuf
> > > > > >> *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
> > > > > >>       dmabuf->dmabuf_id  =3D plane.dmabuf_id;
> > > > > >>       dmabuf->buf.width  =3D plane.width;
> > > > > >>       dmabuf->buf.height =3D plane.height;   =20
> > > > >
> > > > > One thing to note here is the normal width and height in the Qemu=
DmaBuf
> > > > > are of a scanout, which could be just a partial area of the guest=
 plane
> > > > > here. So we should not use those as normal width and height of the
> > > > > QemuDmaBuf unless it is guaranteed the given guest surface (plane=
 in
> > > > > this case) is always of single display's.
> > > > >
> > > > > https://lists.gnu.org/archive/html/qemu-devel/2021-09/msg04737.ht=
ml
> > > > >   =20
> > > > > >> +    dmabuf->buf.backing_width =3D plane.width;
> > > > > >> +    dmabuf->buf.backing_height =3D plane.height;
> > > > > >>       dmabuf->buf.stride =3D plane.stride;
> > > > > >>       dmabuf->buf.fourcc =3D plane.drm_format;
> > > > > >>       dmabuf->buf.modifier =3D plane.drm_format_mod;   =20
> > > > > >   =20
> > > > >   =20
> > > >
> > > > I agree with what Kim said. Alex, are you sending a new patch?   =20
> > >
> > > What would be different?
> > >
> > > struct vfio_device_gfx_plane_info {
> > >         __u32 argsz;
> > >         __u32 flags;
> > > #define VFIO_GFX_PLANE_TYPE_PROBE (1 << 0)
> > > #define VFIO_GFX_PLANE_TYPE_DMABUF (1 << 1)
> > > #define VFIO_GFX_PLANE_TYPE_REGION (1 << 2)
> > >         /* in */
> > >         __u32 drm_plane_type;   /* type of plane: DRM_PLANE_TYPE_* */
> > >         /* out */
> > >         __u32 drm_format;       /* drm format of plane */
> > >         __u64 drm_format_mod;   /* tiled mode */
> > >         __u32 width;    /* width of plane */
> > >         __u32 height;   /* height of plane */
> > >         __u32 stride;   /* stride of plane */
> > >         __u32 size;     /* size of plane in bytes, align on page*/
> > >         __u32 x_pos;    /* horizontal position of cursor plane */
> > >         __u32 y_pos;    /* vertical position of cursor plane*/
> > >         __u32 x_hot;    /* horizontal position of cursor hotspot */
> > >         __u32 y_hot;    /* vertical position of cursor hotspot */
> > >         union {
> > >                 __u32 region_index;     /* region index */
> > >                 __u32 dmabuf_id;        /* dma-buf id */
> > >         };
> > > };
> > >   =20
> >=20
> > Perhaps VFIO is missing extra infos to set the actual x/y/w/h
> > region(s) of the visible monitor(s). This could be an extra message. I
> > am not familiar with the kernel/driver side for this, perhaps it is
> > always guaranteed to be the whole plane (+0+0+w*h). In which case, we
> > simply to set the QemuDmabuf fields accordingly. =20
>=20
> Isn't that what the proposed patch does?  Gerd is likely going to need
> to chime in for any sort of authoritative answer.  Gerd?  Thanks,
>=20
> Alex


