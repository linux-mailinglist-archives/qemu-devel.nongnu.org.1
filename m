Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9DA79447F
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 22:28:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdz6m-0000SI-R3; Wed, 06 Sep 2023 16:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdz6h-0000RK-HR
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 16:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdz6e-0007fv-FF
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 16:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694031991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AVN9dv72CkdY7HHyzr1V62GDhib+jMc/JK5ydhCAaac=;
 b=CCgoaRtwrjzUGHsiBxD3ZjFyJdls615VfWPmwT+ExSyNA4Qf7BwrdGNHMluHUsvx0VvKqQ
 RgWoy4gloUHl+4nOUCMAwiXjjhi6cNmzb76Q/F+xeO+/WHf5kqKA87HzbSuXjEVzB1El5v
 rCBXVthIeYFymAQtu7RDESlLV6ZnaVk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-ihajK_CBMGKCBunBx05sng-1; Wed, 06 Sep 2023 16:26:27 -0400
X-MC-Unique: ihajK_CBMGKCBunBx05sng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D494C80D75F;
 Wed,  6 Sep 2023 20:26:26 +0000 (UTC)
Received: from localhost (unknown [10.39.193.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C29B400F26A;
 Wed,  6 Sep 2023 20:26:26 +0000 (UTC)
Date: Wed, 6 Sep 2023 16:26:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, hare@suse.de, qemu-block@nongnu.org,
 dlemoal@kernel.org
Subject: Re: [PATCH v3 1/4] docs/qcow2: add the zoned format feature
Message-ID: <20230906202625.GA1313843@fedora>
References: <20230828150955.3481-1-faithilikerun@gmail.com>
 <20230828150955.3481-2-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xul6HmWXIVcilGtY"
Content-Disposition: inline
In-Reply-To: <20230828150955.3481-2-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--xul6HmWXIVcilGtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 11:09:52PM +0800, Sam Li wrote:
> Add the specs for the zoned format feature of the qcow2 driver.
> The qcow2 file can be taken as zoned device and passed through by
> virtio-blk device or NVMe ZNS device to the guest given zoned
> information.
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  docs/system/qemu-block-drivers.rst.inc | 39 ++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-bl=
ock-drivers.rst.inc
> index 105cb9679c..640ab151a7 100644
> --- a/docs/system/qemu-block-drivers.rst.inc
> +++ b/docs/system/qemu-block-drivers.rst.inc
> @@ -172,6 +172,45 @@ This section describes each format and the options t=
hat are supported for it.
>      filename`` to check if the NOCOW flag is set or not (Capital 'C' is
>      NOCOW flag).
> =20
> +  .. option:: zoned
> +    The zoned interface of zoned storage divices can different forms whi=
ch
> +    is referred to as models. This option uses number to represent, 1 for
> +    host-managed and 0 for non-zoned.

I would simplify this paragraph down to:

  1 for a host-managed zoned device or 0 for a non-zoned device.

> +
> +  .. option:: zone_size
> +
> +    The size of a zone of the zoned device in bytes. The device is divid=
ed

The first sentence is a little confusing due to the repetition of the
word "zone". It can be shortened:

  The size of a zone, in bytes.

> +    into zones of this size with the exception of the last zone, which m=
ay
> +    be smaller.
> +
> +  .. option:: zone_capacity
> +
> +    The initial capacity value for all zones. The capacity must be less =
than

  The initial capacity value, in bytes, for all zones.

> +    or equal to zone size. If the last zone is smaller, then its capacit=
y is
> +    capped. The device follows the ZBC protocol tends to have the same s=
ize
> +    as its zone.

I think the last sentence says that ZBC devices tend to have capacity =3D=3D
len whereas ZNS devices may have a unique capacity for each zone? You
could drop this last sentence completely.

> +
> +    The zone capacity is per zone and may be different between zones in =
real
> +    devices. For simplicity, limits QCow2 emulation to the same zone cap=
acity
> +    for all zones.

The last sentence:

  For simplicity, qcow2 sets all zones to the same capacity.

> +
> +  .. option:: zone_nr_conv
> +
> +    The number of conventional zones of the zoned device.
> +
> +  .. option:: max_open_zones
> +
> +    The maximal allowed open zones.
> +
> +  .. option:: max_active_zones
> +
> +    The limit of the zones with implicit open, explicit open or closed s=
tate.
> +
> +  .. option:: max_append_sectors
> +
> +    The maximal sectors in 512B blocks that is allowed to append to zones
> +    while writing.

Rephrasing:

  The maximum number of 512-byte sectors in a zone append request.

> +
>  .. program:: image-formats
>  .. option:: qed
> =20
> --=20
> 2.40.1
>=20

--xul6HmWXIVcilGtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT44HAACgkQnKSrs4Gr
c8hbOggAwzcb3wQFxirCOymAUAG+DoI/IiNrtgCJ2rcWep/ByTwcuatpq53b1PC2
eNB57BsMyNtEefCe1+XoCORcyQVtd9mkhpTTyMjpkaEBamzhktlnwtHSPptdqBS8
2MEy0UPu5yXTOHQFGxyLacWjzoVbh5CrIsuIeABPcAKqwfjFvI/QLiJcc4/HVPLY
afRruSXgBIK4M3mlbL7JDHXRJ5zvwwHc3uvkPuu65VobPo4NQbCyiDGJgQyBBCW1
OxUQon1ErvbDvydyhvZ3RRRjRNqTAxXWarSlukUHo4TCvizOPHatcAFx6DBPBltU
ljF7BhisLETZKfU5K9+q09NiISUwow==
=rxPK
-----END PGP SIGNATURE-----

--xul6HmWXIVcilGtY--


