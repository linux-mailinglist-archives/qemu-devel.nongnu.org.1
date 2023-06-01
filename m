Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0131671919F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 06:10:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ZcF-0007Ks-36; Thu, 01 Jun 2023 00:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Zc9-0007Ff-0t
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 00:08:44 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Zc7-0004dB-Ec
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 00:08:40 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-392116b8f31so139928b6e.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 21:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685592518; x=1688184518;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EpvVmzqeddbaeLR//NYYOjtq5SDhaE/nOLFYxPd2yGU=;
 b=YGCJY4GbUxg32QdmKliOmZZ0YC06osFJagLhQP1AeNdwd+bo5oBUl+iVvWP3VFkDWn
 khbLvJ0vnGY4SLu+Czm56sYX/BgJ0wJFVwaLX2ul4KlJ+jUlQp/n9Z3yoH28xZAwZcyf
 vw7hhKLQj4ZrsF7EyhYpEDxTqRN7OncZWTwnhCCfVfENqJBF5YaqI9kDd+MmhIKmtrc8
 RybumJ72f3xlF2iq9wZV2TS7nIwwQRbn2hzRUAoMZpf3FYjeFbHPljkCiQ/xGtrWf5vS
 WVmPVKqBr0tbJX8U8dEQEV5O+DREg/REZKQ6zI1x4Epdu6XPiplRRLDnHeZhqmHb0gAR
 e2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685592518; x=1688184518;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EpvVmzqeddbaeLR//NYYOjtq5SDhaE/nOLFYxPd2yGU=;
 b=jO9zsJCe+xsp4foDYuiClTu/PJVbWolHYNrvJBnIiblyP+MmkwU7r1CZgXNmQT1hMk
 wWpQEafe1EMbnIILkOI0vIM0ofxhyKtn5tyMAxnoEK+pPfX8JbhgTFibbg1cywk68R8u
 z2ZL+3DppUpRnfQqQQcNVq5/jYRufXqZ//FKgRlt4gTMQMeP7TRfljOKm8zOVFz9gUrt
 7HtPmVPRyOHUdvclOWix5Sw055uuqoCaIqEbYdN9Jwg4S98BEl5KPYn0/Wy/IyMM9Dqg
 MIWf5RSzGP4spP/Mu810TPe8BWcTbnnWrf8OGMg+JoEVn66tcT8lL4w6IxwnXUhTBH5g
 JV/Q==
X-Gm-Message-State: AC+VfDx55QcEBFUFaZTak3L/hxCLCwoBsjzzet0yyVDkW9Is5IiPINOU
 gg6oInSic12GrD9h/hITPiQMCg==
X-Google-Smtp-Source: ACHHUZ5iBVBa9RpIglrbqX8s1RAgs0aVo33WtuxlfRA63wz28nf3fWN0XmSfmV8OREgDfDHv3D4Uvg==
X-Received: by 2002:aca:641:0:b0:398:2eeb:a9c2 with SMTP id
 62-20020aca0641000000b003982eeba9c2mr4863346oig.32.1685592516491; 
 Wed, 31 May 2023 21:08:36 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170902b28b00b001b1920d000bsm819323plr.234.2023.05.31.21.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 21:08:35 -0700 (PDT)
Message-ID: <bd19daca-6b9c-0302-04e6-427a0cfe8072@linaro.org>
Date: Wed, 31 May 2023 21:08:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/2] Implement AES on ARM using x86 instructions and vv
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20230531112239.3164777-1-ardb@kernel.org>
 <722d7683-80b4-bb23-3ca2-77f8de23b801@linaro.org>
 <CAMj1kXEH4zFcOZGz0HvTbpcMUup+cyZEr0JQxH1uXpGcbAc6ow@mail.gmail.com>
 <c8499cae-befb-7130-3114-350ee97bf49d@linaro.org>
In-Reply-To: <c8499cae-befb-7130-3114-350ee97bf49d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 5/31/23 10:08, Richard Henderson wrote:
> On 5/31/23 09:47, Ard Biesheuvel wrote:
>> On Wed, 31 May 2023 at 18:33, Richard Henderson
>>> Thanks.  I spent some time yesterday looking at this, with an encrypted disk test case and
>>> could only measure 0.6% and 0.5% for total overhead of decrypt and encrypt respectively.
>>>
>>
>> I don't understand what 'overhead' means in this context. Are you
>> saying you saw barely any improvement?
> 
> I saw, without changes, just over 1% of total system emulation time was devoted to aes, 
> which gives an upper limit to the runtime improvement possible there.  But I'll have a 
> look at tcrypt.

Using

# insmod /lib/modules/5.10.0-21-arm64/kernel/crypto/tcrypt.ko mode=600 sec=10

I see

   25.50%  qemu-system-aar  qemu-system-aarch64      [.] helper_crypto_aese
   25.36%  qemu-system-aar  qemu-system-aarch64      [.] helper_crypto_aesmc
    6.66%  qemu-system-aar  qemu-system-aarch64      [.] rebuild_hflags_a64
    3.25%  qemu-system-aar  qemu-system-aarch64      [.] tb_lookup
    2.52%  qemu-system-aar  qemu-system-aarch64      [.] fp_exception_el
    2.35%  qemu-system-aar  qemu-system-aarch64      [.] helper_lookup_tb_ptr

Obviously a crypto-heavy test, but 51% of runtime is certainly worth more work.


r~

