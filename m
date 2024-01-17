Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7C8830823
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:33:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6xr-0001JA-6u; Wed, 17 Jan 2024 09:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQ6xg-0001Gu-BL
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:32:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQ6xd-0006Yg-P0
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705501928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VyyCMygzCNuHsy/BsfF3Uwn6ZzpGQySnXrJp6xeYVgQ=;
 b=Fk5NhFreIulJf1KLo+gK81GVS0ejmP1V4Wy3yw+rqxC+AtDErynR2y8zWIyCxnWRcsWHIm
 JI3QVJcztw0Gi4MACqY75ASWU7ziuJFkLfyouYM7GAVEfXHSC0/aBEqai60CZo6RkR+r5t
 9mKldEP+/X0JWrEv98Xw8AhChkDgymw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-vgjmjTZePH2sTvr4t_wJQA-1; Wed, 17 Jan 2024 09:32:04 -0500
X-MC-Unique: vgjmjTZePH2sTvr4t_wJQA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06DA285A597;
 Wed, 17 Jan 2024 14:32:04 +0000 (UTC)
Received: from localhost (unknown [10.39.194.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F1502166B32;
 Wed, 17 Jan 2024 14:32:03 +0000 (UTC)
Date: Wed, 17 Jan 2024 09:32:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, fam@euphon.net
Subject: Re: [PATCH] block/io: clear BDRV_BLOCK_RECURSE flag after recursing
 in bdrv_co_block_status
Message-ID: <20240117143202.GA1404231@fedora>
References: <20240116154839.401030-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sB+5/Q6+wBdAyCwP"
Content-Disposition: inline
In-Reply-To: <20240116154839.401030-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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


--sB+5/Q6+wBdAyCwP
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

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--sB+5/Q6+wBdAyCwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWn5OEACgkQnKSrs4Gr
c8gilAgApwNxOqlA6o8KdcWlVyzBt5/JNRgFPtUdk342quq7yyfcr50beRIpSX/k
zStaPrMeFqEeGz0yDz+k3Ptk7Edzbs/O3GuDEu1Ziv4KsJu5ZY+kkF7j+qJ6IZwe
D+oUhtgINIgYzJjepixwKrltTC5ov4J2AkiLyN+7GexvTirpDstpGFcw1ypi74ow
r19RfeF4OZM94BJQhwFko0OUNzv9xR/qm0GNt6EFzdrmXcDQ6q4DTO9g5jIIANjh
Z++94wKJvdIkI579JQuf3VMEB7unu2FZ9fBG0tE5YGVXH55NJ++tZLUNAgLlMSt+
haVB1p/QTK3fq6QWmhj7u3v2et3rdA==
=r1zw
-----END PGP SIGNATURE-----

--sB+5/Q6+wBdAyCwP--


