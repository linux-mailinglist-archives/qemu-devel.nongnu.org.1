Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CC8791608
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:07:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd7Pj-0002s5-7M; Mon, 04 Sep 2023 07:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd7Pg-0002rF-Ud
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:06:36 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd7Pe-0005i2-C3
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:06:36 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4121788397fso8469541cf.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 04:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693825593; x=1694430393; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7XReZQPdaudyj4RLLvVl94xsQ/UOqjMskL7mlqHdVU=;
 b=rRosgT/CcV+u1n9OD/f8spdjnGoQT8HCTojfJ/kjzPBTfItHqRMG1PpBzsNZJy2aN4
 ztQneHePsx8/ZvE5dLfaP7W5UNs9Q+zj0DqyQ7o64uuS1M4uWMnQi6O+KPV2ceOlEUvC
 FPHoJTqC0S6+TnoPhUBzwNNl+oIFd5zaawwsmlJZRMRNQpuLkn5KZySiy0nsxdvbMrPd
 f5OOn7nmorgt++YzYOtx9CK4CQd1pdfvGLBGgDvcwy53A9vwjAU9FGBNJ9rD3+POP3WQ
 lnkX5R9YUFnIYhBowlSmln3CZ5QJS+MTyFbRXxswJENDy2jeXiFgtiBh19V5739PPoGG
 ap3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693825593; x=1694430393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7XReZQPdaudyj4RLLvVl94xsQ/UOqjMskL7mlqHdVU=;
 b=mERXqcnVAhIK1muRbZ7J4sWBHBkliQG6SYC86x6AIS0V6WB0Mn5p2zK/88/gibipf8
 3JAbcPRw2zF8sU/5jHk3zIJY5uQnAN9jcleeqoSNrs1RUU53PF6DVvyx/Knf+gKpPJTH
 UEAPP67HYGdwjeau4KviL3J2a7xvUJ2KA2SB7T5ItTrJT71dCD9hl/flUr/Nz36cOnlq
 bkX0M+AXlFhahE8RBzPN4iI9x7icDPk81nNeEqI3z/rKxJKpLsLf/jowxNaScenbNIkW
 rU93krzpnRiOCuLhFwzcZYTeRdiOzJye/em78beV3y7jEtOqacW5oFnBcqFwjVpxnClz
 2vGw==
X-Gm-Message-State: AOJu0YwGroSGy4u86iWLyWnDftdP22M6RxmnRC3cFmk8Oa3K2CKPziFa
 N3yd1+S9Rq9U2zn84n5UyKs2H0lppmpz5X71hvU=
X-Google-Smtp-Source: AGHT+IEru+B1dZ+NuCFbSjfRAcgUkpfQat395eukERQa35UepHo+IYStM1MA3ytETdv06WMkYBCfwgBmdXrJ5IPpIFU=
X-Received: by 2002:a05:622a:4d1:b0:3f9:aa80:b48a with SMTP id
 q17-20020a05622a04d100b003f9aa80b48amr13950780qtx.8.1693825593251; Mon, 04
 Sep 2023 04:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230816215550.1723696-1-alex.williamson@redhat.com>
 <a3a6f8ec-ca61-4472-45b4-1077dd27bb52@linaro.org>
 <acddfb4a-fe42-ba8c-e920-edc7e9ff5268@intel.com>
In-Reply-To: <acddfb4a-fe42-ba8c-e920-edc7e9ff5268@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Sep 2023 15:06:21 +0400
Message-ID: <CAJ+F1C+YiDgRuyWcGeUPhaNO4SdjOSFSHKBY1wBS3dJFLO-k2w@mail.gmail.com>
Subject: Re: [PATCH for-8.1] vfio/display: Fix missing update to set backing
 fields
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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

On Thu, Aug 17, 2023 at 8:29=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.com=
> wrote:
>
> Ok, this regression happened not just because of renaming. Originally
> width and height were representing the size of whole surface that guest
> shares while scanout width and height are for the each scanout. We
> realized backing_width/height are more commonly used to specify the size
> of the whole guest surface so put them in the place of width/height then
> replaced scanout_width/height as well with normal width/height.
>
> On 8/16/2023 3:31 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 16/8/23 23:55, Alex Williamson wrote:
> >> The below referenced commit renames scanout_width/height to
> >> backing_width/height, but also promotes these fields in various portio=
ns
> >> of the egl interface.  Meanwhile vfio dmabuf support has never used th=
e
> >> previous scanout fields and is therefore missed in the update. This
> >> results in a black screen when transitioning from ramfb to dmabuf
> >> display
> >> when using Intel vGPU with these features.
> >
> > Referenced commit isn't trivial. Maybe because it is too late here.
> > I'd have tried to split it. Anyhow, too late (again).
> >
> > Is vhost-user-gpu also affected? (see VHOST_USER_GPU_DMABUF_SCANOUT
> > in vhost_user_gpu_handle_display()).
>
> Yeah, backing_width/height should be programmed with plane.width/height
> as well in vhost_user_gpu_handle_display().
>
> Link: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg02726.html
> >> Fixes: 9ac06df8b684 ("virtio-gpu-udmabuf: correct naming of
> >> QemuDmaBuf size properties")
> >> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> >> ---
> >>
> >> This fixes a regression in dmabuf/EGL support for Intel GVT-g and
> >> potentially the mbochs mdev driver as well.  Once validated by those
> >> that understand dmabuf/EGL integration, I'd welcome QEMU maintainers t=
o
> >> take this directly for v8.1 or queue it as soon as possible for v8.1.1=
.
> >>
> >>   hw/vfio/display.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> >> index bec864f482f4..837d9e6a309e 100644
> >> --- a/hw/vfio/display.c
> >> +++ b/hw/vfio/display.c
> >> @@ -243,6 +243,8 @@ static VFIODMABuf
> >> *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
> >>       dmabuf->dmabuf_id  =3D plane.dmabuf_id;
> >>       dmabuf->buf.width  =3D plane.width;
> >>       dmabuf->buf.height =3D plane.height;
>
> One thing to note here is the normal width and height in the QemuDmaBuf
> are of a scanout, which could be just a partial area of the guest plane
> here. So we should not use those as normal width and height of the
> QemuDmaBuf unless it is guaranteed the given guest surface (plane in
> this case) is always of single display's.
>
> https://lists.gnu.org/archive/html/qemu-devel/2021-09/msg04737.html
>
> >> +    dmabuf->buf.backing_width =3D plane.width;
> >> +    dmabuf->buf.backing_height =3D plane.height;
> >>       dmabuf->buf.stride =3D plane.stride;
> >>       dmabuf->buf.fourcc =3D plane.drm_format;
> >>       dmabuf->buf.modifier =3D plane.drm_format_mod;
> >
>

I agree with what Kim said. Alex, are you sending a new patch?
thanks

--=20
Marc-Andr=C3=A9 Lureau

