Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 509427C5A46
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 19:34:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqd4T-0007XK-OY; Wed, 11 Oct 2023 13:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qqd4R-0007X0-7U
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 13:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qqd4P-00011k-QJ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 13:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697045549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2JkAbUMvVKfICpU7LQDL/BWD3p23LjZBtsOGW9Y6fX0=;
 b=UdMhZYZemnf3tPo9sIvhoj/UsbcPh6lJTwsc0v78M3FO6bcK34TOwzVguHuwn8W+OCy6jP
 kzI/lRHpDhUKie520MmyUh3/IiaAqtpBGesNOp1mwySM1/o2IaVY5BAVIkrlVW80q/Fhgk
 FsL9gHKImY4Cx1cRbIq3YsbjvFjY9CE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-IQpOVs-lNUiifMB7mUOCaw-1; Wed, 11 Oct 2023 13:32:27 -0400
X-MC-Unique: IQpOVs-lNUiifMB7mUOCaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42AE0805B29;
 Wed, 11 Oct 2023 17:32:27 +0000 (UTC)
Received: from localhost (unknown [10.39.192.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE17740C6F79;
 Wed, 11 Oct 2023 17:32:26 +0000 (UTC)
Date: Wed, 11 Oct 2023 13:04:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 00/25] testing, gdbstub and plugin updates
Message-ID: <20231011170440.GA13501@fedora>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UokwNB/JDn8irH3D"
Content-Disposition: inline
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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


--UokwNB/JDn8irH3D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--UokwNB/JDn8irH3D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUm1agACgkQnKSrs4Gr
c8j/FAgAkneoHoW4egHmYwkQBTlTNgdX6CNkY3kHbKA+mxKKTV9DhCFZyRpLmFDd
eHkMrtGY9k1A/fCbCUdGcHJijaDsT0rZXzgEJ2Uq+molIDEieW98FMRXz90Axk40
o+63BZJYMZ2HtdCwZvtrQMyOMcXdRYd/H4UnxOzQoY4kQLG/tfzNTeAL+9/C67Xc
jkloicDDOhHQgOWussQkMwhXXMpCla9XxgRb32EYZmP6MtjX3K6RsHqU7ZyEgMDa
XOG5h6n8NBpykN2xWwIvD4ucQLwO9aQe5mWNaeh4pHJSASnmYKmbPNLw9uKTNVK2
DeHpoIAvjcHrZfSl31gNLYaKcYzhdA==
=cu2j
-----END PGP SIGNATURE-----

--UokwNB/JDn8irH3D--


