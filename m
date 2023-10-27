Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEBF7D9EED
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 19:35:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwQiQ-0000vc-UY; Fri, 27 Oct 2023 13:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qwQiL-0000v4-DV
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 13:33:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qwQiH-00025M-Oi
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 13:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698428015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oMMnbF1+LcrBZ2XeGxip0fQN3VCr0JPbkyyuyBDZy4M=;
 b=MxzB5Ndldzq4XUee8ydblkkOVI36N82EItY4EKqcqtu7t6x/kl3b0oFFeSO5ZEvOMjXtNG
 0ZSoVqJymarOfvVLo/6JyNHLwMK5WYvfacKnMuT4pgHy2QmgVb2hAjR7ApdJveGUKskWJV
 qshiZDl2rk+aFOVs/nl6+iYm4kWvMSE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-imMu03xGPHuPqbLaaaDSsw-1; Fri, 27 Oct 2023 13:33:33 -0400
X-MC-Unique: imMu03xGPHuPqbLaaaDSsw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC246101A52D
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 17:33:32 +0000 (UTC)
Received: from localhost (unknown [10.45.224.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 467D41121314;
 Fri, 27 Oct 2023 17:33:31 +0000 (UTC)
Date: Fri, 27 Oct 2023 19:33:30 +0200
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v2 00/11] qapi-go: add generator for Golang interface
Message-ID: <5drfnt5rr5jmjl7xv65355squ2zzjra23mdrk5q3avnbue4kqx@7pmoj2zwfggx>
References: <20231016152704.221611-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rru5wego3yfwjdhp"
Content-Disposition: inline
In-Reply-To: <20231016152704.221611-1-victortoso@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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


--rru5wego3yfwjdhp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Daniel & Andrea, it would be great to have your take on the Go
side of this series. If we can agree with an acceptable
'unstable' version of Go modules, we can start building on top of
this:
 - libraries/tools in Go to interact with QEMU
 - qapi specs to fix limitations (e.g: Data type names)
 - scripts/qapi library wrt to generating interfaces in other
   languages other than C

I would love to have this prior to 8.2 feature freeze if the
idea and current code meet your expectations.

Cheers,
Victor

On Mon, Oct 16, 2023 at 05:26:53PM +0200, Victor Toso wrote:
> This patch series intent is to introduce a generator that produces a Go
> module for Go applications to interact over QMP with QEMU.
>=20
> This is the second iteration:
>  v1: https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg06734.html
>=20
> I've pushed this series in my gitlab fork:
> https://gitlab.com/victortoso/qemu/-/tree/qapi-golang-v2
>=20
> I've also generated the qapi-go module over QEMU tags: v7.0.0, v7.1.0,
> v7.2.6, v8.0.0 and v8.1.0, see the commits history here:
> https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v2-by-tags
>=20
> I've also generated the qapi-go module over each commit of this series,
> see the commits history here (using previous refered qapi-golang-v2)
> https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v2-by-patch
>=20
> Cheers,
> Victor
>=20
> * Changes:
>  - All patches were rebased using black python formatting tool, awesome.
>    (John) https://black.readthedocs.io/en/stable/
>  - All patches were tested with flake8 and pylint. Minor complains
>    remains. (John)
>  - All generated types are sorted in alphabetical order (Daniel)
>  - Using utf8 instead of ascii encoding of output files
>  - Improved commit logs
>  - renamed QapiError -> QAPIError (Daniel)
>  - QAPIError's Error() returns only the description (Daniel)
>  - Used more type hints (Where I could) (John)
>  - Removed typehint from self in the Class implementation (John)
>  - The Go code that is generated is now well formated. gofmt -w and
>    goimport -w don't change a thing.
>  - Added a fix from John
>    https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01305.html
>  - Added a tangent fix suggestion to main.py "scripts: qapi: black
>    format main.py"
>=20
> John Snow (1):
>   qapi: re-establish linting baseline
>=20
> Victor Toso (10):
>   scripts: qapi: black format main.py
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
>  docs/devel/index-build.rst          |    1 +
>  docs/devel/qapi-golang-code-gen.rst |  376 ++++++++
>  scripts/qapi/gen.py                 |    2 +-
>  scripts/qapi/golang.py              | 1349 +++++++++++++++++++++++++++
>  scripts/qapi/main.py                |   79 +-
>  scripts/qapi/parser.py              |    5 +-
>  6 files changed, 1781 insertions(+), 31 deletions(-)
>  create mode 100644 docs/devel/qapi-golang-code-gen.rst
>  create mode 100644 scripts/qapi/golang.py
>=20
> --=20
> 2.41.0
>=20
>=20

--rru5wego3yfwjdhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmU79GoACgkQl9kSPeN6
SE+grhAAqG/Ycez6IuGXcV+IvpkRhvEplejlhBf6iMu2+Gx0ZdVfiWVA9pc4indt
und+lgFlqSNvZkU66zDzdQzRD20EgbzadyaiqW5MqVfa/QCh0ckuroDlJ1h7X3FT
oPa/yLPsdCtdN017GsJOMo4eHpgOCikbpMS8vKJPCjEW2R2UNbTBPLor2mSi4Iq1
eCPhF3v8sGLUNO5Qwi2HkTlny6qZtgG1JkxmKbycyc0c9TjdtcifKnpvBeFHURQx
noJSYJ8oaYvzkxuw6BjJiAAsp/OnMpN6J1t7XmxmisUBSDByJXHTXEpFxeHmnObQ
+1NlWbcSa7ufnE+/BWQyQqYLMwSrz5nPuHOUCl684AP9obKJVB/TRPjNfiiQ9yCs
+OLuPgCtieTxsSArdzMA+tSikJ3JmPAqoMFrGZH0mrpnCl4cPGtdK/G9Y7uR30pI
6fM6gdohz75KzHhhOSkDB3WTNLKzOqBb2Qz18JVQn3nTW3mJ/SSLdIBv+9jZ2tGA
VtGIgcFCfOAldyTwKVEv42J7dVXYCnyvZ6bDqEl1y2Iv4bN4RaDqJfqUW8mBjp00
UzBT8rpaI6Mo82MwgfU7x32AFQ1Ttdzy1lTwxJAfnGK7rB//pAs8H3IhKiGK6H6O
JMaCOOGL9NuG+OKiqn/Cwu8UQR2nhuRNQIclbmlZCjQKsf9K5OQ=
=kFk1
-----END PGP SIGNATURE-----

--rru5wego3yfwjdhp--


