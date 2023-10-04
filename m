Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9DC7B7811
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 08:42:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnvaY-0007Yg-2r; Wed, 04 Oct 2023 02:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvaT-0007YX-5H
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:42:25 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvaR-0007UV-IW
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:42:24 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3232be274a0so290666f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 23:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696401740; x=1697006540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bmj7QAm5twh3ixXwl3LjIIDQSTL75GLxado4Md5LaoM=;
 b=D/WUCZzRJ4/ZCcEvtEWa+GG4JKS/YkKtrEWAQvxb4ZmA6gnwN+ZCC+yoVHybNNRdYG
 UNUAhVOj31mrfxPYpk6OlkHhGgh6kTeOVgvfKoVxnOoKRQwTWnWW/9Un3UcrZMf7CZxk
 Sc3xjBGLHVyXE3LcokBM9nChmn3h9BJDpJbZtMmIGXj6t0ru8bAuQWcPO85Zg1EGKapF
 CxAcE96E/9+laKwCU54cjYGvfTJp3jVCOfBxeqXcQyaGD1wbKGQUV8tXG5xpjvrIagXv
 9m/k8JE3nHd3snHmU7JBJLznUp97p8RtdW5R/6JtgxVYb+/0tmac/CoC2lId4K8ldVr/
 dTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696401740; x=1697006540;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bmj7QAm5twh3ixXwl3LjIIDQSTL75GLxado4Md5LaoM=;
 b=o2LVGBryWPW98uQ5OEdnSRDNSd+EBn58Ahbr96MUX8thzT4rNmfVXkFEATphrnJoL3
 1hrEzct+4T5r+txM3I7crrU4ysL8fgUtsuI2aLcX3UP41Mj1BGOTzeg9n1s9poTOJGuo
 qeszUPivm+18Ip15sYb3VYALOjzMk3A01aLSh134KXbQpLnCBDnU+Hn2fjvaj4Wvh5dx
 9cAHtXITODEh8pVxMYHqxSKI32y1Uj/CA+yB/cZzLW6qOpmxkuwe896CVVT+hnzgJIqZ
 HMEVEx2ML4G1V/ItxoY95r9wppCPVpvrj5Z1l30BD2VHCb2WtPcP45yropqHyM4lPKHs
 nuzg==
X-Gm-Message-State: AOJu0Yx2cL7jz39MU/FofkwQ9lAQTprpDZr8br0R3N58DtPuf4XNBgf0
 MMuHi0yXs27o7oCphDt51pvgng==
X-Google-Smtp-Source: AGHT+IHNye751+EfKfFaCJBBgWJGWj/FZRL5SyV1l+yED5DwPM5gPqfIfYXMXO7UrOlXxOG6++y8XQ==
X-Received: by 2002:adf:e607:0:b0:31f:eb45:462e with SMTP id
 p7-20020adfe607000000b0031feb45462emr912731wrm.28.1696401740056; 
 Tue, 03 Oct 2023 23:42:20 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 k2-20020a5d6d42000000b003232d122dbfsm3205819wri.66.2023.10.03.23.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 23:42:19 -0700 (PDT)
Message-ID: <90a876ec-3fec-c9a2-0c70-be484b7b3282@linaro.org>
Date: Wed, 4 Oct 2023 08:42:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 09/10] tcg/riscv: Use tcg_use_softmmu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
 <20231003174356.1602279-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003174356.1602279-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 3/10/23 19:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/riscv/tcg-target.c.inc | 189 +++++++++++++++++++------------------
>   1 file changed, 97 insertions(+), 92 deletions(-)


> @@ -2075,10 +2080,10 @@ static void tcg_target_qemu_prologue(TCGContext *s)
>                      TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
>       }
>   
> -#if !defined(CONFIG_SOFTMMU)
> -    tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
> -    tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
> -#endif
> +    if (!tcg_use_softmmu && guest_base) {

Do you mind mentioning the 'guest_base' change here?

> +        tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
> +        tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
> +    }
>   
>       /* Call generated code */
>       tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);


