Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5615480F926
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 22:24:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDACu-0004BF-W3; Tue, 12 Dec 2023 16:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rDACs-00049X-AM
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 16:22:22 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rDACd-0002Pu-H8
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 16:22:22 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d319a7a35bso24487325ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 13:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702416125; x=1703020925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nK3E7XI1vV56USqZxpxkMZlay2BU3qCNKlQHNH9zBEs=;
 b=UhwnCCGU0Y299Lj24QkfM45xRqLr/sEHcF9QfQo6KPNlRjB3+dSntwJ4zkvAbDwDSH
 oi2Je8as7CAH7h8Da2zdbzibZW9LLmxZ3p4YE3Wj6L5LjdsFxYB9jEMcNEl0gsJequ1d
 aVoI46g+Okm9/6gwjcIqaC4CkRmwhSdQTf6bO97A4X3FRyX5Z2ZW/WcQE3fsaDGBApb1
 jgKGxAEHiOIrEznB9/0qohpPAGGGx4NTf99BrIDv6OWZuNH7fhnmYA9KM0QA0NTxNx4t
 IglTmVq7SkbBsCTJTGv+4FOyweEA+b6DfdAZOEF0UtyER4J2NVdCsza4VdDdFUcpOQlP
 RcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702416125; x=1703020925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nK3E7XI1vV56USqZxpxkMZlay2BU3qCNKlQHNH9zBEs=;
 b=icHljQzX6Ab2LHfj2io+D8vvemiDP5NwzSiB9Yt6HVVAymVwk3ZUjdo+VCoR2bgHLC
 AgJtHy1POUED+RDfln+9bZg+wS9viOUMmk6Qo9bEKUPdUpKuWxdcRAjitseziXqUhN11
 4EVqsAIhv4aqdKxCoESNBTggyby8BFBDjZudK6Fnlze061fLFE7XOEVheARaGGE+Zlmb
 V6V7hrcYQRFpnx309IPeCGDkYgwmCyTN1RxGhEu0mJZIMojraTmUEjN/jGnmkL0r4s8S
 m80DMdu2vQTe9zvDhditOfCB6Lt0x/QERKGJJA9khfs69N7CbPPi2FvncR+7k0kTud8/
 uGuA==
X-Gm-Message-State: AOJu0Yy92rmk2gjzLHoK449tLe6D/LK1GFbU7awzMbom5bFnTKP8n9XB
 5qCwJ/N/oVtF5sRABil7AudfMA==
X-Google-Smtp-Source: AGHT+IHn4WKaNvM18/PbSXJYQLYf9GwjQc6+RjsYFZ8GsWRwgiMjYrMZ7ZQFCW0Fh/FW76HVynaDMg==
X-Received: by 2002:a17:902:d508:b0:1d0:6ffd:9e06 with SMTP id
 b8-20020a170902d50800b001d06ffd9e06mr7377358plg.88.1702416125312; 
 Tue, 12 Dec 2023 13:22:05 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a170903228800b001d052d1aaf2sm8980762plh.101.2023.12.12.13.22.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 13:22:04 -0800 (PST)
Message-ID: <0d42f12f-3af7-403e-9c0e-db462a3139b1@linaro.org>
Date: Tue, 12 Dec 2023 13:22:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.2?] target/i386: Fix 32-bit wrapping of pc/eip
 computation
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231212172510.103305-1-richard.henderson@linaro.org>
 <CABgObfauRJmT5hS9nv1nORwAYj3biZm_xrqoMfADdqJN9_+UYg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfauRJmT5hS9nv1nORwAYj3biZm_xrqoMfADdqJN9_+UYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 12/12/23 13:08, Paolo Bonzini wrote:
> On Tue, Dec 12, 2023 at 6:25 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> In 32-bit mode, pc = eip + cs_base is also 32-bit, and must wrap.
>> Failure to do so results in incorrect memory exceptions to the guest.
>> Before 732d548732ed, this was implicitly done via truncation to
>> target_ulong but only in qemu-system-i386, not qemu-system-x86_64.
>>
>> To fix this, we must add conditional zero-extensions.
>> Since we have to test for 32 vs 64-bit anyway, note that cs_base
>> is always zero in 64-bit mode.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2022
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> This may be too late for 8.2; if not, then 8.2.1 and 8.1.next.
>> I think I have found all forms of pc <-> eip, but another set
>> of eyes would be appreciated.
> 
> Looks good, but perhaps you could also squash the following?
> 
> diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
> index 2c6a12c8350..83ee89579b8 100644
> --- a/target/i386/tcg/tcg-cpu.c
> +++ b/target/i386/tcg/tcg-cpu.c
> @@ -52,7 +52,11 @@ static void x86_cpu_synchronize_from_tb(CPUState *cs,
>       /* The instruction pointer is always up to date with CF_PCREL. */
>       if (!(tb_cflags(tb) & CF_PCREL)) {
>           CPUX86State *env = cpu_env(cs);
> -        env->eip = tb->pc - tb->cs_base;
> +        if (tb->flags & HF_CS64_MASK) {
> +            env->eip = tb->pc;
> +        } else {
> +            env->eip = (uint32_t) (tb->pc - tb->cs_base);
> +        }
>       }
>   }
> 
> 
> It wouldn't be the same bug as 2022 (it wouldn't be new with the vaddr
> change) so it's okay to sort out this extra case after release.

Good catch, I'll squash it.  Thanks.


r~


