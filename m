Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6DE742F58
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 23:14:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEywn-0002WI-Ml; Thu, 29 Jun 2023 17:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEywk-0002Vd-V5
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 17:12:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEywe-00025l-Vc
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 17:12:55 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-313f1085ac2so1243752f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688073171; x=1690665171;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dhA4NY7VP3GoGiF0wjEjSZcOW8uKYG1/e7LeOqhgOuA=;
 b=F6bWpaAYvmLtek5FmUTicKOaATUbWrvXeYfV1t5WW539+UukXYiEnTY9f7Z9L42Ge3
 bG/yKlDLDd0jibV1RVAL34SznmKJQIBB+SZ/UbVBAHFQs3lpKxEIT4rXNWVxfEoNzN4f
 6f+sLj/ruGpBHlVgYQWXd3gGVdvJAAiQRux3z8aeu3dzJu9t9lj6k614n7FQPe2/0PQt
 RTTmIsHUMYxRAdAniUUqIp29L8PPeIQVhm+vhkeFr4TakJfBRG5vtgpViSbxGO4CCjuP
 AztUh8FAohcXKu0EHWvocxQJzzfMyRM5PQoSCHzwaurV2onWono6ykNlHnMY5MKGeHNx
 caow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688073171; x=1690665171;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dhA4NY7VP3GoGiF0wjEjSZcOW8uKYG1/e7LeOqhgOuA=;
 b=fzuA9IgdanYSybvnHXN/mpXuXxtFQqAc0+Et5GRoHbMlCvRYZz+ZP756gJ3TxoNkTW
 3rgi/Lbh48q0ju34s6JUiaTfNyrTvni6jWycovXW1CYj9P4+yqlh0LE/CQeHdQNw09KT
 1/Xzc76xVCoBktii5RTLGexHs62e46rNfJhehotXqhp9c9A7/vJaB3gt3t6f6PLUuUFC
 t93dnhDlUUZiwiG4Wtb2K9Pf884edRyuafJPX97tW99V+ss8dhmo2QKZfUdoba3MXGX0
 oI545+o0CPHxmHqREJnaZ5osrDtYP1NvB1cscP+8N7UABdW7SLSCH0Lts920cgpDD31r
 evrQ==
X-Gm-Message-State: ABy/qLbVkhTOkzSaDdRAoPM5kYGgX9fc1mnpbrAdxbgezcWu0FnOvGDq
 z+2kwZ+4vTIRS6EkVAjV88I4WA==
X-Google-Smtp-Source: APBJJlHouLoDACv2LRX/UAmxNnf0c79KiWx4q0cJh4SKbK+f2y/ZaCgpsgnHdGzgw/iFdXlqsQSk2g==
X-Received: by 2002:adf:cf07:0:b0:313:f4ff:30e9 with SMTP id
 o7-20020adfcf07000000b00313f4ff30e9mr552254wrj.53.1688073170880; 
 Thu, 29 Jun 2023 14:12:50 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 u12-20020adfdd4c000000b0030903d44dbcsm16754477wrm.33.2023.06.29.14.12.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 14:12:50 -0700 (PDT)
Message-ID: <44e89224-ff2e-2c6d-b8d1-2e9e18d67aca@linaro.org>
Date: Thu, 29 Jun 2023 23:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] target/riscv: Check for CF_PARALLEL instead of
 qemu_tcg_mttcg_enabled
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>, Eduardo Habkost <eduardo@habkost.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?= <frederic.petrot@univ-grenoble-alpes.fr>
References: <20230629120255.85581-1-philmd@linaro.org>
 <20230629120255.85581-2-philmd@linaro.org> <87jzvmxmfh.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <87jzvmxmfh.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 29/6/23 18:26, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> A CPU knows whether MTTCG is enabled or not because it is
>> reflected in its TCG flags via the CF_PARALLEL bit.
>>
>> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/riscv/cpu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 4035fe0e62..4dfa64af6a 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -473,7 +473,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
>>   
>>   static void rv128_base_cpu_init(Object *obj)
>>   {
>> -    if (qemu_tcg_mttcg_enabled()) {
>> +    if (CPU(obj)->tcg_cflags & CF_PARALLEL) {
> 
> Hmm have you checked that tcg_cpu_init_cflags() has executed by this point?

$arch_cpu_realize
  -> qemu_init_vcpu
      -> mttcg_start_vcpu_thread
        -> tcg_cpu_init_cflags

I'll document in the commit description.

>>           /* Missing 128-bit aligned atomics */
>>           error_report("128-bit RISC-V currently does not work with Multi "
>>                        "Threaded TCG. Please use: -accel tcg,thread=single");
> 
> Not that we can do anything about it but in linux-user we start with
> CF_PARALLEL unset and only set it at the point we spawn a new thread.

Hmm I'll give it more thinking then.

Thanks,

Phil.


