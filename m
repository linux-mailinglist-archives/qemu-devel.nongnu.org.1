Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8D176D9A5
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:34:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRJUK-0005YG-Se; Wed, 02 Aug 2023 17:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRJU4-0005Qw-IJ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:34:20 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRJU2-0006CD-U4
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:34:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc1218262so3260135e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691012057; x=1691616857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=decvR65ziSo+OGNTH4UzjJMI/kry72eEPwfviYY82P4=;
 b=YPk3uVQSBcySmPEZ1Pa4cBzudN3jtCxVDCZpbHvbs6czaHINnmK7axthc/DeYObeh3
 f0JcwloTokmIP2m3N+iok0fcJsXgWAQnhd9CCFhbJyW5IeaDSHpSOCtNtnzvBCwg1h0J
 rdqHbMzcOtZtAp3Nyi5ZNFMO5gEgaMu7tkZ3KSoTXavj4Kl9waPWfItGRk8FHnniLP4v
 noysx8iVblrZLky1DZQACeP3VjWrcymiYA79s6sZzZ/QyNQvki1oW53iOqGoH7DjD0Ue
 WqF6CInQP56M04C4MKy33O3YBzlBgxG4KMrb2gBr9SDKOQ/mguWYz0C/KOrYFemF0ug0
 YaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691012057; x=1691616857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=decvR65ziSo+OGNTH4UzjJMI/kry72eEPwfviYY82P4=;
 b=V/2V3rAvGWPEng7lH0Ni578IcXnks9A3DUh5M1EakFgyzHizpQVzIn7UfQSdCIhXG3
 Y2ByG/++W6f1RJV/mKYSoRGtH+AE34GPBj97h1DYQwhVRJ+qMleDxQEGhq23qAYUK70a
 bnGEWZnz56xbscp85nOi2M9ZuxnZjfdrrUXBbnT8II/zvNvgow1lQ2uXJwbc3i5L/B5D
 37jx/AzwykGvDoqfXCMdpkBFnaMB1QTN9trJ6vOBNhZgGCjm70L1YHNoKDF/uwAeNZ+3
 Rn9aTM9zML0VY8RziAALFUyNhq1VW4Rwih4qKjGGZ3b6PJQx1lH7PltQ5aJgsuw62Tb3
 weWA==
X-Gm-Message-State: ABy/qLYVsvuCkh3yeGaskWETOmY2UbZC50d+WPvfTLe5tRMUvsm7LmXW
 /nhMb4qvB3y4qHdKCZjGK0WBgw==
X-Google-Smtp-Source: APBJJlFSsLpx1fftVE9xPqUNFSZcm+wX2nmIwFXvTkqLjSXYevvnEVnWLhk5fIujisyjcehkmDvXrQ==
X-Received: by 2002:a05:600c:b54:b0:3fc:9f:e75c with SMTP id
 k20-20020a05600c0b5400b003fc009fe75cmr6048623wmr.11.1691012057311; 
 Wed, 02 Aug 2023 14:34:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.229])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a5d46c6000000b00317a29af4b2sm10703865wrs.68.2023.08.02.14.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 14:34:16 -0700 (PDT)
Message-ID: <3d793690-f3e1-fe65-c0ce-00dd233b9a68@linaro.org>
Date: Wed, 2 Aug 2023 23:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/5] Add i.MX7 missing TZ devices and memory regions
Content-Language: en-US
To: Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
References: <cover.1691010283.git.jcd@tribudubois.net>
 <5ee0e4c1fde379d1865e45ba38a3ff7fbb4741f4.1691010283.git.jcd@tribudubois.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <5ee0e4c1fde379d1865e45ba38a3ff7fbb4741f4.1691010283.git.jcd@tribudubois.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 2/8/23 23:08, Jean-Christophe Dubois wrote:
> * Add TZASC as unimplemented device.
>    - Allow bare metal application to access this (unimplemented) device
> * Add CSU as unimplemented device.
>    - Allow bare metal application to access this (unimplemented) device
> * Add various memory segments
>    - OCRAM
>    - OCRAM EPDC
>    - OCRAM PXP
>    - OCRAM S
>    - ROM
>    - CAAM
> 
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>   hw/arm/fsl-imx7.c         | 63 +++++++++++++++++++++++++++++++++++++++
>   include/hw/arm/fsl-imx7.h |  7 +++++
>   2 files changed, 70 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


