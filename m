Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ABB768C15
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 08:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQMVk-0001Iv-N2; Mon, 31 Jul 2023 02:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qQMVh-0001IL-1B
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:36:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qQMVd-0005tK-Q9
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690785360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QOipC11ww0LU4lt8bpbsSsC5jaOhn3FCqWtuh/ulA2s=;
 b=VGuzORD+rv8MMmW+Gz8p6sJAYtaV8b1AmddaxVD6p9hTUYgjkf86N/0UBdbzpWvWBWECQR
 BhzrME1mP/QZxQC396HgXh006xzb4bBSZAVk/gVCpJAixd1Ixk3pHRH1/8NxrozFRwu+iS
 UKNeQxtqDJWxNGhmjrJWLJxGmKTHxZY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-BABK1iPjO1KJlzo7KNDjDw-1; Mon, 31 Jul 2023 02:35:55 -0400
X-MC-Unique: BABK1iPjO1KJlzo7KNDjDw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b9b00a80e9so33205291fa.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 23:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690785353; x=1691390153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOipC11ww0LU4lt8bpbsSsC5jaOhn3FCqWtuh/ulA2s=;
 b=HHDfHXoJF2iHz6PX2QWwpY+dxquCEet0LFTNGaym2H/yS4jNs04AAEgwt092+7Ez+6
 XFUlr5B3TwUpjpC+n5wv9MZVYhdkWpesQl7UjwKd1T2awNlutsNM+TYJTnpAo6H7LaLZ
 KDbIOipNGHpxyE3mNkXu79yq1e/XID2G5JuZa7SeAunrC1jSpkpPy3ClqsXzzK6Rys/N
 HeEvPDgtJZ+39rnRh9xnCOv+pVHwYEoZSH+27Ho7lCL6loyyRVcoHOjbVFIk9HIMDbfR
 Be4z+ktT8ZuJ0UjB1+zr+85+ode551UfTSYVMHF+BSU51Ft9wLjgVc5FnLM4LHNJybne
 VcGQ==
X-Gm-Message-State: ABy/qLYaGQ4BvzzAKZ6csDOvVOZOHX5mNo7LIWTIzhqRGiCH8KY6rC1w
 Vuy7mBnyehZxrw8j9pv8Wk5QXp8Y2qYSCTsEJ2oUFtEJILN/6vtAarXUeKF9W7ezxiGfAp5sgG6
 59jB1gWnnO2b9embAXIkmgk1ssPj0Z9I=
X-Received: by 2002:a2e:9a95:0:b0:2b7:3633:2035 with SMTP id
 p21-20020a2e9a95000000b002b736332035mr5876745lji.32.1690785353552; 
 Sun, 30 Jul 2023 23:35:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH1YtrVosh1Pad/Lldk0Ld9nm70+x3wZqAP7OSDWP9SYDyOMDrkbxUZMT/LRDiJAPzifSp+/Y6f99wDksi0s10=
X-Received: by 2002:a2e:9a95:0:b0:2b7:3633:2035 with SMTP id
 p21-20020a2e9a95000000b002b736332035mr5876738lji.32.1690785353250; Sun, 30
 Jul 2023 23:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230725182143.1523091-1-eperezma@redhat.com>
 <CACGkMEsqbZNGKdK1kM-qQeZShNeonQKK4_65vtCueQxUsRFTsQ@mail.gmail.com>
 <CAJaqyWeCNdmZX_iNywHxiD3fG39k5bRPOD2U13cmevbcUct+hA@mail.gmail.com>
In-Reply-To: <CAJaqyWeCNdmZX_iNywHxiD3fG39k5bRPOD2U13cmevbcUct+hA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 31 Jul 2023 14:35:42 +0800
Message-ID: <CACGkMEv4HNw-Fqsdn+BmzjrWsbxG4rR=kqYPS5kX41D-r=sUow@mail.gmail.com>
Subject: Re: [PATCH] vdpa: set old virtio status at cvq isolation probing end
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, si-wei.liu@oracle.com, qemu-stable@nongnu.org, 
 Hawkins Jiawei <yin31149@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Wed, Jul 26, 2023 at 2:27=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Jul 26, 2023 at 4:07=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Jul 26, 2023 at 2:21=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > The device already has a virtio status set by vhost_vdpa_init by the
> > > time vhost_vdpa_probe_cvq_isolation is called. vhost_vdpa_init set
> > > S_ACKNOWLEDGE and S_DRIVER, so it is invalid to just reset it.
> > >
> > > It is invalid to start the device after it, but all devices seems to =
be
> > > fine with it.  Fixing qemu so it follows virtio start procedure.
> > >
> > > Fixes: 152128d64697 ("vdpa: move CVQ isolation check to net_init_vhos=
t_vdpa")
> > > Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  net/vhost-vdpa.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > index 9795306742..d7e2b714b4 100644
> > > --- a/net/vhost-vdpa.c
> > > +++ b/net/vhost-vdpa.c
> > > @@ -1333,6 +1333,8 @@ static int vhost_vdpa_probe_cvq_isolation(int d=
evice_fd, uint64_t features,
> > >  out:
> > >      status =3D 0;
> > >      ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> > > +    status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER;
> > > +    ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> >
> > So if we fail after FEATURES_OK, this basically clears that bit. Spec
> > doesn't say it can or not, I wonder if a reset is better?
> >
>
> I don't follow this, the reset is just above the added code, isn't it?

I meant for error path:

E.g:
    uint8_t status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE |
                     VIRTIO_CONFIG_S_DRIVER |
                     VIRTIO_CONFIG_S_FEATURES_OK;
...
    r =3D ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
....
        if (cvq_group !=3D -ENOTSUP) {
            r =3D cvq_group;
            goto out;
        }

out:
    status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER;
    ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);

We're basically clearing FEATURES_OK?

>
> > Btw, spec requires a read of status after setting FEATURES_OK, this
> > seems to be missed in the current code.
> >
>
> I'm ok with that, but this patch does not touch that part.
>
> To fix this properly we should:
> - Expose vhost_vdpa_set_dev_features_fd as we did in previous versions
> of the series that added vhost_vdpa_probe_cvq_isolation [1].
> - Get status after vhost_vdpa_add_status, so both vhost start code and
> this follows the standard properly.
>
> Is it ok to do these on top of this patch?

Fine.

Thanks

>
> Thanks!
>
> [1] https://lore.kernel.org/qemu-devel/20230509154435.1410162-4-eperezma@=
redhat.com/
>
>
> > Thanks
> >
> > >      return r;
> > >  }
> > >
> > > --
> > > 2.39.3
> > >
> >
>


