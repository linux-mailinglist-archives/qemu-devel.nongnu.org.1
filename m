Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C65307849E2
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:04:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWfR-0004Ky-Kb; Tue, 22 Aug 2023 15:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWfP-0004KO-Jq
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWfN-0005ES-MJ
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692731029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I78QXISfRKQ7UGTTvO64xFHgwA79HQn91XOE2nbKCLk=;
 b=XjINFIX7UOI1sF2Kp9Slg67Yc9He1RiZ2J2HKsk5QPlp2ZZV/CG+HkoIINvZKnKt17pGND
 eZBc2zLk2DNa9v7g2S+WLnzxKK0ReEx6hdvxFobGnWhPgkQUH2G8lFT43Bb7D/e9lE1h7I
 Aa87o9Bh//dlP4TSseBfV4s4b7OFlWw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-oxU-0RoJPSuOeFk2YrHKjA-1; Tue, 22 Aug 2023 15:03:45 -0400
X-MC-Unique: oxU-0RoJPSuOeFk2YrHKjA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED2CF101AA5F;
 Tue, 22 Aug 2023 19:03:44 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 858B71121314;
 Tue, 22 Aug 2023 19:03:44 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:03:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 07/21] block-coroutine-wrapper: Allow arbitrary parameter
 names
Message-ID: <20230822190343.GJ727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-8-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AxNwx8PfQ2Ax+E0G"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-8-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--AxNwx8PfQ2Ax+E0G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:06PM +0200, Kevin Wolf wrote:
> Don't assume specific parameter names like 'bs' or 'blk' in the
> generated code, but use the actual name.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  scripts/block-coroutine-wrapper.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AxNwx8PfQ2Ax+E0G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlBo8ACgkQnKSrs4Gr
c8iW7wf8CwTcPaz2kf7XEsB6QY1EBJ0eh9QtdHjWdxC/1rWMkLCv0iYxRQfa8TJ1
dhrlbnC8NjtLa41eiMOJ18ejj69jfkROPuhcC/EDbHqZ3avSu4+4EL/Kh9dYFpuf
Y3jZwSLgGFjFLp8/gA0kv+UX5kZnmOtta4f7lGtPSyQ9UVAXAsLJ/E6P+DA8i4qu
JZ2u5OS5gq6QaXAnZu0f3R7WS+9l9dS9OkHd2rATp509s6bo5uHLyNR0P6TaIewE
oIwG/pj3GbDXy6WF7AC/Z3Autj8W5PirPrjGD0Dt2NuDGyVSSg1vyB7nYr610mE2
zTNNobv2li1qOuUo/wp57yOb9+0aHw==
=UuHg
-----END PGP SIGNATURE-----

--AxNwx8PfQ2Ax+E0G--


