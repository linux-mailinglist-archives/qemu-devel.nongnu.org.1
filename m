Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A48537A947E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:05:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJL6-0006ry-8M; Thu, 21 Sep 2023 09:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qjJGV-0007Mf-12
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qjJGS-00023D-1J
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695301117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vTHntr3nq2IRE/5xa92Oc58XK/Zw79844utx0vWmfI4=;
 b=Yl+NO7hgabtTlfanf7idWzhdfCvSyV8bx2U1rpik3R3e5hEYP5Qkm6XLsINxWzlU61yHzO
 qCdmuhxVTYsD86khYYMspcRu7A9o4k+ilZ9ukvwubni2aJDvV0/yJvX2APbHmMlKAFOLp4
 bzyz5XIIUwYzOmLJnxy2qOAlkoH0ct0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-ZMZ5uzU4PROYhCLJvWw_zw-1; Thu, 21 Sep 2023 08:58:34 -0400
X-MC-Unique: ZMZ5uzU4PROYhCLJvWw_zw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 315C3101B051;
 Thu, 21 Sep 2023 12:58:30 +0000 (UTC)
Received: from localhost (unknown [10.39.195.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A974F40C2064;
 Thu, 21 Sep 2023 12:58:29 +0000 (UTC)
Date: Thu, 21 Sep 2023 08:58:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Yan Vugenfirer <yan@daynix.com>
Subject: Re: [PATCH v2 07/10] virtiofsd: Use qemu_get_runtime_dir()
Message-ID: <20230921125828.GA3860191@fedora>
References: <20221110100629.61496-1-akihiko.odaki@daynix.com>
 <20221110100629.61496-8-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oHXNBpnbo8awhOQJ"
Content-Disposition: inline
In-Reply-To: <20221110100629.61496-8-akihiko.odaki@daynix.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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


--oHXNBpnbo8awhOQJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 10, 2022 at 07:06:26PM +0900, Akihiko Odaki wrote:
> qemu_get_runtime_dir() is used to construct the path to a lock file.
>=20
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  tools/virtiofsd/fuse_virtio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
> index 9368e292e4..b9eeed85e6 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -901,12 +901,12 @@ static bool fv_socket_lock(struct fuse_session *se)
>  {
>      g_autofree gchar *sk_name =3D NULL;
>      g_autofree gchar *pidfile =3D NULL;
> -    g_autofree gchar *state =3D NULL;
> +    g_autofree gchar *run =3D NULL;
>      g_autofree gchar *dir =3D NULL;
>      Error *local_err =3D NULL;
> =20
> -    state =3D qemu_get_local_state_dir();
> -    dir =3D g_build_filename(state, "run", "virtiofsd", NULL);
> +    run =3D qemu_get_runtime_dir();
> +    dir =3D g_build_filename(run, "virtiofsd", NULL);
> =20
>      if (g_mkdir_with_parents(dir, S_IRWXU) < 0) {
>          fuse_log(FUSE_LOG_ERR, "%s: Failed to create directory %s: %s\n",

tools/virtiofsd/ no longer exists. Which version of QEMU did you develop ag=
ainst?

commit e0dc2631ec4ac718ebe22ddea0ab25524eb37b0e
Author: Dr. David Alan Gilbert <dgilbert@redhat.com>
Date:   Wed Jan 18 12:11:51 2023 +0000

    virtiofsd: Remove source

Stefan

--oHXNBpnbo8awhOQJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUMPfQACgkQnKSrs4Gr
c8hgbggArWYb7U0xzFenrEIMYnGJwINoehg+E3n1EvJ/v7yBQc22lMzEHpRHjHUY
qZl3t9E26YEbaGTrs/v0pGtaAtqnfIUkrEMa9sOt8avgr7S0MW9NzROgBLFCfyNr
7v6BSA3ygJXoNnIvUIMp7kibrnAVciXLaMsDhzfjGVuDy/P505I2PGTeJ1n1Ai5x
nFuUgU/yCRIJ8CT7ZymJh22oq8m+TIFQePDsuwDrncqagfI4VducJjZADcIITbPk
FX2ETIoaKTa10SbYpIcmamWv2nQdLJE9DY/Kj8nzIIYRfi4uA1e2maRdav1+FpJ5
z0eiauABUiI9eZ/+qgmXJPxNuuglcg==
=lygc
-----END PGP SIGNATURE-----

--oHXNBpnbo8awhOQJ--


