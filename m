Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 906D8711487
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:41:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FtX-00050z-50; Thu, 25 May 2023 14:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2FtU-0004vH-FM
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2FtT-0004st-2S
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685040058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uYZ4DgK3PfVYP7eBSf6GWF+cgOzhdIUJ/mWcBBRQ8sc=;
 b=SKXci1tMCD1OY56OA+OrPy1uq1dK9XqW5ltPoM0sj9eYb/MRAkTM4CIeo2eh4AAUpOoZ+a
 zVZkrPr7B9QqRJQKU+LrQpO3mYruCXESXohS8EoennJSWKkcGK435GiOWzFC7sNM7w8a1G
 HXP2H4iXQ3nLkf+Ll7xtfHNETHbodrw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-Le9b6vokPDiI6I8xvgu0ew-1; Thu, 25 May 2023 14:40:56 -0400
X-MC-Unique: Le9b6vokPDiI6I8xvgu0ew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1C901C08DAC;
 Thu, 25 May 2023 18:40:55 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E1578162;
 Thu, 25 May 2023 18:40:54 +0000 (UTC)
Date: Thu, 25 May 2023 14:40:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 05/12] mirror: Hold main AioContext lock for calling
 bdrv_open_backing_file()
Message-ID: <20230525184053.GG132697@fedora>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+YsxITaySxPvXSh/"
Content-Disposition: inline
In-Reply-To: <20230525124713.401149-6-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--+YsxITaySxPvXSh/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 02:47:06PM +0200, Kevin Wolf wrote:
> bdrv_open_backing_file() calls bdrv_open_inherit(), so all callers must
> hold the main AioContext lock.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c        | 2 ++
>  block/mirror.c | 6 ++++++
>  2 files changed, 8 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+YsxITaySxPvXSh/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRvq7UACgkQnKSrs4Gr
c8gKqQf/VRZUP7ve95yVNbnlC92xs3g+ZpXnKzjO7TNf7WreUh2d/nGNzXKKuVXC
tSzNAvd0bubigAIkf6hXiqFpRH6ZsnUvYdjLNhPJVDQf+IblT2iTtyyxOHh4+p/6
7YRuEUg6D6aKexI+InCSF1RgeEFr3McjIJ0jpNWkM35PrtIEOtMTpqq/IsxNxBAN
Wblf2RZMxYLsp8+THIG8UmJoFHeJRhhtgHa0ilSeKWvugguQbZatZJ4UC9A3L4Ik
mVaeWLFQd4Bj9t8z0ULAybzmUmTGjVJH9NCK9CLBQOl8iXwg2I8qae8WESlmHzOl
mFsGlLbiHTMFN/vCFiNSKkDgPJVMcA==
=8aJI
-----END PGP SIGNATURE-----

--+YsxITaySxPvXSh/--


