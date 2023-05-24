Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB6B70F985
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:00:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pxE-00066L-Kh; Wed, 24 May 2023 10:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1pxD-000663-2N
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:07 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1pxB-0006Cn-Fq
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:06 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d2c865e4eso791021b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940344; x=1687532344;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x36OQH0SwdR1jrsWHKeeBmibE1d+3dNzuNhncz6kxaE=;
 b=oWa0S5866r6luxvR7gGIhcUdPlyMkQV1U5OXKN3fLia9SHjIgtbWv4lXXt0m4/Wqpx
 2bHEYubzGjgJHSlg/PuH9BGQ79k/BZqoaX4saR9OHouUL/5xU3ToDWLid5/ciSUJipyU
 Ste5QC16jAOvqJGgAPwWZMY/ZQ5x7+QlP8nQuMSW5XJ8+r1x2+6X0/VczhJU1Frt5cnl
 bGBydhEzVCXPk90KAiwtvy0PQRhThXUVemq1CG8kx2L6XsNuGslMO5n0PuOZmrGFu32F
 sux2LwGhJ9eOFB5Wyb2riIeEWseP+B94USarISHT22fMj6X5PJ8YdJJKPNNjZuCk2wX0
 uhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940344; x=1687532344;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x36OQH0SwdR1jrsWHKeeBmibE1d+3dNzuNhncz6kxaE=;
 b=fRdgRwBawsVcEIu6AVDObIVjjWub2jJpVldYNm09654XxWqA02fCwj7aHAj3F2CmkP
 qS2Uj4p/qdztSzEqfeQBclMNxCJSY/fbNJxUUSjHR3uUQJndvFcKi8oGqx5hSmhmuSFw
 rZ2iynudl+NjleJluE/mjabz3k/EWr3KhKpAHajqBdwPt7jdyeTcrpALqla/hiodjXFK
 gzZ1wsyjcheiuQ6IvzYwX/oGw/Fj0Wn7JaRQg8EPGTC+rAUDuU4t/DJEXSQLnqAj/aoM
 hywTgI8fIc9P94uE45Mxk6VIQFSr+nYbfZo9fpaAoSYlORRK1M11Ys1CuWMTkMn+m5xC
 2KPQ==
X-Gm-Message-State: AC+VfDxrzzPiG+uBcQs5xugxfdfFY4IMplO+mEopxmuGeTlUxU2Qq/Ok
 g6umCwyC/6KYnfTLWCkra/Fx6Q==
X-Google-Smtp-Source: ACHHUZ6IvO1UdMr26Cg6DdxBQbxXvCbGiyanICUcnq9D2yxFre52u25fjgb5MLHqeldKvk/oEY76ig==
X-Received: by 2002:a05:6a00:134b:b0:64d:30d2:f69e with SMTP id
 k11-20020a056a00134b00b0064d30d2f69emr3784526pfu.3.1684940343759; 
 Wed, 24 May 2023 07:59:03 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 u18-20020aa78392000000b0064867dc8719sm4816085pfm.118.2023.05.24.07.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 07:59:03 -0700 (PDT)
Message-ID: <8992c8ef-0e7a-db66-7e8e-f58260df2013@linaro.org>
Date: Wed, 24 May 2023 07:59:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/5] hw/arm: Use MachineClass->default_nic in the
 sbsa-ref machine
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230524102729.810892-1-marcin.juszkiewicz@linaro.org>
 <20230524102729.810892-2-marcin.juszkiewicz@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524102729.810892-2-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/24/23 03:27, Marcin Juszkiewicz wrote:
> From: Thomas Huth<thuth@redhat.com>
> 
> Mark the default NIC via the new MachineClass->default_nic setting
> so that the machine-defaults code in vl.c can decide whether the
> default NIC is usable or not (for example when compiling with the
> "--without-default-devices" configure switch).
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   hw/arm/sbsa-ref.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

