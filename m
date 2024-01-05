Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C18BD825507
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 15:16:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLkzB-0006gk-2e; Fri, 05 Jan 2024 09:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLkz9-0006gF-0u
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 09:15:43 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLkz7-0001oC-DA
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 09:15:42 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5573a920ca3so672241a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 06:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704464139; x=1705068939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/pQkWhyVAgLh2a5bF8O+lh37VOYn4VWTRG/YAHWjLOY=;
 b=pCK2bdPttGkIaaWr7JGsB5RT+JLRNo9gnuWa/2Yj9WpO+TGF3Ywch0ZxDsDk254eT9
 bjAfR2/aqQll29jHRJOCCPNiOXBtgasUBgTHXdIM5zTeW+BdXeK1iSh5m7P1EjqPVgab
 eK4zalSNDrJAii3rBNAn6KiCffu1DNQ9KmDZEnj/5wg5bWYdCC7OEzLoeXC85Coo5Wva
 LSldQBl5/sa24GfvVsCda5hJkLBWaHqH+ffi9fH/2nhttr/I83r4y3Lvtp0MT5srHlMG
 jC/mCflwKlEXbJjq1VRWz5m3735fO1PBvZ+Loi4yIm5sH7wVPDcFEGU5hMyXYkFP18WY
 igoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704464139; x=1705068939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/pQkWhyVAgLh2a5bF8O+lh37VOYn4VWTRG/YAHWjLOY=;
 b=ppwhwQpa2hElMfgxR5S8L7LvUyOm9B5leFrc6RrOliEQQkeMuCm9teRngMCnTn/Z32
 KwDZuOzgEK0euUhaIYZmtDSDj9KJYZgBat5EqZItaD2xts6IsHsFUSDrTmTbEjkVlMnQ
 8fiwuzBXy7kWpCdU+KBeYkZa4sC2hv61CYQ8nCnv4rMmonOVUdXXpLQftBByHmNrBxpV
 EYCJhFdR3MroD/qrlXhyDL/zwVIRwvCWEXEcbc+VB2J5WpLMSFEC5KMgercaqdl8YjzV
 SGn48S3oKhk0YR0imRoOzrqCEfpyDu5qajjMsnVlK1pWFbPvoI8ESa0X6IQlFUOzrNVc
 VP7A==
X-Gm-Message-State: AOJu0YzZRCBN0HPnw3pDuIzGCHYSdq5cr/VgHBrycP2qNJs93lFDc40M
 a2wMnKdu+z83Pbd65OmkqEae86sO8epV7g==
X-Google-Smtp-Source: AGHT+IFZQ44OU/NdzG5oNIZ2A66MKaEsxi11rZYKC+BbAE1OdZAEK8jkL6mlLWuorDClQ3KsQpTOdQ==
X-Received: by 2002:a05:6402:4314:b0:557:2233:3386 with SMTP id
 m20-20020a056402431400b0055722333386mr1306672edc.4.1704464139431; 
 Fri, 05 Jan 2024 06:15:39 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 p10-20020aa7c88a000000b00557075b4499sm1016313eds.58.2024.01.05.06.15.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 06:15:38 -0800 (PST)
Message-ID: <07cfab6e-0671-45e6-80ba-f65500b41259@linaro.org>
Date: Fri, 5 Jan 2024 15:15:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] intc/grlib_irqmp: implements multicore irq
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20240105102421.163554-1-chigot@adacore.com>
 <20240105102421.163554-5-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240105102421.163554-5-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 5/1/24 11:24, Clément Chigot wrote:
> Now there is an ncpus property, use it in order to deliver the IRQ to
> multiple CPU.
> 
> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/intc/grlib_irqmp.c         | 43 ++++++++++++++++++-----------------
>   hw/sparc/leon3.c              |  3 ++-
>   include/hw/intc/grlib_irqmp.h |  2 +-
>   3 files changed, 25 insertions(+), 23 deletions(-)


> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 7b9809b81f..94d8ec94b0 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -168,7 +168,8 @@ static void leon3_cache_control_int(CPUSPARCState *env)
>   
>   static void leon3_irq_ack(void *irq_manager, int intno)
>   {
> -    grlib_irqmp_ack((DeviceState *)irq_manager, intno);
> +    /* No SMP support yet.  */
> +    grlib_irqmp_ack((DeviceState *)irq_manager, 0, intno);

This '0' was not obvious, now I figured, I suggest:

       /* No SMP support yet, only CPU #0 available so far. */

>   }

