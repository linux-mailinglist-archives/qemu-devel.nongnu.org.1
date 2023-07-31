Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EA8768F98
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 10:06:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNuS-0005lo-7F; Mon, 31 Jul 2023 04:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qQNuQ-0005lD-KY
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qQNuO-0006Ns-Ri
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690790739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3B1viCt1VnT6k3aBfhXSmVvLPxLPFX6yaDucjUzVjY=;
 b=TFlsBEtCud2c83B4TxKX0c2dfy9F8P1fnn2ToJTe4Wt4V7J5dfoKy2Ic6gwBDc34b3r5qq
 Z9pukfQBj0Z5nxiMlhGE/w/2TnuH6BqMPZqCmGEHt19B6dqBlcrNn37Xm62fE1S2ITNQtr
 2M21Gh4NDPix3GAV5xDgi0K0pJaaeqc=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-8sgIwglmMRa_k-xSX1SKAg-1; Mon, 31 Jul 2023 04:05:37 -0400
X-MC-Unique: 8sgIwglmMRa_k-xSX1SKAg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-d074da73c3eso3579076276.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 01:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690790736; x=1691395536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K3B1viCt1VnT6k3aBfhXSmVvLPxLPFX6yaDucjUzVjY=;
 b=TgcDfImtYZaePClbIpQ9RWqN6WE6z2QjUPmGkqTep4aAzbwcwepnV2KYflBeIB/4XU
 fOfsYW+3OgfcxElgANgUZpKxB9Bi88KOk75VAqHYoaPzgdWyMdqvH1oUwqexeIYM7+fu
 w4KffUqk8fYKGNJ05ckPpSLBW02ADI/dilX8dsIFNv0/akvzgysR6Lau0F5dOIdfBOuw
 xPufnhQ+M161/gl7y6Eahik9JPfLzL6e+IEpUdse9C9o7FqKwlMwxpe8pEwH3fXCDkvM
 C/WJlHUpqNLRJ6Ji1/RrZs4NPee4GZ3LVpOXgWVeKL7WHPCM4Fd7zgyaFcvFoVVqIOAB
 aF3w==
X-Gm-Message-State: ABy/qLaVSVkZPGtDlX09ES9h2bEtsP2e7diJ/RiNgg/ucPtGivUoqFxh
 JfPxD/4qxStyxzieygpbm4htsES+13RalONlqdvVzjx0jOasKl/1HMXItoejV2AOJCxo0UrJhcT
 4Ygs7qx+slemoZxj6P4XH10emS3YBIkc=
X-Received: by 2002:a25:abe3:0:b0:d01:52da:9625 with SMTP id
 v90-20020a25abe3000000b00d0152da9625mr6909944ybi.13.1690790736163; 
 Mon, 31 Jul 2023 01:05:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGqvxvo5Q1SB3jGGGCs91UnlnRr2HTkNeIi4mzBc/odBTvNoUqtMrMEWCMn5MXXufL8HzwmtyNF8KeeraeVrgI=
X-Received: by 2002:a25:abe3:0:b0:d01:52da:9625 with SMTP id
 v90-20020a25abe3000000b00d0152da9625mr6909932ybi.13.1690790735890; Mon, 31
 Jul 2023 01:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230725182143.1523091-1-eperezma@redhat.com>
 <CACGkMEsqbZNGKdK1kM-qQeZShNeonQKK4_65vtCueQxUsRFTsQ@mail.gmail.com>
 <CAJaqyWeCNdmZX_iNywHxiD3fG39k5bRPOD2U13cmevbcUct+hA@mail.gmail.com>
 <CACGkMEv4HNw-Fqsdn+BmzjrWsbxG4rR=kqYPS5kX41D-r=sUow@mail.gmail.com>
In-Reply-To: <CACGkMEv4HNw-Fqsdn+BmzjrWsbxG4rR=kqYPS5kX41D-r=sUow@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 31 Jul 2023 10:04:59 +0200
Message-ID: <CAJaqyWeLm6o7ikrgCa5kmEHXqXniFvvsDGd8uQwOVHL9qiqwWQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: set old virtio status at cvq isolation probing end
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, si-wei.liu@oracle.com, qemu-stable@nongnu.org, 
 Hawkins Jiawei <yin31149@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 31, 2023 at 8:36=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jul 26, 2023 at 2:27=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Wed, Jul 26, 2023 at 4:07=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Jul 26, 2023 at 2:21=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > The device already has a virtio status set by vhost_vdpa_init by th=
e
> > > > time vhost_vdpa_probe_cvq_isolation is called. vhost_vdpa_init set
> > > > S_ACKNOWLEDGE and S_DRIVER, so it is invalid to just reset it.
> > > >
> > > > It is invalid to start the device after it, but all devices seems t=
o be
> > > > fine with it.  Fixing qemu so it follows virtio start procedure.
> > > >
> > > > Fixes: 152128d64697 ("vdpa: move CVQ isolation check to net_init_vh=
ost_vdpa")
> > > > Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > >  net/vhost-vdpa.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > > index 9795306742..d7e2b714b4 100644
> > > > --- a/net/vhost-vdpa.c
> > > > +++ b/net/vhost-vdpa.c
> > > > @@ -1333,6 +1333,8 @@ static int vhost_vdpa_probe_cvq_isolation(int=
 device_fd, uint64_t features,
> > > >  out:
> > > >      status =3D 0;
> > > >      ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> > > > +    status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVE=
R;
> > > > +    ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> > >
> > > So if we fail after FEATURES_OK, this basically clears that bit. Spec
> > > doesn't say it can or not, I wonder if a reset is better?
> > >
> >
> > I don't follow this, the reset is just above the added code, isn't it?
>
> I meant for error path:
>
> E.g:
>     uint8_t status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE |
>                      VIRTIO_CONFIG_S_DRIVER |
>                      VIRTIO_CONFIG_S_FEATURES_OK;
> ...
>     r =3D ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> ....
>         if (cvq_group !=3D -ENOTSUP) {
>             r =3D cvq_group;
>             goto out;
>         }
>
> out:
>     status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER;
>     ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
>
> We're basically clearing FEATURES_OK?
>

Yes, it is the state that previous functions (vhost_vdpa_init) set. We
need to leave it that way, either if the backend supports cvq
isolation or not, or in the case of an error. Not doing that way makes
vhost_dev_start (and vhost_vdpa_set_features) set the features before
setting VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER.
Otherwise, the guest can (and do) access to config space before
_S_ACKNOWLEDGE | _S_DRIVER.


> >
> > > Btw, spec requires a read of status after setting FEATURES_OK, this
> > > seems to be missed in the current code.
> > >
> >
> > I'm ok with that, but this patch does not touch that part.
> >
> > To fix this properly we should:
> > - Expose vhost_vdpa_set_dev_features_fd as we did in previous versions
> > of the series that added vhost_vdpa_probe_cvq_isolation [1].
> > - Get status after vhost_vdpa_add_status, so both vhost start code and
> > this follows the standard properly.
> >
> > Is it ok to do these on top of this patch?
>
> Fine.
>
> Thanks
>
> >
> > Thanks!
> >
> > [1] https://lore.kernel.org/qemu-devel/20230509154435.1410162-4-eperezm=
a@redhat.com/
> >
> >
> > > Thanks
> > >
> > > >      return r;
> > > >  }
> > > >
> > > > --
> > > > 2.39.3
> > > >
> > >
> >
>


