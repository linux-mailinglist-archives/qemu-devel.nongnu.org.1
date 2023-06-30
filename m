Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CC6743AEA
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 13:34:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFCOO-0002Nl-Tw; Fri, 30 Jun 2023 07:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1qFCOJ-0002Mt-1E
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:34:19 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1qFCOH-0008Pf-Bt
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:34:18 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 37185A00F0; Fri, 30 Jun 2023 13:25:06 +0200 (CEST)
Date: Fri, 30 Jun 2023 13:25:06 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 richard.henderson@linaro.org, clegoate@redhat.com, hsp.cat7@gmail.com, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] accel/tcg: add assert() check in
 tb_invalidate_phys_page_range__locked()
In-Reply-To: <8a4605f1-fb1e-2243-5dff-bf1c33e11360@tls.msk.ru>
Message-ID: <alpine.LMD.2.03.2306301320540.12314@eik.bme.hu>
References: <20230629082522.606219-1-mark.cave-ayland@ilande.co.uk>
 <20230629082522.606219-3-mark.cave-ayland@ilande.co.uk>
 <8a4605f1-fb1e-2243-5dff-bf1c33e11360@tls.msk.ru>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Received-SPF: none client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 30 Jun 2023, Michael Tokarev wrote:
> 29.06.2023 11:25, Mark Cave-Ayland wrote:
>> Add an assert() check in tb_invalidate_phys_page_range__locked() to ensure 
>> that
>> both the start and last addresses are within the same target page. Note 
>> that
>> due to performance concerns the check is only enabled when QEMU is 
>> configured
>> with --enable-debug-tcg.
>
> Performance concerns? That's two ANDs and on compare, - is it really that 
> performance
> critical?
>
> I'm just asking, I dunno.

If something is called frequently enough any small computaion can add up. 
In this case invalidating pages is probably a performance hit already and 
hopefully does not happen too often but then it's a good idea not to make 
it worse. As this is not something that should or could normally happen 
and only checks for programming errors I think it's good idea to only do 
it when debugging.

Regards,
BALATON Zoltan

> Thanks,
>
> /mjt
>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   accel/tcg/tb-maint.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>> 
>> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
>> index 33ea1aadd1..8cd730dcb0 100644
>> --- a/accel/tcg/tb-maint.c
>> +++ b/accel/tcg/tb-maint.c
>> @@ -1092,6 +1092,10 @@ tb_invalidate_phys_page_range__locked(struct 
>> page_collection *pages,
>>       TranslationBlock *current_tb = retaddr ? tcg_tb_lookup(retaddr) : 
>> NULL;
>>   #endif /* TARGET_HAS_PRECISE_SMC */
>>   +#ifdef CONFIG_DEBUG_TCG
>> +    assert((last & TARGET_PAGE_MASK) == (start & TARGET_PAGE_MASK));
>> +#endif
>> +
>>       /*
>>        * We remove all the TBs in the range [start, last].
>>        * XXX: see if in some cases it could be faster to invalidate all the 
>> code
>
>
>

