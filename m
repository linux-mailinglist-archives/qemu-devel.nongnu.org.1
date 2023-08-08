Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB5E7740BC
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:09:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQCA-0000KP-CY; Tue, 08 Aug 2023 13:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qTQC7-0000Jt-ED
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:08:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qTQC5-00033A-QR
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691514509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bCdig3AnflnQgSvG2pmvFsRs9dQV6SVNmg/Ic2gWHgY=;
 b=hdabOXzz/QZBXPAph8K7A0m0be95QAD3VneBeVjbxF4kuTRGsxEVKhi1yybPE7BLj9vfgn
 0UPjuSDyH6EPnkYkPugId346r4qsHhwtj3D3qSDJXszdCewxcEgMI3PXSzz5K+TXye/k9G
 L5RT/JgVueJ2bNkjnDJjQLnS0xjNlD0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-8qpXIHfnMouVzSnDK8M1bQ-1; Tue, 08 Aug 2023 13:08:27 -0400
X-MC-Unique: 8qpXIHfnMouVzSnDK8M1bQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D1AF3810D52;
 Tue,  8 Aug 2023 17:08:26 +0000 (UTC)
Received: from localhost (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E790F40C6E8A;
 Tue,  8 Aug 2023 17:08:25 +0000 (UTC)
Date: Tue, 8 Aug 2023 13:08:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] block-migration: Ensure we don't crash during migration
 cleanup
Message-ID: <20230808170823.GA2749198@fedora>
References: <20230731203338.27581-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="w3WvynHDOgtd7Czt"
Content-Disposition: inline
In-Reply-To: <20230731203338.27581-1-farosas@suse.de>
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


--w3WvynHDOgtd7Czt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 05:33:38PM -0300, Fabiano Rosas wrote:
> We can fail the blk_insert_bs() at init_blk_migration(), leaving the
> BlkMigDevState without a dirty_bitmap and BlockDriverState. Account
> for the possibly missing elements when doing cleanup.
>=20
> Fix the following crashes:
>=20
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> 0x0000555555ec83ef in bdrv_release_dirty_bitmap (bitmap=3D0x0) at ../bloc=
k/dirty-bitmap.c:359
> 359         BlockDriverState *bs =3D bitmap->bs;
>  #0  0x0000555555ec83ef in bdrv_release_dirty_bitmap (bitmap=3D0x0) at ..=
/block/dirty-bitmap.c:359
>  #1  0x0000555555bba331 in unset_dirty_tracking () at ../migration/block.=
c:371
>  #2  0x0000555555bbad98 in block_migration_cleanup_bmds () at ../migratio=
n/block.c:681
>=20
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> 0x0000555555e971ff in bdrv_op_unblock (bs=3D0x0, op=3DBLOCK_OP_TYPE_BACKU=
P_SOURCE, reason=3D0x0) at ../block.c:7073
> 7073        QLIST_FOREACH_SAFE(blocker, &bs->op_blockers[op], list, next)=
 {
>  #0  0x0000555555e971ff in bdrv_op_unblock (bs=3D0x0, op=3DBLOCK_OP_TYPE_=
BACKUP_SOURCE, reason=3D0x0) at ../block.c:7073
>  #1  0x0000555555e9734a in bdrv_op_unblock_all (bs=3D0x0, reason=3D0x0) a=
t ../block.c:7095
>  #2  0x0000555555bbae13 in block_migration_cleanup_bmds () at ../migratio=
n/block.c:690
>=20
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/block.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Sorry, I missed this patch!

If this needs to be in QEMU 8.1 (-rc3 is being tagged today), please
reply and provide a justification. At this point only security fixes and
showstoppers will be merged. Thanks!

Applied to my block-next tree for QEMU 8.2:
https://gitlab.com/stefanha/qemu/commits/block-next

Stefan

--w3WvynHDOgtd7Czt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTSdocACgkQnKSrs4Gr
c8g4ZQgAwUqNRNE9sLz3M6hcqJZUtUQosWOpMIj0hYBHjpXQpy7zxhmTCMYGXvzI
7U/VIsnbCT8DbQ7SRrssLeG9/IeqhgNsvdCLVGzrqwnO3ClijpaVIfIOnIQYJTwX
gFz7Tq7RE30QHbycRoP3tqQ+NRdvJRAFW/zk9SGAvabUGtZJRElLc6m1wCHGYWHz
6toU+wiQVL8S1NGaMsur8YcmWxFLRrUI0QaARmoJtBNzLWWaEeJSXDfqL/gQPvmF
qEvWoUO8HBf0j8vI4vY84da+xB5ylonVWuUFUAQ2jqg9490DHtMNeshWk7Pah4wc
SrZAvMHXpVvKYERYmXDViCsgPQLWDw==
=AcRF
-----END PGP SIGNATURE-----

--w3WvynHDOgtd7Czt--


