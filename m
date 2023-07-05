Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A48B7481A6
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 12:03:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGzLm-0001s3-AI; Wed, 05 Jul 2023 06:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=c5xU=CX=kaod.org=clg@ozlabs.org>)
 id 1qGzLh-0001jM-Tc; Wed, 05 Jul 2023 06:03:01 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=c5xU=CX=kaod.org=clg@ozlabs.org>)
 id 1qGzLe-0004Uq-Sz; Wed, 05 Jul 2023 06:03:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QwwFn4kKjz4wqX;
 Wed,  5 Jul 2023 20:02:53 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QwwFl3Dq6z4wZv;
 Wed,  5 Jul 2023 20:02:51 +1000 (AEST)
Message-ID: <4b916a32-daf3-7081-af1a-c10c3ea26a40@kaod.org>
Date: Wed, 5 Jul 2023 12:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ppc/pnv: Set P10 core xscom region size to match hardware
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230705012736.20020-1-npiggin@gmail.com>
 <CACPK8XcsBt5ZQ=SRFd2+6OjRx4zM1gmcr12djiMugS9QTa6SGw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CACPK8XcsBt5ZQ=SRFd2+6OjRx4zM1gmcr12djiMugS9QTa6SGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=c5xU=CX=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 7/5/23 04:05, Joel Stanley wrote:
> On Wed, 5 Jul 2023 at 01:27, Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> The P10 core xscom memory regions overlap because the size is wrong.
>> The P10 core+L2 xscom region size is allocated as 0x1000 (with some
>> unused ranges). "EC" is used as a closer match, as "EX" includes L3
>> which has a disjoint xscom range that would require a different
>> region if it were implemented.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Nice, that looks better:
> 
> 0000000100000000-00000001000fffff (prio 0, i/o): xscom-quad.0: 0x100000
> 0000000100108000-000000010010ffff (prio 0, i/o): xscom-core.3: 0x8000
> 0000000100110000-0000000100117fff (prio 0, i/o): xscom-core.2: 0x8000
> 0000000100120000-0000000100127fff (prio 0, i/o): xscom-core.1: 0x8000
> 0000000100140000-0000000100147fff (prio 0, i/o): xscom-core.0: 0x8000
> 0000000108000000-00000001080fffff (prio 0, i/o): xscom-quad.4: 0x100000
> 0000000108108000-000000010810ffff (prio 0, i/o): xscom-core.7: 0x8000
> 0000000108110000-0000000108117fff (prio 0, i/o): xscom-core.6: 0x8000
> 0000000108120000-0000000108127fff (prio 0, i/o): xscom-core.5: 0x8000
> 0000000108140000-0000000108147fff (prio 0, i/o): xscom-core.4: 0x8000
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>

It'd interesting to add some dummy SLW handlers to get rid of the
XSCOM errors at boot and shutdown on P10 :

[ 4824.393446266,3] XSCOM: write error gcid=0x0 pcb_addr=0x200e883c stat=0x0
[ 4824.393588777,5] Unable to log error
[ 4824.393650582,3] XSCOM: Write failed, ret =  -6
[ 4824.394124623,3] Could not set special wakeup on 0:0: Unable to write QME_SPWU_HYP.
[ 4824.394368459,3] XSCOM: write error gcid=0x0 pcb_addr=0x200e883c stat=0x0
[ 4824.394382007,5] Unable to log error
[ 4824.394384603,3] XSCOM: Write failed, ret =  -6

Thanks,

C.

> 
> 
>> ---
>>   hw/ppc/pnv_core.c          | 3 +--
>>   include/hw/ppc/pnv_xscom.h | 2 +-
>>   2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
>> index b7223bb445..ffbc29cbf4 100644
>> --- a/hw/ppc/pnv_core.c
>> +++ b/hw/ppc/pnv_core.c
>> @@ -299,9 +299,8 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
>>       }
>>
>>       snprintf(name, sizeof(name), "xscom-core.%d", cc->core_id);
>> -    /* TODO: check PNV_XSCOM_EX_SIZE for p10 */
>>       pnv_xscom_region_init(&pc->xscom_regs, OBJECT(dev), pcc->xscom_ops,
>> -                          pc, name, PNV_XSCOM_EX_SIZE);
>> +                          pc, name, PNV10_XSCOM_EC_SIZE);
>>
>>       qemu_register_reset(pnv_core_reset, pc);
>>       return;
>> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
>> index f7da9a1dc6..a4c9d95dc5 100644
>> --- a/include/hw/ppc/pnv_xscom.h
>> +++ b/include/hw/ppc/pnv_xscom.h
>> @@ -133,7 +133,7 @@ struct PnvXScomInterfaceClass {
>>
>>   #define PNV10_XSCOM_EC_BASE(core) \
>>       ((uint64_t) PNV10_XSCOM_EQ_BASE(core) | PNV10_XSCOM_EC(core & 0x3))
>> -#define PNV10_XSCOM_EC_SIZE        0x100000
>> +#define PNV10_XSCOM_EC_SIZE        0x1000
>>
>>   #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
>>   #define PNV10_XSCOM_PSIHB_SIZE     0x100
>> --
>> 2.40.1
>>


