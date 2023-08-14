Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 506D677BDEC
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 18:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVaQW-00062B-Q9; Mon, 14 Aug 2023 12:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qVaQU-000622-Au
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qVaQS-0003h6-BY
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692030495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=el1/x4bYUOgY7iBH4pLkWJ6MFMfvt2mFklMaKRh9uTM=;
 b=OBHNtqET8rx6D8Fy+zuEISTsAy7IakfRbmBsRmuVBjssg/sUExs3UTO5s8hwoebw1x69zj
 VgcLhERECKRlPKoXrpa/p/1DrxiCTFgxjCCFEIgLPmrXG16Q7WsVzNaUuXvv2oJOU4iyhe
 mwDKt+F9Nr3rwtyaGsWHLgt/m2VvcK8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-693-GchZrf9wOIaRMEoQ9gANiQ-1; Mon, 14 Aug 2023 12:28:10 -0400
X-MC-Unique: GchZrf9wOIaRMEoQ9gANiQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5516938149A7;
 Mon, 14 Aug 2023 16:28:10 +0000 (UTC)
Received: from localhost (unknown [10.39.192.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C2E74A9004;
 Mon, 14 Aug 2023 16:28:09 +0000 (UTC)
Date: Mon, 14 Aug 2023 09:18:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH QEMU v2 0/3] provide a smooth upgrade solution for
 multi-queues disk
Message-ID: <20230814131828.GA3146793@fedora>
References: <169165122958.4096.6557269987206106594-0@git.sr.ht>
 <20230810183348.GA2959434@fedora>
 <CAK9dgmZiDaK89JrL30Br-V6tV1ztKnCudpDMG6tc6X1u=8=Y3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="beo0mhrLwYQwrb5G"
Content-Disposition: inline
In-Reply-To: <CAK9dgmZiDaK89JrL30Br-V6tV1ztKnCudpDMG6tc6X1u=8=Y3A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--beo0mhrLwYQwrb5G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 10:31:51AM +0800, Yong Huang wrote:
> Hi, Stefan, thank you for your interest in this series.
> I'm trying to explain my point,  if you think my explanation
> doesn't stand up, please let me know.
>=20
> On Fri, Aug 11, 2023 at 2:33=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
>=20
> > On Thu, Aug 10, 2023 at 07:07:09AM +0000, ~hyman wrote:
> > > Ping,
> > >
> > > This version is a copy of version 1 and is rebased
> > > on the master. No functional changes.
> > >
> > > A 1:1 virtqueue:vCPU mapping implementation for virtio-*-pci disk
> > > introduced since qemu >=3D 5.2.0, which improves IO performance
> > > remarkably. To enjoy this feature for exiting running VMs without
> > > service interruption, the common solution is to migrate VMs from the
> > > lower version of the hypervisor to the upgraded hypervisor, then wait
> > > for the next cold reboot of the VM to enable this feature. That's the
> > > way "discard" and "write-zeroes" features work.
> > >
> > > As to multi-queues disk allocation automatically, it's a little
> > > different because the destination will allocate queues to match the
> > > number of vCPUs automatically by default in the case of live migratio=
n,
> > > and the VMs on the source side remain 1 queue by default, which resul=
ts
> > > in migration failure due to loading disk VMState incorrectly on the
> > > destination side.
> >
> > Are you using QEMU's versioned machine types to freeze the VM
> > configuration?
>=20
>=20
> > If not, then live migration won't work reliably because you're migrating
> > between two potentially different VM configurations. This issue is not
> > specific to num-queues, it affects all device properties.
> >
> > In commit 9445e1e15e66c19e42bea942ba810db28052cd05 ("virtio-blk-pci:
> > default num_queues to -smp N") the num_queues property is set to 1 for
> > versioned machine types <=3D5.1:
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 9ee2aa0f7b..7f65fa8743 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -31,6 +31,7 @@
> >  GlobalProperty hw_compat_5_1[] =3D {
> >      { "vhost-scsi", "num_queues", "1"},
> >      { "vhost-user-scsi", "num_queues", "1"},
> > +    { "virtio-blk-device", "num-queues", "1"},
> >      { "virtio-scsi-device", "num_queues", "1"},
> >  };
> >  const size_t hw_compat_5_1_len =3D G_N_ELEMENTS(hw_compat_5_1);
> >
> > Live migration works when the source and destination QEMU are launched
> > with the same versioned machine type. You can check the "info qtree"
> > output to confirm that starting a VM with -smp 4 -M pc-q35-5.1 results
> > in num-queues=3D1 while -smp 4 -M pc-q35-5.2 results in num-queues=3D4.
> >
> > > This issue requires Qemu to provide a hint that shows
> > > multi-queues disk allocation is automatically supported, and this all=
ows
> > > upper APPs, e.g., libvirt, to recognize the hypervisor's capability of
> > > this. And upper APPs can ensure to allocate the same num-queues on the
> > > destination side in case of migration failure.
> > >
> > > To fix the issue, we introduce the auto-num-queues property for
> > > virtio-*-pci as a solution, which would be probed by APPs, e.g., libv=
irt
> > > by querying the device properties of QEMU. When launching live
> > > migration, libvirt will send the auto-num-queues property as a migrat=
ion
> > > cookie to the destination, and thus the destination knows if the sour=
ce
> > > side supports auto-num-queues. If not, the destination would switch o=
ff
> > > by building the command line with "auto-num-queues=3Doff" when prepar=
ing
> > > the incoming VM process. The following patches of libvirt show how it
> > > roughly works:
> > >
> > https://github.com/newfriday/libvirt/commit/ce2bae2e1a6821afeb80756dc01=
f3680f525e506
> > >
> > https://github.com/newfriday/libvirt/commit/f546972b009458c88148fe07954=
4db7e9e1f43c3
> > >
> > https://github.com/newfriday/libvirt/commit/5ee19c8646fdb4d87ab8b93f287=
c20925268ce83
> > >
> > > The smooth upgrade solution requires the introduction of the auto-num-
> > > queues property on the QEMU side, which is what the patch set does. I=
'm
> > > hoping for comments about the series.
> >
> > Please take a look at versioned machine types. I think auto-num-queues
> > is not necessary if you use versioned machine types.
> >
> > If you do think auto-num-queues is needed, please explain the issue in
> > more detail and state why versioned machine types don't help.
>=20
>=20
> "Using the versioned machine types" is indeed the standard way to ensure
> the proper functioning of live migration.
>=20
> However, a stable version is strongly advised to maintain function in our
> production environment and perhaps practically all the production
> environments in other businesses. As a result, we must backport features
> like "auto-allocation num-queues" while keeping the machine type the same.
>=20
> This patch set is posted for that reason. The "feature-backport" scenario
> is its target. I'm not sure if the upstream development strategy should
> take this scenario into account; if it does, perhaps this patch set can be
> of use. After all, the primary goal of this patch set is to broaden the u=
ses
> for this feature and essentially makes no functional changes.

Downstreams that backport only a subset of patches instead of following
upstream linearly must define their own versioned machine types since
upstream versioned machine types are not relevant downstream.

For example, here is how CentOS Stream defines its own machine types:
https://gitlab.com/redhat/centos-stream/src/qemu-kvm/-/commit/318178778db60=
b6475d1484509bee136317156d3

I think it's nicer for downstreams to define custom versioned machine
types than to add properties like auto-num-queues that are intended for
downstream usage and don't serve a purpose upstream.

My suggestion is for you to maintain your own custom versioned machine
types so you can systematically control device properties across
versions. Does that make sense?

Stefan

>=20
>=20
>=20
>=20
> > Thanks,
> > Stefan
> >
> > >
> > > Please review, thanks.
> > > Yong
> > >
> > > Hyman Huang(=E9=BB=84=E5=8B=87) (3):
> > >   virtio-scsi-pci: introduce auto-num-queues property
> > >   virtio-blk-pci: introduce auto-num-queues property
> > >   vhost-user-blk-pci: introduce auto-num-queues property
> > >
> > >  hw/block/vhost-user-blk.c          |  1 +
> > >  hw/block/virtio-blk.c              |  1 +
> > >  hw/scsi/vhost-scsi.c               |  2 ++
> > >  hw/scsi/vhost-user-scsi.c          |  2 ++
> > >  hw/scsi/virtio-scsi.c              |  2 ++
> > >  hw/virtio/vhost-scsi-pci.c         | 11 +++++++++--
> > >  hw/virtio/vhost-user-blk-pci.c     |  9 ++++++++-
> > >  hw/virtio/vhost-user-scsi-pci.c    | 11 +++++++++--
> > >  hw/virtio/virtio-blk-pci.c         |  9 ++++++++-
> > >  hw/virtio/virtio-scsi-pci.c        | 11 +++++++++--
> > >  include/hw/virtio/vhost-user-blk.h |  5 +++++
> > >  include/hw/virtio/virtio-blk.h     |  5 +++++
> > >  include/hw/virtio/virtio-scsi.h    |  5 +++++
> > >  13 files changed, 66 insertions(+), 8 deletions(-)
> > >
> > > --
> > > 2.38.5
> > >
> >
>=20
>=20
> --=20
> Best regards

--beo0mhrLwYQwrb5G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTaKaMACgkQnKSrs4Gr
c8i19ggAhrkPjGNqI0x1fVoCeAI8/yxQM90sOWSfNDQNvV2P8OsUMZVz8P75QXBA
l2C1ZUAf/clkUpo1vtxTrKXpM8jMiNaSZe8KZFmlrTbR15JcMLprqkNrb0PPpzn9
touoSyOj3L0C0piLLEdf1rY/RjGOXMSeRQo3CGOvYlHjPRH6d9RHGV+QUBQtcFWe
J+q4OFO8bYGIlWBzazIV4jHpARcf+xBOreGIH3we0J4EhkAzmglbz5jAdW8psnnF
VXll96QL5BHG/FrRlU5yRa1LC/peOv9I8Akkym1e8QXNF/IpTwJ1krdvUCwFtjme
8SmhjfjrdnCfF7nfqxkzVNOG16KmjA==
=BysJ
-----END PGP SIGNATURE-----

--beo0mhrLwYQwrb5G--


