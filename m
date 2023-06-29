Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79577742541
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 14:04:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEqNr-0003j0-GJ; Thu, 29 Jun 2023 08:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEqNV-0003OA-3v
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:04:01 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEqNS-0005Tg-E2
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:04:00 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3112f5ab0b1so575348f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 05:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688040236; x=1690632236;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=484IBCDD6g031cWsQu9FYt5VZMx54R+H9rvVVBcgOy8=;
 b=xzz4AsC7udrRnE0Iwh1jG1g5et+oDlIcMjVTRrtt4b3HLmsRwTn+2BaXP+OQe80uXH
 yNX0tEdJamlQ/qTiVQDbaxO9rZxmdV2+oW5wwr46m5LftWWkH5+B+KWnqkWGmruJdKGy
 vg75lhvGf5jOCDCyTLTmBayMR8ARPwbSf5Ng1y+856kv5RtOaUxrZroPmjU44SlZsI+2
 1obhLubV1fHrGnZDpnYMru6htBev1CARKpYoaxblzNRoGR92jKqDMrahhtokDdQISTAG
 LPG/Q5WWldrfS/rJqu8qDV5oNwDHMQiXWoionJgKWlpTxDSxPy2qyk2wYNaMpUyHTNSL
 cnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688040236; x=1690632236;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=484IBCDD6g031cWsQu9FYt5VZMx54R+H9rvVVBcgOy8=;
 b=FNm9s48UYUrBzJ6mDKHi4qPoURmZo1KA+gM1EuAcfisXENayDxPrmDHf+iAh/ZUtO9
 SAw69VxeU/bt/jnY6v3Z3evuZvwxSpUDvW0WzOv6gxY1ZwBHf0LWWPCUTOtC4pMMdiIY
 rukN32szPEfrE7DjsLNjMiDYaIaRQCaLzSR97hCoffV/xwAz7W3+2LYVUkqYBNuAA36f
 tSFUgU3o72u+xev4+vj0bLAN18E1lgU4odA3wmL1vkfwQFooEGbzVPBAi2Bg4/MgcMNI
 XTaeT/Ooq9dNbk2WDmumpYdUL6ofVnqXgV2mDKUpEzTikUgfrUUVZJ5xphLOJQ7x67+K
 +Rbg==
X-Gm-Message-State: AC+VfDw9LEHRgozdxknVqIfXkzF3unVYXue2nfOL/rS+nWjGNDKhcSR6
 68pIMqSwwBibsHkZvtm3FpweZhUR8WE272O1BMQ=
X-Google-Smtp-Source: ACHHUZ7tRmkRWcxsXTQWm66X3IzHgK3UlTFqfJd1HOEM/33ogOePkrMtMDVwjYxJhJOW1aaUPhzYEw==
X-Received: by 2002:a5d:63ce:0:b0:313:e404:688b with SMTP id
 c14-20020a5d63ce000000b00313e404688bmr10212177wrw.42.1688040236607; 
 Thu, 29 Jun 2023 05:03:56 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a5d5705000000b00313f9a0c521sm8143123wrv.107.2023.06.29.05.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 05:03:56 -0700 (PDT)
Message-ID: <6fdb63c3-25b1-eb2c-2bd6-7e01b40e8e2b@linaro.org>
Date: Thu, 29 Jun 2023 14:03:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] accel/tcg: Replace qemu_tcg_mttcg_enabled() by
 mttcg_enabled
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-riscv@nongnu.org,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>, Eduardo Habkost <eduardo@habkost.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230629120255.85581-1-philmd@linaro.org>
 <20230629120255.85581-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230629120255.85581-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 29/6/23 14:02, Philippe Mathieu-Daudé wrote:
> Move 'mttcg_enabled' declaration to "tcg-accel-ops-mttcg.h"
> which is a TCG-internal header; un-inline and remove the
> qemu_tcg_mttcg_enabled() definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-mttcg.h | 8 ++++++++
>   include/hw/core/cpu.h           | 9 ---------
>   accel/tcg/tcg-accel-ops.c       | 2 +-
>   tcg/region.c                    | 3 ++-
>   4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/tcg-accel-ops-mttcg.h
> index 8ffa7a9a9f..1ffe8f3ac2 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.h
> +++ b/accel/tcg/tcg-accel-ops-mttcg.h
> @@ -10,6 +10,14 @@
>   #ifndef TCG_ACCEL_OPS_MTTCG_H
>   #define TCG_ACCEL_OPS_MTTCG_H
>   
> +/**
> + * qemu_tcg_mttcg_enabled:
> + * Check whether we are running MultiThread TCG or not.
> + *
> + * Returns: %true if we are in MTTCG mode %false otherwise.
> + */

Bah, outdated comment... To be removed.

> +extern bool mttcg_enabled;
> +
>   /* kick MTTCG vCPU thread */
>   void mttcg_kick_vcpu_thread(CPUState *cpu);
>   
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index b08f8b7079..5d26e6c90c 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -456,15 +456,6 @@ extern CPUTailQ cpus;
>   
>   extern __thread CPUState *current_cpu;
>   
> -/**
> - * qemu_tcg_mttcg_enabled:
> - * Check whether we are running MultiThread TCG or not.
> - *
> - * Returns: %true if we are in MTTCG mode %false otherwise.
> - */
> -extern bool mttcg_enabled;
> -#define qemu_tcg_mttcg_enabled() (mttcg_enabled)


