Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A95EC7CCA58
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:06:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsoSL-0004ZW-Vd; Tue, 17 Oct 2023 14:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qsoSJ-0004Rh-6U; Tue, 17 Oct 2023 14:06:11 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qsoSA-0005cU-Pr; Tue, 17 Oct 2023 14:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697565957; x=1698170757; i=deller@gmx.de;
 bh=Rho5/4+Dqt8LvQWd3pCFAW0cM4pyitKsCDychO1qpb4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ffrHvV66Js/0GCEJvePmdogOpupJa9bbHc87V9ZK5LHEQ+2DzF6OszlIi347181jq+Jrn/osoGy
 Rql5IcloSIytWZs720kUdzwPC7NgcjL9Np6SvZ2AhSgz48kU4kaD8KuJ2iZV5cjjGPRT12Uuq+VKL
 jtBO9kfDCokJImiKf3UBp8GpISacDV1Wv0BlbdmtvnQ2Gkngvnk8qYt5myOucLSFgWDDhRK+JK6Xp
 n5jTwJNk7SN1WJk9EoP+EsLRi1NLYM5sV9gz/wVlBv3TkmEbKyqDT+UW5cIvetxnXcGUOEDZEL8z9
 3JcXC5mENcR4pf/Q3cyPSxh8OmEspTnpUElA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.254]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGz1V-1qoBte0MvD-00E2ks; Tue, 17
 Oct 2023 20:05:57 +0200
Message-ID: <a8fbe910-b017-4e55-9fb3-537015258ca7@gmx.de>
Date: Tue, 17 Oct 2023 20:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] lasips2: LASI PS/2 devices are not
 user-createable
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, deller@kernel.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 qemu-stable@nongnu.org
References: <20231017154645.95844-1-deller@kernel.org>
 <20231017154645.95844-6-deller@kernel.org>
 <8ab113bb-0c43-da4a-51f7-8113a817ae5d@eik.bme.hu>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <8ab113bb-0c43-da4a-51f7-8113a817ae5d@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bvorOerqg/rMKoz4orilqyZdAfiYqrE36ShkSrqbuKtLcx7Oibu
 kqyUxgsu2BFF9a0Vytg5CrPtN1A1FTyNgunGgHThhjzvhMcU1c3b4ydGDHv3DyBWYglc/SR
 mQPFPluxL9MffSsa8GGnVsWrflzRkB2SMo/+/APCwwR/K/blrfMXbxdnNCVQHRUVCMVBdue
 tSem/9OCpbXaWSvU1y5Dw==
UI-OutboundReport: notjunk:1;M01:P0:mfvV4Xw/8sA=;WPxuaEzYdtfT71hdg9D95+HnijH
 fAsesAOQ1aDbiWb0Fmkfbh5TA7U7XCl/rgmEDoLV+FxqA1rBVk2svCWkTHw8LJQApxcCnK9he
 T/zRMuBvyW7O/gMAAZ0Yw7wwlI3QT5ZEf+E97ZnCyZKSfFavabO9BpQyM7fgXcQJ71Dzmw45Y
 VpAEH+iyElIn21cQvLEmPRIjJ4zJUSZEIUN8ZgNoE62f1U14APX+hMYLNBxJoerFDOLihPwPP
 GowL0OtXj+dAHooblPqaUKXdCdeF11a1srRIHTM1kg1BbJTb6wmk6F8vivpwrQBbl5Jc73u5g
 Wr4MXxPLC/fIKLvJDgS4mTeFewI68NBo0sG9tukluoeqGXutCyYlcXQYARTXUhAsNfBxWVySI
 wjsPFfVz7VZeatZTgpnJ3pFgVGa2uFufXYrjz+k1vw+MCrinaVg/zWUAK8CIR7Zurc2b2n+qK
 EpGU2/ZFBPX9gKM8MSSTgkFR9YWiQy016GCzxeuo8tIv1AGvadrZ4zsmBYLLWkzZrqOwHLnrX
 6vJ7BNtAjhWHBmdf5i9runVLjBp6gyUmzGU++YcbFfVkbhQBH74H148bG2fOVaopn2EcsiqTc
 rzTqTHEAYOUnbksLR7WgaV3PLFSfajAbWvRZNpqL0ejWecwfsaLbnK6IByF1eeZ4h8xRO3DML
 bl7nwiiju1zWs2XcUMtokQanJAf8g20N7BHsVPPcoQ4SR58CYnwhy7Yc8WFU6f8TWIICFRplJ
 Ape7bOEBFOZBvmQxo1Y2WXBXXWZDveQsjwz5B5GrKYMe2f53IYghyicSd4TqUGQePLGo3LUVZ
 sXOktHdr5ymlxCw2frjsEe20LZjk83r+pwOBYJvOhYMIwcN1hwwt5q86bJJtW1mXnAeV8qNuf
 nC8YD+SAJijhkXT6CEWlqk6S76L0SifIlhKw40DaBSMapukF16WhJvgJ34AAdNzJ0bG2qr9uK
 uxGp4J4EbJ9ttbK1j8PgFjXw4K0=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/17/23 18:23, BALATON Zoltan wrote:
> On Tue, 17 Oct 2023, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Those PS/2 ports are created with the LASI controller when
>> a 32-bit PA-RISC machine is created.
>>
>> Mark them not user-createable to avoid showing them in
>> the qemu device list.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Cc: qemu-stable@nongnu.org
>> ---
>> hw/input/lasips2.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/input/lasips2.c b/hw/input/lasips2.c
>> index ea7c07a2ba..18b94fa060 100644
>> --- a/hw/input/lasips2.c
>> +++ b/hw/input/lasips2.c
>> @@ -351,6 +351,7 @@ static void lasips2_port_class_init(ObjectClass *kl=
ass, void *data)
>> {
>> =C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
>>
>
> This isn't what I've meant but maybe I could not explain it clearly.
> According to include/hw/qdev-core.h these should have a comment
> explaining why but a comment just saying "this isn't user creatable"
> does not explain it. Instead the comment should say why, e.g. Part of
> LASI, not a separate device or whatever the reason these aren't QDEVs
> that the user should handle.

Ok, will update.

Helge

>
> Regards,
> BALATON Zoltan
>
>> +=C2=A0=C2=A0=C2=A0 dc->user_creatable =3D false;
>> =C2=A0=C2=A0=C2=A0 dc->realize =3D lasips2_port_realize;
>> }
>>
>> @@ -397,6 +398,7 @@ static void lasips2_kbd_port_class_init(ObjectClass=
 *klass, void *data)
>> =C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
>> =C2=A0=C2=A0=C2=A0 LASIPS2PortDeviceClass *lpdc =3D LASIPS2_PORT_CLASS(=
klass);
>>
>> +=C2=A0=C2=A0=C2=A0 dc->user_creatable =3D false;
>> =C2=A0=C2=A0=C2=A0 device_class_set_parent_realize(dc, lasips2_kbd_port=
_realize,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &lpd=
c->parent_realize);
>> }
>>
>


