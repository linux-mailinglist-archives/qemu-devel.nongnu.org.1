Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A56A72C389
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:57:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8g9u-0008JD-M6; Mon, 12 Jun 2023 07:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baxiantai@gmail.com>)
 id 1q8g9r-0008Ib-Vp; Mon, 12 Jun 2023 07:56:27 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baxiantai@gmail.com>)
 id 1q8g9q-0002HQ-A4; Mon, 12 Jun 2023 07:56:27 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b3dd3ca7adso2365555ad.3; 
 Mon, 12 Jun 2023 04:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686570984; x=1689162984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cSZ7htSifpNfQr6PJVXGMbOjhX3G/NfLLTNW9KstMDs=;
 b=Bc/mTWhqxNt/FMoTvxOwGXLQmJsDA3spQtRnYHzIETzfRfqf4DzZmmxT1DNd3mbLZc
 vEooZzHG7OHCO7IwrzbFIuqiI5hzvU18DcE4WnT3/U9hsK0tU271L2kDMyL3lUWa5xhS
 E/FdRRK6kCwbITPoRuK2nxFcgwOFJO4Gb7cyB8y1CvdritACaqP4oRhGs2tCo4R6SdlX
 XZoq7qrorf+wfBDcWYy+4hxYmqZa1mxphqolx6rqFBFnyK8E11fBl5WnLVxXhFjPm/BV
 Q9MdV1qZT1CBcSDRX9d5umA7mt1ai1l81t+H6VXS8TM/6jphDeuSB6+ClgiV5qMiuMDr
 3XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686570984; x=1689162984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cSZ7htSifpNfQr6PJVXGMbOjhX3G/NfLLTNW9KstMDs=;
 b=dwDgjSlpF6JkKG1CTRC8YzexHv7o+YNbkwV01oMujamSfNV12+zWkqeH20yMY5+gp/
 bNjj7v8+LIc/PZTkzEbPeCFfiTJoOfvK5bE3HxKAiH07SmjvfoNamaSbAMF99QFPJupo
 w+4QzUvrHjKjUpjyj7cLf3oQ1Tp6VWWOWkDP8jTxmXbS4ozbnKgnOzSNlZur/nLH39Vp
 dKEevcXzg8OhV9dWu+QJul2ve0O/GsXhNBSkPdnHCE9nYgCn5EIC5IpdqMCgOrlyiRX+
 4jSVXdABgjFxSira9ydQpjKe5HxDy8icxEmKB7JbxcnJK2Tx+Gqjsij78YL/mPAp4GnG
 FJXA==
X-Gm-Message-State: AC+VfDxyXjjIfc3xyrV6bcFL6jRwW0p7C4W4jJmf9D6iaAIKv/Z4QnOA
 p/lJekj6ELMf353bcsap+O4=
X-Google-Smtp-Source: ACHHUZ51uM5P2vxL3UDu8RbQEBtxQjyDiSldllDXe74pzrAjlIZntHF82+BN5MQo734wW8NI223P9A==
X-Received: by 2002:a17:902:ce8a:b0:1b1:a0bb:4c75 with SMTP id
 f10-20020a170902ce8a00b001b1a0bb4c75mr7573252plg.53.1686570983906; 
 Mon, 12 Jun 2023 04:56:23 -0700 (PDT)
Received: from [30.221.96.167] ([47.246.101.55])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a1709028c8e00b001aaed55aff3sm8013810plo.137.2023.06.12.04.56.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 04:56:23 -0700 (PDT)
Message-ID: <bf9ca2e7-5bbe-6415-fbaf-57854d058e47@gmail.com>
Date: Mon, 12 Jun 2023 19:56:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/9] target/riscv/cpu: Share RISCVCPUConfig with
 disassembler
Content-Language: en-US
To: =?UTF-8?Q?Christoph_M=c3=bcllner?= <christoph.muellner@vrull.eu>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230530131843.1186637-1-christoph.muellner@vrull.eu>
 <20230530131843.1186637-7-christoph.muellner@vrull.eu>
 <29c57d6a-247c-ef4c-da4c-f3021bb0ea54@gmail.com>
 <CAEg0e7iShmcrvqXJkfy+wv+v4e2y=S4go52aTs8cZ_+Lb6rvwg@mail.gmail.com>
 <18954fce-c08d-66f0-fe32-b6bdd4ac1892@gmail.com>
 <CAEg0e7iAjgRPGxOKEA9BmfZ5M8tc_CzyU4jogwM8d9LSMob0mg@mail.gmail.com>
From: LIU Zhiwei <baxiantai@gmail.com>
In-Reply-To: <CAEg0e7iAjgRPGxOKEA9BmfZ5M8tc_CzyU4jogwM8d9LSMob0mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=baxiantai@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 2023/6/12 18:04, Christoph Müllner wrote:
> On Mon, Jun 12, 2023 at 12:01 PM LIU Zhiwei <baxiantai@gmail.com> wrote:
>>
>> On 2023/6/12 17:47, Christoph Müllner wrote:
>>> On Mon, Jun 12, 2023 at 8:25 AM LIU Zhiwei <baxiantai@gmail.com> wrote:
>>>> On 2023/5/30 21:18, Christoph Muellner wrote:
>>>>> From: Christoph Müllner <christoph.muellner@vrull.eu>
>>>>>
>>>>> The disassembler needs the available extensions in order
>>>>> to properly decode instructions in case of overlapping
>>>>> encodings (e.g. for vendor extensions).
>>>>>
>>>>> Let's use the field 'disassemble_info::private_data' to store
>>>>> our RISCVCPUConfig pointer.
>>>>>
>>>>> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
>>>>> ---
>>>>>     target/riscv/cpu.c | 3 +++
>>>>>     1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>>> index 5b7818dbd1..6f0cd9a0bb 100644
>>>>> --- a/target/riscv/cpu.c
>>>>> +++ b/target/riscv/cpu.c
>>>>> @@ -819,6 +819,9 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
>>>>>     {
>>>>>         RISCVCPU *cpu = RISCV_CPU(s);
>>>>>         CPURISCVState *env = &cpu->env;
>>>>> +    RISCVCPUConfig *cfg = &cpu->cfg;
>>>>> +
>>>>> +    info->private_data = cfg;
>>>> I don't know if this field will be overridden by the binutils. Can we
>>>> extend the struct disassemble_info, and add some fields like supporting
>>>> for Capstone?
>>> Initially I wanted to add a new field, but then I noticed that the field
>>> 'disassemble_info::private_data' is used for a similar purpose by
>>> disas/cris.c, disas/m68k.c, and dias/xtensa.c.
>>> So I decided to not add yet another field, which only serves one architecture.
>> I think you can CC these arch maintainers to see if it need some
>> specially process before using the private_data.
>>> But if that's the preferred way, then I can change.
>> I prefer this way, but not insist on  if it really works using the
>> private_data.
> This topic is already resolved by using the field 'info->target_info'.
> So I dropped this patch anyway.

OK. I remembered I also used this field to pass the ISA information in 
the multi-path disassemble patch set.

Zhiwei

>
> BR
> Christoph
>
>> Zhiwei
>>
>>> Thanks
>>> Christoph
>>>
>>>> Zhiwei
>>>>
>>>>>         switch (env->xl) {
>>>>>         case MXL_RV32:

