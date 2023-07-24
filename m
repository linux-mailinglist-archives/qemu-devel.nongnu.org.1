Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D07975F165
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 11:57:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsIs-0003kN-D1; Mon, 24 Jul 2023 05:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qNsIp-0003k9-VL
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 05:56:32 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qNsIl-0006Ds-J1
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 05:56:31 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 288D85C013E;
 Mon, 24 Jul 2023 05:56:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Mon, 24 Jul 2023 05:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1690192583; x=1690278983; bh=C6
 tbieNaqX+GmA3b7FzikGfucZdDTiIhMSjlPzGjtoo=; b=IcTmcB6yGyGh0Tep/D
 ETCjWb6MprIBqVHyWtkuff/q/iIbeWAW4qyoA55Bms6eFnOu2DLRYpDyspl6T54G
 h4n3zyOL7vY8C4DAaL/0onsrap6cDGGyJbf14EbrKdvS0sRtLE9Z7/RGfgtiHZyk
 BST4TNLyQjiFVQGKcSI5/aPIO7KOR2ugVH4ZZkIbpRIH6iZyPn3LO1B50CZUkvUX
 Apjtj2VTqHvk2jLA4DhuwZSER7Uq/w6eQUoMSph73i4/LmwE/ojVqy761UnAk4Qd
 NFfDlyjv7a4XZjmp7Bhf6EhAFWlQrHgoALDdxm3BR5wh6IkNqenmN2EIGGtUbRg8
 EuFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1690192583; x=1690278983; bh=C6tbieNaqX+Gm
 A3b7FzikGfucZdDTiIhMSjlPzGjtoo=; b=Wyj5Jaja19EUN8fz99P+PJzg87Tvt
 lvNN7ko6yBun/il25sEOEtWlb8tfgPGojI5k3ELYLnmrjs/E/LoERBwogS+n7suy
 39Ju+dtnyUeWexmUifCIPmd9+dTZi4wLcvz8kmadhxrnslGNGyuP5TwecLSi20gw
 hT9WUX0DX+zD28ng+0D9n0dq+SDuY9BEkyTkL1HdomKNW5g5ZoPuadb4dZc4TyJV
 KTv2uRRp12Ht3kgy6fyQd3MJGTlevyjoprVuESq2bfVYpM4oGYdkOtpuoMeblXos
 HO7pheTX0eNltlEXvoTi9JUS2qGqTnZEaeVmbSBCRGqswhuD3Ho+HKtOA==
X-ME-Sender: <xms:xkq-ZJycMzb1ffnAQ-WrjB_nYiBMJ5lFqHtam5CmsmbEvvixINlxfw>
 <xme:xkq-ZJTyc2Lu63d3YPWM-9kTPvDoryUY72a3ygmG_iconkbQzTAowD5eD36Y1Ojjh
 6EhMy9Qr2Sl0T6nZA>
X-ME-Received: <xmr:xkq-ZDWZHwfklyheudVQHH6koC8NAigU0Birod1l_shTIgOVNr7hDjzF9GmICituZ4fmYmcUH8iiXZijyq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheekgddvudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufgjfhffkfggtgesghdtreertddttdenucfhrhhomheptehlhihsshgr
 ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepieduff
 euieelgfetgfdttddtkeekheekgfehkedufeevteegfeeiffetvdetueevnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrg
 drihhs
X-ME-Proxy: <xmx:xkq-ZLhF2eOBewH036tswPRxuJUKeMGDkdNuRuvVvi2fUw0mY2etXw>
 <xmx:xkq-ZLDDCUqc5kGzDjBebE1vEwRaCrj5InXnsGO1Cstu2-C9TO-aSQ>
 <xmx:xkq-ZEIOH9Op0oQUA2zAUrT8HXt3MeXAKSRv7huEUEbPnrrK31epeg>
 <xmx:x0q-ZNBJz0SCOcNJGmJzMfb6Yn6loi34gJmII4fCmSc3OZDL_H43HQ>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jul 2023 05:56:22 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id 13AB373A8; Mon, 24 Jul 2023 09:56:19 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com
Subject: Re: [PATCH v1 0/9] gfxstream + rutabaga_gfx
In-Reply-To: <20230711025649.708-1-gurchetansingh@chromium.org>
References: <20230711025649.708-1-gurchetansingh@chromium.org>
Date: Mon, 24 Jul 2023 09:56:10 +0000
Message-ID: <87351diqf9.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=66.111.4.27; envelope-from=hi@alyssa.is;
 helo=out3-smtp.messagingengine.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

--=-=-=
Content-Type: text/plain

Gurchetan Singh <gurchetansingh@chromium.org> writes:

> In terms of API stability/versioning/packaging, once this series is
> reviewed, the plan is to cut a "gfxstream upstream release branch".  We
> will have the same API guarantees as any other QEMU project then, i.e no
> breaking API changes for 5 years.

What about Rutabaga?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmS+SrsACgkQ+dvtSFmy
ccA4JxAAhJUz0WNKqt7QJVkv5WJYHQBn9kxO148tiLHV/wEIXjGWJnGzKqEDFq5D
UZjCsfm65YzUJ3ZqLHPbGj6IdZ1su5bOWv4JOyZAtjP++M9L3Fq06dE4RndWwzt+
Mseqrtt7ighJUF/Z+TGxJMlWuenOrWOrnUKRVWzH6VquXoNwWUZqmiOVKKLWGNaS
PrCbtW32NydCLfs04OKb0D5C0lnvYIQ/IKrfKkTEkIqDM/B1aiqsUG3rLnWmdBzC
Nj4DtThsxGLVuJPIL3j+LbGl0muN8pz/kTUOYoyKU5Rzc9Lmf4HMTzyf3j7OC1Bf
lEfZ/RW3X8kXY3ZDwAc/+9v1ahJPftX2Ta4S9puiGopBsMgYql+yzczA4XnX70Y4
GewbkNaaW2kCFgkgMXuGr/m332YLBh4t8ZRf0u4K0RvJ6U9rrF1MwzOKTNn/Vv/J
A8du2Dj2NOIf0f3KE4HGS7GVxkV5gmkINhSwAv+rY0uYdXwYw+VsdOL9NhmoKd9b
ltA6GYphAgkgm0bA+q7Av7x/bH54LLV9mYnqGhDjU3FDbIX9nY7FBwqWNX86U2xj
hsS8qXz/QYDrSCA6C4KL7csbbRZgnVgGmih+eUchOIPgFLkzwZG4MF2GzNX3Tszt
+ACBcebpRerKVM8HjN+SOHhc9Gaxu4+kylAbeDcnr96+MrbCtV0=
=252h
-----END PGP SIGNATURE-----
--=-=-=--

