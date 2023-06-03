Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DEF7213C6
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 01:36:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5amD-0004hV-AW; Sat, 03 Jun 2023 19:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5amB-0004hC-8o
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 19:35:15 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5am9-0003Fa-Mf
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 19:35:15 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b025d26f4fso30342185ad.1
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 16:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685835312; x=1688427312;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G5YYAThVQnWNgL/97RYmH7/U3pDBhvSHlATExlmn2to=;
 b=R19mS4AcAtZHAQUrslY+sp1ZgecBD2Oqm7mNQLyxJL3sTGNYTnUKLYMOc5QYai5Frs
 0sOsKVj526pCyko+AoIYjKZIb4OrX9F2XiBbtridtpv/Twou2Eloh3fNKLENEa0JsnFY
 o6dC+gbx5jrDWnQBBt5OXgpPmtRkcer0Hpg/rdpj1s1k7ytoR+FwM2Qv6nPktAC5KLG2
 ZWXhfom1b+Bd3xvQqowPoXRZOQ7X57hmHvQ19CMuyTmlwWCR27TdifPNmWhNAnwFS4KF
 O4eEdmO4yzm8zG8J1XbI5mxTuhKUav1AIxX0G0jL0zgjYeDm6SidkdifX3mWQ8u0SaEp
 ju1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685835312; x=1688427312;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G5YYAThVQnWNgL/97RYmH7/U3pDBhvSHlATExlmn2to=;
 b=ARl/T5eQIn+zDknNK2XFoSH7SzRm3o9y3Gqqk6Ys1z3y3RQTE+ExcQbxcvVJ5r0cyp
 hmSd5AmteaCraLH/2eZQUhNYCMWsNasKDE7U6V/vN22aI2ACXRgNC3AnUNZRs4YHRYmK
 iDgNo1UD+jurq05RSJm4Fgw82VnPs6W5iGrBne4mePcZvrWm7lHwTd7ujKCxyCA/VCFl
 /OQBcSreg1/xgcUfFqvCUxarKpuZYPz0bbhPuQslEmHInlnXyHDkvtpF/iJtHhaM+esa
 C5XwHPFIT8ESuEH1p1nG26nE1Ai+PF4OLcoiDtXpn8d0rUEj0dQVb2J2dZ1s3yW8fZef
 FebQ==
X-Gm-Message-State: AC+VfDynmL169WRVJyq2IArNL1FnHRXXDocXqqvq0daSJm0TrgivloZO
 ynA2Rr2YsDteRagS9Yl8ZIG0jTVsUrdEiyVlbik=
X-Google-Smtp-Source: ACHHUZ6iHw7FRotCtptuI+bk2xYgsL8hpOzABBX9t9EPrZijCpMOaKsAGr+EWoV7DpEPO8TLYxiZbw==
X-Received: by 2002:a17:902:cec9:b0:1ac:84dd:6d1f with SMTP id
 d9-20020a170902cec900b001ac84dd6d1fmr4906579plg.1.1685835312157; 
 Sat, 03 Jun 2023 16:35:12 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a170903200a00b001acad024c8asm3722599pla.40.2023.06.03.16.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 16:35:11 -0700 (PDT)
Message-ID: <8a2f965e-435a-bfac-5599-b0efab83bc36@linaro.org>
Date: Sat, 3 Jun 2023 16:35:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 15/20] target/arm: Convert atomic memory ops to decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-16-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 08:52, Peter Maydell wrote:
> Convert the insns in the atomic memory operations group to
> decodetree.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  15 ++++
>   target/arm/tcg/translate-a64.c | 148 ++++++++++++---------------------
>   2 files changed, 67 insertions(+), 96 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

