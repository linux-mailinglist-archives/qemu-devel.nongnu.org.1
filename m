Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33696A2AA5E
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Feb 2025 14:51:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg2GK-0005yf-3s; Thu, 06 Feb 2025 08:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tg2GH-0005xP-RK; Thu, 06 Feb 2025 08:49:46 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tg2GE-0003RN-Og; Thu, 06 Feb 2025 08:49:44 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A71724E6014;
 Thu, 06 Feb 2025 14:49:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id LKvwC01mFm39; Thu,  6 Feb 2025 14:49:38 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 64F1E4E6013; Thu, 06 Feb 2025 14:49:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6372E74577D;
 Thu, 06 Feb 2025 14:49:38 +0100 (CET)
Date: Thu, 6 Feb 2025 14:49:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Bernhard Beschow <shentey@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: Re: [PATCH] hw/sd/sdhci: Set reset value of interrupt registers
In-Reply-To: <800dcc1b-8bf6-48e5-843a-99e630d4b494@linaro.org>
Message-ID: <bd8e216d-df13-4842-9a5a-5f274237359c@eik.bme.hu>
References: <20250115190422.5F0FA4E6030@zero.eik.bme.hu>
 <8cbad5be-e67b-46bd-9198-f7c90ad5ff56@linaro.org>
 <cc92e02b-c20d-974e-8b6d-bb30ea5af452@eik.bme.hu>
 <800dcc1b-8bf6-48e5-843a-99e630d4b494@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-561812885-1738849778=:22970"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-561812885-1738849778=:22970
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 6 Feb 2025, Philippe Mathieu-Daudé wrote:
> On 6/2/25 13:49, BALATON Zoltan wrote:
>> On Thu, 6 Feb 2025, Philippe Mathieu-Daudé wrote:
>>> On 15/1/25 20:04, BALATON Zoltan wrote:
>>>> The interrupt enable registers are not reset to 0 but some bits are
>>>> enabled on reset. At least some U-Boot versions seem to expect this
>>>> and not initialise these registers before expecting interrupts. The
>>>> numbers in this patch match what QorIQ P1022 has on reset and fix
>>>> U-Boot for this SoC and should not break other drivers that initialise
>>>> (and thus overwrite) these reset values.
>>>> 
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>> I've also noticed that the work around marked with an XXX comment near
>>>> line 600 breaks the U-Boot I've tested so I need to disable it:
>>>> if ((s->sdmasysad % boundary_chk) == 0) {
>>>> -        page_aligned = true;
>>>> +//        page_aligned = true;
>>>> }
>>>> What should this hack fix and could it be now removed or somehow
>>>> restricted to cases where it's needed?
>>> 
>>> Cc'ing Jamin for
>>> https://lore.kernel.org/qemu-devel/20241213031205.641009-2- 
>>> jamin_lin@aspeedtech.com/
>>> 
>>>> 
>>>> hw/sd/sdhci.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>> 
>>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>>> index 58375483e3..88eb0bfcb2 100644
>>>> --- a/hw/sd/sdhci.c
>>>> +++ b/hw/sd/sdhci.c
>>>> @@ -303,6 +303,8 @@ static void sdhci_reset(SDHCIState *s)
>>>>       s->data_count = 0;
>>>>       s->stopped_state = sdhc_not_stopped;
>>>>       s->pending_insert_state = false;
>>>> +    s->norintstsen = 0x013f;
>>>> +    s->errintstsen = 0x117f;
>>> 
>>> I guess the problem is earlier:
>>> 
>>>    /*
>>>     * Set all registers to 0. Capabilities/Version registers are not 
>>> cleared
>>>     * and assumed to always preserve their value, given to them during
>>>     * initialization
>>>     */
>>>    memset(&s->sdmasysad, 0, (uintptr_t)&s->capareg - (uintptr_t)&s- 
>>> >sdmasysad);
>>> 
>>> Not all registers have to be reset.
>> 
>> Nothing seems to program those registers before reset but the reset values 
>> are documented (for Freescale eSDHCI) to be the above so just not zeroing 
>> them does not seem to be enough. Bernhard has similar patch in his branch, 
>> not sure if he came up with that separately or took this one. Do you have 
>> some docs on which regs should not be reset?
>
> The header precises what is being modeled here:
>
> * SD Association Host Standard Specification v2.0 controller emulation
> *
> * Datasheet: PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.pdf
>
> I can not see the reset values you mentioned there.
>
> What is wrong with adding a TYPE_FREESCALE_ESDHC, like the
> TYPE_IMX_USDHC / TYPE_S3C_SDHCI types? Then you can add your
> reset handler fixing your fields after sdhci_poweron_reset().

Nothing's wrong with that, I just did not notice those existing variants. 
Maybe that's the way to go then with this too. Bernhard, do you plan to do 
that when cleaning up your tree or should I do another version?

Regards,
BALATON Zoltan
--3866299591-561812885-1738849778=:22970--

