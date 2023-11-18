Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E68387F0155
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 18:38:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4PFK-0003SI-7P; Sat, 18 Nov 2023 12:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r4PFI-0003Rx-Sl
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 12:36:40 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r4PFG-0008J7-R3
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 12:36:40 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-548696eac92so1073922a12.3
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 09:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700328996; x=1700933796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DC2MaIfS6LlWkY/Yuul9WyhF96mD7ttUTd+lMSh2lXs=;
 b=nhSL55NBw+/zxoZu7++M6Y4W473Bbsx42juoKUbJK2zoDGo60gmZAjhd/DgPuyw+Md
 +5RfX3xyPWJ7BxbAshzRzNXf2XwiySZQqE6Ojj+K1Tu0Ep0HR3soqzJIdTYMiQPhVDIH
 xDviTZ7CP4RRK9VURaOcznrwkOd2MMy8Yq+ePogP3FBgl593XrCUdri93TKl8hFGzzrl
 oNdETAc69HG5stKgIvDObDTa7yN8paat5UEk9nKabR2qRzpi3WwTGJpiO7W6qfzPSE//
 bPZQGN/JRiyV9Se6rxO5imPNWytTNiEdETrcjFD03kGN9+b6WvbsG8mw2fp676mx3muB
 w99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700328996; x=1700933796;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DC2MaIfS6LlWkY/Yuul9WyhF96mD7ttUTd+lMSh2lXs=;
 b=FjXeM27WW5oIHaAmEufj8wknx/gEyuZ2k9KPooBVp3LsKq1eMTv68GMrzogvzvDWWU
 FHfIppr0mu/Mqd+x9Bq92aJydeM1Xe5nOTBz7w8DZAR5BdX+HbNJ0GYrTDhMhgu+JZHj
 SYiSEnSUrniRvsb7RgJwGeW3M9qrVZTZYXhW53fLrVqsw65NBkrsSPVWELyOQMgiZZpz
 UMqqhsR8bwMIygjN+6cEEHN42i+qitCR33al+pZSc0gZGjabCrz3k7gZZ64l60Cc3slJ
 Y3uS7H3Fr+Rfk97RnKL/MrINdp2LyZmTWBKS0TygipWsDw8r8x2qLMLXSJ2G9cZt/Ls5
 LNfQ==
X-Gm-Message-State: AOJu0YxoRPgcHWeQ6TagXJyXdQi+jmascsNPdG6DzYqLDZHoiiVXkCTU
 dOWCfg+xPUz4Hkb874id8zCQ6IUKhfCDK1ciYB4=
X-Google-Smtp-Source: AGHT+IFOKSWoML1tEryZjCtjqE7NSsvtKow/YqxYAsoQZ1EDcVQl33MNQljYSY0oqJLruhRgdTl7Gg==
X-Received: by 2002:a17:907:7b92:b0:9be:6ccb:6a8f with SMTP id
 ne18-20020a1709077b9200b009be6ccb6a8fmr3005941ejc.48.1700328995593; 
 Sat, 18 Nov 2023 09:36:35 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.152])
 by smtp.gmail.com with ESMTPSA id
 um16-20020a170906cf9000b009b913aa7cdasm2086267ejb.92.2023.11.18.09.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 09:36:35 -0800 (PST)
Message-ID: <e6f3b219-5e81-4a28-82b9-ab3e30046032@linaro.org>
Date: Sat, 18 Nov 2023 18:36:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.2] target/arm: Fix SME FMOPA (16-bit), BFMOPA
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20231117193135.1180657-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231117193135.1180657-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 17/11/23 20:31, Richard Henderson wrote:
> Perform the loop increment unconditionally, not nested
> within the predication.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 3916841ac75 ("target/arm: Implement FMOPA, FMOPS (widening)")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1985
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/sme_helper.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


