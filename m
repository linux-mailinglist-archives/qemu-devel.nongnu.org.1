Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1A873717A
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:26:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBeB8-0006hf-Q8; Tue, 20 Jun 2023 12:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBeB5-0006hG-J1
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:25:59 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBeB3-0006Z3-LU
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:25:59 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-519274f7b05so6497594a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687278356; x=1689870356;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/j2QptWXp5f8nMnGcfCsx/TH/d651DHO1GqRe4KGrDc=;
 b=LhCQuG+Tm/2W1PfT4QC+KJIY0uOx0cAJo41j8md/ojB3jQy8pK5kyO+BsqZediqGVY
 VNIqvuHvwvJSWEfpPMV+/7GEugRhoLm87Sa76e3HGJxKbVuPeN2qIb1ju7HU6IhoKCTJ
 +86I4cnvjirRYWs0I2G+nGdS4yY4xEfIBsOJ7Ybk+K+uVwk3qZycMqJdCWkp/Hg6sSh/
 56+BqgEHjdB03dAsjznDPZGVClLeYPAfPCi5jtuLDHhfbu0MFrtYrLEVff63jNyT672H
 ewgx7X2X4b/JJG7X4QcNUHdnyYgNiWqkR3KJZH2TO/zh0UxG6J3oACyBK1eO9ntZesxA
 JfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687278356; x=1689870356;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/j2QptWXp5f8nMnGcfCsx/TH/d651DHO1GqRe4KGrDc=;
 b=Izav6xZCIM6SsHqMLCM1GRzvlNPkyr5x5ofS1zBLiIgm7M8koUawpG4u8OwKnRcPDX
 xxhHpGdR74OgjEvEXbAQaCBFEHFZpXEkIf2N27FUR/CrG3f/edXR/zdk2QI6V3LCmxD2
 Ywac8F5eBeGB2i31kkjdve1pfYcxumvQoCw5LbnaBMF9sLUbgNsOHcxSe501howV67cf
 MT2IWwL6MA5KDzWRKpnJjhyzvRz85lRty42I6UeDBnVpr1IlqNTFF/7FCQo7SbOgFUHK
 yjIEQQg4DVTBYbkjVsEeMZBrf+p6/eguvFTmM8s3PjJwB6XAVrkMVIVWuAROg/zdohvo
 Hszw==
X-Gm-Message-State: AC+VfDy1mXAPUaRpLSbRjY8obBvcFV68TT2IHYJibtP90kccwXyyqU36
 ZpN5KAElhp+t5NbZzK751wwnK8QflSDGG+NOD1h8Ehmr
X-Google-Smtp-Source: ACHHUZ5StXr0rWU/flnQAsUwMfnzKb2ps5/KQpOOfbLepqSa2d/GB8OuoQzvCxR7cBnj90Qph3ZNaA==
X-Received: by 2002:a05:6402:895:b0:514:a4da:408e with SMTP id
 e21-20020a056402089500b00514a4da408emr8641661edy.2.1687278355921; 
 Tue, 20 Jun 2023 09:25:55 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 x1-20020aa7d6c1000000b00514bddcb87csm1446496edr.31.2023.06.20.09.25.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 09:25:55 -0700 (PDT)
Message-ID: <2da43cc0-48dc-c04c-8aff-0c90b78a6157@linaro.org>
Date: Tue, 20 Jun 2023 18:25:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pc-bios/keymaps: Use the official xkb name for Arabic
 layout, not the legacy synonym
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230620162024.1132013-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620162024.1132013-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52e.google.com
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

On 6/20/23 18:20, Peter Maydell wrote:
> The xkb official name for the Arabic keyboard layout is 'ara'.
> However xkb has for at least the past 15 years also permitted it to
> be named via the legacy synonym 'ar'.  In xkeyboard-config 2.39 this
> synoynm was removed, which breaks compilation of QEMU:
> 
> FAILED: pc-bios/keymaps/ar
> /home/fred/qemu-git/src/qemu/build-full/qemu-keymap -f pc-bios/keymaps/ar -l ar
> xkbcommon: ERROR: Couldn't find file "symbols/ar" in include paths
> xkbcommon: ERROR: 1 include paths searched:
> xkbcommon: ERROR: 	/usr/share/X11/xkb
> xkbcommon: ERROR: 3 include paths could not be added:
> xkbcommon: ERROR: 	/home/fred/.config/xkb
> xkbcommon: ERROR: 	/home/fred/.xkb
> xkbcommon: ERROR: 	/etc/xkb
> xkbcommon: ERROR: Abandoning symbols file "(unnamed)"
> xkbcommon: ERROR: Failed to compile xkb_symbols
> xkbcommon: ERROR: Failed to compile keymap
> 
> The upstream xkeyboard-config change removing the compat
> mapping is:
> https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/commit/470ad2cd8fea84d7210377161d86b31999bb5ea6
> 
> Make QEMU always ask for the 'ara' xkb layout, which should work on
> both older and newer xkeyboard-config.  We leave the QEMU name for
> this keyboard layout as 'ar'; it is not the only one where our name
> for it deviates from the xkb standard name.
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1709
> ---
>   pc-bios/keymaps/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

