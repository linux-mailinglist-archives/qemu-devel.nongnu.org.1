Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6270D7E2825
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:07:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01Am-0007YG-Mo; Mon, 06 Nov 2023 10:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r01Ah-0007X8-Ob
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:05:48 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r01Ag-0007Hq-4w
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:05:47 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-408002b5b9fso34156765e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699283144; x=1699887944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o8qLD+qmhiVU3X3HfZs6dRQvgaAiBaMWl8zVLnCQilk=;
 b=hpJcawwJYaayhiElSDT8l2I/G+OHSupp1ynIUO5LGrZVEag3Myyap5vVzDBmYfKJtk
 6N0zJdEhHR4AAl61BXtho5s60eCtKfis9XQOOBtPMzRjwxb5ud4axpv0upUc9RpjDVXf
 Das1Jv2GnQip/L7wwldFujQR7XyS2WaTWGTY7cI4rmxg+n/NCCxkmxAlxbqdj8ki7Yqh
 +3GLm0wWlhV53rQ7pzztinDGLEu502utJP+p03JkwPcMwggdyp3J5GkKcp1r1q4ZRtQv
 GvW9cOR/KCsio2ATB+ZVTrnW32gJBDoa6rmnEQbhfle1EibsVEabPzS+7mPoa8OiCFyD
 aZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699283144; x=1699887944;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o8qLD+qmhiVU3X3HfZs6dRQvgaAiBaMWl8zVLnCQilk=;
 b=Yzt5Lr2A1DO1w4l70Wv9HyCo7osloyVU0DpwFrWbkECe1Sx3WZNbLqDbW/0LqQ1a/F
 clihmKRw7Up16jokciLHHfcRrmglT6o0aE2e9GVNM1+GS/GzQWwFYxRM/8CjnieaD9p/
 eUm2juOE9/Ay7B1XC+zFSB+5JlPI41h9hn1rJpiEELA3+tcsSNiLUkrBMlUYFeL328Tt
 u8vbfdaTlLtz9/MVIl6aW1IvsVW6BrnLOBwGEcZhC5q2eQsT/IbFaDTXt/4f2rJKMvc2
 lmiH2HY//xLvM+l5C5Q7wMytnADyaN5EqSLZOfqSqwdIi4331Y/ZOzV4KYDMeTeSb3RE
 ws1g==
X-Gm-Message-State: AOJu0YyVBXQPrb4tShCUuioj0wI9jf4k5BoDBpThK5/gHGd4ScdFK5po
 BnrQgoD9slrPDub+dztguv5MuQ==
X-Google-Smtp-Source: AGHT+IGZME9mvPfKlNtInXE9uFYsVD5VVE4x9F81EfbcVbIcl/0V2J/u8rwqV3kC2aeDOwO4o0Rxag==
X-Received: by 2002:a05:6000:18a4:b0:32f:c750:6ec3 with SMTP id
 b4-20020a05600018a400b0032fc7506ec3mr5201537wri.65.1699283144293; 
 Mon, 06 Nov 2023 07:05:44 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 z18-20020adfec92000000b0032da8fb0d05sm9667272wrn.110.2023.11.06.07.05.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 07:05:43 -0800 (PST)
Message-ID: <eb6b92d4-4ae8-4e38-2369-4e9420f4d138@linaro.org>
Date: Mon, 6 Nov 2023 16:05:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 19/35] tcg/sparc64: Implement tcg_out_extrl_i64_i32
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-stable@nongnu.org
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 28/10/23 21:45, Richard Henderson wrote:
> Build fix for missing symbol.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: b8b94ac6753 ("tcg: Split out tcg_out_extrl_i64_i32")

Commit b8b94ac6753 looks correct, don't we want:
Fixes: dad2f2f5af ("tcg/sparc64: Disable TCG_TARGET_HAS_extr_i64_i32")
?

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/sparc64/tcg-target.c.inc | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index 386f51f29e..ac86b92b75 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -530,6 +530,11 @@ static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
>       tcg_out_ext32u(s, rd, rs);
>   }
>   
> +static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
> +{
> +    tcg_out_ext32u(s, rd, rs);
> +}
> +
>   static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
>   {
>       return false;


