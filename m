Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE987BA86A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 19:47:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSR2-0006cj-06; Thu, 05 Oct 2023 13:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoSQz-0006bz-0t
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:46:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoSQx-0005cn-JV
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696528006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ul7ZTcZle2iwZBE8YxQSWob1f1To0H9pX9Kzy1ownow=;
 b=jQAYF6S+dYtCSlrWg+qMzemoXc92MZEbjHWuQCyLqwc/wUuJn5wSWDBNL496enozFUeJ1n
 u/8t7JtpR+WorR5IaAd4k9S16YiZSy0gOGDDLJJ0EdtepWW7Y7tNGkyNQ5s7xsBeRLkWXK
 4AM/0symNnHBo7cMBKwlEUmz6qYhrF8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-DOqh4_CNNKqjNryGGqXivg-1; Thu, 05 Oct 2023 13:46:27 -0400
X-MC-Unique: DOqh4_CNNKqjNryGGqXivg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A0A8800969;
 Thu,  5 Oct 2023 17:46:27 +0000 (UTC)
Received: from localhost (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10A74492B05;
 Thu,  5 Oct 2023 17:46:26 +0000 (UTC)
Date: Thu, 5 Oct 2023 13:46:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: Re: [PATCH v4 6/8] vhost-user: Interface for migration state transfer
Message-ID: <20231005174625.GG1342722@fedora>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-7-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6sPmmG1cmDCEPdDX"
Content-Disposition: inline
In-Reply-To: <20231004125904.110781-7-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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


--6sPmmG1cmDCEPdDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:59:02PM +0200, Hanna Czenczek wrote:
> Add the interface for transferring the back-end's state during migration
> as defined previously in vhost-user.rst.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/hw/virtio/vhost-backend.h |  24 +++++
>  include/hw/virtio/vhost.h         |  78 ++++++++++++++++
>  hw/virtio/vhost-user.c            | 148 ++++++++++++++++++++++++++++++
>  hw/virtio/vhost.c                 |  37 ++++++++
>  4 files changed, 287 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6sPmmG1cmDCEPdDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUe9nEACgkQnKSrs4Gr
c8hPDgf+N8SSbfkTtcNSDYkblMnfmS7Td5y09f8PzEaPrBkdPa42BjmANVEjkMSA
vZu1F6Fm8JYY/Ytjbk7GTyA+gNrzggkUVBXnaisJfnnj9dtwkwct5R+v1XozZ6ZL
R4jm8KVpdQDf/Mz0scI33g7V5Uh+iWGnhUHipqXR3bU7hO+PfffPRoZbY/DSpIvB
+gUFh+KB/5jUJh3WDc7on1R3BqZGCB1LRq/9HUsLDog7brBUMDqJ9QSpYcZf4G3r
GpAB5hFjEOvWvsgnjT928Vqa6Mr8tcaIh3cUmWn/5t2njFZXwDmdajxKVrbeJ8+R
sJZ74c3RhFiIAhLJiMirrjAXYr6avg==
=DrRn
-----END PGP SIGNATURE-----

--6sPmmG1cmDCEPdDX--


