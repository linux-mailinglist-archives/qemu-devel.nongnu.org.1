Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E74AD5E0B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Jun 2025 20:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPQ5n-0005WR-QK; Wed, 11 Jun 2025 14:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ5j-0005TY-GM
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ5i-0000ou-0b
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749666145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XGAORnKw9+R2umV6mLAlzBQ5YQugEr78XkvxlyiJjpE=;
 b=IL1KNPy+d/CX9IByHXD/Dk0ghneD4DB8MHWkso2M+mya/jKR+xW8vJB1ukG3U58kRnid8+
 0IZHYBpoKC0rndDfjYHl8t0c9+77J+sbrb1w4UrbGYswe0OjKmmGOdjV1Eclwx2ng4G59a
 Cm/0A4/h6HPKoAQYzDqdyOb3tWfCwWg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-YcdfGQFBNymMiwiaaFyKlw-1; Wed,
 11 Jun 2025 14:22:23 -0400
X-MC-Unique: YcdfGQFBNymMiwiaaFyKlw-1
X-Mimecast-MFC-AGG-ID: YcdfGQFBNymMiwiaaFyKlw_1749666142
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C05D61956048; Wed, 11 Jun 2025 18:22:22 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C63A19560A3; Wed, 11 Jun 2025 18:22:22 +0000 (UTC)
Date: Wed, 11 Jun 2025 14:22:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 00/24] Misc HW patches for 2025-06-10
Message-ID: <20250611182221.GA197888@fedora>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OxJsubdWRYqwU6iu"
Content-Disposition: inline
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--OxJsubdWRYqwU6iu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--OxJsubdWRYqwU6iu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhJyVwACgkQnKSrs4Gr
c8iARQf9G4RwLS3MSHfHc66Q/jASx6MNxG8xd4UYxojtMDNQ2m6KZR745mFs1bX9
cWqJIUrkG7T9tVHriDJXsotuCnw/qyCpXRibg5vGSorsnYiCMNBIaQieuxLeVcoW
s9h8haUaFwtK359lvaFVQx/BV2IMZRBemhUHDDKRZvrEf2ypwPn6Fk8Vy0XXvXeJ
niy8yrVfty97cgSLY3WV4JVSMfpgRNSQa8zGl+RAmKHzrL0f91VLWkCDEJAKQVca
ZwO7xn0QxAEBoPaQuSi8XU/wo6itSMBVyCwNsbADWXN5eD6D4LBr4+JvV6aPg9mX
1WqY9OlufbAo2DtC2fyb/SdFfd6O/Q==
=lB1F
-----END PGP SIGNATURE-----

--OxJsubdWRYqwU6iu--


