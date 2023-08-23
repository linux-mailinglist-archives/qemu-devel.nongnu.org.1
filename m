Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6001786412
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 01:46:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYxXM-0004Id-7K; Wed, 23 Aug 2023 19:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYxXH-0004H3-3u
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 19:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYxXD-00029H-7B
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 19:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692834310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5IgvdU8P8bdFMTCVwwKFEf9XQd+pJh5+9Oafmz4pOvA=;
 b=H6cj8amrGqyfaH4eq8Po+UCgDIIUuhvCqC+AYXF45HknJCH7mXxd9BBTVkgx8L/akyn1il
 Fpdt2zwdsVtR4FI7keEmLVk7zb0lNFluamvD5cTJRBu63zS971+elAG+M6HxJstYCUBEdv
 qs0RsXwMyitnM0I6i4/5fa6Dk/3Cwtc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-t6us1s3VPPq0rzfMXlzAoQ-1; Wed, 23 Aug 2023 19:45:08 -0400
X-MC-Unique: t6us1s3VPPq0rzfMXlzAoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35DB01C06901
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 23:45:08 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C088E2166B26;
 Wed, 23 Aug 2023 23:45:07 +0000 (UTC)
Date: Wed, 23 Aug 2023 12:34:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/12] First batch of s390x patches for QEMU 8.2
Message-ID: <20230823163440.GA851545@fedora>
References: <20230823114544.216520-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3DahHZjfStcE137F"
Content-Disposition: inline
In-Reply-To: <20230823114544.216520-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


--3DahHZjfStcE137F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 01:45:32PM +0200, Thomas Huth wrote:
> The following changes since commit b0dd9a7d6dd15a6898e9c585b521e6bec79b25=
aa:
>=20
>   Open 8.2 development tree (2023-08-22 07:14:07 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2023-08-23
>=20
> for you to fetch changes up to 6c49f685d30ffe81cfa47da2c258904ad28ac368:
>=20
>   tests/tcg/s390x: Test VSTRS (2023-08-23 12:07:30 +0200)

Hi Thomas,
Please take a look at the following ubuntu-20.04-s390x-all CI failure:
https://gitlab.com/qemu-project/qemu/-/jobs/4931341536

Stefan

--3DahHZjfStcE137F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTmNR8ACgkQnKSrs4Gr
c8g+rggAkRBc8g2u4hoQD5sI5V4mqjLYO3RKTCtKwK1ng0VSgYnsO0OFlLw5YMcd
cGvoMfFXnrQG7yeIY/UDhbgzjrhnPGOqpNmoVnkvMITKCGIkLLzoeEXzu69Nenrl
RbgaLVv04t1hOkwwYzpbY+gOcEHaC1seK1erfuK6Ge0pU8qX6MC4vL9cz8T0LeHh
2mwCoqvkrzO4NvEnJgdeKLleBb54JRG/H/qt/n4U98vFPoW1NWfxWFh5C3BTvgeX
EOSBdcgUphEpaNDJ8vwXdXF2Npf9A9uldn0GnYv790a54mNlXPZDfGJQm8kWERVm
eA7XYfeDAN/vQ7+QYLoZ0z243PTk/Q==
=7BgG
-----END PGP SIGNATURE-----

--3DahHZjfStcE137F--


