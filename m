Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D3973F7E3
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 10:55:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4TY-0001bn-Sg; Tue, 27 Jun 2023 04:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4Sj-0001OI-Up
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:54:19 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4Sd-0007Pg-H4
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:54:13 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-98de21518fbso413220266b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687856040; x=1690448040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SP/AQ1lhPmkfo1DD1a3kRUAZr3WZGDutW0g6+VnAEE4=;
 b=vmGrpxkIRENozf4lBJ538WXIAsBWZFnrAdiXxZLm6KUbkJAFzEmHbdLrJ4PhtUFEFB
 82m9XkinccU56YpN8VeZHOmlWNcWlzLbDF1y2LM2mGNjqKee8giQVlawWXmbHzHpRtDB
 Xj8zEQW8R1tH6fv4yZRb6MkTGpcLgFOiI+Mvj5gDDk3mJFxIlzumcK2mujE6ASHwIRoG
 uzHsLHzYbM4f4qUyoUKiHDf5fKhqof1oqWgVsdnSj0doU7cPcDYSYzpYW4p5sbiAOoNx
 yBIXPKOPe4IPcAwpfFp2P/AkeA3j8r+j7H1L6+wofgnm+qdrMt45VsfJNWxVkvwzgT27
 h4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687856040; x=1690448040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SP/AQ1lhPmkfo1DD1a3kRUAZr3WZGDutW0g6+VnAEE4=;
 b=JttiWyX+d0NTV928YJgyncW5wPyW5QWxOuipEDeQ6uwGe9+RWaYFyQL+xJuSjHRHU3
 m67WyY3MIdWr+6CXNdahrjW/Quu+wlKlTO0EdHoAuLblANNZ5VUTLMuFWv0LZ9IfaXX5
 knT0cSHb75fbfcLY4PIy/QNuPdjq0PM9Zja7g2OC8r+GMzQlGuLwmfHj03ZdnmvlBFPZ
 Sl9mW64bi2Y8es6anF2Kab2C/SvOkOY/nBp+1bzfycTzaARjsXOmgNwaEl8SYQ8wSXQ6
 AP1znxElS4iwt4v4sxKeS11rJuXTtXz2HQAFq4zVmE9c4M8lOKFm2WrhoqK6uB9aUuZg
 Aovw==
X-Gm-Message-State: AC+VfDzYnZKtY/s5wHhCjvZqDaYsf5UZUHFta0dQyq5gdtOI8wmZL6Sj
 8kX1DHFXCgHns7ECPvCQhXAihA==
X-Google-Smtp-Source: ACHHUZ54qxB1hHAj8YJH3HP44662OVP5oAP6U1uKuwmZa/5WIlccKWfui1myilS/Q80CbvVCfmPSqw==
X-Received: by 2002:a17:907:2d88:b0:988:56d1:10ca with SMTP id
 gt8-20020a1709072d8800b0098856d110camr25969298ejc.66.1687856040042; 
 Tue, 27 Jun 2023 01:54:00 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 n14-20020a170906118e00b0098ce63e36e9sm4347758eja.16.2023.06.27.01.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 01:53:59 -0700 (PDT)
Message-ID: <2274a813-af8f-6447-6dbd-04f2f4f2beba@linaro.org>
Date: Tue, 27 Jun 2023 10:53:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 08/26] tests/qtests: clean-up and fix leak in
 generic_fuzz
Content-Language: en-US
To: quintela@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Peter Xu <peterx@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Radoslaw Biernacki
 <rad@semihalf.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
 <20230626215926.2522656-9-alex.bennee@linaro.org>
 <87h6qtcpup.fsf@secure.mitica>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <87h6qtcpup.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 27/6/23 09:43, Juan Quintela wrote:
> Alex Bennée <alex.bennee@linaro.org> wrote:
>> An update to the clang tooling detects more issues with the code
>> including a memory leak from the g_string_new() allocation. Clean up
>> the code with g_autoptr and use ARRAY_SIZE while we are at it.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   tests/qtest/fuzz/generic_fuzz.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
>> index c525d22951..a4841181cc 100644
>> --- a/tests/qtest/fuzz/generic_fuzz.c
>> +++ b/tests/qtest/fuzz/generic_fuzz.c
>> @@ -954,17 +954,14 @@ static void register_generic_fuzz_targets(void)
>>               .crossover = generic_fuzz_crossover
>>       });
>>   
>> -    GString *name;
>> +    g_autoptr(GString) name = g_string_new("");
>>       const generic_fuzz_config *config;
>>   
>> -    for (int i = 0;
>> -         i < sizeof(predefined_configs) / sizeof(generic_fuzz_config);
>> -         i++) {
>> +    for (int i = 0; i < ARRAY_SIZE(predefined_configs); i++) {
>>           config = predefined_configs + i;
>> -        name = g_string_new("generic-fuzz");
>> -        g_string_append_printf(name, "-%s", config->name);
>> +        g_string_printf(name, "generic-fuzz-%s", config->name);
>>           fuzz_add_target(&(FuzzTarget){
>> -                .name = name->str,
>> +                .name = g_strdup(name->str),
>>                   .description = "Predefined generic-fuzz config.",
>>                   .get_init_cmdline = generic_fuzz_predefined_config_cmdline,
>>                   .pre_fuzz = generic_pre_fuzz,
> 
> Once that you are here, what about?
> (Yes, I didn't care about the ARRAY_SIZE) but you got the idea.
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> To your proposal with/without the change that I proposse.
> 
> modified   tests/qtest/fuzz/generic_fuzz.c
> @@ -954,17 +954,14 @@ static void register_generic_fuzz_targets(void)
>               .crossover = generic_fuzz_crossover
>       });
>   
> -    GString *name;
>       const generic_fuzz_config *config;
>   
>       for (int i = 0;
>            i < sizeof(predefined_configs) / sizeof(generic_fuzz_config);
>            i++) {
>           config = predefined_configs + i;
> -        name = g_string_new("generic-fuzz");
> -        g_string_append_printf(name, "-%s", config->name);
>           fuzz_add_target(&(FuzzTarget){
> -                .name = name->str,
> +                .name = g_strdup_printf("generic-fuzz-%s", config->name),

Even simpler is g_strconcat() suggested by Richard in v1:
https://lore.kernel.org/qemu-devel/42b497a0-e234-64db-e845-1c37b67839fc@linaro.org/

-- >8 --
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -956,13 +956,8 @@ static void register_generic_fuzz_targets(void)

-    GString *name;
      const generic_fuzz_config *config;

-    for (int i = 0;
-         i < sizeof(predefined_configs) / sizeof(generic_fuzz_config);
-         i++) {
-        config = predefined_configs + i;
-        name = g_string_new("generic-fuzz");
-        g_string_append_printf(name, "-%s", config->name);
+    for (int i = 0; i < ARRAY_SIZE(predefined_configs); i++) {
+        config = &predefined_configs[i];
          fuzz_add_target(&(FuzzTarget){
-                .name = name->str,
+                .name = g_strconcat("generic-fuzz-", config->name, NULL),
                  .description = "Predefined generic-fuzz config.",
---

