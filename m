Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C3CA73568
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Mar 2025 16:13:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txouv-0004PO-0P; Thu, 27 Mar 2025 11:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txouk-0004O1-Bk
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txouf-0002zg-3a
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743088374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SI1qp3g/YiogjPPnB+JBsi3L1r5y/3TgT/y43jWhhc4=;
 b=DRCyVq4qaFJ01hxsNEo7ehb/IC6C8lyug386QxHubANyzej7jcdEy9EGMTJ9RdeiDXv3aF
 yzGm9lEgQn2ChH2NfyOj8tiEFQZkYdQX+AbSNKOvNDRXTnOBXUd4ZBRanEW3bi6QSbESuz
 aeXA5mxPOPanTQYuuzwjlvDkZVI5fuw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-W56UBI0TPPutHH3x9qICMg-1; Thu,
 27 Mar 2025 11:12:52 -0400
X-MC-Unique: W56UBI0TPPutHH3x9qICMg-1
X-Mimecast-MFC-AGG-ID: W56UBI0TPPutHH3x9qICMg_1743088371
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79AA8180AB19; Thu, 27 Mar 2025 15:12:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D80630001A1; Thu, 27 Mar 2025 15:12:50 +0000 (UTC)
Date: Thu, 27 Mar 2025 11:12:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 08/15] fuse: Introduce fuse_{at,de}tach_handlers()
Message-ID: <20250327151250.GH37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-7-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XejjBBp09sal8E0w"
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-7-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--XejjBBp09sal8E0w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:06:48PM +0100, Hanna Czenczek wrote:
> Pull setting up and tearing down the AIO context handlers into two
> dedicated functions.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XejjBBp09sal8E0w
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmflavEACgkQnKSrs4Gr
c8jodAf/QVgiEQzPT9RCEsEC2Asv5TAtLwUuifKpVcEXF7PP7NMC9I30JYr2ENMJ
ojoxVcMkrNvRFCy/NKi8+cm0hYCadeOP0UGQeQEyD/AwAH+tGY8ZG9qYZvQ9IrRE
J2IJmn8DKL7stHgUugAuu+dREPodEepUot54kWlCbzqklAogC3lpRQvnWvXmZXf2
2vdCAVpH/hILU8b52+1rKrj/aGZdSeQua6J5d3U6lZXEDHu9yg56+iI07RmNk3M6
wwfKz7VI0i5VWtqrm9yTTHK3R1c+ejaxt1cVdJSkRpA7FNfd3MnwPy73c2cIeihz
w+9SdpKMonzp41vx1E7t6DNOgZLz9g==
=WTNm
-----END PGP SIGNATURE-----

--XejjBBp09sal8E0w--


