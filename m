Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 883BC752C5B
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:44:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK45h-00014w-VJ; Thu, 13 Jul 2023 17:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qK45f-00012l-A4
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:43:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qK45d-0002Tc-O2
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:43:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fc04692e20so11460945e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689284587; x=1691876587;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9qiNNwaV/EnLo8Upe+9gL+l0UijaM3nENXHlNwbCqM4=;
 b=iXl7NrgZlAH8bFNBCAe3Fzf7398rcQ+ILc8SINYY7DwPqYO3xHFuLFgW63pKKStvFP
 j7T6sVY0bbsQf6QyqWX7U7yEluMbb2tSTFDqM7cHizU6ad07XUrwTmTwlUMeDHvKNQPU
 B/uMWgqXbXka5AuoNL1AXCzxcJmj4wT2MM5nejYB1GPIpFqaaJ30vk93ERdjhVlhNb6w
 yg4tzYX7rainh97zJH5wcQUeRpzpfyt/1EFL2T2IP9X374C+qIXJIWs7tqpG9dc876Us
 B/6+O+nCOrxeWdphYIYlycixpqZant62FE83XXgZ63fkMtOFrG6w5ZofQjcJPWj5mpoP
 l25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689284587; x=1691876587;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9qiNNwaV/EnLo8Upe+9gL+l0UijaM3nENXHlNwbCqM4=;
 b=Y0vnhJuJ4yh+ZB4d905iDl+I+zEAyqjKyWyh+/IsZdui6WFpwgvY95CIuKcUXxbqyJ
 xmYwkusPoFWwUFtKm4CFU0HbznpIatda3VSNuzoV+CCytSC7TdgbjcicBxnF3w8mYKpQ
 24jXVtHt7pbZ72+yVgHzI/lqQBHwaZP51GZZVLHhcR0BhsTWvYUmK1pMWWCWEeVp7wak
 /Wx9eAECrjXxymPpjwMgEl4OYNRqX5Pg9+8Cxf2wCRhuH52rQiRnfKMAbx8FQ8TIdASj
 aRVMaRpAr47QHp9pqVXgJQFovVwMi0qDg51U39kXz1Z8vPKpRB20g55s95Q7oqx0jKp2
 Xj1w==
X-Gm-Message-State: ABy/qLaSY5gh00GSYuGnxip9dVIynZ5008bQ/w3AVyyfPME6CA1sbDBt
 qq79ISC6IqHdHK0hSU9fK5+JxSZQBYBtOy+2zw8=
X-Google-Smtp-Source: APBJJlEL0wlk9IkxTLdlDhGF1wVuoWClv3w9MN6kIivUH0i892P73j26S6Cx0sVhk/Vkh+4WHj/+nQ==
X-Received: by 2002:a05:600c:2141:b0:3f7:4961:52ad with SMTP id
 v1-20020a05600c214100b003f7496152admr2508719wml.3.1689284587445; 
 Thu, 13 Jul 2023 14:43:07 -0700 (PDT)
Received: from [192.168.7.115] (m-109-111-99-24.andorpac.ad. [109.111.99.24])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a05600c2a4a00b003fbacc853ccsm27377wme.18.2023.07.13.14.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 14:43:06 -0700 (PDT)
Message-ID: <463c9e0c-235d-50b4-1a64-65fd7d4d4800@linaro.org>
Date: Thu, 13 Jul 2023 23:43:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 02/18] target/arm: Use clmul_8* routines
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
References: <20230713211435.13505-1-richard.henderson@linaro.org>
 <20230713211435.13505-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230713211435.13505-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 13/7/23 23:14, Richard Henderson wrote:
> Use generic routines for 8-bit carry-less multiply.
> Remove our local version of pmull_h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/vec_internal.h |  5 ---
>   target/arm/tcg/mve_helper.c   |  8 ++---
>   target/arm/tcg/vec_helper.c   | 63 +++++++----------------------------
>   3 files changed, 15 insertions(+), 61 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


