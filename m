Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 740CE7D2E50
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:32:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurGP-0000zn-QT; Mon, 23 Oct 2023 05:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qurGL-0000zT-Bs
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qurGH-00042O-0l
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698053410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bWRH/UhKo/xZsmdbBLpR3mKt4IiEjfeUIaolB7vdgHA=;
 b=h5AYQdqw6+2D5m2uv14Gdl4jlnk2lKXCVYtXObKfA36IOfs67WnPLXmBNP4NQKZ3no/Pjg
 i8btjzjrqAwFeV/C8VAQ+qj+tclIcy0wWDKlcTW2KOdZeh4Zk1MFG0LC0AwHC5wl3XQBDX
 mIIh/CXJZ6VW65B3rF5TgqdWog5iP6o=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-AFe7zxblPGyUD8rfHyDs_Q-1; Mon, 23 Oct 2023 05:30:08 -0400
X-MC-Unique: AFe7zxblPGyUD8rfHyDs_Q-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41cb7904d5aso44889321cf.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 02:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698053408; x=1698658208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bWRH/UhKo/xZsmdbBLpR3mKt4IiEjfeUIaolB7vdgHA=;
 b=wv0Ua+IvpGunl+mVGW5C/P6ptCMAc4VBk+c2BselsHu/p8fycuLrR3HmrraufF1zQW
 kl8QHCGa0Jgj1H6LBW1PKP/UqZwuvJv2R2o9BZuVWcp8zwQ47zK8RJmdAd6Pgk3iCNwr
 G9usNMy2fUTsBU+jwjbOlRWdV0XQQaFeU7kQ/k7PeIgcPAVgjrF7ZTRMUIrDdUT/DSaN
 iFUTbK6hu0EqqLDQIu0udRkf/2j3rOcQkul40UlzwZahK/11RD2Eo8LV+SGskrQbJ2q3
 6vU1Ussv9vfVNBKn0zqzVFY4HZbrJ1l3D3Z3MAxgY2L+rd6TlOJE83BFcMIXP4mKlwIU
 TWZA==
X-Gm-Message-State: AOJu0YzEtasI5L/GTc0/2NJkalq77qpaiqnhfzBcuwF4YduUjiOdOHMO
 KXkC9QLArl2qaPEP5jp9RMMtvb4Ifswwz5FzmqcQpZt7jrhJnKlqHH3IMVCjdVu9T5NGQ9hGrq/
 k57Sei3vMeOumBAM=
X-Received: by 2002:ac8:4e86:0:b0:41b:826b:1be8 with SMTP id
 6-20020ac84e86000000b0041b826b1be8mr11973481qtp.17.1698053407902; 
 Mon, 23 Oct 2023 02:30:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk3I1W94WildIJnzyBvuTUwKjpxDbfTwVQeJ7fvAykTJzbav/T0qXVcTdryJEKL/kx9hWMBA==
X-Received: by 2002:ac8:4e86:0:b0:41b:826b:1be8 with SMTP id
 6-20020ac84e86000000b0041b826b1be8mr11973463qtp.17.1698053407595; 
 Mon, 23 Oct 2023 02:30:07 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 h11-20020ac8776b000000b004194c21ee85sm2617680qtu.79.2023.10.23.02.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 02:30:06 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:30:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony
 Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau         <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 11/12] hw/xen: automatically assign device index to
 block devices
Message-ID: <20231023113002.0e83c209@imammedo.users.ipa.redhat.com>
In-Reply-To: <3f3487af227dcdce7afb37e8406d5ce8dcdbf55f.camel@infradead.org>
References: <20231016151909.22133-1-dwmw2@infradead.org>
 <20231016151909.22133-12-dwmw2@infradead.org>
 <20231018093239.3d525fd8@imammedo.users.ipa.redhat.com>
 <3f3487af227dcdce7afb37e8406d5ce8dcdbf55f.camel@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 18 Oct 2023 09:32:47 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Wed, 2023-10-18 at 09:32 +0200, Igor Mammedov wrote:
> > On Mon, 16 Oct 2023 16:19:08 +0100
> > David Woodhouse <dwmw2@infradead.org> wrote:
> >  =20
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > >  =20
> >=20
> > is this index a user (guest) visible? =20
>=20
> Yes. It defines what block device (e.g. /dev/xvda) the disk appears as
> in the guest. In the common case, it literally encodes the Linux
> major/minor numbers. So xvda (major 202) is 0xca00, xvdb is 0xca10 etc.

that makes 'index' an implicit ABI and a subject to versioning
when the way it's assigned changes (i.e. one has to use versioned
machine types to keep older versions working the they used to).

=46rom what I remember it's discouraged to make QEMU invent
various IDs that are part of ABI (guest or mgmt side).
Instead it's preferred for mgmt side/user to provide that explicitly.

Basically you are trading off manageability/simplicity at QEMU
level with CLI usability for human user.
I don't care much as long as it is hidden within xen code base,
but maybe libvirt does.

