Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F04AF82B953
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 03:09:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO6xj-0007Dm-O6; Thu, 11 Jan 2024 21:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rO6xg-0007D0-Pk
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 21:07:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rO6xe-00018V-O0
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 21:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705025273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qsIJVtqBJLvrhJ9BS9yfiy8PppKDOmHMb5VtOge3S20=;
 b=TVUAjYwHBQzxINpeV+pTQhUcVKf+ySzCuh8v6IguIxridZQm6rq4YK/vHbbfOCSnI7m+JK
 HvSbQFmGQxMoE+JWU8NxroeybkJSfxT9XuYwqTfwIMKR8V5thwXTmt101EZ2n/j7wXYp+0
 9JQb5xRCGhsHeiVuHomJO3e/VpBocEA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Rp2fQg15OJCRI66tP3-Keg-1; Thu, 11 Jan 2024 21:07:51 -0500
X-MC-Unique: Rp2fQg15OJCRI66tP3-Keg-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6da0d1d6674so6468239b3a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 18:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705025271; x=1705630071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qsIJVtqBJLvrhJ9BS9yfiy8PppKDOmHMb5VtOge3S20=;
 b=sBsDzL9icsT7S9BFmj2A4RTeh8DszhHwbgPcFyZ2yha7d1QcNldMxKyifRtN6IGXtf
 wpCqnj0ENVOUCMe++yyN6olpOAfte41N7NNjMomL/sYuTwjlfrgKgQ/0+YP02UJ4ndWe
 ZrBBYl5XMTRX7M9VpR4jIZshSTAo1y/WMy0O0wPZBSVmUgZRlwTePo6GLhe6kpU5WeT8
 6pDrwHB9R7JGNo+MKzAch6zX83Td3Zy/QP+0BkCLleBZrRW7Tdj8lubmEnjBqzr9S3AF
 2gwqZflOfHrTZ6FzZKdCR/0im214/OakJue9+J0uaQUXnhX5dZndkE2Q+bUIPv+bpy+9
 krgQ==
X-Gm-Message-State: AOJu0YwkoHEmfudQdR9GTrmjZ1W5Uzerx7N4sWDHQH4WN6Jl1iiTpAvF
 pMkT/WBm4w2re7COZkAS71x9wKt1+UGwbqap2HJq2sUWA3Vds/rKKFFC9sVJ9tsdzs51X0DOwYM
 Zi20dFSylWxk+ihqJB8xtSXE=
X-Received: by 2002:a05:6a00:2295:b0:6d9:b5ce:f17e with SMTP id
 f21-20020a056a00229500b006d9b5cef17emr326328pfe.5.1705025270939; 
 Thu, 11 Jan 2024 18:07:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFogdPCJFCZzkW3fJugF7mHstjv4XggXypSml1HueXxqMYO6ChogOypKLXTy3Ni1Y1h+nH+xg==
X-Received: by 2002:a05:6a00:2295:b0:6d9:b5ce:f17e with SMTP id
 f21-20020a056a00229500b006d9b5cef17emr326311pfe.5.1705025270589; 
 Thu, 11 Jan 2024 18:07:50 -0800 (PST)
Received: from [10.72.112.34] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 t127-20020a628185000000b006db05eb1301sm2010034pfd.21.2024.01.11.18.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 18:07:50 -0800 (PST)
Message-ID: <acaa64af-4deb-475f-984f-631f60c4f798@redhat.com>
Date: Fri, 12 Jan 2024 12:07:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core: Handle cpu_model_from_type() returning NULL value
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240111064723.6920-1-philmd@linaro.org>
 <cdfc3049-8b9b-4a24-9e0e-8db396acc6c1@redhat.com>
 <4f73c8d8-ea98-47b0-9296-bd9ccb76908d@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <4f73c8d8-ea98-47b0-9296-bd9ccb76908d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Phil,

