Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAF77AE03F
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 22:20:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qks2b-0006ir-RF; Mon, 25 Sep 2023 16:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qks2Y-0006hS-0N
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 16:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qks2W-0003JY-BY
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 16:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695673122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ir41adnngj7M73aEWvrBzVXVr3Nx1p/nIVdUntOb/0c=;
 b=Q8ZqnQ3F2AMdSgoyFEClwWmI+d0SJ4q103NpyIOnlRS6jThx5IQA/DnXUhdviKmG0ASYjV
 c7wC3ln9cTLkOPLjIhPH35YVbGi6g0OuvVTpvjp+u9HW52o8BBY5Fe8lG5MGs7d4R0OPIF
 FQsOT/O/RYRYE6UxWEEwgh0Pzu11uSs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-7HirmlBiMUCM1nfHG6-KKA-1; Mon, 25 Sep 2023 16:18:40 -0400
X-MC-Unique: 7HirmlBiMUCM1nfHG6-KKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 905723816C94
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 20:18:40 +0000 (UTC)
Received: from localhost (unknown [10.39.194.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FA282026D4B;
 Mon, 25 Sep 2023 20:18:39 +0000 (UTC)
Date: Mon, 25 Sep 2023 16:18:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH v3 3/5] vhost-user: Interface for migration state transfer
Message-ID: <20230925201838.GD323580@fedora>
References: <20230915102531.55894-1-hreitz@redhat.com>
 <20230915102531.55894-4-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="muhzgkgoTP5FcE5Q"
Content-Disposition: inline
In-Reply-To: <20230915102531.55894-4-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--muhzgkgoTP5FcE5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 12:25:28PM +0200, Hanna Czenczek wrote:
> Add the interface for transferring the back-end's state during migration
> as defined previously in vhost-user.rst.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/hw/virtio/vhost-backend.h |  24 +++++
>  include/hw/virtio/vhost.h         |  79 ++++++++++++++++
>  hw/virtio/vhost-user.c            | 148 ++++++++++++++++++++++++++++++
>  hw/virtio/vhost.c                 |  37 ++++++++
>  4 files changed, 288 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--muhzgkgoTP5FcE5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUR6x4ACgkQnKSrs4Gr
c8ikuAgAxVyVj19bGYPACb0rP8tXyXpMj+bzYHrVoB1XOdkKo/Knw46Eu9I4Ljtz
8eHonM7YAOz6/3DTvMk6/wuiC3iMzs4FS0WZ+cKkfdiM6Opt9z8ultvuH4ZGbxQa
nf/TVaQJY7rVditSx+0h8oBiQk0GbCS5cwSzItdfPYLF8/Q1ZeyG/0Qt2Iy3kRHe
9s1Wuix6YZRNTLYi7uvlbAzVpKDzbnnCnVPwCznDSf2qZKWQg1xQdNxH79JSPaDn
ujmwTstFEs8heh0ZxD3DZaxRXeSHIyqIe1RdpDn0u+YL7/45IMJrFXMGlLDj5h3w
7lIu/+H92bNwLkMKL1OWGhWTa++tng==
=ifEH
-----END PGP SIGNATURE-----

--muhzgkgoTP5FcE5Q--


