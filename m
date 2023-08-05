Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA667711FF
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 22:06:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSNVx-0002fT-UK; Sat, 05 Aug 2023 16:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSNVw-0002fK-87
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 16:04:40 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSNVu-0003h1-Ey
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 16:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691265876; x=1691870676; i=deller@gmx.de;
 bh=P4dtLwhq0SWZN5h/luXDYOYiAQF9o1Rf+z3BKeGGdME=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=SxqNZ/seLMbmRRboD8ZE5n3lT/iuBT+fgZlIFv1Rnw/c4tRCOBVoobJDxTwEnBeKaudWqWa
 w/eKOSJMZ2jb8YSIby/pT4eQTbC5rFizD77JzA8aGbqv+K4i+JSjTQS4WsONvK4VJ34/xn7ZM
 1eDw6eFWpUz/SITAnXAZu4NzvuZ6uLwkP14K6OQJp9+bYowa7SABMXIQC8Zd10B3vqshHEPST
 74+VfeoGwvuqbRuI0RIEa/LZyTRI7iaLBqPawCeG01TWbPeZcE6FQYu2eWnVsEeu1aKDvUloB
 K1CrTMs8D0q+kH8VBv0uJpzEWG6Z5Y26W2I0raaL7VJVHIK6oVmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.145.133]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYPi-1pvFgR3e8W-00fyZM; Sat, 05
 Aug 2023 22:04:35 +0200
Message-ID: <c7d0ff32-ee9a-94f7-bb1f-1bbb3b1f24ba@gmx.de>
Date: Sat, 5 Aug 2023 22:04:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH] Reduce generated code by 3% by increasing MMU indices
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <ZM59CkNZg5n4WXO3@p100>
 <53a2d13f-b508-0dba-5f0a-1b158372d1a4@linaro.org> <ZM6KOBfqFLumgpwm@p100>
 <e4c887b7-a055-3b30-8d41-0e8be0bc5d30@linaro.org>
 <a33687b2-066b-80e1-09b9-7ef108143147@gmx.de>
In-Reply-To: <a33687b2-066b-80e1-09b9-7ef108143147@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pY8CHye70516Zn+VZ7zSPoGRRGmxKkp3Cp1lkh0/d+n90NEocMY
 /yvyVZID+eH7nwvgdIouWkAFuz9QuKVY/8+ICOwnn0NVbqU3oVzIJu2cg/JE6uPaWqi7fLc
 0uIpNt1S6Mk25XERMGvAOsLyptyptZkmq2BgN+6Fi78Uw+ILdeqwYr4/hfXvSxLuQofg7iZ
 otE71OkWIwY3Fbn96SO0g==
UI-OutboundReport: notjunk:1;M01:P0:+iZFq+fr/LY=;LY9Qh1n1OFG7ObgUDu0ZoHqfuDf
 3IwM42PCyoIyDxnpRmCtvQXx/XEjZZ35CtZgBmJpZCgf8+B8pMJ1Rl0tFb1vZuAfjDkag+Y9t
 gompnmqHwo+U6UXgTEs6uhs9r0UO1OVv9xnVaHSGbRfdv162oo435V/fzbX9j6BnvahVbrwh/
 GpiTU9xCy4hrFU4+fnD4JLP/ItK+MJ1wokUKlJTRlwMX7n8qSzaPOFAZYr+Q+9jHwLLMUaU4L
 Affuo+T5UB9lu0OiV+5W+0IAvLRvYfZlsqD14NzH+tj7q+jWIselpAgXrmcxucgKRCjNemSa0
 2QWo85aBEhkf+W72m7Qyjdm8CT187ukR2U2do8UkQz07KpmXZTYPojxqPIT2ojDxH1y4aA5Ib
 YHjLAwyjj0C0sniQwuklFNF/mbi7sklB/acyp7eAVKyR+KL+IAIg9aZ5haGInj723drH/KXyA
 FjBH1ffdpFPzhEapnJu+wcbMWsI4ZohwGshshuKthtMt2wMqPZnZM9r6sdciOQY7CV5SpP7Jl
 Lvq//KJuDQ7Eu/51Xeg11CG2CitZcs6F4M2VB5WkHc5JbyEunrSkMO/7a/a0u3sathlEV9rpE
 y2oPtCrxFv1HiGtT8JtPcd84JV70XPf7iZew0I420oN6mgr18kx1nq1IHkF5qi+gPXfugeByo
 v4Q7JEDTWwsbjSflPdWrK3CpiC0Gm6cc97SJb3WMoNvB6TjG+2pWEN03U+zNhurQZ5UIFN7BT
 CNvEu6GAj82XIKMW41zkuXcCZx1FShG5MiiNXNZH6/PTTmzylQy+InPZMkMn6XiFQOOyAbzCH
 CNSS1adMWMBvweayqfL/s5ObCrwtvgg7XVccCsdxpIvIdUuxszUAL4KaocAlED8FFv4eTLiBP
 Hg/YQYHUW99UpPJYio2LB3uSb3evAsQhSfPw+81PL2FBZR9MKH0Ye7DxfRqfU4URpctmfNSDA
 aRMHpyfiR/knB9K4ntGvkv4YZuM=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/5/23 21:40, Helge Deller wrote:
