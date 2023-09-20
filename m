Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 109957A8D1A
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 21:50:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3Cs-0000V0-NQ; Wed, 20 Sep 2023 15:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3Cr-0000Um-5X
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3Cp-0007rB-Px
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 15:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695239391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jByhE9WRYO0hH7CuHgmdPaNfWJpmyUR6F1c9hbVprsc=;
 b=SVaySg70lIt6F1a1a+eQbHJBk3Ub6zgTi0ez7cR/tDF+HyhQ7oElaZk/97jlxLhyTW8ZMs
 ikOPbtWwvBTeo4pszZrri6frYCJj9BVG0xqszvQkJncDOX2bclrUQFNj7Q1ttyDrJinP7N
 EZj5wVcB8ly+e52yrl/rEDAWLSOCNAE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-xG3gifwaNUi-FLT2YKeQcA-1; Wed, 20 Sep 2023 15:49:47 -0400
X-MC-Unique: xG3gifwaNUi-FLT2YKeQcA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F23DF801FA9;
 Wed, 20 Sep 2023 19:49:46 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8928F492C37;
 Wed, 20 Sep 2023 19:49:46 +0000 (UTC)
Date: Wed, 20 Sep 2023 15:49:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
Subject: Re: [PATCH v4 06/14] simpletrace: improved error handling on struct
 unpack
Message-ID: <20230920194945.GE1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-7-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xR9/QFUbTH6yltvh"
Content-Disposition: inline
In-Reply-To: <20230823085429.20519-7-mads@ynddal.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--xR9/QFUbTH6yltvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:54:21AM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> A failed call to `read_header` wouldn't be handled the same for the two
> different code paths (one path would try to use `None` as a list).
> Changed to raise exception to be handled centrally. This also allows for
> easier unpacking, as errors has been filtered out.
>=20
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>  scripts/simpletrace.py | 41 ++++++++++++++++-------------------------
>  1 file changed, 16 insertions(+), 25 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xR9/QFUbTH6yltvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULTNgACgkQnKSrs4Gr
c8gBbwf/WYvInA1TuuyaaLC7S+7bqlfhwZqydVodRt9JAgY+DMGE9G2aZews4WCo
if1hm6KQAiS5+kyXKHj4+klo0+7jVgNtUbO+fHREiWm7mj8nQq8a9ztfnVQXJaKJ
Jj+Pi01gWhGAwk7HjonhxL3JZZEBOGa5W72Cc8188qwBTYKpYGT6lYTgvQMIkb6/
w7IR9h206jVSGoAl0P6VEw5iurrY9SANU2qVsk6OfPVBQKYREqUDvCMX74Xv+fD3
T1wqa79CArZ0e+TWzs1rE01AnfeUzQxpphjZiLZnZyiVIDnKiy1Fbdk7weFPDdVO
Cv3vHdrsUvHOgb6xx2F40ZL82EfSsw==
=VwC4
-----END PGP SIGNATURE-----

--xR9/QFUbTH6yltvh--


