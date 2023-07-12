Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D311750CF3
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 17:46:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJc2M-0003IN-AF; Wed, 12 Jul 2023 11:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sanastasio@raptorengineering.com>)
 id 1qJc2K-0003I7-UV; Wed, 12 Jul 2023 11:45:53 -0400
Received: from mail.raptorengineering.com ([23.155.224.40]
 helo=raptorengineering.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sanastasio@raptorengineering.com>)
 id 1qJc2J-0004hQ-6N; Wed, 12 Jul 2023 11:45:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 67A8A8285707;
 Wed, 12 Jul 2023 10:45:49 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Gvj5VO_O1PQL; Wed, 12 Jul 2023 10:45:47 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 606008285721;
 Wed, 12 Jul 2023 10:45:47 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 606008285721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
 t=1689176747; bh=AOZEurO6K9VkGRa66+4og1/0LcqRiD7/NW1LyXoBCAE=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=Yw2XHJfTjD26F6EDKM+QbPp5XCdNt94Vzqp+eVxiQTOXuOol8aYkowUIcFFWMlZBq
 5tRAaxf0GrVKBKAzA0Ti+7pRZrgmfxXm+0Won5d1N5OoDMYsdQcZzcjk8OfWuculvF
 1L8JwDtmvPIDF/kuD7vywl93tikzW6avSuqZFaQc=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id vRbZ-beCTj6z; Wed, 12 Jul 2023 10:45:47 -0500 (CDT)
Received: from [10.11.0.2] (5.edge.rptsys.com [23.155.224.38])
 by mail.rptsys.com (Postfix) with ESMTPSA id CA0EE8285707;
 Wed, 12 Jul 2023 10:45:46 -0500 (CDT)
Message-ID: <62f4a255-c577-8086-ecc6-aabd11d9230b@raptorengineering.com>
Date: Wed, 12 Jul 2023 10:45:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] target/ppc: Generate storage interrupts for radix RC
 changes
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Timothy Pearson <tpearson@raptorengineering.com>
References: <20230711222405.2712188-1-sanastasio@raptorengineering.com>
 <f89abc5c-6356-1124-b6be-7cdb0c3e280c@kaod.org>
From: Shawn Anastasio <sanastasio@raptorengineering.com>
In-Reply-To: <f89abc5c-6356-1124-b6be-7cdb0c3e280c@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=23.155.224.40;
 envelope-from=sanastasio@raptorengineering.com; helo=raptorengineering.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi C=C3=A9dric,

On 7/12/23 3:27 AM, C=C3=A9dric Le Goater wrote:
> Hello Shawn,
>=20
> On 7/12/23 00:24, Shawn Anastasio wrote:
>> Change radix64_set_rc to always generate a storage interrupt when the
>> R/C bits are not set appropriately instead of setting the bits itself.
>> According to the ISA both behaviors are valid, but in practice this
>> change more closely matches behavior observed on the POWER9 CPU.
>>
>>  From the POWER9 Processor User's Manual, Section 4.10.13.1: "When
>> performing Radix translation, the POWER9 hardware triggers the
>> appropriate interrupt ... for the mode and type of access whenever
>> Reference (R) and Change (C) bits require setting in either the guest =
or
>> host page-table entry (PTE)."
>>
>> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
>> ---
>>   target/ppc/mmu-radix64.c | 57 ++++++++++++++++++++++++++++----------=
--
>>   1 file changed, 40 insertions(+), 17 deletions(-)
>>
>> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
>> index 920084bd8f..06e1cced31 100644
>> --- a/target/ppc/mmu-radix64.c
>> +++ b/target/ppc/mmu-radix64.c
>> @@ -219,27 +219,48 @@ static bool ppc_radix64_check_prot(PowerPCCPU
>> *cpu, MMUAccessType access_type,
>>       return false;
>>   }
>>   -static void ppc_radix64_set_rc(PowerPCCPU *cpu, MMUAccessType
>> access_type,
>> -                               uint64_t pte, hwaddr pte_addr, int *pr=
ot)
>> +static int ppc_radix64_check_rc(PowerPCCPU *cpu, MMUAccessType
>> access_type,
>> +                               uint64_t pte, vaddr eaddr, bool
>> partition_scoped,
>> +                               hwaddr g_raddr)
>>   {
>> -    CPUState *cs =3D CPU(cpu);
>> -    uint64_t npte;
>> +    uint64_t lpid =3D 0;
>> +    uint64_t pid =3D 0;
>>   -    npte =3D pte | R_PTE_R; /* Always set reference bit */
>> +    switch (access_type) {
>> +    case MMU_DATA_STORE:
>> +        if (!(pte & R_PTE_C)) {
>> +            break;
>> +        }
>> +        /* fall through */
>> +    case MMU_INST_FETCH:
>> +    case MMU_DATA_LOAD:
>> +        if (!(pte & R_PTE_R)) {
>> +            break;
>> +        }
>>   -    if (access_type =3D=3D MMU_DATA_STORE) { /* Store/Write */
>> -        npte |=3D R_PTE_C; /* Set change bit */
>> -    } else {
>> -        /*
>> -         * Treat the page as read-only for now, so that a later write
>> -         * will pass through this function again to set the C bit.
>> -         */
>> -        *prot &=3D ~PAGE_WRITE;
>> +        /* R/C bits are already set appropriately for this access */
>> +        return 0;
>>       }
>>   -    if (pte ^ npte) { /* If pte has changed then write it back */
>> -        stq_phys(cs->as, pte_addr, npte);
>> +    /* Obtain effLPID */
>> +    (void)ppc_radix64_get_fully_qualified_addr(&cpu->env, eaddr,
>> &lpid, &pid);
>> +
>> +    /*
>> +     * Per ISA 3.1 Book III, 7.5.3 and 7.5.5, failure to set R/C duri=
ng
>> +     * partition-scoped translation when effLPID =3D 0 results in nor=
mal
>> +     * (non-Hypervisor) Data and Instruction Storage Interrupts
>> respectively.
>> +     *
>> +     * ISA 3.0 is ambiguous about this, but tests on POWER9 hardware
>> seem to
>> +     * exhibit the same behavior.
>> +     */
>> +    if (partition_scoped && lpid > 0) {
>> +        ppc_radix64_raise_hsi(cpu, access_type, eaddr, g_raddr,
>> +                              DSISR_ATOMIC_RC);
>> +    } else {
>> +        ppc_radix64_raise_si(cpu, access_type, eaddr, DSISR_ATOMIC_RC=
);
>>       }
>=20
> I would raise the exception in the callers :
>=20
>   ppc_radix64_partition_scoped_xlate()
>   ppc_radix64_process_scoped_xlate()
>=20
> lpid could be passed to these routines also, this to avoid the call to
> ppc_radix64_get_fully_qualified_addr().
>=20
> This requires a little more changes but would be cleaner I think.

Sure, I can do that. I'll send a v2 with this change made.

> Thanks,
>=20
> C.

Thanks,
Shawn

