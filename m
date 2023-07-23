Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E88075E3B4
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 18:24:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNbqn-0002Bz-9b; Sun, 23 Jul 2023 12:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbql-0002B5-4N
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:22:27 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbqj-0000mc-K7
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:22:26 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31757edd9edso280403f8f.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690129344; x=1690734144;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BEL1kEDVVrLE7nB7gi35NcqrzNd9WB+kfTttDAPWBFo=;
 b=Ce/PZKp8u3Hv4fvGLQMTT1179ExJekDenxWsP9gxOo+FNn68Es9X88Z6G9KzSuQbHh
 6ur+PZayKNJiH6yGF9U9frN9YMRkzu7PlubCnzcISd1yFGDCzGBWMIVPkpygfFiQkAnE
 7noMnwJ/ykZdnhA5FkWdmxI6EIJihMrKbWU1Rj12OoDc2Obcue2IBZKlx4PT75R57miV
 JZ5raGVgyYxl2nHlX6JmggULBHs0QWcgOtkXHTjqTZigo20OLyLgRV5GVUCHzt2Uvv8l
 F8mTUIenKnHMXwCBM4/30StkCoIFye9hDCGK4Ud8I9WSACDqs9zza/iqGIoqiUR/RtbW
 RxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690129344; x=1690734144;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BEL1kEDVVrLE7nB7gi35NcqrzNd9WB+kfTttDAPWBFo=;
 b=OZv7NseA/LrFnHqodcyV3G77g5kYWe6BRcXeqXoxZlwxUddMn97S8a3SRqr1q5xlPA
 qMhLg1dgzYCcD2J0jRDK510ff7LD86pgoPWVSeL+RRSbtAgPYwYZIw2mlyrZ0SpEt/s5
 vOX3j5EWuJ0HPeOil2F7juC3I3K11QMZXVzZm9ghu+vJHfuulDrFcLUtRGVDQ6lRn1Iy
 X/7jnzWDnWRVGNu0DmTwO9HMle5+diwMgqfB4Tx1FOHAQ68RthHH6/tkGYlLQZieQCyJ
 iHDSqYiZr6ZvLv5HcYwb92DWNrjB+q6lLRj/G0s0h06BILmLw7vcEUwBhRP29OUtBJ8e
 NIvw==
X-Gm-Message-State: ABy/qLa2HobAmln6ss1VWxlRcawc8whzcZgOQVxk2H0J8gzmZByLH3b7
 +XRyOZvHxIOF2waOQqY/rCJvgw==
X-Google-Smtp-Source: APBJJlEloN2DwYLa/3691hpyecEe4WuErgFGmSyxDDx5e7DNZ9nx8356G84ypQtdYXx+WPMLXvUZjg==
X-Received: by 2002:a5d:5309:0:b0:317:59df:a846 with SMTP id
 e9-20020a5d5309000000b0031759dfa846mr1238207wrv.67.1690129343696; 
 Sun, 23 Jul 2023 09:22:23 -0700 (PDT)
Received: from [172.20.12.233]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d6a50000000b0030ae901bc54sm10017083wrw.62.2023.07.23.09.22.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 09:22:23 -0700 (PDT)
Message-ID: <f48d5259-746e-276e-0d56-9e97fca9f804@linaro.org>
Date: Sun, 23 Jul 2023 17:22:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 02/14] target/s390x: Fix CLM with M3=0
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230719221310.1968845-1-iii@linux.ibm.com>
 <20230719221310.1968845-3-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230719221310.1968845-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 7/19/23 23:11, Ilya Leoshkevich wrote:
> When the mask is zero, access exceptions should still be recognized for
> 1 byte at the second-operand address. CC should be set to 0.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Cc: qemu-stable@nongnu.org
> Fixes: defb0e3157af ("s390x: Implement opcode helpers")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/mem_helper.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
> index f417fb1183c..d6dc8b32620 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -667,6 +667,11 @@ uint32_t HELPER(clm)(CPUS390XState *env, uint32_t r1, uint32_t mask,
>       HELPER_LOG("%s: r1 0x%x mask 0x%x addr 0x%" PRIx64 "\n", __func__, r1,
>                  mask, addr);
>   
> +    if (!mask) {
> +        /* Recognize access exceptions for the first byte */
> +        cpu_ldub_data_ra(env, addr, ra);
> +    }

Since s390x does not implement .do_transaction_failed, I guess this is ok.
But probe_read might be clearer.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> +
>       while (mask) {
>           if (mask & 8) {
>               uint8_t d = cpu_ldub_data_ra(env, addr, ra);


