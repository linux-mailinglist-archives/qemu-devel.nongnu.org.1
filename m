Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2135C7A8C22
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:58:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2OA-0006xL-3g; Wed, 20 Sep 2023 14:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj2O7-0006x3-AE
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj2O5-0007Vn-Cz
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695236243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TiStE50taKJ0UQAqOFUMipgCBb5F/9SH6N/TTJh83Uo=;
 b=f3S8IY0Q/kGkWtCKQqgkkn0PnyYAEBevcpYvjiZf9wYrlxYyEZWxHjEjTiu3ov1oF+aM8A
 xvXdvv8fG5aGenCnQbvg31A5qkTnAXIITMy6XwZ5LVdbMbx0y6Lup6lFIXRXE/b0QKInor
 XYBrWsIjaxi5ELRHJCUkhgAv0lXG7tU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-YFDaFE30PNiB6odT32NCAw-1; Wed, 20 Sep 2023 14:57:22 -0400
X-MC-Unique: YFDaFE30PNiB6odT32NCAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89196811E7E;
 Wed, 20 Sep 2023 18:57:21 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F28C28FD;
 Wed, 20 Sep 2023 18:57:20 +0000 (UTC)
Date: Wed, 20 Sep 2023 14:57:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
Subject: Re: [PATCH v4 03/14] simpletrace: improve parsing of sys.argv; fix
 files never closed.
Message-ID: <20230920185719.GC1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-4-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FKxN6fA9gGvxlC0F"
Content-Disposition: inline
In-Reply-To: <20230823085429.20519-4-mads@ynddal.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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


--FKxN6fA9gGvxlC0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:54:18AM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> The arguments extracted from `sys.argv` named and unpacked to make it
> clear what the arguments are and what they're used for.
>=20
> The two input files were opened, but never explicitly closed. File usage
> changed to use `with` statement to take care of this. At the same time,
> ownership of the file-object is moved up to `run` function. Added option
> to process to support file-like objects.
>=20
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>  scripts/simpletrace.py | 50 ++++++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FKxN6fA9gGvxlC0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULQI8ACgkQnKSrs4Gr
c8iNOwf/Y6scf4nbMc6rVvVuyDqSxKW4/TmjBzSClFM4FUQNFcHQ5wWscPVpPCZY
ynUnQcGXeE5rakmZkMmuHdfJ5OAINfOLK+m6r6EkB9nOEVGqS7pb908J6CTFdrZ7
7mkDjGTUlbhx/4cN7NDvix6UjgtT/ENzRonhkqetMzQZr+lchgeSsWhtI8kQ9WdL
HhVDzj13UgWhw90sTrhmLCx/E78Zc8C14UNTeZjzvVm3SnV5UxfzyyxC9qoB1Hc/
C59fq8OcYMEfu3CN9DbMeaGCVX9dg86sL7XVDGiswV9fM+JD/sfsB2IOXq5A1Qw4
ju7CgKj9HsDjVXXRNmY+dQlIVGn6pw==
=/Rkx
-----END PGP SIGNATURE-----

--FKxN6fA9gGvxlC0F--


