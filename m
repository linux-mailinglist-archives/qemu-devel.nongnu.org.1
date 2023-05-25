Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F028271175F
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 21:26:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2GaX-0004Fq-SP; Thu, 25 May 2023 15:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2GaP-0004FV-5W
 for qemu-devel@nongnu.org; Thu, 25 May 2023 15:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2GaN-0004oZ-2t
 for qemu-devel@nongnu.org; Thu, 25 May 2023 15:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685042715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JCQyJT5CzKxKQ3CT2edu0x6VcoeXH8Zl1gXDqT14ogM=;
 b=FSYKOkdKIa8DHYU53kBdLD/8F6GIIl1Y6RCRhvs2dgJj6CVAjphKkOE5M5/uKcxWIjQVov
 qbekbBKdYed/L1Nvv6we719NimQCvmXCk5QxSKZodo80t1324EywfxDsWhmmTAalPlo714
 08m0WZftOA49WUW6tQYBWZxzhkIPxJ4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-DY_ZOO_dPSmNYCPwzzzFRw-1; Thu, 25 May 2023 15:25:08 -0400
X-MC-Unique: DY_ZOO_dPSmNYCPwzzzFRw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C05885A5AA;
 Thu, 25 May 2023 19:25:07 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 709F840C6CCF;
 Thu, 25 May 2023 19:25:06 +0000 (UTC)
Date: Thu, 25 May 2023 15:25:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 libvir-list@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v5 04/10] scripts/qapi: document the tool that generated
 the file
Message-ID: <20230525192504.GA140694@fedora>
References: <20230524133952.3971948-1-alex.bennee@linaro.org>
 <20230524133952.3971948-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CA9Nq6afzQW716uj"
Content-Disposition: inline
In-Reply-To: <20230524133952.3971948-5-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--CA9Nq6afzQW716uj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 02:39:46PM +0100, Alex Benn=E9e wrote:
> This makes it a little easier for developers to find where things
> where being generated.
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Message-Id: <20230523125000.3674739-5-alex.bennee@linaro.org>
> ---
>  scripts/qapi/gen.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index 8f8f784f4a..2ea27ef31c 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -13,6 +13,7 @@
> =20
>  from contextlib import contextmanager
>  import os
> +import sys
>  import re
>  from typing import (
>      Dict,
> @@ -162,7 +163,7 @@ def __init__(self, fname: str, blurb: str, pydoc: str=
):
> =20
>      def _top(self) -> str:
>          return mcgen('''
> -/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
> +/* AUTOMATICALLY GENERATED by %(tool)s DO NOT MODIFY */
> =20
>  /*
>  %(blurb)s
> @@ -174,6 +175,7 @@ def _top(self) -> str:
>   */
> =20
>  ''',
> +                     tool=3Dstr(os.path.basename(sys.argv[0])),

Why is str() used here? %s already produces a string representation of
whatever value you give it (e.g. '%s' % 123 -> '123').

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CA9Nq6afzQW716uj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRvthAACgkQnKSrs4Gr
c8gtdAgAht9atR1TL9xbYFhemfnTR1hC0VMW7M2aau1B0osH04MUcE3Y19L8+G+o
w+JBod7pA3EMH2CpF3DCVTDb4OF+Aoqnty+MrJvxXGk1WEk7f+Ad2/FoYTxRsjD5
mIiCiQZbpELFksSqHVrrDCS3U3E9lZoykgJJVuyDUWTSk1OrdmNC03+NOJT7KZlh
bkRfS7vJvKBPh5ijw7HLxbwcEaXtrthH/+BhCnajmzN/ft0N9pn90qOXyiYUGI6R
UjXm3NqChuKVdl+bpJQeWeT/xVPF2Vg05bQsvw9bXcsjHbwCJDvA/SR36DyyDvj+
6zDi7H4zJ/HI1rDz76zG4e8WphDMkw==
=WiLk
-----END PGP SIGNATURE-----

--CA9Nq6afzQW716uj--


