Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 680197EBA8F
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:23:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r33fs-0005MV-Ng; Tue, 14 Nov 2023 19:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33fp-0005MF-WF
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:22:30 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33fo-0003SQ-Aa
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:22:29 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc921a4632so56675905ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 16:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700007746; x=1700612546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1jKU3Cl/YGpR2OL8VokXMtgrBtzPhbEfYBG2YcAc7QI=;
 b=Ml4C3nzqVbnMuC/nwbXpoQrXGEdynRbiSq33Y39k67QTystZCuphZPDOFQNPb8yN8c
 xkonbT3hxDGl5hBZzSvOLamNAqXkQ+10rHUQhpEzGtg0L6i/z8ZMd/CDKpYYrzbgIyX1
 sdp2G4vNPO1eT7uvGAY9NoyLUYHCyxaettoX7TDS0jVRQMaUOEPatcHHAHvB/RUKxzvM
 O5UmiK9AFf+UV1Vd7bNY19xjERgVjf1sFejvz/14p5/cVqoM4Z5hnZGlz9U4Qrls/HMJ
 5IAFjtz8sH+GDIcLc4EbzUDzwlewUrehg0rsOivcDc1v1ACepLMA3R3EVP1uvmmmDh6l
 RIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700007746; x=1700612546;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1jKU3Cl/YGpR2OL8VokXMtgrBtzPhbEfYBG2YcAc7QI=;
 b=vZvOGbpKe7LoX6HMqtKplrxIfEOJBTGfZE8Tm47Dyz7Fd9CPW/VN+oxn+8v9+yoGXR
 6m2eft6VtdLGwv4HTZDjnCVgfL7BLawIcV7Oy++ae3HcLCzB89iwtyNXZ7CWY3oZ/gR4
 69qsClVtWKS+d2mVw315ebsfQEdov1ll3tlmLVIdYDZvceRylwh27XTk0yz8cPO+VgdF
 rBImy5+f7XIK0EepJbAp9pLTIvjYTPiLTw6GoEMFK0GPDy3daqXN2awxTTh0z1Yl7Dnj
 nVyc8Y7Ao5YI9f5dWomPjN46T1EG+IFJEhStZA6tMjgENdi9tV5T6kYGqol7F+rVvwLv
 nUzQ==
X-Gm-Message-State: AOJu0Ywqc7TYHd4cz7+tecirhQ/BfitZGtelFx5IJhtL0c3xZ6G7rgj5
 NCKJERzYeTRWImaZP6h/YJzSjw==
X-Google-Smtp-Source: AGHT+IHfcTNhWU1KUX4r/m5UrBBRxk0yFsx4p+geYL5HoLm0eGcBsaNhgjJIOskFOBt5ZZVKmgyzCg==
X-Received: by 2002:a17:903:4288:b0:1cc:4559:ff with SMTP id
 ju8-20020a170903428800b001cc455900ffmr3483946plb.13.1700007746441; 
 Tue, 14 Nov 2023 16:22:26 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a170902ec9000b001cc2bc10510sm6181997plg.128.2023.11.14.16.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 16:22:26 -0800 (PST)
Message-ID: <55804c4c-2274-4b21-a27c-186c0999c859@linaro.org>
Date: Tue, 14 Nov 2023 16:22:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/31] target/alpha: Remove 'ev67' CPU class
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-2-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/14/23 15:55, Gavin Shan wrote:
> 'ev67' CPU class will be returned to match everything, which makes
> no sense as mentioned in the comments. Remove the logic to fall
> back to 'ev67' CPU class to match everything.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/alpha/cpu.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)

The subject is wrong -- ev67 cpu class is still present.
Better as

   target/alpha: Remove fallback to ev67 cpu class

with that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 39cf841b3e..91fe8ae095 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -141,11 +141,8 @@ static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
>       typename = g_strdup_printf(ALPHA_CPU_TYPE_NAME("%s"), cpu_model);
>       oc = object_class_by_name(typename);
>       g_free(typename);
> -
> -    /* TODO: remove match everything nonsense */
> -    if (!oc || object_class_is_abstract(oc)) {
> -        /* Default to ev67; no reason not to emulate insns by default. */
> -        oc = object_class_by_name(ALPHA_CPU_TYPE_NAME("ev67"));
> +    if (!oc || !object_class_dynamic_cast(oc, TYPE_ALPHA_CPU)) {
> +        return NULL;
>       }
>   
>       return oc;


