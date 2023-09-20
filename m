Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 055397A8DAB
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:17:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3cf-0008UU-5r; Wed, 20 Sep 2023 16:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3cY-0008Rf-6l
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3cV-0005n0-A7
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695240980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hc/YDCRTTDrvmD/ILXqvVNQyn+//e6tHfkb8WIw99QI=;
 b=LddtmTYHVIZrW/oTHPE5wRb/IJxed8J6vJ8g5To9SJN3cyzsSsj7NdzdlfAdB0TzqJ8gjn
 ccTMad9nPp6wl1zQQhMIPe1Si7llq6ZzuD1Eq7j2fHHW3Rrk5Ti46nEbCUyE6EU3AGDVWe
 mY/S5Rr6vRPuKPyCITlG3AdLuN5/dtI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-NGhuOLgXM6SMb4spvh02LQ-1; Wed, 20 Sep 2023 16:16:17 -0400
X-MC-Unique: NGhuOLgXM6SMb4spvh02LQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F856809F91;
 Wed, 20 Sep 2023 20:16:17 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAB1BC15BB8;
 Wed, 20 Sep 2023 20:16:16 +0000 (UTC)
Date: Wed, 20 Sep 2023 16:16:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
Subject: Re: [PATCH v4 09/14] simpletrace: refactor to separate
 responsibilities
Message-ID: <20230920201615.GH1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-10-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MMMGW4I0T2bdWWv3"
Content-Disposition: inline
In-Reply-To: <20230823085429.20519-10-mads@ynddal.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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


--MMMGW4I0T2bdWWv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:54:24AM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> Moved event_mapping and event_id_to_name down one level in the function
> call-stack to keep variable instantiation and usage closer (`process`
> and `run` has no use of the variables; `read_trace_records` does).
>=20
> Instead of passing event_mapping and event_id_to_name to the bottom of
> the call-stack, we move their use to `read_trace_records`. This
> separates responsibility and ownership of the information.
>=20
> `read_record` now just reads the arguments from the file-object by
> knowning the total number of bytes. Parsing it to specific arguments is
> moved up to `read_trace_records`.
>=20
> Special handling of dropped events removed, as they can be handled
> by the general code.
>=20
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>  scripts/simpletrace.py | 115 +++++++++++++++++++----------------------
>  1 file changed, 53 insertions(+), 62 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MMMGW4I0T2bdWWv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULUw4ACgkQnKSrs4Gr
c8ix1wgAjBinT7LDLW5UtUUt/g6ZWe1UNJeGxYxM2gb6aGzJ/VXXCXSgvWtuTxkQ
4kMgjkEJAA77Xrmm3Ab6ZrLHnC22etAEV0pHhKRKFxkE+WnRAYhEtEtiOYGfa5+p
C+53rZBvjsfM8o9E7Dz9vE2mu5NXGknXTvrA5gwYlHTW7mGShtHSvJZfzna9LDRr
JcgszEr+tnFN5AJjuH98hrPtQ4Vgsn0G4YrRw+bRQic5wpZTvW/bxztP1Un/xnuM
3EFhWADOOcff3j9S+1/8P2xIDr0Qdj14Zs8rHfkr6NvH6gu8jFKU5GvJ3tz+pxuW
Jg6B4wBGv49ir6VXUPeTxxrs66Z00w==
=IKmP
-----END PGP SIGNATURE-----

--MMMGW4I0T2bdWWv3--


