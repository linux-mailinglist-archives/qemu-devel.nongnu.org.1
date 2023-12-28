Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD4E81FBA3
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:48:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIz9Z-0000Oo-03; Thu, 28 Dec 2023 17:47:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIz9W-0000Od-KP
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:46:58 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIz9U-0006LL-Vg
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:46:58 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3bbc648bed4so1444580b6e.3
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703803615; x=1704408415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h5LIdoYz1HndAXTpIzdVX3DW9+9N+L/bWX4ogXaKsEM=;
 b=W0Q0+cw5GUEAg4dL6AGUyoMuHbLM7kJLRysV44bAExEagOxrjGal/9EzeqVmTWmefr
 BxEYzjoYv2w2j5pMipdCQ4OsajlrDgBJKQS/wQyBQUwvLHAK2fuF5HzuX3dFBWMTF5XC
 DGNrkXK2jBV6WXrqZDpp7MFuyNsN7JpUet9RqVkDqPeQEEjf0hDmXsMQT2wVkh+REI77
 qAYl3+PWzykbTNRph9wKCFlTBTfwzZ80NDdkDk/SN5L2DhpL1Y/YT6B62oaMhaUz02Lm
 wcD70g27w9EZ6rn3R4Ruv3bpBzaxn+qBnwBQN5yFHK0OiLz2a9YMRdPnrQEKAyJIhcQJ
 BL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703803615; x=1704408415;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h5LIdoYz1HndAXTpIzdVX3DW9+9N+L/bWX4ogXaKsEM=;
 b=rHDCWED5iW5eqCVfErtSr/F3OYymQGnt9Ulk4us9pwyTQXkpNVN1a5cyA8dq6Sp8de
 o7UO25qFVYBsqiQ7t5UoAq69XMMuXpIYrP/cpFbUvp9sgt7xqmcXbaq0f6HyqqJTJ7FG
 pRIo2KDNNLLEtxXsAaC0sgAJRHJrkgtVFSurOu2HoQMsQAV5Z/9caqpiwbrcctzFrHfX
 BUIC3Tgw4Ft4VZJ4hBc50ASX6vG6njN6pWXru8xv34GwoSnC0bTtgkUHzKqo23r5+PbH
 v0bB0WpRwfm+fSwkmWF0CwzmjCETRgcezmt00XqOr4yen1p42U7FqGDbnoNWk7tpOBSp
 VGxw==
X-Gm-Message-State: AOJu0Yx3yrinDscvHsp/RGfInIswZK5y2OeYAIrrcgXKpiW+5LInYMcv
 JQ5HJ7vpc6pF4gt4nRaqYOntmplAOUy2Vg==
X-Google-Smtp-Source: AGHT+IEgY6s9RMZY2hUFT3n6uYc7OZnDPNzBTpF7SqiuSA/JgywV0vXfPsAXjvAayhr6hjMKY9cbsQ==
X-Received: by 2002:a05:6808:180e:b0:3bb:d6f5:d224 with SMTP id
 bh14-20020a056808180e00b003bbd6f5d224mr1365799oib.6.1703803615622; 
 Thu, 28 Dec 2023 14:46:55 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 p184-20020a625bc1000000b006d8610fcb63sm14629385pfb.87.2023.12.28.14.46.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 14:46:55 -0800 (PST)
Message-ID: <259d44d4-1f35-408e-a1be-17c6bcb75649@linaro.org>
Date: Fri, 29 Dec 2023 09:46:50 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/22] target/i386: introduce flags writeback mechanism
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-22-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-22-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 12/23/23 05:16, Paolo Bonzini wrote:
> ALU instructions can write to both memory and flags.  If the CC_SRC*
> and CC_DST locations have been written already when a memory access
> causes a fault, the value in CC_SRC* and CC_DST might be interpreted
> with the wrong CC_OP (the one that is in effect before the instruction.
> 
> Besides just using the wrong result for the flags, something like
> subtracting -1 can have disastrous effects if the current CC_OP is
> CC_OP_EFLAGS: this is because QEMU does not expect bits outside the ALU
> flags to be set in CC_SRC, and env->eflags can end up set to all-ones.
> In the case of the attached testcase, this sets IOPL to 3 and would
> cause an assertion failure if SUB is moved to the new decoder.
> 
> This mechanism is not really needed for BMI instructions, which can
> only write to a register, but put it to use anyway for cleanliness.
> In the case of BZHI, the code has to be modified slightly to ensure
> that decode->cc_src is written, otherwise the new assertions trigger.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/cpu.h                |  1 +
>   target/i386/tcg/decode-new.c.inc | 34 +++++++++++++++++++++++++++++
>   target/i386/tcg/decode-new.h     |  4 ++++
>   target/i386/tcg/emit.c.inc       | 36 ++++++++++++++++++++-----------
>   tests/tcg/i386/Makefile.target   |  2 +-
>   tests/tcg/i386/test-flags.c      | 37 ++++++++++++++++++++++++++++++++
>   6 files changed, 101 insertions(+), 13 deletions(-)
>   create mode 100644 tests/tcg/i386/test-flags.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

