Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 848127573D5
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 08:13:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLdwF-0004Xb-Mg; Tue, 18 Jul 2023 02:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qLdwC-0004XH-PS
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 02:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qLdwA-0005Le-W0
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 02:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689660712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vHRCIhofoweDHT2kk3dm0VqHYPgh/+gcBIxdL+BWBro=;
 b=MhOszm62UEeZ/GT8ZfoVhYEj52piBlb0AB52AQOwi8IRkB2mwzbOEw4MuHOfe/Y9gnuJUY
 VV9i6SbhaKvyVZXLEjVuioeX7yfE7L+NBOc89j8fZ4Hd31yRXuJb7r7F9ATgzVnN19uD8J
 9+xTyS/OwiBdLJrh5A+apTb7W5/gvOs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-Uxo-fBTpMN2IaPV7u2uPpQ-1; Tue, 18 Jul 2023 02:11:50 -0400
X-MC-Unique: Uxo-fBTpMN2IaPV7u2uPpQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-666e3dad70aso4639209b3a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 23:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689660709; x=1692252709;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vHRCIhofoweDHT2kk3dm0VqHYPgh/+gcBIxdL+BWBro=;
 b=etjXcODGEaDm51XKKwKD4M06KsRywn7f5ULwsKaK/iCleHfoSjwHUjJBZr3KMC2qqA
 /V+qN4rd84r/RwM+lcwXxQ8Oa1bK9jH5lcSIQBTnonuvC9X91pX99a9tJbl90ETq5vyk
 xUUQAKzmZZg+wZy+1jKlWSbr7PcKD5npBwjOb5PCesFkk63E9K7n5AlWtvb4U6D7Vfzw
 i1/28kfhftXxs6cnWFdxSbg3fqVm0BcQI7xEGKRpUKNs3Idq0WaQZMB9JBvUibaxGcAA
 SWXmmCwn7E3gRihd0vAI5hTESRv5kLDf6SAkZGfQ8KHIUImYT0Rtebv6NDX4D8DdVDxW
 q4rg==
X-Gm-Message-State: ABy/qLZRaI/ZHMaNR14/7fhcQtC+iTMUvorBMOYiorTCAY2K+/GQuelY
 kMQC/jBUogsJIHVpSpKpqaJlbrMwS6/dxiQZLljBRnCOdsnVnlqgBnOpPtg+yqjFsDG4StSEr5x
 Q/sRSs5Z1ZuJOcvc=
X-Received: by 2002:a05:6a00:14c5:b0:668:83b6:bfe8 with SMTP id
 w5-20020a056a0014c500b0066883b6bfe8mr18939614pfu.9.1689660709258; 
 Mon, 17 Jul 2023 23:11:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHrB5kEjvrwyM+wapGanm98polCdsJChTNxmV+DPAIrHaDv708abv2PUHYE0hqIDOaYmDDKnw==
X-Received: by 2002:a05:6a00:14c5:b0:668:83b6:bfe8 with SMTP id
 w5-20020a056a0014c500b0066883b6bfe8mr18939590pfu.9.1689660708932; 
 Mon, 17 Jul 2023 23:11:48 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a62ed03000000b006829b27f252sm765051pfh.93.2023.07.17.23.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 23:11:48 -0700 (PDT)
Message-ID: <9a97da2f-befe-8b5a-aee6-23bb9212abcd@redhat.com>
Date: Tue, 18 Jul 2023 16:11:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] machine: Factor CPU type invalidation out into helper
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, peter.maydell@linaro.org, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, shan.gavin@gmail.com
References: <20230713054502.410911-1-gshan@redhat.com>
 <20230713054502.410911-2-gshan@redhat.com>
 <20230714140707.5c7c2402@imammedo.users.ipa.redhat.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230714140707.5c7c2402@imammedo.users.ipa.redhat.com>
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

On 7/14/23 22:07, Igor Mammedov wrote:
> On Thu, 13 Jul 2023 15:45:00 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> The CPU type invalidation logic in machine_run_board_init() is
>> independent enough. Lets factor it out into helper validate_cpu_type().
>> Since we're here, the relevant comments are improved a bit.
>>
>> No functional change intended.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   hw/core/machine.c | 81 +++++++++++++++++++++++++----------------------
>>   1 file changed, 43 insertions(+), 38 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index f0d35c6401..68b866c762 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -1349,12 +1349,52 @@ out:
>>       return r;
>>   }
>>   
>> +static void validate_cpu_type(MachineState *machine)
> s/validate_cpu_type/is_cpu_type_valid or better is_cpu_type_supported
> 
> Is it going to be reused elsewhere (otherwise I don't see much reason to move code around)?
> 

The logic of checking if the CPU type is supported is independent enough. It's
the only reason why I factored it out into a standalone helper here. It has
been explained in the commit log. Lets have an individual helper for this if
you don't have strong taste. With it, machine_run_board_init() looks a bit more
clean.

I don't have strong opinion about the function name. Shall we return 'bool'
with is_cpu_type_supported()? Something like below. The 'bool' return value
is duplicate to 'local_err' in machine_run_board_init(). So I think the
function validate_cpu_type(machine, errp) looks good to me. Igor, could you
please help to confirm?

static bool is_cpu_type_supported(MachineState *machine, Error **errp)
{
     bool supported = true;

     :

     if (!machine_class->valid_cpu_types[i]) {
         error_setg(errp, "Invalid CPU type: %s", machine->cpu_type));
         error_append_hint(errp, "The valid types are: %s", model);
         for (i = 1; machine_class->valid_cpu_types[i]; i++) {
             error_append_hint(errp, ", %s", model);
         }
         error_append_hint(errp, "\n");

         supported = false;
     }

     :

     return supported;
}

