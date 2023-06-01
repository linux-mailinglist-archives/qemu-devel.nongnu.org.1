Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E527190B0
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 04:49:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4YMI-0006ju-NY; Wed, 31 May 2023 22:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4YMG-0006jH-Qm
 for qemu-devel@nongnu.org; Wed, 31 May 2023 22:48:12 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4YMF-0005wz-9Y
 for qemu-devel@nongnu.org; Wed, 31 May 2023 22:48:12 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-397f13944f2so229538b6e.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 19:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685587689; x=1688179689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L/eGAZNNy5ekExubn9tdH1R9J6sUFzSLjFysRi+efOU=;
 b=r9463slEyCFZzqh/dQzqSB+qawmUiQaOAw3AaQwg3eQep7y1b10V+L31Pu3xmsIN1R
 2ObVF0L+OWwvhC3vBZcgmQD1qL3hxUEdK+BFnU2sm8qmQbBRS+y73Ofy4keuF4Ztz2zC
 IW+C6m7WMgdCHJV+J4HjzUMMLxw3si5Vq2Rh/AiSwyY6o623EGKYD4WYneVvjY5rrjtv
 yY9+goQBjg5ofRb2R2urHxEFkbehGY7DznTNe2Kixi/4Z9ExTS+aggZNeRFNXxiIferL
 p9X0uxlzhIJN4jVDi5Yc1ZaJcSXa12j0khVzuUP0TJMS7Ionly+GKxnDL0qautYSvjSo
 M9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685587689; x=1688179689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L/eGAZNNy5ekExubn9tdH1R9J6sUFzSLjFysRi+efOU=;
 b=aJu/LXai6d7wNqsyWSnbFIY1DbMswzxMz3eWnAL71S650L/oBpN4PRotmnpSQ2SiEB
 7i31Yih+xQAlcRq48vfWVjTm1IF79Y7FZp+pmDwqLtlSF7kBaLR1e06kHdpC9IYkFus+
 cnXQBOyJj5qDdyWwaXgFgPnS1fdtRixPld3tQ+L7s8gZqZP5aDI04+v08Oa6ejbYgWi0
 fgKGOzZ+e31Erzi+gj+wJE3r5R1kSNJdVl8gLqZow29BSwZc2B2dg8rQSC45P2jUlQIq
 r6Z2hQ+Z5VUD7PHz9CUfCoO51cif4FxsTxw7Fe98n+6Lw4FEF/Os5tKYF9B53q+JziT1
 QmnA==
X-Gm-Message-State: AC+VfDwpLMocOrXgUTjegL0Q3ooIYCAIeP6xYIfi363lpiSb5YF0YAHr
 LKDwGucpMo9pXlEWqBOAIuBNJQ==
X-Google-Smtp-Source: ACHHUZ4Rfn8ZGRSz2v6zrMl04V8CtTx/CbeGWi6OPUa5vuSb2wWQMSyQSMVSMts2lC/h72s/w43DHA==
X-Received: by 2002:aca:b98b:0:b0:398:4217:e890 with SMTP id
 j133-20020acab98b000000b003984217e890mr6013649oif.2.1685587689681; 
 Wed, 31 May 2023 19:48:09 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 d4-20020aa78684000000b00640d80c8a2bsm4020009pfo.50.2023.05.31.19.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 19:48:09 -0700 (PDT)
Message-ID: <fad791ac-c855-4930-e0be-0dff4fbfe1df@linaro.org>
Date: Wed, 31 May 2023 19:48:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 02/10] accel/tcg: introduce TBStatistics structure
Content-Language: en-US
To: "Wu, Fei" <fei2.wu@intel.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-3-fei2.wu@intel.com>
 <3653fd43-6fde-7974-f723-51f1c06c069f@linaro.org>
 <beb21871-3661-3096-2317-2cfb16bb0327@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <beb21871-3661-3096-2317-2cfb16bb0327@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/31/23 18:30, Wu, Fei wrote:
> On 6/1/2023 7:59 AM, Richard Henderson wrote:
>> On 5/30/23 01:35, Fei Wu wrote:
>>> +    /*
>>> +     * We want to fetch the stats structure before we start code
>>> +     * generation so we can count interesting things about this
>>> +     * generation.
>>> +     */
>>> +    if (tb_stats_collection_enabled()) {
>>> +        tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags);
>>
>> If cflags & CF_PCREL, then 'pc' should not be cached or matched.
>> Using 'phys_pc' will suffice, so pass 0 in that case.
>>
> OK, tb_get_stats(phys_pc, (cflags & CF_PCREL ? 0 : pc), cs_base, flags);
> 
> btw, is it possible to drop 'pc' even w/o CF_PCREL setting in cflags?
> Two TBs with different 'pc' but same 'phys_pc', are they the same?

For the purpose of statistics, yes, plausibly.

Knowing how many different translations of the same bit of libc.so, for a guest that does 
not support CF_PCREL, could be revealing.  In any case, you can get back to the virtual 
addresses via tb_stats->tbs[i]->pc, so long as tb_stats->tb[i].cflags & CF_PCREL is not set.


r~

