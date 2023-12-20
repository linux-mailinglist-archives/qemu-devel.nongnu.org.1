Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4204481A3A2
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:04:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFz38-0002j4-08; Wed, 20 Dec 2023 11:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFz32-0002bJ-T6
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:03:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFz2z-00027A-JP
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703088228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fe3s6T2/MvCiXrq8NdYYAkYRMkD3KK2RZLyUdd9IIG4=;
 b=APeFAoDJ9wEa9k6FaeJtUfCu9ex5u6eQ6Ck+lwcfpEiwe3MBAxFX8Lr64U8PGBlriZbbTd
 7dr9w2PerHUeLX3JRjjqd9Cy0BNT/Gr2ccTZXDvOuI5elos6XqdZSzcdvZ4eyml2Wg2++F
 R7XHTTrCHvXj05+HYmZILBG2gMm1r6o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-l6PSfK2_NqGNhbHlIzKwLw-1; Wed, 20 Dec 2023 11:03:42 -0500
X-MC-Unique: l6PSfK2_NqGNhbHlIzKwLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF28C85A596;
 Wed, 20 Dec 2023 16:03:41 +0000 (UTC)
Received: from localhost (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 707EAC15A0C;
 Wed, 20 Dec 2023 16:03:41 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:03:40 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/43] target-arm queue
Message-ID: <20231220160340.GA843272@fedora>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HmLGxKkY+0rjB7K2"
Content-Disposition: inline
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--HmLGxKkY+0rjB7K2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--HmLGxKkY+0rjB7K2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWDEFsACgkQnKSrs4Gr
c8hssQgAx2+9+juImz3JfcOKNr1SDgqHDNkrAZsiHa3U7+k78SDvSa5fRnSzq3W4
joSbDf4UPvCR8jTDDxvpAMM5Z4z21AfkzxBH9TwCyStitsHQs9+3YM+Uby4cTWGQ
rAaolm4u7EvYelZNqBqZehEltAOwWJzkdyS9yJhHWDwLr1tc9s3aEnE1mofU3fFC
4yiCkyrsQKh5LkY/3TvYEoTlvxUaty0zllCOf17NWRCnFFZXplOAoJcKJpVWg8Ka
3lZOHT2vI5PCqEAOyNLY92DiQnZwb0Krb03YJkDf5/8ndjVdDYRh6TdH+UNbblku
hB6XNJe8iJ54OiP5eWRCcRQ5xgW2Xw==
=QmUF
-----END PGP SIGNATURE-----

--HmLGxKkY+0rjB7K2--


