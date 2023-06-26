Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB12373D928
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:08:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhH4-0000ek-C6; Mon, 26 Jun 2023 04:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qDhH2-0000bs-Gd
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:08:36 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qDhGy-00085e-To
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:08:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-676f16e0bc4so381237b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1687766911; x=1690358911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D5SVNL6y/qlIHMSPMSqQ+oOihVr00QKN1GR35w6GjOI=;
 b=l7JptPV3FNIzosFHRRngfFWnAMc4WeZgICQJAxv+2RgUMfkTk8JqcnCIWBthekPXgW
 3HrCTU7Bq7/rt1H4xRExbJ+vrFwqU5/No3u3Qd+3fPTiAArr1jMzQTcgXF+PDJ1p4aJx
 8ePvyqPSXH4lc+SFI6qcfQhVRHKrV4GYAZRloi5iBpdvyCuKemPqdb06OD6zAyz2+qOx
 d0wquLv7dsuWFWavtU4ILFFm4/r9ev5SaaRuapFRM4ZNjcOGmYPB+LdPouAHtCpAluqd
 86t6wiwSncPu44pl2LiQcHx/phiDR3UQ8Gh80S4Nv7aa4tx/jARUmURdLxlOXBeMKnh2
 5SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687766911; x=1690358911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D5SVNL6y/qlIHMSPMSqQ+oOihVr00QKN1GR35w6GjOI=;
 b=E4qMcHqaB3K6E+63TdmanaaTlafHVvWmTMyDE3wSreN28EHeeZYOrFjrOLuWCTgXbC
 NaEf5IvU1s4rw7bmGvNZ6TK+2J+Pmr7uVGmWPnGjPex0a2560/3prYomG9ZYreD/+YYa
 sCkn26mImjFMO/Iv9L1DP4AO+kVmS85UMtWfEVzIOlbTcSMc42uhzCA+bIcKUTzWyF18
 71roj8yuXQ+sASm/Y7BlSrBVoGOoComgFyNmneI0E1eu+lZosMdqHTVtK/9lEK6vK7k9
 6mOMODL/jn5z0N1+LLgIhe1tODhpHHfAaDBCqpXBwiB2RHfqvJI3PxmRrCyLC2YBVVtB
 K7fA==
X-Gm-Message-State: AC+VfDxO6qz69gCmdWmqx9bAq9H1Lp9N7AH/B+Pi2gmqyIbHEf8XBDne
 IzQXmTWf+mlGvW0u/rYiK0KdYQ==
X-Google-Smtp-Source: ACHHUZ5vWQNW4a2PdAM31t23NxCKaWW74lJe0d4WJlAAQj91MJuamVH5yTDgoOmkfItfWuuKufxEww==
X-Received: by 2002:a05:6a00:1a52:b0:653:de9a:d933 with SMTP id
 h18-20020a056a001a5200b00653de9ad933mr16860650pfv.17.1687766911177; 
 Mon, 26 Jun 2023 01:08:31 -0700 (PDT)
Received: from [192.168.100.101] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 s1-20020aa78281000000b0065a1b05193asm3266067pfm.185.2023.06.26.01.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:08:30 -0700 (PDT)
Message-ID: <414993d5-2ce7-5d91-580b-680e11783ada@sifive.com>
Date: Mon, 26 Jun 2023 16:08:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 17/17] target/riscv: Expose Zvk* and Zvb[b,c] cpu
 properties
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Nazar Kazakov <nazar.kazakov@codethink.co.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230622161646.32005-1-max.chou@sifive.com>
 <20230622161646.32005-18-max.chou@sifive.com>
 <12f82e04-7379-0d8c-c54b-348cd30c31b2@ventanamicro.com>
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <12f82e04-7379-0d8c-c54b-348cd30c31b2@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2023/6/23 1:41 AM, Daniel Henrique Barboza wrote:

>
>
> On 6/22/23 13:16, Max Chou wrote:
>> From: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
>>
>> Exposes earlier CPU flags allowing the use of the vector cryptography 
>> extensions.
>>
>> Signed-off-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
>> Signed-off-by: Max Chou <max.chou@sifive.com>
>> ---
>>   target/riscv/cpu.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index c1956dc29b..48d584ab0d 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -1714,6 +1714,16 @@ static Property riscv_cpu_extensions[] = {
>>       DEFINE_PROP_BOOL("x-zvfh", RISCVCPU, cfg.ext_zvfh, false),
>>       DEFINE_PROP_BOOL("x-zvfhmin", RISCVCPU, cfg.ext_zvfhmin, false),
>>   +    /* Vector cryptography extensions */
>> +    DEFINE_PROP_BOOL("x-zvbb", RISCVCPU, cfg.ext_zvbb, false),
>> +    DEFINE_PROP_BOOL("x-zvbc", RISCVCPU, cfg.ext_zvbc, false),
>> +    DEFINE_PROP_BOOL("x-zvkg", RISCVCPU, cfg.ext_zvkg, false),
>> +    DEFINE_PROP_BOOL("x-zvkned", RISCVCPU, cfg.ext_zvkned, false),
>> +    DEFINE_PROP_BOOL("x-zvknha", RISCVCPU, cfg.ext_zvknha, false),
>> +    DEFINE_PROP_BOOL("x-zvknhb", RISCVCPU, cfg.ext_zvknhb, false),
>> +    DEFINE_PROP_BOOL("x-zvksed", RISCVCPU, cfg.ext_zvksed, false),
>> +    DEFINE_PROP_BOOL("x-zvksh", RISCVCPU, cfg.ext_zvksh, false),
>> +
>
> We usually add the cpu properties in the same commit that the 
> extension was
> added, e.g. "x-zvbb" would be added by patch 9. This is no hard rule 
> though.
>
> Let's leave this as is and, if a v5 is required for any other reason, 
> you can
> put each property into its own patch. For now:
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
Thanks for the suggestion.

I'll provide a v5 patch set for the AES related modification.
https://lore.kernel.org/qemu-devel/20230620110758.787479-1-richard.henderson@linaro.org/
So I'll also follow the suggestion in v5.


With regards,
Max


