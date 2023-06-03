Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20009720DF3
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 07:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Jvr-0007GM-1q; Sat, 03 Jun 2023 01:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5Jvl-0007Fx-Ew
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 01:36:03 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5Jvi-0004LK-Ce
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 01:36:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d57cd373fso3045448b3a.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 22:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685770557; x=1688362557;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VN7IOryTl8esie3w7ONq6wgeerlf7CFA9U6TT4EyU04=;
 b=WdkJ/P3xdzIPu6DPDLjZa/pTXjGWouv+AocsW0TRZIbd2pV6siFjnVzru/qF1b0pvf
 N0pA+zQAoZJmfyMdZoU/x9EXdua3Xg7qkZHEZXEHkbRUh/K+AJbOJHdeONZ9mwJFbdWk
 bqnEMp8PG4M8rj2u9iaJres6NHp2MJFWMrxJKU9Bm/0TZTxdU7TfHqAzGkE6gXKK1iFF
 oIE/xfBrlS1gDeFzY7BckeZ79ef1S4cmtGvmEPL0W7kytG4cn5cG1SmH2EoV4uO8l7bD
 292t9GXIj1Biz8P1VwrPT5hD0/l/oqkEwg4SwxO4m/5dGJDQiBuu76OyUAu7YrNzljCF
 TH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685770557; x=1688362557;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VN7IOryTl8esie3w7ONq6wgeerlf7CFA9U6TT4EyU04=;
 b=ceGmGR1FUewX5UzM93EX68vnjZnF/PZlm91ISzVCahak85FLteMuzk6xx+Sf+8nY5P
 T9qr96NssGf9LfV1kCEyVfFG1xegJeKR+OIqbl3jZSZFeiljdbgVt184S+CLXJ2+Aqbo
 7O8gmx9Nvp+muVg6l9utbEhCPRDmRKJwyDguCbcaW2GjGHI6KqcK7H/NzdC7wyjzQiHR
 CkpoOpUMYsTKTJGdcQPMDpWsHuuFvTWQgvDbpXl5Mqf2e6FnQDNuldugRIV5MiSXYnPa
 B7BldDMOiWw0JeF0VBrKdknJFJ8RwOpLd4yMA/stl2Br3CEwzyBOjWTVQ9fwT2/zcGBf
 yapA==
X-Gm-Message-State: AC+VfDzlJgvkQaqyIelXadGe5F5E2i6UJLpiV8DFSXLs8ssR4Urd15iq
 wRUYKpyHTbE4+iu6xeBHZAx3Zw==
X-Google-Smtp-Source: ACHHUZ6IFslp18VdoanEVUEvfHG/WE8dp9Hck+KS7wWiEDdUs41M77rXXusTnDCG3/d3KSWrfqXDRg==
X-Received: by 2002:a17:903:1209:b0:1af:e302:123 with SMTP id
 l9-20020a170903120900b001afe3020123mr1974570plh.3.1685770556713; 
 Fri, 02 Jun 2023 22:35:56 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 ix22-20020a170902f81600b001a943c41c37sm2311754plb.7.2023.06.02.22.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 22:35:56 -0700 (PDT)
Message-ID: <ea2a4436-61f8-69aa-6b1a-d6b64c72eae4@linaro.org>
Date: Fri, 2 Jun 2023 22:35:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 01/20] target/arm: Fix return value from LDSMIN/LDSMAX
 8/16 bit atomics
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 08:52, Peter Maydell wrote:
> The atomic memory operations are supposed to return the old memory
> data value in the destination register.  This value is not
> sign-extended, even if the operation is the signed minimum or
> maximum.  (In the pseudocode for the instructions the returned data
> value is passed to ZeroExtend() to create the value in the register.)
> 
> We got this wrong because we were doing a 32-to-64 zero extend on the
> result for 8 and 16 bit data values, rather than the correct amount
> of zero extension.
> 
> Fix the bug by using ext8u and ext16u for the MO_8 and MO_16 data
> sizes rather than ext32u.
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

