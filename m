Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1AEA54089
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Mar 2025 03:16:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq0ls-0002gV-64; Wed, 05 Mar 2025 21:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tq0ln-0002g7-HM
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 21:15:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tq0lf-0003Ao-T6
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 21:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741227319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ye7p54CXpH+bLk4mVc+iChbkOhNWfJTVVBKQHyp0qMA=;
 b=iril6DlFlvtPISynS6sYnkYaDQ0vMPzeiDGYhp0g1y/3jDwukMV9SFolsjAkr7dz5WMHyR
 gmeckhastspBeUEGCaE2uiX5IDuXHQhiIrEaIFBEomX/Rs2MsX8Epx2WKBx5qh1UwJOOu2
 D7vmX3ZXHKmh9xianL+wOa8kVM4GyDc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339--qf25Z9XOuuCThHndgQwww-1; Wed,
 05 Mar 2025 21:15:15 -0500
X-MC-Unique: -qf25Z9XOuuCThHndgQwww-1
X-Mimecast-MFC-AGG-ID: -qf25Z9XOuuCThHndgQwww_1741227314
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 752551955F67; Thu,  6 Mar 2025 02:15:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.55])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66E541944F2E; Thu,  6 Mar 2025 02:15:13 +0000 (UTC)
Date: Thu, 6 Mar 2025 10:15:10 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] tests/functional: Increase the timeout of the
 mips64el_replay test
Message-ID: <20250306021510.GC303194@fedora>
References: <20250305074353.52552-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cV3a8DfTa7hAWk1G"
Content-Disposition: inline
In-Reply-To: <20250305074353.52552-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--cV3a8DfTa7hAWk1G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 08:43:53AM +0100, Thomas Huth wrote:
> We run the gitlab-CI with the untrusted tests enabled, and
> the test_replay_mips64el_malta_5KEc_cpio subtest is rather slow,
> so this already hit the standard 90 seconds timeout in the CI.
> Increase the timeout for more headroom.
>=20
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/meson.build | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cV3a8DfTa7hAWk1G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfJBS4ACgkQnKSrs4Gr
c8i5Vwf+LBvcH7LNaPupRu1e1zj95QNp640jdVuHFUkAgEF/tEPB5WzBLpiSFZ54
zF342ObVO7rolpEsVsWZHCgJRwkuUfM2kvhZTA57qX6bzrb8sqhffQ+OaEr5vGD9
m+lSe9NnmtIlUOsM7YRqXd8oUetAH0bDBelqEG7zcvjD/160IkSzy/VwAt8BFpyl
SyMgxvri3PHNxNMweRX3bopupQWyQWROOAUNrF5hF6tFmmu4ApzfENJ/Jo8mPJwq
7JgjBwKuwSd4r451C5EeF82/e46zinF1P+h7pJMN0nGoDT4VzbrTGcH4KwtoTYwu
YBHs8UQ9EY8TwqAfQti5debf0HHVbg==
=Nn6x
-----END PGP SIGNATURE-----

--cV3a8DfTa7hAWk1G--


