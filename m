Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD5A7BCD65
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 10:55:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpPZR-0003Aq-I3; Sun, 08 Oct 2023 04:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPZA-0003Ae-4z
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:55:12 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPZ7-0005Ip-4U
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:55:11 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so783094966b.0
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696755186; x=1697359986;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tsc/LOndVtU5h8z65qr/wQukB/YrdB/bUR5UjJjWnZo=;
 b=so91hpzM9N9J2h/KHNmZNs5GlY3uU9DUr1DHhcGUt/XPWy3YmWZS/JRBydYiO1MB9O
 Tp/g4+zqATNLKlx87vfwurCl44APcz319XKpBZvVdlixvoNvVktWBFBTKdeILxq9zy/Z
 XXQjjJvBVS2yOfVR5FlTYBgwKCeL11KsFnB0FvwQicu9qyW1sEpS+jG4Q7qhVwprTSNJ
 alPo6RfVl//JGbnyC3LT6XS9LkD78pYcOaZyNFNspMtFSgJwj7SXFaIRU/sdcLiCVRU9
 fsebz/zjwiFwAerou2LWsP9X/tA9lyeDRXxeB5/ybnF26iVNmEwBUfe1slAbFAT2qdRH
 FtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696755186; x=1697359986;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tsc/LOndVtU5h8z65qr/wQukB/YrdB/bUR5UjJjWnZo=;
 b=aukirzTjOnI4RssGT8hXg7ZJd9h0VJ/2sqBow56ROPUirqac5CnXswwxEmg9SZIvAa
 YUR3N/A/dLBHMvn1Juw+tAaaDKIHF7TSZOxgVD0iuQGwlleVP0gZ6LsDa+nG2VGkU9GI
 cwFX9NB9pTo+owLqxVrQnPipS3dmYfO73BvlCR0q3wXk+s2gKd49Lu+vu/RYdxse0x5a
 vuQFqJrKh/zQS34OKY5VkV1M5uC70igBEHShxWwVz5RzxefrHIqazjxpFOKiqqgnvOal
 I0BHA5HqNnSl9mridC/q/vCGePRGYg2UxuHlJzAPrkDszfTgsEpGofaufZtpbxcyUizD
 2wOA==
X-Gm-Message-State: AOJu0YymgBYQrvgvu/9SfgW//wlMa5AjK6mNO6YSj4+E9b7/fJURivH5
 yXaEHsv6fIpNWkTqYyxhPaugIOarECFa2/DMgtxPBA==
X-Google-Smtp-Source: AGHT+IEpLlSCA0NHWW5iWuqLzq53T2A1wpVBuDpZK5Gaayqm6Gv9ywKbd2VQf48yu9rGSsioy7876nUvyFq1DToAaek=
X-Received: by 2002:a17:907:808:b0:9b2:cee1:1f82 with SMTP id
 wv8-20020a170907080800b009b2cee11f82mr7073439ejb.7.1696755186271; Sun, 08 Oct
 2023 01:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230922114625.5786-1-fengli@smartx.com>
 <20230922114625.5786-2-fengli@smartx.com>
 <D5AD3E2E-8C4B-4ADA-B054-B42E2B030808@nutanix.com>
 <CAHckoCxb3kgF_2cc6kb05v24Jes107MixquB2fYxcKePiSvUzg@mail.gmail.com>
 <20231008044946-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231008044946-mutt-send-email-mst@kernel.org>
From: Li Feng <fengli@smartx.com>
Date: Sun, 8 Oct 2023 16:53:08 +0800
Message-ID: <CAHckoCyjJ-r_YajOz7s_w_L1miLEQWqdAq+rGVzhnxVmonbQtw@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] vhost-user-common: send get_inflight_fd once
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Markus Armbruster <armbru@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::630;
 envelope-from=fengli@smartx.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Oct 8, 2023 at 4:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sun, Oct 08, 2023 at 04:49:05PM +0800, Li Feng wrote:
> > On Fri, Sep 29, 2023 at 8:55=E2=80=AFAM Raphael Norwitz
> > <raphael.norwitz@nutanix.com> wrote:
> > >
> > >
> > >
> > > > On Sep 22, 2023, at 7:46 AM, Li Feng <fengli@smartx.com> wrote:
> > > >
> > > > Currently the get_inflight_fd will be sent every time the device is=
 started, and
