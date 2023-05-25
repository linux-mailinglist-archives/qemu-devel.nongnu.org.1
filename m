Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5A0711373
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:16:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FVI-0007qq-FT; Thu, 25 May 2023 14:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2FVG-0007pB-Fm
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2FVF-0007SJ-24
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685038556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cuczzkOLkigYHUJLk7z+PfPiKw4wGwp1ukIsXDTIPA4=;
 b=M7SyqoHFXlvTRO0I2A2tJaLlHt2A7S9BpeTqeVQDL0BFaqulD1dZotJqFMK2pPfvvRBbP5
 yr3jj18Xow1idY9Wn/z598UbTS9FsQond2M4CRMYbbX5ugAMu0Vi8SyNzoXVaZmmjlOp1d
 2A2zYbTjLkWkdBlEP6w2+lS5zHFFJuo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-_RaCJLL0PkKEhgvyYArlzA-1; Thu, 25 May 2023 14:15:52 -0400
X-MC-Unique: _RaCJLL0PkKEhgvyYArlzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26D36101A53B;
 Thu, 25 May 2023 18:15:51 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7ECCA9E60;
 Thu, 25 May 2023 18:15:50 +0000 (UTC)
Date: Thu, 25 May 2023 13:59:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, elena.ufimtseva@oracle.com
Subject: Re: [PATCH v1 0/2] Fix the documentation for vfio-user and
 multi-process QEMU
Message-ID: <20230525175918.GB132697@fedora>
References: <cover.1684338236.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xd4B2bFieirttUP2"
Content-Disposition: inline
In-Reply-To: <cover.1684338236.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--xd4B2bFieirttUP2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 04:43:55PM +0000, Jagannathan Raman wrote:
> This series addresses recent comments from Markus Armbruster in the
> "Machine x-remote property auto-shutdown" email thread.
>=20
> Jagannathan Raman (2):
>   vfio-user: update comments
>   docs: fix multi-process QEMU documentation
>=20
>  docs/system/multi-process.rst |  2 +-
>  hw/remote/vfio-user-obj.c     | 14 +++++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
>=20
> --=20
> 2.20.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xd4B2bFieirttUP2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRvofYACgkQnKSrs4Gr
c8hVEwf8CNcdHovTlNa0etf5fCQW5pBY7EtXKeETYaPhriT/mMALSSa5EXov8et/
PGppGxSevOL89VxweA3ymt3788hFoXa6uZYt7FlxjrgwaScEcNPDZ0PqwCMXUMpL
q0M5U4w3YyXM5uIUj71MSC82KI7brvX6Whx+b4CUsg1S6tbz62tXREbHjHPYTMhg
PFTATWTin6LqK1gqZ3BsgIDLC9cUv2V9O0GE6MdkZ5kURoxEPb/Wt+BtoIVhwKIJ
FHK05UkSbhTn76AlZgmcUy2vArrpIRMBLgnidKzcQOphlT72KTfrZ2/JpEkycoLk
7iXPtkX7GPr6jXKT+j40wW290ayvHw==
=ny7k
-----END PGP SIGNATURE-----

--xd4B2bFieirttUP2--


