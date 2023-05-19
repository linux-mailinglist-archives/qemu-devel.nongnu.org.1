Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46855709AC7
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:01:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01bE-0002Yd-NH; Fri, 19 May 2023 11:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q01b4-0002Xo-6R
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:00:47 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q01az-0001hs-Db
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:00:42 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1a516fb6523so31818115ad.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684508436; x=1687100436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L1cvhEp5ZR87MBsvwJCWB0RGjMDQew3io93LmMVniq0=;
 b=eKRvKT+GKOq6h8QyqU9iSriO0I0FZm/Ap7Ky1lNIpSGubGjCmiDMti/Y+zLG+V+cy+
 dBMmKLBAs+4OjbB7yHdJsrdXvIGChIgsLHcBsN9oDTfgEoHEsLD483NRhcKtq0+UZ6CQ
 rEj6Lgp5OqoY+xRHz6f3HPSFxrKfUlgfFGjcXMpebP9l56rnvnyIIm1ZyECehFIp6V2X
 Qp7BDLY4RhWy49lU1Wb2UruAGPNXNn0yOgJZ7basFz2XrTY0l81RC0Hg8++JBNClZ2U6
 HlTfICJ90xA4lqvTges/IaZ5F0bQMhQ5AZyGKZ8CUr4aY9JVB/GJEgWf2Qqwk2JJbGAM
 c5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684508436; x=1687100436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L1cvhEp5ZR87MBsvwJCWB0RGjMDQew3io93LmMVniq0=;
 b=DMAjAzNRWsAq58mhXyJxGHq6zFay/PP7X9vwz7YfmbyeelKdMm1+bmsUpOuOz/e1iS
 B8uUWCB5ryderDg+EWFHWaW7eHWuoCSSy0Yf9SmGXU5MzqKwdGNcF1fNRcmVs6luWZqD
 5BT7wC0p6Lg3K/jW7ym044Nq1pD5MaEfNLhMHGWOYi7Jp/kNpQqHuM1m8ScswXT0XMSM
 RA5CNqd9UJqOyvnvdjT9WTtrKozupn+/d/cmfn+TZTYmIevH8IBFLcUAgScKEHenATel
 xn1VKMbYjNPeQo8k4sm51a9qIwrPEtCHS7TJ2rYcf+hMR80oi0Glpi/QZDMg2qyDiRwa
 +zTQ==
X-Gm-Message-State: AC+VfDz2KHdRUiE3gQI+EenFZT58NCW63oEKSmwCcdSQ8hC/36hNsrDU
 +2IAA21wt1kG596WZofYsmff9g==
X-Google-Smtp-Source: ACHHUZ7CoaUueCtBwheDTkxtA1pqPbAuBdKn6Y9cEhVjzZEt6Z/dXFy332NLaeAjxi+y7WKiRI3AiQ==
X-Received: by 2002:a17:902:ef82:b0:1a5:3319:12f7 with SMTP id
 iz2-20020a170902ef8200b001a5331912f7mr2617012plb.50.1684508436565; 
 Fri, 19 May 2023 08:00:36 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:686f:d1bb:8fc4:dc38?
 ([2602:ae:1598:4c01:686f:d1bb:8fc4:dc38])
 by smtp.gmail.com with ESMTPSA id
 jb15-20020a170903258f00b001ae626d051bsm3575943plb.70.2023.05.19.08.00.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 08:00:36 -0700 (PDT)
Message-ID: <d66f620e-d19c-8d4a-ae10-4c5732d73df2@linaro.org>
Date: Fri, 19 May 2023 08:00:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Revert "arm/kvm: add support for MTE"
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
References: <20230519145808.348701-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230519145808.348701-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

On 5/19/23 07:58, Peter Maydell wrote:
> This reverts commit b320e21c48ce64853904bea6631c0158cc2ef227,
> which accidentally broke TCG, because it made the TCG -cpu max
> report the presence of MTE to the guest even if the board hadn't
> enabled MTE by wiring up the tag RAM. This meant that if the guest
> then tried to use MTE QEMU would segfault accessing the
> non-existent tag RAM:
> 
>      ==346473==ERROR: UndefinedBehaviorSanitizer: SEGV on unknown address (pc 0x55f328952a4a bp 0x00000213a400 sp 0x7f7871859b80 T346476)
>      ==346473==The signal is caused by a READ memory access.
>      ==346473==Hint: this fault was caused by a dereference of a high value address (see register values below).  Disassemble the provided pc to learn which register was used.
>          #0 0x55f328952a4a in address_space_to_flatview /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/exec/memory.h:1108:12
>          #1 0x55f328952a4a in address_space_translate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/exec/memory.h:2797:31
>          #2 0x55f328952a4a in allocation_tag_mem/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../target/arm/tcg/mte_helper.c:176:10
>          #3 0x55f32895366c in helper_stgm/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../target/arm/tcg/mte_helper.c:461:15
>          #4 0x7f782431a293  (<unknown module>)
> 
> It's also not clear that the KVM logic is correct either:
> MTE defaults to on there, rather than being only on if the
> board wants it on.
> 
> Revert the whole commit for now so we can sort out the issues.
> 
> (We didn't catch this in CI because we have no test cases in
> avocado that use guests with MTE support.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> Richard, do you want to apply this to master as a buildfix?

Can do, yes.


r~