> > > > the backend will allocate shared memory to save the inflight state.=
 If the
> > > > backend finds that it receives the second get_inflight_fd, it will =
release the
> > > > previous shared memory, which breaks inflight working logic.
> > > >
> > > > This patch is a preparation for the following patches.
> > >
> > > This looks identical to the v3 patch I reviewed? If I=E2=80=99ve miss=
ed something can you please point it out?
> > Yes, nothing changed in this patch.
>
>
> Then you should include tags such as reviewed/acked by for previous
> version. if you drop tags you indicate to people they have to
> re-review.
> also, mentioning which patches changed in the cover letter is
> a courtesy to reviewers.
OK.

>
> > >
> > >
> > > > Signed-off-by: Li Feng <fengli@smartx.com>
> > > > ---
> > > > hw/scsi/vhost-scsi-common.c | 37 ++++++++++++++++++----------------=
---
> > > > 1 file changed, 18 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-commo=
n.c
> > > > index a06f01af26..a61cd0e907 100644
> > > > --- a/hw/scsi/vhost-scsi-common.c
> > > > +++ b/hw/scsi/vhost-scsi-common.c
> > > > @@ -52,20 +52,28 @@ int vhost_scsi_common_start(VHostSCSICommon *vs=
c)
> > > >
> > > >     vsc->dev.acked_features =3D vdev->guest_features;
> > > >
> > > > -    assert(vsc->inflight =3D=3D NULL);
> > > > -    vsc->inflight =3D g_new0(struct vhost_inflight, 1);
> > > > -    ret =3D vhost_dev_get_inflight(&vsc->dev,
> > > > -                                 vs->conf.virtqueue_size,
> > > > -                                 vsc->inflight);
> > > > +    ret =3D vhost_dev_prepare_inflight(&vsc->dev, vdev);
> > > >     if (ret < 0) {
> > > > -        error_report("Error get inflight: %d", -ret);
> > > > +        error_report("Error setting inflight format: %d", -ret);
> > > >         goto err_guest_notifiers;
> > > >     }
> > > >
> > > > -    ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
> > > > -    if (ret < 0) {
> > > > -        error_report("Error set inflight: %d", -ret);
> > > > -        goto err_guest_notifiers;
> > > > +    if (vsc->inflight) {
> > > > +        if (!vsc->inflight->addr) {
> > > > +            ret =3D vhost_dev_get_inflight(&vsc->dev,
> > > > +                                        vs->conf.virtqueue_size,
> > > > +                                        vsc->inflight);
> > > > +            if (ret < 0) {
> > > > +                error_report("Error getting inflight: %d", -ret);
> > > > +                goto err_guest_notifiers;
> > > > +            }
> > > > +        }
> > > > +
> > > > +        ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
> > > > +        if (ret < 0) {
> > > > +            error_report("Error setting inflight: %d", -ret);
> > > > +            goto err_guest_notifiers;
> > > > +        }
> > > >     }
> > > >
> > > >     ret =3D vhost_dev_start(&vsc->dev, vdev, true);
> > > > @@ -85,9 +93,6 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
> > > >     return ret;
> > > >
> > > > err_guest_notifiers:
> > > > -    g_free(vsc->inflight);
> > > > -    vsc->inflight =3D NULL;
> > > > -
> > > >     k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
> > > > err_host_notifiers:
> > > >     vhost_dev_disable_notifiers(&vsc->dev, vdev);
> > > > @@ -111,12 +116,6 @@ void vhost_scsi_common_stop(VHostSCSICommon *v=
sc)
> > > >     }
> > > >     assert(ret >=3D 0);
> > > >
> > > > -    if (vsc->inflight) {
> > > > -        vhost_dev_free_inflight(vsc->inflight);
> > > > -        g_free(vsc->inflight);
> > > > -        vsc->inflight =3D NULL;
> > > > -    }
> > > > -
> > > >     vhost_dev_disable_notifiers(&vsc->dev, vdev);
> > > > }
> > > >
> > > > --
> > > > 2.41.0
> > > >
> > >
>

