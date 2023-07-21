Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CCC75CC66
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 17:48:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMsMm-00030B-91; Fri, 21 Jul 2023 11:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMsMf-0002zm-Bc
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMsMc-0001m1-N9
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689954497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fS03YZ4r5e7oaCPO9ogre6tpyaCKYMyGY7O8UMFzvhg=;
 b=VCKc6OfBPtrA0H3mi8EMQOb1EdLBx0laQISNVk4NJELHxRNcO/HrOxSzPjXGwqKOVoEBJE
 +xRIs4N916W2zSESl8Nu8RiXpxKhfyUtCRd226bK9Zkv9GxNDrcZJ1XY3X8bCIKbeE+Erq
 QTwvsUGmldinuifVte/IJlaD7vD5Ugk=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-uee8pUqrOR-eMHYjm96EfA-1; Fri, 21 Jul 2023 11:48:15 -0400
X-MC-Unique: uee8pUqrOR-eMHYjm96EfA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-d06d36b49f9so15868276.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 08:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689954494; x=1690559294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fS03YZ4r5e7oaCPO9ogre6tpyaCKYMyGY7O8UMFzvhg=;
 b=KzZ5nEUz7/AsSZxGuTNWf0qyEAqQERu6uyep1fyRGE6gmE5QAG5VMsLWOiF9GaDnTN
 +hDO2vZYII8rLEflkR25/1eSEnkawNR/f0j/gkorbF+AG1YvJQ67eUKst6VAauq0e2B3
 owtj52aVQdxz40Lmj/vqwyq0lhIs0WtGdf5IqhXi3pqspFrdOsYTYaIObB3z2A5TS12i
 776KMThhkRGR0tZDhPEK/L82ylypveYbRTJxXy2SS/CpzIGhTyBi/1dv8ZK4rFyHdGf1
 mtxV7DK+hjbn1Ott5S3Dpht8ypJhOyzYbQtZBGC10SdAfbOhIfNRaePLwJyd54B4r31r
 Km3Q==
X-Gm-Message-State: ABy/qLbW6RFFjnlm+GBPfLWKBE3XDcJ8PByg5Qrg4AWm8eBKT58dMLD2
 5OVB0K9HjqbK1WewUgh5OCt3hACs2SecCFx3p4YgE08txIaVgIqNBOW4wA5DrYBPJAoO3DXBAgy
 wMaNv5kOSfc5NkuNyqs06ucKpWBII7vI=
X-Received: by 2002:a25:ae1e:0:b0:cfe:4254:c3cb with SMTP id
 a30-20020a25ae1e000000b00cfe4254c3cbmr2162188ybj.23.1689954494104; 
 Fri, 21 Jul 2023 08:48:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHdVY7NJULYK9/Radi5mALBQSFV6jqFAg9SZF8u4xMZ8RvXcgTUhS/0EkvMRhDt9caiog6yAKpMU9hY2D2g0OQ=
X-Received: by 2002:a25:ae1e:0:b0:cfe:4254:c3cb with SMTP id
 a30-20020a25ae1e000000b00cfe4254c3cbmr2162174ybj.23.1689954493822; Fri, 21
 Jul 2023 08:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-6-hreitz@redhat.com>
 <20230718145032.GF44841@fedora>
 <82796f23-c9a7-7a52-96c4-f70d10a06d0a@redhat.com>
In-Reply-To: <82796f23-c9a7-7a52-96c4-f70d10a06d0a@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 21 Jul 2023 17:47:37 +0200
Message-ID: <CAJaqyWe9SSUonCm5hm=-MLha6n_7rjunTfkRgrn+-tdBLMcnhA@mail.gmail.com>
Subject: Re: [PATCH 5/6] vhost-vdpa: Match vhost-user's status reset
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, German Maglione <gmaglione@redhat.com>
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

