Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 070627F62A4
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:23:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6BXK-0000ng-6R; Thu, 23 Nov 2023 10:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r6BXI-0000lJ-2f
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:22:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r6BXG-0004Zf-E7
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700752953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BE+Me4+3SRSugohNvS5MTpHbvdS8fQfxyXYzX2ckl5s=;
 b=RTP9uld2FrU5votcvnQJOp7sTBkat1qMkuzWHowgdixObqHAU9mg72Etn0aMkJpAuYJ9oE
 /rhCJ7Wa/N9cA76LLsi6nKfgnN/3BeEcn4x8xrtqkreOJog32wVCwppMWF3NAh+5biFssd
 cvUWLQxdRhY2bQ/FuzztS7Cdm9kfbxk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-mejxz8HzOdi1Fg2Fp0d0YQ-1; Thu,
 23 Nov 2023 10:22:20 -0500
X-MC-Unique: mejxz8HzOdi1Fg2Fp0d0YQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43B9729AA383;
 Thu, 23 Nov 2023 15:22:19 +0000 (UTC)
Received: from localhost (unknown [10.39.194.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF208492BE7;
 Thu, 23 Nov 2023 15:22:18 +0000 (UTC)
Date: Thu, 23 Nov 2023 10:22:17 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20231123152217.GB52478@fedora>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yHzYr/lnoZ022gIu"
Content-Disposition: inline
In-Reply-To: <20231123114026.3589272-3-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--yHzYr/lnoZ022gIu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 11:40:26AM +0000, Daniel P. Berrang=E9 wrote:
> There has been an explosion of interest in so called "AI" (LLM)
> code generators in the past year or so. Thus far though, this is
> has not been matched by a broadly accepted legal interpretation
> of the licensing implications for code generator outputs. While
> the vendors may claim there is no problem and a free choice of
> license is possible, they have an inherent conflict of interest
> in promoting this interpretation. More broadly there is, as yet,
> no broad consensus on the licensing implications of code generators
> trained on inputs under a wide variety of licenses.
>=20
> The DCO requires contributors to assert they have the right to
> contribute under the designated project license. Given the lack
> of consensus on the licensing of "AI" (LLM) code generator output,
> it is not considered credible to assert compliance with the DCO
> clause (b) or (c) where a patch includes such generated code.
>=20
> This patch thus defines a policy that the QEMU project will not
> accept contributions where use of "AI" (LLM) code generators is
> either known, or suspected.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  docs/devel/code-provenance.rst | 40 ++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

As open source LLMs mature, it may be possible to curate the training
data so that the output complies with software licenses and can be used
in QEMU.

For the time being, the position in this patch seems reasonable because
it prevents license problems down the road.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yHzYr/lnoZ022gIu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVfbikACgkQnKSrs4Gr
c8igSQgAliJ+EDHYxQgbEYL3xHmSO5n6Cj/W+1337Gm4T5YoXhL1cMxNgNkcRtsV
q72yJtidS3TkWeFrDYPbN5rruKaE/tzx5h9AOuw52SaSGJ5SlVtOTZAaUYa5uPxE
c1v3XjvlJfCoC9RYJnWKtJ0bD8FFm1bVfZcIj+lFsNeVqWROLFLTLb675CnJ2yxc
G7IPWoJWtlILSOuiGWAjPDpS4o+DF96Y5FKMjrbo/NiIcLmyzV7JIaH3ONgoTqIo
ZGd6JNbpjtCnvqcNwAw1HwvE4GyudOm73ivXeW4oaysdyrwlcWcASWkK3oA/PPys
ejViQOkyVcOzASO22s8hEMNAFSuKNw==
=8aJL
-----END PGP SIGNATURE-----

--yHzYr/lnoZ022gIu--


