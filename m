Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E783E793748
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 10:41:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdo60-0002ZE-Qm; Wed, 06 Sep 2023 04:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qdo5x-0002Yd-8D; Wed, 06 Sep 2023 04:41:05 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qdo5v-0006zr-61; Wed, 06 Sep 2023 04:41:05 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4ff09632194so5826856e87.2; 
 Wed, 06 Sep 2023 01:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693989661; x=1694594461; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0+1kLVjB9jRPH5mJ+IAeZdWkc0pbgAJT7COQDbmIzV0=;
 b=hWVFMRrjHabNJvYOmo6clyo/P7rhulIVXNvf9WO4Q5hdY4Toz0TvHgeIu8gbD9CuBa
 B88oUGXdgZXDzrrWRNJx5XdXEHTCe5wedxmDmWJBFuh+q/EPYdnEdYq9p4+Jnif3BynR
 X5ukg8xgy5owDAosofcXm26jeSqH+cERFQrHEzjohKzqSTR8yqoKs9oinp4ctw+PI9R4
 Ap+JQpWMqH6KrBRFHmJwJso+/TQ6TcgRegCGzJNxHklMm2Fg+VQLPc6+Pj3Z2WJjWu5C
 D1MBs8CcK76wB1TVZ+R4v7tsMpJ9bpVyqFpR6cYnACJcWJjQMmZyH9NpcGMT4IOFmlF8
 pm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693989661; x=1694594461;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0+1kLVjB9jRPH5mJ+IAeZdWkc0pbgAJT7COQDbmIzV0=;
 b=j93nOl6okquAYBRu70m8Twc3Od81Ubfvg3Ar7yTJ8Jg5S4dtZRPgZtCpthvqjZ+tG7
 7eMVgTMjkfdM+DzcloOScpnMF3BOQiAVhlkcZY29sSZWt2FqpX+5Y05CKe20/mTHWuOC
 RVpXwMdgkd9t+eGmvBTYXBPC66+8G0BXfcXn6Q3IZ7wc7dI3dLmMm4CysxDh3Qmm/JtA
 BQfQGADsL7MNQMx5/cZ0u39LN3n02RK2/0L5YYVGXGkjq20FLhidnnDyG6O+LuILT6O+
 yaYLLMbBzO4eH9CIPrjPz5roz2bWQsjJ8awqrxVsqP2ltO/OoR543704mTygkuLchyd7
 O2ag==
X-Gm-Message-State: AOJu0YwgkpgNWpYL+rCPKJo8pnCkJ+/jR7SBwwIrpaoA1jy757VrQua8
 6XGNlJQcqo5VkDw4c6E3g/kId8Gmx8Q=
X-Google-Smtp-Source: AGHT+IHV43a075miMgA3+2fD9HZJv23EK1P38W8p93e1pejeNaS9k0PT0oJvmava4Q52NTMC7mhghg==
X-Received: by 2002:a19:4f52:0:b0:500:9d4a:89ff with SMTP id
 a18-20020a194f52000000b005009d4a89ffmr1671270lfk.62.1693989660380; 
 Wed, 06 Sep 2023 01:41:00 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 m22-20020a195216000000b00500a0d870c6sm2668300lfb.282.2023.09.06.01.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 01:40:59 -0700 (PDT)
Date: Wed, 6 Sep 2023 10:40:58 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH] hw/intc/arm_gicv3: Simplify gicv3_class_name() logic
Message-ID: <20230906084057.GR6984@fralle-msi>
References: <20230905145651.8199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230905145651.8199-1-philmd@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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

On [2023 Sep 05] Tue 16:56:51, Philippe Mathieu-Daudé wrote:
> Simplify gicv3_class_name() logic. No functional change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/intc/arm_gicv3_common.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 2ebf880ead..8863f06b67 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -612,13 +612,12 @@ type_init(register_types)
>  
>  const char *gicv3_class_name(void)
>  {
> -    if (kvm_irqchip_in_kernel()) {
> -        return "kvm-arm-gicv3";
> -    } else {
> -        if (kvm_enabled()) {
> +    if (kvm_enabled()) {
> +        if (!kvm_irqchip_in_kernel()) {
>              error_report("Userspace GICv3 is not supported with KVM");
>              exit(1);
>          }
> -        return "arm-gicv3";
> +        return "kvm-arm-gicv3";
>      }
> +    return "arm-gicv3";
>  }
> -- 
> 2.41.0
> 
> 

