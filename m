Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC93D821972
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 11:10:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKbjH-0000Wm-Ce; Tue, 02 Jan 2024 05:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rKbjF-0000WA-AZ
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:10:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rKbjD-0006zh-OM
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704190230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=doixIXZF34sW71X8vm+kL6i02zOfDTVx9IllcOBHrVU=;
 b=WPFkVn9zz854nNOIcdeYlk8UYzVROIy7x34uva7ORmOOBunf0IG7S/OiYyFqZFu4Q7bs1t
 HSvq+g+Ls5nFneVoWF+a7g/NLd6+nwrK4l6xSDyzj/dcgPHm6GJMqbc73cCOa0Oe8mT3wZ
 4HCTWOHXtHZWZdp5GIOkBD+FRxQuHDw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-P75IKJOvMJ6G0zFq798Rbg-1; Tue, 02 Jan 2024 05:10:25 -0500
X-MC-Unique: P75IKJOvMJ6G0zFq798Rbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBDC385A58E;
 Tue,  2 Jan 2024 10:10:24 +0000 (UTC)
Received: from localhost (unknown [10.39.193.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9604E2166B31;
 Tue,  2 Jan 2024 10:10:23 +0000 (UTC)
Date: Tue, 2 Jan 2024 05:10:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH] mailmap: Fix Stefan Weil author email again
Message-ID: <20240102101021.GA423238@fedora>
References: <20231227085934.18158-1-philmd@linaro.org>
 <92d0751b-fa39-4fc2-8e55-3b07aa3b3ed4@tls.msk.ru>
 <9d66b444-d0c8-495a-8555-5b70af07bea9@linaro.org>
 <9733fe6c-d9ea-4945-ba06-8d23890f22c7@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T6UvdHA0dXqprGcr"
Content-Disposition: inline
In-Reply-To: <9733fe6c-d9ea-4945-ba06-8d23890f22c7@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.246,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--T6UvdHA0dXqprGcr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 10:21:26AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 27/12/23 10:12, Philippe Mathieu-Daud=E9 wrote:
> > On 27/12/23 10:09, Michael Tokarev wrote:
> > > 27.12.2023 11:59, Philippe Mathieu-Daud=E9:
> > > > Commit 5204b499a6 ("mailmap: Fix Stefan Weil author email")
> > > > corrected authorship for patch received at qemu-devel@nongnu.org,
> > > > correct now for patch received at qemu-trivial@nongnu.org.
> > > >=20
> > > > Fixes: d819fc9516 ("virtio-blk: Fix potential nullptr read access")
> > >=20
> > > Do you think a single commit warrants an entry in mailmap?
> >=20
> > If I cared enough to write and post a patch, I suppose so...
> >=20
> > In the past the only limitation was whether someone was willing
> > to do the work and send a patch, not the size of the .mailmap
> > file.
>=20
> A more useful use of our time would be a git pre-merge hook on
> our CI, but that won't work because PR aren't merged on the CI
> but externally, and the final commit is pushed.
>=20
> The only place I can think of to automate that is to have a
> script on the maintainer side. Remembering Peter had a such
> script, I found a reference in the list:
> https://git.linaro.org/people/pmaydell/misc-scripts.git/commit/?id=3Df9a3=
17392e8
>=20
> Stefan, do you mind using Peter's script for your merges?

Yes, in future releases. Peter is handling the QEMU 9.0 release so I
will not be merging pull requests for the time being.

Thanks,
Stefan

--T6UvdHA0dXqprGcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWT4Q0ACgkQnKSrs4Gr
c8gYlAf9FsqoycnIUg2yNZZ5pLwB0VMDe6zunHRQyjJVimA41+na/m6dmNsRZ11U
oALLS9z6wXSPdg1RRX+N3p7QkAdvAstWQSNt8TAflMtFmmKUBfC7L29pqlYz0pV7
ee6/XYFy1w+NA4SruJ5zz1xl+GqRXAc0XUOE6pcy93NMW8KjRFBhmHKUwCwabAEg
goGvrdbgcv6SWB0hWoYGAB9ku0X738U6ls7QPtvkD5g6qMlwhdR2Yxf9KyBa58d7
VoRcD9VCnSW7dPpbkgiE7sYmhbd1iwFk6FTR0ChwMg5lZZ8Zoxd0rl0S761QFXKP
IO9ETIRlpv52DDXdYV1G0ENV0M+0BA==
=bX4i
-----END PGP SIGNATURE-----

--T6UvdHA0dXqprGcr--


