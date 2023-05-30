Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E05BC716075
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:49:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ymQ-0004xB-KC; Tue, 30 May 2023 08:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3ylx-0004rG-JU
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:48:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3ylv-0006FG-Ve
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:48:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6e72a1464so30386005e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685450898; x=1688042898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zuBh/LEWp4WSjpTEKKhURTRkk58x4xiP1SYwoZGx6M0=;
 b=ZC20/ifrCFm0f+GbQ3lFo1c/vxoqZgbumoj6/oJBd7aCXvqAvAvWeEtdeXDJ6BbBwW
 goOtrAsepJL+X6RDlDLqrGfFO95iCrqjQ8QSULR6XriaKOpIHkf32N633xtcoN5nQgrT
 9QXSELlYnBxvnSdHaW5mKID1h2VNW3P0nCOqSbEiCLzpeTh1+C9+PMsUrxi4yf1u2WFb
 qT12SsLU/vkN06Hf67GvCxiy8f+HLpHne3q9aR+M+zHfD5LjkJa28XcwS8nODG+wySEG
 ReT8LLLQ1zGit3Jk4rr/OhTdVLPwVcfSZRS8+146YPCGziZtliEu6TnsBrYqopL0PvF+
 98hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685450898; x=1688042898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zuBh/LEWp4WSjpTEKKhURTRkk58x4xiP1SYwoZGx6M0=;
 b=LYsYRPq53Op9c4vdnAr9rc1WuiismsPY04vrPVdYMMR63qz3432UCOxwm2b8YL/WyK
 2W0S447GxnsmwQsNV8/2oTxSoE0rz2gCj+DG8oVBEWnD2iUgtpHfswwR/0agraG8bkK6
 Aj8pyr1secUvp9FGNFfqS8kXB4hop2yIiRlTakEmSaxESQZGIRM15Ne4nmy1S1nuVmye
 wPw6PLFZhYqiedNQoTQbIPoi3e1PWaseUmShBvA6cpNwTQ9+OEZthBOEEfjLo+8VfH0A
 tfDQC4L6Hg6rkBoGj/rlJ6wktIYDgok/fR8XjG+EJ4kwlu3lgyX23ggjve1Xil7Ogybu
 jvrA==
X-Gm-Message-State: AC+VfDwsb6lXkzzrkEzfRAQrI0F+zP8qJR04pAgjWxNeLGR8dxM3lU5k
 WkdiHViojlrOdZ6A/Evp2LlXyQ==
X-Google-Smtp-Source: ACHHUZ5L7tDWsCFp1WewIa7WI0zvmxottHq0BLDDxbS8RXHzJSOsFETJzoRThmLaYfv6Ml3q7mASUQ==
X-Received: by 2002:a05:600c:22c4:b0:3f4:2897:4eb7 with SMTP id
 4-20020a05600c22c400b003f428974eb7mr1516944wmg.38.1685450898624; 
 Tue, 30 May 2023 05:48:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a05600c0ac300b003f50e88ffc1sm21131077wmr.0.2023.05.30.05.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:48:18 -0700 (PDT)
Message-ID: <401da06f-46a1-e485-dae5-d8a0a93a54e8@linaro.org>
Date: Tue, 30 May 2023 14:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 03/20] target/arm: Introduce finalize_memop_{atom, pair}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
 <20230525232558.1758967-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230525232558.1758967-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 26/5/23 01:25, Richard Henderson wrote:
> Let finalize_memop_atom be the new basic function, with
> finalize_memop and finalize_memop_pair testing FEAT_LSE2
> to apply the appropriate atomicity.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h     | 39 +++++++++++++++++++++++++++++-----
>   target/arm/tcg/translate-a64.c |  2 ++
>   target/arm/tcg/translate.c     |  1 +
>   3 files changed, 37 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


