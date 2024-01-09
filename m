Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DEB828EBD
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 22:08:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNJJV-0003ln-87; Tue, 09 Jan 2024 16:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rNJJO-0003l6-Ni
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:07:04 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rNJJL-0001HN-L9
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704834412; x=1705439212; i=deller@gmx.de;
 bh=LHm4VrIjcC4s1Uxm4kz8nACqVPY5/pAgyMkEunz8Dr8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=U9KLsMDL+OAqo+MwDm3OwXurZaCU6LcCYRCrAcn+yby6Iq6aiCwF6DI1adWs+CA9
 MZ4wooLUxIOgBBwaEEs7WYR1QRuC7rlP1Rzb6ZMv89oxItstPFaof0orzNOi3rsb1
 hCenAXjYrj9F0CPgKCMOLGt117cFQyNF8/wrd646dquGTdP5QD0x2sYesIflU//+t
 16NJk2FmmseWcoYeiYj+smnBdMrQlBKz1POJ+s0ieWlLkFdBrmGdeVkgEP6XtUo4+
 8lq6smuK4bUIGJ+DE9roh1WrNnSgE9oRHQ+3spM0A2uCww3ATUht1+YLpkHZJCZQO
 DBdHYNSfeMxyVtifKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.149.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1qkgEa2MDU-00ckH3; Tue, 09
 Jan 2024 22:06:52 +0100
Message-ID: <060dc700-e8f9-4bcc-bfda-0d09b81dc081@gmx.de>
Date: Tue, 9 Jan 2024 22:06:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] target/hppa: Fix PDC address translation on PA2.0
 with PSW.W=0
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, deller@kernel.org,
 qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>
References: <20240107132237.50553-1-deller@kernel.org>
 <20240107132237.50553-5-deller@kernel.org>
 <48cc72dd-bf52-4cd2-a5e1-d7d1a7e08dd1@linaro.org>
 <9c8e5d0a-99e7-4332-bf69-a7e56a62c2e3@gmx.de>
 <f8056d9d-803a-47b9-9e2e-007d164829b0@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <f8056d9d-803a-47b9-9e2e-007d164829b0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6ON/jFsy7HCR0DADVfBa7PPUFwOyQP/MFVsF5MREsSEKwegWa+n
 n5n8wVgMlvRoJ47L5RaBuhmeCPy/0HuPnOKf2g0gdZwrjtBjnHSFcaWGsVWMa6PlsGKkYUl
 Kq1ZzDyhSHfLeXe+wZyzOXBkpDfVAh7SzyhCT9l/d6BFwAoAxvhCG8GxsI2kYhaKiuJ5t+D
 uljXsp6VynHGoS1AUz5lQ==
