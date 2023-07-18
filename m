Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C49067573F2
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 08:18:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLe1Z-0007Ub-JN; Tue, 18 Jul 2023 02:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qLe1U-0007TV-Dg
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 02:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qLe1Q-0006A0-R1
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 02:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689661040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nKtQ4bWygdwWjo4GxXYPJuuLM9S0oNomjHKTYCoVOZ0=;
 b=TfLda4SY/vv2oBBYPwyKym1UmWrR2ci8zIz54cXc01Q65758xksUFM04g+J1TIvmilYrkt
 oavrXXn07FSI5HbS5hAh/VKMHT2aIxMc7f37MgaNOXDN+gsjxztqe7Y+oR1z0sHYGH75CL
 dsEQdCwpzryF6zSuwqE6z/QO/djdS+Q=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-GNW6pyAcNj2WoqRW71ombg-1; Tue, 18 Jul 2023 02:17:18 -0400
X-MC-Unique: GNW6pyAcNj2WoqRW71ombg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b896096287so41964305ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 23:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689661037; x=1692253037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nKtQ4bWygdwWjo4GxXYPJuuLM9S0oNomjHKTYCoVOZ0=;
 b=HAkUHnQZGKeggompX0ex3phoupvc1TVgHFoIW3KwWsIAHXzgC7bEWthfNlTu19G23x
 jWIFsL9YIgzlS9Ebb7FHgDAsm3ap0Q28cTxRM1/6mjLjl+N4snXmtqJ2XvoGppwvCBST
 9HIBGGtqClXKUllQWPPM6Bs7tzK/cQ0jjyU9wtc6hAUyZMoQziTUiYEyMRxm48xQ97pZ
 d2eSMsMOGMGzCDqz5CiZjO99CZ6+QW3WKQV18ZkJFNcOh4IzNwQBqlQfGu2RiqZC+O/d
 aDOOKcS2ZKJ0NU9TIwR+7ZMAY+Kjai+7u3gaQwLhDOWQcX0+hwC2H9aOpabeOhYjyYIi
 8ChA==
X-Gm-Message-State: ABy/qLYheUVeb+cO4z79CuqoAJaA2KtNCyFC6wPq8Gw2sq4cnBf/RnP5
 lvJ8sacxvIa4PDqOp/7aa7DzmvwF/rJHcD2ulq0Wy5XQH62PMxVd9YZwFiBEuArFXX06IDgTzZN
 ogA+iicBrOF1zP4E=
X-Received: by 2002:a17:903:1250:b0:1aa:d971:4623 with SMTP id
 u16-20020a170903125000b001aad9714623mr19243674plh.38.1689661037407; 
 Mon, 17 Jul 2023 23:17:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHJoGQ0jtawcPSRKpHqZTmWr8FmwJU7rzhoCgQSpTrvDklydjneylrFBLSz68ph9YGtkzOVhA==
X-Received: by 2002:a17:903:1250:b0:1aa:d971:4623 with SMTP id
 u16-20020a170903125000b001aad9714623mr19243644plh.38.1689661036724; 
 Mon, 17 Jul 2023 23:17:16 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a170903245200b001b801044466sm937921pls.114.2023.07.17.23.17.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 23:17:15 -0700 (PDT)
Message-ID: <0ba17b80-87a4-9240-abce-b9d2f467895c@redhat.com>
Date: Tue, 18 Jul 2023 16:17:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] hw/arm/virt: Use generic CPU type invalidation
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, peter.maydell@linaro.org, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, shan.gavin@gmail.com
References: <20230713054502.410911-1-gshan@redhat.com>
 <20230713054502.410911-3-gshan@redhat.com>
 <20230714135930.428e7d19@imammedo.users.ipa.redhat.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230714135930.428e7d19@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.097, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Igor,

On 7/14/23 21:59, Igor Mammedov wrote:
> On Thu, 13 Jul 2023 15:45:01 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> There is a generic CPU type invalidation in machine_run_board_init()
>                                ^^^^^
> using that throughout the series is confusing to me.
> Perhaps use original phrase 'valid cpu types' with appropriate rephrasing
> would be better
> 

Sure and sorry about the confusion. I will improve accordingly in next revision.

>> and we needn't a same and private invalidation. Set mc->valid_cpu_types
>> to use the generic CPU type invalidation.
> 
> I's suggest to replace commit message/subj with something like
> 
> arm/virt specific cpu_type_valid() is duplicate of ...
> drop it and use ...
> 

Sure, will do in next revision.

>> No functional change intended.
> 
> 
> 
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   hw/arm/virt.c | 21 +++------------------
>>   1 file changed, 3 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 7d9dbc2663..43d7772ffd 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -203,7 +203,7 @@ static const int a15irqmap[] = {
>>       [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
>>   };
>>   
>> -static const char *valid_cpus[] = {
>> +static const char *valid_cpu_types[] = {
>>   #ifdef CONFIG_TCG
>>       ARM_CPU_TYPE_NAME("cortex-a7"),
>>       ARM_CPU_TYPE_NAME("cortex-a15"),
>> @@ -219,20 +219,9 @@ static const char *valid_cpus[] = {
>>       ARM_CPU_TYPE_NAME("cortex-a57"),
>>       ARM_CPU_TYPE_NAME("host"),
>>       ARM_CPU_TYPE_NAME("max"),
>> +    NULL
>>   };
>>   
>> -static bool cpu_type_valid(const char *cpu)
>> -{
>> -    int i;
>> -
>> -    for (i = 0; i < ARRAY_SIZE(valid_cpus); i++) {
>> -        if (strcmp(cpu, valid_cpus[i]) == 0) {
>> -            return true;
>> -        }
>> -    }
>> -    return false;
>> -}
>> -
>>   static void create_randomness(MachineState *ms, const char *node)
>>   {
>>       struct {
>> @@ -2030,11 +2019,6 @@ static void machvirt_init(MachineState *machine)
>>       unsigned int smp_cpus = machine->smp.cpus;
>>       unsigned int max_cpus = machine->smp.max_cpus;
>>   
>> -    if (!cpu_type_valid(machine->cpu_type)) {
>> -        error_report("mach-virt: CPU type %s not supported", machine->cpu_type);
>> -        exit(1);
>> -    }
>> -
>>       possible_cpus = mc->possible_cpu_arch_ids(machine);
>>   
>>       /*
>> @@ -2953,6 +2937,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>>   #else
>>       mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
>>   #endif
>> +    mc->valid_cpu_types = valid_cpu_types;
>>       mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
>>       mc->kvm_type = virt_kvm_type;
>>       assert(!mc->get_hotplug_handler);

Thanks,
Gavin


