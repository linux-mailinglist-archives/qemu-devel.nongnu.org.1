Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4B1711619
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:58:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2GAL-0003lK-AB; Thu, 25 May 2023 14:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2GAJ-0003l7-Qc
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2GAI-00086k-GM
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685041101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jpkuHd49U/1w9DFXwbEuprwaEQbnreoDhilto7YgrYc=;
 b=Zj4ZY2dhgootnc1jFf5EEcv4y0aF8q+FCLoW6cBxvHO1V2134DVBSwSazgiZHuSBSx0CE1
 xFsqQz/0QKK9kUASSIeb/gMKjKNVpeG+1mnBR5IYpN1QVSg2LM9Qd3cuHOilDsv2zS8fjq
 51GKTTov1OP/zFHu4axLUOxaoTsAHQs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-uSvuTWP6OSm-DavOUDOwWg-1; Thu, 25 May 2023 14:58:19 -0400
X-MC-Unique: uSvuTWP6OSm-DavOUDOwWg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED3758002BF;
 Thu, 25 May 2023 18:58:18 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D63D1121314;
 Thu, 25 May 2023 18:58:18 +0000 (UTC)
Date: Thu, 25 May 2023 14:58:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 10/12] block: Fix AioContext locking in bdrv_insert_node()
Message-ID: <20230525185817.GL132697@fedora>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-11-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TBKwadwSR4fvkrjn"
Content-Disposition: inline
In-Reply-To: <20230525124713.401149-11-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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


--TBKwadwSR4fvkrjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 02:47:11PM +0200, Kevin Wolf wrote:
> While calling bdrv_new_open_driver_opts(), the main AioContext lock must
> be held, not the lock of the AioContext of the block subtree it will be
> added to afterwards.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TBKwadwSR4fvkrjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRvr8kACgkQnKSrs4Gr
c8i+eQgAh6SVnEE0ZL/hKCp19jUkEmsQGY6vrnTzpF8gDB+NDRvxOCExjJQmx4Ev
xYEAJUXS3i3Bcdpm8OWKG9108SwRFjuhc0P2BCNgEcv7x/pBK0KsFzpLUvL4XS9K
Dkx4SRi20ApPJ72VK6K/59HPTsEYI6G5o5sCKNl+BRLCiVY666p0cf7pC2Dg26lI
kEnQJU6/xEqAFVzO9sm7w6NBStGToMvtU0NyCUPJdoJcI0m0+3g3+b2H3PHbUp5v
N0HVTocgQrC2/P6AHo+xJVpairHI+SuYD9/5npgc2YvnfJUvYoVry5wTqPuR+57X
HFfUWDRJ79Taoa6xmkCE5xsb28pRnw==
=XAAi
-----END PGP SIGNATURE-----

--TBKwadwSR4fvkrjn--


