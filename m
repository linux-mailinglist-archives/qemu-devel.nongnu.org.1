Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 719CC784A78
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:30:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYX4d-0000cI-9R; Tue, 22 Aug 2023 15:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYX4b-0000YE-Cf
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYX4Z-0003RG-DA
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692732590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZ+4caOJmMRkz13FXwNKA3aAtxKeMMuoM3rtXf1OjJU=;
 b=JJThDS6vro1qlvFzwRyVHia0j8XRoLYGoInpyFMeaipm3GKZMuHHhxt6Jy5l1yXqcTnF4b
 +h+KNWy44zh8CnTOd2EYJlDfQQGV14oOGGhQK7TwQeXNg0wEnRdT40mQpTYS8VFfs5sc1d
 kEbpXXi4fEjU+/xLpad/ODhIYARC2Eg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-GJbgad4pOhSzr4_JGhDRnA-1; Tue, 22 Aug 2023 15:29:47 -0400
X-MC-Unique: GJbgad4pOhSzr4_JGhDRnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CC891C04181;
 Tue, 22 Aug 2023 19:29:46 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 071F91121314;
 Tue, 22 Aug 2023 19:29:45 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:29:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 16/21] block: Mark bdrv_parent_cb_change_media()
 GRAPH_RDLOCK
Message-ID: <20230822192944.GT727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-17-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="F108MU27NZTgjbpx"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-17-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--F108MU27NZTgjbpx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:15PM +0200, Kevin Wolf wrote:
> The function reads the parents list, so it needs to hold the graph lock.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--F108MU27NZTgjbpx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlDKgACgkQnKSrs4Gr
c8iGjwgAx8zKM666eKDljs00hPKA2oSyNwdcpKjdAIFR/LiAszln+HAQL7Uoocah
RlSEaOIy+S8/T+pbWs/A1OteP0GuX5xrauDj66qz6BkWynIhWu42dq4rhmL7oGGb
bWwRP8G7MFQbLW8L9rKB254u3pMq8MAUSZmtSOXRvIdEuyMtCXkHlGNuS0lxuwOj
iH//brS5i3uE9JEovMhk8/V0k7+H8mq12vZhCmB0a9RN854i4UhL+NUOYvIcKZId
GVggeosG49JY7eCHRnHnL9utmF7dL0XPnkgl5MFLxV3cJD2K7MRpG21CsOdublbf
Cm9Q4u0A+FHj8tf3LKhGAIZThuPYQg==
=IT78
-----END PGP SIGNATURE-----

--F108MU27NZTgjbpx--


