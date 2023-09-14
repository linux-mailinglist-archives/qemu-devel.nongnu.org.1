Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A24279FBA2
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:09:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfXE-0005L6-Vy; Thu, 14 Sep 2023 02:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfXB-0005Kx-DG
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:09:01 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfX9-0006R1-Qz
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:09:01 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-501bef6e0d3so922358e87.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 23:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694671737; x=1695276537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RWyYsUKRTwmeWyVQHg3++Fdlb6uLwndqS1zpEXpVjHI=;
 b=NZdJyWDWrM9wLbarHmHWp0QfbOLCYMOOPBsbGE8jm3Xm3fSPAhu0hrJoomFQ1zGJbp
 ttmAmMAX3pd5xTRPwgyjH29sma5Iwi9WpCopw/6dtgYmPBPc2XNPIldyCUplOVEf4wKa
 jP+jl9Lo4kTFfI7ld4inSWo7ZtRmNnniA53209agiTKXKDNrde0ZHW4S4zaeN5s6BXK4
 H0Mj04pTrzHWM7JOwT5uPD8djzPpdVCMCZBVuxaEJIMPgUK62y/8a/90RTBpeFbZi7GA
 jirkejjCWbqcPeuaaZ3s28LUp1Dg9kTrg1MeEkua3s2gY+1PMU04S91lffvDd589tkyf
 Us8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694671737; x=1695276537;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RWyYsUKRTwmeWyVQHg3++Fdlb6uLwndqS1zpEXpVjHI=;
 b=mRViLMugV0Rf90i5FXIXpImyq5HXSblA5fbQFGnjhotGRv0yPiWhb2FfIhShj1pTc2
 F+FuD9ktgVDSrsUDoWKFIEEdsXHZl7IUQZscHxCHvqxRnhjk2a/npqTjW/DrFhCrOOjO
 TJ0U8L9NMVR42KFOkortJTGdeUtCGGt+iv5SpPzdNadTcnhO5FG7VQZUlLm7KgfYdfiU
 4heJ5nhtWrE31sCxe/H7yF4AlSeoR4Q810HzW9V/5HP4gVXDa2d1VA7IENSwyNB8Fyh3
 UsJPmLNKCmIgvqzj2ENePYAQcN21tdch7U56stCEDFS0wB4iontbYyBRZRJ4pzytOSJ2
 umRw==
X-Gm-Message-State: AOJu0Yy7EqJr8oHlofjRaowCjYwGJKatnFpFPrbSgdtwh5IHzmOrrOEl
 N8I1/2UaktDpX/UlFVOTln6J5w==
X-Google-Smtp-Source: AGHT+IF0E1TG7ka3jRqZ7Yh81x1JeG3oY+2HwE5s9muHU5QC/3JTOdduHjKqgyDqkhek/dw8kFxQ2w==
X-Received: by 2002:a05:6512:1190:b0:4fe:94a1:da84 with SMTP id
 g16-20020a056512119000b004fe94a1da84mr4226084lfr.5.1694671737328; 
 Wed, 13 Sep 2023 23:08:57 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 gs10-20020a170906f18a00b0098de7d28c34sm493958ejb.193.2023.09.13.23.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 23:08:56 -0700 (PDT)
Message-ID: <f6c1eb5e-f870-b992-0837-7400390e821c@linaro.org>
Date: Thu, 14 Sep 2023 08:08:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 11/24] accel/tcg: Remove cpu_neg()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914024435.1381329-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

On 14/9/23 04:44, Richard Henderson wrote:
> Now that CPUNegativeOffsetState is part of CPUState,
> we can reference it directly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h           | 11 -----------
>   include/exec/exec-all.h          |  2 +-
>   accel/tcg/cpu-exec.c             | 14 +++++++-------
>   accel/tcg/tcg-accel-ops-icount.c |  6 +++---
>   accel/tcg/tcg-accel-ops.c        |  2 +-
>   accel/tcg/translate-all.c        |  6 +++---
>   softmmu/icount.c                 |  2 +-
>   7 files changed, 16 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


