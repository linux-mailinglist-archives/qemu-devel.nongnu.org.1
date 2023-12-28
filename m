Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE37A81FB67
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 22:36:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIy1t-0003cJ-Mx; Thu, 28 Dec 2023 16:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIy1p-0003Zf-LA
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 16:34:58 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIy1o-0005wg-4e
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 16:34:57 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-593f420187aso4022387eaf.1
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 13:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703799294; x=1704404094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gKC+G+Z4CnoAxyHw3YU1yCPAsDgJ01jGvlwSyLULyJk=;
 b=s0GlIZIKk7JJlnYAfJXiI8xjtGHeOBGZTuKatESrUpcBC7aSPiC0FhHcNKZR2L/YkQ
 +DL7onRpEcC8lzPLrVYXDWXsQp/vH177sjAL6XND7gyi5DUTtj27d3GZe0xanepbI0/a
 /LtfXonbv/l6AJsKTPZ9VtBoWZEvmDhajFyi2L45bWjJtJYOn8Zn4pghYTgiLRsydG1S
 Xv5eTmu45sS0uld68Jm6YRrQrhVeSEd/aJjKyx9V7G6bWAxNEtsZuqLsVmCfHjW8yGro
 BClXiynEJfZurwk6AxVSTpfKytq8MUOkJah9Cwq88NKJGlgKgnP7GS76235nbvzrRipN
 aNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703799294; x=1704404094;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gKC+G+Z4CnoAxyHw3YU1yCPAsDgJ01jGvlwSyLULyJk=;
 b=mqEAiKkf9ffG2sfA5TbGmQk8X9gHGxbm9CShbjuFhQvgNpFmx0xG5d5NbxuoANqnzn
 iZAl+XRFbR4SbcZlouDEP7f3Z3ZfsMmxmNFhn7kd+1vGKtC5wIr7uxCg6D48EiOPH033
 BTgOwmOxL4RppYUPJ+99mrysKopB6zh2kTph35LotxtegnhRpu/kPqjYkP7YZMYxWIPZ
 YbshkEpSYa8alyEgmJUbaBbnUFdeHFwQqpFbenKun/c+GH7ewmGWBi2cyD1LcUT0HcMT
 RMNOdUxL9bxKzHbROsYJeTWeRvqEAVMs5sHuSwPMpMDKdLx1odnGy5kZZBseRKH+fhee
 nmFw==
X-Gm-Message-State: AOJu0YymcpwtxCBD6GwhBHowFWpL2jKHoE88Tw+MSqYJGBMpyBX/mNCc
 qEda9dKmP8goccQfeTqn+JuaJn4tyleGfw==
X-Google-Smtp-Source: AGHT+IEVJP4qVJ8U8nobZ4KKu+Pc6G1T0cwEvKb3ZycAro2v9xQoDd88xj9D7LFBxvWwJYI8qyYAgw==
X-Received: by 2002:a05:6358:9047:b0:172:b387:51bd with SMTP id
 f7-20020a056358904700b00172b38751bdmr7042198rwf.25.1703799294399; 
 Thu, 28 Dec 2023 13:34:54 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a056a00099000b006d9c7f2840bsm6734408pfg.57.2023.12.28.13.34.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 13:34:53 -0800 (PST)
Message-ID: <92e22e4d-3f1e-4ffd-8b98-5906f32b886e@linaro.org>
Date: Fri, 29 Dec 2023 08:34:48 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/22] target/i386: document more deviations from the
 manual
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-7-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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

On 12/23/23 05:15, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 12 ++++++++++++
>   1 file changed, 12 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index 2bdbb1bba0f..232c6a45c96 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -26,6 +26,13 @@
>    * size (X86_SIZE_*) codes used in the manual.  There are a few differences
>    * though.
>    *
> + * Operand sizes
> + * -------------
> + *
> + * The manual lists d64 ("cannot encode 32-bit size in 64-bit mode") and f64
> + * ("cannot encode 16-bit or 32-bit size in 64-bit mode") as modifiers of the
> + * "v" or "z" sizes.  The decoder simply makes them separate operand sizes.
> + *
>    * Vector operands
>    * ---------------
>    *
> @@ -44,6 +51,11 @@
>    * if the difference is expressed via prefixes.  Individual instructions
>    * are separated by prefix in the generator functions.
>    *
> + * There is a custom size "xh" used to address half of a SSE/AVX operand.
> + * This points to a 64-bit operand for SSE operations, 128-bit operand
> + * for 256-bit AVX operands, etc.  It is used for conversion operations
> + * such as VCVTPH2PS or VCVTSS2SD.
> + *
>    * There are a couple cases in which instructions (e.g. MOVD) write the
>    * whole XMM or MM register but are established incorrectly in the manual
>    * as "d" or "q".  These have to be fixed for the decoder to work correctly.


