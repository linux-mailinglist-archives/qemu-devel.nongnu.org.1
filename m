Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1475742226
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:30:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEn2K-00037E-J9; Thu, 29 Jun 2023 04:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEn2I-00036Y-7H; Thu, 29 Jun 2023 04:29:54 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEn2G-0004XB-8w; Thu, 29 Jun 2023 04:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=biDuv5j9mBW9ubk4T2rAMURItEC7soXYAGxIOyPrt6g=; b=Ruc1LRO4COUCP7XU1H5jKJp0iH
 Gw6LGfXADARBPBiujFs3c9ALaUuOHl7FfnhaeOi/oylGt34LXdUTHhXUV911o3LmvvHcxAIaI9DoT
 h5PDMbJtZ76sUwgPT2buQRa+n/jyICN9e9TRHm02hK2JGOvlCe30GUyOlV3/RlWQNqGR9JdgBVfLK
 DVM8nnKNHAyAdzBb2QgjULESxSYOC8yKK7E7XBvL5UnifSBLOq/Ipk/mDEF1Bthk5AT1L+qNEtm49
 9LlVWzgRD15/8Mz5A3b9ilJp6427lEmHOoiiN/3uLcvnfJEUOCCYUeXpvDhqLQ1OEY26pkmTNreR9
 PBQNz+uM07QkYq4NqGhsDOFRG7Q1GgQis80XcbYlTY3ipj6l5EmpwHk9Vw37L9p3evK6fwBOrqIJt
 nwERDqd+xjeKNVB4dqDH4NVhd5yjPc1gPrADpDnUBkRTNuOuJ0IOP96Sh1cPpAjYKU1ABiqEYvY4n
 SA6HJ4JU5FYsUAWhQ1uNKzpL+fH+P9fXh+zZ7zD/vXBA4HxyqWiCQk3oeRqzrj/8nFQuHIvpDFS1U
 IxuhSifc0kNWTaJHQuG7jrnG9NWaf7d3MGVfuw8Azh4kXckcwfFfjwdaEMgPQJA8Ljoyd6Kk6zTfj
 rXTILm9QBkLlwUI0le02zjGCgU5EjkK+oB6Ud5hOM=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEn1z-000AdA-D7; Thu, 29 Jun 2023 09:29:39 +0100
Message-ID: <bfbfafe6-1a28-8514-a3bb-cf289c7b7200@ilande.co.uk>
Date: Thu, 29 Jun 2023 09:29:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
 <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
 <cefdeb3f-3442-ede4-3e5d-6a4a99b38293@ilande.co.uk>
 <CABLmASF92ux10=D5MJ4Ax3FbCi4digWJajHy4VE1fNUL9bOJxA@mail.gmail.com>
 <8e3010d8-9ca7-c834-3348-e11060c53f8a@ilande.co.uk>
 <CABLmASFsWK9Bg_bo=kC9C_8EnLpoVJKtqg0ca8gv1YdrffQSAw@mail.gmail.com>
 <d9b7499f-f462-79b3-e9e8-25a14a3b538d@redhat.com>
 <840c34e7-0f5c-89fa-2dfa-f8de3da4d643@ilande.co.uk>
 <7e596b48-c631-34d5-2b63-0aac1922de93@kaod.org>
 <2bc2ca94-c1ba-a9de-0b81-6f9d3d4ad333@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <2bc2ca94-c1ba-a9de-0b81-6f9d3d4ad333@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 28/06/2023 08:17, Cédric Le Goater wrote:

>>>>> qemu-system-ppc.exe -M mac99,via=pmu -cdrom C:\mac-iso\9.2.2.iso -boot d -L pc-bios
>>>>> crashes Mac OS with an address error. (with unpatched and patched builds).
>>>>
>>>> Same on Linux. I get an invalid opcode. QEMU 7.2 work fine though.
>>>>
>>>> C.
>>>
>>> That certainly shouldn't happen, and if it worked in 7.2 then there's definitely a 
>>> regression which has crept in there somewhere. I'll try and bisect this at some 
>>> point soon, but feel free to try and beat me ;)
>>
>> bisect points to :
>>
>> commit e506ad6a05c806bbef460a7d014a184ff8d707a6
>> Author: Richard Henderson <richard.henderson@linaro.org>
>> Date:   Mon Mar 6 04:30:11 2023 +0300
>>
>>      accel/tcg: Pass last not end to tb_invalidate_phys_range
>>      Pass the address of the last byte to be changed, rather than
>>      the first address past the last byte.  This avoids overflow
>>      when the last page of the address space is involved.
>>      Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>>   include/exec/exec-all.h   |  2 +-
>>   accel/tcg/tb-maint.c      | 31 ++++++++++++++++---------------
>>   accel/tcg/translate-all.c |  2 +-
>>   accel/tcg/user-exec.c     |  2 +-
>>   softmmu/physmem.c         |  2 +-
>>   5 files changed, 20 insertions(+), 19 deletions(-)
>>
>>
>> I think the instruction is fnmadds. Needs more digging.
> 
> the invalid opcode is just a symptom of something bad happening.
> 
> C.

Indeed, it appears to be a copy/paste error within that commit. I've just posted a 
proposed fix for this: 
https://lore.kernel.org/qemu-devel/20230629082522.606219-1-mark.cave-ayland@ilande.co.uk/T/.

Nick: you may wish to try your series again with this fix applied to see if there are 
still problems with the CPUs used in the Mac machines.


ATB,

Mark.


