Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F29807CD1CA
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 03:25:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsvIX-0006PJ-PZ; Tue, 17 Oct 2023 21:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsvIV-0006P1-Ba
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 21:24:31 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsvIT-0001DU-K0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 21:24:31 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c9e072472bso40159095ad.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 18:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697592268; x=1698197068; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=orNK2rQfgLh7GepKMpLM6cVK6b1KmqO5uXqunqmpk9w=;
 b=RooZdXW7JC2YLo9X8Owc8qN7NpDtYv67dwigz5EIrYRNhRZNYzdmFiTypkp1gOjtbV
 nauvOuxHG+XZATIlZaMMXNqkBkz3hCRT7GkhUO4UIfQmLKJSV00dU3dzmfvb/LmctP7Q
 l3r8K+RPU04rmRVeUFAi9njVXwEuYqM9iv+/tV46wIe8MqAaRV8Y/tpcSKK7l+gKRBjJ
 b2nQEzi+q/+aUbFWQLNeW5jB5rLYqbT3GXFdUPW1e6pKvEJFvVAToayzjhzH9nLzBsSS
 Ff9UIvQjiYmo33wqy2z/ZWebS9D9h7j9jMc8ctgi/aDQ0z/QYnqzVWQyFJ/8dWNEKUoj
 8toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697592268; x=1698197068;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=orNK2rQfgLh7GepKMpLM6cVK6b1KmqO5uXqunqmpk9w=;
 b=f0OrQ+/1cFhRuqZOEKny1iJo6ZsJMx9Safyfgil85sBw8ZPKKjIuetI2DZFRjSeKAv
 wo4FORQkGvTJaHa7h/WfDZTusyT3xB4O6CVZXuLwlp6QyFpMqTJIP26duyUN0xqaa8Ul
 GeexEhAVZfJGp2ANwTZNirDp95kiyek/Vg/O7YwUvNMnYHEcVB9sTWI/4Qm8IITGxjVW
 HEQWlRNJrE3oRO1hF/o1vtpK4OrzmzdBrdcWR9ogcDPTIEonBGK3tKRtOhhOux6DGFqJ
 SqYnAvyawj0g1LoggsggMeJcwAvvZgrcqbSvLKdMJiRd7dy+jYZLx2XDiqOVcgW2v3Et
 HxQA==
X-Gm-Message-State: AOJu0YyOMEAu7vZfKJ6nc7amaipqOX9RMLICcvRqNhlovJzBz+I7nSSr
 78YaROlCFUpjt08eALw9XnzrbluemsydmBPkwd0=
X-Google-Smtp-Source: AGHT+IHTc18fEqLkphh0IUq9NUII61XZrOfYHoZbleGvzW4pFNJx/Y+ZOEbje7pnBwYYVT488bNP+g==
X-Received: by 2002:a17:902:f543:b0:1ca:8cb0:7ff5 with SMTP id
 h3-20020a170902f54300b001ca8cb07ff5mr4677929plf.9.1697592268030; 
 Tue, 17 Oct 2023 18:24:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 iw9-20020a170903044900b001c73f3a9b7fsm2232418plb.185.2023.10.17.18.24.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 18:24:27 -0700 (PDT)
Message-ID: <582d074b-5789-48a7-9aa5-3f518fa73c2d@linaro.org>
Date: Tue, 17 Oct 2023 18:24:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] target/i386: validate VEX.W for AVX instructions
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/14/23 03:01, Paolo Bonzini wrote:
> Instructions in VEX exception class 6 generally look at the value of
> VEX.W.  Note that the manual places some instructions incorrectly in
> class 4, for example VPERMQ which has no non-VEX encoding and no legacy
> SSE analogue.  AMD does a mess of its own, as documented in the comment
> that this patch adds.
> 
> Most of them are checked for VEX.W=0, and are listed in the manual
> (though with an omission) in table 2-16; VPERMQ and VPERMPD check for
> VEX.W=1, which is only listed in the instruction description.  Others,
> such as VPSRLV, VPSLLV and the FMA3 instructions, use VEX.W to switch
> between a 32-bit and 64-bit operation.
> 
> Fix more of the class 4/class 6 mismatches, and implement the check for
> VEX.W in TCG.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 133 +++++++++++++++++++++----------
>   target/i386/tcg/decode-new.h     |   6 ++
>   2 files changed, 99 insertions(+), 40 deletions(-)
> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index 790339eaf25..850271e0898 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -43,6 +43,47 @@
>    * There are a couple cases in which instructions (e.g. MOVD) write the
>    * whole XMM or MM register but are established incorrectly in the manual
>    * as "d" or "q".  These have to be fixed for the decoder to work correctly.
> + *
> + * Speaking about imprecisions in the manual, the decoder treats all
> + * exception-class 4 instructions as having an optional VEX prefix, and
> + * all exception-class 6 instructions as having a mandatory VEX prefix.
> + * This is true except for a dozen instructions; these are in exception
> + * class 4 but do not ignore the VEX.W bit (which does not even exist
> + * without a VEX prefix).  These instructions are mostly listed in Intel's
> + * table 2-16, but with a few exceptions.
> + *
> + * The AMD manual has more precise subclasses for exceptions, and unlike Intel
> + * they list the VEX.W requirements in the exception classes as well (except
> + * when they don't).  AMD describes class 6 as "AVX Mixed Memory Argument"
> + * without defining what a mixed memory argument is, but still use 4 as the
> + * primary exception class... except when they don't.
> + *
> + * The summary is:
> + *                       Intel     AMD         VEX.W           note
> + * -------------------------------------------------------------------
> + * vpblendd              4         4J          0
> + * vpblendvb             4         4E-X        0               (*)
> + * vpbroadcastq          6         6D          0               (+)
> + * vpermd/vpermps        4         4H          0               (§)
> + * vpermq/vpermpd        4         4H-1        1               (§)
> + * vpermilpd/vpermilps   4         6E          0               (^)
> + * vpmaskmovd            6         4K          significant     (^)
> + * vpsllv                4         4K          significant
> + * vpsrav                4         4J          0
> + * vpsrlv                4         4K          significant
> + * vtestps/vtestpd       4         4G          0
> + *
> + *    (*)  AMD lists VPBLENDVB as related to SSE4.1 PBLENDVB, which may
> + *         explain why it is considered exception class 4.  However,
> + *         Intel says that VEX-only instructions should be in class 6...
> + *
> + *    (+)  Not found in Intel's table 2-16
> + *
> + *    (§)  4H and 4H-1 do not mention VEX.W requirements, which are
> + *         however present in the description of the instruction
> + *
> + *    (^)  these are the two cases in which Intel and AMD disagree on the
> + *         primary exception class

Oof.

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

