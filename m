Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5601972309E
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:01:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GNx-0007Wc-EB; Mon, 05 Jun 2023 16:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6GNg-0007R2-7c
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:00:45 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6GNB-0003Rd-P8
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:00:28 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f3b4ed6fdeso6617052e87.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685995212; x=1688587212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g+u2mCMZ/CP8aWbRTpWgQSUWAWRX2AfPPr4ZAtkEIS4=;
 b=c5J9xkzEgSIAx7SolRKXRvIAwCeNov4NFbPut2Hkc1AcOYhU5lBHwN+0Niu6l767Cy
 qeDZp9qAZ2MS6BAkBDo5nrBpEKajgPo5gDVG0B1c5p4pe3MIcVNoNBQPy/507yv0MsCh
 L52X3KCVxpwEL+JAZxKlHFikTa0kZ9xxwmM/arNGmi8EjR6zO7JrzxdE+/XrJzbUVXBP
 Rm0tqUYEBj6Zkr/KgNe2EmA9Q2naE3uZlxlCWaPOsTT0CfHiSlpkwi3kKbPdUckMKNI5
 hllrb60tGHPHLrpMnS/Kh516k3PupRUvafRvDe3J14oAXnWNQ9UWkQY2ZKKjYJCU4QFw
 BovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685995212; x=1688587212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g+u2mCMZ/CP8aWbRTpWgQSUWAWRX2AfPPr4ZAtkEIS4=;
 b=UJJeZCFgfgi/bYsBUmnXqKPSq1USFPXuzgV8Y0Dj7qy7g7bHmcXxyzDkxMy0nkz7DF
 LEB9uk9Ux4zYC9JJlj13zkugVNZoQy33MB+2oeJp3XJAV8OUtuNF0MRz4taOsNDxLtzk
 2jNctIrMAKCSYi2TdLzgXlJewFGxK6droV4hBbiyQR3ZsQByVKv0WiEoTAHySGY6C8gn
 8b2So51X1zKbW+SyFBYn+w5j+HxKc+MFvNhmMj7bZRXrcqEMQmy7abzNqqV2N2dPZpVz
 rHDyjK0uyLO1QAsEH1N5RRaNUqgtDXYcpU8/z36Ow81lq8SE8nQbpEiKAfr0l+TSP/sL
 AZHA==
X-Gm-Message-State: AC+VfDwJHLVAhc8a1xFSvX8B7fp0n8y1BIHFjhopLjC/l1W12ybFOz9t
 HS3tjpGL3DPrtQ4MuNoQBU9tAFZxOzOAbUFLoDU=
X-Google-Smtp-Source: ACHHUZ74TrBQ8DXKUY7Wa6IcOquT9j1tQslz2liDTsx4CXUM1cGbyG3f0dkGIEO9Im3fNtWAXKOLag==
X-Received: by 2002:a19:700a:0:b0:4ef:f1f4:14db with SMTP id
 h10-20020a19700a000000b004eff1f414dbmr18425lfc.16.1685995211648; 
 Mon, 05 Jun 2023 13:00:11 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a1cc912000000b003f4e3ed98ffsm11738032wmb.35.2023.06.05.13.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 13:00:11 -0700 (PDT)
Message-ID: <b331c239-ea54-1721-1253-bd1ca60c4064@linaro.org>
Date: Mon, 5 Jun 2023 22:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] util/cacheflush: Avoid flushing dcache twice when not
 necessary
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230605195911.96033-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230605195911.96033-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Subject: "Avoid flushing dcache twice [on Darwin] when not necessary"

On 5/6/23 21:59, Philippe Mathieu-Daudé wrote:
> <libkern/OSCacheControl.h> describes sys_icache_invalidate() as
> "equivalent to sys_cache_control(kCacheFunctionPrepareForExecution)",
> having kCacheFunctionPrepareForExecution defined as:
> 
>    /* Prepare memory for execution.  This should be called
>     * after writing machine instructions to memory, before
>     * executing them.  It syncs the dcache and icache. [...]
>     */
> 
> Since the dcache is also sync'd, we can avoid the sys_dcache_flush()
> call when both rx/rw pointers are equal.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20230605175647.88395-2-philmd@linaro.org>
> ---
>   util/cacheflush.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/util/cacheflush.c b/util/cacheflush.c
> index de35616718..a08906155a 100644
> --- a/util/cacheflush.c
> +++ b/util/cacheflush.c
> @@ -241,7 +241,14 @@ static void __attribute__((constructor)) init_cache_info(void)
>   
>   void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
>   {
> -    sys_dcache_flush((void *)rw, len);
> +    if (rx == rw) {
> +        /*
> +         * sys_icache_invalidate() syncs the dcache and icache,
> +         * so no need to call sys_dcache_flush().
> +         */
> +    } else {
> +        sys_dcache_flush((void *)rw, len);
> +    }
>       sys_icache_invalidate((void *)rx, len);
>   }
>   #else


