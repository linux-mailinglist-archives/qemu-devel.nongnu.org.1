Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D285B77CCDA
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 14:44:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVtOP-0000KM-Ed; Tue, 15 Aug 2023 08:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qVtON-0000Jv-3G
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 08:43:23 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qVtOJ-0003uQ-7L
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 08:43:22 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a78a29bca3so4233690b6e.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 05:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692103385; x=1692708185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GEZpZgnUfK/Z2JJjv9jSJln4+H9Nu0lLNmLT2fU/jcs=;
 b=BMHB0a/54SiAEN90GEkjRl/ahk5CqqlPsJ8Y7kWQgLRM5ci0qpf3sCNf60Ytukdqp0
 qiO2t5ylLBsuDkiBvjltAYhzn1OfoHvEeikdPYvzlCUij0dkdfbp7N2jaJvHCjppy0/I
 2CcI8CU0AsiCIN/tyo1+tIL7iis84aKEeyhrf+MWZxguiO6Vx/o/U33A6lM3ai2KdK7J
 0KXWBu3ROnRZ9gVzOPto6LPc6oSZR+ITTGM0cUY1DoktDrk54By8Ume9217f7D25oNSd
 CA1ufcs9xw4yrQjTS1DMDc5qac4UdpT/ubL5iYqk+HX4wi8TaGXBZqOT9g/kjP/utu4u
 Ruqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692103385; x=1692708185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GEZpZgnUfK/Z2JJjv9jSJln4+H9Nu0lLNmLT2fU/jcs=;
 b=YUt8CQ8Ssqecp0nUN+35Re1XFgHie3NE63TPUzoMDPDeBqCfcobJxZzUU9dXeyXTU/
 Vzd11XPybI1xvvYDXFmSRqzgUrvH4XqnLyBq776Tx5rjpnmnRxqtmWz9SEBCqJUYnKsQ
 OSzefzaskoZwZ9l1EJoJ3WSICzTE8aIM0SeRg2Qf5wrpW1LUMZ2b3O1X+FfUHlUxQiNz
 7cH/73XDxxU9kqQKXR9l5oljPo2WHZHGpKgrO0+d2kah8HAL3MrlPDHAu6mGaW2/fi/V
 tSk3yS5hNuQ9Tiz7j0HdsOv33Y99lWQKexLVya2062kCxvoAeSgggDGxQ5P3FYmaNaWj
 qLgg==
X-Gm-Message-State: AOJu0Yx/u19JoKExApju8d2BebLjZTDBE5sArHAhnFxgDU9UAHygXtcR
 r3W0yCfHXiw60zroFcbUac0dGw==
X-Google-Smtp-Source: AGHT+IGjxSVvLVSWdDraxKZOZIwCOWbRsa4K5druukXxrb2sbkR6XTdjQMdqx8gDTDGX0gorUrBv9g==
X-Received: by 2002:a05:6808:2188:b0:3a7:c13:c8d1 with SMTP id
 be8-20020a056808218800b003a70c13c8d1mr16237278oib.17.1692103385496; 
 Tue, 15 Aug 2023 05:43:05 -0700 (PDT)
Received: from [192.168.68.108] (189-69-160-189.dial-up.telesp.net.br.
 [189.69.160.189]) by smtp.gmail.com with ESMTPSA id
 y2-20020a056808060200b003a7a34a4ed8sm5430042oih.33.2023.08.15.05.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 05:43:05 -0700 (PDT)
Message-ID: <0013e3ed-75ba-1806-45d5-6ca7c00ee917@ventanamicro.com>
Date: Tue, 15 Aug 2023 09:43:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 04/12] target/riscv/cpu.c: del
 DEFINE_PROP_END_OF_LIST() from riscv_cpu_extensions
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20230727220927.62950-1-dbarboza@ventanamicro.com>
 <20230727220927.62950-5-dbarboza@ventanamicro.com>
 <CAKmqyKMkWbg5iFOOqgiaT_J6+FCUr9gpQS9HV90kZeGwPeioPg@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAKmqyKMkWbg5iFOOqgiaT_J6+FCUr9gpQS9HV90kZeGwPeioPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.045,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 8/10/23 14:49, Alistair Francis wrote:
> On Thu, Jul 27, 2023 at 6:20 PM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> This last blank element is used by the 'for' loop to check if a property
>> has a valid name.
>>
>> Remove it and use ARRAY_SIZE() instead like riscv_cpu_options is already
>> using. All future arrays will also do the same and we'll able to
>> encapsulate more repetitions in macros later on.
> 
> Is this the right approach? This seem different to the rest of QEMU

I am not sure if we have a 'right approach' in this case or not. I see both
being used in QEMU.

All this said, I'm cooking another series in which I had to remove the ARRAY_SIZE()
of all these arrays, going back to add the empty element at the end of each one,
because I ended up exporting them (making them extern) to other files and ARRAY_SIZE()
doesn't work in that case.

I can do this right now in this patch with the excuse that we're going to export them
in the future. As long as we do the same thing to all arrays we should be able to
eliminate code repetition anyway.


Thanks,

Daniel


> 
> Alistair
> 
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
>> ---
>>   target/riscv/cpu.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index f1a292d967..33a2e9328c 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -1842,8 +1842,6 @@ static Property riscv_cpu_extensions[] = {
>>       DEFINE_PROP_BOOL("x-zfbfmin", RISCVCPU, cfg.ext_zfbfmin, false),
>>       DEFINE_PROP_BOOL("x-zvfbfmin", RISCVCPU, cfg.ext_zvfbfmin, false),
>>       DEFINE_PROP_BOOL("x-zvfbfwma", RISCVCPU, cfg.ext_zvfbfwma, false),
>> -
>> -    DEFINE_PROP_END_OF_LIST(),
>>   };
>>
>>   static Property riscv_cpu_options[] = {
>> @@ -1901,14 +1899,13 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
>>
>>   static void riscv_cpu_add_kvm_properties(Object *obj)
>>   {
>> -    Property *prop;
>>       DeviceState *dev = DEVICE(obj);
>>
>>       kvm_riscv_init_user_properties(obj);
>>       riscv_cpu_add_misa_properties(obj);
>>
>> -    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
>> -        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
>> +    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_extensions); i++) {
>> +        riscv_cpu_add_kvm_unavail_prop(obj, riscv_cpu_extensions[i].name);
>>       }
>>
>>       for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
>> @@ -1929,7 +1926,6 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
>>    */
>>   static void riscv_cpu_add_user_properties(Object *obj)
>>   {
>> -    Property *prop;
>>       DeviceState *dev = DEVICE(obj);
>>
>>   #ifndef CONFIG_USER_ONLY
>> @@ -1943,8 +1939,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
>>
>>       riscv_cpu_add_misa_properties(obj);
>>
>> -    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
>> -        qdev_property_add_static(dev, prop);
>> +    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_extensions); i++) {
>> +        qdev_property_add_static(dev, &riscv_cpu_extensions[i]);
>>       }
>>
>>       for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
>> --
>> 2.41.0
>>
>>

