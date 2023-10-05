Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E30F17BA730
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:58:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRfU-00036M-83; Thu, 05 Oct 2023 12:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoRfR-000369-Ji
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:57:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoRfQ-0008FT-4c
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:57:41 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4066241289bso11102505e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696525058; x=1697129858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FuosKPA6v7j9uyc9yYuedyH11cKK0zuj4K2Q2OYjZ9M=;
 b=hG8jE76NW0RiIuWph5T7sqbl4ip+/mnTuZ2o3i7OWDZCDNIw/LkTNjjaLcMn/1n2MO
 oDy5YFMC5YOEC5+Mm1M1v96in1mlscGqXtAb4xdxKfbMHbyXuLb7nzUGIjNuw8dVdLaE
 4EYo/edQnak9i1b781PcpwEpR0b9FWuHPSJYdl7MMRG/RVJip1FU+Bfk7bMoPQRVge3E
 D4IXvAjMCtpGWc1M+ahAiIdmJNownZ9rXbwCfuv1mHjfghiQMSKzx+UE03a/omGgtu54
 10bXxIv5lqrI+DzUHM17xhTMW2IWnmQ1Jfu3c6PXhDnQbOF0qyB9scGgzxIGGwZyw6/1
 WzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696525058; x=1697129858;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FuosKPA6v7j9uyc9yYuedyH11cKK0zuj4K2Q2OYjZ9M=;
 b=t8QxkbTiqrBb5EEJq9NOjCB6Swoqj8h7hOv5mWmf7X+j6OctI7b32Ll1L9MBA01wm5
 2ixWhkyN7CGyiubcpaFiDl5A8SeI+SNt0zFxaFOCgoaZkFXSqXJnl5livC25jBrlw/7i
 GU7S0DtKmYSQSV1qCCU+BYl8Smt+RZkRF9SrSLMvpDIu9WHt4BZS3VYI9v3x0lMMN3tL
 rdb9HuhwweLIb1YPU2feUIDexI7fnztZDnuySe8xbhGhjeOMDqe9tPofGrQvJadcNL2C
 07RahgfuXHrcOFiEDXVj1lfWxrKMDaJ9+zKT6D17uExoyKMLBoR9Db1yJd74WpegzoUJ
 K9yg==
X-Gm-Message-State: AOJu0Yzrjbe+72eXbtPHtOwjDEqsYNi5PXddhHyuw3HLnlSuWfRQEdIz
 TukJMuPkws1DrE+PirUtkFBlfei1Cj+IsshkAwc=
X-Google-Smtp-Source: AGHT+IFmsLrWKHKTVGwk0S6nlQTJl8mpM+D9KzTA3otF0z6DoCvbSUv9bDSdn51KJRh1eFQ5eeLjUw==
X-Received: by 2002:a7b:c858:0:b0:404:737a:17d with SMTP id
 c24-20020a7bc858000000b00404737a017dmr4825443wml.9.1696525058374; 
 Thu, 05 Oct 2023 09:57:38 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a1c7719000000b004065daba6casm4171093wmi.46.2023.10.05.09.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 09:57:37 -0700 (PDT)
Message-ID: <6e9a1549-93f5-fab6-d083-e7a61d79d3bb@linaro.org>
Date: Thu, 5 Oct 2023 18:57:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 09/10] tcg/riscv: Use tcg_use_softmmu
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
 <20231003174356.1602279-10-richard.henderson@linaro.org>
 <90a876ec-3fec-c9a2-0c70-be484b7b3282@linaro.org>
In-Reply-To: <90a876ec-3fec-c9a2-0c70-be484b7b3282@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

On 4/10/23 08:42, Philippe Mathieu-Daudé wrote:
> On 3/10/23 19:43, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/riscv/tcg-target.c.inc | 189 +++++++++++++++++++------------------
>>   1 file changed, 97 insertions(+), 92 deletions(-)
> 
> 
>> @@ -2075,10 +2080,10 @@ static void 
>> tcg_target_qemu_prologue(TCGContext *s)
>>                      TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
>>       }
>> -#if !defined(CONFIG_SOFTMMU)
>> -    tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
>> -    tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
>> -#endif
>> +    if (!tcg_use_softmmu && guest_base) {
> 
> Do you mind mentioning the 'guest_base' change here?

Nitpicking, it would be clearer as a preliminary patch, with

Fixes: 92c041c59b ("tcg/riscv: Add the prologue generation and register 
the JIT")

>> +        tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
>> +        tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
>> +    }
>>       /* Call generated code */
>>       tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, 
>> tcg_target_call_iarg_regs[0]);
> 


