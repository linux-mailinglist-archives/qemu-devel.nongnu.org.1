Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC997DFE5F
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 04:25:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qykn3-0003VT-Vz; Thu, 02 Nov 2023 23:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qykn1-0003Tw-Tz
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qykn0-0006Ad-82
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698981845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ME0YwZrPAM8DXQfC3WcAnwOgEpomkG+jSwfgxzk5D/w=;
 b=GBb2Bu634/fahHx86TAWddV77MvI9wLrbkVG5rAau5fBpZMUB1pZouvR1SLAJMnpWsmDza
 zO2SDyPyMzyxdkG9Mxs7ATolI9TVaIxJ5wVTQCcRaTVgLpdWRbLUZ7pq6CUrekYGYHZS/s
 yy6qNS6DToOwiSgCpvVI8P1ylwUYmBM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-XHHJPaX5O4aEo7A89zCkqw-1; Thu, 02 Nov 2023 23:24:01 -0400
X-MC-Unique: XHHJPaX5O4aEo7A89zCkqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF13B811E7B;
 Fri,  3 Nov 2023 03:24:00 +0000 (UTC)
Received: from localhost (unknown [10.39.192.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1357D1C060BA;
 Fri,  3 Nov 2023 03:23:59 +0000 (UTC)
Date: Thu, 2 Nov 2023 14:30:45 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 dlemoal@kernel.org, hare@suse.de, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 2/4] qcow2: add configurations for zoned format
 extension
Message-ID: <20231102063045.GA726730@fedora>
References: <20231030121847.4522-1-faithilikerun@gmail.com>
 <20231030121847.4522-3-faithilikerun@gmail.com>
 <i43illqyyzu7wbotuw2fbuft7izdmfo7jkwnds4yrigewachhw@7pudpozwjer5>
 <CAAAx-8LmOU36W7Y9DwhFKj5WB04oOge5NQ908544rb9cmw=-jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n8ED0FceWLPkbLpa"
Content-Disposition: inline
In-Reply-To: <CAAAx-8LmOU36W7Y9DwhFKj5WB04oOge5NQ908544rb9cmw=-jg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.393, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--n8ED0FceWLPkbLpa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 11:01:26PM +0800, Sam Li wrote:
> Hi Eric,
>=20
> Eric Blake <eblake@redhat.com> =E4=BA=8E2023=E5=B9=B410=E6=9C=8830=E6=97=
=A5=E5=91=A8=E4=B8=80 22:53=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Oct 30, 2023 at 08:18:45PM +0800, Sam Li wrote:
> > > To configure the zoned format feature on the qcow2 driver, it
> > > requires settings as: the device size, zone model, zone size,
> > > zone capacity, number of conventional zones, limits on zone
> > > resources (max append bytes, max open zones, and max_active_zones).
> > >
> > > To create a qcow2 file with zoned format, use command like this:
> > > $ qemu-img create -f qcow2 test.qcow2 -o size=3D768M -o
> > > zone_size=3D64M -o zone_capacity=3D64M -o conventional_zones=3D0 -o
> > > max_append_bytes=3D4096 -o max_open_zones=3D0 -o max_active_zones=3D0
> > > -o zone_model=3Dhost-managed
> > >
> > > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > >
> > > fix config?
> >
> > Is this comment supposed to be part of the commit message?  If not,...
>=20
> No...
>=20
> >
> > > ---
> >
> > ...place it here under the divider, so 'git am' won't include it, if th=
ere is nothing further to change on this patch.
> >
> > >  block/qcow2.c                    | 205 +++++++++++++++++++++++++++++=
+-
> > >  block/qcow2.h                    |  37 +++++-
> > >  docs/interop/qcow2.txt           |  67 +++++++++-
> > >  include/block/block_int-common.h |  13 ++
> > >  qapi/block-core.json             |  45 ++++++-
> > >  5 files changed, 362 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/block/qcow2.c b/block/qcow2.c
> > > index aa01d9e7b5..cd53268ca7 100644
> > > --- a/block/qcow2.c
> > > +++ b/block/qcow2.c
> > > @@ -73,6 +73,7 @@ typedef struct {
> > >  #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
> > >  #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
> > >  #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
> > > +#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x007a6264
> > >
> > >  static int coroutine_fn
> > >  qcow2_co_preadv_compressed(BlockDriverState *bs,
> > > @@ -210,6 +211,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint6=
4_t start_offset,
> > >      uint64_t offset;
> > >      int ret;
> > >      Qcow2BitmapHeaderExt bitmaps_ext;
> > > +    Qcow2ZonedHeaderExtension zoned_ext;
> > >
> > >      if (need_update_header !=3D NULL) {
> > >          *need_update_header =3D false;
> > > @@ -431,6 +433,63 @@ qcow2_read_extensions(BlockDriverState *bs, uint=
64_t start_offset,
> > >              break;
> > >          }
> > >
> > > +        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
> > > +        {
> > > +            if (ext.len !=3D sizeof(zoned_ext)) {
> > > +                error_setg(errp, "zoned_ext: Invalid extension lengt=
h");
> > > +                return -EINVAL;
> > > +            }
> >
> > Do we ever anticipate the struct growing in size in the future to add
> > further features?  Forcing the size to be constant, rather than a
> > minimum, may get in the way of clean upgrades to a future version of
> > the extension header.
>=20
> The zoned extension could grow. So ext.len > sizeof(zoned_ext) -> invalid.

No, ext.len >=3D sizeof(zoned_ext) is valid. The program can extract the
zoned_ext fields that it knows about. Any additional fields are ignored
by the program because it doesn't know how to interpret them. ext.len <
sizeof(zoned_ext) is invalid because required fields are missing.

When zoned_ext is extended to add a new feature the first time, the code
is updated like this:

  if (ext.len < endof(zoned_ext, last_minimum_field)) {
      ...invalid...
  }

  ...handle minimum zoned_ext fields...

  if (ext.len >=3D endof(zoned_ext, additional_field)) {
      ...handle additional_field...
  }
  ...more additional fields...

This approach is often used by Linux ioctl(2) interfaces. It allows
extensions to the struct without breaking old programs that still use
shorter versions of the struct.

Only optional features can be added using this approach, so it's often
combined with a 'flags' field that indicates which mandatory features
userspace wants and the kernel has provided. That way the kernel can
reject ioctls that require a new feature that the old kernel doesn't
know and the kernel can fill in flags upon returning from ioctl(2) so
userspace knows which functionality was provided by the kernel. qcow2
has feature bits, so I don't think a 'flags' field is required.

Stefan

--n8ED0FceWLPkbLpa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVDQhUACgkQnKSrs4Gr
c8gbPgf/YWWAodqwNvFVfeple7LjYsFdU/dOjuDnSN26VpWw7XHxEhA3wrF4ZNLB
6jfR3gXU3aBC4MeHlcVeb9FF6PS+tKdz55jBHs9V3t55SrC2XlAwGExcQZ7l11XX
VezjZLSiJ0msLmTP4kX9HftC40I+ZLuQd7KN+G4C6RzJk7OV4YxQhmTeMPYXkaZW
j1M5aZ8s+hKd6/l6nl3AaIWeAkwirMfFvEgxBnbV7pGSk3RPWPK/rMuvZQlb7uLl
1QuqfMPrUYXYbxdt5JM9gDcXeCcAk0XaA72BTSglK9D9ghIE5YBQS0hJVzwRgrEw
JwYL0Mi1TI4CdgfoExJeJVqWMrgjGw==
=svsY
-----END PGP SIGNATURE-----

--n8ED0FceWLPkbLpa--


