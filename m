Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD0781B82F
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 14:41:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGJI7-00047i-ES; Thu, 21 Dec 2023 08:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGJI4-00046h-Ln
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 08:40:44 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGJI3-0006DG-4v
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 08:40:44 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d3e416f303so3609995ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 05:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703166041; x=1703770841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9a7DyTpxGUAyWUJkgH9qfuNqaMpww0BzNmqbO2l/U/o=;
 b=O6tzzuxV8kSlfu5i3mVD3ymnFWyaUOhdGeaJcEnt/1uzGzab7fmUX7QiFalScEN9g1
 okRLUR3oNFopqwCVJZSBmuNKXib3qgA9tivRn8DDaQUpdELDmvxM+NuBTfA7SdEuCDpP
 KA7s7p4Xd4jR3agTEBGh1G+vj3hlsUp3PGlqJtS5RVLrRktlIIdByXXwnYHui/dE5Qjm
 268SMbDnRQoZwTfTo9ZGvBWSueykcsewP491gtqtxvSCTmqpFmcknTV7pjsLqrrqT8h8
 RmaVUa4Ft0dkEdU5dkAnZmQ6ErhprhcUb/soJpR5QBPGngU8YG+RncCNnJ8O4ZJzCK4e
 uSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703166041; x=1703770841;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9a7DyTpxGUAyWUJkgH9qfuNqaMpww0BzNmqbO2l/U/o=;
 b=UALrZVgOxr9z68pig2KbeXSM3MMuSfPinLko7qpQon8ooIvpvaTwAAcZUEB/kHy7dM
 Bf+gnZqf8ndgvQ/Qsct9Q4xxUGN3lsGwi5N/82Tkq0OMjsocGflhPkxDA7/jxTx0l7pW
 9HOid8J57TfvIy2/H7dUl729jEQlZSnJBtvSIbIcNmpIYndztIWUMdaRYF63DxNdDTPL
 57UDtFUvyuXukidTv0KlpUw9UQSk0TncsVxW1dm1LnMhjXjJoBJ3L3Hs6zH/wKHzRker
 mjyqm0yedLuWUNPd0rP3lPZEkMLLUS4OquazINgqDlMsDWhP9P/09wsdm58+7U/Aka5c
 uRww==
X-Gm-Message-State: AOJu0YzD/7w0Bvq86ZKzR2aGGioaur2IA4BsbZR6+VqsySlzhTFjA5tn
 b79jeRoZIJwVk8Ie2NkuI84V2Q==
X-Google-Smtp-Source: AGHT+IG9I3M9jXeHuGD1lRDfRrnRk+hHIElT3fYOu49EZ+pFNHo7GVig79y+ifoTD/iqCwHuuv9rjg==
X-Received: by 2002:a17:903:2443:b0:1d3:f921:a44c with SMTP id
 l3-20020a170903244300b001d3f921a44cmr1588495pls.76.1703166041338; 
 Thu, 21 Dec 2023 05:40:41 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.205])
 by smtp.gmail.com with ESMTPSA id
 jg13-20020a17090326cd00b001d398876f5esm1639827plb.121.2023.12.21.05.40.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 05:40:40 -0800 (PST)
Message-ID: <007b2faf-37f6-4841-a11d-6d0d231a37fd@ventanamicro.com>
Date: Thu, 21 Dec 2023 10:40:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: pmp: Ignore writes when RW=01 and MML=0
Content-Language: en-US
To: Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
References: <20231220153205.11072-1-ivan.klokov@syntacore.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231220153205.11072-1-ivan.klokov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 12/20/23 12:32, Ivan Klokov wrote:
> This patch changes behavior on writing RW=01 to pmpcfg with MML=0.
> RWX filed is form of collective WARL with the combination of
> pmpcfg.RW=01 remains reserved for future standard use.
> 
> According to definition of WARL writing the CSR has no other side
> effect. But current implementation change architectural state and
> change system behavior. After writing we will get unreadable-unwriteble
> region regardless on the previous state.
> 
> On the other side WARL said that we should read legal value and nothing
> says about what we should write. Current behavior change system state
> regardless of whether we read this register or not.
> 
> Fixes: ac66f2f0 ("target/riscv: pmp: Ignore writes when RW=01")
> 
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/pmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 162e88a90a..c0b814699e 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -126,7 +126,7 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
>               /* If !mseccfg.MML then ignore writes with encoding RW=01 */
>               if ((val & PMP_WRITE) && !(val & PMP_READ) &&
>                   !MSECCFG_MML_ISSET(env)) {
> -                val &= ~(PMP_WRITE | PMP_READ);
> +                return false;
>               }
>               env->pmp_state.pmp[pmp_index].cfg_reg = val;
>               pmp_update_rule_addr(env, pmp_index);

