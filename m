Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8887BA868
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 19:47:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSR1-0006cA-2L; Thu, 05 Oct 2023 13:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoSQy-0006bs-L0
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoSQx-0005cp-87
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696528006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oCEx+e7zhURH47CTIYcozc8nPDJG7sAi2IbfSeAF2H0=;
 b=hn9FPqZ/6i0v8BUE3sKLYTEDhzNRDNkonsmZiv1FQiZFZXt7WE43bLEpYFxeopNO54eRon
 OZzrTBGSbKjPVLRb0pAHApf1Quq/PDQA5wN/MKP9rJ35zNRzCpBDVsR4zt3Xb0R5r8ADz1
 gnnQ7y1+24uOL3zgKEvfiG84t+Ybur8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-KSuavLKiPiO4kRPFalwbmA-1; Thu, 05 Oct 2023 13:46:41 -0400
X-MC-Unique: KSuavLKiPiO4kRPFalwbmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C7091875054;
 Thu,  5 Oct 2023 17:46:41 +0000 (UTC)
Received: from localhost (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1864A40C6EA8;
 Thu,  5 Oct 2023 17:46:40 +0000 (UTC)
Date: Thu, 5 Oct 2023 13:46:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: Re: [PATCH v4 7/8] vhost: Add high-level state save/load functions
Message-ID: <20231005174639.GH1342722@fedora>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-8-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8SCwRJLZuG5agDQG"
Content-Disposition: inline
In-Reply-To: <20231004125904.110781-8-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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


--8SCwRJLZuG5agDQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:59:03PM +0200, Hanna Czenczek wrote:
> vhost_save_backend_state() and vhost_load_backend_state() can be used by
> vhost front-ends to easily save and load the back-end's state to/from
> the migration stream.
>=20
> Because we do not know the full state size ahead of time,
> vhost_save_backend_state() simply reads the data in 1 MB chunks, and
> writes each chunk consecutively into the migration stream, prefixed by
> its length.  EOF is indicated by a 0-length chunk.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/hw/virtio/vhost.h |  35 +++++++
>  hw/virtio/vhost.c         | 204 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 239 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8SCwRJLZuG5agDQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUe9n8ACgkQnKSrs4Gr
c8hHRwgAsniNhUQF6fB3+pYk91OUG/cI8VpaQx+w5MzEm7V9JLDFr95NlSEa2AwE
Ujxpk47hsn0XcTvZw24iPuTQCORllr3KZaghJHRh4C9f4HYq99n5CGU3qfSBjcgi
5Bu7h3H0pa9rb2W1hzYHDCquuEVMBMG2Y29VuHRUx3oTpcrWozLe9YiTJnfP5S+P
sqMTLc0HXKmeIOh8pcEA6i7tKkRE/baIjivjE/nIlO13hmdXFMqYitMJNWWlhlOQ
BBdh07Y7LD40a7J0O9+PJsmvkOcaHCjRHjcdkeRviDLkKrBTim6+x5A2JCXTHu4r
W+7G3WTBe5vuFfhkHp2dMispEbYm6A==
=oRVw
-----END PGP SIGNATURE-----

--8SCwRJLZuG5agDQG--


