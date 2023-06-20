Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE3C736AD6
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:21:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZQ0-00018X-EE; Tue, 20 Jun 2023 07:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rj0j=CI=kaod.org=clg@ozlabs.org>)
 id 1qBZPr-00016S-Ti; Tue, 20 Jun 2023 07:20:56 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rj0j=CI=kaod.org=clg@ozlabs.org>)
 id 1qBZPp-0007ru-Pp; Tue, 20 Jun 2023 07:20:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qlkhb5Vmhz4x0G;
 Tue, 20 Jun 2023 21:20:47 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QlkhY6852z4wjC;
 Tue, 20 Jun 2023 21:20:45 +1000 (AEST)
Message-ID: <4ad1a081-bf98-1b7d-05c9-82c230da34ce@kaod.org>
Date: Tue, 20 Jun 2023 13:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 05/29] pnv/xive2: Handle TIMA access through all ports
To: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, 
 Frederic Barrat <fbarrat@linux.ibm.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
 <20230610133132.290703-6-danielhb413@gmail.com>
 <CAFEAcA_KKSc=Ns9n1UJKdnhZ846EGK-nFbsG_e2mw_zwMoOJcw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CAFEAcA_KKSc=Ns9n1UJKdnhZ846EGK-nFbsG_e2mw_zwMoOJcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=rj0j=CI=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 6/20/23 12:45, Peter Maydell wrote:
> On Sat, 10 Jun 2023 at 14:31, Daniel Henrique Barboza
> <danielhb413@gmail.com> wrote:
>>
>> From: Frederic Barrat <fbarrat@linux.ibm.com>
>>
>> The Thread Interrupt Management Area (TIMA) can be accessed through 4
>> ports, targeted by the address. The base address of a TIMA
>> is using port 0 and the other ports are 0x80 apart. Using one port or
>> another can be useful to balance the load on the snoop buses. With
>> skiboot and linux, we currently use port 0, but as it tends to be
>> busy, another hypervisor is using port 1 for TIMA access.
>>
>> The port address bits fall in between the special op indication
>> bits (the 2 MSBs) and the register offset bits (the 6 LSBs). They are
>> "don't care" for the hardware when processing a TIMA operation. This
>> patch filters out those port address bits so that a TIMA operation can
>> be triggered using any port.
>>
>> It is also true for indirect access (through the IC BAR) and it's
>> actually nothing new, it was already the case on P9. Which helps here,
>> as the TIMA handling code is common between P9 (xive) and P10 (xive2).
>>
>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>> Message-Id: <20230601121331.487207-6-fbarrat@linux.ibm.com>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
> 
> Hi -- Coverity points out that there's a problem with this
> change (CID 1512997, 1512998):
> 
>> --- a/hw/intc/pnv_xive2.c
>> +++ b/hw/intc/pnv_xive2.c
>> @@ -1662,6 +1662,8 @@ static void pnv_xive2_tm_write(void *opaque, hwaddr offset,
>>       bool gen1_tima_os =
>>           xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
>>
>> +    offset &= TM_ADDRESS_MASK;
> 
> Here we now mask off most of the bytes of 'offset',
> because TM_ADDRESS_MASK is 0xC3F...
> 
>> +
>>       /* TODO: should we switch the TM ops table instead ? */
>>       if (!gen1_tima_os && offset == HV_PUSH_OS_CTX_OFFSET) {
> 
> ...but here we compare offset against HV_PUSH_OS_CTX_OFFSET,
> which is defined as
> #define HV_PUSH_OS_CTX_OFFSET  (HV_PAGE_OFFSET | (TM_QW1_OS + TM_WORD2))
> and since
> #define HV_PAGE_OFFSET         (XIVE_TM_HV_PAGE << TM_SHIFT)
> #define XIVE_TM_HV_PAGE         0x1
> #define TM_SHIFT                16
> 
> that means HV_PUSH_OS_CTX_OFFSET has bits defined in the
> upper 16 bits, and the comparison can now never be true,
> making the if() dead code.
> 
>>           xive2_tm_push_os_ctx(xptr, tctx, offset, value, size);
>> @@ -1681,6 +1683,8 @@ static uint64_t pnv_xive2_tm_read(void *opaque, hwaddr offset, unsigned size)
>>       bool gen1_tima_os =
>>           xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
>>
>> +    offset &= TM_ADDRESS_MASK;
>> +
>>       /* TODO: should we switch the TM ops table instead ? */
>>       if (!gen1_tima_os && offset == HV_PULL_OS_CTX_OFFSET) {
>>           return xive2_tm_pull_os_ctx(xptr, tctx, offset, size);
> 
> Similarly here.


yes. I think this went unnoticed because the push/pull os context
commands are only used by the HV when a vCPU is dipatched on a HW
thread. We would need a test for a KVM guest running under the QEMU
PowerNV POWER10 machine. This requires an image with some tuning
because emulation is a bit slow. I use to have a buildroot image
including a qemu and smaller buildroot image for it.

So, offset is within the full TIMA region (4 pages) and
TM_ADDRESS_MASK is a mask within a page. This needs a fix.

Thanks,

C.


