Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD1279914F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 22:53:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeiTI-0005oC-Bn; Fri, 08 Sep 2023 16:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeiTC-0005nA-40
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 16:52:51 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeiTA-0006eo-1f
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 16:52:49 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68a4bcf8a97so2004544b3a.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694206366; x=1694811166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l0cMhIb7U9Z1ab1M4542EFUivodi9OT0TAYeA8IKBAE=;
 b=zDpLCTknsF0F0q/alvvah5h0r2OpPmGzusC+8hboiqEfLDTYKZIO3+7EwBZXoAgtCx
 tfbDPgHQcy7orsz0cEVCGA+lDai0HItxp8yPTWlT2kdmvERdf9VTJEFWMIsBJu7wQR/H
 JbecxPwLeTl+weEZrcwLFHdlOi2D2ecwod1p72UYuvzVtvFqPnbToFuBraaMuFlGJLYw
 mR+/1cS2LM3mlinrFFxgDvjSxtsTz7jOKbaicR62myJcI3tpZ/Ntd3gA8wMvd5BVf26B
 U4tyxceaIE9bbGhY5ldMUVTolWb4X/YnpcGhPqV6lXEx6Z1v9901foBQDMy0sgaJp6vQ
 utpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694206366; x=1694811166;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l0cMhIb7U9Z1ab1M4542EFUivodi9OT0TAYeA8IKBAE=;
 b=d1Vaa7fIwhK9G9YyA39Ypt/RHGy9Fa3DkRIe0388WQLN03C7fITvEK+6pmOZ5zf9/K
 UL4ToXofTXTrco+XKxv6xaSAZIaSv3rkdwnTV/6yaRd5vmX+qMp+aiD04G9Yjj2S/V2Y
 K12Jyu+KW7gtyfmIOd6LZNWhlDHLyOOdKbBidqpPWQj5OKrbFGBjGUDOk8IwLYnZfRr5
 hnNLIc0tV/b9lJjDwCTgGpap/yKYGVt7y3x1B3gKJpziyQFBdX7F1f0tW37m6PBSskPH
 rTeG0V6oARXoudo6ZBGjlkH+gaKmq636gVAYaJyI7Yy3cRbQWP2VYLkpQ/qE+7hQoIVl
 Lm8Q==
X-Gm-Message-State: AOJu0Yzu03aySn9qhe2bkD5gKAPIAwkHBf7TLOJBEufuUir3mkZLgYJF
 3cPIM7gSBotlpWAg2fqSiuA0N2M02s90f06o4AI=
X-Google-Smtp-Source: AGHT+IGZfWJhYMA4XWqR6qcSr+zFPzfNc47RVv8pc0TBWl7a9Zm7NSb6MSbDOrzFN3xbAALAs4Ts7w==
X-Received: by 2002:a05:6a00:2d9a:b0:675:ef91:7922 with SMTP id
 fb26-20020a056a002d9a00b00675ef917922mr3590417pfb.4.1694206366491; 
 Fri, 08 Sep 2023 13:52:46 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a056a001c8800b0068be216b091sm1578075pfw.24.2023.09.08.13.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 13:52:46 -0700 (PDT)
Message-ID: <51e7dc21-35ef-9037-19ab-93a8ff2667c2@linaro.org>
Date: Fri, 8 Sep 2023 13:52:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 08/14] target/arm: Implement MTE tag-checking functions
 for FEAT_MOPS
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907160340.260094-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/7/23 09:03, Peter Maydell wrote:
> The FEAT_MOPS instructions need a couple of helper routines that
> check for MTE tag failures:
>   * mte_mops_probe() checks whether there is going to be a tag
>     error in the next up-to-a-page worth of data
>   * mte_check_fail() is an existing function to record the fact
>     of a tag failure, which we need to make global so we can
>     call it from helper-a64.c
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/internals.h      | 28 +++++++++++++++++++
>   target/arm/tcg/mte_helper.c | 54 +++++++++++++++++++++++++++++++++++--
>   2 files changed, 80 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

