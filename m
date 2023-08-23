Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF91478587D
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 15:06:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYnYW-0006kv-Rk; Wed, 23 Aug 2023 09:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYnYU-0006kP-BK
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 09:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYnYS-00032L-Qe
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 09:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692795947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gVCDFsUxyk8XXQBe7ncGEuR9XeB7t7U/NzM8nL1TNYY=;
 b=ftpyIS4U8Bg2/5PNfcFzWY7af+euha0kww7RFxyyJR5IPEiWNHIdc6nuXXCD8eQR5WFuVq
 zO6tY3Aloy6yW8lP4xHb3sRajxmDWWKeqooRnfWfpfz8ajrQJnSnorU/oEXOFowbg+DVbp
 iPoay25pgCLiJsEwo1SDvm0tNNslsMQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-MZfN6inmPfWOAKhYPkzc4Q-1; Wed, 23 Aug 2023 09:05:42 -0400
X-MC-Unique: MZfN6inmPfWOAKhYPkzc4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F1D2857A84;
 Wed, 23 Aug 2023 13:05:42 +0000 (UTC)
Received: from localhost (unknown [10.39.192.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA30F1121314;
 Wed, 23 Aug 2023 13:05:41 +0000 (UTC)
Date: Wed, 23 Aug 2023 09:05:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] docs/about/license: Update LICENSE URL
Message-ID: <20230823130540.GA830132@fedora>
References: <20230822125716.55295-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tPiDFxacdIzM9Iq8"
Content-Disposition: inline
In-Reply-To: <20230822125716.55295-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--tPiDFxacdIzM9Iq8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 02:57:16PM +0200, Philippe Mathieu-Daud=E9 wrote:
> In early 2021 (see commit 2ad784339e "docs: update README to use
> GitLab repo URLs") almost all of the code base was converted to
> point to GitLab instead of git.qemu.org. During 2023, git.qemu.org
> switched from a git mirror to a http redirect to GitLab (see [1]).
>=20
> Update the LICENSE URL to match its previous content, displaying
> the file raw content similarly to gitweb 'blob_plain' format ([2]).
>=20
> [1] https://lore.kernel.org/qemu-devel/CABgObfZu3mFc8tM20K-yXdt7F-7eV-uKZ=
N4sKDarSeu7DYoRbA@mail.gmail.com/
> [2] https://git-scm.com/docs/gitweb#Documentation/gitweb.txt-blobplain
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---
> v2: Drop '&ref_type=3Dheads' (danpb)
> ---
>  docs/about/license.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my staging tree.

Stefan

--tPiDFxacdIzM9Iq8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTmBCQACgkQnKSrs4Gr
c8iy/gf8C/Td6wLU3HaBfasZPsCcEHNR9EZsn5s5LyRkCFi+jnyHTZ8oa2+p9hoF
oRXCpl43wU3GxKCxm4Fv0qywlHfD7EgABK+D0L6ZtnDK+RAclmxtRY+QCNaHcxc2
tAYIStc/JJDCx9iCS7UH+fRe0S0ijSh+Ferf/TFoWAKVRMT4dvnFEhwlIdVtMb6V
anLUxoMSkY5PGovRIyy7uLLSgiGu0dd+0LivfnfYgcuVF7mrbaXS0Op2pChkzp0M
KlFN58SiI7ReiSBjA1yIAMseq4S3KXiugUZZB4pEXTeG0FZS0JilM2PfhLTlYYCY
Ukx9z0HJUsj1ZF8ROPV6cFCbKwHVyw==
=GitM
-----END PGP SIGNATURE-----

--tPiDFxacdIzM9Iq8--


