Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3CA7A8D12
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 21:48:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3AL-00085W-N7; Wed, 20 Sep 2023 15:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3AH-000859-A5
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3AF-0007X7-Qb
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695239230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RbgSNO2fHUbDAWhEe7iwwQykES6X51yzlNyeu4uwjz8=;
 b=Lx1PQBKidCG+mRuTRNXTsBaEmi1IpyOgqYaOmd4lmkXkv3G2uVJSuQ9uVhotkLcc00r1aH
 jNIwRLkOCneP2SjUZK7VyEAoCm0ao7bxoP7iaNqo9vtrMZ7bqJYAu5N35PNJmmt8dO5ZLM
 hVJNkatyKwxdIHppnzTSxd3w2s89tC4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-EW_4-155MVCDYc8Ow7KBQA-1; Wed, 20 Sep 2023 15:47:05 -0400
X-MC-Unique: EW_4-155MVCDYc8Ow7KBQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F4B428EC101;
 Wed, 20 Sep 2023 19:47:00 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3B012026D37;
 Wed, 20 Sep 2023 19:46:59 +0000 (UTC)
Date: Wed, 20 Sep 2023 15:46:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 04/14] simpletrace: changed naming of edict and
 idtoname to improve readability
Message-ID: <20230920194657.GD1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-5-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hgA+k3XJyjtqk4uN"
Content-Disposition: inline
In-Reply-To: <20230823085429.20519-5-mads@ynddal.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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


--hgA+k3XJyjtqk4uN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:54:19AM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> Readability is subjective, but I've expanded the naming of the variables
> and arguments, to help with understanding for new eyes on the code.
>=20
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/simpletrace.py | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--hgA+k3XJyjtqk4uN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULTDAACgkQnKSrs4Gr
c8jN0ggAl8WKc7sFi5WtXpLCZOX3m2mwCSAvVUvJbwPCYRANJcZea5sKF0Uv+Hqy
IV+qkM923Fi0aaTj2kVgXYRcNubjG1ghSMHUo81r/7APGdogfzsDmjBh4R17IbFK
Y1Qay3/O52LwCTIFsGa8krfQ+jnM/tL4yJ++I9IzOS0Ml5g+ZSyPzAKzopyLZ6Vf
qiCZPlqb+ho/npzE8Ktym8qI2J7mFniQjw8FUj0fUt5sIVpH4o1Ku4X7wzgek8mk
vUAAXfCKUL70ym7QOyoaxLGrNt+tR733RkK6UmasSyH/YY7Wp3BzscwmnJhJDAnT
v1K29z97jFDj07fHvWd6zBjpyJpjOQ==
=1ln/
-----END PGP SIGNATURE-----

--hgA+k3XJyjtqk4uN--


