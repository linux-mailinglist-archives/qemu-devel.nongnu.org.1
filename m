Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A657670DB62
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 13:20:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Q2P-000382-Ih; Tue, 23 May 2023 07:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q1Q2G-00037W-MS
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:18:36 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q1Q2E-0008D8-QF
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:18:36 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 2E7F35C01BD;
 Tue, 23 May 2023 07:18:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 23 May 2023 07:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
 1684840712; x=1684927112; bh=tk2K9FCoHmgBYKpCZIGL7AYc6a7NszktshV
 NldWMGg0=; b=ZDLIy/gJtEBN6H/hMbd4I2hDEww+9p0cTRlOV3oBXxyBLFAMovI
 stkiXSUO2yKOQSyfk/vRvmYvWUC4KHsSZGPvZv4Yh+Akt+4l3B6U8hl+AcHJ0RBE
 o2NMlon+82OVC8bocBKsRqnwgxCEQ11GVCJ1LKsKqEHmc2ITJxEolHzCkLgnodRl
 2r5X6RlThnpvdcJkj3tbXQDhd0xh/0O6ao+mUlYpx0Wo0xafEjiCf5r4pUc1E5s+
 JXToOMHWLmIelpV0uXZ4h6ntcuAH8MDzUMashNYu1D+JJcIXsYMMUQsSJyrUh/wN
 cej5uxG6pzHg7v8TyRrbajCbsIYuAD4zM6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1684840712; x=1684927112; bh=tk2K9FCoHmgBYKpCZIGL7AYc6a7NszktshV
 NldWMGg0=; b=NX1GfpMI+WQSzlr7M19TeuTay1L11hV42Cy/r3wXVQiR8/oO+jB
 Nd0p0xZjnz7bgZsm0yEuWGfnpj9quEnauQHNGDboz6+/CeXdMRv9IaPeww6FJt8C
 kIYEEeYYFvDKVXfw6QKQtBk056tpOCYg0dSPziTUGVKW+k8mMm47rzQY6Ywo7XFn
 0eP4590D7SiE0YfjutmrLWjs4KAGS34ZbGm4kz4Avt68AR+yeg60xK1zhS2RG6At
 yTqLMZywoA7lBObrM9F25OQt2FUGmisUx+GGj0ELRMvZN3X677lSKO+aDpMvvbP1
 SfWFJiNbdYL56ODeZrIcwwGRVFbMnmPhZIg==
X-ME-Sender: <xms:CKFsZIfoRj01iaXUCbKaMqPbB05NbYDuSVC6ucL48AiXWvYGyE22zA>
 <xme:CKFsZKNnhILTxzdpzJT7N0zW-7kDrSqWjslCb9oWkjeWBtWS92h15ttxr69ISd35T
 UYBjsuy3ZCZkWSFYpA>
X-ME-Received: <xmr:CKFsZJjqIGNRxF2xIk6GbJmWy48ZPcUM3iCoa2PaeBIU7KJKqlQOoApR_rXz8qKcOGqZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejfedgfeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvedugfeghfejkedvfeefvedutdeuteeujeelleefveejgfel
 hfefueeufedthfdtnecuffhomhgrihhnpehiohgtshhrrdgrshenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:CKFsZN_eyyA6Va9p_K9GB95YXJSg7VoGT2x3geSjbTAv2b4xAmi__A>
 <xmx:CKFsZEsD4jTEOaXQqmI9xS8qSBiF32OUXJRFvmOZ0_Z0Ab6IAY9v_Q>
 <xmx:CKFsZEFlOycpgKgPzagF9NSa2UUHlPOoNDTfukCMCOSJyDB0Yc4B7A>
 <xmx:CKFsZFn-y1-EGkYCHKdUDS_q9njdDJOnJPjZRZIpYehwyEz5ahBRtA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 May 2023 07:18:30 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 1/4] hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <29e26b7b-497c-a446-be86-8dda70b606d7@loongson.cn>
Date: Tue, 23 May 2023 12:18:19 +0100
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 QEMU devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5BE30A5-7DE7-479A-B012-23076EFA7831@flygoat.com>
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
 <20230521102307.87081-2-jiaxun.yang@flygoat.com>
 <CAAhV-H4kx5cDcswkHpCYH9UZhh7PDEndP+NvwNgdZaZji6BFLA@mail.gmail.com>
 <CA74488A-DB92-4D13-8BAC-5E853F187419@flygoat.com>
 <e184fa06-9ce4-1ab9-4680-58aa6c4200b9@linaro.org>
 <c965d4ef-3993-cfca-7d22-3ecef5cfc256@loongson.cn>
 <07F6A866-81EB-422F-A42E-6B31BEE401BF@flygoat.com>
 <29e26b7b-497c-a446-be86-8dda70b606d7@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
X-Mailer: Apple Mail (2.3731.500.231)
Received-SPF: pass client-ip=66.111.4.28; envelope-from=jiaxun.yang@flygoat.com;
 helo=out4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> 2023=E5=B9=B45=E6=9C=8823=E6=97=A5 11:01=EF=BC=8CSong Gao =
<gaosong@loongson.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> =E5=9C=A8 2023/5/23 =E4=B8=8A=E5=8D=8811:22, Jiaxun Yang =E5=86=99=E9=81=
=93:
[...]
>>=20
>>>=20
>> Is totally the same on MIPS and LoongArch. I=E2=80=99m guarding them =
out because
>> We have different way to get IOCSR address space on MIPS, which is =
due
>> to be implemented.
>>=20
>> I can further abstract out a function to get IOCSR address space. But =
still,
>> I think the best way to differ those two architecture is using =
TARGET_* macros,
>> as it doesn=E2=80=99t make much sense to have unused code for another =
architecture
>> compiled.
> Most of the code in hw/intc or hw/ uses property to distinguish =
between different devices,  not TARGE_* macro.

They are the *same* device, with different way to handle IOCSR address =
space.

Another problem is casting CPUState with LOONGARCH_CPU() is something =
invalid on
MIPS, vice-versa. We are potentially introducing a security issue here.

I know nobody have done something like this before, but not necessarily =
to be a bad idea.

I=E2=80=99ll introduce something like:

+#ifdef TARGET_LOONGARCH64
+static inline void *AddressSpace get_iocsr_as(int cpuid)
+{
+    CPUState *cs =3D qemu_get_cpu(cpuid);
+    LoongArchCPU *cpu =3D LOONGARCH_CPU(cs);
+
+    return &cpu->env.address_space_iocsr;
+}
+#endif
+
+#ifdef TARGET_MIPS64
+static inline void *AddressSpace get_iocsr_as(int cpuid)
+{
+    CPUState *cs =3D qemu_get_cpu(cpuid);
+    MIPSCPU *cpu =3D MIPS_CPU(cs);
+
+    return &cpu->env.iocsr.as;
+}
+#endif

Thanks
- Jiaxun

>=20
> I still think it is better to use property.
>=20
> Thanks.
> Song Gao
>>> All references to loongarch_ipi should also be changed.
>> Sure.
>>=20
>> Thanks
>> - Jiaxun
>=20