UI-OutboundReport: notjunk:1;M01:P0:jJZ6jY39fJQ=;DigpBPxrbTMCImtHx5SRMziStbb
 6f/gbc0QK3oBR2ZRMRnlItYkYuvYMRQPxFgpVfTji/W7OixI5vZ5yYl5zE/mT8PGIcFnOKKGh
 RMYIaA4Z2USlepxE+2dj6JvKFpmoNSlebnJxqBnDUNhCGXkvldNDD1pylaGzrlP8W7RyEkWB9
 No+PmrbgJe7su/aXkb+EtINlXcrFkh9W8O0VGvOPZU9kn+CI4L1FIA1bDlRXs3reTBb7/GjMB
 TzLhu49xID8UoIQCcE8d/TAU48trnI7W23EIVWbqT374ErGriGrNgHLXPYAXESMCHcQETjK/x
 w7Sh9PnTToEOeGP8XSIsAZ8D/VPoV/l/Ht5xl3hQurXCTBsjZhdGVwph6945ufb/3MyNnFQ2s
 AMfzY480QzLBrpB64rNCGW6Z3EWHBEdApW1J+36CX3ZFbIoVfKROV6P7j0etLkHu1Rvs77Mj9
 HZ3faLcmJppGhLShh5a6d+FKr5+Cq7GSeyzH6YXu05D1cVSggsG0Bt+W2vMTlgevUbmDUddy0
 PkeAxEW64J0OpFDOtaljbyTTdH/0oUCqI+MNNIwayg5Omok+jbvZDVj7RBfi2Cmc59DrHLadD
 4AkrkEIrqNYYqQmUhfGfjWr9XpH3TSSUi8oc65uDevBQOdPtjSk6y0JiMofqlmK1hzBLxEZYw
 oSaK3sPN8NQnUxFLeEgohkFg4E8aXpvI9gks2Awcm4LOkjq3BoVF4hLNvPFwMMQkQES7+Iazu
 RrOEhGLlWIuVM1nliy5WrI5CWVnIuLqnwJblECKveCnbCASYOD6+x/nKMd3hsf6LA+SQ/SueP
 Hins5tBEwWz6TKGxUBjgBAShrBPN+m4E0Fz9rxi5P5LQH6EOHxvZOSRmWyTsmssCdXeIaclyv
 1yaYngshahl9j2vhKPXW2ShY2kr+A7g2VaI4+VxJ7mPqyQX7lL2HYnw7iLw1QM2tOAwYZAcBk
 gSaMeSi/rOlRfA1WeVzac3S5k0o=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/9/24 17:18, Richard Henderson wrote:
> On 1/9/24 22:22, Helge Deller wrote:
>> On 1/9/24 10:14, Richard Henderson wrote:
>>> On 1/8/24 00:22, deller@kernel.org wrote:
>>>> From: Helge Deller <deller@gmx.de>
>>>>
>>>> Fix the address translation for PDC space on PA2.0 if PSW.W=3D0.
>>>> Basically, for any address in the 32-bit PDC range from 0xf0000000 to
>>>> 0xf1000000 keep the lower 32-bits and just set the upper 32-bits to
>>>> 0xfffffff0.
>>>>
>>>> This mapping fixes the emulated power button in PDC space for 32- and
>>>> 64-bit machines and is how the physical C3700 machine seems to map
>>>> PDC.
>>>>
>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>> ---
>>>> =C2=A0 target/hppa/mem_helper.c | 2 +-
>>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
>>>> index 08abd1a9f9..011b192406 100644
>>>> --- a/target/hppa/mem_helper.c
>>>> +++ b/target/hppa/mem_helper.c
>>>> @@ -56,7 +56,7 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D (int3=
2_t)addr;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* PDC address=
 space */
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr &=3D MAKE_64BIT_MASK=
(0, 24);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D (uint32_t)addr;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr |=3D -1ul=
l << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return addr;
>>>
>>> I believe this to be incorrect, as it contradicts Figures H-10 and H-1=
1.
>>
>> Yes, but that seems to be how it's really implemented on physical hardw=
are.
>> We have seen other figures as well, which didn't reflect the real world=
 either.
>> IMHO we can revert if it really turns out to be wrong and when we
>> get a better solution.
>
> What evidence?=C2=A0 So far, all I can see is for your seabios button, w=
hich doesn't run on physical hardware.

You are wrong on this.
My Seabios just mimics the real hardware. And the hardware has such a butt=
on
which is reported back by the PDC firmware.
Here is what the Linux kernel reports on *physical* hardware:
64-bit kernel -> powersw: Soft power switch at 0xfffffff0f0400804 enabled.
32-bit kernel -> powersw: Soft power switch at 0xf0400804 enabled
Just look at the old dmesg from another user (with Linux kernel 2.6.16):
http://ftp.parisc-linux.org/dmesg/dmesg_C3700.txt
(search for "power" in that log).

As you can see, even the real C3700 reports the power button inside the
firmware region. And on 64-bit the higher 32-bits are at 0xfffffff0.
That's exactly what I do with this patch.

> In any case, there is a comment just above pointing to the spec, which y=
ou are now deviating from.=C2=A0 You need to expand that comment to say wh=
y and how.

Ok.

Helge

