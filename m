Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A8F76B836
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:04:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQqvG-0008N5-VD; Tue, 01 Aug 2023 11:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qQqvD-0008Mt-Ev
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:04:27 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qQqvB-0004qu-8B
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:04:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 50FE7320092C;
 Tue,  1 Aug 2023 11:04:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Tue, 01 Aug 2023 11:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1690902261; x=1690988661; bh=HZ
 Mo+fZkcSvCmmGKEwU186XsUyBsD/QtfboYsG7DWcQ=; b=q+de9Ur+V5Zh7M6/H0
 uBJDRogakmD1kHUZcRS6xlRXu9gmctpJxvYD8oq6KvGOEd+0wbjaUW+lzSo4VqWS
 FeZRiz27otCL5wFeF9Dsi0LRBzaq/omL2u6pPNtfMGrIqvrTZFLNNyRAkBgUqTIA
 euRF9i21E9jjk/ZPUy6Rn892MFMXLReZsGJBm5muFA+xRHk9xg+UWiMLntIRRn3A
 +eLbELMbZYez+fupH9BQoPO7Ka5xBQQ5phffMXrvFaix3cT6dsEl3nRIheICT/Du
 b23VKAzGJGhZPihp/F4hb4kD84v5wYuwgWWqbSXIW+wX/72MdzwFXP0+6H18OaPD
 1KgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1690902261; x=1690988661; bh=HZMo+fZkcSvCm
 mGKEwU186XsUyBsD/QtfboYsG7DWcQ=; b=b6NZOUEyJx2B0Lg6RS2elDseS6ymA
 5rDX56jjHlDGkBXckkLGOe7r1Ko8X8qmjuQv3nIRgE6UEJ3OWzFZGQSWoMcNz/Pj
 g834oGjT5MjFCb1otZhAB+i/kq9fvjBfDAXpUUzaB4fBSDDDv54BW45QhV1tkUZj
 1CEVAe4jQ8LJF85cjDYMYE7HCixb3L4fzCAHaOwYBTNXjY19FwOYEbdmKEitvi6n
 95JyaK+vaeplTu4uNGYD43LSjPOqmJ1P44RNGPMN2h4AmXnuqXA9PYXFQsjtFoxG
 klAztbq247brxuprrrU3Yqe+APqSYQncSuRjZPZ5JSb8KTfgKIewk2Wuw==
X-ME-Sender: <xms:9R7JZKIr9UFeb3hpso4qS3EcqPozFLHtFBCARYF6vfsQRrEOTwXGHA>
 <xme:9R7JZCI85VcG3D5lRYFypjiosYzR9hQ1SEcfA29RdMmROBdrE-yYA7kf2OeU-Jz41
 AqY5nONpi75NL3iwA>
X-ME-Received: <xmr:9R7JZKt-WUMYzP8RmHRAYEAb9fcJ2vRXUNbJH3N1XpDxjsv2l48Tpg9v04pB0q2xCvRkiT8m4exLER_iDF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdekudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufgjfhffkfggtgesghdtreertddttdenucfhrhhomheptehlhihsshgr
 ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepieduff
 euieelgfetgfdttddtkeekheekgfehkedufeevteegfeeiffetvdetueevnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrg
 drihhs
X-ME-Proxy: <xmx:9R7JZPb8b2k64gvxGVu8z1DCddetMi4BXKiukN4rrYgwvjX5IEX3Zw>
 <xmx:9R7JZBZ9_0RIZ0X5PX9Nas4yXHTCOdNZdo7km3qPKBTQFmQDqDFuOQ>
 <xmx:9R7JZLCiWNB6iJj8pssSlV-6iD36NmSKvhAJvVYcHs-TtGGayEmMwg>
 <xmx:9R7JZN4Sfg1kuOohNl0HOmuA2LrqhL_cbxTpvBEMYDc9Bqhvov4F1g>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Aug 2023 11:04:20 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id 7B91A7568; Tue,  1 Aug 2023 15:04:19 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com
Subject: Re: [PATCH v2 9/9] docs/system: add basic virtio-gpu documentation
In-Reply-To: <20230801011723.627-10-gurchetansingh@chromium.org>
References: <20230801011723.627-1-gurchetansingh@chromium.org>
 <20230801011723.627-10-gurchetansingh@chromium.org>
Date: Tue, 01 Aug 2023 15:04:18 +0000
Message-ID: <877cqeby8d.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=64.147.123.21; envelope-from=hi@alyssa.is;
 helo=wout5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

> +virtio-gpu rutabaga
> +-------------------
> +
> +virtio-gpu can also leverage `rutabaga_gfx`_ to provide `gfxstream`_ rendering
> +and `Wayland display passthrough`_.  With the gfxstream rendering mode, GLES
> +and Vulkan calls are forwarded directly to the host with minimal modification.
> +
> +The crosvm book provides directions on how to build a `gfxstream-enabled
> +rutabaga`_ and launch a `guest Wayland compositor`_.
> +
> +This device does require host blob support (``hostmem`` field below), but not
> +all capsets (``capset_names`` below) have to enabled when starting the device.

A more thorough description of what hostmem does, and how to determine
what value it should have, would be very welcome.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmTJHvIACgkQ+dvtSFmy
ccBd/hAApGNA9O4uF98z8Z2gtfNjMKgBgPdpbYZIjYCMtiXuL5N31Rai5xo43o4X
e7ZoMLHMwSQQ6wjptLUgYCHrXjuUS11L/Apdy34qVfEru5+UHmhSVAhOpI7ir25H
Ngrmfc1QVwzBIVHl6Q7hNdieEEwnF+dFe4uz6APdOVBwt1wKNEb2lANT8IO2d/NZ
kFce/483KpysXPKmMTsHyATOuv47zJDV6q1agZhsXcpf4gCqoA3YlP/DnkFaeEEM
9Xv1QDYi3wRnvXM8oiqdH7tVdRkLqWOxkKQRQf1djxFrmTKOQLBuLG2dNFVRNbjY
Uvt2xSrMqt1pdgMlQUcabgEQK4c66ptdzZrSoCXVPVaUL6uBrWUAqLCuQgZUrUtK
xgFfo48rm9/oCxzNG9tk+Nk0GFX8psj0wWmhVfbLITwqUmz3tw8NrWTKcjDvDRiX
OU76nps0pt05AY72txnuXFPuRVL5fThHL6en/+AHHhow3KA2yeMLFL3F9BU2XqkH
H2OEP5SYVBNRKenTYITcXS/Fpb7AURmr2MbPVaQ5Fdb4Rjl0XK0k44ZqNgl/2l3/
AXBk4jrkDeUaWo+Sd1H6C4zvLtUjxtxqMhUgGJlP9wjGgTfZcq17WJDwFOz6SR6A
HpLodiad+AlclX5K6LmB4BbEv9+JgXyMsFiDunhVFnoD6SPSOJc=
=SGZo
-----END PGP SIGNATURE-----
--=-=-=--

