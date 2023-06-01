Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D56719AC9
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gGY-0007go-FK; Thu, 01 Jun 2023 07:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4gGV-0007dz-S5
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:14:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4gGU-0007xP-9s
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:14:47 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6dbe3c230so7406785e9.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685618084; x=1688210084;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ric4xZY4sbwDFeewEqiUuPNK4iBDi81PyG0iU1oWHTw=;
 b=U1IXFPZkJyUP0M8TgY7P6iAzULoguz9pM5frluiHnT93NQZkKpvh1Pdkea+YfgUqdf
 G5zhK1CJN1nEcAAWwkVPq0LaEcV42p2E3ff6Gen5lvJtLUW6luOtV+4Dae7msroLYe9W
 vfTR7N+A74hzCdcGhIfi5JXowUdIBQogQ7Aa4CNyScyYvsqEuer9AOdq8o8syU42/we/
 7ajE2Qtl8572AI/pd352iMrMSlpqUDQ6Xjxu7ey5c8hm2RsxWMCUK8f+8tkZKY4aH8AK
 MUCGYA4SrPKY8IruTNG8rk95swu2txbfNI1HAt0f/MebkZsdNzpX0XhcqlrpO+7TzF/f
 ssaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685618084; x=1688210084;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ric4xZY4sbwDFeewEqiUuPNK4iBDi81PyG0iU1oWHTw=;
 b=FXcAwTyDk9SK/Dv/guSoywm1ikTCP0vAUf6H0GFEDwZnwx1jaCNWpRwI9FHiNA/4rp
 N56vdWw36cl6w8hFgf8uS2JF6dFFBlgRsP/8qvwS/Jmms2aM9Ez8rxkyoKQDEhRir1yo
 MrLyH3zry+x6APFA5zDncwKw/T4mtQeTZVUYFkO306TRZR5XEK6pdT1dUqFtoSvKNUve
 EzhE4jDY61acwA5pkPZ0+EcQCvPQKo6vRfvAqt8ezAHjLMG5ERw4m1ezrSQtn4T+juXR
 EhGK+LLYvtJLk3tYs7P+coDH6xvdOn6qFRVOGQo3FPuhM+b7njb5ST+BHixToUhsIw6T
 bQ1g==
X-Gm-Message-State: AC+VfDzi5/eEXoXATKxom27rTwNzkFyHNfv0Cx6+z3UAf+QCr2wyJ2QS
 uuYEpiIzzwS5/+pZSp9eta8UsA==
X-Google-Smtp-Source: ACHHUZ5RNo0x5dWK4vG5DB6VvZuSSNCcoEkdCViLLl4o+vQpgnEaJsrdXRHQPDmrmQSYHBdU79YaOQ==
X-Received: by 2002:a05:600c:205a:b0:3f6:a44:73bb with SMTP id
 p26-20020a05600c205a00b003f60a4473bbmr1771428wmg.8.1685618084712; 
 Thu, 01 Jun 2023 04:14:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 d24-20020a1c7318000000b003f17eaae2c9sm2064482wmb.1.2023.06.01.04.14.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 04:14:44 -0700 (PDT)
Message-ID: <31c23dd3-8c13-30be-2ebc-6cc417b2fbc2@linaro.org>
Date: Thu, 1 Jun 2023 13:14:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 26/48] tcg: Add guest_mo to TCGContext
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-27-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 31/5/23 06:03, Richard Henderson wrote:
> This replaces of TCG_GUEST_DEFAULT_MO in tcg-op-ldst.c.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h         | 1 +
>   accel/tcg/translate-all.c | 5 +++++
>   tcg/tcg-op-ldst.c         | 4 +---
>   3 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



