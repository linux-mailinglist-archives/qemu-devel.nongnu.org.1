Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CF27A5E7B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:45:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXIf-0005gw-P9; Tue, 19 Sep 2023 05:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiXIK-0005TL-Ul
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:45:29 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiXII-0007jz-JX
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:45:24 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9a21b6d105cso684436966b.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 02:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695116720; x=1695721520; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bYEPH9H522raezzc3AZZVPfHqXxjixe1n2JjIc16jdo=;
 b=DJz3cIGij4dSRg2G01/izA0xKxuc+RTygFlwtx33UFgixnn/TLB/Lw1Mvy+3zVVAwi
 QW0ebHLMC0DITDexL0A/HG3PkkAF40UhM+KGcVacbrhY32akRffLlnCfvFMVjisRoMa1
 E0rQFUR4gySaKcN3TVd2XNXScbnlgw8XBmDA3UiwSp5VOhgBPoPbFTYAVe/XedcygKSR
 MGBUL+ggV8eajHIkcfFFb8tZlYuVGe/xn+F+luuwF5BTl2Vdp+i+hE0aNv0GShmbfUtx
 qnqu+n2wFJ0gYeyD/LadNWugW+8ZEK7H0auoZHmdIWPF0II4aoDCjZZe2tUqba6DKTuy
 D6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695116720; x=1695721520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bYEPH9H522raezzc3AZZVPfHqXxjixe1n2JjIc16jdo=;
 b=dabWqKptbJCkPuY8GtwDgeSsRxPQdVXLbZMGr/YeRPQO3T1CGz/MPxU3Q6qMs+bkj9
 V8Gie/rDA/6dBII+g+SkG0U0vwvHgRh+D/sWcZTanQrxm5kPKfQj5Px5JaQ6welrszWe
 0DCAUblMqx3RSLfWcqivW/j/NPuUeFgJ9BJ0KIF1ttqENM675dklDS+hqyo4aFRD5szi
 qNpPqEY9Rw2pCdNQVhhQo2kGoNS7reQEOxvbr/Mk3k/+zLRN5WP1UaD/Y27Q3OmTnuD2
 ksRUVv2Jc1I5LJafCnpLFqDFPeABbNdjCH/9juM5mSZwR5kbKJ3c5MmFmEuUmcxnDmyq
 sJLA==
X-Gm-Message-State: AOJu0Ywah3IvnbDfW/T+hzCql6xF6E71z4xt3BKbPcptvQPgF7PYS8zV
 fvMGZ5AcUIFTKZ/mQY4sRcZXnw==
X-Google-Smtp-Source: AGHT+IFxYmvtST17YOIwX0h2FEIAlWNZNWrK82yfj8JlQuv+BhVLoeGISj1I7hHAjdEntQN2AYLk8g==
X-Received: by 2002:a17:906:8a6b:b0:9ae:3a68:93e8 with SMTP id
 hy11-20020a1709068a6b00b009ae3a6893e8mr311736ejc.14.1695116719877; 
 Tue, 19 Sep 2023 02:45:19 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 kg28-20020a17090776fc00b00992d122af63sm7532845ejc.89.2023.09.19.02.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 02:45:19 -0700 (PDT)
Message-ID: <ae9aea50-5ed7-9a59-2183-435d5a5ba31d@linaro.org>
Date: Tue, 19 Sep 2023 11:45:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 21/39] accel/tcg: Remove env_tlb()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20230916214123.525796-1-richard.henderson@linaro.org>
 <20230916214123.525796-22-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230916214123.525796-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 16/9/23 23:41, Richard Henderson wrote:
> From: Anton Johansson <anjo@rev.ng>
> 
> The function is no longer used to access the TLB,
> and has been replaced by cpu->neg.tlb.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Message-Id: <20230912153428.17816-9-anjo@rev.ng>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> [rth: Merge comment update patch]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h       | 11 -----------
>   tcg/aarch64/tcg-target.c.inc |  2 +-
>   tcg/arm/tcg-target.c.inc     |  2 +-
>   3 files changed, 2 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


