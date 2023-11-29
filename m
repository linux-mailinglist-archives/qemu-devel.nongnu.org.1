Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7F77FD87E
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 14:44:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Kql-0003ct-L3; Wed, 29 Nov 2023 08:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8Kqj-0003cc-88
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 08:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8Kqh-0000mQ-Ip
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 08:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701265410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7es7mT6I3z/r6GS8G7JPLU1QYcuJuDJRm/6RZk3JeM=;
 b=M7hjkS5jxeSp5QOAg2UxYpiuVIh4BSh86ZNSe+n5243U1WZLRq231NBAXqtkgguZyi4/tC
 f1gGjgnau+HjKJRQa18LQn9mJMyT61Joie0EcRdeSqB7YdpQIXADdRUPpZ+U54TWHyjpZw
 DiqQ20PKfX8W4/5TCY4L/8qphic2PGo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-Ds4K253QMZCWcs3nS_Hyxg-1; Wed,
 29 Nov 2023 08:43:28 -0500
X-MC-Unique: Ds4K253QMZCWcs3nS_Hyxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 150861C0315E;
 Wed, 29 Nov 2023 13:43:28 +0000 (UTC)
Received: from localhost (unknown [10.39.192.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FC8C40C6EBB;
 Wed, 29 Nov 2023 13:43:26 +0000 (UTC)
Date: Wed, 29 Nov 2023 08:43:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: fam@euphon.net, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/2] vhost-scsi: Support worker ioctls
Message-ID: <20231129134323.GA774040@fedora>
References: <20231127002834.8670-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BZ+tsMPd8GSg5KYe"
Content-Disposition: inline
In-Reply-To: <20231127002834.8670-1-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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


--BZ+tsMPd8GSg5KYe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 06:28:32PM -0600, Mike Christie wrote:
> The following patches allow users to configure the vhost worker threads
> for vhost-scsi. With vhost-net we get a worker thread per rx/tx virtqueue
> pair, but for vhost-scsi we get one worker for all workqueues. This
> becomes a bottlneck after 2 queues are used.
>=20
> In the upstream linux kernel commit:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/vhost/vhost.c?id=3Dc1ecd8e9500797748ae4f79657971955d452d69d
>=20
> we enabled the vhost layer to be able to create a worker thread and
> attach it to a virtqueue.
>=20
> This patchset adds support to vhost-scsi to use these ioctls so we are
> no longer limited to the single worker.
>=20
> v2:
> - Make config option a bool instead of an int.
>=20
>=20

Aside from Stefano's comment asking for a warning when the kernel
doesn't support the vhost worker ioctl:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--BZ+tsMPd8GSg5KYe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVnP/sACgkQnKSrs4Gr
c8jvNQf9EAhMiHoRlq0mHR90DTUsl2am2+sbhX8Xyv7/niqq7fGSzHRlJNiVbi47
bRrk5AadZrJxIZBhUh97fqu/JkhEq1pPPd34QmBXgBGqX5+FA9Kr168FNSwp5AuU
OfJejiwOsFC52pJA1xYPaw1zoK1uIIB57KjvDJSjJVmdZYLWQE2Q/zLERDhX3UIO
5jS5gIl42igZaoQCdQG4DwA4qH9+WqezG4+3JBQeZQ4nfW4SlAtn+DWA74/+kDNO
zjIbzLYYMfOtONu97R3B1++aB3IjzEewJU1539HsXW5K1DnbpXDglzvdxQQ5J795
11mVoKEEbwxCegl3ZO7cQ8Dju4XibA==
=omaH
-----END PGP SIGNATURE-----

--BZ+tsMPd8GSg5KYe--


