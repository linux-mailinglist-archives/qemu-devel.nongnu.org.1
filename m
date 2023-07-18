Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB581757FD8
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 16:42:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLlti-0007TR-4z; Tue, 18 Jul 2023 10:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLltg-0007TJ-OW
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLltf-0000ns-8p
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689691307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LvHRKJGuhXoOruTxHBmXYutSd4v4IHF/1xDzy+o4L7w=;
 b=PeaRVrd0egRn/Aq9nWfOVE7C23vlQifSC+k4KvaXArxUG+B1JxdZV9BWtIpdZY6Klo+Qfy
 w008qpEJh0g+MTZAbGmAIbDeqckyMJ87SW0iKjEB4uDpkXAUqcXp26BZZJOBTO8zdnbP+b
 WdwrkhpnW0ukb982RMJbXgQLnMxDRF8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-h3kuCz1dMgym1jHLZ8evJA-1; Tue, 18 Jul 2023 10:41:40 -0400
X-MC-Unique: h3kuCz1dMgym1jHLZ8evJA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FFD018DCABC
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 14:38:03 +0000 (UTC)
Received: from localhost (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C8BE40C2072;
 Tue, 18 Jul 2023 14:38:02 +0000 (UTC)
Date: Tue, 18 Jul 2023 10:37:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH 4/6] vhost-user: Implement suspend/resume
Message-ID: <20230718143757.GE44841@fedora>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-5-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Pc84NtWdHwoDzI4I"
Content-Disposition: inline
In-Reply-To: <20230711155230.64277-5-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--Pc84NtWdHwoDzI4I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 05:52:26PM +0200, Hanna Czenczek wrote:
> Implement SUSPEND/RESUME like vDPA does, by automatically using it in
> vhost_user_dev_start().  (Though our vDPA code does not implement RESUME
> yet, so there, the device is reset when it is to be resumed.)
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 99 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Pc84NtWdHwoDzI4I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS2o8UACgkQnKSrs4Gr
c8hivgf+Md6Luekn0yfVHvsqtU6FZocjpRa3pa6TbLKUI+RVfa1t9cyoOQo7yc/w
CKp+jt/AOZTZ8vmEH5hP/L4qVfPz5iCSs/Hls6f0kQTTdvntNhiHtW79StCmKf7q
TPEKT9Aa8rwrJeZEpXla3utkvt4W/o7WMGHELYhHfGic5kjgMO64ODJbibVqwH/F
vdhbw3dcpkxBsK2K/5bM2k9a3gpGv6HO1sQCvwKgbMvvtncAqo/FC1DR6Ae31vmb
2UQVG2qsgG+MekQJVbHBwrV0CMNjuQi9Ot51Jdut/ABw2uxUOI3ia5g2VRvN91US
3RkepOPyzoZKFScl018QoVHhZxHNqg==
=1/0J
-----END PGP SIGNATURE-----

--Pc84NtWdHwoDzI4I--


