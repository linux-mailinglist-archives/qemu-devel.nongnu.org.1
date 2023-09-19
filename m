Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 008B07A61F6
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 14:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiZQy-00035h-CR; Tue, 19 Sep 2023 08:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UaPf=FD=kaod.org=clg@ozlabs.org>)
 id 1qiZQo-00033L-TM; Tue, 19 Sep 2023 08:02:22 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UaPf=FD=kaod.org=clg@ozlabs.org>)
 id 1qiZQk-0000wf-Fw; Tue, 19 Sep 2023 08:02:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RqgJG4Pksz4xNs;
 Tue, 19 Sep 2023 22:02:06 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RqgJD3CF2z4wy6;
 Tue, 19 Sep 2023 22:02:04 +1000 (AEST)
Message-ID: <0f407c08-fb59-4a41-e134-4f184b5ec758@kaod.org>
Date: Tue, 19 Sep 2023 14:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/8] spapr/drc: Clean up local variable shadowing in
 rtas_ibm_configure_connector()
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-7-clg@kaod.org>
 <9e061471-931c-daf8-ab8f-567ce99f5057@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <9e061471-931c-daf8-ab8f-567ce99f5057@linux.ibm.com>
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

On 9/19/23 10:29, Harsh Prateek Bora wrote:
> 
> 
> On 9/18/23 20:28, Cédric Le Goater wrote:
>> Remove extra 'drc_index' variable to avoid this warning :
>>
>>    ../hw/ppc/spapr_drc.c: In function ‘rtas_ibm_configure_connector’:
>>    ../hw/ppc/spapr_drc.c:1240:26: warning: declaration of ‘drc_index’ shadows a previous local [-Wshadow=compatible-local]
>>     1240 |                 uint32_t drc_index = spapr_drc_index(drc);
>>          |                          ^~~~~~~~~
>>    ../hw/ppc/spapr_drc.c:1155:14: note: shadowed declaration is here
>>     1155 |     uint32_t drc_index;
>>          |              ^~~~~~~~~
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/ppc/spapr_drc.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
>> index b5c400a94d1c..843e318312d3 100644
>> --- a/hw/ppc/spapr_drc.c
>> +++ b/hw/ppc/spapr_drc.c
>> @@ -1237,8 +1237,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
>>           case FDT_END_NODE:
>>               drc->ccs_depth--;
>>               if (drc->ccs_depth == 0) {
>> -                uint32_t drc_index = spapr_drc_index(drc);
>> -
> I guess you only wanted to remove re-declaration part. Assigning the value returned by this function doesnt seem to happen before.

drc_index is assigned at the top of this large routine with :

     drc_index = rtas_ld(wa_addr, 0);
     drc = spapr_drc_by_index(drc_index);


So, the extra local variable 'drc_index' is simply redundant because
there are no reason for it to change. The drc object is the same AFAICT.
Correct ? I should have explained that better in the commit log.

Thanks,

C.


> 
>>                   /* done sending the device tree, move to configured state */
>>                   trace_spapr_drc_set_configured(drc_index);
>>                   drc->state = drck->ready_state;


