Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF0381AB17
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 00:35:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG64n-0006tn-SV; Wed, 20 Dec 2023 18:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG64l-0006tN-Cd
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 18:34:07 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG64j-00059A-On
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 18:34:07 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-42795ea3e35so1176011cf.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 15:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703115244; x=1703720044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Thny8/Sqo68HAOlHz+xF/uOQbDSn8lxi0+jhwmD4W14=;
 b=fTNctSDKsdN/Q30/EpSfNqx5DgS7Nql83GWhbzcd4YoljOAgoQ02PtJCcuUfwFwGeF
 ipjhdur3xQLrf+/cORoe74yw+tunCGRwjJiJbLflhq1yhhgS40kC2n/kP8EU9mPmUqbP
 7AUBrH/blv2HplhVmBOdS53fIcNKeGlmy8QY8PytyE6W60/8L/eEk9IBEqxw+r1Rkc/C
 y8+12Q+9BDpIaGRtDjclRJkrWUYK/Mujm3I5Ih6KyDdJUXtkgqG05RBtDryFMQQOEUWS
 V2NhLO5iky6QdcREQ7sybljHFiyfIW4u5yC7m8tvpPfJmvoltDZlzkPgRNlSxmi7EgOI
 wEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703115244; x=1703720044;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Thny8/Sqo68HAOlHz+xF/uOQbDSn8lxi0+jhwmD4W14=;
 b=J6rILgv+l3BOIsuWHrdmQ3SXsJf2lDe9Ppie3XCseiFrAhYIUlmLGQw6DgB2PwCBiX
 xCE7fgLsz5gQrnn2+GGmuK7CSGzxwUgx7lEVcnQUWC6w578jLH0vI1DnAs7Id0QzahPs
 O1QolNMyeJE9d8q7JzVpKHFZ5Lxq2qrf42w5+URFdKGkfVEuyTQsqoXEfpTeEvMJqX2p
 7/77W2zBfHkwUcn2+8IuKco8eDqF0yCRnLTSpdIHgHPeYtxna3TfDniwIB8ZKfWsJZBt
 LndMKgCRULxCWAeQ5r/5wmtdMKIG7vthnIv7IS9rq+u5wcEc7Y1ixTYnKxL+SaLt/2Zd
 BjVQ==
X-Gm-Message-State: AOJu0Yzw2xO0T64g6C4Hq7w3PThuqfjo5d6glK1s5aLdiXZtkSVF4qtF
 ELeEcUwXI6McwAhDfURpBeSWqw==
X-Google-Smtp-Source: AGHT+IEPDBuMxREo6KRBNyqRyS58VeZQGbyBJMegKGArtEPCVmBIkl5J7JqBwQUgd8ij9MzBVWHDmg==
X-Received: by 2002:a05:622a:118f:b0:423:8e6a:f7b with SMTP id
 m15-20020a05622a118f00b004238e6a0f7bmr29919801qtk.59.1703115244282; 
 Wed, 20 Dec 2023 15:34:04 -0800 (PST)
Received: from [192.168.4.227] ([172.58.139.164])
 by smtp.gmail.com with ESMTPSA id
 hb4-20020a05622a2b4400b00417fa0cd77esm300591qtb.80.2023.12.20.15.33.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 15:34:03 -0800 (PST)
Message-ID: <7f2c38bc-d3d8-4d22-867e-74330dcb2ab8@linaro.org>
Date: Thu, 21 Dec 2023 10:33:51 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] linux-user: Allow gdbstub to ignore page protection
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, philmd@linaro.org
Cc: qemu-devel@nongnu.org
References: <20231215232908.1040209-1-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231215232908.1040209-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x832.google.com
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

On 12/16/23 10:24, Ilya Leoshkevich wrote:
> @@ -377,22 +379,42 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>           flags = page_get_flags(page);
>           if (!(flags & PAGE_VALID))
>               return -1;
> +        prot = ((flags & PAGE_READ) ? PROT_READ : 0) |
> +               ((flags & PAGE_WRITE) ? PROT_WRITE : 0) |
> +               ((flags & PAGE_EXEC) ? PROT_EXEC : 0);

See target_to_host_prot where guest PROT_EXEC is mapped to host PROT_READ.
This should be

	flags & (PAGE_READ | PAGE_EXEC) ? PROT_READ

> +            if (!(prot & PROT_WRITE)) {
> +                if (target_mprotect(page, TARGET_PAGE_SIZE,
> +                                    prot | PROT_WRITE)) {
> +                    return -1;
> +                }
> +            }
>              /* XXX: this code should not depend on lock_user */
> -            if (!(p = lock_user(VERIFY_WRITE, addr, l, 0)))
> +            if (!(p = lock_user(VERIFY_NONE, addr, l, 0)))
>                  return -1;
>              memcpy(p, buf, l);
>              unlock_user(p, addr, l);
> +            if (!(prot & PROT_WRITE)) {
> +                if (target_mprotect(page, TARGET_PAGE_SIZE, prot)) {
> +                    return -1;
> +                }
> +            }

Is the mmap lock held here?  You're opening up a window in which a page may be modified 
but we don't catch the modification to translation blocks.

> +            if (!(prot & PROT_READ)) {
> +                if (target_mprotect(page, TARGET_PAGE_SIZE, prot | PROT_READ)) {
> +                    return -1;
> +                }
> +            }

I really really doubt you need to do this.  The page is not accessible, so why expose it 
at all?  If you want to do this, I wonder if we should instead be interacting with ptrace?


r~

