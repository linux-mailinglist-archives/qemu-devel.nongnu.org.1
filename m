Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B67BB7BCD42
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 10:51:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpPVJ-00015w-VT; Sun, 08 Oct 2023 04:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPVD-00015f-BZ
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:51:07 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPVB-0004Em-EY
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:51:07 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso612719766b.1
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 01:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696754944; x=1697359744;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6kpYtSVxGPaq22VAfKHfnfl/WA2xys5N+EHgkuFdi0=;
 b=V9sgauPRMauTojfOI8NmkYS7pc3lcG4dCPh3+VP5aML3kEsjaqt9HFS8peec00pA2F
 7dkO34tLXNwVO3Bcbnrk/Wj8rgu3lFjhY6yHFGPInEz1g9mqyUUReprJQGtUJO4FJkC9
 oloCwBUSHFr4D9khhjUwPbPOYvgwiS94JWct5btvnMYAQ50ZeWxHz2lY250lUa1Ohugr
 7rZyQkUAobID3vqjtDINv+vVKTbFv5LzoRse1CHUj6AB4YW/BF/pCNm1sMmg8TM5nyeS
 Ew8Tl5nFRm4qWwaIbWijHEjsy93dkgx8pG4LWAXrM7upH+WDnG0BdmR2ayUH466GZGnM
 2sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696754944; x=1697359744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6kpYtSVxGPaq22VAfKHfnfl/WA2xys5N+EHgkuFdi0=;
 b=OcX9OwkOXjN0g2pgMmC4KtVKxfRSZGKScnDuMA4KSkfjhtdpFOOGy4gaPTjqQqRWJg
 5IOYw2lvlTOgb1ZJj8mNkKzwKU7Tl6ixjf8XDEpOK5wRBkyBqQak877e+CpYWBel+Faw
 rXzRB4GGa+HMUjhWlTktii7V049ogncSGTRKdpVjPPjqU/LiKLbtQ/7AgAKnxghC0XBU
 AE/hIYDzIjr2+WqT2LcoNfEqaxRt0HmnQv+BqQAdg6faFiaeuGgiFGoCLXMKaX8M1+0+
 i0QEMPvDknPDCgBG/zMn8V73NVfhBKHzWgyxkmAEw9fe36FaM6JySkqvjwO48pumGEXu
 dGrw==
X-Gm-Message-State: AOJu0Yz30vH0OoG9tnusT5gJw8aNIEDOwSVPe3DDypbSBKBrasB5KZfA
 U6ANTs9iw9EonmXgKNDabd1pyhS5dc2NjETz6BF+ZA==
X-Google-Smtp-Source: AGHT+IHzQ4HlQLzv9yV20BOhmsEvreNP46RF7k8OP7h619cnuOjcnV6MC6UGOM94USTeOtBx7coEOr4dcTV63li3VJ4=
X-Received: by 2002:a17:906:301a:b0:9a5:b814:8254 with SMTP id
 26-20020a170906301a00b009a5b8148254mr11068603ejz.24.1696754943328; Sun, 08
 Oct 2023 01:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230922114625.5786-1-fengli@smartx.com>
 <20230922114625.5786-2-fengli@smartx.com>
 <D5AD3E2E-8C4B-4ADA-B054-B42E2B030808@nutanix.com>
In-Reply-To: <D5AD3E2E-8C4B-4ADA-B054-B42E2B030808@nutanix.com>
From: Li Feng <fengli@smartx.com>
Date: Sun, 8 Oct 2023 16:49:05 +0800
Message-ID: <CAHckoCxb3kgF_2cc6kb05v24Jes107MixquB2fYxcKePiSvUzg@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] vhost-user-common: send get_inflight_fd once
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::62c;
 envelope-from=fengli@smartx.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 29, 2023 at 8:55=E2=80=AFAM Raphael Norwitz
<raphael.norwitz@nutanix.com> wrote:
>
>
>
> > On Sep 22, 2023, at 7:46 AM, Li Feng <fengli@smartx.com> wrote:
> >
> > Currently the get_inflight_fd will be sent every time the device is sta=
rted, and
> > the backend will allocate shared memory to save the inflight state. If =
the
> > backend finds that it receives the second get_inflight_fd, it will rele=
ase the
> > previous shared memory, which breaks inflight working logic.
> >
> > This patch is a preparation for the following patches.
>
> This looks identical to the v3 patch I reviewed? If I=E2=80=99ve missed s=
omething can you please point it out?
Yes, nothing changed in this patch.

>
>
> > Signed-off-by: Li Feng <fengli@smartx.com>
> > ---
> > hw/scsi/vhost-scsi-common.c | 37 ++++++++++++++++++-------------------
> > 1 file changed, 18 insertions(+), 19 deletions(-)
> >
> > diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> > index a06f01af26..a61cd0e907 100644
> > --- a/hw/scsi/vhost-scsi-common.c
> > +++ b/hw/scsi/vhost-scsi-common.c
> > @@ -52,20 +52,28 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
> >
> >     vsc->dev.acked_features =3D vdev->guest_features;
> >
> > -    assert(vsc->inflight =3D=3D NULL);
> > -    vsc->inflight =3D g_new0(struct vhost_inflight, 1);
> > -    ret =3D vhost_dev_get_inflight(&vsc->dev,
> > -                                 vs->conf.virtqueue_size,
> > -                                 vsc->inflight);
> > +    ret =3D vhost_dev_prepare_inflight(&vsc->dev, vdev);
> >     if (ret < 0) {
> > -        error_report("Error get inflight: %d", -ret);
> > +        error_report("Error setting inflight format: %d", -ret);
> >         goto err_guest_notifiers;
> >     }
> >
> > -    ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
> > -    if (ret < 0) {
> > -        error_report("Error set inflight: %d", -ret);
> > -        goto err_guest_notifiers;
> > +    if (vsc->inflight) {
> > +        if (!vsc->inflight->addr) {
> > +            ret =3D vhost_dev_get_inflight(&vsc->dev,
> > +                                        vs->conf.virtqueue_size,
> > +                                        vsc->inflight);
> > +            if (ret < 0) {
> > +                error_report("Error getting inflight: %d", -ret);
> > +                goto err_guest_notifiers;
> > +            }
> > +        }
> > +
> > +        ret =3D vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
> > +        if (ret < 0) {
> > +            error_report("Error setting inflight: %d", -ret);
> > +            goto err_guest_notifiers;
> > +        }
> >     }
> >
> >     ret =3D vhost_dev_start(&vsc->dev, vdev, true);
> > @@ -85,9 +93,6 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
> >     return ret;
> >
> > err_guest_notifiers:
> > -    g_free(vsc->inflight);
> > -    vsc->inflight =3D NULL;
> > -
> >     k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
> > err_host_notifiers:
> >     vhost_dev_disable_notifiers(&vsc->dev, vdev);
> > @@ -111,12 +116,6 @@ void vhost_scsi_common_stop(VHostSCSICommon *vsc)
> >     }
> >     assert(ret >=3D 0);
> >
> > -    if (vsc->inflight) {
> > -        vhost_dev_free_inflight(vsc->inflight);
> > -        g_free(vsc->inflight);
> > -        vsc->inflight =3D NULL;
> > -    }
> > -
> >     vhost_dev_disable_notifiers(&vsc->dev, vdev);
> > }
> >
> > --
> > 2.41.0
> >
>

