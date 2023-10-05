Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EF07BA869
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 19:47:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSRK-0007O5-EG; Thu, 05 Oct 2023 13:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoSRF-0007Aq-Cg
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoSRD-0005gT-C0
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696528022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3758PgzZpvuVFNy+U1uTkswTTiER8PuxnuDDpXwTNiM=;
 b=ATBR7UeMKh83kEL5wKFUZu1XM8ToWZTU5n2vlBwL1rb52qY5PTlbWx2nMB1rrQeWXT5GfF
 dVgrsQWfrdbTtgts5X/lbIyZWO0Qk0o01qLONBRSBhW2S8zO6QsKVqmEPkLYLtniFDFCjn
 KG1TjOgzKGhSg3kQjLd4BjKdZz36rWU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-6kcORmUBNR6xizPXCvzD6Q-1; Thu, 05 Oct 2023 13:46:59 -0400
X-MC-Unique: 6kcORmUBNR6xizPXCvzD6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C779E185A79C;
 Thu,  5 Oct 2023 17:46:58 +0000 (UTC)
Received: from localhost (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B3AC111CD23;
 Thu,  5 Oct 2023 17:46:58 +0000 (UTC)
Date: Thu, 5 Oct 2023 13:46:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: Re: [PATCH v4 8/8] vhost-user-fs: Implement internal migration
Message-ID: <20231005174657.GI1342722@fedora>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-9-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E3HnexntZWZGy08/"
Content-Disposition: inline
In-Reply-To: <20231004125904.110781-9-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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


--E3HnexntZWZGy08/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:59:04PM +0200, Hanna Czenczek wrote:
> A virtio-fs device's VM state consists of:
> - the virtio device (vring) state (VMSTATE_VIRTIO_DEVICE)
> - the back-end's (virtiofsd's) internal state
>=20
> We get/set the latter via the new vhost operations to transfer migratory
> state.  It is its own dedicated subsection, so that for external
> migration, it can be disabled.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  hw/virtio/vhost-user-fs.c | 101 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 100 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--E3HnexntZWZGy08/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUe9pEACgkQnKSrs4Gr
c8gYjwgAxU2ww9s9PeIb8tYpVQ9//4vdONyEacrcqL+yQmGDV8hb4dXJe1K3g5y8
wOpaGhZ9z2dYOD3LD/5jNg45rK91k4rhZP/jcpNyEjCK0yjdf4jJEYvpVW1ENxc6
A+yTDdnzpzTxru+nxRAj7oBir+waOO/N2cLZ5aEMYCTJs/qMCQ04Na+ETsXKHbUB
AFStYKH+SQXQsHycVEg+uaimGyiZjghBWDuEz4PaDd2FhdfFrMCfHwkvr/C3avtJ
EPNLsbXlPraX4GScYonWU8VVKrXTo71nBMVTP+lLsDu1fNXDexqRo6xjgj9COe8w
BjvQ3Wfz/dUneQZzV7w2R6Xi7qONsQ==
=nlmV
-----END PGP SIGNATURE-----

--E3HnexntZWZGy08/--


