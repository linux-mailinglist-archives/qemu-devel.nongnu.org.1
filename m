Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 023727230A4
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GQn-0008TW-Hx; Mon, 05 Jun 2023 16:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GQl-0008T2-B6
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:03:55 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GQj-0005Ag-Qv
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:03:55 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-651f2f38634so4800940b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685995432; x=1688587432;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8nf2scfxi1ezwNm6grB20ScTTKEFTfOs5NwJVdYOYV0=;
 b=DD4Wxka1X/WGRG4vmZ1b/rMJFANmwR1cOSSAqccrIaJaENTdYh2ZSWNLL21n2JumZ2
 tyzaPuHmJrQJRhtmDNjjp3F6j6ZRsLkATgWthjQ7KSRadyTDt7+euReCMLFQqzaHOchQ
 UQRdZEaJ/gC+V74vNeEg3xCShgeeMuiiU2dUTWwSor00zdL467EHhTZ3l6GP7f+DTd5w
 wybF5oy4lRFtSsAGeo0HfqvJ9zwJ4qKxYub+JtI36SyVrCxIyNxeFzsGR5qKDqvQwYeL
 CmHrKHqq3obyHpozpZ4Dr4knRbwuW+8QN8+hBEeP6o2xUf/gKDEMJ7nn9fkfoKmZ+Tqt
 Si9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685995432; x=1688587432;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8nf2scfxi1ezwNm6grB20ScTTKEFTfOs5NwJVdYOYV0=;
 b=NZxNS2s8QqkjSR/Wocb+jCZKBVH0YGhrdk27QYgtCLT40AGBmPFF+UVG/2O4JUZJLg
 1Hmmjz3dGyXbfRQAwJsAy4xMN8ZCKbjeAk3l7ddP5hYKShQED4DtEn/EJoIMpY++Lc82
 HE2voV9GNcwwQtz7+MI88UcXbm9wgAvO/QeBPqVDbiXU0oK2dwAns3lWNsIWlDm9XRLG
 RDZZzfn1bm08cAC3yOthDte9xMierJ7JslI5eWugS3fU2fjzw5z8kE74dGNbRQhHHmSu
 zC5fXi9hgyyNXkzl3L/rQZpT3oCOzzkWEGKUQue4lxQfMcfZ5xUtNVvs6eytBZ2PoCFu
 Kr8w==
X-Gm-Message-State: AC+VfDwhbFVOJoc6VfFFzNTQeU9shjTvK9FKoujQI0fNTddwwm6Z/m0n
 vXl4FfmdTTLJxhM9g47SQGvziQ==
X-Google-Smtp-Source: ACHHUZ6jgopXKGigVDRLK/9bapOqwrlhQOuQRITVyySAqi/cjkhHBwUaeG1cad8X47LCJDGHkWt5BA==
X-Received: by 2002:a05:6a00:c89:b0:640:f313:efba with SMTP id
 a9-20020a056a000c8900b00640f313efbamr850505pfv.19.1685995432198; 
 Mon, 05 Jun 2023 13:03:52 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3f85:a600:6a3e:e465?
 ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 w12-20020aa7858c000000b00653fe2d527esm4473657pfn.32.2023.06.05.13.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 13:03:51 -0700 (PDT)
Message-ID: <5ffbe75d-0bd0-65ae-4eb4-31c42d033663@linaro.org>
Date: Mon, 5 Jun 2023 13:03:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] util/cacheflush: Avoid flushing dcache twice when not
 necessary
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230605195911.96033-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230605195911.96033-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/5/23 12:59, Philippe Mathieu-Daudé wrote:
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
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Based-on:<20230605175647.88395-2-philmd@linaro.org>
> ---
>   util/cacheflush.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