> On 8/5/23 19:58, Richard Henderson wrote:
>> On 8/5/23 10:43, Helge Deller wrote:
>>>> If there were a way to change no more than two lines of code,
>>>> that would be fine.=C2=A0 But otherwise I don't see this as being
>>>> worth making the rest of the code base any more complex.
>>>
>>> Ok. What about that 6-line patch below for x86? It's trivial and
>>> all what's needed for x86. Btw, any index which is >=3D 9 will use
>>> the shorter code sequence.
>>>
>>> Helge
>>>
>>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h index
>>> e0771a1043..3e71e666db 100644 --- a/target/i386/cpu.h +++
>>> b/target/i386/cpu.h @@ -2251,11 +2251,11 @@ uint64_t
>>> cpu_get_tsc(CPUX86State *env); #define cpu_list x86_cpu_list
>>>
>>> /* MMU modes definitions */ -#define MMU_KSMAP_IDX=C2=A0=C2=A0 0 -#def=
ine
>>> MMU_USER_IDX=C2=A0=C2=A0=C2=A0 1 -#define MMU_KNOSMAP_IDX 2 -#define
>>> MMU_NESTED_IDX=C2=A0 3 -#define MMU_PHYS_IDX=C2=A0=C2=A0=C2=A0 4 +#def=
ine MMU_KSMAP_IDX
>>> 11 +#define MMU_USER_IDX=C2=A0=C2=A0=C2=A0 12 +#define MMU_KNOSMAP_IDX=
 13 +#define
>>> MMU_NESTED_IDX=C2=A0 14 +#define MMU_PHYS_IDX=C2=A0=C2=A0=C2=A0 15
>>
>> No.=C2=A0 The small patch would need to apply to all guests.
>
> Yes.
>
>> Perhaps something to handle indexing of CPUTLBDescFast, e.g.
>>
>> static inline CPUTLBDescFast cputlb_fast(CPUTLB *tlb, unsigned idx)
>> { return &tlb->f[NB_MMU_MODES - 1 - idx]; }
>>
>> There's already tlb_mask_table_ofs, which handles all tcg backends;
>> you just need to adjust that and cputlb.c> Introduce cputlb_fast with
>> normal indexing in one patch, and then the second patch to invert the
>> indexing may well be exactly two lines.=C2=A0 :-)
>
> You're cheating :-)
> But ok, that's an easy one and I can come up with both patches.
>
> One last idea which came into my mind and which may be worth
> asking before I start to hack the patch above...:
>
> include/exec/cpu-defs.h:
> /* add some comment here why we use this transformation: */
> #define MMU_INDEX(nr)=C2=A0=C2=A0=C2=A0 (NB_MMU_MODES - 1 - (x))
>
> target/*/cpu.h:
> /* MMU modes definitions */
> #define MMU_KSMAP_IDX=C2=A0=C2=A0 MMU_INDEX(0)
> #define MMU_USER_IDX=C2=A0=C2=A0=C2=A0 MMU_INDEX(1)
> #define MMU_KNOSMAP_IDX MMU_INDEX(2)
> #define MMU_NESTED_IDX=C2=A0 MMU_INDEX(3)
> ...
>
> Downside:
> - of course it's a lot more than the 2 lines you asked for
> Upsides:
> - no additional subtaction at tcg compile time/runtime
> - clear indication that this is an MMU index, easy to grep.
> - easy to use

and it's actually a 1-line patch as you requested :-)
   similiar to your approach above (multiple preparation patches,
   one last patch which just changes
#define MMU_INDEX(nr)    (nr)
   to
#define MMU_INDEX(nr)    (NB_MMU_MODES - 1 - (nr))

;-)

Helge



