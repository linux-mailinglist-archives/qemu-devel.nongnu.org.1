Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 800ED78E0D1
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 22:40:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbRyZ-0004TZ-9L; Wed, 30 Aug 2023 16:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbRyW-0004Sz-Kk
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:39:40 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbRyT-0001WH-S0
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:39:40 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf48546ccfso497905ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693427976; x=1694032776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y+c1aY9H0ewTlnIm/H9ttVZwgicbrE75sp1yURphyrE=;
 b=hkyJf0hyhwbTKQcfmciW9OmGlSEfDPAv2NLb8qi/hEVX+lfHPw246pDY3IHyJpwiV3
 vU6soW1omFMkSQF31U+h1x8B0gmJ2IUUrLAbfTeWRpyWkw48T7JPLOE8ZJmajYC4CbIo
 AFPHxkw2dv+7kK4xSCs54s/r7jVylVTPYoFZJF7IFMXUJ62632/pYuEUOBKJn+09z8SH
 F9hLak98Zx4HR4O6cxSl2bFdSOexU20O9jmefDf94bzYhFFoZF5eIclWUuZuhuzj7ZUt
 UsUo+25Vz3K/AtCT3tta/1TG1F4kcaP9ZA/gRImZdHvlgFL7kx0OCZmAv1epGakzw1Vp
 3TNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693427976; x=1694032776;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y+c1aY9H0ewTlnIm/H9ttVZwgicbrE75sp1yURphyrE=;
 b=AP8g2tGz6cJ0yzjSb+ny1ucdFKihB0nUYnGZUqLR8aBf+/uPehGOTzMprVRDSfaWzC
 A4Oew6HX1d9xT5qdR2snGTTddyyswAYNlGGSy6T6fhb0d9CTra9g8ssJa6CxuXV+/dnX
 UkHBmBgzGI7oOfNq0P2j4q0en8YFkz9AlXoyuA2wZps8X+h4UaKy7oEk1ABrPKY8FPFQ
 gY/uiiB2BoyAQST7SQ+xD0TvL1lp08xR6DfIqkcedHmZlZJo+agLJ7tR+wtP+TCpPLUm
 t+uqw0Og/wLTzA7ZQnZbiNwrazR7WFQ/JOVHlYZuZHEnYQOOg/CrXl0QDVXrFM2PbDxO
 LlqQ==
X-Gm-Message-State: AOJu0YyfK99UBFRZVKjwLMepIcHWjz/J4m3gRxvR6SYngX2Lx/6auBFM
 xkL20IwgnydTlacC9BjLHD3pjg==
X-Google-Smtp-Source: AGHT+IEqI0I6QZgKXp63dz66uMtVJAOaNIX65CetZXiCBLkgsWq4TNEEE14Efq/L5DVCr7MLEkFtyA==
X-Received: by 2002:a17:90b:4acd:b0:26b:4e40:7be8 with SMTP id
 mh13-20020a17090b4acd00b0026b4e407be8mr3204188pjb.12.1693427976145; 
 Wed, 30 Aug 2023 13:39:36 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 bf7-20020a17090b0b0700b00263cca08d95sm1617259pjb.55.2023.08.30.13.39.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 13:39:35 -0700 (PDT)
Message-ID: <866db717-92a6-1e6a-cd50-fddc79b9c057@linaro.org>
Date: Wed, 30 Aug 2023 13:39:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] accel/tcg: Fix typo in translator_io_start() description
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20230830160834.42069-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830160834.42069-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/30/23 09:08, Philippe Mathieu-Daudé wrote:
> Missed while reviewing commit dfd1b81274
> ("accel/tcg: Introduce translator_io_start").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/translator.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/exec/translator.h b/include/exec/translator.h
> index a53d3243d4..4e17c4f401 100644
> --- a/include/exec/translator.h
> +++ b/include/exec/translator.h
> @@ -159,7 +159,7 @@ bool translator_use_goto_tb(DisasContextBase *db, vaddr dest);
>    * translator_io_start
>    * @db: Disassembly context
>    *
> - * If icount is enabled, set cpu->can_to_io, adjust db->is_jmp to
> + * If icount is enabled, set cpu->can_do_io, adjust db->is_jmp to
>    * DISAS_TOO_MANY if it is still DISAS_NEXT, and return true.
>    * Otherwise return false.
>    */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

And queued to tcg-next.

r~

