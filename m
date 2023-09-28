Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A5A7B26D4
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 22:50:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlxxL-0001Sf-RK; Thu, 28 Sep 2023 16:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlxxD-0001SP-Nd
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 16:49:47 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlxx9-0001Qa-TA
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 16:49:46 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-48faba23f51so5000563e0c.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 13:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695934179; x=1696538979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1JT1Kd6LjkSdgtv7ZyWTRCTt4F/HM7bhZ2sKLpnu9JY=;
 b=jBCbOhDqd0ws8eYYhRM7k097HxEOB16R87jmwn2vs/jvKyBCm0txU8JZeS8G4w3nT+
 6V4rXImGqrI3AByPCkj2H91yEtO/WoERkDrv7HAPVFK1niAEPoTIUd8eqUxei75Yw7mW
 c3asGNDWCW7KroSfrsGAUNbsDmbgYJsLrupo1sHU7fABsa9XPFDTL3CS3QN8TjY8CaVx
 prkoX7HiuxkVEDc/Ljv6flZ0fivvkfSnYIfH/QEOOpEVDnyO04AboFMJm8H84Pp9im02
 TAXfAnINq6EaAgRXBn5EhSWOLKZFXSccMv6Sh03F27lRRwKkTPWC8OSejsjSdabVxEZF
 SfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695934179; x=1696538979;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1JT1Kd6LjkSdgtv7ZyWTRCTt4F/HM7bhZ2sKLpnu9JY=;
 b=f7lDjuJqRbo0/bQbyaQHeHxU52OfHJrv2UKA+deIcEzJOJ7evhZB5v5/Sce5B2S+G4
 sfNBTewT+oeHO50OrMvB0BNpukT4ZAdojs/R0MawftD/OMb7sTLFIvMv53fwxUtXAeQW
 BFaIz5PwHKpEA6dnTGXFwfF97wHTamUJ+ZhfqgEnfWqGujzmo0NxhQZOXgCjtiZqB9rz
 FxDOBujAmNoHkzf6ToPFM6aULCl7ZSAk/zkwLAxOI/hHTF69aI4T/58IUIe6jqqTpEWT
 viEzWs7y2AwFe4IqSpDI6xRlj7HFpgHkY+g8TsvcT0QbAGWbvqcioZ2x/M69xXYw6tOG
 iZ6A==
X-Gm-Message-State: AOJu0YwXkJ1kGVua412la0eEGJhZm4/Y+K6Oe6JP1rgUyCNJCMud66KO
 bzoz+mxXgbl8B+Eabm9ISiFL7A==
X-Google-Smtp-Source: AGHT+IGPAPD3deUSt/ZH0UX+d1uyvq/KxLF2L03LExujD7pTkF83hR/Cb1g98mOSftXC7Sj/4+vYRg==
X-Received: by 2002:a1f:4ac2:0:b0:496:295a:843 with SMTP id
 x185-20020a1f4ac2000000b00496295a0843mr2045121vka.13.1695934179420; 
 Thu, 28 Sep 2023 13:49:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-146-124.tukw.qwest.net. [174.21.146.124])
 by smtp.gmail.com with ESMTPSA id
 q19-20020a62e113000000b0068bc6a75848sm13752952pfh.156.2023.09.28.13.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 13:49:38 -0700 (PDT)
Message-ID: <347031f8-499d-f244-7497-11bb39a9e352@linaro.org>
Date: Thu, 28 Sep 2023 13:49:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] target/arm: Permit T32 LDM with single register
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230927101853.39288-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230927101853.39288-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=richard.henderson@linaro.org; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/27/23 06:18, Peter Maydell wrote:
> For the Thumb T32 encoding of LDM, if only a single register is
> specified in the register list this instruction is UNPREDICTABLE,
> with the following choices:
>   * instruction UNDEFs
>   * instruction is a NOP
>   * instruction loads a single register
>   * instruction loads an unspecified set of registers
> 
> Currently we choose to UNDEF (a behaviour chosen in commit
> 4b222545dbf30 in 2019; previously we treated it as "load the
> specified single register").
> 
> Unfortunately there is real world code out there (which shipped in at
> least Android 11, 12 and 13) which incorrectly uses this
> UNPREDICTABLE insn on the assumption that it does a single register
> load, which is (presumably) what it happens to do on real hardware,
> and is also what it does on the equivalent A32 encoding.
> 
> Revert to the pre-4b222545dbf30 behaviour of not UNDEFing
> for this T32 encoding.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1799
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate.c | 37 +++++++++++++++++++++++--------------
>   1 file changed, 23 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

