Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9952570D257
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 05:24:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1IcF-0000W8-JQ; Mon, 22 May 2023 23:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q1IcE-0000Vz-0R
 for qemu-devel@nongnu.org; Mon, 22 May 2023 23:23:14 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q1IcB-0004On-Gg
 for qemu-devel@nongnu.org; Mon, 22 May 2023 23:23:13 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 826B75C00C8;
 Mon, 22 May 2023 23:23:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Mon, 22 May 2023 23:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
 1684812190; x=1684898590; bh=z3t8SQWmEeDVoY+pyNW2neo3tNmAK70zEQ9
 LlcmsZig=; b=j6+WEPTPH9JHylVTqwEPggXvtPBrRGDPQF+CVaDyDcNkZecEjTC
 EA8f+fPFgGaKOpdEMlazFlvmvxPtgxvjqgJ+Xup9xABDbQbVcf7Q7qvo2P6p+hNG
 DfbJXBWW/PdzS6kCflpiA2oW3hxWCu2HakifIvn+TJKmklDYX1z008TmnsOU8lgT
 qLZc4t2K/XMv1AuIWfbXf/dpx7VhRNBeczuYpYSaKRKajlVCS512sRRPzc9Yg9HE
 Ncg3dc6GVxigzTr38xFpCJB30lajEQg7jDRGXcWgPQcrBxslz1t/AvZ37CXvxTmS
 N2LUqClHx3LrJ9wFe5nBFc3MJSkcWwP6qMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1684812190; x=1684898590; bh=z3t8SQWmEeDVoY+pyNW2neo3tNmAK70zEQ9
 LlcmsZig=; b=IULGwUdX+DMw1SMddZCM/UtkO5AbjUgOHF0D4Zoar+AJfnjscC0
 HgaM/oiJMM+5MRf0Q0jHfDAJsyXLBeqw0I2V86z0E0x7USx11viPA8V6oCUnwk3g
 n3plLMathtPmEvd0/FWMcS2uic/XlxAKPhYS3YnuByB2aZodXyqOlLqH2nVD9N9a
 LLBDZy21rK1/27ysM1PxcQvOYArbnBKYGUm6BJwN6bA1xayXgHjlG6ryRY9LKXgI
 8uMj2RWdMTmccv/EEKN+1tPYKwQ8Bg7k0rz231aAlW9I3SEB5e4q7GsUUtEufEMy
 VUmJnj3v377W4WsxUFVe1pDRSyl6lioG+OQ==
X-ME-Sender: <xms:njFsZIzeSK2WhL7c_5SsgvLnFYIirgXHFeyggWwwLQQzb1NIs9qyBQ>
 <xme:njFsZMSl_hg3Bso9f_7Bw-QGvyJFnOYEUfzomq5V23FqcZZZ65pbG87unBEo2ENiY
 ZcD7fbIOhYfL8YC2-8>
X-ME-Received: <xmr:njFsZKUEay2u__Talr7mWSVtKk6ZxYoK0DQ5ReP-KHc88dG0dYKM7TDl00zIZNxMGzOu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejvddgjedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
 ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:njFsZGikvB9r7B1BaCRSK3CiJT6ViQkcO-kNdhjZ6s44j_Qyh2dPEw>
 <xmx:njFsZKA0K_sQYTJM-ZuIxEN9V3U50Je6iiJUyi7wJEaLhGMWHbYDMA>
 <xmx:njFsZHLEE4c-RmCbQRYWs2lieijRcM_NC5Ck5DmDRX6uoFbPBMc9kQ>
 <xmx:njFsZAApLeVk5kNZm2uJ5v0Poh71VY8_rXZ-GpM5a_qGWsv-c7mS8w>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 May 2023 23:23:09 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 1/4] hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <c965d4ef-3993-cfca-7d22-3ecef5cfc256@loongson.cn>
Date: Tue, 23 May 2023 04:22:58 +0100
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 QEMU devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Bibo Mao <maobibo@loongson.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <07F6A866-81EB-422F-A42E-6B31BEE401BF@flygoat.com>
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
 <20230521102307.87081-2-jiaxun.yang@flygoat.com>
 <CAAhV-H4kx5cDcswkHpCYH9UZhh7PDEndP+NvwNgdZaZji6BFLA@mail.gmail.com>
 <CA74488A-DB92-4D13-8BAC-5E853F187419@flygoat.com>
 <e184fa06-9ce4-1ab9-4680-58aa6c4200b9@linaro.org>
 <c965d4ef-3993-cfca-7d22-3ecef5cfc256@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
X-Mailer: Apple Mail (2.3731.500.231)
Received-SPF: pass client-ip=66.111.4.29; envelope-from=jiaxun.yang@flygoat.com;
 helo=out5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> 2023=E5=B9=B45=E6=9C=8823=E6=97=A5 02:25=EF=BC=8CSong Gao =
<gaosong@loongson.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> =E5=9C=A8 2023/5/22 =E4=B8=8B=E5=8D=889:44, Philippe Mathieu-Daud=C3=A9 =
=E5=86=99=E9=81=93:
>> On 22/5/23 13:47, Jiaxun Yang wrote:
>>>=20
>>>=20
>>>> 2023=E5=B9=B45=E6=9C=8822=E6=97=A5 04:52=EF=BC=8CHuacai Chen =
<chenhuacai@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>=20
>>>> Hi, Jiaxun,
>>>>=20
>>>> Rename loongarch_ipi to loongson_ipi? It will be shared by both =
MIPS
>>>> and LoongArch in your series.
>>>=20
>>> Hi Huacai,
>>>=20
>>> Thanks for the point, what=E2=80=99s the opinion from LoongArch =
mainatiners?
>>>=20
>>> Or perhaps rename it as loong_ipi to reflect the nature that it=E2=80=99=
s shared
>>> by MIPS based Loongson and LoongArch based Loongson?
>>=20
>> I'm not a LoongArch maintainer, but a model named "loong_ipi" makes
>> sense to me.
>>=20
>> Please add it to the two Virt machine sections in MAINTAINERS.

Hi Song,

>>=20
> 'loonggson_ipi' is better, qemu doesn't have naming with 'loong' as =
prefix.

Thanks, I=E2=80=99ll take looongson_ipi then.

>=20
> And  patch2 should not use macros. Some attributes should be added to =
distinguish between MIPS and LongArch.

By attribute do you mean property? If so I don=E2=80=99t see any =
necessity, the IP block
Is totally the same on MIPS and LoongArch. I=E2=80=99m guarding them out =
because
We have different way to get IOCSR address space on MIPS, which is due
to be implemented.

I can further abstract out a function to get IOCSR address space. But =
still,
I think the best way to differ those two architecture is using TARGET_* =
macros,
as it doesn=E2=80=99t make much sense to have unused code for another =
architecture
compiled.

>=20
> All references to loongarch_ipi should also be changed.
Sure.

Thanks
- Jiaxun

>=20
> Thanks.
> Song Gao



