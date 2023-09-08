Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C1E799154
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 22:57:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeiWu-0007Pd-4M; Fri, 08 Sep 2023 16:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeiWq-0007Oi-Mz
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 16:56:36 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeiWo-0007Rz-E0
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 16:56:36 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68c576d35feso2337916b3a.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 13:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694206593; x=1694811393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ByUqUacKFhbA1ou2BOfu9pawjfMy3n2JM+xEhfoLiNg=;
 b=N1+mZKNXmp6O/KPj71caEawkdJOQ3IUsaNQDPOqimCOotNzUpDvFbJ1JqxSHeZp/0+
 auW53itF8yEYlE/L6uDJDYg193foZdp1kuA7yqcQ6Gv+9PUh11PojcH9A6cGjXd2z0r8
 8QmskGiN+J51wkp8Mj9NtY+7H+8yJp5AdMo2m8xV6h8THcLkDLaxumSlnzNM8O3Tjzx8
 twSceFAiwCDPU3tLFlMXotZaAv6wyp/aaSNLRJxNsPnkx7qM4E+RYx7Ng2yLIz6pWUSk
 Y2RBdeflSBisQ8G1m+5CfhSTuBAgthw13Rb8hwZ1dNcOqy38tLCpRodSTYBBKFVZVNv6
 thNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694206593; x=1694811393;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ByUqUacKFhbA1ou2BOfu9pawjfMy3n2JM+xEhfoLiNg=;
 b=VLYbedocz/IVV1Ipp8lSvchMujZ56BZCulhYcwQ/SYmy8DrU9DsCd+CbH/g5W+gAnq
 /Xlgw++9klUenVgh995PCWMLEcdEKBaFDz/WFkwnqpQb7W3DURefvAVEcgv0m1Bt5tpF
 uesK4EYE9+iypReRg0jtDTJP/CR/I/7vgTr+oVASUFj2d3CN0LhGkrYqXDoW6kt2s2VW
 Y9HyX+OX1+YrGGD2Vb3T9dpctVU3ys4k6bMRziW6fLCvj26KPQ1/+ORQQi06X826nDGK
 tjA6MhtgMqjliZPkNGIDy9P4kU0jnJymlwU1Ug8qwp10A6BeovlZRBpLh0XEtDDI7R0T
 iFfQ==
X-Gm-Message-State: AOJu0YxLZ2FoYeXbTpgEdQwPF3Kjl4SknqTGVp1JFbfAdJElqpjrZphK
 qHBekDg9i+6LujxDv9tltHdrmg==
X-Google-Smtp-Source: AGHT+IEq0hKVcr/K9RV0Xfiqz/srRr23R/5mkhXv2TkZt2ufcAzW4lbuH5EmzUCoIR9O1FOFY5VPOw==
X-Received: by 2002:a05:6a20:7343:b0:153:6ce7:294d with SMTP id
 v3-20020a056a20734300b001536ce7294dmr4060392pzc.12.1694206592736; 
 Fri, 08 Sep 2023 13:56:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 z11-20020aa785cb000000b0068a3e7634d0sm1683851pfn.129.2023.09.08.13.56.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 13:56:32 -0700 (PDT)
Message-ID: <23cc3a62-51a8-a6c7-2389-e166b0fb9fb5@linaro.org>
Date: Fri, 8 Sep 2023 13:56:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 04/14] target/arm: Implement FEAT_MOPS enable bits
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907160340.260094-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/7/23 09:03, Peter Maydell wrote:
> FEAT_MOPS defines a handful of new enable bits:
>   * HCRX_EL2.MSCEn, SCTLR_EL1.MSCEn, SCTLR_EL2.MSCen:
>     define whether the new insns should UNDEF or not
>   * HCRX_EL2.MCE2: defines whether memops exceptions from
>     EL1 should be taken to EL1 or EL2
> 
> Since we don't sanitise what bits can be written for the SCTLR
> registers, we only need to handle the new bits in HCRX_EL2, and
> define SCTLR_MSCEN for the new SCTLR bit value.
> 
> The precedence of "HCRX bits acts as 0 if SCR_EL3.HXEn is 0" versus
> "bit acts as 1 if EL2 disabled" is not clear from the register
> definition text, but it is clear in the CheckMOPSEnabled()
> pseudocode(), so we follow that.  We'll have to check whether other
> bits we need to implement in future follow the same logic or not.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h    |  6 ++++++
>   target/arm/helper.c | 28 +++++++++++++++++++++-------
>   2 files changed, 27 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

