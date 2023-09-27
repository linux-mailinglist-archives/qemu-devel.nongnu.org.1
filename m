Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA557B0B92
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 20:00:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlYoA-0003PE-1f; Wed, 27 Sep 2023 13:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlYo7-0003Oe-O7
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 13:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlYo5-0004NR-TJ
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 13:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695837518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fKNekV4swq5BvWA3Mls3pjKsqyDGj3YcQGzddYH0ozs=;
 b=DFgBpCl4+O4kXgP1AXIYVKvB5QbHSO6Di1BdDeRoEBIW2iwKHAkjxGVlYdpPy9zPkIodpL
 gy4LjHlXo+h7LFddSc28+IrKMLVZEGvguUU9Kecit7EuyfoM5n1DX2nj6Zi4FkQQTvto0Y
 caFwf9zmLus1RBIuG6X+PqUNAM6MuZA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-H57yse-cPSeCbshXXeE9vQ-1; Wed, 27 Sep 2023 13:58:34 -0400
X-MC-Unique: H57yse-cPSeCbshXXeE9vQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86F99800B35;
 Wed, 27 Sep 2023 17:58:34 +0000 (UTC)
Received: from localhost (unknown [10.39.193.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1629492B16;
 Wed, 27 Sep 2023 17:58:28 +0000 (UTC)
Date: Wed, 27 Sep 2023 13:58:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 0/8] migration fixes
Message-ID: <20230927175827.GA488606@fedora>
References: <20230918172822.19052-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AjB/tDjz7QXZLiMT"
Content-Disposition: inline
In-Reply-To: <20230918172822.19052-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--AjB/tDjz7QXZLiMT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 02:28:14PM -0300, Fabiano Rosas wrote:
> This series contains fixes for the two currently know failures that
> show up in migration tests plus a set of fixes for some theoretical
> race conditions around QEMUFile handling.
>=20
> Patch 1 addresses the issue found in the postcopy/preempt/plain test:
> https://gitlab.com/qemu-project/qemu/-/issues/1886
>=20
> Patch 7 fixes a rare crash during the postocpy/preempt/recovery/plain tes=
t:
>=20
>   Thread 7 "return path" received signal SIGSEGV, Segmentation fault.
>       0x00005555560e4893 in qemu_file_get_error_obj (f=3D0x0, errp=3D0x0)=
 at ../migration/qemu-file.c:154
>       154         return f->last_error;
>=20
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1008652837
>=20
> Fabiano Rosas (7):
>   migration: Fix possible race when setting rp_state.error
>   migration: Fix possible races when shutting down the return path
>   migration: Fix possible race when shutting down to_dst_file
>   migration: Remove redundant cleanup of postcopy_qemufile_src
>   migration: Consolidate return path closing code
>   migration: Replace the return path retry logic
>   migration: Move return path cleanup to main migration thread
>=20
> Peter Xu (1):
>   migration: Fix race that dest preempt thread close too early
>=20
>  migration/migration.c    | 145 +++++++++++++++------------------------
>  migration/migration.h    |  14 +++-
>  migration/postcopy-ram.c |  38 +++++++++-
>  3 files changed, 106 insertions(+), 91 deletions(-)

Applied to staging.

Thanks,
Stefan

--AjB/tDjz7QXZLiMT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUUbUMACgkQnKSrs4Gr
c8iJNQf/WeYHLDr5MpvOP3BL2UL5xk0NZv0K54IBiFW01NcfsPOmF9C9z4E1al9y
8BCGNME7CzhVkYWlNAEWeEycopFQqdrAInqx13U3faZ7STVa5V4fX4rigEjl0dln
CQU2gBkx9fW6UZ3QeVodsbuZRAM74myyEd7d8c5BKP2wExN09f76ri8wM36u7zG4
mOJii7qskl2hHPdpQQLBst7opjs/sDl6bFzlLm9U+cZcm1DIdNsum0Bul4jChVv3
wRsR9w99Nj1TxbXY4kdDLFaWHjZrwAIVKt3fyuTF+4ZqP3Kmb84vbbfl9184mH0t
Ylb7ETwNGy9u+Wu0b2y10Sqj1Fntvg==
=kGYA
-----END PGP SIGNATURE-----

--AjB/tDjz7QXZLiMT--


