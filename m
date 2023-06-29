Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 880F67424E0
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 13:16:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpcs-0003uE-5E; Thu, 29 Jun 2023 07:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEpcl-0003tz-Dm
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:15:43 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEpcf-00062H-FD
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:15:43 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f957a45b10so821673e87.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688037335; x=1690629335;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0N3TbupmJNysqlo0FovRJPZVTk+GMvbPpUEhBzyxCJ4=;
 b=KrBqbx5fRxIyOIKYmY4fPPSOThehNQdtdqlYSyMSo+9PIK0LybGvjNDL6AA6UZQE0A
 3GTYrcP+dnQnDGYFp97YDwtROLtuTTfknAu2WrsfOkhmu9E5rt4tYiJ6SXD7VkHu2TMg
 FctRzvPnF1o7Jts4xyIx8UcgxyYa6D4LfKt7rb221WuCDvUQMLwg8E1QJi1twCxYP/xr
 2Uf4anr48UllIwUaTgE8BvJzR5M0fB331aaEMQaKybrCAAZrjWzz918/s4GHz/Z94wRX
 lO+fzJ321S1/Kq0CqZ+MWmTrKWUEnsIMp9EYVj99NCpLGoAMyCWJBR9OJu3I1Q++1LF4
 Ftkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688037335; x=1690629335;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0N3TbupmJNysqlo0FovRJPZVTk+GMvbPpUEhBzyxCJ4=;
 b=aPcsa7BAHMimTTGVpMHHNFhWwB3VHJShhJBeE9qk6ArmshWLUMdcYSAbaQoumttfEa
 s5UqVVgsXPvFOGuH5IJKUHIkzFRCUjRfS6vVq9B9o8LCvqaRCyJA7CQZPrqMtIulotHQ
 HtKT0/8FrlfVOOl6ZA+uBr2KdFUaF3q1md0PpI/8MQEhUY/D8EJ7y9iRZBLYU2P45StF
 WMxQMp7UapG/cbyep1uDcmQioRWxKLjoCpg6b1EDjbrDqc6EWsIGXZuU+TKqUBETd8Da
 ab6xw7uZ+GrjZHVH+LD+WZAKXPbfSHsdgwBwy3DYTj517sqTdYFfQKjTvFV/APF09/Gc
 XHLA==
X-Gm-Message-State: AC+VfDwOeSVmhZCjFmPurSird62W+QPtXHaedJkWuMT2AkBFa33iLuU2
 sAW/bSxKxWCwlLBkLw7W364o5A==
X-Google-Smtp-Source: ACHHUZ7amzjYMm1AfDRq6dCPIVlTp+JiFBm8tImE1nSmMYX0XY/cXQhb1ZTauu92VhaD+Dfespps0w==
X-Received: by 2002:a05:6512:15a7:b0:4f9:6256:2a7e with SMTP id
 bp39-20020a05651215a700b004f962562a7emr17019513lfb.31.1688037335176; 
 Thu, 29 Jun 2023 04:15:35 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a5d4649000000b0031118d80246sm15596305wrs.29.2023.06.29.04.15.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 04:15:34 -0700 (PDT)
Message-ID: <92f7e054-0551-081e-9ad5-6fa845344859@linaro.org>
Date: Thu, 29 Jun 2023 13:15:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/30] Accelerator patches for 2023-06-28
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230628155313.71594-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/28/23 17:52, Philippe Mathieu-Daudé wrote:
> The following changes since commit b111569da9f82fdf05df03184836a4564adef599:
> 
>    Merge tag 'ui-pull-request' ofhttps://gitlab.com/marcandre.lureau/qemu  into staging (2023-06-28 08:42:32 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/accel-20230628
> 
> for you to fetch changes up to 14a868c626e99eea063ecbf6ef86002f6a314f0a:
> 
>    exec/memory: Add symbol for the min value of memory listener priority (2023-06-28 14:27:59 +0200)
> 
> ----------------------------------------------------------------
> Accelerators patches
> 
> - MAINTAINERS: Update Roman Bolshakov email address
> - HAX: Fix a memory leak
> - HAX/NVMM/WHPX/HVF: Rename per-accel state as AccelCPUState
> - KVM: Restrict specific fields from ArchCPU
> - WHPX: Re-enable cross-build gitlab-ci job on case sensitive filesystems
> - WHPX: Fix error message when setting ProcessorCount fails
> - exec/memory: Add definitions for memory listener priorities

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


