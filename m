Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B804F7A31D5
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 20:08:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhZhE-00013d-20; Sat, 16 Sep 2023 14:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qhZhA-00013L-Au
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 14:07:04 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qhZh7-0002v2-TQ
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 14:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694887614; x=1695492414; i=deller@gmx.de;
 bh=n/qB577nmSmusWwoZirpsdXeFHapXY7OigZAEDzp5Lk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=IC4G5KYQgh3EutIgnrwT0nYHf8s+xPeFXekx5Ksya2nfrq81e8tFPrAUFxl5jhNb+zj9q5K9ZKQ
 xOH4iUh8czIiZWtglrNV9175KY/40zsxKdeVeYC9V7wqzxE69yTgETcKLmedMiNudZ58eKhsEHXEJ
 lANRvz5omwqQG+BfF4/J/HyTaXXNqMotHMknDUHCQfKYImj4BwXL06DqFOG7Cqvze/uatVVoPOhfB
 j3yFATRm7WB+yS364c+eHXWhko2KgdZ3/OUBvqD5L0s+AuioRqa3fHbr4SmGkHHh37pI24GAnch7u
 cO54siAPSwNrkzJs8auTMFCDThnJ6SCJrLGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.154.45]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY6Cb-1rD6G31jBd-00YTxN; Sat, 16
 Sep 2023 20:06:54 +0200
Message-ID: <a8a94168-8b80-c073-7532-4fa5f2f8ed2e@gmx.de>
Date: Sat, 16 Sep 2023 20:06:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/hppa: lock both words of function descriptor
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 John David Anglin <dave.anglin@bell.net>
Cc: qemu-devel@nongnu.org, linux-parisc@vger.kernel.org
References: <87bd9251-5d6a-11f5-9a28-78224a776742@redhat.com>
 <953ee56d-173a-aaf2-c7fc-34386f285340@gmx.de>
 <1e41b01a-2f34-5ff5-c2b2-025d061731de@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <1e41b01a-2f34-5ff5-c2b2-025d061731de@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WWIBUeIA+v+52Mot//j/4cW/wxb7jaWai0X3AzB3yMf86tOoYNW
 wPni6Hz/a0yimaG6QaU6YAdKdu7iPGc4XVXLshU69IkJfVkHU0HovYoF69uPiVN1SE5rMZM
 qyxKF1gBksNJE80hqHeB955XYMhwlu6gGtDM6qLRAEX5wPmT0nI0hN4FGmuwCBnhPttUIxy
 UDLkfkk4b0cVNVDemsztQ==
UI-OutboundReport: notjunk:1;M01:P0:f/aufKTXCYk=;/RR+E6XSN4qj4nv5D7s7a3ga2ze
 D5JXoNxqkS5mtvSquIaDdExKPjTspuVxUmDrcr5/a2AnNfvrSVT6dFACcpmrRc2NUr3dx2VcC
 /WQr1AlOlxIrSM2GNq1F1x4odQUh5OL1Ua8YrXCR4v5+EaUOw1Rn+Oi06h0zmyhuLvqYWzaLS
 AukERDAy4dpddF+KC5BOjc1/MU7IimMzlC4mwpmKNxDqiXNwtZGGvulwQlnx+G2mlntvhGNRj
 3x6YPkp9blD4IonD52jeXqINiUmLYjov7uZeTg/qdc8Va5owkulFF809sDec3fcUtlyXu4MeP
 TEsaWv22lagKicWMh7X4q766/qX54dj26yKwOOEmt/WK6+mOAuVaN9mck7WF2xmEVUtX49aMX
 5ef/Uan9/u5UYQ0W+/YjGM8u9CzLSR/eMxNnaAQpTPov4NLcAiriRlWpHdgRe+VfWB3pMA4ra
 LAV+IfWvnxsjskqn7mYWJXWSoqwPrKUO1IqUdw6mS0Sj6wtmDlRbYLjrELWAVEUFRMLXkvZR/
 UnWLrv9eywCIb3mc1axQntmZ/qNbqbyByAXX1BFOQkJnbR+gVssZTXI6/2dQOAYW8lWf/ukYT
 0UxWY1fV/u7L3A/P/Pred/WPzUqWcUmKINuWn/sjU/D7CPUq8HPchJSG9OH2xeYy/74sW3a0z
 TmNsCKCxbKE5+Tz4nDt0afuZICM6RDxRn+n1Z+r7+IYiDnqDBMT0ZcJUIxH+Nds9nPea44G+2
 oT2539T+SsfLMVMH0+C4hHT3bjL376Gse6c8bxh93tgEx5muERyHmKwdBY0J2/LrRrnNB0U/T
 Cey8WL57VX4Z6IuHhuydghjnKT5i6EqaB41ugdfuCPsRlCIy7zlip7sk0GnLEOvQ3xXtcvyY8
 PRyRLq/n2lzZH9NZLW5DNxBRRdA3IX2MgiBIMyA1tg4NgJbliNI+d03THnzjavjPwOilcmL0/
 OJcLzw==
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

On 9/16/23 19:17, Richard Henderson wrote:
> On 9/16/23 09:18, Helge Deller wrote:
>> On 9/16/23 15:52, Mikulas Patocka wrote:
>>> The code in setup_rt_frame reads two words at haddr, but locks only on=
e.
>>> This patch fixes it to lock both.
>>>
>>> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>>>
>>> ---
>>> =C2=A0 linux-user/hppa/signal.c |=C2=A0=C2=A0=C2=A0 5 ++---
>>> =C2=A0 1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> Index: qemu/linux-user/hppa/signal.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- qemu.orig/linux-user/hppa/signal.c
>>> +++ qemu/linux-user/hppa/signal.c
>>> @@ -149,12 +149,11 @@ void setup_rt_frame(int sig, struct targ
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong *f=
desc, dest;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 haddr &=3D -4;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!lock_user_struct(VERI=
FY_READ, fdesc, haddr, 1)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(fdesc =3D lock_user(=
VERIFY_READ, haddr, 2 * sizeof(target_ulong), 1)))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto give_sigsegv;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> Patch is Ok, but I think the qemu coding style is to keep the { } brace=
s, even
>> if they are unnecessary (as in this case).
>
> Coding style also separates the assignment from the if condition.

I'll fix it up.

Thanks!

Helge


>
> r~
>
>>
>> Acked-by: Helge Deller <deller@gmx.de>
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __get_user(dest=
, fdesc);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __get_user(env-=
>gr[19], fdesc + 1);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_user_struct(fdesc, =
haddr, 1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_user(fdesc, haddr, =
0);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 haddr =3D dest;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->iaoq_f =3D haddr;
>>>
>>
>
>


