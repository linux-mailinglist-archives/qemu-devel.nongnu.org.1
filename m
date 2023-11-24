Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 123847F72F2
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:42:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UZK-0005aD-Vs; Fri, 24 Nov 2023 06:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6UZG-0005Zl-Ov
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:41:55 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6UZ3-000144-O3
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:41:54 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507f1c29f25so2492585e87.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 03:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700826100; x=1701430900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LLdTj1hC4loE8PyfPU7TG4P2nXHktOX8GhzvC206YiA=;
 b=TwqlhA++tZNMhNfxoOw5z6r9q/7w1SM+cbwDI/4CeAEgvlFaRTEPuroH3eQV8R6o0N
 wIaFbJJimpRMOb3qscXwRWaXHV66B+HmOdDaMyjJCNWgi3V2/Yyep7ny2fBgl8Qeihuq
 1M31IJa/FAxZm3BQA/m3+tEKqtahTWTd/qzBhwNB2AJU4MEcDw1DsFCydNHaD0KN0gsd
 czQ+4zD2wcKoGzyuZ9AkZFKT9hfrWgUOPGFnjm6j6U16ybCkUtqXl0NXrE289BlyCLpG
 V0OuFqGiDo7ewg5sYyTPo4ooeIYXzz7Napej1c41x5asTGPzl1zskRsn7u/mandVwzms
 oA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700826100; x=1701430900;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LLdTj1hC4loE8PyfPU7TG4P2nXHktOX8GhzvC206YiA=;
 b=Kg044MAb7cpOcIk2Rltm5pWSUHBrScV5r/yl7FWIJdGXMrQwx2WxSqQbzVkYEcMpFV
 DHiuNWN88dl7orIOEXt/8e5ErHe2sWpDtMpGtk227fsFnOy4tL6pOm80j2pICBOXt2FX
 eWD+oDDREqWHWXCzzUSV9pfAJX8iJe0yebU7sX/eIFEE2A6ACba2OjYz7XWj8rFfOi3G
 kQMU7NWC+dwR5iZXjAURZVrb54Ro2VVxcQYDZJigeMmOnc9/MSFcMnZGIqhX9g0r/1De
 OR26ox2u6ImA/+9nNXhbOCOs9wWPjd7SwPstYDV+JHctOQsUd29hYieTUmvsdb2XGidm
 r4ow==
X-Gm-Message-State: AOJu0YxP0zbnbkIIihxCzFrjud4+AQCU8iSyc1wgGApPWj1/CF9kt381
 TewZboR2w/LFwa0LbG5U26ab+g==
X-Google-Smtp-Source: AGHT+IGgDr8XMiPCanbfKhn3K0vLv7kpQt09mvsnKuFg5EgCkFisO+PqzYT2sBXR/HuOOUMoMCfOWw==
X-Received: by 2002:a05:6512:3c8f:b0:509:4587:bdd0 with SMTP id
 h15-20020a0565123c8f00b005094587bdd0mr2414694lfv.7.1700826099880; 
 Fri, 24 Nov 2023 03:41:39 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 m23-20020a056000025700b00332ce0d7300sm4102681wrz.92.2023.11.24.03.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 03:41:39 -0800 (PST)
Message-ID: <89482575-2fe4-48f7-86f3-1bd77baa4475@linaro.org>
Date: Fri, 24 Nov 2023 12:41:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/21] target/arm/kvm: Merge kvm64.c into kvm.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Hi Richard,

On 23/11/23 05:42, Richard Henderson wrote:
> Since kvm32.c was removed, there is no need to keep them separate.
> This will allow more symbols to be unexported.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm.c       | 789 +++++++++++++++++++++++++++++++++++++++
>   target/arm/kvm64.c     | 820 -----------------------------------------
>   target/arm/meson.build |   2 +-
>   3 files changed, 790 insertions(+), 821 deletions(-)
>   delete mode 100644 target/arm/kvm64.c

Reviewed using 'git-diff --color-moved=dimmed-zebra'.

> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> deleted file mode 100644
> index 52c0a6d3af..0000000000
> --- a/target/arm/kvm64.c
> +++ /dev/null
> @@ -1,820 +0,0 @@
> -/*
> - * ARM implementation of KVM hooks, 64 bit specific code
> - *
> - * Copyright Mian-M. Hamayun 2013, Virtual Open Systems
> - * Copyright Alex Bennée 2014, Linaro
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or later.
> - * See the COPYING file in the top-level directory.
> - *
> - */

IANAL but shouldn't we keep these (c) lines? As:

-- >8 --
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7903e2ddde..b8fc1c8d87 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2,6 +2,8 @@
   * ARM implementation of KVM hooks
   *
   * Copyright Christoffer Dall 2009-2010
+ * Copyright Mian-M. Hamayun 2013, Virtual Open Systems
+ * Copyright Alex Bennée 2014, Linaro
   *
   * This work is licensed under the terms of the GNU GPL, version 2 or 
later.
   * See the COPYING file in the top-level directory.
---

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


