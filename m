Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DB2762B6B
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 08:29:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOY0J-0004tg-8H; Wed, 26 Jul 2023 02:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qOXzw-0004sK-Ep
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 02:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qOXzu-000861-Rx
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 02:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690352865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKPVSPo6xiI64BvJqJ8H0FkMTulKkfG6jKqaSgXiDCk=;
 b=G/ahsCfU22ewmXwuVxvsGInIcKJYMCnsekf4TpEXbnmudqOR5WwT/B8mjT6uO9EDCiaL+1
 6wPHhfecgQ8c0qZ8TKSlJ2Exiugr0Qd/EcLTmWy24pEZooNt4fIZDN4LTjO6/a/+ApyYNj
 7iXuPMQ4Vl7+8d9eI9bHCFiZ6kAl3ag=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-p4uF6BMMPzeE_tAQD-wOYQ-1; Wed, 26 Jul 2023 02:27:44 -0400
X-MC-Unique: p4uF6BMMPzeE_tAQD-wOYQ-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-4863e0b2bf6so320107e0c.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 23:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690352863; x=1690957663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKPVSPo6xiI64BvJqJ8H0FkMTulKkfG6jKqaSgXiDCk=;
 b=eCpC+ZJcDgaGQregWLpSkeuLkiNWKiEI1h9JEMtO1IwP4olexts0Md84YQ/swBaV0w
 lgMNctHt8imQw4lQF6L4GSSksgv+krSjks4T9q7QF3y5fCoy94z0/+OjDK+DGAhtY0e9
 FenUDiMdFsdONPnenCGYoZ7HTvEs2dpi7tE0fNqf64odUvf0JLlWH7ia84OTU77VP36f
 iVmT4EGA51hIRxDV1k5EZMOsU5gFV4+GhFlYMi0sx2p3HvATSDosuK6dUkSEw+n6u8/1
 fvD+bu/3RwgdJ+YFRnAEHgWpH2E6MzdmJDF9DRltCj0oaR4oLR9S2Vxo/3MLwbFUiLGM
 y55Q==
X-Gm-Message-State: ABy/qLZV/bw0SScKNNklicJil9fe0jxwF9BAlaiFbJPQYhjdgeNvbJbW
 RL0zx2sk9L+uk5aEvhe9bKZFymlYH5kffFVfPD0mrIpEJAfrLfkQ9WNJlOF5Y9TeeoA5gZHCDTF
 LQSgxzgYlZHImVAQq6gnv4lD9h43Iups=
X-Received: by 2002:a1f:e041:0:b0:486:47fd:b6c3 with SMTP id
 x62-20020a1fe041000000b0048647fdb6c3mr520107vkg.9.1690352863242; 
 Tue, 25 Jul 2023 23:27:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH1v7EA+7UYZTLfvsP2kV8E30vs8oiBQBhyh3+gOEC56blAAjYYpxAzrxtzMuyMPA+v/3hiw7PjHuw2Y5Qbbm4=
X-Received: by 2002:a1f:e041:0:b0:486:47fd:b6c3 with SMTP id
 x62-20020a1fe041000000b0048647fdb6c3mr520103vkg.9.1690352863024; Tue, 25 Jul
 2023 23:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230725182143.1523091-1-eperezma@redhat.com>
 <CACGkMEsqbZNGKdK1kM-qQeZShNeonQKK4_65vtCueQxUsRFTsQ@mail.gmail.com>
In-Reply-To: <CACGkMEsqbZNGKdK1kM-qQeZShNeonQKK4_65vtCueQxUsRFTsQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Jul 2023 08:27:06 +0200
Message-ID: <CAJaqyWeCNdmZX_iNywHxiD3fG39k5bRPOD2U13cmevbcUct+hA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: set old virtio status at cvq isolation probing end
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, si-wei.liu@oracle.com, qemu-stable@nongnu.org, 
 Hawkins Jiawei <yin31149@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 26, 2023 at 4:07=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jul 26, 2023 at 2:21=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > The device already has a virtio status set by vhost_vdpa_init by the
> > time vhost_vdpa_probe_cvq_isolation is called. vhost_vdpa_init set
> > S_ACKNOWLEDGE and S_DRIVER, so it is invalid to just reset it.
> >
> > It is invalid to start the device after it, but all devices seems to be
> > fine with it.  Fixing qemu so it follows virtio start procedure.
> >
> > Fixes: 152128d64697 ("vdpa: move CVQ isolation check to net_init_vhost_=
vdpa")
> > Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  net/vhost-vdpa.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 9795306742..d7e2b714b4 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -1333,6 +1333,8 @@ static int vhost_vdpa_probe_cvq_isolation(int dev=
ice_fd, uint64_t features,
> >  out:
> >      status =3D 0;
> >      ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> > +    status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER;
> > +    ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
>
> So if we fail after FEATURES_OK, this basically clears that bit. Spec
> doesn't say it can or not, I wonder if a reset is better?
>

I don't follow this, the reset is just above the added code, isn't it?

> Btw, spec requires a read of status after setting FEATURES_OK, this
> seems to be missed in the current code.
>

I'm ok with that, but this patch does not touch that part.

To fix this properly we should:
- Expose vhost_vdpa_set_dev_features_fd as we did in previous versions
of the series that added vhost_vdpa_probe_cvq_isolation [1].
- Get status after vhost_vdpa_add_status, so both vhost start code and
this follows the standard properly.

Is it ok to do these on top of this patch?

Thanks!

[1] https://lore.kernel.org/qemu-devel/20230509154435.1410162-4-eperezma@re=
dhat.com/


> Thanks
>
> >      return r;
> >  }
> >
> > --
> > 2.39.3
> >
>


