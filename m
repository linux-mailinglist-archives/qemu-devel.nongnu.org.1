Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C776A77D
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 05:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQg3a-0008Sn-5T; Mon, 31 Jul 2023 23:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qQg3Y-0008Pk-Oj
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 23:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qQg3V-00012e-Do
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 23:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690860496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2EVcACqhFyK2djPO0VTOxVsXuz9Ai2XkUZ4jZ3RjYA=;
 b=YG6XEmIqv1uW3XAzFyczMIwr/QgXayO0LZ0QTCfS6w1iU6PaXfQNTruQiJctvBBEu3o57/
 2nS+zyk8/lw3NsWtRu7Eau17i+O5Wj8FCWEdqHAYIzkd9qKgMUvwaG+0fQO/A3sChb4Za3
 PSVWR8dzKW46jeUCZg4r/m0nIdP75cM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-MBlmOS9YNlSodg4P6Hke8w-1; Mon, 31 Jul 2023 23:28:13 -0400
X-MC-Unique: MBlmOS9YNlSodg4P6Hke8w-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b9b1a21b93so46746491fa.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 20:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690860491; x=1691465291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q2EVcACqhFyK2djPO0VTOxVsXuz9Ai2XkUZ4jZ3RjYA=;
 b=hn22ThjQLml/896+cYV/vPi42kel7AqZHHPqFedLbD8c0Nsk2sITOycSewt3D805b7
 tgOLHn/V3p+Yn1eDgxRi2GFk3vXAYvCRFWJR8P+yZiyQ10iqgxNRMng4br/5+dUrYsZW
 zUXW5+LdUqJaSJ6/bN9wEMbl8pmsteQZU21Z5r/HtAyjF57ykG7L9hwksdXG3RfKlE5k
 dIItZH8geAKtaA6J5kHqV1ZQb0rM0pshAJCdnbXANOEa2Wctzig5Z6LqZYlH8WHyYSJn
 GqLJbHTmaSPugoDjiBwsqnIdSe+ALzhwYob2ttcNSC9u8Uag/usP+EQQGz5/TZtuD1Yj
 9LpA==
X-Gm-Message-State: ABy/qLbw8K4H1IAYZTwQXR8TtXIFLpeYCU3agQAGrrKs16WBWKpVXQVs
 +kDo7g8sZY6TXlfzoKS8dp2uEbw119iNJsK5mmvJqEQwPm76UOJ8urbWankCGw1xXLG0ahaIe20
 zvJ5w7yex3TPVkMOfSFGjYdiYz5n14UI=
X-Received: by 2002:a05:651c:10d1:b0:2b9:cce3:a126 with SMTP id
 l17-20020a05651c10d100b002b9cce3a126mr1413964ljn.21.1690860491703; 
 Mon, 31 Jul 2023 20:28:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHp4KG9M2bC3qr+2prZIOxhm810gxMG7GKm0yZ0oH/KsPPaxXC9b695OVDtoIBVZN4GdCUM9bi1JQBKKN7YMgw=
X-Received: by 2002:a05:651c:10d1:b0:2b9:cce3:a126 with SMTP id
 l17-20020a05651c10d100b002b9cce3a126mr1413956ljn.21.1690860491366; Mon, 31
 Jul 2023 20:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230725182143.1523091-1-eperezma@redhat.com>
 <CACGkMEsqbZNGKdK1kM-qQeZShNeonQKK4_65vtCueQxUsRFTsQ@mail.gmail.com>
 <CAJaqyWeCNdmZX_iNywHxiD3fG39k5bRPOD2U13cmevbcUct+hA@mail.gmail.com>
 <CACGkMEv4HNw-Fqsdn+BmzjrWsbxG4rR=kqYPS5kX41D-r=sUow@mail.gmail.com>
 <CAJaqyWeLm6o7ikrgCa5kmEHXqXniFvvsDGd8uQwOVHL9qiqwWQ@mail.gmail.com>
 <CACGkMEswqFZzgv2TH8ggx2upB5-xewSPMt_wk4Kpr+YLffnJwg@mail.gmail.com>
 <CAJaqyWcKUNhjLS6oz-Lfsa8j0prBhmOOsHz9wpfp90YPTeQBNw@mail.gmail.com>
In-Reply-To: <CAJaqyWcKUNhjLS6oz-Lfsa8j0prBhmOOsHz9wpfp90YPTeQBNw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Aug 2023 11:28:00 +0800
Message-ID: <CACGkMEsk+xd1iYDW7qQZO+GY-cj1J3ad9r0MOfSMsRFRHLWXXg@mail.gmail.com>
Subject: Re: [PATCH] vdpa: set old virtio status at cvq isolation probing end
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, si-wei.liu@oracle.com, qemu-stable@nongnu.org, 
 Hawkins Jiawei <yin31149@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 31, 2023 at 5:41=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Jul 31, 2023 at 10:42=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Mon, Jul 31, 2023 at 4:05=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Mon, Jul 31, 2023 at 8:36=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Wed, Jul 26, 2023 at 2:27=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Wed, Jul 26, 2023 at 4:07=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Wed, Jul 26, 2023 at 2:21=E2=80=AFAM Eugenio P=C3=A9rez <epe=
