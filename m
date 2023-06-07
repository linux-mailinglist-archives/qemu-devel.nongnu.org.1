Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E38E872699A
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 21:20:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6yh6-00061I-Fk; Wed, 07 Jun 2023 15:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6yh5-000616-1a
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 15:19:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6yh3-0007Ob-De
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 15:19:42 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6563ccf5151so5289245b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686165579; x=1688757579;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6gOEurnM1h2U/DznPBh+y7TrnDHgSwrewZ/RauF7hWo=;
 b=oIeykgU9rcM0cCaTjNAR2S9sQkDzFWaQDeD4r6Kvcbdo52b3waJM9r6hyEE8sFqjxD
 9Zydc3dNOjHqPzLFywzhxz23zX7LXCqHgvpkudtJGxJL8Hi2tjT6gWL3sq3/GMinjUd2
 WWS8lkkwqdyNiTZS6Mb9BBx/qABe2gJKwaBNxWwRsHCZzd1y/jkv0bNCLredHvEKXZCh
 LZYjUzliZD16GHO5jk770Gebq8it341KH2dU4F5xdro6FJpUNntTjJ3etjEzHftIKxgf
 M1ZukNs5waWil+MxZqlyLNtL/BNpQdCxXiY3oBJuCjnLGSLKS8PDYfI/DOcpyROQAmMS
 3aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686165579; x=1688757579;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6gOEurnM1h2U/DznPBh+y7TrnDHgSwrewZ/RauF7hWo=;
 b=NY4ks50H9f5zM4ITXLeUT1SJ6BTzmBs2I5gb1PZFpwgtQylL8puFOnzMtvekYhj2Wh
 fpA/h44pAHu1iRXLwryP1EfrNRSiixBmgcKZ2dDLHzIS+M9v9ZMLCwi/gs30+0sGbv3b
 wxrBRTD/2VCpq96b1+fdfgsAIJUFOMhMUgf5lSWUYBhPk/1onbFIA+XG1+xRIRQCSSVw
 DxcP4ZSBFEpY4p1LFD+fZX/2kyejGh5qxl2x3fzQcW4WTy52bAGLrVnob6HzotSvW3O2
 P8v+rD5zGyuOeM0hdokAETChtTEP9ZznK3fEXKrXXt7QraT+xTZSzeb+IDWmvrSQhyk2
 6B/A==
X-Gm-Message-State: AC+VfDy1z1R9i7TRTiNVMGZeEIFsOr3tj8GXWzzCse4Y9Lla6lnyR1uF
 Re7WKemzBHqYBVyqNvUeQO3rbNFaD0JV2mUQi9Q=
X-Google-Smtp-Source: ACHHUZ5JhXcNjJdgfBbcAn8+HcMtgDy6OTysn6rgNzt8tGziD0lBk7BXNnxX48B2ZHagXYP0HwqBqw==
X-Received: by 2002:a05:6a00:896:b0:647:7ee8:6251 with SMTP id
 q22-20020a056a00089600b006477ee86251mr8385339pfj.21.1686165579668; 
 Wed, 07 Jun 2023 12:19:39 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:1f09:2b0b:a56e:7a17?
 ([2602:ae:1598:4c01:1f09:2b0b:a56e:7a17])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a056a00271300b0064378c52398sm8735236pfv.25.2023.06.07.12.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 12:19:39 -0700 (PDT)
Message-ID: <48a22e2f-bb7e-e459-0144-721f9e580a74@linaro.org>
Date: Wed, 7 Jun 2023 12:19:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC v2 3/6] target/i386: Add native library calls
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
 <20230607164750.829586-4-fufuyqqqqqq@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230607164750.829586-4-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 6/7/23 09:47, Yeqi Fu wrote:
> +    /* One unknown opcode for native call */
> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
> +    case 0x1ff:
> +        uint16_t sig = x86_lduw_code(env, s);
> +        switch (sig) {
> +        case NATIVE_MEMCPY:
> +            gen_helper_native_memcpy(cpu_env);
> +            break;
> +        case NATIVE_MEMSET:
> +            gen_helper_native_memset(cpu_env);
> +            break;
> +        case NATIVE_MEMCMP:
> +            gen_helper_native_memcmp(cpu_env);
> +            break;
> +        default:
> +            goto unknown_op;
> +        }
> +        break;
> +#endif

This bit of code must be protected by native_calls_enabled() or some such, as we do with 
semihosting_enabled().

Which means that patch 6 should come before this, so that native_calls_enabled() can be 
true if and only if "-native-bypass" is given.


r~

