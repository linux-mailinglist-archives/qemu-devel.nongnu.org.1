Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DAF7A6215
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 14:08:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiZWH-0006IK-4z; Tue, 19 Sep 2023 08:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UaPf=FD=kaod.org=clg@ozlabs.org>)
 id 1qiZWF-0006I8-Ba; Tue, 19 Sep 2023 08:07:55 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UaPf=FD=kaod.org=clg@ozlabs.org>)
 id 1qiZWD-0002JA-G9; Tue, 19 Sep 2023 08:07:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RqgQr4PWmz4xNt;
 Tue, 19 Sep 2023 22:07:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RqgQp3Zhnz4xPN;
 Tue, 19 Sep 2023 22:07:46 +1000 (AEST)
Message-ID: <e5480b29-a1d0-8d6f-54b7-a8957f568ed9@kaod.org>
Date: Tue, 19 Sep 2023 14:07:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 8/8] spapr/drc: Clean up local variable shadowing in
 prop_get_fdt()
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-9-clg@kaod.org>
 <660b5c89-d219-1e20-9fa5-1b7c390a2f1b@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <660b5c89-d219-1e20-9fa5-1b7c390a2f1b@linux.ibm.com>
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

On 9/19/23 10:48, Harsh Prateek Bora wrote:
> 
> 
> On 9/18/23 20:28, Cédric Le Goater wrote:
>> Rename 'name' variable to avoid this warning :
>>
>>    ../hw/ppc/spapr_drc.c: In function ‘prop_get_fdt’:
>>    ../hw/ppc/spapr_drc.c:344:21: warning: declaration of ‘name’ shadows a parameter [-Wshadow=compatible-local]
>>      344 |         const char *name = NULL;
>>          |                     ^~~~
>>    ../hw/ppc/spapr_drc.c:325:63: note: shadowed declaration is here
>>      325 | static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
>>          |                                                   ~~~~~~~~~~~~^~~~
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/ppc/spapr_drc.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
>> index 843e318312d3..2b99d3b4b1a6 100644
>> --- a/hw/ppc/spapr_drc.c
>> +++ b/hw/ppc/spapr_drc.c
>> @@ -341,7 +341,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
>>       fdt_depth = 0;
>>       do {
>> -        const char *name = NULL;
>> +        const char *dt_name = NULL;
> 
> I guess you wanted to use the input arg "name" here without re-declaration. 

I don't understand. I don't want to use the input arg "name" here.
It seems useless in this case.

C.

> I do not see "name" being used elsewhere in this routine.
> 
> regards,
> Harsh
>>           const struct fdt_property *prop = NULL;
>>           int prop_len = 0, name_len = 0;
>>           uint32_t tag;
>> @@ -351,8 +351,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
>>           switch (tag) {
>>           case FDT_BEGIN_NODE:
>>               fdt_depth++;
>> -            name = fdt_get_name(fdt, fdt_offset, &name_len);
>> -            if (!visit_start_struct(v, name, NULL, 0, errp)) {
>> +            dt_name = fdt_get_name(fdt, fdt_offset, &name_len);
>> +            if (!visit_start_struct(v, dt_name, NULL, 0, errp)) {
>>                   return;
>>               }
>>               break;
>> @@ -369,8 +369,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
>>           case FDT_PROP: {
>>               int i;
>>               prop = fdt_get_property_by_offset(fdt, fdt_offset, &prop_len);
>> -            name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
>> -            if (!visit_start_list(v, name, NULL, 0, errp)) {
>> +            dt_name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
>> +            if (!visit_start_list(v, dt_name, NULL, 0, errp)) {
>>                   return;
>>               }
>>               for (i = 0; i < prop_len; i++) {


