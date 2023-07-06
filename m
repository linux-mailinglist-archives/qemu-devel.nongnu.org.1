Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9673C74A284
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHSCL-0002qo-6U; Thu, 06 Jul 2023 12:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHSC9-0002q5-BT
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:51:08 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHSC5-00009Z-8A
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:51:04 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-992e22c09edso109260466b.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688662259; x=1691254259;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xz5uFkMVAHreoQsP7qWUQ7Nk5ICo8gFm0Z5UxHN3DYM=;
 b=O9DU5yRoGcUpnn4ec/qHb8Nr9a5nBpuuP32GE4LsyDwg2kA1/cJZVL/l9EFQ/boiPO
 KZFee4mlDbTMSd+z4UTxzI2B8yZuqUSeYslw3nEHDs4c2uesl2whELy7XiYerLZGMwQA
 l8oFS86+A9ZQT8m/5OzH/NNIQtmn0ukLB7uKFZuP47u6ciVkst+C/EdlvQG13Uumgaxo
 cymRbsTDjECBYhWpeGqe2ym9glUrAXJpRRf0o/oKchmh/wo4kRnL0Ou67pcrP1ZAxUfJ
 RgbXXBtENgg+GKmUOgEt8IyjfeXF4K+41F3qrKvUPPb96nVkqceh51CYmpPGM71XY4Ll
 YwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662259; x=1691254259;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xz5uFkMVAHreoQsP7qWUQ7Nk5ICo8gFm0Z5UxHN3DYM=;
 b=DuFdyPaliRE2gURdIgL0/EsmVs6UMVYi5ariErTEJ+O+k65hVTH0IWoTnPYIdBPPBB
 OQhXHhUU+quMUXtOjqXe276zRDq7ZAoHaD4svQYlgfLLEI1JnV83AS2Jg3umWHga4bg2
 6f49sbWw9CWcMGs2pFkpM47D4pnB9j9L4069zFtudu45pPIy0fKc8vwptOLasH1ECz7p
 WOdAk8Rh3H2u+vUSxCrWwj8Ouu+++Cljx7pbj3/dqIm2MjEWz0TFDoksT2cDD592ETcZ
 PxmQKdxEqcMAAE6uIMFuyOlYAHosMRgiOXn54MW/pEsZ6hZoYGllpq4XweIMjxIxwU59
 82vQ==
X-Gm-Message-State: ABy/qLY9p1A+s49IHlOXzHTiR7SxDI68ietxXVa7ZvOjCchzUDT+/gNg
 op9NoQboFKKDUUvl3PuT0E0EVw==
X-Google-Smtp-Source: APBJJlEyKBONGcfBZCJkmY/HjvyD+4VKSj03dsa8ID25/OjNEyj2GhWyljDqwggWygT5U6czyEYEEA==
X-Received: by 2002:a17:906:20e:b0:992:8a4a:6811 with SMTP id
 14-20020a170906020e00b009928a4a6811mr2313658ejd.15.1688662259675; 
 Thu, 06 Jul 2023 09:50:59 -0700 (PDT)
Received: from [192.168.1.102] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a17090607ca00b00989257be620sm1017322ejc.200.2023.07.06.09.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 09:50:59 -0700 (PDT)
Message-ID: <c03209e3-c0e3-3fb0-c627-478bd820fc89@linaro.org>
Date: Thu, 6 Jul 2023 18:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] hw/arm/virt-acpi-build.c: Add missing header
Content-Language: en-US
To: Peng Liang <tcx4c70@gmail.com>, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, shannon.zhaosl@gmail.com, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230706150839.1180137-1-tcx4c70@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230706150839.1180137-1-tcx4c70@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/7/23 17:08, Peng Liang wrote:
> virt-acpi-build.c uses warn_report. However, it doesn't include
> qemu/error-report.h directly, it include qemu/error-report.h via trace.h
> if we enable log trace backend. But if we disable the log trace backend
> (e.g., --enable-trace-backends=nop), then virt-acpi-build.c will not
> include qemu/error-report.h any more and it will lead to build errors.
> Include qemu/error-report.h directly in virt-acpi-build.c to avoid the
> errors.
> 

Fixes: 451b157041 ("acpi: Align the size to 128k")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Peng Liang <tcx4c70@gmail.com>
> ---
>   hw/arm/virt-acpi-build.c | 1 +
>   1 file changed, 1 insertion(+)