> Previously we had to explicitly set it for each disk in Qemu:
>=20
>   -drive file=3Ddisk1.img,id=3Ddrv1 -device xen-disk,drive=3Ddrv1,vdev=3D=
xvda
>   -drive file=3Ddisk2.img,id=3Ddrv2 -device xen-disk,drive=3Ddrv2,vdev=3D=
xvdb
>=20
> Now we can just do
>=20
>   -drive file=3Ddisk1.img,if=3Dxen -drive file-disk2.img,if=3Dxen
>
> (We could go further and make if=3Dxen the default for Xen guests too,
> but that doesn't work right now because xen-block will barf on the
> default provided CD-ROM when it's empty. It doesn't handle empty
> devices. And if I work around that, then `-hda disk1.img` would work on
> the command line... but would make it appear as /dev/xvda instead of
> /dev/hda, and I don't know how I feel about that.)
>
> [root@localhost ~]# xenstore-ls  -f device/vbd
> device/vbd =3D ""
> device/vbd/51712 =3D ""
> device/vbd/51712/backend =3D "/local/domain/0/backend/qdisk/1/51712"
> device/vbd/51712/backend-id =3D "0"
> device/vbd/51712/device-type =3D "disk"
> device/vbd/51712/event-channel =3D "8"
> device/vbd/51712/feature-persistent =3D "1"
> device/vbd/51712/protocol =3D "x86_64-abi"
> device/vbd/51712/ring-ref =3D "8"
> device/vbd/51712/state =3D "4"
> device/vbd/51712/virtual-device =3D "51712"
>=20
> >  =20
> > > There's no need to force the user to assign a vdev. We can automatica=
lly
> > > assign one, starting at xvda and searching until we find the first di=
sk
> > > name that's unused.
> > >=20
> > > This means we can now allow '-drive if=3Dxen,file=3Dxxx' to work with=
out an
> > > explicit separate -driver argument, just like if=3Dvirtio.
> > >=20
> > > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > > ---
> > > =C2=A0blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 15 ++++++++++++---
> > > =C2=A0hw/block/xen-block.c | 25 +++++++++++++++++++++++++
> > > =C2=A02 files changed, 37 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/blockdev.c b/blockdev.c
> > > index 325b7a3bef..9dec4c9c74 100644
> > > --- a/blockdev.c
> > > +++ b/blockdev.c
> > > @@ -255,13 +255,13 @@ void drive_check_orphaned(void)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ignore defau=
lt drives, because we create certain default
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * drives uncon=
ditionally, then leave them unclaimed.=C2=A0 Not the
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * users fault.
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ignore IF_VIRTIO,=
 because it gets desugared into -device,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so we can leave f=
ailing to -device.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ignore IF_VIRTIO =
or IF_XEN, because it gets desugared into
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * -device, so we ca=
n leave failing to -device.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ignore IF_NO=
NE, because leaving unclaimed IF_NONE remains
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * available fo=
r device_add is a feature.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dinfo->is_defaul=
t || dinfo->type =3D=3D IF_VIRTIO
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
| dinfo->type =3D=3D IF_NONE) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
| dinfo->type =3D=3D IF_XEN || dinfo->type =3D=3D IF_NONE) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 continue;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!blk_get_attache=
d_dev(blk)) {
> > > @@ -977,6 +977,15 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockIn=
terfaceType block_default_type,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_opt_set(devopts=
, "driver", "virtio-blk", &error_abort);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_opt_set(devopts=
, "drive", qdict_get_str(bs_opts, "id"),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &error_abort);
> > > +=C2=A0=C2=A0=C2=A0 } else if (type =3D=3D IF_XEN) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QemuOpts *devopts;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devopts =3D qemu_opts_cre=
ate(qemu_find_opts("device"), NULL, 0,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &error_abor=
t);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_opt_set(devopts, "dr=
iver",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (media =3D=3D MEDIA_=
CDROM) ? "xen-cdrom" : "xen-disk",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &error_abort);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_opt_set(devopts, "dr=
ive", qdict_get_str(bs_opts, "id"),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &error_abort);
> > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0 filename =3D qemu_opt_get(legacy_opts, "file=
");
> > > diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> > > index 9262338535..20fa783cbe 100644
> > > --- a/hw/block/xen-block.c
> > > +++ b/hw/block/xen-block.c
> > > @@ -34,6 +34,31 @@ static char *xen_block_get_name(XenDevice *xendev,=
 Error **errp)
> > > =C2=A0=C2=A0=C2=A0=C2=A0 XenBlockDevice *blockdev =3D XEN_BLOCK_DEVIC=
E(xendev);
> > > =C2=A0=C2=A0=C2=A0=C2=A0 XenBlockVdev *vdev =3D &blockdev->props.vdev;
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0 if (blockdev->props.vdev.type =3D=3D XEN_BLOCK_VD=
EV_TYPE_INVALID) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char name[11];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int disk =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long idx;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Find an unoccupied dev=
ice name */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (disk < (1 << 20)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (disk < (1 << 4)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 idx =3D (202 << 8) | (disk << 4);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=
 else {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 idx =3D (1 << 28) | (disk << 8);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
nprintf(name, sizeof(name), "%lu", idx);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (!xen_backend_exists("qdisk", name)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 vdev->type =3D XEN_BLOCK_VDEV_TYPE_XVD;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 vdev->partition =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 vdev->disk =3D disk;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 vdev->number =3D idx;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return g_strdup(name);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
isk++;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "cannot =
find device vdev for block device");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> > > +=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0 return g_strdup_printf("%lu", vdev->number);
> > > =C2=A0}
> > > =C2=A0 =20
> >=20
> >  =20
>=20


