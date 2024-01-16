Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7B782FBF1
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 23:07:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPraZ-0005ny-EU; Tue, 16 Jan 2024 17:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rPra4-0005ia-SV
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:06:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rPra1-0002it-GH
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705442803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/mgweJalvCWTdkb4FdlBYhk7fdJqgYHzN12g8ihY2oM=;
 b=NfjMQEi09b4iR2ARnnqzfa9bx1ZwDxKnswNQdAiKfmpVhIo0JSnrtviP8LqU4KU37DilzO
 eeFgA6aCWNISthIoXAadPf71ZNzGzCxGJ/nAlaQY1hBE3H/HCZfAJLDvDByuhhoLHWQVx1
 keUuuLCZxxKna0O6exrjDGy459XBWQk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-RCyu8VEkPRqdsjrmcJ1wuQ-1; Tue,
 16 Jan 2024 17:06:40 -0500
X-MC-Unique: RCyu8VEkPRqdsjrmcJ1wuQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 090913C0F19C;
 Tue, 16 Jan 2024 22:06:40 +0000 (UTC)
Received: from localhost (unknown [10.39.192.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 009C5492BE6;
 Tue, 16 Jan 2024 22:06:38 +0000 (UTC)
Date: Tue, 16 Jan 2024 17:06:37 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, fam@euphon.net,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH] block/io: clear BDRV_BLOCK_RECURSE flag after recursing
 in bdrv_co_block_status
Message-ID: <20240116220637.GA1269179@fedora>
References: <20240116154839.401030-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GFwjnwwGFTAnNlk2"
Content-Disposition: inline
In-Reply-To: <20240116154839.401030-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--GFwjnwwGFTAnNlk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 04:48:39PM +0100, Fiona Ebner wrote:
> Using fleecing backup like in [0] on a qcow2 image (with metadata
> preallocation) can lead to the following assertion failure:
>=20
> > bdrv_co_do_block_status: Assertion `!(ret & BDRV_BLOCK_ZERO)' failed.
>=20
> In the reproducer [0], it happens because the BDRV_BLOCK_RECURSE flag
> will be set by the qcow2 driver, so the caller will recursively check
> the file child. Then the BDRV_BLOCK_ZERO set too. Later up the call
> chain, in bdrv_co_do_block_status() for the snapshot-access driver,
> the assertion failure will happen, because both flags are set.
>=20
> To fix it, clear the recurse flag after the recursive check was done.

CCing Vladimir, who introduced the BDRV_BLOCK_RECURSE flag in commit
69f47505ee66 ("block: avoid recursive block_status call if possible").

>=20
> In detail:
>=20
> > #0  qcow2_co_block_status
>=20
> Returns 0x45 =3D BDRV_BLOCK_RECURSE | BDRV_BLOCK_DATA |
> BDRV_BLOCK_OFFSET_VALID.
>=20
> > #1  bdrv_co_do_block_status
>=20
> Because of the data flag, bdrv_co_do_block_status() will now also set
> BDRV_BLOCK_ALLOCATED. Because of the recurse flag,
> bdrv_co_do_block_status() for the bdrv_file child will be called,
> which returns 0x16 =3D BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID |
> BDRV_BLOCK_ZERO. Now the return value inherits the zero flag.
>=20
> Returns 0x57 =3D BDRV_BLOCK_RECURSE | BDRV_BLOCK_DATA |
> BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_ZERO.
>=20
> > #2  bdrv_co_common_block_status_above
> > #3  bdrv_co_block_status_above
> > #4  bdrv_co_block_status
> > #5  cbw_co_snapshot_block_status
> > #6  bdrv_co_snapshot_block_status
> > #7  snapshot_access_co_block_status
> > #8  bdrv_co_do_block_status
>=20
> Return value is propagated all the way up to here, where the assertion
> failure happens, because BDRV_BLOCK_RECURSE and BDRV_BLOCK_ZERO are
> both set.
>=20
> > #9  bdrv_co_common_block_status_above
> > #10 bdrv_co_block_status_above
> > #11 block_copy_block_status
> > #12 block_copy_dirty_clusters
> > #13 block_copy_common
> > #14 block_copy_async_co_entry
> > #15 coroutine_trampoline
>=20
> [0]:
>=20
> > #!/bin/bash
> > rm /tmp/disk.qcow2
> > ./qemu-img create /tmp/disk.qcow2 -o preallocation=3Dmetadata -f qcow2 =
1G
> > ./qemu-img create /tmp/fleecing.qcow2 -f qcow2 1G
> > ./qemu-img create /tmp/backup.qcow2 -f qcow2 1G
> > ./qemu-system-x86_64 --qmp stdio \
> > --blockdev qcow2,node-name=3Dnode0,file.driver=3Dfile,file.filename=3D/=
tmp/disk.qcow2 \
> > --blockdev qcow2,node-name=3Dnode1,file.driver=3Dfile,file.filename=3D/=
tmp/fleecing.qcow2 \
> > --blockdev qcow2,node-name=3Dnode2,file.driver=3Dfile,file.filename=3D/=
tmp/backup.qcow2 \
> > <<EOF
> > {"execute": "qmp_capabilities"}
> > {"execute": "blockdev-add", "arguments": { "driver": "copy-before-write=
", "file": "node0", "target": "node1", "node-name": "node3" } }
> > {"execute": "blockdev-add", "arguments": { "driver": "snapshot-access",=
 "file": "node3", "node-name": "snap0" } }
> > {"execute": "blockdev-backup", "arguments": { "device": "snap0", "targe=
t": "node1", "sync": "full", "job-id": "backup0" } }
> > EOF
>=20
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>=20
> I'm new to this part of the code, so I'm not sure if it is actually
> safe to clear the flag? Intuitively, I'd expect it to be only relevant
> until it was acted upon, but no clue.
>=20
>  block/io.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/block/io.c b/block/io.c
> index 8fa7670571..33150c0359 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2584,6 +2584,16 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool=
 want_zero,
>                  ret |=3D (ret2 & BDRV_BLOCK_ZERO);
>              }
>          }
> +
> +        /*
> +         * Now that the recursive search was done, clear the flag. Other=
wise,
> +         * with more complicated block graphs like snapshot-access ->
> +         * copy-before-write -> qcow2, where the return value will be pr=
opagated
> +         * further up to a parent bdrv_co_do_block_status() call, both t=
he
> +         * BDRV_BLOCK_RECURSE and BDRV_BLOCK_ZERO flags would be set, wh=
ich is
> +         * not allowed.
> +         */
> +        ret &=3D ~BDRV_BLOCK_RECURSE;
>      }
> =20
>  out:
> --=20
> 2.39.2
>=20
>=20

--GFwjnwwGFTAnNlk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWm/ewACgkQnKSrs4Gr
c8joBgf9EH7RJdWP26oy98RjyJ8w8OIgIBwQS7+DrzAEo5JfnJ7VI9jEf+0uiwhs
UMlxZCom8WF/kg/4BjD1fK18hmrM+iT8WhQN9mjuILV9mvRqUjpR9rI/K1f2c2Or
7ClWwAW/wPK+1DV+oYLTWNeJKCyS5zwcnGiuh6P6iXFepOERl5MRAokYquOOc8pS
wP/Xs458bAj9iBzcsNkLDtljbr3EIqlJarzUDinLrplqFUkNH8EAJJCjC/EJKhSw
GGn1NxUE8sJOqJIEwIaX4pN8blO8LjfjcTCebcRAVm634K+AXfkC63oBmLrL5ROk
LRVz7S5yEkv8ZeRHsC7Op+PXbJHLkA==
=VPlM
-----END PGP SIGNATURE-----

--GFwjnwwGFTAnNlk2--


