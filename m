Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C2578D014
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:14:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mv-0000jM-Un; Tue, 29 Aug 2023 19:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4q8-0001wl-KG
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:57:28 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4q6-0007Go-3c
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:57:28 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-26fc9e49859so2767322a91.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693339044; x=1693943844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vmLkSEepLW7htOhiNJ+mpz4AbMKUaJ69xeHg7iyXyFM=;
 b=vdz4vC55gk56g1kScBFJDSm0mkFjn9sIP/NQ+hxIsJ/Ut+tZt4gz715BKF3Wr4Oc5U
 m7FKShtwVMzTI5RL4jrRDshUTAyV2JAZdN6Ev7wBS6Sqmkqt66DG9HW7aHULgB4Ya/nN
 9lcmThn6Yxvn2O7KcVqVwGOYjyvwQWxO/tBaIqcebN2zCKwBr/TxUsVSt5AZ9eENieSU
 k1Yw2OfVXghkldqPaqCr0Cs/R6GotpBBFaKBHBv6LCNPzhixrlJlmrPb68Xm7+FZ8SUJ
 W98zktzf/wJpqyoxL8M3PAGCzwm8l9nsjgmhp4vmbF/p6glYyrz+e8APicXa7CSdUK/L
 fCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693339044; x=1693943844;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vmLkSEepLW7htOhiNJ+mpz4AbMKUaJ69xeHg7iyXyFM=;
 b=TbFrDSRwwK4aVAr7ZTwTySkx5Tuj/KxNPawbDD0ksKMEkWSK7hMZPLw6XRuywB/nZ7
 SuYneax/K8eOx8njZQ/BfOJhhFmrr7HS6iST/m69xmdc+KMn1niGe8Piody+kmGQ3WkT
 RdoCL1+uSVR6TFO56sURQwguTwb0L6LITCTD6k1ZdpEQVY/TGPixOZa38tl77QRad7gH
 6tvqQm1K+V/exkp2Kqh7C0oNFw/Xcaf8pYoJL0bMO/DYkUJwLWjZwiOrFuAh5Q0FpkgE
 pVSfe/qkksgdTKadVofRZH0YXi4QcHKUXhikjH4WQKEKg39mDIaYgokUNFGO26l663dE
 Xicw==
X-Gm-Message-State: AOJu0YxIGj4oJDXGt+LO9T7ekfUMZy5eJk0Z3GojROGcFyUPZARqSDKs
 knwGUZFF1L9TWmblL+mSGv7gNg==
X-Google-Smtp-Source: AGHT+IEJa+s9heE4X9Yvnat492dIZTaeGIAWZq5OIOiuxKuqdUxBRuVioxWRN4JW+1EVfN8nBxUIIQ==
X-Received: by 2002:a17:90a:f318:b0:26b:6a2f:7d96 with SMTP id
 ca24-20020a17090af31800b0026b6a2f7d96mr221587pjb.18.1693339044145; 
 Tue, 29 Aug 2023 12:57:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 15-20020a17090a000f00b002681bda127esm9939371pja.35.2023.08.29.12.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:57:23 -0700 (PDT)
Message-ID: <46b7efd6-b364-1479-e3c3-b7bbc4417581@linaro.org>
Date: Tue, 29 Aug 2023 12:57:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 14/32] bsd-user: Implement getrusage(2).
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-15-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-15-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-proc.h           | 13 +++++++++++++
>   bsd-user/freebsd/os-syscall.c |  4 ++++
>   2 files changed, 17 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

