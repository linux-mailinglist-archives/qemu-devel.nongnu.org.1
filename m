Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CC6711617
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:56:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2G7f-0002ER-Eb; Thu, 25 May 2023 14:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2G7d-0002EC-41
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2G7b-0007py-PJ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685040934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ka+9GOhdJdoEkL0qLYjCsOy7Fh3ZQdRy0C4VdZUcgU4=;
 b=YYlOVA5z3Y0/jJXjL8zHVMzSQfhe5aLYwMzo1/HgwU5o/EYbrSMTeBfqpTsihJwewS8uVl
 zTKp87ZS+8VjtM63dExCGhFeE2AKEMD98zzZGb64GRbCFU6Ojvh65etPvvYqxJS3Kvwgqi
 TW+X/V17qfar23AoG0K7E1ergH9TAoY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-0-wHn4m0PGm8EZs3i6vvUA-1; Thu, 25 May 2023 14:55:28 -0400
X-MC-Unique: 0-wHn4m0PGm8EZs3i6vvUA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12F701C05133;
 Thu, 25 May 2023 18:55:28 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BEF2492B0A;
 Thu, 25 May 2023 18:55:27 +0000 (UTC)
Date: Thu, 25 May 2023 14:55:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 08/12] copy-before-write: Fix open with child in iothread
Message-ID: <20230525185525.GJ132697@fedora>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-9-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yi0cV8nGDhae70Hx"
Content-Disposition: inline
In-Reply-To: <20230525124713.401149-9-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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


--yi0cV8nGDhae70Hx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 02:47:09PM +0200, Kevin Wolf wrote:
> The AioContext lock must not be held for bdrv_open_child(), but it is
> necessary for the followig operations, in particular those using nested
> event loops in coroutine wrappers.
>=20
> Temporarily dropping the main AioContext lock is not necessary because
> we know we run in the main thread.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/copy-before-write.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yi0cV8nGDhae70Hx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRvrx0ACgkQnKSrs4Gr
c8g/uQf/RjVscB+Da/kncWS6DYukDpsCcZxeIey8Y51KRSb2D37UA4nzD8gxsg1/
XDsuEaIG0eUwWMBCQ8VL2hhq3VBy2aOS6dlPAXFasLmPinKULAuQmiCEu5kvPxao
x39RnfxiyvbE2VGmdNUfYlV7ada50u67ppvF/r3BnVCn7uMb+g1P73hJXNqavp8y
BUiZJ71efMubwQRzj+dxXpZ5mXgaWiC+xHqlxnDE2h0NAOdNTWk6ZsKlzVKuYtj6
YL/VYVLRa0fL9jcLUKNo56Ia7TrFviX4dqL4J+aFbSR1FZ7F06hYYxhEYDBIGZhF
BOtBE7t0lY8RKLa45kHLvfiJZTYpaQ==
=YuE/
-----END PGP SIGNATURE-----

--yi0cV8nGDhae70Hx--