On 1/11/24 18:21, Philippe Mathieu-Daudé wrote:
> On 11/1/24 08:30, Gavin Shan wrote:
>> On 1/11/24 16:47, Philippe Mathieu-Daudé wrote:
>>> Per cpu_model_from_type() docstring (added in commit 445946f4dd):
>>>
>>>    * Returns: CPU model name or NULL if the CPU class doesn't exist
>>>
>>> We must check the return value in order to avoid surprises, i.e.:
>>>
>>>   $ qemu-system-arm -machine virt -cpu cortex-a9
>>>    qemu-system-arm: Invalid CPU model: cortex-a9
>>>    The valid models are: cortex-a7, cortex-a15, (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), max
>>>
>>> Add assertions when the call can not fail (because the CPU type
>>> must be registered).
>>>
>>> Fixes: 5422d2a8fa ("machine: Print CPU model name instead of CPU type")
>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   cpu-target.c          | 1 +
>>>   hw/core/machine.c     | 5 +++++
>>>   target/ppc/cpu_init.c | 1 +
>>>   3 files changed, 7 insertions(+)
>>>
>>> diff --git a/cpu-target.c b/cpu-target.c
>>> index 5eecd7ea2d..b0f6deb13b 100644
>>> --- a/cpu-target.c
>>> +++ b/cpu-target.c
>>> @@ -291,6 +291,7 @@ static void cpu_list_entry(gpointer data, gpointer user_data)
>>>       const char *typename = object_class_get_name(OBJECT_CLASS(data));
>>>       g_autofree char *model = cpu_model_from_type(typename);
>>> +    assert(model);
>>>       if (cc->deprecation_note) {
>>>           qemu_printf("  %s (deprecated)\n", model);
>>>       } else {
>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>> index fc239101f9..730ec10328 100644
>>> --- a/hw/core/machine.c
>>> +++ b/hw/core/machine.c
>>> @@ -1422,16 +1422,21 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
>>>           /* The user specified CPU type isn't valid */
>>>           if (!mc->valid_cpu_types[i]) {
>>>               g_autofree char *requested = cpu_model_from_type(machine->cpu_type);
>>> +            assert(requested);
>>>               error_setg(errp, "Invalid CPU model: %s", requested);
>>>               if (!mc->valid_cpu_types[1]) {
>>>                   g_autofree char *model = cpu_model_from_type(
>>> mc->valid_cpu_types[0]);
>>> +                assert(model);
>>>                   error_append_hint(errp, "The only valid type is: %s\n", model);
>>>               } else {
>>>                   error_append_hint(errp, "The valid models are: ");
>>>                   for (i = 0; mc->valid_cpu_types[i]; i++) {
>>>                       g_autofree char *model = cpu_model_from_type(
>>> mc->valid_cpu_types[i]);
>>> +                    if (!model) {
>>> +                        continue;
>>> +                    }
>>
>> Shall we assert(model) for this case, to be consistent with other cases? :)
> 
> No, this is the "(null)" cases displayed in the example.
> 
> IOW, mc->valid_cpu_types[] contains a CPU type which isn't registered,
> so we just skip it.
> 

I thought this should be fixed by correcting mc->valid_cpu_types[] in
hw/arm/virt.c. It means the consistent mc->valid_cpu_types[] needs to
be  provided by the specific board. Otherwise, the logic is incorrect from
the code level at least. For example, "cortex-a9" isn't available to
qemu-system-arm but it has been wrongly declared as supported in hw/arm/virt.c

I've posted one patch against it:

https://lists.nongnu.org/archive/html/qemu-arm/2024-01/msg00531.html


>>
>>>                       error_append_hint(errp, "%s%s",
>>>                                         model,
>>>                                         mc->valid_cpu_types[i + 1] ? ", " : "");
>>
>> Otherwise, the separator here need to be adjusted because it's uncertain that
>> mc->valid_cpu_types[i+1] ... mc->valid_cpu_types[END] are valid.
> 
> Here we know mc->valid_cpu_types[i] is *not* NULL, but
> mc->valid_cpu_types[i + 1] might be (signaling the end
> of the array).
> 
> This seems correct to me, but I might be missing something.
> 

When the class for mc->valid_cpu_types[i + 1] isn't registered, we will
skip the entry. it's possible that the class of mc->valid_cpu_types[i + 2]
isn't registered either. mc->valid_cpu_types[i + 3] to mc->valid_cpu_types[END - 1]
have the similar situations.

In order to correct the separator, we need to invalidate the return value
from cpu_model_from_type(mc->valid_cpu_types[i + 1]) ... cpu_model_from_type(mc->valid_cpu_types[END - 1]).
Too much complex for that and it's another reason why I suggested assert(model) as above

>>
>>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>>> index 344196a8ce..58f0c1e30e 100644
>>> --- a/target/ppc/cpu_init.c
>>> +++ b/target/ppc/cpu_init.c
>>> @@ -7037,6 +7037,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
>>>       }
>>>       name = cpu_model_from_type(typename);
>>> +    assert(name);
>>>       qemu_printf("PowerPC %-16s PVR %08x\n", name, pcc->pvr);
>>>       for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
>>>           PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];
>>

Thanks,
Gavin


