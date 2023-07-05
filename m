Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 833D67482C4
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 13:14:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH0Qu-0001NS-9J; Wed, 05 Jul 2023 07:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH0Qq-0001MU-Si
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:12:25 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH0Qo-0003e4-P0
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:12:24 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51d9695ec29so6442512a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688555540; x=1691147540;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FFnVTM41erRPYYtdM2ahHezzF5fD4xoP8cpatY4VCMs=;
 b=gsjMXvh68CiNy7wwIEUKDpuNvmejeRNelp+YpBCOaYg3aVRtpntxKhP+iJSpQg2sZr
 jXhp3v6pZqHO0T9wpBctfTM5+rsP41z/KBQq53DRSHKd3e0/BA6J0zcwHmpZTc1cloGB
 yJZRuELRWZSA0OEcpeIZnpIiQuq3iXAwPdvGLLO825TA5nBitZZOVO5kABHn4EPyMmzn
 sw/JQT1RPTCjeWAYCeuhw0UAQUCuii4vvbbDO/+9qXRV4RF588haET7LBOydo5U/H5K1
 P7Vf69ANvLdXpwcOc3GYdPpFlINr2drxDFTK8RyktYQsCdX+AJvC6P1CX8jRTh/iwlJG
 1RvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688555540; x=1691147540;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FFnVTM41erRPYYtdM2ahHezzF5fD4xoP8cpatY4VCMs=;
 b=IAqnbMiDBpQGwprK+05G4vmwAzRvTZxCuKXa7FonE7cVFAzz91RprxtE1OQJqhnVEZ
 spYy8/i6eWo8a7DyLw5adpKwM8JRZ32aEDFayqyHUgQMn6ktNuvLiLqU7ssHdPBh5lf4
 TdWWZsB7FPWHDdGSaefzWnHrAAnNd/pSVc71oMRiu+3HWMvAEJgbergnjvV6BWMBpWgb
 R4TLIfm9ITrjeIIxmtsOyNC9EX9bymQQvUUlIj44ByKGMDsmh7VjaJlSMnzS6vQ/7PzX
 YQFC8qH0TaQiMpkt/SND5ccYsf8iV6+ZZvIrlNy7IJUpxazgu8ijdtas8c8zuSUdMqmr
 sNOQ==
X-Gm-Message-State: ABy/qLYCydxN/iJE23Y0830ABMOXeQL+dLpN40VBCEqeuuxLb8hzP28b
 HA8V5NeISSB5AGnAW38bDNrpfi22YmW+LblyAc8=
X-Google-Smtp-Source: APBJJlFu0sCTeBX1r93xLOvbwZBNoTU/35BRUfes1p0pXA650zOzqyEmnD9zn2AnMgiw8LFziP8kgw==
X-Received: by 2002:a05:6402:184e:b0:51b:e4c7:410f with SMTP id
 v14-20020a056402184e00b0051be4c7410fmr8197188edy.6.1688555540206; 
 Wed, 05 Jul 2023 04:12:20 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.96])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a05640204cf00b0050bc4600d38sm12964463edw.79.2023.07.05.04.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 04:12:19 -0700 (PDT)
Message-ID: <060f5a94-30ab-b708-5086-09332531fd81@linaro.org>
Date: Wed, 5 Jul 2023 13:12:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/xive: Print CPU target in all TIMA traces
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230705110039.231148-1-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230705110039.231148-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/7/23 13:00, Frederic Barrat wrote:
> Add the CPU target in the trace when reading/writing the TIMA
> space. It was already done for other TIMA ops (notify, accept, ...),
> only missing for those 2. Useful for debug and even more now that we
> experiment with SMT.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
>   hw/intc/trace-events | 4 ++--
>   hw/intc/xive.c       | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 5c6094c457..36ff71f947 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -265,8 +265,8 @@ xive_source_esb_read(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64
>   xive_source_esb_write(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
>   xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "END 0x%02x/0x%04x -> enqueue 0x%08x"
>   xive_router_end_escalate(uint8_t end_blk, uint32_t end_idx, uint8_t esc_blk, uint32_t esc_idx, uint32_t end_data) "END 0x%02x/0x%04x -> escalate END 0x%02x/0x%04x data 0x%08x"
> -xive_tctx_tm_write(uint64_t offset, unsigned int size, uint64_t value) "@0x%"PRIx64" sz=%d val=0x%" PRIx64
> -xive_tctx_tm_read(uint64_t offset, unsigned int size, uint64_t value) "@0x%"PRIx64" sz=%d val=0x%" PRIx64
> +xive_tctx_tm_write(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
> +xive_tctx_tm_read(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64

"target" is kinda confusing, what about:

xive_tctx_tm_read(uint32_t cpu_index, ...) "cpu=%d @0x%"PRIx64" ...

?

