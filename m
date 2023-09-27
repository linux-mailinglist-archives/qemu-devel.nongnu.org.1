Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 149B57B033A
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:39:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSsP-0005QD-7V; Wed, 27 Sep 2023 07:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSsJ-0005Pp-AO
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSsG-0006NA-Dd
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695814713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rTnpT4aZxs9komRyhCjMKKp3wNcjUxldTKjxZ4eiRyQ=;
 b=gBT5rk/Qjdq5aW06dfw04gVyxM5p6kfeU3o4PZPUoxhqnVRo/JSStnbIFyvECfM/MSHDge
 c3tD9COZPn4kXE0VqLN2PswJyQJnxa7WwIlw5UwHGgaX0ErmqMZx+mfQPkB3ptB1s9a6Pl
 We3XP+ZVMfPNrxxwXC1uy3IFTla6fec=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-rjiVi-cTO1S8pzlmzJhmjA-1; Wed, 27 Sep 2023 07:38:31 -0400
X-MC-Unique: rjiVi-cTO1S8pzlmzJhmjA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 625951C068D1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 11:38:31 +0000 (UTC)
Received: from localhost (unknown [10.45.224.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F41D340C2064;
 Wed, 27 Sep 2023 11:38:30 +0000 (UTC)
Date: Wed, 27 Sep 2023 13:38:29 +0200
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v1 0/9] qapi-go: add generator for Golang interface
Message-ID: <mxrq3tlzuk2ubc5xl3vckqvchrrgpvygwc5cwtvvnb4pqkyijq@armzaivij7np>
References: <20230927112544.85011-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s4ahrork4mjjrm6r"
Content-Disposition: inline
In-Reply-To: <20230927112544.85011-1-victortoso@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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


--s4ahrork4mjjrm6r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 01:25:35PM +0200, Victor Toso wrote:
> Hi, long time no see!
>=20
> This patch series intent is to introduce a generator that produces a Go
> module for Go applications to interact over QMP with QEMU.
>=20
> This idea was discussed before, as RFC:
>  (RFC v1) https://lists.gnu.org/archive/html/qemu-devel/2022-04/msg00226.=
html
>  (RFC v2) https://lists.gnu.org/archive/html/qemu-devel/2022-04/msg00226.=
html

Bad copy-paste, the correct one:
    https://lists.gnu.org/archive/html/qemu-devel/2022-06/msg03105.html

>=20
> The work got stuck due to changes needed around types that can take JSON
> Null as value, but that's now fixed.
>=20
> I've pushed this series in my gitlab fork:
>     https://gitlab.com/victortoso/qemu/-/tree/qapi-golang-v1
>=20
> I've also generated the qapi-go module over QEMU tags: v7.0.0, v7.1.0,
> v7.2.6, v8.0.0 and v8.1.1, see the commits history here:
>     https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v1-by-tags
>=20
> I've also generated the qapi-go module over each commit of this series,
> see the commits history here (using previous refered qapi-golang-v1)
>     https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v1-by-pat=
ch
>=20
>=20
>  * Why this?
>=20
> My main goal is to allow Go applications that interact with QEMU to have
> a native way of doing so.
>=20
> Ideally, we can merge a new QAPI command, update qapi-go module to allow
> Go applications to consume the new command in no time (e.g: if
> development of said applications are using latest QEMU)
>=20
>=20
>  * Expectations
>=20
> From previous discussions, there are things that are still missing. One
> simple example is Andrea's annotation suggestion to fix type names. My
> proposal is to have a qapi-go module in a formal non-stable version till
> some of those tasks get addressed or we declare it a non-problem.
>=20
> I've created a docs/devel/qapi-golang-code-gen.rst to add information
> from the discussions we might have in this series. Suggestions always
> welcome.
>=20
> P.S: Sorry about my broken python :)
>=20
> Cheers,
> Victor
>=20
> Victor Toso (9):
>   qapi: golang: Generate qapi's enum types in Go
>   qapi: golang: Generate qapi's alternate types in Go
>   qapi: golang: Generate qapi's struct types in Go
>   qapi: golang: structs: Address 'null' members
>   qapi: golang: Generate qapi's union types in Go
>   qapi: golang: Generate qapi's event types in Go
>   qapi: golang: Generate qapi's command types in Go
>   qapi: golang: Add CommandResult type to Go
>   docs: add notes on Golang code generator
>=20
>  docs/devel/qapi-golang-code-gen.rst |  341 +++++++++
>  scripts/qapi/golang.py              | 1047 +++++++++++++++++++++++++++
>  scripts/qapi/main.py                |    2 +
>  3 files changed, 1390 insertions(+)
>  create mode 100644 docs/devel/qapi-golang-code-gen.rst
>  create mode 100644 scripts/qapi/golang.py
>=20
> --=20
> 2.41.0
>=20
>=20

--s4ahrork4mjjrm6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUUFDUACgkQl9kSPeN6
SE9m7g/8DjFB7oyhdn1YmLjLNIFkOSfsm8pLyzZox9quyTJgZXkRIh+6AJr+xOOK
BARwu4AxWGff7177AogjOyZ8cOImNn5jw6QL8pmbCHRJmqVh29gUT93WAGOP0AB2
NO4CAr5gDOmMMy1uuAyILbdJsN4Gi+wr/ne7oiluO/rxsdP7i+n8K5CX0qp0BUdC
aFIzGvDR4c7jshNb13I1VHbFcwj/+qMwfbWTVIzAoLeIbNWboGeApJ+xh+fwx2YW
JNGTd9Y0SeAnJYIYczptNzES9sG8zRZ6qFgKqZh+NSPTd0RSFkhQFirUFnph34jU
HCbBjETkkP0vCAttpYRtnpMMTKw2eDLS4dSVE3jodEIgt95tSt6DyIZPl3/O9KV+
FZYfuCyyBLLbGI06M2v+LyIdrr9JthvI0OpVATFRX9wAdP+rOMxeoQaeTWR2ZToy
OJca5z/kgoX6osKg41sSCemRHThORovWkvOgyxiKRmGrFwUrt7VVY7+uDRfOUzaV
Gs20rHpR6dp/jlgH46HCBtZv7ttTEvRiDD1fVPXebKPSJYdoOxCdCyeSfH/5tXGi
sOhcGQ84i2WRVJrbR7G9ZYCHbv4iHNWuJxzaovZBL6M07zx7hiFOnwb0NhPy0Hmy
yzTxuiYAl+MqYIyAL5BbcY89RCT6hredVN9Xo6oLn3iUi5NKMGw=
=qttC
-----END PGP SIGNATURE-----

--s4ahrork4mjjrm6r--