rezma@redhat.com> wrote:
> > > > > > >
> > > > > > > The device already has a virtio status set by vhost_vdpa_init=
 by the
> > > > > > > time vhost_vdpa_probe_cvq_isolation is called. vhost_vdpa_ini=
t set
> > > > > > > S_ACKNOWLEDGE and S_DRIVER, so it is invalid to just reset it=
.
> > > > > > >
> > > > > > > It is invalid to start the device after it, but all devices s=
eems to be
> > > > > > > fine with it.  Fixing qemu so it follows virtio start procedu=
re.
> > > > > > >
> > > > > > > Fixes: 152128d64697 ("vdpa: move CVQ isolation check to net_i=
nit_vhost_vdpa")
> > > > > > > Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > ---
> > > > > > >  net/vhost-vdpa.c | 2 ++
> > > > > > >  1 file changed, 2 insertions(+)
> > > > > > >
> > > > > > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > > > > > index 9795306742..d7e2b714b4 100644
> > > > > > > --- a/net/vhost-vdpa.c
> > > > > > > +++ b/net/vhost-vdpa.c
> > > > > > > @@ -1333,6 +1333,8 @@ static int vhost_vdpa_probe_cvq_isolati=
on(int device_fd, uint64_t features,
> > > > > > >  out:
> > > > > > >      status =3D 0;
> > > > > > >      ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> > > > > > > +    status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S=
_DRIVER;
> > > > > > > +    ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> > > > > >
> > > > > > So if we fail after FEATURES_OK, this basically clears that bit=
. Spec
> > > > > > doesn't say it can or not, I wonder if a reset is better?
> > > > > >
> > > > >
> > > > > I don't follow this, the reset is just above the added code, isn'=
t it?
> > > >
> > > > I meant for error path:
> > > >
> > > > E.g:
> > > >     uint8_t status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE |
> > > >                      VIRTIO_CONFIG_S_DRIVER |
> > > >                      VIRTIO_CONFIG_S_FEATURES_OK;
> > > > ...
> > > >     r =3D ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> > > > ....
> > > >         if (cvq_group !=3D -ENOTSUP) {
> > > >             r =3D cvq_group;
> > > >             goto out;
> > > >         }
> > > >
> > > > out:
> > > >     status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER=
;
> > > >     ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> > > >
> > > > We're basically clearing FEATURES_OK?
> > > >
> > >
> > > Yes, it is the state that previous functions (vhost_vdpa_init) set. W=
e
> > > need to leave it that way, either if the backend supports cvq
> > > isolation or not, or in the case of an error. Not doing that way make=
s
> > > vhost_dev_start (and vhost_vdpa_set_features) set the features before
> > > setting VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER.
> > > Otherwise, the guest can (and do) access to config space before
> > > _S_ACKNOWLEDGE | _S_DRIVER.
> >
> > I'm not sure if it is supported by the spec or not (I meant clearing
> > the FEATURES_OK). Or maybe we need a reset here?
> >
>
> Sorry, I'm still missing it :). The reset just above in all fail
> paths. They go to "out" label, and the first ioctl reset the device,
> the second set the VIRTIO_CONFIG_S_ACKNOWLEDGE |
> VIRTIO_CONFIG_S_DRIVER.

Just to make sure we are at the same page:

On error we basically do:

set_status(VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER |
VIRTIO_CONFIG_S_FEATURES_OK);
...
set_status(VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER)

So it means the device allows the driver to clear FEATURES_OK. But
spec is unclear whether or not this is supported. So I'm not sure it
is supported by all devices.

Thanks

>
> > Thanks
> >
> > >
> > >
> > > > >
> > > > > > Btw, spec requires a read of status after setting FEATURES_OK, =
this
> > > > > > seems to be missed in the current code.
> > > > > >
> > > > >
> > > > > I'm ok with that, but this patch does not touch that part.
> > > > >
> > > > > To fix this properly we should:
> > > > > - Expose vhost_vdpa_set_dev_features_fd as we did in previous ver=
sions
> > > > > of the series that added vhost_vdpa_probe_cvq_isolation [1].
> > > > > - Get status after vhost_vdpa_add_status, so both vhost start cod=
e and
> > > > > this follows the standard properly.
> > > > >
> > > > > Is it ok to do these on top of this patch?
> > > >
> > > > Fine.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks!
> > > > >
> > > > > [1] https://lore.kernel.org/qemu-devel/20230509154435.1410162-4-e=
perezma@redhat.com/
> > > > >
> > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >      return r;
> > > > > > >  }
> > > > > > >
> > > > > > > --
> > > > > > > 2.39.3
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>


