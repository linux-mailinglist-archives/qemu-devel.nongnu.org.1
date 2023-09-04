Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2E679197E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:12:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAIq-0007Kc-0Z; Mon, 04 Sep 2023 10:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qdAIl-0007KH-93
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qdAIi-0002Nq-JU
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693836693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5IGZNp0VSnxBuZS8Zt4S0mX7v7XYANR/mB2vF8dlU90=;
 b=DprZeXloLv4MJYAyCAvPPmL2dDsyKp9f4EUBCibwygpUtQeTIIHrAd59ivHnvHRsl0itGD
 gptr6KY9RhLvcpZtdjGE4rcPbBjZinkCp3IvkmwbhxxlfkE92rJxf+L/48b/kXOkElpqLX
 bfCFUTCwzLpowQQH+VpWrZOQgN+CBHA=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-W8IWbyRZPJKS9IUG6h6BHw-1; Mon, 04 Sep 2023 10:11:32 -0400
X-MC-Unique: W8IWbyRZPJKS9IUG6h6BHw-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-34deff589bbso10026835ab.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 07:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693836691; x=1694441491;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5IGZNp0VSnxBuZS8Zt4S0mX7v7XYANR/mB2vF8dlU90=;
 b=HxhWONPO133iKNkUPcZJycsiqJ39UCbiSTq/0gvpYHRwIrmpq4E53S88/ZxI8MWV6Q
 /IkMpqV3Er1tS57h1T13RUeS/dBLautWFomRNIizKDqX/Ek2+NwJgNsLUM81//2LCiC2
 xvH0Pd02cCGjbnJdkdopoRtGFnyfWm080hXZAvd7bfJ3uRiAhCh9of0bayhQRmQKrFVI
 OswvAk0cBkTr4LsyqIqeTL8Nav/lJR4QBGQy1xk63L/iMoW1zFMNpw1UPww4hB3P5etX
 Y/uQ8WDYhp+98sNHiqzplcjzj/QsU4cf5ljvuhr7DBadZ1G/k+505qSQ0sn02w0zgjaS
 BDTQ==
X-Gm-Message-State: AOJu0Ywziv36CxsBem/UHbFyZQVJhHRC9hqCIkeTT/mrDfHQ08s3+O1w
 H4KWfJTQqOhXKf5XDfphuBePS1U9/yfA6GKF0U+rOa9SWdxCQcR052N26ttkJQxYz29lOdhQk1L
 ibpx6+OpUOu1oNhE=
X-Received: by 2002:a92:c20e:0:b0:34c:e4c6:c522 with SMTP id
 j14-20020a92c20e000000b0034ce4c6c522mr9630841ilo.27.1693836691474; 
 Mon, 04 Sep 2023 07:11:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjj3HmA2Cmf8lH0Qo/M4oKhlb9aG5POFMuISggaRfYaJ9ABKJrE5At7BFV7/6lcxHxFwEuWQ==
X-Received: by 2002:a92:c20e:0:b0:34c:e4c6:c522 with SMTP id
 j14-20020a92c20e000000b0034ce4c6c522mr9630819ilo.27.1693836691195; 
 Mon, 04 Sep 2023 07:11:31 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 c4-20020a92dc84000000b003493fcfaef1sm3349756iln.67.2023.09.04.07.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:11:30 -0700 (PDT)
Date: Mon, 4 Sep 2023 08:11:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: "Kim, Dongwon" <dongwon.kim@intel.com>, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com
Subject: Re: [PATCH for-8.1] vfio/display: Fix missing update to set backing
 fields
Message-ID: <20230904081129.3908c083.alex.williamson@redhat.com>
In-Reply-To: <CAJ+F1C+YiDgRuyWcGeUPhaNO4SdjOSFSHKBY1wBS3dJFLO-k2w@mail.gmail.com>
References: <20230816215550.1723696-1-alex.williamson@redhat.com>
 <a3a6f8ec-ca61-4472-45b4-1077dd27bb52@linaro.org>
 <acddfb4a-fe42-ba8c-e920-edc7e9ff5268@intel.com>
 <CAJ+F1C+YiDgRuyWcGeUPhaNO4SdjOSFSHKBY1wBS3dJFLO-k2w@mail.gmail.com>