On Wed, Jul 19, 2023 at 4:10=E2=80=AFPM Hanna Czenczek <hreitz@redhat.com> =
wrote:
>
> On 18.07.23 16:50, Stefan Hajnoczi wrote:
> > On Tue, Jul 11, 2023 at 05:52:27PM +0200, Hanna Czenczek wrote:
> >> vhost-vdpa and vhost-user differ in how they reset the status in their
> >> respective vhost_reset_status implementations: vhost-vdpa zeroes it,
> >> then re-adds the S_ACKNOWLEDGE and S_DRIVER config bits.  S_DRIVER_OK =
is
> >> then set in vhost_vdpa_dev_start().
> >>
> >> vhost-user in contrast just zeroes the status, and does no re-add any
> >> config bits until vhost_user_dev_start() (where it does re-add all of
> >> S_ACKNOWLEDGE, S_DRIVER, and S_DRIVER_OK).
> >>
> >> There is no documentation for vhost_reset_status, but its only caller =
is
> >> vhost_dev_stop().  So apparently, the device is to be stopped after
> >> vhost_reset_status, and therefore it makes more sense to keep the stat=
us
> >> field fully cleared until the back-end is re-started, which is how
> >> vhost-user does it.  Make vhost-vdpa do the same -- if nothing else it=
's
> >> confusing to have both vhost implementations handle this differently.
> >>

Ok now I understand better why you moved the call to vhost_vdpa_reset_statu=
s.

Maybe we can move the vhost_vdpa_add_status(dev, _S_ACKNOWLEDGE |
_S_DRIVER) to vhost_vdpa_set_features then, and let reset_status call
vhost_vdpa_reset_device directly. But I'm not 100% sure if I'm missing
something, it would need testing.

Thanks!

> >> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> >> ---
> >>   hw/virtio/vhost-vdpa.c | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> > Hi Hanna,
> > The VIRTIO spec lists the Device Initialization sequence including the
> > bits set in the Device Status Register here:
> > https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.=
html#x1-1070001
> >
> > ACKNOWLEDGE and DRIVER must be set before FEATURES_OK. DRIVER_OK is set
> > after FEATURES_OK.
> >
> > The driver may read the Device Configuration Space once ACKNOWLEDGE and
> > DRIVER are set.
> >
> > QEMU's vhost code should follow this sequence (especially for vDPA wher=
e
> > full VIRTIO devices are implemented).
> >
> > vhost-user is not faithful to the VIRTIO spec here. That's probably due
> > to the fact that vhost-user didn't have the concept of the Device Statu=
s
> > Register until recently and back-ends mostly ignore it.
> >
> > Please do the opposite of this patch: bring vhost-user in line with the
> > VIRTIO specification so that the Device Initialization sequence is
> > followed correctly. I think vhost-vdpa already does the right thing.
>
> Hm.  This sounds all very good, but what leaves me lost is the fact that
> we never actually expose the status field to the guest, as far as I can
> see.  We have no set_status callback, and as written in the commit
> message, the only caller of reset_status is vhost_dev_stop().  So the
> status field seems completely artificial in vhost right now.  That is
> why I=E2=80=99m wondering what the flags even really mean.
>
> Another point I made in the commit message is that it is strange that we
> reset the status to 0, and then add the ACKNOWLEDGE and DRIVER while the
> VM is still stopped.  It doesn=E2=80=99t make sense to me to set these fl=
ags
> while the guest driver is not operative.
>
> If what you=E2=80=99re saying is that we must set FEATURES_OK only after
> ACKNOWLEDGE and DRIVER, wouldn=E2=80=99t it be still better to set all of=
 these
> flags only in vhost_*_dev_start(), but do it in two separate SET_STATUS
> calls?
>
> (You mentioned the configuration space =E2=80=93 is that accessed while b=
etween
> vhost_dev_stop and vhost_dev_start?)
>
> Hanna
>
> >> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >> index f7fd19a203..0cde8b40de 100644
> >> --- a/hw/virtio/vhost-vdpa.c
> >> +++ b/hw/virtio/vhost-vdpa.c
> >> @@ -1294,8 +1294,6 @@ static void vhost_vdpa_reset_status(struct vhost=
_dev *dev)
> >>       }
> >>
> >>       vhost_vdpa_reset_device(dev);
> >> -    vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> >> -                               VIRTIO_CONFIG_S_DRIVER);
> >>       memory_listener_unregister(&v->listener);
> >>   }
> >>
> >> @@ -1334,7 +1332,9 @@ static int vhost_vdpa_dev_start(struct vhost_dev=
 *dev, bool started)
> >>           }
> >>           memory_listener_register(&v->listener, dev->vdev->dma_as);
> >>
> >> -        return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> >> +        return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE=
 |
> >> +                                          VIRTIO_CONFIG_S_DRIVER |
> >> +                                          VIRTIO_CONFIG_S_DRIVER_OK);
> >>       }
> >>
> >>       return 0;
> >> --
> >> 2.41.0
> >>
>


