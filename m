Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7487F44BA
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 12:14:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5lBG-0004BH-8e; Wed, 22 Nov 2023 06:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5lBE-00044y-2A
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 06:14:04 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5lBC-000292-Dw
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 06:14:03 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507bd19eac8so8710359e87.0
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 03:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700651641; x=1701256441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xArlKAU9VpyZGfAZTLPSPkkhWViQgzmkUPgbToSyLYA=;
 b=p97RlbOGd136Mbmeic85v1tYTRnmABD8C1vAmG/68EijvsjAvIwa6w/eNEA20Hujvu
 k+Rq8AB1yOzQcjOt7Dycp1E3rAU75qqFE/yLdXyLnx/Hgh0c4CarSkJHP1fAsHIkwTtz
 p+x5nwrbc+UXvVaZgX/5guZA0tMfP/snCSWYFCsN3lHvFXrvzROM3Y50gOQC60Yd3KtI
 KQB+/k/e94JJzevPNUMxsgezmpyb4u4cswuM+Bf/3niv+N1iVi65GDLdxtfAwxR64tlK
 2rXgXaYDApPQQizE1K7yixEBYbxO0wBjIz6f9CGqKC5Gt/zSZTdgqHrdveS04k+qzm5J
 4egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700651641; x=1701256441;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xArlKAU9VpyZGfAZTLPSPkkhWViQgzmkUPgbToSyLYA=;
 b=Dj8TFOcYpuUMfj7PakblQFOTVzGIXGPgOeYjjAYTCmnbftaBtVXmq9ftbADZeqXGJG
 7fhGl9n0nsGzdfU84mm5Ft8i6NnIONy6NMgnoKjrr5NePHBczd5sd4It3ToumXwEQWdB
 fVi1iSNf5MZLghxwYzYpff/ipKnpyn4eqxcUIsYrl6mnUI/tvv9yKNS914qvBhRab35O
 SAB5ypoMWzw8pult/3LrR9Ry54V7OilRYkBmbNe+FPwKwrgqU2eLcgpyRIIYCJRkVWJp
 L8CQZ4y8bJAQhRmNOVRcCtG+i/JAVLc/YxlDlmkUWeOTyjpcHlWdkhurU+xbrju+ps0H
 Uogw==
X-Gm-Message-State: AOJu0Yz2oz/F5WVrj2fC916FHs5pQqrWUvNNoujRBjsqKL9i0svKVtvF
 AjSiRa3lUQk4xKYi3mZq7Mt5yw==
X-Google-Smtp-Source: AGHT+IG20RXVbrDXXuj59jJPpy6xnVAYO3l60GC8A0QIivwdrM/PU1hSTsKxAfJQvJcDU0vmJ52S6A==
X-Received: by 2002:a05:6512:544:b0:509:4530:e7fb with SMTP id
 h4-20020a056512054400b005094530e7fbmr1219955lfl.32.1700651640854; 
 Wed, 22 Nov 2023 03:14:00 -0800 (PST)
Received: from [192.168.69.100] (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 a15-20020adfed0f000000b003140f47224csm16706766wro.15.2023.11.22.03.13.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 03:14:00 -0800 (PST)
Message-ID: <ebc45ef8-1745-459d-a904-630d041c366e@linaro.org>
Date: Wed, 22 Nov 2023 12:13:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ppc/spapr: Introduce SPAPR_NR_IPIS to refer IRQ
 range for CPU IPIs.
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org
References: <20231122092845.973949-1-harshpb@linux.ibm.com>
 <20231122092845.973949-2-harshpb@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231122092845.973949-2-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Hi Harsh,

On 22/11/23 10:28, Harsh Prateek Bora wrote:
> spapr_irq_init currently uses existing macro SPAPR_XIRQ_BASE to refer to
> the range of CPU IPIs during initialization of nr-irqs property.
> It is more appropriate to have its own define which can be further
> reused as appropriate for correct interpretation.
> 
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Suggested-by: Cedric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/spapr_irq.c         | 4 ++--
>   include/hw/ppc/spapr_irq.h | 1 +
>   2 files changed, 3 insertions(+), 2 deletions(-)


> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index c22a72c9e2..e7a80a8349 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -28,6 +28,7 @@
>   #define SPAPR_IRQ_MSI        (SPAPR_XIRQ_BASE + 0x0300)
>   
>   #define SPAPR_NR_XIRQS       0x1000
> +#define SPAPR_NR_IPIS        0x1000

BTW why hexadecimal and not decimal?

Regards,

Phil.

