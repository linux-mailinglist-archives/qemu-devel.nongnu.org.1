Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 234027584FD
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 20:44:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLpgG-0006nU-RR; Tue, 18 Jul 2023 14:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLpgE-0006n3-IV
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLpgD-0001RY-4i
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689705850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tb0DQL+eraw/WsvYWvwJdPSPO3Ql6b99+Rjh67H3D+8=;
 b=iFgCyKggPoshYl78dMwvK80rJ7H8CEG2ddhewakq+WGzCfFuhgMe9xT58CRUXdo/CUtyZZ
 LL6TLHzlFrNXO3tA3ku6hAOCcps3IeuLX9xC0Cc9oQjA+LPy3r5D48301gjymWRK3TMumX
 JrvyGUZ+UcyTbanuZloqs6qYOna+lO4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-GeEif05rPbaurrzhWZQnVA-1; Tue, 18 Jul 2023 14:44:08 -0400
X-MC-Unique: GeEif05rPbaurrzhWZQnVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F35291C07545
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 18:44:07 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AB46F66D0;
 Tue, 18 Jul 2023 18:44:07 +0000 (UTC)
Date: Tue, 18 Jul 2023 14:44:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v2 4/4] vhost-user-fs: Implement internal migration
Message-ID: <20230718184405.GN44841@fedora>
References: <20230712111703.28031-1-hreitz@redhat.com>
 <20230712111703.28031-5-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6wa/D7BRPF2G8XTF"
Content-Disposition: inline
In-Reply-To: <20230712111703.28031-5-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--6wa/D7BRPF2G8XTF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 01:17:02PM +0200, Hanna Czenczek wrote:
> A virtio-fs device's VM state consists of:
> - the virtio device (vring) state (VMSTATE_VIRTIO_DEVICE)
> - the back-end's (virtiofsd's) internal state
>=20
> We get/set the latter via the new vhost operations to transfer migratory
> state.  It is its own dedicated subsection, so that for external
> migration, it can be disabled.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  hw/virtio/vhost-user-fs.c | 101 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 100 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6wa/D7BRPF2G8XTF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS23XUACgkQnKSrs4Gr
c8iXVAf+NllGwBz6+X27TWFo5xx0UhMghIuI6ybXbutx9lQSuSTdmc3hwtlKRU7y
5cxaw9fKGXsYF7zi6LxFn4onRSmjGFe2uAnk5vPmff+idaI5XOV25Vlg6Bb/RbNm
c8asN3q8B7petk/Jc9x5BZZTgNBhBqezCJoWUCP/L/hgIrs+geh0e2+ARukaK8RV
GJutJnXg3fxoijcmbmAU/q3NPQ8fr440buDrNaeSlmopeg+ikcHDAD+aneakojbs
oTvnsAJchJ1GPPQPjZJWpe536j9XhUX7Y40WFd4luRLpkBIUIRQTe+JmiAemSp5u
xEoHG6dQPLyw1VEcwOD3XzyaRiSrlQ==
=Awnu
-----END PGP SIGNATURE-----

--6wa/D7BRPF2G8XTF--


