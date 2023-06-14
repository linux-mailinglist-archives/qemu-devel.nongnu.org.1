Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F2A72F3BA
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:47:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9IPN-0007mf-R3; Wed, 14 Jun 2023 00:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IPL-0007gV-AL
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:46:59 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IPJ-0003ov-LC
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:46:58 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-307d20548adso4446218f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686718016; x=1689310016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=auaPt1hOXoZgw/1+AbAPsk+Tji/EwtfhvVlmV0KomHo=;
 b=AGKke7pms0kdiGmxgKSSspjEoXhF0kF6q4GvRQeU/2K1R1eUSdk1OHhizKPV+0S5JR
 0yUsAP/F7fG8DZRJvuOBxTvvbRUi+tfqYsJIzdJqylzb+VC2fXLRGKAGYD3ZtA1k5F7W
 x22miV0iErXiOp4ccWZHRPLS/6qdKmHUaCzHJavlBDHNJPlU1BOTnwfpXrDptIR8abfr
 KTHFQKaZ76DMMds9/DwAk9XfcA9SSwbA7QF9ccyA02i9cd7hmu8xjD364jtTWYEP3PZl
 UfAiLHoUfyHIz7f6ENiD6+rofRLWy+n68YGoqBZH6AzgBXwgh6Ln9wertjMob0w1vmRf
 Krjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686718016; x=1689310016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=auaPt1hOXoZgw/1+AbAPsk+Tji/EwtfhvVlmV0KomHo=;
 b=XUrzL4K9Ch0SX3KYtVmL3e+fBqjPtJu8AmbjnZ3TYydqergNoLPTxP9yYRWIvfVQ1a
 ss1JOzt/F16VppoTT6xwJOr81ZE53XcwdRxW8dsHJVerTl6i99EWf8tTjGFfWST5X0bD
 Emxuu68EdhSowRnVgVz1QJTJeVJE4gLlgTGmyEfJ44ThznBOmQAHnjORVXZH3r8HHTjS
 D9WP7y8D2u4fhI1GAObcmh0q9FYN3UjeEJGkp3Wg0KFJfQyqNlQhXUSCo7iUJv7RVlEE
 RIR7yX/o+6sDzcO70Yj86+WhRl2Vnaic/L4o/OdEDW08CaQjxKSX39nLSM4mfoxPXUW0
 WwuQ==
X-Gm-Message-State: AC+VfDxSnXuZEEs4xoDniQPMKX9x4K9QM3F0tXepYlls+xU7KDrZT2cm
 5DAGH9tUM52BxGgPphYAXUaV/w==
X-Google-Smtp-Source: ACHHUZ5KR+FwBBJu3PxBIEssQ0SQvoks9+wvkb1Y5uXQK18H1GW4qvXSB/mNafrJWPcq9r+rBDJyCA==
X-Received: by 2002:adf:fc8e:0:b0:30a:d083:d22d with SMTP id
 g14-20020adffc8e000000b0030ad083d22dmr8221592wrr.24.1686718016075; 
 Tue, 13 Jun 2023 21:46:56 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a5d43d2000000b0030ae93bd196sm16929905wrr.21.2023.06.13.21.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:46:55 -0700 (PDT)
Message-ID: <e1d6ae1b-c102-e225-a9eb-2757f6387109@linaro.org>
Date: Wed, 14 Jun 2023 06:46:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 10/26] target/arm/tcg: Extract VFP definitions to
 'helper-vfp.h.inc'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611085846.21415-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/11/23 10:58, Philippe Mathieu-Daudé wrote:
> helper.h is used by all units, but not all require the VFP
> definitions. Move them to a new header; the next commit will
> remove it from the common helper.h.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> TODO check recpe/rsqrte/rint* are VFP

Yep.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


