Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D8A70EBD9
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 05:26:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1f7m-0001GE-P4; Tue, 23 May 2023 23:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1f7j-0001Fn-5g
 for qemu-devel@nongnu.org; Tue, 23 May 2023 23:25:15 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1f7h-0002gC-Hn
 for qemu-devel@nongnu.org; Tue, 23 May 2023 23:25:14 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d426e63baso361330b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684898711; x=1687490711;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UwTuhPIZRe27Mii1f0+zqsBjjmsuhrJllYBH8cIIbA0=;
 b=rTDs1wlUB9F1U1E5MnY9HPbsZIIIuKh/86y9RTMyo4L3bHrSbe4OjgKAnL+U7+ExW1
 7xhid/mqPIHjePa5bpqupBnF/vjMFUc+ECpVI4LQcFtXUU2BY4mmEfsmVYTi7eEGFR4o
 P2X3YRZvsYcid+pL1ZcPDL6yxXtpix2ZIjbg21FlEZDrgibgBBASX30/L8X59XxX2gbl
 HAm8HnUk7Rf1YrTj5GcrT2gtZoBd6ovtxDYQ7l1eymzyIqpcFgU1qLx9GpqR5uTV97nr
 IfCe5xyHDj2+3OiVvbEcHBfINdNXtApDEsAsOeidILKkw5G3iEit8AaA/cVf4ajDv6rS
 UOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684898711; x=1687490711;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UwTuhPIZRe27Mii1f0+zqsBjjmsuhrJllYBH8cIIbA0=;
 b=EKlisMv9zYZnwkicI0F2IpLKsP+Blca1inzVKlYseiRryVobO/GZDQZVZ8oSPpKhj1
 kBr3dcvzXWx7kyoLmk+1FV34IyyFgfoMldfQ1x9U1MCS/UyRTRPxcGrva0JmXCoXuAbh
 Uq7/Oy5QrWnHyut6jX0q1AV+h4ZQCi0zdGujgFFNdv3nbLfy44NidVyuv9SgxUgUiZRx
 9bGrXzgKOlM+pNgGhS7hvVcBecJZ68WZHUMTm1Ir6FenqVmb4oMbnOTvfLEeBa0Yw0gM
 VU933MU8Iq3pBu8W8s1N7MmRs2iTCO1VFw//IOq/mAIY9YDU9TRjnxZJhOLeT8HMlamw
 6UQA==
X-Gm-Message-State: AC+VfDw3TTKismdmIi9pDgbkh2lpJ9ABGMkqf3BqGA+dk0rYZrZ/9RjJ
 hun4evxQ1d8UfBO9P/jf5IqlQ1abZ5N2FFtVOPQ=
X-Google-Smtp-Source: ACHHUZ53/bjzCed6uoua0YvREYEgH7P3UINGOUiyPYmQxoCIhG2PxmmFnFp3pwhhDcggWgL+nw7BvA==
X-Received: by 2002:a05:6a00:14d4:b0:64f:52c9:ddd5 with SMTP id
 w20-20020a056a0014d400b0064f52c9ddd5mr1477480pfu.34.1684898711192; 
 Tue, 23 May 2023 20:25:11 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 83-20020a630756000000b0051416609fb7sm6630062pgh.61.2023.05.23.20.25.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 20:25:10 -0700 (PDT)
Message-ID: <49a53043-2dce-a805-d17f-e642c56c8ebc@linaro.org>
Date: Tue, 23 May 2023 20:25:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v2 00/28] tcg patch queue
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230524011452.807053-1-richard.henderson@linaro.org>
In-Reply-To: <20230524011452.807053-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 18:14, Richard Henderson wrote:
> v2: Testing revealed a missing earlyclober in the aa64 inline asm,
> which showed up with macos testing.
> 
> r~
> 
> The following changes since commit aa33508196f4e2da04625bee36e1f7be5b9267e7:
> 
>    Merge tag 'mem-2023-05-23' of https://github.com/davidhildenbrand/qemu into staging (2023-05-23 10:57:25 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230523-2
> 
> for you to fetch changes up to a57663c5a38c26516bde24ecb3992adff4861a31:
> 
>    tcg: Remove USE_TCG_OPTIMIZATIONS (2023-05-24 01:10:44 +0000)
> 
> ----------------------------------------------------------------
> util: Host cpu detection for x86 and aa64
> util: Use cpu detection for bufferiszero
> migration: Use cpu detection for xbzrle
> tcg: Replace and remove cpu_atomic_{ld,st}o*
> host/include: Split qemu/atomic128.h
> tcg: Remove DEBUG_DISAS
> tcg: Remove USE_TCG_OPTIMIZATIONS

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~



