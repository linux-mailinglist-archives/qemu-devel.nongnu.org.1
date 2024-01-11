Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B74282A8F7
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:21:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqJU-0000Gz-1c; Thu, 11 Jan 2024 03:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNqJR-000095-D5
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:21:17 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNqJP-0002Ck-JK
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:21:17 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e60e137a3so1753745e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704961274; x=1705566074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5TZoZwVbqpVHzs0xtso3QFWX7Z11nZ42Jc+3vcZbepQ=;
 b=HCUsGyg86pwM5UlA+bDHuKKktIqPwnY8PAhokKTiPpq0xt5LLruYhAEDXthjNwItnV
 wIqruOnFzMRDTtOE6dqa5hrQrgIlLc5oumWR8uBY1NUZJKwHd52P7kigL5la9neQTRKM
 m446xJ0GCyI3cEjMV+qolD0dMIsKG8rUVn1f5rJsh4QPVv4TiLBYYFn3voXVsYJaq+Jh
 UJSQO6khftUjCO6o2G4ZxqEpCW/3Q39HJLsQTPHm4dLEPZJbBlj7KH+IGBBc3YRQ5Hf1
 1jQGl0lfbFDQH25VIipCdZ3iUK6iegGCF9V/dc0NL77RFjfSon4z3117MktwVm6x6Akx
 C08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704961274; x=1705566074;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5TZoZwVbqpVHzs0xtso3QFWX7Z11nZ42Jc+3vcZbepQ=;
 b=VS+Izq7OXhKx9TosOkawpPLcpSTjOoLTi+6bJKasJnNneHP1l9FlRiNURc6+tw9671
 DBI4I/Udh9zZ/L7dUtnVDS8U++4YUlBwHfzKg/bbNdjS5t3gqvPQHqwQiImvfqB20z6M
 YEumODBu+6c9bJLX9Lq57BAFrWuEYXNjQc43XwQimJ/rj4HD1c6XXTMa+bPK/rWZNE8I
 wBEVUov1f3zisod7a3+KDf0xDcgKDhdezHthAOozRZ6FSvWkEsiJtManBFM57CDI/eIC
 6Qaswm3KoeJYvsqYSDfwJ3MSeVoKgIOocytK/kHJzbyN/9I7PO+sVg/g6tf1ypCpn8ms
 xcBQ==
X-Gm-Message-State: AOJu0Yys91aDmtnN2KhUC0+9sx0f+6MiId5XfVVdFEqcD/JN6ouu36Rz
 uoAL2AQsRYCz5KO1ZIPke7KgSmyXu8xkdQ==
X-Google-Smtp-Source: AGHT+IGNeAgULU2BF8V8eArv1aKW4fs5Hyfb91+0jO11QQibX1IHYCUrN/++/88ZWr9mq7uyCFTsiQ==
X-Received: by 2002:a05:600c:358b:b0:40d:5d9a:adc with SMTP id
 p11-20020a05600c358b00b0040d5d9a0adcmr190595wmq.11.1704961273943; 
 Thu, 11 Jan 2024 00:21:13 -0800 (PST)
Received: from [192.168.207.175] (83.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.83]) by smtp.gmail.com with ESMTPSA id
 d14-20020a05600c34ce00b0040e60c00d2csm831061wmq.12.2024.01.11.00.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 00:21:13 -0800 (PST)
Message-ID: <4f73c8d8-ea98-47b0-9296-bd9ccb76908d@linaro.org>
Date: Thu, 11 Jan 2024 09:21:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core: Handle cpu_model_from_type() returning NULL value
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240111064723.6920-1-philmd@linaro.org>
 <cdfc3049-8b9b-4a24-9e0e-8db396acc6c1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cdfc3049-8b9b-4a24-9e0e-8db396acc6c1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Gavin,