Organization: Red Hat
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 4 Sep 2023 15:06:21 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Thu, Aug 17, 2023 at 8:29=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.c=
om> wrote:
> >
> > Ok, this regression happened not just because of renaming. Originally
> > width and height were representing the size of whole surface that guest
> > shares while scanout width and height are for the each scanout. We
> > realized backing_width/height are more commonly used to specify the size
> > of the whole guest surface so put them in the place of width/height then
> > replaced scanout_width/height as well with normal width/height.
> >
> > On 8/16/2023 3:31 PM, Philippe Mathieu-Daud=C3=A9 wrote: =20
> > > On 16/8/23 23:55, Alex Williamson wrote: =20
> > >> The below referenced commit renames scanout_width/height to
> > >> backing_width/height, but also promotes these fields in various port=
ions
> > >> of the egl interface.  Meanwhile vfio dmabuf support has never used =
the
> > >> previous scanout fields and is therefore missed in the update. This
> > >> results in a black screen when transitioning from ramfb to dmabuf
> > >> display
> > >> when using Intel vGPU with these features. =20
> > >
> > > Referenced commit isn't trivial. Maybe because it is too late here.
> > > I'd have tried to split it. Anyhow, too late (again).
> > >
> > > Is vhost-user-gpu also affected? (see VHOST_USER_GPU_DMABUF_SCANOUT
> > > in vhost_user_gpu_handle_display()). =20
> >
> > Yeah, backing_width/height should be programmed with plane.width/height
> > as well in vhost_user_gpu_handle_display().
> >
> > Link: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg02726.ht=
ml =20
> > >> Fixes: 9ac06df8b684 ("virtio-gpu-udmabuf: correct naming of
> > >> QemuDmaBuf size properties")
> > >> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > >> ---
> > >>
> > >> This fixes a regression in dmabuf/EGL support for Intel GVT-g and
> > >> potentially the mbochs mdev driver as well.  Once validated by those
> > >> that understand dmabuf/EGL integration, I'd welcome QEMU maintainers=
 to
> > >> take this directly for v8.1 or queue it as soon as possible for v8.1=
.1.
> > >>
> > >>   hw/vfio/display.c | 2 ++
> > >>   1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> > >> index bec864f482f4..837d9e6a309e 100644
> > >> --- a/hw/vfio/display.c
> > >> +++ b/hw/vfio/display.c
> > >> @@ -243,6 +243,8 @@ static VFIODMABuf
> > >> *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
> > >>       dmabuf->dmabuf_id  =3D plane.dmabuf_id;
> > >>       dmabuf->buf.width  =3D plane.width;
> > >>       dmabuf->buf.height =3D plane.height; =20
> >
> > One thing to note here is the normal width and height in the QemuDmaBuf
> > are of a scanout, which could be just a partial area of the guest plane
> > here. So we should not use those as normal width and height of the
> > QemuDmaBuf unless it is guaranteed the given guest surface (plane in
> > this case) is always of single display's.
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2021-09/msg04737.html
> > =20
> > >> +    dmabuf->buf.backing_width =3D plane.width;
> > >> +    dmabuf->buf.backing_height =3D plane.height;
> > >>       dmabuf->buf.stride =3D plane.stride;
> > >>       dmabuf->buf.fourcc =3D plane.drm_format;
> > >>       dmabuf->buf.modifier =3D plane.drm_format_mod; =20
> > > =20
> > =20
>=20
> I agree with what Kim said. Alex, are you sending a new patch?

What would be different?

struct vfio_device_gfx_plane_info {
        __u32 argsz;
        __u32 flags;
#define VFIO_GFX_PLANE_TYPE_PROBE (1 << 0)
#define VFIO_GFX_PLANE_TYPE_DMABUF (1 << 1)
#define VFIO_GFX_PLANE_TYPE_REGION (1 << 2)
        /* in */
        __u32 drm_plane_type;   /* type of plane: DRM_PLANE_TYPE_* */
        /* out */
        __u32 drm_format;       /* drm format of plane */
        __u64 drm_format_mod;   /* tiled mode */
        __u32 width;    /* width of plane */
        __u32 height;   /* height of plane */
        __u32 stride;   /* stride of plane */
        __u32 size;     /* size of plane in bytes, align on page*/
        __u32 x_pos;    /* horizontal position of cursor plane */
        __u32 y_pos;    /* vertical position of cursor plane*/
        __u32 x_hot;    /* horizontal position of cursor hotspot */
        __u32 y_hot;    /* vertical position of cursor hotspot */
        union {
                __u32 region_index;     /* region index */
                __u32 dmabuf_id;        /* dma-buf id */
        };
};

Thanks,
Alex


