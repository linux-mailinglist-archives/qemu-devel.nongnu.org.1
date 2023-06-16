Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB5E73330A
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 16:02:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAA0d-0006Nh-Io; Fri, 16 Jun 2023 10:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAA0b-0006NL-VD
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:01:01 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAA0a-0004rF-0X
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:01:01 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f8fcaa31c7so1771035e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686924058; x=1689516058;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X+A5OPfH2NtcQuN06uhG+2NwIyNLjzxp6ZM91SB6oNk=;
 b=BP4YVwMSzoHWKz1TyRqYyBCZw2CUakFwO6T9O5s0lda+/t3FP0zwU0Y4Pfai6Q27iH
 7AW51OquEWxpLfT4hLeVISZD01BsBn+kx0xiYCxk9x9HZ1o8//O8FfnfcxiplJKfGWCY
 IR3a5ad00nA6en1G2XS+al7KESuXFZFPLP64GOLz5vCB5lYGtnR/oCbUhYMs4bhpVwxv
 Q/vqIMomLkt4QwzQ1lgEtedWfleQBFsPOnZWEa4GjzIa0aOt5rHuAVhqaOogllbtwpWP
 yqvVgt2cwX+RnI688rghdlS041KRhtwr2CCT5hdYWvdqpt65MVpJf/iBWTvES/z6qeH6
 hO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686924058; x=1689516058;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X+A5OPfH2NtcQuN06uhG+2NwIyNLjzxp6ZM91SB6oNk=;
 b=c0asoA8S6pdPxibLZIBwKPNKCCcfUXa7Q9IAvShtCEIVxq+vIuCMLbxwmVca7B2SP7
 iJH+1KGYFZbp8mFQklyxTuVBGBNKPBf3YvrBTXS4ow85OKHPYLcMwyh8SSbMMGw6n6px
 znsawSh3j/ghNWKY70iSd9UkHIkBMSUK0Yr7qiCwzpdyIF61/oPwegxmj+pSX3bK1emX
 Cy7cCLdkp/KRTvFuZHxk4lq3huK3c/X4j8Q73ZdrwPMo716Z3OFz74K4zwFNXRfU1AIH
 VsU2VPqhV5ZZaxzcnw/Bykd4O7zSTPNpVb0RmBNQ41r2jbc/Xv9uPd3ny+NnLYZSl9yP
 VgyA==
X-Gm-Message-State: AC+VfDz699EYKHoC3N+bxgfGb9xSoXzsh2E9bH8bpVH47FBV8usffPzk
 wSxB60GmScNiotPI/kfWhuAiug==
X-Google-Smtp-Source: ACHHUZ668rWVWtAWyOgfkFfd29gZ1O93tjslO4j+0maNAbvGLKEr7PdP3vvC/AAB86yy5g5upPUVKg==
X-Received: by 2002:adf:e6c4:0:b0:30f:b7be:4089 with SMTP id
 y4-20020adfe6c4000000b0030fb7be4089mr1610462wrm.3.1686924058232; 
 Fri, 16 Jun 2023 07:00:58 -0700 (PDT)
Received: from [192.168.164.175] (146.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.146]) by smtp.gmail.com with ESMTPSA id
 j15-20020a05600c2b8f00b003f4266965fbsm2322965wmc.5.2023.06.16.07.00.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jun 2023 07:00:57 -0700 (PDT)
Message-ID: <7f606624-7744-6c1f-c5bb-fb62f4e65495@linaro.org>
Date: Fri, 16 Jun 2023 12:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 03/12] hvf: Increase number of possible memory slots
Content-Language: en-US
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20230614224038.86148-1-graf@amazon.com>
 <20230614224038.86148-4-graf@amazon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230614224038.86148-4-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 15/6/23 00:40, Alexander Graf wrote:
> For PVG we will need more than the current 32 possible memory slots.
> Bump the limit to 512 instead.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   accel/hvf/hvf-accel-ops.c | 2 +-
>   include/sysemu/hvf_int.h  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index 9c3da03c94..bf0caaa852 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -88,7 +88,7 @@ struct mac_slot {
>       uint64_t gva;
>   };
>   
> -struct mac_slot mac_slots[32];
> +struct mac_slot mac_slots[512];
>   
>   static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
>   {
> diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
> index 6ab119e49f..c7623a2c09 100644
> --- a/include/sysemu/hvf_int.h
> +++ b/include/sysemu/hvf_int.h
> @@ -40,7 +40,7 @@ typedef struct hvf_vcpu_caps {
>   
>   struct HVFState {
>       AccelState parent;
> -    hvf_slot slots[32];
> +    hvf_slot slots[512];
>       int num_slots;
>   
>       hvf_vcpu_caps *hvf_caps;

Please add a definition in this header (using in ops.c).

In order to save memory and woods, what about keeping
32 on x86 and only raising to 512 on arm?

