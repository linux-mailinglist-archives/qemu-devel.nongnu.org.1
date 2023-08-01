Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD12576C123
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQyya-0004Wq-Kv; Tue, 01 Aug 2023 19:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQyyX-0004WZ-TR
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:40:26 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQyyW-0006T1-2T
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:40:25 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bb893e6365so39661525ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 16:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690933222; x=1691538022;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nhTj7mVSXukErwdP394mtKcqMePtYUDjEUZaagGeWP0=;
 b=Z6x9bYrLs1UP1OHwPMxMZB4RlqFnCZpPzs4of8Cex2z7D8Ght5OwYK9Dq81JQwFpW0
 C6kPzodayV1sR3IgV3zjg0mC0MX+6eIYva5hMkqcJYeLjrVlcmEo2pfwhZJTshj9HQXt
 +3swKYob9RV/52MxhNNPINx/HPAnDdLF9w/7xsng3nkyeRsaKRcKZS5yb6B9AxeWOhCQ
 /iAaT9S7E677vqEGi/uMAzPCNnxo9yfYwDAx+wMQ18tHJAg7frK7sfHywnXHbW3q3OSH
 8sHy+cetr8LfBJ3XqFghHEhoNAceog/99gJiL+kUQzkxhZl66YpqTGS5hrrWGicvr2s6
 +BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690933222; x=1691538022;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nhTj7mVSXukErwdP394mtKcqMePtYUDjEUZaagGeWP0=;
 b=NbjjvegDzQTe/gTbCY3c1UXIEEK0jFnKT0FNmkX7/41pY8ikY8FUqBMdHgJDmWfE9o
 i6txFFDMFi2ZkgO2bIc/7WalzSaj8NK7NHWSu4+lpVqnORc+5bon6/WQOSbWLfFnEcqN
 YacSJsz3E0g5ClRnLIBaE88toVxTgODSQTD7iKttxq9NmjdoAUCCbH9F0bv9AVzChd8u
 Y+VysIq1tCrxqmpvQcfp+Y6nxKT4orkNFBC2u16bWX6mMlpcHuG8FLzuy6uyqcIZUI6h
 ur9TkAsAw1UpQbeuVxpRQoQgzPsl+QWb/b8Z+vPIRQp/Or0SCeFqq4ILwjiI6O5Px9+f
 LMsg==
X-Gm-Message-State: ABy/qLYPvZIEfqafyzBYViR01llU6Yp+UNh+s/zDatCYYUEsG0Nu0ZuQ
 dhWAfSeG4xFftwqIl4g6cZHTcQ==
X-Google-Smtp-Source: APBJJlEuyG/5rpsgPmPyVW33jRSuMaAB+eNY8CZB/V2CaHHX7gCcHmNObvG+WIbm1P3MGFVhqaq3Xg==
X-Received: by 2002:a17:902:b605:b0:1b8:b382:f6c6 with SMTP id
 b5-20020a170902b60500b001b8b382f6c6mr12582418pls.9.1690933222047; 
 Tue, 01 Aug 2023 16:40:22 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:67b4:35b2:87e2:dccc?
 ([2602:47:d490:6901:67b4:35b2:87e2:dccc])
 by smtp.gmail.com with ESMTPSA id
 6-20020a170902ee4600b001b8a3a0c928sm10999831plo.181.2023.08.01.16.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 16:40:21 -0700 (PDT)
Message-ID: <19ce607e-80d9-bff1-03da-c013715639b9@linaro.org>
Date: Tue, 1 Aug 2023 16:40:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/8] linux-user: Unset MAP_FIXED_NOREPLACE for host
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230801232745.4125-1-deller@gmx.de>
 <20230801232745.4125-2-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230801232745.4125-2-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 8/1/23 16:27, Helge Deller wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Passing MAP_FIXED_NOREPLACE to host will fail if the virtual
> address space is reserved with mmap. Replace it with MAP_FIXED.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/mmap.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index a5dfb56545..2f26cbaf5d 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -610,6 +610,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>               goto fail;
>           }
> 
> +        flags = (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;


Again, this must be restricted to reserved_va == 0 or 64-bit guests will fail.


r~

> +
>           /*
>            * worst case: we cannot map the file because the offset is not
>            * aligned, so we read it
> --
> 2.41.0
> 


