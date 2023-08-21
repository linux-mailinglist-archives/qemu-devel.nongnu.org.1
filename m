Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CF678303D
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 20:26:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY9al-0000zp-6I; Mon, 21 Aug 2023 14:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY9ae-0000zW-CG
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 14:25:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY9ac-00007o-9D
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 14:25:24 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bc83a96067so19889445ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692642319; x=1693247119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=twRauk71GNiidAU146hHWvGXFiyEKVOW738yy2Bks1g=;
 b=CePbfMh2Ou9140cptORqJ7LoHr8NWJHTyNlll2UFxx6zBaWR6MIpAc1z0Tq+5Tj+2S
 SeUhPAekZfrSO+93V6tCHYrXGVNcc/6t2GJKHgwf4p1pJBfB6pkqaL8b9208v2XkObIS
 6j1zpZT12ER4sNdIrvq0LQnvNqyLNIWF1v3Av80S6twxWaglQxuvAMGTKJqg6DdfNqoz
 lAe8bfWlnZPQSAUneTR4ovjnFe3iXjCSZXfi9RYJE/vDP01JGuAGciQpPF7El2m+Wpi/
 vhyL/s4O0HcARg8gh+wPrOv1xs/6ML0MrSybbaOR0FBZDPWP1eCuey29pFLovNVZE6mC
 eZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692642319; x=1693247119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=twRauk71GNiidAU146hHWvGXFiyEKVOW738yy2Bks1g=;
 b=js10VLsDGqfCdYzMga27Kr+DCe0rkUGgydPUCDDokVVe1uvTXjOAMNwIKgWIi+eAR+
 qIsXxN0KfCim9TClFEYrLFPnC3dFp23XiweXYMWrq3KNIYuENndIliI03aPp5bt4qSCc
 gZs/DVQaIqh+GWLiWAOsuoPQlXJ3uJSVLGJovPct25KHGs4bqPAB52Prd8uM96XUtxWi
 eMLYjzdneWv58aQHemKOwewNN7jQ4uTf+viN3KJPKwO4UrbhvKqitPqW34ZIilpMmJn1
 4vP88fz9dtaSaObpw9bf4wrIiRGBUBTkm5jODsFbKrx+qN8bnEM6LCz7BpQTFmZRHOzs
 yLcg==
X-Gm-Message-State: AOJu0YwSydxc1if5Ws2xbiHsA2DmTIJufrOD+HzPDKf74qQXFsY+VbaV
 07DlKCqJdfS2x+9i4qZwrB4mag==
X-Google-Smtp-Source: AGHT+IGO3nlFtuoJHDsi0LxPXjI/vi+3zdQW8Uj+5nAKv1LrscpQO3B7HYO37pME5D4xmVbqsvpArw==
X-Received: by 2002:a17:902:7890:b0:1bd:d14a:7e14 with SMTP id
 q16-20020a170902789000b001bdd14a7e14mr4951059pll.65.1692642319656; 
 Mon, 21 Aug 2023 11:25:19 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:2c08:e710:4459:46f1?
 ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a170902d38c00b001bdf046ed71sm7347618pld.120.2023.08.21.11.25.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 11:25:19 -0700 (PDT)
Message-ID: <7d06c66a-361f-f1c3-c3bb-e99ff69d9a2f@linaro.org>
Date: Mon, 21 Aug 2023 11:25:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/19] crypto: Provide clmul.h and host accel
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
References: <20230821161854.419893-1-richard.henderson@linaro.org>
 <CAMj1kXECQeCnUZyt2FMnOSRfzBp_bCVQ2ZUV+VvSx==7nnqu5g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAMj1kXECQeCnUZyt2FMnOSRfzBp_bCVQ2ZUV+VvSx==7nnqu5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
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

On 8/21/23 11:08, Ard Biesheuvel wrote:
> OK, I did the OpenSSL benchmark this time, using a x86_64 cross build
> on arm64/ThunderX2, and the speedup is 7x (\o/)

Excellent, thanks.


r~



