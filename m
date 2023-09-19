Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C44F7A6790
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 17:06:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qicIL-0007Yv-LD; Tue, 19 Sep 2023 11:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UaPf=FD=kaod.org=clg@ozlabs.org>)
 id 1qicHs-0007Vv-08; Tue, 19 Sep 2023 11:05:16 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UaPf=FD=kaod.org=clg@ozlabs.org>)
 id 1qicHo-000846-A5; Tue, 19 Sep 2023 11:05:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RqlMR0mfJz4x2r;
 Wed, 20 Sep 2023 01:05:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RqlMN4BVgz4xG4;
 Wed, 20 Sep 2023 01:05:04 +1000 (AEST)
Message-ID: <a9e0f6f8-d7c1-c817-2e42-be9c8cccfd6c@kaod.org>
Date: Tue, 19 Sep 2023 17:05:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/8] spapr: Clean up local variable shadowing in
 spapr_dt_cpus()
Content-Language: en-US
To: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-4-clg@kaod.org>
 <56a18122-ed29-ddc5-03f7-6e539a9f46f2@linux.ibm.com>
 <78e09b46-cf41-91d7-d518-519c12ca4b43@kaod.org>
 <CAEuJdmpsG_SEpBcb33-NJKtYr2WNqNaKrKMsfAOQtiRg8NxFJA@mail.gmail.com>
 <CAEuJdmrbS2Jh6_zOQX=3EtN0xjHFQt3wGtHHnsh7CfvBt-1RCQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CAEuJdmrbS2Jh6_zOQX=3EtN0xjHFQt3wGtHHnsh7CfvBt-1RCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=UaPf=FD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.473, SPF_HELO_PASS=-0.001,
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

On 9/19/23 16:59, Harsh Prateek Bora wrote:
> 
> 
> On Tue, 19 Sept, 2023, 6:34 pm Harsh Prateek Bora, <harsh.prateek.bora@gmail.com <mailto:harsh.prateek.bora@gmail.com>> wrote:
> 
> 
> 
>     On Tue, 19 Sept, 2023, 4:37 pm Cédric Le Goater, <clg@kaod.org <mailto:clg@kaod.org>> wrote:
> 
>         On 9/19/23 09:28, Harsh Prateek Bora wrote:
>          >
>          >
>          > On 9/18/23 20:28, Cédric Le Goater wrote:
>          >> Introduce a helper routine defining one CPU device node to fix this
>          >> warning :
>          >>
>          >>    ../hw/ppc/spapr.c: In function ‘spapr_dt_cpus’:
>          >>    ../hw/ppc/spapr.c:812:19: warning: declaration of ‘cs’ shadows a previous local [-Wshadow=compatible-local]
>          >>      812 |         CPUState *cs = rev[i];
>          >>          |                   ^~
>          >>    ../hw/ppc/spapr.c:786:15: note: shadowed declaration is here
>          >>      786 |     CPUState *cs;
>          >>          |               ^~
>          >>
>          >> Signed-off-by: Cédric Le Goater <clg@kaod.org <mailto:clg@kaod.org>>
>          >> ---
>          >>   hw/ppc/spapr.c | 36 +++++++++++++++++++++---------------
>          >>   1 file changed, 21 insertions(+), 15 deletions(-)
>          >>
>          >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>          >> index de3c616b4637..d89f0fd496b6 100644
>          >> --- a/hw/ppc/spapr.c
>          >> +++ b/hw/ppc/spapr.c
>          >> @@ -780,6 +780,26 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
>          >>                                 pcc->lrg_decr_bits)));
>          >>   }
>          >> +static void spapr_dt_one_cpu(void *fdt, SpaprMachineState *spapr, CPUState *cs,
>          >> +                             int cpus_offset)
>          >> +{
>          >> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
>          >> +    int index = spapr_get_vcpu_id(cpu);
>          >> +    DeviceClass *dc = DEVICE_GET_CLASS(cs);
>          >> +    g_autofree char *nodename = NULL;
>          >> +    int offset;
>          >> +
>          >> +    if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
>          >> +        return;
>          >> +    }
>          >> +
>          >> +    nodename = g_strdup_printf("%s@%x", dc->fw_name, index);
>          >> +    offset = fdt_add_subnode(fdt, cpus_offset, nodename);
>          >> +    _FDT(offset);
>          >> +    spapr_dt_cpu(cs, fdt, offset, spapr);
>          >> +}
>          >> +
>          >> +
>          >>   static void spapr_dt_cpus(void *fdt, SpaprMachineState *spapr)
>          >>   {
>          >>       CPUState **rev;
>          >> @@ -809,21 +829,7 @@ static void spapr_dt_cpus(void *fdt, SpaprMachineState *spapr)
>          >>       }
>          >>       for (i = n_cpus - 1; i >= 0; i--) {
>          >> -        CPUState *cs = rev[i];
>          >> -        PowerPCCPU *cpu = POWERPC_CPU(cs);
>          >> -        int index = spapr_get_vcpu_id(cpu);
>          >> -        DeviceClass *dc = DEVICE_GET_CLASS(cs);
>          >> -        g_autofree char *nodename = NULL;
>          >> -        int offset;
>          >> -
>          >> -        if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
>          >> -            continue;
>          >> -        }
>          >> -
>          >> -        nodename = g_strdup_printf("%s@%x", dc->fw_name, index);
>          >> -        offset = fdt_add_subnode(fdt, cpus_offset, nodename);
>          >> -        _FDT(offset);
>          >> -        spapr_dt_cpu(cs, fdt, offset, spapr);
>          >> +        spapr_dt_one_cpu(fdt, spapr, rev[i], cpus_offset);
>          >
>          > Do we want to replace the call to spapr_dt_cpu in
>          > spapr_core_dt_populate() with the _one_ as well?
>          > Not sure about the implication of additional instructions there.
> 
>         yeah may be we could rework spapr_dt_one_cpu() and spapr_core_dt_populate()
>         in a single routine. They are similar. It can come later.
> 
>          > Also, could this code insider wrapper become part of spapr_dt_cpu() itself?
>          > If can't, do we want a better renaming of wrapper here?
> 
>         I am open to proposal :)
> 
> 
>     How about spapr_dt_cpu_prepare() ?
> 
> 
> I guess spapr_dt_cpu_process() may be more apt since it calls the spapr_dt_cpu internally.

*_one_* is a common qualifier in QEMU and Linux routine names.

C.

> 
> 
> 
>         Thanks
> 
>         C.
> 
> 
>          >
>          > Otherwise,
>          > Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com <mailto:harshpb@linux.ibm.com>>
>          >
>          >>       }
>          >>       g_free(rev);
> 
> 


