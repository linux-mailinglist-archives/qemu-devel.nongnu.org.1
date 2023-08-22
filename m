Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7DD784A86
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:36:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYX9v-0005vN-Qa; Tue, 22 Aug 2023 15:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYX9l-0005p9-97
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYX9i-0005CU-Pp
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692732908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sr0AYOB3pFsJotI0XmHXIMmObopaVDUTS+W99no6/ng=;
 b=IJaLquTRr4Oalqk7frT2thDKBHQT4KN7NHahAsdHR5qQuKAe+vdnoWhgeOYgWPXQIpjbZ2
 mETGXvTTSWm78vm0RxbStDdQcPXVbZ+EqBQlZHl6TjY2L5CuI/ZgDnnO6Vo+pU44YutRTt
 +yCls2TLk/Db2mjRTVaA6/A9x6GkZBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-kCK9oUnsMMiXDPnIe2NuqA-1; Tue, 22 Aug 2023 15:35:04 -0400
X-MC-Unique: kCK9oUnsMMiXDPnIe2NuqA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B94E6858EED;
 Tue, 22 Aug 2023 19:35:03 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50D87C15BAE;
 Tue, 22 Aug 2023 19:35:03 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:35:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 17/21] block: Take graph rdlock in bdrv_drop_intermediate()
Message-ID: <20230822193502.GU727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-18-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ID+33Dwtqxy/1kpi"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-18-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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


--ID+33Dwtqxy/1kpi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:16PM +0200, Kevin Wolf wrote:
> The function reads the parents list, so it needs to hold the graph lock.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 7df8780d6e..a82389f742 100644
> --- a/block.c
> +++ b/block.c
> @@ -5934,9 +5934,11 @@ int bdrv_drop_intermediate(BlockDriverState *top, =
BlockDriverState *base,
>          backing_file_str =3D base->filename;
>      }
> =20
> +    bdrv_graph_rdlock_main_loop();
>      QLIST_FOREACH(c, &top->parents, next_parent) {
>          updated_children =3D g_slist_prepend(updated_children, c);
>      }
> +    bdrv_graph_rdunlock_main_loop();

This is GLOBAL_STATE_CODE, so why take the read lock? I thought nothing
can modify the graph here. If it could, then stashing the parents in the
updated_children probably wouldn't be safe anyway.

> =20
>      /*
>       * It seems correct to pass detach_subchain=3Dtrue here, but it trig=
gers
> --=20
> 2.41.0
>=20

--ID+33Dwtqxy/1kpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlDeYACgkQnKSrs4Gr
c8hc6Qf/UrYCUTPc5ZOkOq+9vx/kJwcguQsRy3qCWQidl4fbAqbqDRZApOA6wbV1
tkVSyCM799iKjkeMThMUVotWYV/CR094MmXLVsIVOQdx1au8p8RNcUOxdd7ihnRV
dkSDFTGdERW3Z6sdYcOtBu2a56I1uXcosjprbJ18nA4ZKb22kqAdhgkYKgVILIYp
R5gAdMVo8dA4S4OkTjBv4BhHvlk0YVlbN3RppjQBm+wjex0c3dpKbKUZYtYft9Nm
zfJVqBfHJcSZiCgUsgGpNlJsnrq5FEJS2j92eotUP3DSYY3R5XLPFA3i8xFwyNAu
n+HdcLiPg9nruqnchC4CZy3Dg+VXvA==
=wSyr
-----END PGP SIGNATURE-----

--ID+33Dwtqxy/1kpi--


