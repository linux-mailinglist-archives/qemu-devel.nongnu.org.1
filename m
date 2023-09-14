Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 765AF79FB83
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:03:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfRC-0000Ly-Cg; Thu, 14 Sep 2023 02:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfR6-0000Cw-W8
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:02:47 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfR2-00055f-UO
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:02:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-401b393ddd2so6292405e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 23:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694671359; x=1695276159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YX6vGeqyVem/HzcqhZ4oNSM+sednCUTkpVTReyBQTJU=;
 b=aEJeeXUaI2vG0CP9qLsnSc7WiQhsBFxrIrNRd/z3IxsSE1kJ+Iu1JGq7O1AEKrRW8m
 kC50Y/CQW8fIQX8tKuFttmXa9oVtWm6/PmScaCkfiAfzctb0ixpzPYiHk/7ECejLmz9V
 3JSm2zF4bRS6tsSv4p/5fI5EQ+BIMyaOj/S7nq06UkBSwceOGD2/oSVyXhPv8HkFxNUB
 0C6MSXkD7bai0m4Zz/BqwKG5lmVCYWJm8UVrvhcSD2qlNsgKJxgYDtvrwFU2t4xEl17F
 khz+rQp31OrpnrAGhYHhr3QZyVvM6TB7a6l6OB7HGpB3k0KrB7Om1QNQiDi6WoX9/Uyr
 Vi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694671359; x=1695276159;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YX6vGeqyVem/HzcqhZ4oNSM+sednCUTkpVTReyBQTJU=;
 b=tmPUh1aCMBRD7qG69ScIuCIdwB72BR98aFAD961lKWGvwaoB4QBul+2mA+WPZSe5F2
 5PCx4zYZaaEQYCyUWutldX3JVDLnJOQtCQdg7BnS3CqQbZTEBtw9oaYuFmwAnjHvsj+r
 VPm3KnIcbHLs+28DGMEEFcjTPCa2Dz+qZgl4yGPRgvvbiMXcPPcu+/IAyt2mA3I1vlpv
 87EDgByhspO/CbbDUf4Dw0mB2DYX97VODvin3Wgg7tYplO8qScGYy26cl7hNUh+ude2t
 RUvAUV5JU7IrYdAURkwmPfGBpT3/NMgWYt0yx3GsxJ8BuGPAmKFZT1XvxFrsXea3ksSo
 Gamg==
X-Gm-Message-State: AOJu0Yw8MfZAk+buYXKcEzVFU8sxuBGfrmQ1kHA5I+9j0idncxfB5+wU
 C5N5ubi6u6A8IwlJr+bf50s0Kd/2hIZGHdMZf5A=
X-Google-Smtp-Source: AGHT+IEOZN+9Zt6alVo1c1DLyRIVPet8EIqbUmVCS5bNxETBNlPLV/xEE6q7HNQmudSLBFWI2nEsjA==
X-Received: by 2002:adf:de8a:0:b0:319:7c0f:d920 with SMTP id
 w10-20020adfde8a000000b003197c0fd920mr4137594wrl.57.1694671359375; 
 Wed, 13 Sep 2023 23:02:39 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 d6-20020adfef86000000b0031f82743e25sm756609wro.67.2023.09.13.23.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 23:02:38 -0700 (PDT)
Message-ID: <5c52d7d7-cd04-2f3b-8f95-cfc538c9faf0@linaro.org>
Date: Thu, 14 Sep 2023 08:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 05/24] target/arm: Remove size and alignment for cpu
 subclasses
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914024435.1381329-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
> Inherit the size and alignment from TYPE_ARM_CPU.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.c   | 3 ---
>   target/arm/cpu64.c | 4 ----
>   2 files changed, 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


