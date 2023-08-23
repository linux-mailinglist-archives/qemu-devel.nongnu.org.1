Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7643178566C
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 13:08:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYli8-0002Ot-0P; Wed, 23 Aug 2023 07:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qYli4-0002Of-KK
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:07:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qYli2-0002IE-8D
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:07:36 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id E5BFC5C019A;
 Wed, 23 Aug 2023 07:07:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 23 Aug 2023 07:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1692788850; x=1692875250; bh=Yi
 NfpJ7Pfr9DtgxCnfY26Pa0Rw9qklJPF4j6MXhHIR4=; b=AxNepES5+bIp+R+Z64
 lCTWp11JMDGEzPekvPtfRNgamCsGiq77bNz4vR7Y40HQ5wE8kO8Pwfj4cAPBuPRS
 vrix95NYHoRKabfL6icbT7kG+Jp8hh0g0B4iVPVR5JNBhhMC1y8vYc1zoF0tWH+y
 KjRrwC4xPCZHWXH0oVyM03lX+w586ebIViTQPCbgPjboyyWNhz7yj5pixABvaZKl
 csx2yN6d55DBrQtyibVRjTnQa2U0LSFFBtazQQJS2yvs4xBivifDcAcbifJfTjjM
 igidcQ1tjFHw8tsc6il7jsG6rRpNnQem2mS1LO7ZMhdP+GO/LTN11U1IVk4FNDaO
 Dnxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1692788850; x=1692875250; bh=YiNfpJ7Pfr9Dt
 gxCnfY26Pa0Rw9qklJPF4j6MXhHIR4=; b=foiWlLugTh2nyIN7f0HlS2dW4EFM6
 iHD1oYHVhrBDhUWtvNblWKEb7+v85lYtNOc99x259BjGWGTqyI79EVZMxsRSwIJj
 BauOjDk413BwXo4B3jSDrxjpQfdR/LMsOBofHHTllikvu+b8ymZ13+OKxfGsllfx
 BW7QhnuaxWSZw4WGpOp8j8FpiJyW29S5ROwLiE1mmXRPhqmWocU7thmSQQVuFU2S
 vakfodFN2oczKICohk1U32zXx6RL/yIIwmyU7q+fRDYrmVidQrnqfVJCtBUl4XsA
 BpQi00ODsiZI9uNR5shWprF1cV/4mdbuN8g8WjFPya3HmuEbxy5DjUyhg==
X-ME-Sender: <xms:cujlZLNK_DeF5EFZEng_H7xx_OoRFWNw3QsP0xei3wYqkn8GUL3eYg>
 <xme:cujlZF-8guC507qvcCF-wYw42fVNMESSlbzeh052do9uT0a-XKK3nl6nLHdVmLBZ0
 aWJoPdekQ7_OusJZg>
X-ME-Received: <xmr:cujlZKTm2w1gDptQiP9mOyxWlJSPB8g7DVgEs7OPHgOqRCYCs6FlX4xwrHCxEqWa9D439Br6V6r6azwELMs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgfeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefujghffffkgggtsehgtderredttddtnecuhfhrohhmpeetlhihshhs
 rgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpefgtd
 egieeiffeiieelueekveejvdeviefgveegvedvgeehtddvffejjeeuudduhfenucffohhm
 rghinheptghrrhgvvhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:cujlZPv365OEGacopHpTipO8UkLFFCfdm2Gdo6aFqBeXw5_Gb2-0BQ>
 <xmx:cujlZDfc630LgSvWj75pdBC5yK3x9C96g7HRELs-B9wltNsNx9Fnpg>
 <xmx:cujlZL3J4LrzBk089KgiZs-3H_uDyjCkKbMs_0Dh77c9kmKjt-Ou2A>
 <xmx:cujlZCzAoXbu8iZ2eadvEqZfH4NORvV397Mo4DoRDvIeXWzfRWLuTw>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 07:07:30 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id 3B2947FE0; Wed, 23 Aug 2023 11:07:28 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, ernunes@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org
Subject: Re: [PATCH v11 0/9] rutabaga_gfx + gfxstream
In-Reply-To: <20230823012541.485-1-gurchetansingh@chromium.org>
References: <20230823012541.485-1-gurchetansingh@chromium.org>
Date: Wed, 23 Aug 2023 11:07:26 +0000
Message-ID: <87a5uiyq35.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=66.111.4.25; envelope-from=hi@alyssa.is;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--=-=-=
Content-Type: text/plain

Gurchetan Singh <gurchetansingh@chromium.org> writes:

> - Official "release commits" issued for rutabaga_gfx_ffi,
>   gfxstream, aemu-base.  For example, see crrev.com/c/4778941
>
> - The release commits can make packaging easier, though once
>   again all known users will likely just build from sources
>   anyways

It's a small thing, but could there be actual tags, rather than just
blessed commits?  It'd just make them easier to find, and save a bit of
time in review for packages.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmTl6G4ACgkQ+dvtSFmy
ccCUjg//UHB0zYcsuEal1otdQpRSmkfcOniBdSM+pvnMUFEfTf2t6obmc8n5HV1a
Y+kuMvHz7G6+QApL6+4FjUrrrdpZ1vjqT15gxqSZRuubUcbq8RV/4QfFCK3FaVFK
GkDke9OWKQWYEZi2sqmD/av8AMN2poP7ga9husznP9S8ASwOEbl27pArouNTNt03
A6i5PZ1pbAqgePRD7ixJqrmR1XaVY/SWF7zzmzBoIz8dEeCNmkFcLpRUCmZCmIZw
MSwWsQj7u0sDSW7ZnJjZaQStkWX0/zFYxmtmfDEL+iaxUkSqNBMomp573mOv7uCu
luZmXkNrCpeFwhnYQt6ggh0TDvEkP32SSakceohgD6yhn9oAX9BOvvdjFPXf1j5Z
I0XcpChml80pOO8eDen7FR5HDNcEEIMF1po7+e+PMJD1C5lDfwAgUjTw80TGXkNa
wJr0cfbnbt6F6tH1DgXdohKtYvsfMFXI0yR7seB19DxZ3hHn3gtbkgeS+gRbIJNe
DMr/EGJe/tofS4pNmJ3mJCDpLQn8cMAwPIbiAcSY7mir0bUQdQJn83Ce49ehbXSj
wLUx7/ckKgiWc3yNhU6/Fy92srNWNlCewDHPDgHi0b5jMn2zmMzSFyIuLMog5YNq
eJtsbxX/KERGK3PKzwOmlKLHWHbDgiEfEVOksLUvEPPK4fle3Lg=
=S7mW
-----END PGP SIGNATURE-----
--=-=-=--

