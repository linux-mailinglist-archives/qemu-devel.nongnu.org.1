Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C15749576
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 08:17:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHIHP-0000Ha-3x; Thu, 06 Jul 2023 02:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=00IJ=CY=kaod.org=clg@ozlabs.org>)
 id 1qHIHL-0000Fr-31; Thu, 06 Jul 2023 02:15:47 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=00IJ=CY=kaod.org=clg@ozlabs.org>)
 id 1qHIHI-0001Gc-AO; Thu, 06 Jul 2023 02:15:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QxR8z5GFdz4wxq;
 Thu,  6 Jul 2023 16:15:31 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QxR8x4BWKz4w24;
 Thu,  6 Jul 2023 16:15:29 +1000 (AEST)
Message-ID: <28800258-12d5-8908-cce7-c848dd2cef4d@kaod.org>
Date: Thu, 6 Jul 2023 08:15:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ppc/pnv: Set P10 core xscom region size to match hardware
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230705012736.20020-1-npiggin@gmail.com>
 <CACPK8XcsBt5ZQ=SRFd2+6OjRx4zM1gmcr12djiMugS9QTa6SGw@mail.gmail.com>
 <4b916a32-daf3-7081-af1a-c10c3ea26a40@kaod.org>
 <CACPK8XeLUOzviiT_8daqB2edCbLkBeeEB6HGMxboVTwcx9q2yA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CACPK8XeLUOzviiT_8daqB2edCbLkBeeEB6HGMxboVTwcx9q2yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=00IJ=CY=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 7/6/23 04:33, Joel Stanley wrote:
> On Wed, 5 Jul 2023 at 10:02, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 7/5/23 04:05, Joel Stanley wrote:
>>> On Wed, 5 Jul 2023 at 01:27, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>>
>>>> The P10 core xscom memory regions overlap because the size is wrong.
>>>> The P10 core+L2 xscom region size is allocated as 0x1000 (with some
>>>> unused ranges). "EC" is used as a closer match, as "EX" includes L3
>>>> which has a disjoint xscom range that would require a different
>>>> region if it were implemented.
>>>>
>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>
>>> Nice, that looks better:
>>>
>>> 0000000100000000-00000001000fffff (prio 0, i/o): xscom-quad.0: 0x100000
>>> 0000000100108000-000000010010ffff (prio 0, i/o): xscom-core.3: 0x8000
>>> 0000000100110000-0000000100117fff (prio 0, i/o): xscom-core.2: 0x8000
>>> 0000000100120000-0000000100127fff (prio 0, i/o): xscom-core.1: 0x8000
>>> 0000000100140000-0000000100147fff (prio 0, i/o): xscom-core.0: 0x8000
>>> 0000000108000000-00000001080fffff (prio 0, i/o): xscom-quad.4: 0x100000
>>> 0000000108108000-000000010810ffff (prio 0, i/o): xscom-core.7: 0x8000
>>> 0000000108110000-0000000108117fff (prio 0, i/o): xscom-core.6: 0x8000
>>> 0000000108120000-0000000108127fff (prio 0, i/o): xscom-core.5: 0x8000
>>> 0000000108140000-0000000108147fff (prio 0, i/o): xscom-core.4: 0x8000
>>>
>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>
>> It'd interesting to add some dummy SLW handlers to get rid of the
>> XSCOM errors at boot and shutdown on P10 :
>>
>> [ 4824.393446266,3] XSCOM: write error gcid=0x0 pcb_addr=0x200e883c stat=0x0
>> [ 4824.393588777,5] Unable to log error
>> [ 4824.393650582,3] XSCOM: Write failed, ret =  -6
>> [ 4824.394124623,3] Could not set special wakeup on 0:0: Unable to write QME_SPWU_HYP.
>> [ 4824.394368459,3] XSCOM: write error gcid=0x0 pcb_addr=0x200e883c stat=0x0
>> [ 4824.394382007,5] Unable to log error
>> [ 4824.394384603,3] XSCOM: Write failed, ret =  -6
> 
> Yes. I was looking at this yesterday. We need to figure out how to do
> the xscom addressing for the QME. It sets (different) bits in order to
> address a given core.>
>
> For a -smp 4 machine, the P10_QME_SPWU_HYP read comes in on these addresses:
> 
>      case 0x200e883c:
>      case 0x200e483c:
>      case 0x200e283c:
>      case 0x200e183c:
> 
> ie, the fourth nibble selects the core.
> 
> For a -smp 8 machine, the address now has bit 24 set to select the
> second quad, so we need to cover these addresses:
> 
>      case 0x210e883c:
>      case 0x210e483c:
>      case 0x210e283c:
>      case 0x210e183c:
> 
> I am thinking about how to map this into an address range that a model
> can claim.
  
OPAL should have the magic macros for XSCOM addresses. I included a few
in QEMU.

> Cheers,
> 
> Joel
> 
> PS. For reference, this is sufficient to silence xscom errors with
> skiboot and -M powernv10 -smp4. A different set of hacks is required
> for p9.
>

Thanks,

C.


> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -106,6 +106,26 @@ static uint64_t xscom_read_default(PnvChip *chip,
> uint32_t pcba)
>       case 0x401082a:
>       case 0x4010828:
>           return 0;
> +
> +    /* P10_QME_SPWU_HYP */
> +    case 0x200e883c:
> +    case 0x200e483c:
> +    case 0x200e283c:
> +    case 0x200e183c:
> +        return 0;
> +
> +    /* P10_QME_SSH_HYP */
> +    case 0x200e882c:
> +    case 0x200e482c:
> +    case 0x200e282c:
> +    case 0x200e182c:
> +        return 0;
> +
> +    /* XPEC_P10_PCI_CPLT_CONF1 */
> +    case 0x08000009:
> +    case 0x09000009:
> +        return 0;
> +
>       default:
>           return -1;
>       }
> @@ -152,6 +172,13 @@ static bool xscom_write_default(PnvChip *chip,
> uint32_t pcba, uint64_t val)
>       case PRD_P8_IPOLL_REG_STATUS:
>       case PRD_P9_IPOLL_REG_MASK:
>       case PRD_P9_IPOLL_REG_STATUS:
> +
> +    /* P10_QME_SPWU_HYP */
> +    case 0x200e883c:
> +    case 0x200e483c:
> +    case 0x200e283c:
> +    case 0x200e183c:
> +
>           return true;
>       default:
>           return false;


