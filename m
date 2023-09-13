Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4312A79E4A0
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:12:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgMpd-0006eF-QN; Wed, 13 Sep 2023 06:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qgMpb-0006e6-1l
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:10:47 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qgMpY-00073Q-HB
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:10:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 000C9320095E;
 Wed, 13 Sep 2023 06:10:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 13 Sep 2023 06:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; t=1694599840; x=1694686240; bh=Gm
 rUs2V3ALSzXB0WEfcXcNrZ61T1S1RjO6hj39jKAJk=; b=LIaJi/MEP0/M2frdwq
 l3yIewkyT/gaMoIsvYtOmu1FBhLJIOszeIT7FrnFgvs7YHhbOnYzrR2WJyJePYLb
 bzsJ1eprHDeTpQnYbgblSniGPF1a+CPJWfHzc43VU4dK26QamIoQB8LcLhSUlqmi
 4JSJROfg3+tgcdpfiQZQXmNYG2cbXbvtW9eE9R9DNlz2duFBwG6SYPKfikq9ekmP
 pLIkfY2ZPuoGhPw8OXWWD4qYBVPcIU5qS55+RSC3cYzWFcUK8MtD9TuR7JZ+Fd2H
 Gideis+xOa4XebnCqBCt36eXuP4vduhFHkF66viwvTIoY8keELFxkEnjoG2DEndC
 NJvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1694599840; x=1694686240; bh=GmrUs2V3ALSzX
 B0WEfcXcNrZ61T1S1RjO6hj39jKAJk=; b=TEPNWdYHImbS4KIJHtCrDSm00e4qp
 7SFh7ABRBQOtZj3IiE5x5SMOy4eox3DwL2cKODZU2BC/Ss9z1wNwOac8ZA/wQ9ew
 IAKeGoAMfTkeJkfARYgIPbj+vep68Tn67BrLpf7sDVpzNHEj9cRhgfZC0nl2KPdu
 iRtqNCIol4fbYtR4WISjZyDushyywdy1oRo8UUqLEUKij9b/TImMdyL1/euEoz2G
 2Px5i9ZOrjziJgbet8ZnqcC2nyvU3EfQPgEoUHTt47tfI0klMTyULsV9koPKHXjy
 PTXoKiu7yDXOtTxUijSx//R3uZhZJYzhiC/xCyYcmShWkiAfWmCN0TH7g==
X-ME-Sender: <xms:n4oBZX6pYHs4gypaEoNImZvHwbJuYzrjKt7mIiB71uu9CnBRKiw4mg>
 <xme:n4oBZc56jSxU-8Mlqmpo-bHAahNe6-_HITPkaM3v71vf2wxkNlupVrYhNvNn21ce2
 xK491ysaKSVYXoANw>
X-ME-Received: <xmr:n4oBZee12uW_8F_pS-HKPuF4IzRPOHGNlEPlEdZTP_ZcH2ZWqKxDYRwqdiojL0H1WulTpSu_XrleS-ReKuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgvdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhs
 rgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeethe
 evudfgjefghefhieejudelkeeljeegvdekueeuhffhgedvveefteevgeetieenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihssh
 grrdhish
X-ME-Proxy: <xmx:n4oBZYJpZKW06ZBtsfjCgzCmewA2d7sP-ZOHtQKL3rkXptCtwi3Prw>
 <xmx:n4oBZbJ8p978MjUduOfbH5U8ocrws7WYMaVEbciDx4u6_jljMta84A>
 <xmx:n4oBZRygVhiOP2TLi4_zuX7n-y84PZrOyT2HyS9PJGX4Tzv1jIwXaA>
 <xmx:oIoBZS_mTlYnTLlESL575R1axxIezru-64b1oY8rE6iL6GgIdKCNoA>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Sep 2023 06:10:39 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id 489BC8604; Wed, 13 Sep 2023 10:10:36 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 philmd@linaro.org
