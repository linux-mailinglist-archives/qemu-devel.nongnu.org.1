Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AECFA811ADD
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:24:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDSxK-0007zw-6W; Wed, 13 Dec 2023 12:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDSx3-0007uJ-Uk
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:23:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDSx2-0001Ei-DB
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702488195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bcF6kabMw8JRNx5/UxsdOtTs4858nTmr7ZLiAL8adLo=;
 b=I4vs7Il6hWg/0A/JPMlGMXeBlqDbc2GRQVlS7L5arESB8Gwai7KGJ7NwYTgsAbaJz7OjAa
 1GAVspLCrk3ifZEcxrMHnvzDUkLGccqC9an61s74oPDiCeND61t4Gv81K7NN+MkRyIViaL
 4+bqdy/M1loGUeCJKVeH2uZWKsHQXEw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-nl8PBop1NPSodEcKjYAtGg-1; Wed, 13 Dec 2023 12:23:11 -0500
X-MC-Unique: nl8PBop1NPSodEcKjYAtGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89DD688F2EF;
 Wed, 13 Dec 2023 17:22:38 +0000 (UTC)
Received: from localhost (unknown [10.39.195.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 069CE3C25;
 Wed, 13 Dec 2023 17:22:37 +0000 (UTC)
Date: Wed, 13 Dec 2023 12:22:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, vikram.garhwal@amd.com,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH for 8.2] docs: clean-up the xenpvh documentation
Message-ID: <20231213172235.GA1490675@fedora>
References: <20231207130623.360473-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UVnCPlsdV4ZfjYIv"
Content-Disposition: inline
In-Reply-To: <20231207130623.360473-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--UVnCPlsdV4ZfjYIv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--UVnCPlsdV4ZfjYIv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmV56FsACgkQnKSrs4Gr
c8hpnQgAjq4OzQFs2JRy+7zazgTVxonhOpWcPgMYW6nEUxuFOkCpfbpKa4hPJXpn
64g/bfwJhJpYonCpczsNUlRCaGm/fvsmH5W181Oma7KnpHN/kkDFP8Bq60KZT4UR
zKp45A2M+x+xn6UtJTvGIxeQSVftBYnZdLrUQabtcb6B82WgZWTj6ckrQG/lnUTp
QD4v1rO1ye2lng7NdzxdTyoe7vqZmlJ3VmhdSmlNSUK8ViTnUOWw80wGKSuuEye7
UdR73iGyxEE4Eh0abUI0dFaPnic+SsP6T/iO4afS5nIk63SfHaMZyu9+X7yTasTY
mbj1i9RweZhUNzD0H56CTgBlOkCdfQ==
=vPp9
-----END PGP SIGNATURE-----

--UVnCPlsdV4ZfjYIv--


