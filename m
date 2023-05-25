Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C39471161F
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 21:02:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2GDv-0006Fn-E6; Thu, 25 May 2023 15:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2GDt-0006FG-AP
 for qemu-devel@nongnu.org; Thu, 25 May 2023 15:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2GDq-0000JQ-K5
 for qemu-devel@nongnu.org; Thu, 25 May 2023 15:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685041320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BEqlswvosyXdGOQSbUmg0KOoSUO2MC0QNRqigt0MgOA=;
 b=EtY5PkIRnXa1YsGhfOVYXWRTpBAGj8US7uXC7lfXodHBColptfKBstssjMDPa06uUlne38
 6x9ZrwpYd1tatmlP3qhPAkWoXUW8jQYMThKgaUAI0epBF9yfNEB/el9iNn+mTYo/HCetNt
 JJkYyUYt4FvCUhaiLocQrhfYLBwX4jE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-KJAUTQVbOXOulbiu-ZflwQ-1; Thu, 25 May 2023 15:01:57 -0400
X-MC-Unique: KJAUTQVbOXOulbiu-ZflwQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABEC41991C48;
 Thu, 25 May 2023 19:01:48 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 102F3407DECB;
 Thu, 25 May 2023 19:01:47 +0000 (UTC)
Date: Thu, 25 May 2023 15:01:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 12/12] iotests: Test blockdev-create in iothread
Message-ID: <20230525190145.GN132697@fedora>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-13-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W2aUMLXZv1UwjLJo"
Content-Disposition: inline
In-Reply-To: <20230525124713.401149-13-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--W2aUMLXZv1UwjLJo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 02:47:13PM +0200, Kevin Wolf wrote:
> If blockdev-create references an existing node in an iothread (e.g. as
> it's 'file' child), then suddenly all of the image creation code must
> run in that AioContext, too. Test that this actually works.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/tests/iothreads-create     | 67 +++++++++++++++++++
>  tests/qemu-iotests/tests/iothreads-create.out |  4 ++
>  2 files changed, 71 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/iothreads-create
>  create mode 100644 tests/qemu-iotests/tests/iothreads-create.out

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--W2aUMLXZv1UwjLJo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRvsJkACgkQnKSrs4Gr
c8g9XAf/cdEj5HKhIiEnroyzxgCmcYkRRHUs8os6/KUBCaClYVOtgfKo24+N/hZ0
adlva0nsgcqe99yrQi+0cM3u9+/UTbz/2LugCU40/1as1DBjh6n61SCbkUrbOCCe
/HIcnIuU13F3BPisN83HQ6I3jZ+Xzft5R61mQsGmh70fAtxV3EdgQ2juCH93q20Z
gFTjnN1ODCi31QT6dc3/8vY/Xesi6MAaa70L9tBJdAMThKovc3FHJJZtGdlOjbQC
ON9TI/piSproJeTgs9wOdTVvy2dwHZmh4mQu4wYLy8yTyVyucTKpEBCl9+Y5JFr3
zHPND4jSl4mXFatkW58Uat/1mkRPEQ==
=rduE
-----END PGP SIGNATURE-----

--W2aUMLXZv1UwjLJo--


