Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E43B7741370
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:11:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVrL-0006AJ-5t; Wed, 28 Jun 2023 10:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEVrI-0006A2-UX
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:09:24 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEVrG-0002p1-1r
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:09:24 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so6642808f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687961360; x=1690553360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uWkoBlCW6apXh86RZXu3ZOrLCzjbQMErzxVckKf3Frs=;
 b=gbvBOspI4xPl86i6vMyrmnYOPNquKH5xiHMtZ49sNW/ROCZyQ8WywE6pixe8co0RfS
 qBmR0B2yXJvtF0ZJqmVrL+7ClpEEmj0JwXD8o9eVYoUexihOGIDLG3gVsDomTmPJ9Ayu
 1008D+xW/tnhcKDTnidMJFNccjWJl8fFbhEPWXDImSnIa/NifOHAxWA8vFvA6ev04reI
 VrbTfz8lsYOpUSpsxIpJftUvitu/dHW54zEjEdwSvq8XFBrIpLCPBJDb/+DP0FZcl/YU
 jCmDQQ37skZAFTcu42aeF5MvnXN2+4vGQVlwtIF2mK5ANsqEvEiY6MdSG5IVSX+BoGoe
 V8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687961360; x=1690553360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uWkoBlCW6apXh86RZXu3ZOrLCzjbQMErzxVckKf3Frs=;
 b=Nxcb+MjKNdNyqxH0iPlo7ZMBE3ZUJ7/TMFJX7lsoCv4/STwf38drMcMJhH2+xNn1hN
 f7IBbKE4W5cd/XxijF6dyKu8P6OCFyBK0blr2ScqItMG/NVZScTHjOkl4byI1b3DKMKy
 a3L1XRzGyiH14oiQuxY5s6lKSkNNeRPLiEql8I6KEuQN6SnMLdniPbRFQr/hqH2PyYq7
 FfVEoX5LKKkSnd+HHJkYvs7ofPrAfkW4PgwRLXT6cqRVR5K2S4Q46Taf9/8F9isBmB+i
 +nyoy3rCsDHGF2fhfh1AsRETWTY8lmTbfz/IgdDBYVWWQLn5DZBIgeudmVN19+KjSNyP
 zGXg==
X-Gm-Message-State: AC+VfDwZvd0ehhe17axll8+iuR80uU0kBLHKSP+IdOYb3OYg1u5pSj38
 TSq6PWFj6G5ZyfMuuS24Ootgjg==
X-Google-Smtp-Source: ACHHUZ5Y5OcrdFaC6VYEmAIRKkaUPunzybMymQNJM0tkksqXZ8pkKVhgO2YEsU3Y8aXpOZEoDBQ9uA==
X-Received: by 2002:a05:6000:1370:b0:311:1a45:3606 with SMTP id
 q16-20020a056000137000b003111a453606mr28082751wrz.30.1687961359839; 
 Wed, 28 Jun 2023 07:09:19 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a5d638c000000b00313f61889e9sm7376348wru.36.2023.06.28.07.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 07:09:19 -0700 (PDT)
Message-ID: <e594441e-d3df-8698-f98e-0f98e5e8fcad@linaro.org>
Date: Wed, 28 Jun 2023 16:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hw: arm: allwinner-sramc: Set class_size
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>
References: <20230628110905.38125-1-akihiko.odaki@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230628110905.38125-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

On 6/28/23 13:09, Akihiko Odaki wrote:
> AwSRAMCClass is larger than SysBusDeviceClass so the class size must be
> advertised accordingly.
> 
> Fixes: 05def917e1 ("hw: arm: allwinner-sramc: Add SRAM Controller support for R40")
> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
> ---
>   hw/misc/allwinner-sramc.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

