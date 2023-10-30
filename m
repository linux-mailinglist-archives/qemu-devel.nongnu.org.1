Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AEC7DB319
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 07:10:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxLSs-0002F5-7B; Mon, 30 Oct 2023 02:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qxLSo-0002EA-LC
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 02:09:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qxLSn-0003yt-2B
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 02:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698646162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z1TEV0qVADYDKruUoeNUhD/kIaSSMmOFMfH3DBxM7NI=;
 b=P+T9mhuIq9LJD8OTbTc1AZ4i50jy4mq+sOX+xvfffk1xycKuy0aHQQxJLsU1FxBJzEJweM
 ZtLQ6jOwjiRDEfTjB52PaI9aWfMz6pcn1CLtWKGGBUtL4iQvXY0v5Ox4LkiA2ewMD7z+iD
 Ybao1uk5vEvPHOumOgWtVxO3Io1PGqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-xivd2ilGPBmPHD6o6BAEmQ-1; Mon, 30 Oct 2023 02:09:18 -0400
X-MC-Unique: xivd2ilGPBmPHD6o6BAEmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12386101A52D;
 Mon, 30 Oct 2023 06:09:18 +0000 (UTC)
Received: from localhost (unknown [10.39.192.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E22CF2166B26;
 Mon, 30 Oct 2023 06:09:16 +0000 (UTC)
Date: Mon, 30 Oct 2023 15:08:18 +0900
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Cain <bcain@quicinc.com>
Cc: qemu-devel@nongnu.org, bcain@quicinc.com, armbru@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
Subject: Re: [PULL 0/2] hex queue - GETPC() fixes, shadowing fixes
Message-ID: <20231030060818.GA619608@fedora>
References: <20231019021733.2258592-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nU6iDK3A+tMwsqQM"
Content-Disposition: inline
In-Reply-To: <20231019021733.2258592-1-bcain@quicinc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


--nU6iDK3A+tMwsqQM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--nU6iDK3A+tMwsqQM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmU/SFIACgkQnKSrs4Gr
c8hzEQgAiqSYD0RTYYlkp3s88JTlonplealOlluFGpI74O7W6E84fQaQPjrzGMmb
sOwdvWfUXsuz6D7vD6bmbSb0oCACpJOsfnSA7HCfM1LtpksvFkRM3IsVyaqIeHsq
D9M6KYaNwJBp+4LnVYuGBe9bgnXqvffnVaHPWhDQG6Wj2NUgaPYP1YFLIsXdCTiW
o4rHV+iQHPoqCev7H1Oq9Um/gK17IwnWzOr09K0QyqBfTwgC0cZUNH/RjQfCBkSF
84690ht8U+Yd3wy1k9ACJ1vn+6jFXx6raO3cFUMfZq6csxFcpES4gjiCtOc8BKdN
f6ZjQH8RuZVI29H49mvSMALjeR+14A==
=7poZ
-----END PGP SIGNATURE-----

--nU6iDK3A+tMwsqQM--


