Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 540E079A79A
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:27:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qff3t-0007ll-69; Mon, 11 Sep 2023 07:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qff3r-0007lc-J3
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qff3p-0007O6-3e
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694431592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NrU0+FxSdSG2R3ExQKbpCBuVSJFkQ8tUQd3WEU+I9lg=;
 b=SAUGIDExSWKPXayfsSGGW/a1ItcsLYemCB+yNIPmybfXDCp0PzE5JITi2XAkwcpIARD7bx
 TrL+pD3CNHh3Y6ae3x4Wvx2z0LRaklaNs5qX/XRX0Bu8/rNTa49c/ht4fBv4fpg2lyxiK2
 Ai80QFCgG3NfBTbNqGBtvrufAEVC1k8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-7Wd5EW6kNu2mtA5exLRZYw-1; Mon, 11 Sep 2023 07:26:30 -0400
X-MC-Unique: 7Wd5EW6kNu2mtA5exLRZYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39F0E381CC0D
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 11:26:30 +0000 (UTC)
Received: from localhost (unknown [10.45.225.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE3CF40C6EA8;
 Mon, 11 Sep 2023 11:26:29 +0000 (UTC)
Date: Mon, 11 Sep 2023 13:26:28 +0200
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 10/11] qapi: meson: add test flag to allow skip
 generators
Message-ID: <zgd2szbc3uso6epxxrznxjtwt3ngrj7eqtr56lcdoitisbha4h@hpb5q5dl426p>
References: <20230911111324.74940-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gevxu67nnendyhbx"
Content-Disposition: inline
In-Reply-To: <20230911111324.74940-1-victortoso@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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


--gevxu67nnendyhbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry, this two are part of v2, did a mistake with
git-send-email. I'll add them to the right thread with
--in-reply-to shortly (without cc, to avoid spamming people's
inbox)

v2: https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg02383.html

Cheers,
Victor

On Mon, Sep 11, 2023 at 01:13:23PM +0200, Victor Toso wrote:
> The next patch adds a generator that also validates qapi
> documentation. We don't want to execute it with a test schema.
>=20
> Signed-off-by: Victor Toso <victortoso@redhat.com>
> ---
>  scripts/qapi/main.py | 4 ++++
>  tests/meson.build    | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> index 316736b6a2..7efdcc6b8d 100644
> --- a/scripts/qapi/main.py
> +++ b/scripts/qapi/main.py
> @@ -33,6 +33,7 @@ def generate(schema_file: str,
>               prefix: str,
>               unmask: bool =3D False,
>               builtins: bool =3D False,
> +             test_schema: bool =3D False,
>               gen_tracing: bool =3D False) -> None:
>      """
>      Generate C code for the given schema into the target directory.
> @@ -75,6 +76,8 @@ def main() -> int:
>      parser.add_argument('-u', '--unmask-non-abi-names', action=3D'store_=
true',
>                          dest=3D'unmask',
>                          help=3D"expose non-ABI names in introspection")
> +    parser.add_argument('-t', '--tests', action=3D'store_true',
> +                        help=3D"flag generator that is running with a te=
st schema")
> =20
>      # Option --suppress-tracing exists so we can avoid solving build sys=
tem
>      # problems.  TODO Drop it when we no longer need it.
> @@ -96,6 +99,7 @@ def main() -> int:
>                   prefix=3Dargs.prefix,
>                   unmask=3Dargs.unmask,
>                   builtins=3Dargs.builtins,
> +                 test_schema=3Dargs.tests,
>                   gen_tracing=3Dnot args.suppress_tracing)
>      except QAPIError as err:
>          print(err, file=3Dsys.stderr)
> diff --git a/tests/meson.build b/tests/meson.build
> index debaa4505e..ed0844a6a0 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -43,7 +43,7 @@ test_qapi_files =3D custom_target('Test QAPI files',
>                                               'qapi-schema/include/sub-mo=
dule.json',
>                                               'qapi-schema/sub-sub-module=
=2Ejson'),
>                                  command: [ qapi_gen, '-o', meson.current=
_build_dir(),
> -                                           '-b', '-p', 'test-', '@INPUT0=
@',
> +                                           '-t', '-b', '-p', 'test-', '@=
INPUT0@',
>                                             '--suppress-tracing' ],
>                                  depend_files: qapi_gen_depends)
> =20
> --=20
> 2.41.0
>=20
>=20

--gevxu67nnendyhbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmT++WQACgkQl9kSPeN6
SE+0YhAAnS6QJKeHAeaDHShXBhWx2O9ZDG8l5x+Q1pI6nC54oILWban2dBCEPywl
lRJodb4BdpfSy5sWk3UYKcyc6sLilLKoxrqJBshY1Ll9gTo6XAK1o1/byIf4EGDz
UbKjQYpC+lFdCqawGOv9yf4lzyZxV1LTsIZlR3XUHFvj50X2UbGWq8kiyJ86jL9r
kgIQ3f919qkXnQa8FBJ9LZ17zHEh4IBAp7sZj77xufN2U5udCeucXPpuYFakiAVE
Hn36B3+2Q8v+XaqT/b8vzwgfsutHpaAK7DE1TynsRpSf94ESXnJYmwSHs3X4KktP
94YEi8NfDI1KxE2HrFwuzU9LGlS8gYIh0rXccRwAQZam7swtoEmmGF9t0lgAy7cH
7MBIAAV8en/d8S7zerxaHA90OHjCoC7+no6MknDym+X4Cr5HhoiwStIMs8yekt9E
epJI2tWKjQEmQ6qbIB97V1e3KlosApmKjFEfqkvouwVMBxcJh24I9+p3MDqhe8kb
6TiyU6hNTGFVrA0hpkNhLYHhOXj2aUTDvl2ve8hJyJzgcKl4RLOgKZtL5n3g4dmY
p82TvzaXGh1j39ptqF2niN3JIt4KqwoOr7LNJyKdb2tgP35hsqo6v2WZE2zyAVds
nDpMlHazedLAGtuT68r1U5wscFqQ25lwUwflsQ7gb7wGseAjFeU=
=ugJx
-----END PGP SIGNATURE-----

--gevxu67nnendyhbx--


