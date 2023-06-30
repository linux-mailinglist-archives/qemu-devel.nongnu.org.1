Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E85EF743D48
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 16:17:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEvK-0008MJ-RN; Fri, 30 Jun 2023 10:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFEvD-0008MA-SJ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:16:28 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFEvC-0001A6-An
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:16:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso9265015e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688134584; x=1690726584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4bgBZ7BZWhe8wc1/cb6Mvy177qkyNy7zo1A4/4M+btw=;
 b=jzZ3Z5fusYVR/Jp6MqLjG2It4uTmEjIFIdWwi8MdxNk7+/FLrm57MuqGwqWow67y7s
 GTPykmP17lMZv/Ysn6Cbr0iFxLB4aiag38RvO+DQ4knPv/in8Os7wAnDjun1DPeJVKbC
 GdSGU6Tl0ven/0xV6x7idQPU2tRaesStCuKiz0WYt3rLBz4YeWYBS/knSfBVdp+uV2VL
 J9UIy+zybIeSJd+8MpT/yhqEVuoq1Pb7zmiRvfFSJAiGAgcs8FfkVYoDUEO5ait5ry4G
 V9ZRssfBMYIainBvouBHtN9t2iY4QE5NDbUUd7T1laFiwqXp7vzOF1rje+o5C8mjPycM
 NJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688134584; x=1690726584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4bgBZ7BZWhe8wc1/cb6Mvy177qkyNy7zo1A4/4M+btw=;
 b=f8/SIyixAuLztrJYxj5TwQn9pZPKAxWNVncONJo1ZThQqFYA7CX0RJgVo4k6uvgvzH
 3pB+pSypiDNkQbYCZZRD4FjcTFz75+T53vAN1lI87WnIK1G3sIJe8nO5ShJmClKx4y3z
 nLQgmW5iJiklgZrw0/1IU4KuVCcJlwA/4+dMTMLs6s8+KKfE6Yv+EqA7nVQcV/CPydpy
 JKTs+vJJT97t18iXLyekiSZDkYXCe8HLoJCMEY2MurFXe7yYtueQxmHQExYz+kZN0hHK
 brm1hsYR0z50jVFWse90eB3N/9/6M1r9h9/iWAAsDyiPp3pcJBBYIe5EF2cyRF2/ND66
 DReA==
X-Gm-Message-State: AC+VfDzyVAwocLvgl4kLi226h/81v9akOqsrTJuey9DfQHjpAGNUMfcB
 0Jn+CaHQTC5Cb18ePpM9qIVrrg==
X-Google-Smtp-Source: ACHHUZ5dlr7VG5YNLHoRcXggc0JHYaxBGxJ2Ima3GVvVBEPAHw/XTPSXofYZxTw3Rx7+QFT+aF4e7Q==
X-Received: by 2002:a05:600c:ac6:b0:3fb:b005:99d6 with SMTP id
 c6-20020a05600c0ac600b003fbb00599d6mr2611630wmr.2.1688134584205; 
 Fri, 30 Jun 2023 07:16:24 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 6-20020a05600c230600b003fbc4621839sm2258121wmo.0.2023.06.30.07.16.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 07:16:23 -0700 (PDT)
Message-ID: <bc65acdc-b32d-0f0f-82c3-b2143c9af6e9@linaro.org>
Date: Fri, 30 Jun 2023 16:16:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/9] accel: Move CPUTLB to CPUState and assert offset
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, eduardo@habkost.net, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, peter.maydell@linaro.org, wangyanan55@huawei.com
References: <20230630122551.21766-1-anjo@rev.ng>
 <20230630122551.21766-6-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630122551.21766-6-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

On 6/30/23 14:25, Anton Johansson wrote:
> @@ -448,6 +448,13 @@ struct CPUState {
>   
>       /* track IOMMUs whose translations we've cached in the TCG TLB */
>       GArray *iommu_notifiers;
> +
> +    /*
> +     * The following fields needs to be within CPU_MAX_NEGATIVE_ENV_OFFSET of
> +     * CPUArchState.  As CPUArchState is assumed to follow CPUState in the
> +     * ArchCPU struct these are placed last.  This is checked statically.
> +     */
> +    CPUTLB tlb;
>   };

This is what we had before CPUNegativeOffsetState, comment and all, and over the course of 
time the comment was ignored and the CPUTLB crept toward the middle of the structure.

I really don't see how this merge helps.  There's nothing target-specific about 
CPUTLBDescFast or CPUNegativeOffsetState, and keeping them separate enforces their importance.


r~

