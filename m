Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3768D7BA85C
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 19:45:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSPh-0005gf-30; Thu, 05 Oct 2023 13:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoSPL-0005dl-TA
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoSP7-00059O-N6
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696527892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RPIPeGdVdNPeyTseCP9G8ldvR7n8mTDPKCIQpnVZur8=;
 b=XQOIGWQ1/JLAAMIMIUq4mHfjk9tTVGYwFuDiF7BS8VKgZn8G6VEH4R0U0Pr2jP2aLxQaox
 CMmuOUJun95DY9BgvPq6llVS82j/3HPbYfcEFZaedHy82a7oUZMJTO5VHwaEYxV6vA+IPX
 b9WGUCr0kwv4UWdA/Ux/yTL9zzaF9vA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-GiZU82vVNWWT1lXePE40pQ-1; Thu, 05 Oct 2023 13:44:49 -0400
X-MC-Unique: GiZU82vVNWWT1lXePE40pQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9BCE101AA68;
 Thu,  5 Oct 2023 17:44:48 +0000 (UTC)
Received: from localhost (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C363C15BB8;
 Thu,  5 Oct 2023 17:44:48 +0000 (UTC)
Date: Thu, 5 Oct 2023 13:44:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: Re: [PATCH v4 4/8] vhost-user.rst: Introduce suspended state
Message-ID: <20231005174447.GE1342722@fedora>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-5-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BiiMM0ypZsvH1hYP"
Content-Disposition: inline
In-Reply-To: <20231004125904.110781-5-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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


--BiiMM0ypZsvH1hYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:59:00PM +0200, Hanna Czenczek wrote:
> In vDPA, GET_VRING_BASE does not stop the queried vring, which is why
> SUSPEND was introduced so that the returned index would be stable.  In
> vhost-user, it does stop the vring, so under the same reasoning, it can
> get away without SUSPEND.
>=20
> Still, we do want to clarify that if the device is completely stopped,
> i.e. all vrings are stopped, the back-end should cease to modify any
> state relating to the guest.  Do this by calling it "suspended".
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--BiiMM0ypZsvH1hYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUe9g4ACgkQnKSrs4Gr
c8jqNQgAh3/NLIUfC62NRsbyqKCQI96jvjtfA0HkcxrLnE3mMOGCePEIMzhkBzqx
HLvjE79D5JGQKaiOQHlOFNj9xHHeIBoqan03Z8yhCWgNvW5NDD0I2xDGtsPm7eUj
urfyyCYxK9ldOQAW9iNJsDySgHZArZ1yGO9n4Gyl5fWU4GH0drK2dnrf0E7lYhw7
Mh63aI4YjkzQZgDyc/WZCWN5qUyxLveV34fmvlvGhzZeZYndJS/9s2bXp+2pCL/H
eCbuTDBcN9CW7zPk9uxcjcXIf3u0pklFDRxGJLatX5IRAycmgugXqQGCrwL9FXHe
4/pEoqDS6ylC06izJ3ZReEgLv+izLw==
=de4m
-----END PGP SIGNATURE-----

--BiiMM0ypZsvH1hYP--


