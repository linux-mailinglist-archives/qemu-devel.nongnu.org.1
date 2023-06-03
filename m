Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFC2720E70
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 09:08:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5LLv-0001zz-Rc; Sat, 03 Jun 2023 03:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q5LLs-0001zc-WA
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 03:07:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q5LLr-0006fS-2d
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 03:07:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 8F1915C0087;
 Sat,  3 Jun 2023 03:07:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Sat, 03 Jun 2023 03:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
 1685776020; x=1685862420; bh=amhXiMSK/tRBOTRNakTaFOspBOdi84PWrZn
 zENwJSSY=; b=tCO5NySax1/m91GA9mFkHS4dGvPMNi2a4CEyi6DGmFcBFclA3kS
 uWvz/jTG6Q7rNZxJpOJie4xQayst2zGTGTEBSYjaKewwPIQBvtQpLlsPhx4RVD93
 lCR5RN97Ty1T9L5DDZ6aeWudZix+jS3ApHTDzOn+bIYUFlReXVAKsmrsBQUGsBtc
 sDAbiyFHq/RD0kRihp8mAglecYeQCJPo80M+tlEX4fTPCTAIVkg5QxnAT+woyH8y
 afEYoKVxZZgpKk9OOwMq0OUOU8jZiWHvFPMyNBhIxg3F+cs3Wp++rVIzWs8dZ86X
 koA9VxTIWO68vm86JvPZQt1hEuDVaPU68zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1685776020; x=1685862420; bh=amhXiMSK/tRBOTRNakTaFOspBOdi84PWrZn
 zENwJSSY=; b=ENdg8LTSMs9N+WDNDewvrCWHuCYV1pBPrOqR+mFqrqdo14FXWPM
 w7/fuNmfowVldlyTDavg2Vq5MV8ytzK/fMVzcNJ4dL356/SImG2lgz2bjRu8Yh7s
 sqpRDucTdf0H/OI8gDnvg0lEspG0CWoAJfqJuIzU3k9xD6soemgkB+ShY2nowQaO
 gW/9A+MRS8tvJJpEWy5QSG9gSmgIuZnAxCdx+9jc/4RHZBy0rEO2Ux19d1lMwxaQ
 kgGrySnXB9+AJ8wcKA7NwcnfSVhh/JLEs1yxbWIbUid/yivM/B0qCjHJj9CAu6Ds
 k1i5HhUB5PNLKyixSFsJKYGKkplXkmhGJ8Q==
X-ME-Sender: <xms:lOZ6ZAs2cKtgyNg7tyGFpDfbjhOH-YcQcxsjA0Ji45dzue6ZjMGOlA>
 <xme:lOZ6ZNcAb3NIL--cWHMcExJu8NOt-SC7wKJR0myFcb2mk-hOeevOGGIe_09WpK0x8
 _1oYc5QHIQV260LO9E>
X-ME-Received: <xmr:lOZ6ZLzdmBBLTcCl_5l_LypLwjsm5DqIGK76QvHlrdVN2zTyLscAOOk_AGNPiMNyfMAO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelgedguddukecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedutdejffetteefkeejieehfeeuieeguedtveeijeeviefh
 ffelvdfgudeihfdvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:lOZ6ZDO9gB4As0sDC18cvRLR8s2Ep3VVDbb_ghUeQ4CStAgoaxgWmg>
 <xmx:lOZ6ZA8lFIhfn-ilwL8tguIhWMF8ifs5Xgz6HZsQV2dfdYrqu-iIBg>
 <xmx:lOZ6ZLXdmbaC7-F9-n1pp0rUWPBMKvkSRSU_TN78AeDddHUTlUJMNw>
 <xmx:lOZ6ZNNuBiGONlZaTj9oYUNzb1fQoqw8LJ3rbNCoFzeuYoERUT-lTQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jun 2023 03:06:54 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH 1/4] hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAFEAcA9F4OOwg9LQn-y7ScixG9mZ58bsvcE6qGqxw1WXENYaZw@mail.gmail.com>
Date: Sat, 3 Jun 2023 15:06:41 +0800
Cc: QEMU devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <203A9E36-9EAC-41B5-9EE1-94936957FA89@flygoat.com>
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
 <20230521102307.87081-2-jiaxun.yang@flygoat.com>
 <CAFEAcA9F4OOwg9LQn-y7ScixG9mZ58bsvcE6qGqxw1WXENYaZw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
X-Mailer: Apple Mail (2.3731.600.7)
Received-SPF: pass client-ip=66.111.4.27; envelope-from=jiaxun.yang@flygoat.com;
 helo=out3-smtp.messagingengine.com
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



> 2023=E5=B9=B46=E6=9C=883=E6=97=A5 01:28=EF=BC=8CPeter Maydell =
<peter.maydell@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sun, 21 May 2023 at 11:24, Jiaxun Yang <jiaxun.yang@flygoat.com> =
wrote:
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
>=20
> In particular, this fixes Coverity issues CID 1512452 and 1512453,
> where Coverity notices that the code in loongarch_ipi_writel() and
> loongarch_ipi_readl() reads off the end of the too-short buf[].

LoongArch maintainers, do you mind to take this patch while I=E2=80=99m =
refactoring
rest of the series?

Thanks
Jiaxun

>=20
> thanks
> -- PMM



