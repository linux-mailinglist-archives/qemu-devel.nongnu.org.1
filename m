Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0067C6785
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 10:24:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqqyG-0004Tc-Pc; Thu, 12 Oct 2023 04:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqqyD-0004T4-S0
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 04:23:01 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqqyA-0007OQ-Jc
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 04:23:01 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5033918c09eso958712e87.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697098975; x=1697703775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vEbAvL6rJkK+tyI4avRZquI8VfniJZBrHrPnRLsaBJI=;
 b=oxNpjaYIJj4WwVZTGgDvPU6NPKfPQbQE9+yi3MeZnBNk2mKieZdfZ5cBoE1bF8E5q8
 Z01NmxkoAw2IFWo5/4OjaoSYkfeKN26TDupFUJtxGIub9lDMIJ/5bgMlBwhjO/RqsPLY
 MO0l1zukY4AfSLCok0YiLBUpGVCbNDiwcW2c9RwYtx78NRpMDAdohCLHH1xgxuDJBfcF
 uEBXUBP1E6F0SiSFw0WhZljI0iajIxUjasykzsI3z7QObnz+Dp+jqjGpuS0kVoF9KO1J
 mQnyDoeuXwse5lEMxURqq/6fWFnXihoNpXtGH+l79M/m00US8A7s7tmYE52jcwVLVM6n
 fuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697098975; x=1697703775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vEbAvL6rJkK+tyI4avRZquI8VfniJZBrHrPnRLsaBJI=;
 b=obn0HH/jyCtKZeTrU8alWHDA+rAJcNDthevVkkpzr/CBsYOCsKHqWE97e57Pmm86C5
 aRBxCxEfV/v/D5uR/U4dqnW9lZHcY2eLWNFX7CdTf61oboWVG0+gF8OtdclXVElV26BJ
 vWmXO42uFgnVhlEIKiRuLaD3kl27gbnPMyicqSHRgdKRoZ3E7qdnHLmN8y0bSupKtm1U
 CaI37bgBMuT+UBViHh5+Vmm6A2CiFw/zo3qeuBblhq14t2ujDfSjHrmRVTBN+p435A/7
 z1ozRp2vOedyzz07vBBRkbe2LtEIlRcU+6BlTP1GPJdMMCbQJ90c7fYlZfvZb5YLmYvw
 QxCg==
X-Gm-Message-State: AOJu0YxaiyHsCBZjW++5oouNwx5Ja3lVRMztyYgSf4xFD6baRTIAG4/x
 RnQ5mO86/6HAhOLlnjIKV8nLU9s9DLk/Jnf4LZQgtA==
X-Google-Smtp-Source: AGHT+IEb6XTaN2pStg6rBU3EJyXPT4vb/0dQEmpgpBw7FMF11tEkHloXYs+qAh/K+lYdnpJfxkvJvg==
X-Received: by 2002:a05:6512:3450:b0:501:c3ee:62ec with SMTP id
 j16-20020a056512345000b00501c3ee62ecmr15747273lfr.12.1697098975501; 
 Thu, 12 Oct 2023 01:22:55 -0700 (PDT)
Received: from [192.168.26.175] (192.red-88-28-24.dynamicip.rima-tde.net.
 [88.28.24.192]) by smtp.gmail.com with ESMTPSA id
 v5-20020a05600c214500b003fbe791a0e8sm18973251wml.0.2023.10.12.01.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 01:22:54 -0700 (PDT)
Message-ID: <788f54e1-3f2f-f24d-63cf-172efc605823@linaro.org>
Date: Thu, 12 Oct 2023 10:22:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/arm: Move raspberrypi-fw-defs.h to the include/hw/arm/
 folder
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-trivial@nongnu.org
References: <20231012073458.860187-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231012073458.860187-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 12/10/23 09:34, Thomas Huth wrote:
> The file is obviously related to the raspberrypi machine, so
> it should reside in hw/arm/ instead of hw/misc/.

Not quite. These are the VideoCore DSP definitions. Firmware
running on SoC including a VC can use this syscall-like interface.

FWIW there are a pair of QEMU VC implementations on GitHub.

Anyhow, preferably rewording the description,
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> And while we're
> at it, also adjust the wildcard in MAINTAINERS so that it covers
> this file, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                    | 2 +-
>   include/hw/{misc => arm}/raspberrypi-fw-defs.h | 0
>   hw/misc/bcm2835_property.c                     | 2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename include/hw/{misc => arm}/raspberrypi-fw-defs.h (100%)


