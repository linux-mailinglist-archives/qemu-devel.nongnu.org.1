Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB11B1529F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Jul 2025 20:23:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugoyL-0000yW-91; Tue, 29 Jul 2025 14:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ugng9-0002BC-6W
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ugng7-0006nk-Db
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753808390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FbMTF0l3mvrk/PSj+fIvrkUAMJApNRpeXdKZYYIJpZY=;
 b=b3Dby5B96LhhkrA+O1s6B6Xra4Ss96SDyUlnFz7KmoHr6nd24szTvjPxPG6x/Tve2t5E1K
 xkleLwbmFt4K3PKClkxjh1KunxHnaqKJIXLFOsqDgdC8X9k8cZZyn84YryUSuu1gYSQ6oi
 VbjJLL6RXwPLvriG84tSr/Rz+EJI0bQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-26I6MbFhMmCl4yB6_xyjTg-1; Tue,
 29 Jul 2025 12:59:48 -0400
X-MC-Unique: 26I6MbFhMmCl4yB6_xyjTg-1
X-Mimecast-MFC-AGG-ID: 26I6MbFhMmCl4yB6_xyjTg_1753808387
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90A7719560B1; Tue, 29 Jul 2025 16:59:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.185])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1338F1800287; Tue, 29 Jul 2025 16:59:46 +0000 (UTC)
Date: Tue, 29 Jul 2025 12:59:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 0/9] Misc HW patches for 2025-07-29
Message-ID: <20250729165945.GA21655@fedora>
References: <20250729115735.33619-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="taoawv/+tYsWErLF"
Content-Disposition: inline
In-Reply-To: <20250729115735.33619-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--taoawv/+tYsWErLF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--taoawv/+tYsWErLF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiI/gEACgkQnKSrs4Gr
c8h5/gf+Pb0c15g6YGbLaFmNJxN2oBgbGBdMtry5PzYAW/lz3SjCRIFg//p0o58N
ADRq5cu8mxfXqV1nIGwqZlMqaT9gkgHuEprYh+XLx0KkMO3C2C2ZzCdcyLyp02uT
02YukPuJs6zAkWfhhCZ+8JobD0FPtseqFWw6KcSDSfGBUAuXnDY5UTeKRuEcFfjV
dQnXgDvBhHLD/O2uDWrTCGgWN5ex7ZHkD5bwk7QWOULmUqI6PAwFQJB6bhq9PdCj
Dkjr2PI/RWj13nUQG5/BpnXjedCY/PYS87GNzlV9fR8dsAHLptu/8kUyblyMDWEj
vJf+1ZqTWtR9e4xDjNG/1lLZxx+oNg==
=/lf4
-----END PGP SIGNATURE-----

--taoawv/+tYsWErLF--


