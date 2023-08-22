Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A58B784AD3
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:50:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYXOL-0004v9-Ti; Tue, 22 Aug 2023 15:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYXOJ-0004uV-4K
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYXOH-0000i8-29
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692733812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sKOhLcLWse4VnsByy+XjQBL+z5/TPj4lDloRG6BQQQ8=;
 b=eqHk6XTb2zMHYGae1/aC+8LvJbI6Si2zWIIoX9g9/VsTxKUO+kFbqJPThraXeuJkG5vtKJ
 6hhEp7LFNel7eEk4C7RIP5Xdc5sfNbCVi79xQYan5Gb8jGDAXa3h4wHSwX8UiidB4pofrX
 Wtmr0q3kmpqigd6UpXjTXCpe8TMK0hc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-PpGbetclNV6D3SslfupU7g-1; Tue, 22 Aug 2023 15:50:07 -0400
X-MC-Unique: PpGbetclNV6D3SslfupU7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D0521C04181;
 Tue, 22 Aug 2023 19:50:07 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9924C1121314;
 Tue, 22 Aug 2023 19:50:06 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:50:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org
Subject: Re: [PATCH v2 4/4] iotests: test the zoned format feature for qcow2
 file
Message-ID: <20230822195004.GC37847@fedora>
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-5-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k0kdOHp2CyO183kK"
Content-Disposition: inline
In-Reply-To: <20230814085802.61459-5-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--k0kdOHp2CyO183kK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 04:58:02PM +0800, Sam Li wrote:
> The zoned format feature can be tested by:
> $ tests/qemu-iotests/check zoned-qcow2
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  tests/qemu-iotests/tests/zoned-qcow2     | 135 ++++++++++++++++++++++
>  tests/qemu-iotests/tests/zoned-qcow2.out | 140 +++++++++++++++++++++++
>  2 files changed, 275 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
>  create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--k0kdOHp2CyO183kK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlEWsACgkQnKSrs4Gr
c8ghXgf/fkwdy/QY3/qfISCxd+1JO1nax/U7quPCrOKx75RmCDcwvVz7AD4l6sig
GqdIW2O8XRgUK9+2xR8Dgsb/sKQFwmpsgc6Q3mM8zefnAgm+G1BgII8+Z6SK/C6n
Ar3idWlQ4cq4p28LyiFNcI8bTcOkibzFyRcDPOtdquE8SepIt/csW9h09GezIv7O
XNcmo3SGqmVSgNOCmOdbsYd29pG2ipDcV3etS5cBYqkZC+kp6mSaCxE+xQtimubc
D9FlotE70YVrWiiH50GYRkC9BUNvacPOcwe9YEdUaMHLV1/RnQYLieJu5YlbIXA8
UdzRHf1iSis6SNC5kEjNpE9bKMl6AQ==
=z56m
-----END PGP SIGNATURE-----

--k0kdOHp2CyO183kK--


