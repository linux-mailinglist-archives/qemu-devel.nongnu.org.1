Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D77E67409CE
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:47:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPso-0006ic-5V; Wed, 28 Jun 2023 03:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPsl-0006hl-DI
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:46:31 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPsj-0004Y5-I1
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:46:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-313f363a6f1so3101604f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687938388; x=1690530388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l3d0YvTX1szbYee0xp0LPfgUCWFMOQy8vz9b8lPblMI=;
 b=UxUHm6UQoxNee91SN/HXkRLuMeEH1LzT8ZECq/r+MFKNo6Ooon3U0tD+OT0s/ZuCnx
 XIWgw3V6PEz/XLjfthVABkZCBy+WftH4rg8h+dZyjG8Vqktcp/zYIQINIF+V1k9CKp4h
 gOpIN1tZdnv4Gr8MShIH4OWQ55vNVnRIcuvsCy9Q6YC+kVAPDIcEIaLYdbVAi8O6Nsip
 rzjdWsEI7z3s1OUTokeJiZ1zv7SCOzIXadhwfQsM86QmHXhg+tyRHtmUYyW9g+nyqHKN
 OnZ2qQErYlC/yXn60dtAAdR5eOEMuZYhBVTfjFQE/sQ0Q/BhGMTXZQP+mCejEPmJntFE
 BW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687938388; x=1690530388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l3d0YvTX1szbYee0xp0LPfgUCWFMOQy8vz9b8lPblMI=;
 b=b/F8wkVQEBQ9zeYZ3VpDcaRPdp+CSRanek1hWqFLs7AIm+R/a9guPTsHTxLAaGZws0
 c8l3z/zCqoMHZBsmJIxoG2trFR0DYAiIqfyFa+dk6MWk51CQRAEQe/bu6ix6voGTdkA8
 UQ3/+XoEVwS02V/AcVbVqQDoPD+eoc23hU0Ljqnnz6czcVJUrtPxsyOeQ+abhMsq/z+J
 Wo7ypwdfDb8Sa9D0O3SKKxcqxk0RdiALSyH9JBt9q40/Qo3T3FYbDn2BQ1+7i0diZtAU
 kwZHtIHjlzu5fkezM4EmwzQtUr1lZhjFLWYSRTWbgBIGvMKfAIy6lpFSMIqHFTvDE1+I
 QolQ==
X-Gm-Message-State: AC+VfDwuGG+NQH4ynVlEJQydI3f3wkD1qEo9CqznXx/irJyNOs4QIxf9
 mP9rw5kE1gCSpb3NTpD3sgQFXA==
X-Google-Smtp-Source: ACHHUZ7Xl1BuWjCZjg2yRtLw8qVeiKKS12Jw5KH05EsacWHAGMwN/BE9XzFcuku0TNzWvw376tsilg==
X-Received: by 2002:a5d:540f:0:b0:313:f429:f6e9 with SMTP id
 g15-20020a5d540f000000b00313f429f6e9mr5703076wrv.60.1687938387781; 
 Wed, 28 Jun 2023 00:46:27 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a5d5705000000b00313f9a0c521sm4983215wrv.107.2023.06.28.00.46.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 00:46:27 -0700 (PDT)
Message-ID: <3b70cc47-e4d1-c7e9-3031-f5c39074f9e2@linaro.org>
Date: Wed, 28 Jun 2023 09:46:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/ppc: Only generate decodetree files when TCG is
 enabled
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
References: <20230626140100.67941-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230626140100.67941-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/26/23 16:01, Philippe Mathieu-Daudé wrote:
> No need to generate TCG-specific decodetree files
> when TCG is disabled.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/ppc/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

