Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0337B0D33
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 22:15:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlav2-0006Bn-8L; Wed, 27 Sep 2023 16:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlauv-0006Be-AP
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 16:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlaut-00039q-UJ
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 16:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695845630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1dhuSgthUpKlH1AhJGRn+SXDLn5dNRpfYnSJPL6xfiM=;
 b=IHRjrw64nCC3xV1PQ1AY0rnHZ3zdIQKbIjwesaHvtP8gKZmryP5P3znIbFPM5GuDpKSOzi
 rZMji/9aVmyhIKfsGUdCHr3CCQQFnjJQdwbDAWlJtE2/JeuU0ZksDxB3c9TzrMi3AGtebm
 lKrbM7ZfPt3lHMkx4Yja9rnSw3i2T3U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-1SZGHgpXNgKeclgHl5l54A-1; Wed, 27 Sep 2023 16:13:48 -0400
X-MC-Unique: 1SZGHgpXNgKeclgHl5l54A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B0821C06532
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 20:13:48 +0000 (UTC)
Received: from localhost (unknown [10.39.193.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1367BC15BB8;
 Wed, 27 Sep 2023 20:13:47 +0000 (UTC)
Date: Wed, 27 Sep 2023 16:13:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/19] Misc patches for 2023-09-26
Message-ID: <20230927201346.GA532486@fedora>
References: <20230926165915.738719-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OBqZDsH/Nd8X7gEJ"
Content-Disposition: inline
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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


--OBqZDsH/Nd8X7gEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--OBqZDsH/Nd8X7gEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUUjPoACgkQnKSrs4Gr
c8jYKAgAkNal1Gh63O5d8xNR+P7Raie7x0620rEmWaXTwFOcgsdlnzsZ4veuujpW
ngXgSSMG2gT1i6O63HWhYCmUs0OqrxR6/dIyTQsEF7WR4xU1LJbti/7mgbWNZpyy
PqCJePn8v6d6dinQi24IiurHOTMUKGrEqxZM/2nOtXMePSPlUa307FO0cqQUIR7G
6ULIDQ/FCxZiBjLfADPxHqJgzclBuEv9tpyxJj7nlQOnzijuZ/ZZvH28ev089KtZ
SCchYDZfGPojZADHvjq4w0gIvag/G7Ghv1Q488Rce3YDzBmejn71j2hXmYs3Jhte
mQN7T1gucWAl26HyxZwnGEIQkGVLXA==
=Egd7
-----END PGP SIGNATURE-----

--OBqZDsH/Nd8X7gEJ--


