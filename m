Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E32287849E5
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:05:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWh2-0005o3-IO; Tue, 22 Aug 2023 15:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWh0-0005ns-9F
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWgy-0005hr-7e
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692731127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2i6L3EZPsRg9TU6M1dC94TQn2EmNIzCcGAYQmjfGg1s=;
 b=Rt1WEvdyY1gKXhyp4DPTMvqqrYmoS3qswKL0+2cPGoB2o/D2exqDKzXbKFLt66FQh8XWCE
 PABO0vU5VaxNN5LUMkTNDvDHymmSh4CwZQ61nBL7oC24yU3IW8xkDyucu/bqFNh5TLjkR3
 nMMiVcF9GvUS8pTp7FQFDF0/fpFuZCY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-A9KYaa9xMRa8VPHYgIOYdA-1; Tue, 22 Aug 2023 15:05:25 -0400
X-MC-Unique: A9KYaa9xMRa8VPHYgIOYdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A0F63814942;
 Tue, 22 Aug 2023 19:05:25 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E67E964661;
 Tue, 22 Aug 2023 19:05:24 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:05:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 08/21] block: Mark bdrv_replace_child_noperm() GRAPH_WRLOCK
Message-ID: <20230822190523.GK727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-9-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jsvuK0DjMmoA5Pd9"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-9-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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


--jsvuK0DjMmoA5Pd9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:07PM +0200, Kevin Wolf wrote:
> Instead of taking the writer lock internally, require callers to already
> hold it when calling bdrv_replace_child_noperm(). These callers will
> typically already hold the graph lock once the locking work is
> completed, which means that they can't call functions that take it
> internally.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jsvuK0DjMmoA5Pd9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlBvMACgkQnKSrs4Gr
c8hMsggAxEkMDTqAABqlXBgsSZEnryK6K/Dl8loY/Ps9TPbVVE0fIxOX8maowmDD
RzCtsdnMDYsU+v5g4MLqxgmvana4hmi9jTbnArr9taVSIDW6iHcpZ5qjfpYQeAvf
o8YuxSSImTSBzmug+8EMP5qh+nl23t2AA27bA9YKv7D4b7fQ5AlgWnwR5CsCNiPA
jBRvGRUAAlEUD94eWW+9EkZ/cxfuz8yn+2lzwcAsaReDGhxhD2B69oPf6M10rj3g
vzjkBe/B8/pSnBXtSSzAvZdrP4qeJiL/UW/vxPkZew4nTeNZowH7fDiIlyUsf7ye
hx/8p6nGZNjNDCazkJ1YxQ+s2HPYzg==
=HFNr
-----END PGP SIGNATURE-----

--jsvuK0DjMmoA5Pd9--


