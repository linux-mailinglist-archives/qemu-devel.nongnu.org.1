Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB4778EF81
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 16:21:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbiXH-0005ry-3w; Thu, 31 Aug 2023 10:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qbiXF-0005n5-0o
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 10:20:37 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qbiXC-0003ei-FO
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 10:20:36 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6bca5d6dcedso731853a34.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693491633; x=1694096433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SXYUI5y2T06OUaQK0xvy01Q3bHqiLYEWGJRGIsQNGNo=;
 b=n3DUxpa2ebrXWZWv2o4CcGfIAar5WMcROmJ3Qnq4BhCMNlpaJkMPYdsDDGV8vWrBaw
 oMLESquC1EVEfc1Uc3t7cAFfM2Iaiu2WMklcUyPvLAH4uWHnREjtNuf9DJFIIookm9rV
 Y/gBPsRe1JRru2iTwyUajbBPU77T6jYVwofw2Jd6blhE+CvtHrnRrxNiTb9itNR+pJ6Q
 62BXpc6CUw6Cz8zQAiklFfyyCyi41Cb3QlcWm1MrciAJK7hbbaloqJzRRmnRnOxGrwK8
 K90Daf/aIti8Nib6vsuG4SZwRbHpMz4ffAmb4KIbD7tOjkncrvvea/1mqEtVeyeUS0qv
 oY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693491633; x=1694096433;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SXYUI5y2T06OUaQK0xvy01Q3bHqiLYEWGJRGIsQNGNo=;
 b=RchHIhCJLRnEDyryUEWCfQJtm9Nr+Vfg5rvAp7kbhDLgTcEC5vqwn54N7FanUEOFI8
 rpE8E5HSayCjE5UfHWMnwFuuATWeEvIT4QqvgZxMo9LEBQSz00LK0l+athFEA8BBJIkH
 W77MNQmfISait+Jhea5Fg16Wrh1x9nZYsC/Z5KPwDaQpRCNm7FByp38PvPS7ER5gpdrP
 rgwoPvz4XSENNSzMWIXmshc6T6O1cwyNNfRQxUXlmXvKKrSQypfV9oQQMF9AobYcbJC0
 8H+faSrqZoZakUUAWAbe+crMM47TKCddWhLm0gr2e+GWMkNMb3FHsVSrCEKLoI0PwkdB
 GMmg==
X-Gm-Message-State: AOJu0YybP/7WytOMCCXqiNVv7PRHnAi5eOWOZQyPeMuy2nggoE9vEg3u
 pGYaUENAvPI4EI0ua08dAs1ubw==
X-Google-Smtp-Source: AGHT+IEZmzJw+OpxtiKmfZFnvPuVcUKmy1KsmiZntn3/CWK8QzwFj7CTf9/HbZ/H6xgT7GAhKbWgfw==
X-Received: by 2002:a9d:6c82:0:b0:6bc:e049:b28f with SMTP id
 c2-20020a9d6c82000000b006bce049b28fmr5538860otr.34.1693491633037; 
 Thu, 31 Aug 2023 07:20:33 -0700 (PDT)
Received: from [192.168.68.108] ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a05683011d500b006b8c277be12sm747496otq.8.2023.08.31.07.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 07:20:32 -0700 (PDT)
Message-ID: <35286ce3-ffff-dd42-8b9d-3a45804bc31a@ventanamicro.com>
Date: Thu, 31 Aug 2023 11:20:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v8 11/20] avocado, risc-v: add opensbi tests for
 'max' CPU
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
 <20230824221440.484675-12-dbarboza@ventanamicro.com>
 <20230831-1c9bd710f47d8bd9eeeb46c8@orel>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230831-1c9bd710f47d8bd9eeeb46c8@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 8/31/23 10:16, Andrew Jones wrote:
> On Thu, Aug 24, 2023 at 07:14:31PM -0300, Daniel Henrique Barboza wrote:
>> Add smoke tests to ensure that we'll not break the 'max' CPU type when
>> adding new ratified extensions to be enabled.
> 
> I'm not really sure what this test proves other than we didn't remove the
> minimally supported set of extensions that opensbi requires to boot. The
> other opensbi tests appear to be ensuring boards can boot, rather than
> cpus.

I added this test because the 'max' CPU takes extra steps to init (e.g. enabling
a bunch of extensions) in comparison with the other CPUs. I agree that it would
be better to add a Tux test like we already have for the rv32/rv64 CPUs to ensure
  that the CPU is able to boot up to prompt.

I'll see if I can get that working and, in that case, we can ditch this test and
use a TuxBoot test instead.


Thanks,

Daniel

> 
> Thanks,
> drew
> 
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   tests/avocado/riscv_opensbi.py | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/tests/avocado/riscv_opensbi.py b/tests/avocado/riscv_opensbi.py
>> index bfff9cc3c3..15fd57fe51 100644
>> --- a/tests/avocado/riscv_opensbi.py
>> +++ b/tests/avocado/riscv_opensbi.py
>> @@ -61,3 +61,19 @@ def test_riscv64_virt(self):
>>           :avocado: tags=machine:virt
>>           """
>>           self.boot_opensbi()
>> +
>> +    def test_riscv32_virt_maxcpu(self):
>> +        """
>> +        :avocado: tags=arch:riscv32
>> +        :avocado: tags=machine:virt
>> +        :avocado: tags=cpu:max
>> +        """
>> +        self.boot_opensbi()
>> +
>> +    def test_riscv64_virt_maxcpu(self):
>> +        """
>> +        :avocado: tags=arch:riscv64
>> +        :avocado: tags=machine:virt
>> +        :avocado: tags=cpu:max
>> +        """
>> +        self.boot_opensbi()
>> -- 
>> 2.41.0
>>
>>

