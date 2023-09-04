Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 911D6791BD3
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 19:02:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCwq-0004yh-AP; Mon, 04 Sep 2023 13:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qdCwp-0004yU-3H
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 13:01:11 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qdCwk-0002EN-RG
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 13:01:10 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4121f006c30so9628451cf.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693846865; x=1694451665; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RxGwYW9Jx094UeZIlGXISiP1fwvleV8JTxDAeeWgok=;
 b=M9E+L38AHqfl4pwvjMS1AaCCg0RreWh15wIZGDpis5MW3k1k7Zd1SrLyfA9nU1kwm2
 Lica8dJ/TorIcOv5a9UgCx2N18ZbTh248m1YmM1+aqd2qfyoYVNPKXcDetq0TvfLOu0H
 g03T6txPJNED5phtUmh9e/EF4kSjZdpEr+59czl+bZfyuV0gFNSRWjJzBJP+8gFR4AP2
 rVKSMEylH3euHUwdbnwbH0SjkCccK3jWgcElCwZLl+Q2tNANdcgqwMvyoyotfnGeNQYS
 zPzvkg/Gg2yXdBWcKNOX6FIiJtF9GhAViIrRXrTK/N8irw3+niUYVak2MCWRaMumhE2J
 XrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693846865; x=1694451665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/RxGwYW9Jx094UeZIlGXISiP1fwvleV8JTxDAeeWgok=;
 b=jqvr8intzXCUqrqCwCvS3Y0InZZysw80vaqu6SKs7nxlAyT2uQeNBGDhfNhTx1B4J5
 jfqEbuZ9tVa/rOAfzdi8UY8PbrNrFQuk9B8T14SXGromFQaYYK9EvRi0N06KDJgWElRT
 AuSWdbCAQhNiFzmXWLg78DFIbBZ7nuW+eVWJF4okbmePR5m5pFh1z/LuwiVp9W7l47AI
 6pG8udWkWz5Iq+uwZUei07JzD18SQ4eKtSQIA7LLAHzS/YMp68tM8kMTx2qIRH9Ar+9Q
 bVjF3xaC72YJhPFv/N5RtSu+kE+1P6BvK5Nqt4p7w46oS5I3acrYCcyPLw1uPd47ELSX
 Ku1w==
X-Gm-Message-State: AOJu0Ywg6aCwbr2ns+R8mKabPkL1JRcwLrAi2/WJiEud9MvQQlAJGHFX
 LmCZdIyk0Z+K3REsn9kRdIONb7JMzulNppPf+os=
X-Google-Smtp-Source: AGHT+IE0KB3zc5hgVyeFpy4J1z6iy5DBwZDjZA62GOPtjlMo2GRg6nO5bJXoNijmMdgbAeQzc36KWp+m84+vZcVDCw8=
X-Received: by 2002:a05:622a:1910:b0:40f:ffd3:6201 with SMTP id
 w16-20020a05622a191000b0040fffd36201mr13321746qtc.66.1693846865096; Mon, 04
 Sep 2023 10:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230816215550.1723696-1-alex.williamson@redhat.com>
 <a3a6f8ec-ca61-4472-45b4-1077dd27bb52@linaro.org>
 <acddfb4a-fe42-ba8c-e920-edc7e9ff5268@intel.com>
 <CAJ+F1C+YiDgRuyWcGeUPhaNO4SdjOSFSHKBY1wBS3dJFLO-k2w@mail.gmail.com>
 <20230904081129.3908c083.alex.williamson@redhat.com>
In-Reply-To: <20230904081129.3908c083.alex.williamson@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Sep 2023 21:00:53 +0400
Message-ID: <CAJ+F1CJFiHCu4FTbSFfLgSANiHJHEowJg7Um3j+ZMiHb_S21aQ@mail.gmail.com>
Subject: Re: [PATCH for-8.1] vfio/display: Fix missing update to set backing
 fields
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Kim, Dongwon" <dongwon.kim@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Mon, Sep 4, 2023 at 6:11=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Mon, 4 Sep 2023 15:06:21 +0400
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>
> > Hi
> >
> > On Thu, Aug 17, 2023 at 8:29=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel=
.com> wrote:
> > >
> > > Ok, this regression happened not just because of renaming. Originally
> > > width and height were representing the size of whole surface that gue=
st
> > > shares while scanout width and height are for the each scanout. We
> > > realized backing_width/height are more commonly used to specify the s=
ize
> > > of the whole guest surface so put them in the place of width/height t=
hen
> > > replaced scanout_width/height as well with normal width/height.
> > >
> > > On 8/16/2023 3:31 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > > > On 16/8/23 23:55, Alex Williamson wrote:
> > > >> The below referenced commit renames scanout_width/height to
> > > >> backing_width/height, but also promotes these fields in various po=
rtions
> > > >> of the egl interface.  Meanwhile vfio dmabuf support has never use=
d the
> > > >> previous scanout fields and is therefore missed in the update. Thi=
s
> > > >> results in a black screen when transitioning from ramfb to dmabuf
> > > >> display
> > > >> when using Intel vGPU with these features.
> > > >
> > > > Referenced commit isn't trivial. Maybe because it is too late here.
> > > > I'd have tried to split it. Anyhow, too late (again).
> > > >
> > > > Is vhost-user-gpu also affected? (see VHOST_USER_GPU_DMABUF_SCANOUT
> > > > in vhost_user_gpu_handle_display()).
> > >
> > > Yeah, backing_width/height should be programmed with plane.width/heig=
ht
> > > as well in vhost_user_gpu_handle_display().
> > >
> > > Link: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg02726.=
html
> > > >> Fixes: 9ac06df8b684 ("virtio-gpu-udmabuf: correct naming of
> > > >> QemuDmaBuf size properties")
> > > >> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > >> ---
> > > >>
> > > >> This fixes a regression in dmabuf/EGL support for Intel GVT-g and
> > > >> potentially the mbochs mdev driver as well.  Once validated by tho=
se
> > > >> that understand dmabuf/EGL integration, I'd welcome QEMU maintaine=
rs to
> > > >> take this directly for v8.1 or queue it as soon as possible for v8=
.1.1.
> > > >>
> > > >>   hw/vfio/display.c | 2 ++
> > > >>   1 file changed, 2 insertions(+)
> > > >>
> > > >> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> > > >> index bec864f482f4..837d9e6a309e 100644
> > > >> --- a/hw/vfio/display.c
> > > >> +++ b/hw/vfio/display.c
> > > >> @@ -243,6 +243,8 @@ static VFIODMABuf
> > > >> *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
> > > >>       dmabuf->dmabuf_id  =3D plane.dmabuf_id;
> > > >>       dmabuf->buf.width  =3D plane.width;
> > > >>       dmabuf->buf.height =3D plane.height;
> > >
> > > One thing to note here is the normal width and height in the QemuDmaB=
uf
> > > are of a scanout, which could be just a partial area of the guest pla=
ne
> > > here. So we should not use those as normal width and height of the
> > > QemuDmaBuf unless it is guaranteed the given guest surface (plane in
> > > this case) is always of single display's.
> > >
> > > https://lists.gnu.org/archive/html/qemu-devel/2021-09/msg04737.html
> > >
> > > >> +    dmabuf->buf.backing_width =3D plane.width;
> > > >> +    dmabuf->buf.backing_height =3D plane.height;
> > > >>       dmabuf->buf.stride =3D plane.stride;
> > > >>       dmabuf->buf.fourcc =3D plane.drm_format;
> > > >>       dmabuf->buf.modifier =3D plane.drm_format_mod;
> > > >
> > >
> >
> > I agree with what Kim said. Alex, are you sending a new patch?
>
> What would be different?
>
> struct vfio_device_gfx_plane_info {
>         __u32 argsz;
>         __u32 flags;
> #define VFIO_GFX_PLANE_TYPE_PROBE (1 << 0)
> #define VFIO_GFX_PLANE_TYPE_DMABUF (1 << 1)
> #define VFIO_GFX_PLANE_TYPE_REGION (1 << 2)
>         /* in */
>         __u32 drm_plane_type;   /* type of plane: DRM_PLANE_TYPE_* */
>         /* out */
>         __u32 drm_format;       /* drm format of plane */
>         __u64 drm_format_mod;   /* tiled mode */
>         __u32 width;    /* width of plane */
>         __u32 height;   /* height of plane */
>         __u32 stride;   /* stride of plane */
>         __u32 size;     /* size of plane in bytes, align on page*/
>         __u32 x_pos;    /* horizontal position of cursor plane */
>         __u32 y_pos;    /* vertical position of cursor plane*/
>         __u32 x_hot;    /* horizontal position of cursor hotspot */
>         __u32 y_hot;    /* vertical position of cursor hotspot */
>         union {
>                 __u32 region_index;     /* region index */
>                 __u32 dmabuf_id;        /* dma-buf id */
>         };
> };
>

Perhaps VFIO is missing extra infos to set the actual x/y/w/h
region(s) of the visible monitor(s). This could be an extra message. I
am not familiar with the kernel/driver side for this, perhaps it is
always guaranteed to be the whole plane (+0+0+w*h). In which case, we
simply to set the QemuDmabuf fields accordingly.

--=20
Marc-Andr=C3=A9 Lureau

