Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D0770EE3
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 10:49:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSCwa-00016T-SP; Sat, 05 Aug 2023 04:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qSCwY-000160-Du
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 04:47:26 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qSCwW-0006Pe-D5
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 04:47:26 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 047B45C010D;
 Sat,  5 Aug 2023 04:47:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sat, 05 Aug 2023 04:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1691225240; x=1691311640; bh=zz
 zDeDARo77CdBxknQ7srZjXSSd7cHcjCpXL9ov1ugo=; b=HbgE6kzDqpR/S+3EAM
 XesV5z16FPPSfMHPPCvh/JcLDrcjVmV2CRTpEnKHylAaXywRJbuC1Thv+lYj8Tad
 bBZM4UgFnH0q8UqwIPiM8rKZlTyFTR//KmklLs6UHGrUbU+Pd6V1NvJvFnUroVlu
 JjqPOT+cjivBXjWQjrRxO3eY+0VH4EnSWusUm5bjiRs2Qz/I3buPA+f6wSE4mw1V
 Oz+bTSY0ym3RtmT4U1vfvG6WYDWM++4w9nHAZ87Dh9AlDnNnbk9xnlx3L/xsISuj
 R5RRcbBlU39A96KAneb9qSvEZ5iJg6Arn33F1ecy+IckAPdc3FTWzukgJ3Lvrd8M
 neng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1691225240; x=1691311640; bh=zzzDeDARo77Cd
 BxknQ7srZjXSSd7cHcjCpXL9ov1ugo=; b=Mhy5Tt3j5gc3MlzytNaNZKyzmdiHS
 gp6G2vNChZ26TVMS76Rk7rsap1+e8XFXxxTGfITg9vkw5sGSx09lzPK2amN8BpVW
 kLc1J1Z8BDGWJnDBVrINxfJxPAoYWHpP97ZN2KvT4e7IkAeN8Iic79rd7CRq7LNd
 MP69VGA3Z3t/JYfhqdSUYptlwBG+It9IjlDhe4Fs6VflaM8/D5FZENLXFP8pilaB
 wYlMK644diYwGPPf3tK3ny9GotMxy+lhtb4LWo0u+ztJx5+nq2+A9QBKPWua8TAw
 UWzRloCbOE2vGdz1VfMAeSe7ZhADdE534f7XuV5ut/BelPI6m5rXAoTnw==
X-ME-Sender: <xms:mAzOZBVhjuPwNOFIF6jzQfic7NJwG2tpncsRU1ijQs4of9FAYoHwIw>
 <xme:mAzOZBlQKszNbuPsxd6wRhruNWY3LlflMhYP0IEsmHiNma09FB9UJLvrTSLvsRF7u
 qDsIDAhpOviGE8Lyg>
X-ME-Received: <xmr:mAzOZNboZm4YfSBCGoTuwvBaW0QoVLzeiDqliyQHHBkdmHcHd2ny7V9m1dbQeIPIe3eBvu1JxXSQKy80epk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeeigddtjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufgjfhffkfggtgesghdtreertddtjeenucfhrhhomheptehlhihsshgr
 ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepleeihf
 dvgeetveevgfffkeefjeehueekvdekieevgfdvgefhtedutdduudehkeejnecuffhomhgr
 ihhnpegtrhhrvghvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:mAzOZEXTLPU3EUH5WqpleqTBu_63e_VV5aWLEo-qbFUAIN7lKBTqoA>
 <xmx:mAzOZLm2xX_nN2axwZNF0gLNxWPoabZJipRbiFVPMKrgNOfLNFLWVw>
 <xmx:mAzOZBefy2oq7LcB_pzfzC7IzxOEIfp1UpH9GdAPjLY_nwIjYht75A>
 <xmx:mAzOZN6ymc7bq2b52p-SUSrAdYBFsoQo_GkEbe9zH_YTcqxiJwNQVw>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Aug 2023 04:47:20 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id CE2D87634; Sat,  5 Aug 2023 08:47:17 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, dmitry.osipenko@collabora.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, crosvm-dev@chromium.org
