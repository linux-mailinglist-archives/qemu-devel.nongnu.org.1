Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1527791A5
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 16:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUSvc-0002rH-6r; Fri, 11 Aug 2023 10:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qUSva-0002qz-Qr
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:15:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qUSvZ-0000mw-06
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:15:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e8c4so18217345e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691763343; x=1692368143;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tDIgT/twgiO8D6JJTgdM4fHS5xWGX+S3UD7LUUkUxq4=;
 b=FhZVB78hC95y9Xvd5dY/e1OqMd0MuNcdhSETuaPBgguyFTcnm6lH3a4PuCg0+oFKr/
 ZCBS4/GZGihzc6unbYoX9ET10LaMmf+emUxtty3Inh9f9pg8zn5+lD4d1rtbl+DFQhfi
 4brmPUEWzn/POuW6LbywfEydL7QrbiJZNSOgaYFmR/JogDHJDqI05vyyRLpFrH95hsRt
 68kTZuS8mGhS+olHTDUhqFIunaORoI/VaucJ7C9lV44OXXZ3qJPJw252UIWrBNb3gq26
 ZsbS5nzO5uPLS0+aJpGpNGDjZ4QzV7CxMGYOdr+ERohx86o0/qZP/X4XZt6Zs2O8I5zO
 IXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691763343; x=1692368143;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tDIgT/twgiO8D6JJTgdM4fHS5xWGX+S3UD7LUUkUxq4=;
 b=d9scGko8l9TrnGoBPDZpO5Eq4WyI5uv/nTKtwG/v++pC310dOaLSmBOdRfmutkDs/+
 WiRxTZbHO01CD5cO49Gzc93wn2JvbJh+OIP2MHyJB1iZWyB26p4krKrn9PbESVWC9DE6
 vxM2cpSX0Y+bOTEbaUrzX85IHXv50QrrgK69AyoY3nXx6kMlQvGAFgKIZZfZAddGtf70
 rft+2voBvyujI+OFfCN65uY3Y4ZAcOvlkAtVfDCnb+8w36yVLqZs4XJkFRvB6XMOQOQ8
 SgA2PCvxGVReiMShzN59M5to4OUxSy/RY56HneVwbHT9Dd4dG3m2pYEhh5Jx7dac2y0T
 d8xg==
X-Gm-Message-State: AOJu0YynjDJdumZ6TUNaS75YiGweAAar+2rLQnARYBGSXteKgsURV9Qw
 hGx6/TCg/hbWzWe+aTgfTDeUQV2XDt1XmTXmBsM=
X-Google-Smtp-Source: AGHT+IG509djyuTXbXnl+ns8CCB6PM+nrUyqQaMMsrXi4R03dvyq9D+QpkBJarY4V0/KKxrS16EUQA==
X-Received: by 2002:a05:600c:2207:b0:3fe:6199:939f with SMTP id
 z7-20020a05600c220700b003fe6199939fmr1747926wml.33.1691763343158; 
 Fri, 11 Aug 2023 07:15:43 -0700 (PDT)
Received: from [192.168.69.115] (tre93-h02-176-184-7-255.dsl.sta.abo.bbox.fr.
 [176.184.7.255]) by smtp.gmail.com with ESMTPSA id
 17-20020a05600c021100b003fe1c332810sm8341551wmi.33.2023.08.11.07.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 07:15:42 -0700 (PDT)
Message-ID: <70792c75-1a77-eb21-98b3-032aebb773e3@linaro.org>
Date: Fri, 11 Aug 2023 16:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2] linux-user/riscv: Use abi type for target_ucontext
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Alistair.Francis@wdc.com,
 palmer@dabbelt.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, qemu-riscv@nongnu.org
References: <20230811055438.1945-1-zhiwei_liu@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230811055438.1945-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 11/8/23 07:54, LIU Zhiwei wrote:
> We should not use types dependend on host arch for target_ucontext.
> This bug is found when run rv32 applications.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
> v2:
> - Use abi_ptr instead of abi_ulong for uc_link. (Suggest by Philippe Mathieu-Daudé)
> ---
>   linux-user/riscv/signal.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



