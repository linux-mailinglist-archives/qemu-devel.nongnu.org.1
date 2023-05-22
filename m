Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDC270BC29
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:48:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q141S-00045M-MV; Mon, 22 May 2023 07:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q141P-00044s-QI
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:48:15 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q141M-000756-OP
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:48:15 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 2B69B5C0102;
 Mon, 22 May 2023 07:48:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Mon, 22 May 2023 07:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
 1684756085; x=1684842485; bh=5VDY/DQlRjweo1+bKEszwnsHQAkleKao7iy
 X343SUcA=; b=SK34oiDW3ThI7BVaJG1fa6o+Qlp2ho4CJIqrx7xrfjEzKPt0i0m
 h7Uphv//J2UDTKHyJ8l7fYFMHhCQoDYJCeCvJ3BcRZ5D/29WXU0aJDiekfsLLPEe
 SgGygH/GtrNIcL+VteCmeL5ce9tH90pYGcd3eefpdexVX0Xse3V2L2GeUX9NIguv
 eBq7nwSbzeQWf/Lg7idUD4I2bCDAgiKV/W3smv9oTIko+EQJ6m3KtDsou+cGeTHN
 +T2TPDbFg5wqG2mcLfZG3WWodtYZbOL8o+CQqeAX5212/BoniWuNJJBze9h5FCZS
 J4kdAVWcnOIUpJe7ocEl+5Tyx4sYp/41NgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1684756085; x=1684842485; bh=5VDY/DQlRjweo1+bKEszwnsHQAkleKao7iy
 X343SUcA=; b=oGZoWdGn7mChk4I8lyzVuk9hf1jQTChANRgOmGNAp7uQa9nA+7s
 zuJD2vtYofi3FFcx+/JwnfNQBTaIunRB1EkwwD133RhhVadP2AVDXHuUyyDrZjxD
 R5oPK1XiEeErTUS8+AD/BdFHHhuY6BrcA8qkR/7lgTIYwxYSpmMbTFenN5jH3YDE
 fqZ30ZdbD5/ljObn7tmTEsPULgycYlQ/0FLUB/sl1JDqYWDkOKf/gGHiuTzYSnnV
 CoPtFgpJjvsIRmCs/RfgimjyfmJbi02W4py8WS8rPvj/u5xXcU+/5+GeTdqRzxcf
 EU7ujdWb949xcWY3aiLCbKGo2oLQ7I2bUgw==
X-ME-Sender: <xms:dFZrZFdezwOLTZBJu6QNqoZ6ww56ksdde76QMt7B8uSi1McSyy_Fxw>
 <xme:dFZrZDNxN6BSHMIQD9VTmtGpq6IjuXP0n6wORUXlJq3i4InmCJik_2BCNiHVCzNuV
 k-7czG4Tll_-KC04hU>
X-ME-Received: <xmr:dFZrZOhcs5Ov3nYdYRfEfQwncEnEMwuxnkp_JRFucQme2CfU_UdunWFUkh4WjtSx2Uh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejuddggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
 ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:dFZrZO9qmiMonBO6N7s3TxFrlV0ty1vd0gqCbl8QviaCo_cD_WTaPA>
 <xmx:dFZrZBsGavf7T6bu0yMm5MdGssnLkkoeXhHdSDe9F0tbL9PEt0vnuQ>
 <xmx:dFZrZNF3ayVVvcdPu2bm6vUpYV0pZg62-J5tYup0603Tf-nhhYOXaw>
 <xmx:dVZrZFgHPaG4POn8LMepp2w2X7qYIa81f-YnRV7ETih6PIttNsk4Ag>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 May 2023 07:48:03 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 1/4] hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAAhV-H4kx5cDcswkHpCYH9UZhh7PDEndP+NvwNgdZaZji6BFLA@mail.gmail.com>
Date: Mon, 22 May 2023 12:47:52 +0100
Cc: QEMU devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA74488A-DB92-4D13-8BAC-5E853F187419@flygoat.com>
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
 <20230521102307.87081-2-jiaxun.yang@flygoat.com>
 <CAAhV-H4kx5cDcswkHpCYH9UZhh7PDEndP+NvwNgdZaZji6BFLA@mail.gmail.com>