Subject: Re: [PATCH v11 0/9] rutabaga_gfx + gfxstream
In-Reply-To: <CAAfnVB=NEMnW4YKV1aqg98aSW-av8vWWF2W3Wqpqt7Y5hKxhKg@mail.gmail.com>
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <87a5uiyq35.fsf@alyssa.is>
 <CAAfnVB=qW99pYK04g6ZdM+c8HLLmE5kwc_UWyJgRVSPnGB84=g@mail.gmail.com>
 <871qfriok0.fsf@alyssa.is>
 <CAAfnVBmxE4ThprAFuEj2khoX9LqxuVe02K7B-ps4g0r77vqmyg@mail.gmail.com>
 <87v8d2hqdu.fsf@alyssa.is> <87sf86hq0x.fsf@alyssa.is>
 <CAAfnVBno8-Ue_4L=yRxM6woDRQ0_QDorhOvvpFfMV4S=5PutrQ@mail.gmail.com>
 <87jzsvrcvu.fsf@alyssa.is>
 <CAAfnVB=NEMnW4YKV1aqg98aSW-av8vWWF2W3Wqpqt7Y5hKxhKg@mail.gmail.com>
Date: Wed, 13 Sep 2023 10:10:34 +0000
Message-ID: <87h6nyqt7p.fsf@alyssa.is>
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
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gurchetan Singh <gurchetansingh@chromium.org> writes:

> It's harder to get the attention of the Android build team than the Chrome
> build team.  Though, there are a few issues with AEMU/gfxstream packaging
> we also need to figure out -- see "[PATCH v13 0/9] rutabaga_gfx +
> gfxstream" for details -- interested in your opinion on the matter!

None of the other points there are issues for me =E2=80=94 in Nixpkgs, every
package is installed to a unique prefix (different versions of the same
package, or even just different build recipes for the same version, or
different dependencies result in different prefixes), so library
versioning and the /usr/include directories are not blockers.  Static
libraries are also fine for Nixpkgs =E2=80=94 any change to a library, stat=
ic or
dynamic, causes all dependents to be rebuild against the new library, so
the only real disadvantage to static libraries is the duplication on
disk, which isn't a big deal.

All that's to say, I'm ready to have rutabaga support, including
gfxstream, in our QEMU package, as soon as a release of QEMU including
it is made.  Everything Marc-Andr=C3=A9 has identified would still be nice =
to
have fixed, but for us specifically, none of it is a blocker, even the
tags I asked for.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmUBipoACgkQ+dvtSFmy
ccAy/hAAnH+VIGL1tI/spwEcHSNF+5Q1mss9G4m6qMB5Ktb6iE5/PtSPDfORkHST
8QJZPmPNbh9ZIGaXnirEHfUymMRNZMN8FD7J3xLef+CJpLaAEXKpTQL5DS6PxQw3
0pgB91oAzun9T5FYEvIDJhCgrdptT9Nw+ExtqR/k8o2qBM8kqriCQsvyTCJ1PTLG
/sbH0cO4f33wBSrKJ+283nPKMNbcjpmQwMKXD/sF2QVnkGgebBYiDPrLSZbijqbG
g7Uf+eDnB2fwLUkkypbyUiLK+iuAKoQ5ID2192KbVU2HOmSOJGlHu3GmrHNEZYLr
l7qKjdbNQ8T7AJN3GyrFDXWz04JpXdZfq12lfgu9j0TWX0C+ysiEEHPTHUsnT8on
bZi6fSNMFQccP+eMsA5TKIcEm9/azZ+CdL4dZhirWzSK31Y8MWP3qUjAGM1ptSh4
CCP9wD5XZNGjnDqrz3ovbK9xYExG0wy/mM5qSp8JfIDnbUopE9PIkqZpyG6TS8SS
2djZaSjuikjzMDbW2FBO5ZICtdeJG5Gut8Z1HZxpIzYKWmBpFoPKSMWmbdQclKAa
iZ0QMyc/1M9/IoUNEELesksx97a1GKidqorh55o6WKFXcd9O8Dqxl5AC8nTL7X2n
8ZcBVacEc9f3Pejr+eUcbii412lbjmXzpTLHfGnl62UQl416xKs=
=Gaip
-----END PGP SIGNATURE-----
--=-=-=--

