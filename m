Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2B1791CC3
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 20:27:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdEI0-0003J1-BI; Mon, 04 Sep 2023 14:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdEHy-0003If-LL
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 14:27:06 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdEHw-0001eo-Cg
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 14:27:06 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-52a250aa012so2319433a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693852022; x=1694456822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=541JyCy9XPIs515STXSwG4wUnIWy4aYwP9IFPsJMMiY=;
 b=muqxjb+4xn2Gx9VT+Xvj4TKNGRF4BvMnetIYRaAaCiVN8kMKbbWY2sbcj5balX/6Oi
 yXKKR2dft/ISTex4grkG95IOpZOybuKleKY4j9Symteqcq2vjoF89bnXONobfi1zDu/7
 bQcV/Zx9aP31bMCQJLk+kcknRA7Mc6IbhcI2Y4u+pTlkPbjD1egAE2vfUx3iiEgdZZtn
 gs/vyuIhZMZZ+kmRIudP7qiaiZxV2cTOcAixLkMjg2b9l3jIetK+zWfLjidnq3JJJxcH
 SeVDQ3vSGjkeNQeY1UqNvi3dZrpG7ZWI1E5jQepFEPvVBDdYI/Vfea/fHko+y05xh5TT
 59JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693852022; x=1694456822;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=541JyCy9XPIs515STXSwG4wUnIWy4aYwP9IFPsJMMiY=;
 b=L7wxJo6zDnujtsvvKEnvvcY2R/ljvkx2PmKILCthVXl1tgJScDbQHFbdTiqRe4iZ2w
 1iXkPQ579OvhJGeXzKKP0VkdgnmNCfSccHEzWewUQtDIfIZK5aUM7cZ2RbvEK/BZz+dI
 R6zL0B4k9eMA6738K33k7bclrII6y0eqPYTqM4XJcl3zIWm0bGLaN3yZAOKaBJFeR79M
 XWWttm/xrZcz+zsx2S00dye8y56dJt7VgtG0Lu2SLDHjl9e0Zn6fOEN4nkIfe/1WCWum
 v26+9e08Ub4WXDR30oq9F6830f929+sh6MxbhkUYUmvAklb9nmxhp6dCDCkRp+9Tr0G5
 NuHw==
X-Gm-Message-State: AOJu0YxFVfjcx6nx897oOi0trOU55R66RXoXcfv5vSCelTw0YyFXNYTP
 vIPsl2epvLjO2nKVYjmrx0Ztxg==
X-Google-Smtp-Source: AGHT+IG7olyS+jXevCnvnP0ISdYpGDEZXpjpOLluwjmlzCxf9S1L1N/Icwq7w84VNpuh8r40vekAIQ==
X-Received: by 2002:a05:6402:382:b0:525:7e46:940 with SMTP id
 o2-20020a056402038200b005257e460940mr8972257edv.24.1693852022524; 
 Mon, 04 Sep 2023 11:27:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 b22-20020aa7d496000000b0051dd19d6d6esm6172363edr.73.2023.09.04.11.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 11:27:01 -0700 (PDT)
Message-ID: <89d5477c-ece0-b738-c64f-056242619d92@linaro.org>
Date: Mon, 4 Sep 2023 20:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] hw/cxl: Add utility functions decoder interleave ways
 and target count.
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, linuxarm@huawei.com
References: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
 <20230904164704.18739-2-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904164704.18739-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

On 4/9/23 18:47, Jonathan Cameron wrote:
> As an encoded version of these key configuration parameters is
> a register, provide functions to extract it again so as to avoid
> the need for duplicating the storage.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   include/hw/cxl/cxl_component.h | 14 ++++++++++++++
>   hw/cxl/cxl-component-utils.c   | 17 +++++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 42c7e581a7..f0ad9cf7de 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -238,7 +238,21 @@ static inline int cxl_decoder_count_enc(int count)
>       return 0;
>   }
>   
> +static inline int cxl_decoder_count_dec(int enc_cnt)
> +{
> +    switch (enc_cnt) {
> +    case 0: return 1;
> +    case 1: return 2;
> +    case 2: return 4;
> +    case 3: return 6;
> +    case 4: return 8;
> +    case 5: return 10;
> +    }
> +    return 0;
> +}

Why inline?

Alternatively:

   unsigned cxl_decoder_count_dec(unsigned enc_cnt)
   {
       return enc_cnt <= 5 ? 2 * enc_cnt : 0;
   }