On 11/1/24 08:30, Gavin Shan wrote:
> Hi Phil,
> 
> On 1/11/24 16:47, Philippe Mathieu-Daudé wrote:
>> Per cpu_model_from_type() docstring (added in commit 445946f4dd):
>>
>>    * Returns: CPU model name or NULL if the CPU class doesn't exist
>>
>> We must check the return value in order to avoid surprises, i.e.:
>>
>>   $ qemu-system-arm -machine virt -cpu cortex-a9
>>    qemu-system-arm: Invalid CPU model: cortex-a9
>>    The valid models are: cortex-a7, cortex-a15, (null), (null), 
>> (null), (null), (null), (null), (null), (null), (null), (null), 
>> (null), max
>>
>> Add assertions when the call can not fail (because the CPU type
>> must be registered).
>>
>> Fixes: 5422d2a8fa ("machine: Print CPU model name instead of CPU type")
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   cpu-target.c          | 1 +
>>   hw/core/machine.c     | 5 +++++
>>   target/ppc/cpu_init.c | 1 +
>>   3 files changed, 7 insertions(+)
>>
>> diff --git a/cpu-target.c b/cpu-target.c
>> index 5eecd7ea2d..b0f6deb13b 100644
>> --- a/cpu-target.c
>> +++ b/cpu-target.c
>> @@ -291,6 +291,7 @@ static void cpu_list_entry(gpointer data, gpointer 
>> user_data)
>>       const char *typename = object_class_get_name(OBJECT_CLASS(data));
>>       g_autofree char *model = cpu_model_from_type(typename);
>> +    assert(model);
>>       if (cc->deprecation_note) {
>>           qemu_printf("  %s (deprecated)\n", model);
>>       } else {
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index fc239101f9..730ec10328 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -1422,16 +1422,21 @@ static bool is_cpu_type_supported(const 
>> MachineState *machine, Error **errp)
>>           /* The user specified CPU type isn't valid */
>>           if (!mc->valid_cpu_types[i]) {
>>               g_autofree char *requested = 
>> cpu_model_from_type(machine->cpu_type);
>> +            assert(requested);
>>               error_setg(errp, "Invalid CPU model: %s", requested);
>>               if (!mc->valid_cpu_types[1]) {
>>                   g_autofree char *model = cpu_model_from_type(
>>                                                    
>> mc->valid_cpu_types[0]);
>> +                assert(model);
>>                   error_append_hint(errp, "The only valid type is: 
>> %s\n", model);
>>               } else {
>>                   error_append_hint(errp, "The valid models are: ");
>>                   for (i = 0; mc->valid_cpu_types[i]; i++) {
>>                       g_autofree char *model = cpu_model_from_type(
>>                                                    
>> mc->valid_cpu_types[i]);
>> +                    if (!model) {
>> +                        continue;
>> +                    }
> 
> Shall we assert(model) for this case, to be consistent with other cases? :)

No, this is the "(null)" cases displayed in the example.

IOW, mc->valid_cpu_types[] contains a CPU type which isn't registered,
so we just skip it.

> 
>>                       error_append_hint(errp, "%s%s",
>>                                         model,
>>                                         mc->valid_cpu_types[i + 1] ? 
>> ", " : "");
> 
> Otherwise, the separator here need to be adjusted because it's uncertain 
> that
> mc->valid_cpu_types[i+1] ... mc->valid_cpu_types[END] are valid.

Here we know mc->valid_cpu_types[i] is *not* NULL, but
mc->valid_cpu_types[i + 1] might be (signaling the end
of the array).

This seems correct to me, but I might be missing something.

> 
>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>> index 344196a8ce..58f0c1e30e 100644
>> --- a/target/ppc/cpu_init.c
>> +++ b/target/ppc/cpu_init.c
>> @@ -7037,6 +7037,7 @@ static void ppc_cpu_list_entry(gpointer data, 
>> gpointer user_data)
>>       }
>>       name = cpu_model_from_type(typename);
>> +    assert(name);
>>       qemu_printf("PowerPC %-16s PVR %08x\n", name, pcc->pvr);
>>       for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
>>           PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];
> 
> Thanks,
> Gavin
> 


