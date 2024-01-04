Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF4C824990
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 21:29:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUJd-0008HT-2v; Thu, 04 Jan 2024 15:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rLUJa-0008HK-Rc
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:27:42 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rLUJY-0007gg-Ob
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704400054; x=1705004854; i=deller@gmx.de;
 bh=wI7YzSpN/MohG9aRB57ZhOB3zwy7I3Jqku0XqV+YypQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=V1zAlfIPx3Y1lAFtsg0LgfAJYLfxpJImG5L7V0W+E98luxcWb3DA0J0XlDg81F0t
 O/tm41M+zYUsDH0S7G/vM8iODIsj3vOgjFSybZtQc33/gpUsP8lpQMrw518m+8TDf
 qJL1VWvWC/OrLEhjBqgeQxxkguXp13qaJEAhb5ZopAKMxFJhrvKeZaKpvCkbj/kpV
 N24iuegDcn41GtM4chgUfc/G9E56pWF6QNMj0c3k+/zDjfepitkiczIeg20h9tlgC
 pmtcXtyOCgnBv3M2ScnBE5Hj6KRCv4+1oa/PlfeFt30o7KGv1Vs6Fp/uQ3R4ttPi7
 5PGdRfXFKPlb1kO8Og==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.158.235]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDIo-1qvGEQ2yNk-00iD7e; Thu, 04
 Jan 2024 21:27:34 +0100
Message-ID: <6b619d29-3630-4698-a127-c54b80f700e1@gmx.de>
Date: Thu, 4 Jan 2024 21:27:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] hw/hppa/machine: Allow up to 3840 MB total memory
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, deller@kernel.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Bruno Haible <bruno@clisp.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>
References: <20240104183628.101366-1-deller@kernel.org>
 <20240104183628.101366-2-deller@kernel.org>
 <alpine.LMD.2.03.2401042055420.28870@eik.bme.hu>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <alpine.LMD.2.03.2401042055420.28870@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:liI3sBdaUKgc3ue8tdLauYbPajgGD2W1nhmRRF6hUk7U2h3h8my
 STMst3UT6xJ8XGpEMb8imzpxgoXv/n1bGOZkX2Z65IpPHJtUZkPtlVGrFFPhgBIg5a8GDjr
 hnJDyov8CFhnNLhduu+vijQVNnnkx6CG/j/iFVAv0WwERlUwdcHHmZhe78tqOy7uwaLxerR
 8l1AfWjxBScnB9k3DwcGA==
UI-OutboundReport: notjunk:1;M01:P0:zSvUVULhjLQ=;Xpiw0aSnA5vCvl2iRwAl1GaP9X5
 FAm9/9FvV/bbh9OyoF9C2cXZrnRvDvot+SHfnwweHDCi8GZu1DV5o3WTmeUkhdz07emOtqxPf
 2MAVxEz0wXPTHpf1F7bm0h+kevNgYY16DYj93ldEnanZArKzSxPw9f+uC2Lq22/oZD2hsqEnk
 pyHqApG4ac7vv8cakr9weNs24Q+lfbRRQAcorDymjGnHtADI/bk2MMjAmFG0sKwcnioakSSrZ
 mhIo7H2eMRuifUJJmFaKxyP5/QPwRy/WesRIqCK00pspl4Rm9K8GjzQSu8sqHQlFbVJ3WSjmK
 XazuQuNGSCzy4UPWnPOMq1UAX8VvgjaCDkbbRM67jby0YFzKeiKjmpTTSAAYhGpnHKThp6qON
 Zs2tcyMsn/QzkeAr00Yr0Aq196H+UWsi1Y7myhZooS6Du2eJQq2F8jXgrTvw7yCGKGdYoWC0V
 sDgzIirqkC9ByZtNzURtACT1vzce6fYIiwiYSl93AJxkUrQbnDQmSH7Z2uAfiuZct1fqIuz6H
 gOb3UVCvZWCcZvNNjJxbeAi2aOh3nt3M4vWorc4MLSU5N971XL9FHBEnHorxsQhJv1Yzc1DAb
 B4mIwO1i8dgYVM2v0RamCFS2Ey+hmaq6q9UdeDPPSWKTaG+VIUcjWkO+DUEpgfs+TDV6y84Aq
 ITpvUblEpZBrIMOqYLhNNCLI2NoIZyPWIGYB7ieLn9mB9XNFsWtiqOF39RxsGgdX1ofYwtTuC
 clcHShwilX1+r0KIxLTYFKMZZyhyv2K3dVXqP4w+kJqrebzdhWUIYLTRVOx1Hm+yu9rzY7vv7
 cqVzj9zdj/4Z2mjjX511EV24QZU6a4GQBk+AzNiXK1EsPjPVU25WTtC0yH6Bk+up0lk/Yqmc3
 gAan/iQWv+JD3VuwIwVLkNQXiehE/0jd+2uZp00R8q+U60i8+wa+X86UMhzbC6Nn41IOm0Xp0
 uJEWprNVFBTaZEWWZEux3rx9L1c=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/4/24 20:58, BALATON Zoltan wrote:
> On Thu, 4 Jan 2024, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> The physical hardware allows DIMMs of 4 MB size and above, allowing up
>> to 3840 MB of memory, but is restricted by setup code to 3 GB.
>> Increase the limit to allow up to the maximum amount of memory.
>>
>> Btw. the memory area from 0xf000.0000 to 0xffff.ffff is reserved by
>> the architecture for firmware and I/O memory and can not be used for
>> standard memory.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Noticed-by: Nelson H. F. Beebe <beebe@math.utah.edu>
>> Fixes: b7746b1194c8 ("hw/hppa/machine: Restrict the total memory size t=
o 3GB")
>> ---
>> hw/hppa/machine.c | 9 ++++++---
>> 1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>> index c8da7c18d5..6181f4b747 100644
>> --- a/hw/hppa/machine.c
>> +++ b/hw/hppa/machine.c
>> @@ -276,6 +276,7 @@ static TranslateFn *machine_HP_common_init_cpus(Mac=
hineState *machine)
>> =C2=A0=C2=A0=C2=A0 unsigned int smp_cpus =3D machine->smp.cpus;
>> =C2=A0=C2=A0=C2=A0 TranslateFn *translate;
>> =C2=A0=C2=A0=C2=A0 MemoryRegion *cpu_region;
>> +=C2=A0=C2=A0=C2=A0 ram_addr_t ram_max;
>>
>> =C2=A0=C2=A0=C2=A0 /* Create CPUs.=C2=A0 */
>> =C2=A0=C2=A0=C2=A0 for (unsigned int i =3D 0; i < smp_cpus; i++) {
>> @@ -288,8 +289,10 @@ static TranslateFn *machine_HP_common_init_cpus(Ma=
chineState *machine)
>> =C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0 if (hppa_is_pa20(&cpu[0]->env)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 translate =3D translate_pa20=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ram_max =3D 0xf0000000;=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3.75 GB (limited by 32-bit firmware) */
>> =C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 translate =3D translate_pa10=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ram_max =3D 0xf0000000;=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3.75 GB (32-bit CPU) */
>
> If the value is the same what's the point of setting it here and not
> once above at definition? It is's only the different comment then you
> could have a comment saying "3.75 GB, limited by 32-bit firmware on
> 64 bit CPU" or similar there.

Oh, sorry, I missed to explain it...

qemu already supports the 64-bit CPU (hppa64), but using more than
3.75 GB of RAM is limited because the 32-bit firmware (which is
currently shipped) only supports up to max. 4GB.
For more than 4GB, a 64-bit SeaBIOS-hppa firmware is needed.
The current SeaBIOS-hppa git tree already contains the code
to build the firmware with 64-bit support. It already boots up,
but I still need some more bug-fixing until it can be used.

So, keeping two different lines here helps to more easily test
the 64-bit firmware and the final commit to allow more than 4GB
will become a one-liner with an upcoming patch.

Helge

