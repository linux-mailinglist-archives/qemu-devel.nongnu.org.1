Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E92C7676D0
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 22:16:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPSwk-0002KC-Uu; Fri, 28 Jul 2023 15:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qPSwj-0002Jy-8D
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 15:16:17 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qPSwh-0007Lv-Gl
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 15:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690571765; x=1691176565; i=deller@gmx.de;
 bh=CWPvn2dcz7K/ujAeFTorKidDmn5/zJNS3abKDui1vEM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=iNEkmG+AVvP7l4A6Kwg7EzFE/jimRNX8gYU2EUWP+bXo6Fr8tW/e32ul3n9SVSgPz3nn2Hu
 OwkTDsxGnadqg5ynX2p0wNpWZ5SL7dvn2VFxvWMtRbw+aTqCMP8/9lPk+GZmNPA9De3WEAftS
 RbvCuhrQfW96DlUCvoIh7SR2V903Rf6SJVyi6mn1BYQbS8iFpkt+vA5aRaiUtOvMkJBnfMYET
 zuJmseiII+/N2fK/TPkTBSmThDdalpFggh5ZTNOKXCiMgT1Dv53mS+BIh7TcwwzTE7PXSFRRM
 GdXZNO97a2Ckn7dsUDKfP2UKjuZV3i1BdFUI+IE4H8r1oRzw5/uA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.73]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSc1B-1qJFee2xIn-00Sxg9; Fri, 28
 Jul 2023 21:16:05 +0200
Message-ID: <93cf0369-504d-53be-a0f1-63acf82a5d5d@gmx.de>
Date: Fri, 28 Jul 2023 21:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] linux-user/armeb: Fix __kernel_cmpxchg() for armeb
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 John Reiser <jreiser@bitwagon.com>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
References: <ZMNJ+Ga7A4zDXjAg@p100>
 <f6129139-54f6-1d96-1edc-cb1bdf7dac89@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <f6129139-54f6-1d96-1edc-cb1bdf7dac89@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f348NXsM5WxHa+Lm7B+KQFcLo2yfrw7aVwfHgR3rh/ua0HXvTDL
 DS00Ty/JHgG7mC4HpVatF5H7eYptofGgEZ28cohh55K5b12Cl14pv8Y2JMX1ZIjweh0GM9Y
 BjzT7+oF680K0ppvoh0XoR3uPY9CxA+pM4NRzt/YGkNNgpcgQwJItjaW9vwaDbxuvqaHCCa
 AAEqa6fNZgVbuK+dqW9+g==
UI-OutboundReport: notjunk:1;M01:P0:T+JhtyhA2gE=;YyphQ0b5crs/YBYQW40s3Gk4N6J
 zRt+Z+FH/xn/UxGYyfymChoKF9wI9izOIq7Qm5yxx5C7nqZKe2qfnCBjG15ViK5PnnohY1pY0
 U5QfQ6D48lekE0GtgvW0DMV659Xwc+I3qEVy/016z1uxk/yopQya9/m6eS33oOvrKVOW26Z78
 hFBEg0PNlt1AXO40Yt2E/q4MBFw3Pu7tsgzNMEx7qZGnzGY2+j//EmVxKgMaucehTYuhC08tH
 4h21mMowo7e2/FM+MHn+uXE/ei5S7mwNKzQtVj/Ltwcbk+V4xZHivYwbcpk49AGiIMvezLJ+8
 vTmRZ5UxUcjjY2ZKWJTWu/etKv0V2Gbop4vWCo+8S3JNVxxUJc1WYrWvulz60X3t/s0II6Yrm
 CDHpx5uGaqHe70OwVcsueeqkGZQCB8ftQ6Z8ICtoVnkiSsiaDs0ryJ7WIYc/eKReTu9MbptAx
 oUpvat0kfuUXVen0g3l+YRaGJE6YH7u1phHJGOIv6aZWQFMi1wJo5R8nuQcVuzsv2q9/et4re
 vt/UO2vksjLc6k1bTT9uCOvYu817UktjHTe0kECeneGfBr3a3Dg4kbdqw0fDBWNcXw10fgrTt
 k0aIpnzbfIEu57vT6dp7PZqM9HpHlsUop/UD/cSzc4qz1FxUzgNpOkHcDAbTPJTWNLUn7e+b/
 Om5g8zzLj8y+Uv81UrjimIuRDLDEcRy5c+ZxSIU+eeGO+IkCBwxLJMs/YsHEwOSmgo5ybEJ/1
 OezkCCXsuF4aK93KpoUbBgMumVUak0sMmBR1epYTebUMLqFYgHvZIMbQ7GSMi3JIb+f7Aiqvf
 /OJBHBny7vuUFF4ia2SwDsl5s8kKy/b8amMxDl1ct+CA9k/gvIY0XIoW7tQeVgDDzZNyfB8wy
 zeyfg5sCoXByEw85pgmH7AONjbwD2ERQ7Fws7uU8zBmZH3BTHllXYoNAU5/F6QJYHK8k9Spjb
 X6y3wHQEfnJ+dlZmy80VdhE/v8A=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/28/23 17:35, Richard Henderson wrote:
> On 7/27/23 21:54, Helge Deller wrote:
>> @@ -174,6 +175,10 @@ static void arm_kernel_cmpxchg64_helper(CPUARMStat=
e *env)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0 /* endianess-swap if emulating armeb */
>> +=C2=A0=C2=A0=C2=A0 oldval =3D tswap32(oldval);
>> +=C2=A0=C2=A0=C2=A0 newval =3D tswap32(newval);
>
> Must be tswap64.

Oh, of course!
I send a v3.

Helge

