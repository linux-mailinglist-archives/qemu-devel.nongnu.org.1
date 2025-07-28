Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C634B13E24
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Jul 2025 17:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugPem-00082A-EH; Mon, 28 Jul 2025 11:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ugPeN-0006ku-Nr
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ugPeL-0008NT-Nc
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753716024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Ly3JuTypXdYvOG4q8fHlUtoukI7z0h333GZyFS5XGA=;
 b=RF9BkUkuwor0BCGcQPnbUVUY/Pk4NplGS+vxFfu9u0iZie8SSuzIZIdCpzxP09OpuMiSHv
 6MCnpgZDv4TJQfZQxrspNvu9FDSzkYPl0JGktvttgesT6HNUQe5vJn1Xe9Ciu1fQ2wNP+b
 ZXzQxNlxUxo9InXV36GlTNUWRhohvPE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-_FYBwGuRPteFMffxtYFElA-1; Mon,
 28 Jul 2025 11:20:20 -0400
X-MC-Unique: _FYBwGuRPteFMffxtYFElA-1
X-Mimecast-MFC-AGG-ID: _FYBwGuRPteFMffxtYFElA_1753716020
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD33019560AD; Mon, 28 Jul 2025 15:20:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.147])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9188D30078C2; Mon, 28 Jul 2025 15:20:19 +0000 (UTC)
Date: Mon, 28 Jul 2025 11:20:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL for 10.1-rc1 00/14] documentation an testing updates
Message-ID: <20250728152018.GA71308@fedora>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="koueyOE10lcXtRWi"
Content-Disposition: inline
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--koueyOE10lcXtRWi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--koueyOE10lcXtRWi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiHlTIACgkQnKSrs4Gr
c8j5cAf/cnelzLeUVIAMl6h8pqD23p/bJyU08bZjcGuYsx2iCWr1LQTYvRgpfHnr
MfX6874FgBh0HESSlPHW33JQqwRJe11NmLZlYYO+d+IV+Uda2D54cZsO0x5N+YQU
0VyTp/hPFBy4oW54v2IQ78Y9K65MRx132Mfh+MEsydiEy1XjfvCA4l4ArBnon6bE
MWzTgK5dZY4afkzwUfp5zhTJjcSYS5p9cdxWVtMMOracakqVjgzl770IlzsnGhLg
ph34DudB0XaPG3nl3GAwp2NmraRKm+5c4sFDa1xMnQXXtlEI2Vm6N/eJ/0cLKocq
B6aRTUe+434UIuLRz8BjlPhssxuN6A==
=vNJC
-----END PGP SIGNATURE-----

--koueyOE10lcXtRWi--