Subject: Re: Rutabaga backwards compatibility
In-Reply-To: <CAAfnVBkLuNeDkgGz2DNvv4iG5oKn6DxP=3s07pVz=9gR+ZK+ug@mail.gmail.com>
References: <20230711025649.708-1-gurchetansingh@chromium.org>
 <87351diqf9.fsf@alyssa.is>
 <CAAfnVBkm6yjR8HVWgpCCQkzpQ53unBCTP4Ngk=Z8QeEZ-7MbMw@mail.gmail.com>
 <87zg3aaj04.fsf@alyssa.is>
 <CAAfnVBkLuNeDkgGz2DNvv4iG5oKn6DxP=3s07pVz=9gR+ZK+ug@mail.gmail.com>
Date: Sat, 05 Aug 2023 08:47:06 +0000
Message-ID: <87zg35j2ph.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=66.111.4.28; envelope-from=hi@alyssa.is;
 helo=out4-smtp.messagingengine.com
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gurchetan Singh <gurchetansingh@chromium.org> writes:

> On Tue, Aug 1, 2023 at 8:18=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
>> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>>
>> > On Mon, Jul 24, 2023 at 2:56=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wro=
te:
>> >>
>> >> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>> >>
>> >> > In terms of API stability/versioning/packaging, once this series is
>> >> > reviewed, the plan is to cut a "gfxstream upstream release branch".=
  We
>> >> > will have the same API guarantees as any other QEMU project then, i=
.e no
>> >> > breaking API changes for 5 years.
>> >>
>> >> What about Rutabaga?
>> >
>> > Yes, rutabaga + gfxstream will both be versioned and maintain API
>> > backwards compatibility in line with QEMU guidelines.
>>
>> In that case, I should draw your attention to
>> <https://crrev.com/c/4584252>, which I've just realised while testing v2
>> of your series here breaks the build of the rutabaga ffi, and which will
>> require the addition of a "prot" field to struct rutabaga_handle (a
>> breaking change).  I'll push a new version of that CL to fix rutabaga
>> ffi in the next few days.
>
> Sorry, I didn't see this until now.  At first glance, do we need to modify
> the rutabaga_handle?  Can't we do fcntl(.., GET_FL) to get the access fla=
gs
> when needed?

That was my original approach[1], but it was difficult to make work on
Windows and not popular.

[1]: https://crrev.com/c/4543310

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmTODIoACgkQ+dvtSFmy
ccAjGw/+M4ZDsk8hcT3Bv8c0ElWEJ71Sn232eXMid5X+IS3LSIJVETMTjBlxBw1v
iuSJTyvcFqwVoFNc5hz71OB9M2J0epQLcQMWjLCC7wyqm4PtmQ5UokcQ0tWGXGay
hTnzUmdkzo4D7d7WdLfU/8cJcb1uGWQNYqMrwX1OHH0H5oFBfCiajuMaIXw7+ges
ML1PhCFCvWF2gSjqCaVocygU+Gq2/Z3C749UcZBSJH6R5ytEJkgpqb+pTLlWDhhe
F0ZgI80Iif/JI9p5Tn14rmzMfn4T6/5LBGXvW9WNJT7MW/tdH7aaS1pPCgMFHmX0
U8QZvP/UQt24Dwh+kvWHSqfIngM1AWmjhVtP53POwBFyr9F6/pbYkVe4KywEfOnh
l8reekH/XmdS2KLvgVCqFxPOOIMhuPETuNaQ2B++x4alCJJx21A8gI6h4XzPvOTk
9mIiO3dbR98fa/mqTEo6wqXrfvg3IAibM+nIDHQImQgtCVBnjJdeoKbMlUiJKIqc
N+I/5RbxRBdV2xF6T/eDJjWEJCSHwxU26XJDC6qIyhpb8Uge5VkjehFlJ3jNX+nu
D5rTl62EQpdKrvBzZjmOXqzMlrp3hI6cbBC0aVFE59dMgPoZLZTvc8QHrn+A0/sR
7rtjfeMAbCf7/0hnOrjES0PYvGNP7fjzASX4EI/ewhr3i4t4w74=
=znC2
-----END PGP SIGNATURE-----
--=-=-=--

