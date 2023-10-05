Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB767BA855
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 19:45:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSO2-0004fM-8Q; Thu, 05 Oct 2023 13:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoSO0-0004eU-1h
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoSNx-0004om-HS
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696527819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p0itKNhzeMx74t/+gK5QA1MDIfNAGDMVUcXIcUF6HFo=;
 b=VTXDN19ALSuw0SGKuTGLokAbjtTMCka1ZCOJVeF9FUCtzzYDxXRtjuHy50gOQT2MWlu4an
 4fs3/1N74dj119yy4KC8xes8rX+QCkSbDuQIO8zMRgB+X+RuuUMYV9ytDzQXRJipm2tn38
 dx1/ArICQgdpWEJej8Mo228GJn1iN+g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-1mAhzpflNwmb9QLrWpXk3w-1; Thu, 05 Oct 2023 13:43:35 -0400
X-MC-Unique: 1mAhzpflNwmb9QLrWpXk3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F5733C1ACD6;
 Thu,  5 Oct 2023 17:43:35 +0000 (UTC)
Received: from localhost (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E75C940B3ECE;
 Thu,  5 Oct 2023 17:43:34 +0000 (UTC)
Date: Thu, 5 Oct 2023 13:43:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: Re: [PATCH v4 3/8] vhost-user.rst: Clarify enabling/disabling vrings
Message-ID: <20231005174333.GD1342722@fedora>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-4-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="t+JYja1hNqvjfZWk"
Content-Disposition: inline
In-Reply-To: <20231004125904.110781-4-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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


--t+JYja1hNqvjfZWk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:58:59PM +0200, Hanna Czenczek wrote:
> Currently, the vhost-user documentation says that rings are to be
> initialized in a disabled state when VHOST_USER_F_PROTOCOL_FEATURES is
> negotiated.  However, by the time of feature negotiation, all rings have
> already been initialized, so it is not entirely clear what this means.
>=20
> At least the vhost-user-backend Rust crate's implementation interpreted
> it to mean that whenever this feature is negotiated, all rings are to
> put into a disabled state, which means that every SET_FEATURES call
> would disable all rings, effectively halting the device.  This is
> problematic because the VHOST_F_LOG_ALL feature is also set or cleared
> this way, which happens during migration.  Doing so should not halt the
> device.
>=20
> Other implementations have interpreted this to mean that the device is
> to be initialized with all rings disabled, and a subsequent SET_FEATURES
> call that does not set VHOST_USER_F_PROTOCOL_FEATURES will enable all of
> them.  Here, SET_FEATURES will never disable any ring.
>=20
> This interpretation does not suffer the problem of unintentionally
> halting the device whenever features are set or cleared, so it seems
> better and more reasonable.
>=20
> We can clarify this in the documentation by making it explicit that the
> enabled/disabled state is tracked even while the vring is stopped.
> Every vring is initialized in a disabled state, and SET_FEATURES without
> VHOST_USER_F_PROTOCOL_FEATURES simply becomes one way to enable all
> vrings.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--t+JYja1hNqvjfZWk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUe9cUACgkQnKSrs4Gr
c8hqeQf+J8jHFezwIR2ygsUKJwEjYNdeoaFotnS5EMqR8I+Hw2lPWz6qeWKBKCxt
97zucS5Cuae/QH8sMKlb+c9FvGAG+3ibNFTQNo0U51s7eZzUQVLTjRYFLY+q7e1Q
fcXqP0ju7ZoXvEYsjuaLqXMyfPNWLMesoOpE9nmPErW7QtZXMd5utSFphqUNIp3O
GQGKynO33pfkolMqLBBa9tcYV6bSfKV/jlJMmMz2AZIYvmfj1uajomU08JLuVznt
Lpx/fZj8QLkyKeTK63Xr0YcyV/XnSRlW/UuJIluis0Uagc42G03wNVmD32TAL5NE
30sSwJAK+GI5q+Ae8UI4msWvN0BuMQ==
=8Kbw
-----END PGP SIGNATURE-----

--t+JYja1hNqvjfZWk--


