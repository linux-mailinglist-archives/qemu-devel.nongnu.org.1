Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA3C7A0F87
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 23:08:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtYI-0005TW-Uu; Thu, 14 Sep 2023 17:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgtYF-0005Rs-I3
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 17:07:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgtYC-00057W-2q
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 17:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694725618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKbB/otjvcWbaoE6Oljxgj+GUcLDWyDd9a2Vt8UZEsk=;
 b=TG6ZHvZCUW+Jyep/t0GGTBVzWSufpKmzqLB/uuTfamO5UT0uTaKzrHXtPYcU/ogAxmhxTy
 f+HtCfm9GIb06K5v5yePrtWzASODPSuWn+nBCuz42AW9VI4sJuplzZ5y6l3xFNWwgmeNWv
 Lknu20EIpGbqMBdnrmK6mY7jhE3RYVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-HWWMUfGQOoC6nFm6cjhMyg-1; Thu, 14 Sep 2023 17:06:56 -0400
X-MC-Unique: HWWMUfGQOoC6nFm6cjhMyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B410E185A790;
 Thu, 14 Sep 2023 21:06:55 +0000 (UTC)
Received: from localhost (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EFE41054FC0;
 Thu, 14 Sep 2023 21:06:54 +0000 (UTC)
Date: Thu, 14 Sep 2023 17:06:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
Subject: Re: [PATCH v4 01/14] simpletrace: add __all__ to define public
 interface
Message-ID: <20230914210653.GA1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-2-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dgk71tvX2ai5awBM"
Content-Disposition: inline
In-Reply-To: <20230823085429.20519-2-mads@ynddal.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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


--dgk71tvX2ai5awBM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:54:16AM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> It was unclear what was the supported public interface. I.e. when
> refactoring the code, what functions/classes are important to retain.
>=20
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>  scripts/simpletrace.py | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dgk71tvX2ai5awBM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUDde0ACgkQnKSrs4Gr
c8jWawf+JVMEnnmzmg0kWAoTkuixUHcKAIquhRyiSIR3mBh0hdBDFj6/2AVq2f1N
rEu9lH2doaVHP+oK9xMHqfWeJ+ZOaodzsV6d5D3+W/thYeF5/ET51f4vtL1NACnH
Kg67XeoyLcxsYZe+lh8h8KP8krUoq4K/9zAvVMhHHc8+CN81sqa95REWiTAp1eb8
fMQcoxdSLUvRWFb16oGUYFSJA8kYZ0P7UavUc87/iiJTqV/rhrxASyaxTM691ZhT
32b0cPWrNxHzke6noV5pdI3/S0I4BWqnZ1brOXAPku8fDkvvxLo8y/ZgOiv41W+i
yzOZL239T9sGATFbPhAmwMtPa2QD+g==
=LYqv
-----END PGP SIGNATURE-----

--dgk71tvX2ai5awBM--


