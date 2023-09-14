Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3D97A0FB7
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 23:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtkh-0003Hi-9v; Thu, 14 Sep 2023 17:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qgtkf-0003GP-EF
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 17:19:54 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qgtkd-0007HE-BP
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 17:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694726385; x=1695331185; i=deller@gmx.de;
 bh=7DhPwe1dJLN7G43PV/TXiqGH/8jS9Wr6/1ISWqBOSrw=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=LTB35eDhsZPgv7dPdnI/9w/z+BfFvECxVHLu2IpsMQKy1kTxdcpRtFfCwladtQ3mDizSlIiYath
 cXoZ2aliVCLMyitmm9pT6RASvJA6ennH6DEQZBbCN9Mpg77lPMEPYv7VXu2yRJeXiaAS8zDQpDzkL
 JunPGy21lMHmD0M4g/yUMCBU9BpbIFDeRrytclBjUZQS7CrYieUBW8AeMeiZVQyHy5ceIrRO4UZxs
 lBulMNlVtrQjE5c80W4dJcKqnEcYPSK109JznWbovFWW3VYBhdooQ8OUbJk1frfbbzJrD5gWhf0fP
 VKhheDNrlI+tf/dKGoqWDBcYXZJDVbu5bHbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.145.203]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UV8-1qgLml1hgo-000ZTo; Thu, 14
 Sep 2023 23:19:45 +0200
Message-ID: <6e6a7003-0c62-d208-da3c-6b25efa809e3@gmx.de>
Date: Thu, 14 Sep 2023 23:19:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/hppa: Optimize ldcw/ldcd instruction translation
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <ZQHLcL6E5uNvjkaN@p100>
 <ba047867-db8b-8bb6-d2e7-563516c5afb6@linaro.org>
 <acc0b3f5-959c-ac8d-89e1-5c862b39a721@gmx.de>
 <f824fa25-0d7f-b417-11a4-e3c84efe1b7a@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <f824fa25-0d7f-b417-11a4-e3c84efe1b7a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GIHag+YevQPBgoFX26/c71kuHAe3awhUeNv0/qO3ULVUxWWB4GD
 XxdYJreYVEfALo7OkQrc9ytx0e1Y2zY/falvZtQyPnMF58ncnp/4hfkgN+fKs1uAQHex8o5
 cQTVY/25BBDTh23x4sHdl3mQ25MZUmS0V6ioAprNAnFBbsrIxvYtdoxbFQ2LZ0exRCcudFn
 MrCuYtsofHG7CKbPAtyOQ==
UI-OutboundReport: notjunk:1;M01:P0:6cL2DDs2Muw=;u6HQt3geYtB43Z/jwsKg+rBiDhJ
 JpfrUB6DmUpI8hQk2LmHU5ccTpOGIN55EQyoSMKr9yvl93rXs+2FQi4q+UYIqiXCYRkZ9HFjJ
 caQPP3dlWkNIf9EXDbiTwyakwY9dFbSnbdtshOOKLtwoXuc/goNigeM14iUEwxlWn11wS7MhN
 d/d3irZRQH2kVbQ0YVT1VkMlOIVKHGMINdCUeopjVRyQEFnJRArCkgc8lGjQf43YPhe/oQiBO
 cmOQfj0zrw+Tu7l6LpHkzZdnpGWUzXtCzml5QnEvt5f6UY61lU1VHc7AB5lNo/G+GPLPi+XvR
 aNOzCqMD75xXRUH0m3rM0nbyHS+G84S7VpFN/zUETx1hL0y/6qfIT5+vX87CcB4Vt/XkQ6FRJ
 Z6xKVN3R6MAsUftUjtIGUibvZLX+NwzcCFJN3R6Wj9x+qJzFtMJFSSQlZe7r+NA2FzKjRHeX1
 AclOc3a9/WEqc7KR5GxJauvnn4Li7wjH3/+XfiAhKgcSFSIaBYwCPZcs1hbSyWvv3/NXwlxtr
 6qCgZRnymFYuuPv4BwoCFBPBx4CjNF9BU+10Nta0uf4WyxOnd7tDsztnpTZXoY40phQiHL37z
 LmIrFbfd2/bENgn9yvlIgVIL02ebukawE+0wTb1HeXWhDYTSKOubYYLqzN6v/yQlqocl55lA/
 h/atIAmhtNSZQJwZPuuFW3P0iLv4V1tKwX1xBs2XuEE0F8WB0NuyaSLcoBicHvKDFx9oMUiI6
 MRvagtpTDtfSvKAITfkpD+kFrUBanAWftDjr47Ba8/BRMzwwS8MrJ4Sdvqqr2Kyu8fuyKqPYV
 PtoU/364S/WYCeMykXfzeQzHiQTVuxlw13fxf1im7gbh7OHkrOklRPuE6quktUQs62tG1NddZ
 uhOo+qNZEOnppxaqJVzbf2aXzwxA9CaJ9sw96esc85mtccAso5+KOHvgvmJ0AU5ZYn3rmugwh
 AP++/A==
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Richard,

On 9/13/23 22:30, Richard Henderson wrote:
> On 9/13/23 10:19, Helge Deller wrote:
>> On 9/13/23 18:55, Richard Henderson wrote:
>>> On 9/13/23 07:47, Helge Deller wrote:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 haddr =3D (uint32_t *)((u=
intptr_t)vaddr);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old =3D *haddr;
>>>
>>> This is horribly incorrect, both for user-only and system mode.
>>
>> Richard, thank you for the review!
>> But would you mind explaining why this is incorrect?
>> I thought the "vaddr =3D probe_access()" calculates the host address, s=
o
>> shouldn't it be the right address?
>
> The vaddr name is confusing (since it implies virtual address, which
> the return from probe_access is not) as are the casts, which are
> unnecessary.

Still, I think my code isn't as wrong as you said.

But I tend to agree with you on this:
> Frankly, the current tcg_gen_atomic_xchg_reg is as optimized as
> you'll be able to do.
tcg_gen_atomic_xchg_reg() seems to generate on x86-64:

0000000000525160 <helper_atomic_xchgl_be>:
   525160:       53                      push   %rbx
   525161:       4c 8b 44 24 08          mov    0x8(%rsp),%r8
   525166:       89 d3                   mov    %edx,%ebx
   525168:       89 ca                   mov    %ecx,%edx
   52516a:       b9 04 00 00 00          mov    $0x4,%ecx
   52516f:       e8 1c a6 ff ff          call   51f790 <atomic_mmu_lookup>
   525174:       48 89 c2                mov    %rax,%rdx
   525177:       89 d8                   mov    %ebx,%eax
   525179:       0f c8                   bswap  %eax
   52517b:       87 02                   xchg   %eax,(%rdx)
   52517d:       5b                      pop    %rbx
   52517e:       0f c8                   bswap  %eax
   525180:       c3                      ret

and atomic_mmu_lookup() is basically the same as probe_access(),
so there is probably no gain in my patch.

Please ignore my patch.

Thank you!
Helge

