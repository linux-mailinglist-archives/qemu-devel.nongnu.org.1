Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF3571146B
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:38:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FqW-0003St-IF; Thu, 25 May 2023 14:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2FqU-0003SL-UC
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2FqT-0004Ea-A5
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685039872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4r3qYxneeA4YJy/Q3KXkKdfuD89XMkaoJ1c8oKEi/1A=;
 b=PaB38F7+NekZRPDzXxjDw57oEMhFIDXoVfds4RNnY9qgUcNvflXGyHsNQ2DJbBtustKNfn
 Q26FVKQ86tUylQnlQS8abpE9HJeikwSrujJZ8VUD66gXvQgMXc4+sXwKLHIpurSo09kJ4X
 psfYQ525cNzyxtWo5Q13hAjq+JyG2R4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-t-JFKiZDPvaKD1h3HpsPmg-1; Thu, 25 May 2023 14:37:50 -0400
X-MC-Unique: t-JFKiZDPvaKD1h3HpsPmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73754381D1F3;
 Thu, 25 May 2023 18:37:50 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE09520296C6;
 Thu, 25 May 2023 18:37:49 +0000 (UTC)
Date: Thu, 25 May 2023 14:37:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 04/12] block-backend: Fix blk_new_open() for iothreads
Message-ID: <20230525183748.GF132697@fedora>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="c8uiaRYCFr46ISxp"
Content-Disposition: inline
In-Reply-To: <20230525124713.401149-5-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


--c8uiaRYCFr46ISxp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 02:47:05PM +0200, Kevin Wolf wrote:
> This fixes blk_new_open() to not assume that bs is in the main context.
>=20
> In particular, the BlockBackend must be created with the right
> AioContext because it will refuse to move to a different context
> afterwards. (blk->allow_aio_context_change is false.)
>=20
> Use this opportunity to use blk_insert_bs() instead of duplicating the
> bdrv_root_attach_child() call. This is consistent with what
> blk_new_with_bs() does. Add comments to document the locking rules.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--c8uiaRYCFr46ISxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRvqvwACgkQnKSrs4Gr
c8h3UggAktJItivaZHPJ4QSIIGTngnKrd8L8gq2KEM9M4HCkCGRwhjdRt6pMY1Dd
e4Xb0WjN8SAyG+ECJUPptSoVY20Ygdd2sB9YPHOixZXxejiblH3hrrDUPpZcn5zB
DaJ5x11OQ5tsxBpFSGl6Th145V7MPW3aWq2XJtZ4xrtkKB1J9pt8WZVTpY+1aICp
U6qiWToHwtUhfuHjg9txyklL+90iu0OCPROQgoaxdH7CT8kFf+InIgRhOYIRTKYh
coWh6EJtAr18hF90+OegHSbZcJ0Ql4Z06J+Szlk0vwEuoHyOFt6aEGT2JZiAHX+q
uXYHEJv9D5gY2+SVuTX2+vewggezgA==
=ffRa
-----END PGP SIGNATURE-----

--c8uiaRYCFr46ISxp--


