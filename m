Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5668A746C58
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:49:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbi1-0005Uw-P4; Tue, 04 Jul 2023 04:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbhz-0005U2-Nn
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:48:27 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbhy-0001tr-As
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:48:27 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3142860734aso2753533f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688460504; x=1691052504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=toKx1fFLd+3/2P2vytnpx3Tsn4SWMbWwnwh4hJZuTuk=;
 b=O1Obz0A6umHoYblvkCg2+Snh7K1+VmFdAHyt5lNbn+ytu6zpm4LN8uMILqiG+mDTAv
 wKfn8cl1YrNOgXb0ytcrmAvLNVwKkyUR28apAbqbe1NdZouXeMNTfVAGa5WLjAqrwG4A
 N3vaPeZrIlIrSfvjvlY5Ggwg9CHKZLj3rU4UNRX7M4Y3J7u4ROqS/LSaRhHo3aOB46mN
 SjLn6KuwNOFybfarRLfuL8tyFLpIuUxRFuMGnIluLRn8vMEVa5B1WHbegZO/6o89k/0z
 9XIpTSpFppzt/FdstMTr4lDc8E+wwuegMPNBwHrYYFfGoHxPKKUH273aV3upuqgeY4Wc
 s0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688460504; x=1691052504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=toKx1fFLd+3/2P2vytnpx3Tsn4SWMbWwnwh4hJZuTuk=;
 b=XqRMxW5fYazRkPST7VIRoG1XGal91g7Odo4AKfiiCrnBNr09pUC/Oo6NsCnWPDx57y
 kTjZHXlhVjLXqokE3FOqAjc5/KMSc1d1qVrWRQxE5rs2kxpzEBkMqxe/BfInzYgg1NO1
 KZGCk//T7fNbF3N0a2mZp2t59mLYm6HNBUfzJj2uoLjH34bOsWF2aKCVan/5ZxshNsGB
 4rvmh0i9SNZFmGNGVuffXE9kMU0ilfM+Whnd9adMgzvaVjOaSzEQ1I0YEi+6CyEhplQU
 Y1bFAmEysGYA+9WDDRJJTmoA2Fgdmt7O4e4P8MHg7y01GY/jS7THoKJHbpIvICg3Zq5E
 TNpg==
X-Gm-Message-State: ABy/qLZka2aJytHDGG/o1Ih3GXJGakUuzoN9fgIK0QXRpe8TucRVTNLx
 Bcr8uRB/3lFGHP+llaLQGmSOTA==
X-Google-Smtp-Source: APBJJlEju6sp0FP6GBXaubFVLLJNmtkhXJ1hLH1LWQxPTv8f08/bDHTlgbUoA4djq9iApQ4nrGQT1A==
X-Received: by 2002:adf:f84a:0:b0:314:140a:e629 with SMTP id
 d10-20020adff84a000000b00314140ae629mr13829335wrq.7.1688460504591; 
 Tue, 04 Jul 2023 01:48:24 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a1c4b11000000b003f9b24cf881sm32191156wma.16.2023.07.04.01.48.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:48:24 -0700 (PDT)
Message-ID: <6c582b2c-927a-41d1-68a3-19f8189eac70@linaro.org>
Date: Tue, 4 Jul 2023 10:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 01/13] ppc440: Change ppc460ex_pcie_init() parameter type
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <3a4232c444613e63627203cc7c8c22c9d5bb414d.1688421085.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <3a4232c444613e63627203cc7c8c22c9d5bb414d.1688421085.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/7/23 00:02, BALATON Zoltan wrote:
> Change parameter of ppc460ex_pcie_init() from env to cpu to allow
> further refactoring.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc440.h    | 2 +-
>   hw/ppc/ppc440_uc.c | 7 ++++---
>   hw/ppc/sam460ex.c  | 2 +-
>   3 files changed, 6 insertions(+), 5 deletions(-)

FWIW I'd rather move ppc460ex_pcie_register_dcrs() in
this patch. Regardless:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


