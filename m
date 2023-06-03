Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 653C7720DF7
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 07:43:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5K2L-0000SO-22; Sat, 03 Jun 2023 01:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5K2F-0000S1-BL
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 01:42:43 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5K2B-0005SH-1D
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 01:42:42 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-33bbc91dcb7so13096565ab.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 22:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685770957; x=1688362957;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eHtD3r8eQUhKXy9rSyCkrVSTtWlD2fudkIlTI+MkhMA=;
 b=hxiHrjsOQ/+tFgcSPajUpYqD8suKpbx7sAwsKAiSKzbx3EiLTkA3Rtv86HE24ddA5+
 hRjuCMml/S1DvyDvChHLk3VQz6cpxtxSg2MVqf0eVau7PfNMCXW0iF9p3W1/6XUdJ+VY
 8Hk/t8c/p/Pda/YvtHWYD/+S/rrQhn6OJALTji5Rumm5JJwjYs6v6emrwBZ/9x0BKZ8z
 LWZMuuObxeO0143IjVNYosq1KRHlMicIK2RNKwfMMuf6xlyrV0TjlGC5DoaZ9uRAqstQ
 rQuErVCo/2enArQv/cbRuvQZ0kjoW2QLBKjtdybQvHGRfcO1uZJdGgzAodZLBPb2CWsA
 rD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685770957; x=1688362957;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eHtD3r8eQUhKXy9rSyCkrVSTtWlD2fudkIlTI+MkhMA=;
 b=Eo1EBULDH2TjCgHtSm4xBMojPvvaVm/zaCvz7UrlZx/CYcCiP3ZQrjQmZgvdK99mrz
 iDRVDnWyvQgz8la3a8xYVFyV/SFviwJgNc3oZRT2DmyVFnoxCUlEAZQ6Zss++uGVXSU4
 U/IkAb9jo0lfU/1ZQ8rThqysEdzGfgsPT4+hIqowcWNmY635sTV6j+6hgqRX4M+UKVZB
 pmuX48/p3xwyST8pvBeWfEUJdNZitcEEOwrUymZmG1Goehj4waIUkb1cmNihggJJUTqv
 GREiIQok/q+I0FmpdmTV0iyULa7ehhT4NiwwkjrCuYwJW4VJWY2Sxa/f68xjcLVko+SY
 mj5Q==
X-Gm-Message-State: AC+VfDx6Jac5OtC10kDTOpxD1q575Z2JYRQt8U/QgQQCnPbatAYMa+a2
 ugKbl57cmofHfYK9z8EZnWqM2w==
X-Google-Smtp-Source: ACHHUZ5tJpyyprmdJnZ6xLB/QAMx6beMo7aRo19dxyQYeaABcTV1V/mGGtU4BN9E2W7136gHL/BjYA==
X-Received: by 2002:a92:c9c2:0:b0:33d:24f9:d537 with SMTP id
 k2-20020a92c9c2000000b0033d24f9d537mr7170457ilq.26.1685770957413; 
 Fri, 02 Jun 2023 22:42:37 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 x1-20020a62fb01000000b0063b806b111csm1737934pfm.169.2023.06.02.22.42.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 22:42:36 -0700 (PDT)
Message-ID: <cf99db3b-e10f-2467-8eba-9713a72adb32@linaro.org>
Date: Fri, 2 Jun 2023 22:42:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 02/20] target/arm: Convert hint instruction space to
 decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x136.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 08:52, Peter Maydell wrote:
> Convert the various instructions in the hint instruction space
> to decodetree.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  31 ++++
>   target/arm/tcg/translate-a64.c | 277 ++++++++++++++++++---------------
>   2 files changed, 185 insertions(+), 123 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

