Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2530174D07C
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 10:44:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qImUq-0005H0-A5; Mon, 10 Jul 2023 04:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qImUn-0005GN-M3
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:43:49 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qImUm-0003dJ-3a
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:43:49 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51e429e1eabso3492495a12.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 01:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688978625; x=1691570625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wbQAAyH7d5YOOK3TqUhKtRR7KiuYnWLrk5NmmPz9EdU=;
 b=jjl8tK5pqpbneAi/dcdY4LV3rZUu4P4xcGyGYLfyI2tLtg0Vnrj1ZF5+fiRRrAskP0
 q1rg6iZczNMT1Ab2uz8AgN9M/4dB9slSYXcOh4gLLAPSYq1bMba8Yfz3kGMgOYTaiKqv
 HlxZdEsvkkcM2zTFutjyLhUHm/HvJEWAJnbMXSzLBYTZWzeazO2wi0JUD5TDqW3ur0a5
 Fkfjd58/HcGXqnzl6T5ID5cpuHkqDA/xw4M1mkNGgBrPXewYrnE1KywetbUFOSTLqseq
 PfqlU+CVB5nDsrLWLdlhqk8BAJv1P76jLN6Qc66u0gsOtFmXyoUUg5MW6zvapUCO5rfr
 fYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688978625; x=1691570625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wbQAAyH7d5YOOK3TqUhKtRR7KiuYnWLrk5NmmPz9EdU=;
 b=FUZMBlp37ig2muwnA0yuYaPl4Gk1f/C62MIHEmEPksd9l9OkCcEqZMLdCPBcvDaR7+
 bsY0gsdxkmfvmJ6FUCE+H7pWk3X9ShEpCvIZfof38cltS22HYH2h6QY0sZWxbOfj7Fwf
 tRGPZJz28G4TvIckeAdP3fQj6mA63Y4ua+XKg0s5fD8YGhWit2hae9My8sYkd90fWYth
 6vEgOzsf1f/I/j9AD1f8zaNcP05TV0BuKVz4aQZqyfp6713LsRnHvyJCq80ewNIGvGQl
 gtyLJdpy0FzA69Y6Qb+Pz03Jz3xAVk51RnfUpEUK+wr0W+so2GjOdMfNxK6/l2wL9OiM
 URKg==
X-Gm-Message-State: ABy/qLah08XwL/URHu1KeWkWIR1nUzvw2OesmUtrglftk0eXZr/+hzey
 t+7IK7b1Jy7JEitI8iseMIf7VQ==
X-Google-Smtp-Source: APBJJlEiTG2ncgfXvV9gC/Yfkf2U0fOq7S9nIeF5IiFEBg8Xwh77p2ekoe7zW4tRQ4JxCmnjqhaqNQ==
X-Received: by 2002:a17:906:3847:b0:98e:26ae:9b01 with SMTP id
 w7-20020a170906384700b0098e26ae9b01mr9098716ejc.65.1688978624933; 
 Mon, 10 Jul 2023 01:43:44 -0700 (PDT)
Received: from [192.168.1.102] (xbn44-h02-176-184-35-162.dsl.sta.abo.bbox.fr.
 [176.184.35.162]) by smtp.gmail.com with ESMTPSA id
 x15-20020a1709065acf00b00992316f0690sm5803942ejs.74.2023.07.10.01.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 01:43:44 -0700 (PDT)
Message-ID: <a47afd4f-c23f-67ad-9208-3a49fb1d6502@linaro.org>
Date: Mon, 10 Jul 2023 10:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 03/45] linux-user: Use abi_uint not uint32_t in
 syscall_defs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230709182934.309468-1-richard.henderson@linaro.org>
 <20230709182934.309468-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230709182934.309468-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 9/7/23 20:28, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall_defs.h | 108 +++++++++++++++++++-------------------
>   1 file changed, 54 insertions(+), 54 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


