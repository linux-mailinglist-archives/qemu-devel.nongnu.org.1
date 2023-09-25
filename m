Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 827277AE043
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 22:24:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qks7f-00012K-Kv; Mon, 25 Sep 2023 16:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qks7d-00010w-41
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 16:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qks7a-00048v-Pd
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 16:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695673437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qlc+nPHSx2NwgwT/RoZzeDhzPQHRR3dOY/JarxS2lgU=;
 b=VpOTMyM11Cj3wiYN7WWLZKz2/DSOzs55e+95yNjKEPxtrm0uct2qX3UU4X3eeZ3LI69DNg
 W/NjunaH8K7xKDbP03DMv3eqyoc2rGt9IrHPbv5dlHolrAEKumhW2uJjcpQu1/Ohe8rdgs
 vgq0Gjgd1mkIsniI+FPygITJFucUw5E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-KoQCW5S8P3iYNvLSkILyMg-1; Mon, 25 Sep 2023 16:23:55 -0400
X-MC-Unique: KoQCW5S8P3iYNvLSkILyMg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F409685A5BA
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 20:23:54 +0000 (UTC)
Received: from localhost (unknown [10.39.194.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75A0D711286;
 Mon, 25 Sep 2023 20:23:54 +0000 (UTC)
Date: Mon, 25 Sep 2023 16:23:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH v3 4/5] vhost: Add high-level state save/load functions
Message-ID: <20230925202353.GE323580@fedora>
References: <20230915102531.55894-1-hreitz@redhat.com>
 <20230915102531.55894-5-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G1vLTDuBl/2qpJYj"
Content-Disposition: inline
In-Reply-To: <20230915102531.55894-5-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--G1vLTDuBl/2qpJYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 12:25:29PM +0200, Hanna Czenczek wrote:
> vhost_save_backend_state() and vhost_load_backend_state() can be used by
> vhost front-ends to easily save and load the back-end's state to/from
> the migration stream.
>=20
> Because we do not know the full state size ahead of time,
> vhost_save_backend_state() simply reads the data in 1 MB chunks, and
> writes each chunk consecutively into the migration stream, prefixed by
> its length.  EOF is indicated by a 0-length chunk.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/hw/virtio/vhost.h |  35 +++++++
>  hw/virtio/vhost.c         | 204 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 239 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--G1vLTDuBl/2qpJYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUR7FkACgkQnKSrs4Gr
c8g53gf/efNh2hqj0IptWY7I+2HpZ9C+MMwAw60jvMILi4MzWiZAJt625pYSEqB6
eR0ov0YpFTrcOAtiKyREswaYnZ5bLQMppoocjQh/qApgiOXR+7ugaW87Pj6itGf5
yMenJBO7gURkeXfmFSUNzhiev5XOrKuSbw1IwWXEFzXIstT/dDujfYZ5Pr/M4Fjs
aKbo/dAmPxUP3OzVSZe49igboCIHKop+6WH3d3kQlLb5mlNcbldDtg4scRKq9IRY
slf5P/Cs47CpHbo5+USYEMg2FYA5tbU7+dlo3rd88e1Xkp9TDnVdpx1Akkmtke8j
3fjYbcZ3uF2xHGxGejCKm1G/3Cg7xg==
=kLNj
-----END PGP SIGNATURE-----

--G1vLTDuBl/2qpJYj--