To: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
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



> 2023=E5=B9=B45=E6=9C=8822=E6=97=A5 04:52=EF=BC=8CHuacai Chen =
<chenhuacai@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi, Jiaxun,
>=20
> Rename loongarch_ipi to loongson_ipi? It will be shared by both MIPS
> and LoongArch in your series.

Hi Huacai,

Thanks for the point, what=E2=80=99s the opinion from LoongArch =
mainatiners?

Or perhaps rename it as loong_ipi to reflect the nature that it=E2=80=99s =
shared
by MIPS based Loongson and LoongArch based Loongson?

Thanks
- Jiaxun

>=20
>=20
> Huacai
>=20
> On Sun, May 21, 2023 at 6:24=E2=80=AFPM Jiaxun Yang =
<jiaxun.yang@flygoat.com> wrote:
>>=20
>> As per "Loongson 3A5000/3B5000 Processor Reference Manual",
>> Loongson 3A5000's IPI implementation have 4 mailboxes per
>> core.
>>=20
>> However, in 78464f023b54 ("hw/loongarch/virt: Modify ipi as
>> percpu device"), the number of IPI mailboxes was reduced to
>> one, which mismatches actual hardware.
>>=20
>> It won't affect LoongArch based system as LoongArch boot code
>> only uses the first mailbox, however MIPS based Loongson boot
>> code uses all 4 mailboxes.
>>=20
>> Fixes: 78464f023b54 ("hw/loongarch/virt: Modify ipi as percpu =
device")
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> hw/intc/loongarch_ipi.c         | 6 +++---
>> include/hw/intc/loongarch_ipi.h | 4 +++-
>> 2 files changed, 6 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
>> index d6ab91721ea1..3e453816524e 100644
>> --- a/hw/intc/loongarch_ipi.c
>> +++ b/hw/intc/loongarch_ipi.c
>> @@ -238,14 +238,14 @@ static void loongarch_ipi_init(Object *obj)
>>=20
>> static const VMStateDescription vmstate_ipi_core =3D {
>>     .name =3D "ipi-single",
>> -    .version_id =3D 1,
>> -    .minimum_version_id =3D 1,
>> +    .version_id =3D 2,
>> +    .minimum_version_id =3D 2,
>>     .fields =3D (VMStateField[]) {
>>         VMSTATE_UINT32(status, IPICore),
>>         VMSTATE_UINT32(en, IPICore),
>>         VMSTATE_UINT32(set, IPICore),
>>         VMSTATE_UINT32(clear, IPICore),
>> -        VMSTATE_UINT32_ARRAY(buf, IPICore, 2),
>> +        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
>>         VMSTATE_END_OF_LIST()
>>     }
>> };
>> diff --git a/include/hw/intc/loongarch_ipi.h =
b/include/hw/intc/loongarch_ipi.h
>> index 664e050b926e..6c6194786e80 100644
>> --- a/include/hw/intc/loongarch_ipi.h
>> +++ b/include/hw/intc/loongarch_ipi.h
>> @@ -28,6 +28,8 @@
>> #define MAIL_SEND_OFFSET      0
>> #define ANY_SEND_OFFSET       (IOCSR_ANY_SEND - IOCSR_MAIL_SEND)
>>=20
>> +#define IPI_MBX_NUM           4
>> +
>> #define TYPE_LOONGARCH_IPI "loongarch_ipi"
>> OBJECT_DECLARE_SIMPLE_TYPE(LoongArchIPI, LOONGARCH_IPI)
>>=20
>> @@ -37,7 +39,7 @@ typedef struct IPICore {
>>     uint32_t set;
>>     uint32_t clear;
>>     /* 64bit buf divide into 2 32bit buf */
>> -    uint32_t buf[2];
>> +    uint32_t buf[IPI_MBX_NUM * 2];
>>     qemu_irq irq;
>> } IPICore;
>>=20
>> --
>> 2.39.2 (Apple Git-143)
>>=20


