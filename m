Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AE4B120D0
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Jul 2025 17:26:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKIk-0007M8-Du; Fri, 25 Jul 2025 11:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ufKIR-0007Bl-TF
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ufKIQ-0005gq-CR
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753457117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ViVbcSheORgE9PAl0i5mg5svmGAaT+ItVIpeFxqaPL0=;
 b=AAjgk7unONuPd7fO+v8/UAsctcBm1bHFzeCFShFNSCc4qQDRaQfT9GdHyJXTIpJHuto8+M
 AapxhWJBCXIC53jyZa4nKdKr5RCvWzytT5ACqiVSw+JlKlVQP3K+l5XMyoBjP2pEN1CsDS
 yjfJ5qo6rnamZRGq7gwkEvxVYqkv4A4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-zjwZY4cHMR2wKKH2_X2w8w-1; Fri,
 25 Jul 2025 11:25:15 -0400
X-MC-Unique: zjwZY4cHMR2wKKH2_X2w8w-1
X-Mimecast-MFC-AGG-ID: zjwZY4cHMR2wKKH2_X2w8w_1753457114
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43D5E1800998; Fri, 25 Jul 2025 15:25:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.248])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEE423000199; Fri, 25 Jul 2025 15:25:11 +0000 (UTC)
Date: Fri, 25 Jul 2025 11:25:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/8] target-arm queue
Message-ID: <20250725152510.GA604029@fedora>
References: <20250725114158.3703254-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A5ogySAkYh4qm2w2"
Content-Disposition: inline
In-Reply-To: <20250725114158.3703254-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--A5ogySAkYh4qm2w2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--A5ogySAkYh4qm2w2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiDodYACgkQnKSrs4Gr
c8inqAgAkhHHKIo1fDrDF/SpRe2xpZ84Gh8ZUOLv2MPJaRSdDDIQ6GZKzQKCS53T
LUKExfvRkU5X6AMlqCDDHUY537dZnk5enDxATHqQNyn4FxSH8di4biGUcxv5RqID
VnX9R7Hu0N2tiS857I5yaJkyYnxQdeEHSP/OKev5KiNSKo4f6NvlgVUL2jxqgriK
Y3Qtb7Zui0NvK2xLLGGKfowLgIlKN3bmUcbO99FvoADocUQqFfZvgHCpSh0AQy+m
j6Kfb/MHtVTjf80rzTDTO8pfkCM47nWft8zSru8LT0m06sPBKGC8fCdDYf0zrvX8
OVR2A+nbMj6TRcS6yzCoMn4pwjIbZA==
=e60A
-----END PGP SIGNATURE-----

--A5ogySAkYh4qm2w2--