void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp)
{
     Error *local_err = NULL;

     :

     /* These two conditions are duplicate to each other! */
     if (!is_cpu_type_supported(machine, &local_err) && local_err) {
         error_propagate(errp, local_err);
     }

     :
}

>> +{
>> +    MachineClass *machine_class = MACHINE_GET_CLASS(machine);
>> +    ObjectClass *oc = object_class_by_name(machine->cpu_type);
>> +    CPUClass *cc = CPU_CLASS(oc);
>> +    int i;
>> +
>> +    /*
>> +     * Check if the user-specified CPU type is supported when the valid
>> +     * CPU types have been determined. Note that the user-specified CPU
>> +     * type is given by '-cpu' option.
>> +     */
>> +    if (!machine->cpu_type || !machine_class->valid_cpu_types) {
>> +        goto out_no_check;
> no goto-s please
> 

Ok. Will be dropped in next revision.

>> +    }
>> +
>> +    for (i = 0; machine_class->valid_cpu_types[i]; i++) {
>> +        if (object_class_dynamic_cast(oc, machine_class->valid_cpu_types[i])) {
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (!machine_class->valid_cpu_types[i]) {
>> +        /* The user-specified CPU type is invalid */
>> +        error_report("Invalid CPU type: %s", machine->cpu_type);
>> +        error_printf("The valid types are: %s",
>> +                     machine_class->valid_cpu_types[0]);
>> +        for (i = 1; machine_class->valid_cpu_types[i]; i++) {
>> +            error_printf(", %s", machine_class->valid_cpu_types[i]);
>> +        }
>> +        error_printf("\n");
>> +
>> +        exit(1);
> 
> since you are touching that,
> turn it in errp handling, in separate patch 1st
> and only then introduce your helper.
> 

Right, it's a good idea. I will have a preparatory patch for it where
the error messages will be accumulated to @local_err and finally propagate
it to @errp of machine_run_board_init().

>> +    }
>> +
>> +    /* Check if CPU type is deprecated and warn if so */
>> +out_no_check:
>> +    if (cc && cc->deprecation_note) {
>> +        warn_report("CPU model %s is deprecated -- %s",
>> +                    machine->cpu_type, cc->deprecation_note);
>> +    }
>> +}
>>   
>>   void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp)
>>   {
>>       MachineClass *machine_class = MACHINE_GET_CLASS(machine);
>> -    ObjectClass *oc = object_class_by_name(machine->cpu_type);
>> -    CPUClass *cc;
>>   
>>       /* This checkpoint is required by replay to separate prior clock
>>          reading from the other reads, because timer polling functions query
>> @@ -1405,42 +1445,7 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>>           machine->ram = machine_consume_memdev(machine, machine->memdev);
>>       }
>>   
>> -    /* If the machine supports the valid_cpu_types check and the user
>> -     * specified a CPU with -cpu check here that the user CPU is supported.
>> -     */
>> -    if (machine_class->valid_cpu_types && machine->cpu_type) {
>> -        int i;
>> -
>> -        for (i = 0; machine_class->valid_cpu_types[i]; i++) {
>> -            if (object_class_dynamic_cast(oc,
>> -                                          machine_class->valid_cpu_types[i])) {
>> -                /* The user specificed CPU is in the valid field, we are
>> -                 * good to go.
>> -                 */
>> -                break;
>> -            }
>> -        }
>> -
>> -        if (!machine_class->valid_cpu_types[i]) {
>> -            /* The user specified CPU is not valid */
>> -            error_report("Invalid CPU type: %s", machine->cpu_type);
>> -            error_printf("The valid types are: %s",
>> -                         machine_class->valid_cpu_types[0]);
>> -            for (i = 1; machine_class->valid_cpu_types[i]; i++) {
>> -                error_printf(", %s", machine_class->valid_cpu_types[i]);
>> -            }
>> -            error_printf("\n");
>> -
>> -            exit(1);
>> -        }
>> -    }
>> -
>> -    /* Check if CPU type is deprecated and warn if so */
>> -    cc = CPU_CLASS(oc);
>> -    if (cc && cc->deprecation_note) {
>> -        warn_report("CPU model %s is deprecated -- %s", machine->cpu_type,
>> -                    cc->deprecation_note);
>> -    }
>> +    validate_cpu_type(machine);
>>   
>>       if (machine->cgs) {
>>           /*

Thanks,
Gavin


