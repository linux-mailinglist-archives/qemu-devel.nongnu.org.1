Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF96736933
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYY0-0001Ep-Fp; Tue, 20 Jun 2023 06:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYXs-00018c-F3
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:25:08 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYXp-0000hE-Ln
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:25:07 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9741caaf9d4so553383266b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687256702; x=1689848702;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e5OEfbuuH8T9Dcj7iOcZAlKmwpUl+YWfTb2WCDK4aiY=;
 b=YVDIHwmltJxXYbus4qlIPCDZi2RYPqpa6BNuJeC4x1QW8YToVyWWiq3Wp5KV26y8sl
 GsVpBFH/R5WsRMfwdcTDrwtH7EExNfGj+YxCI4LCf8Ch/yquEuFFhRDeQj3cwsK2t6wn
 Xx02QJrUDf6E8TokyJ6wPyk8XRcl9nowZyzM7tmEchEwwD9ubzV27h5X3czaiEHJhYsX
 nek4/lDKH1jb+3ZPQVL+YpU9nZcZ2fNRZ5vYqOQ7W8uCOorbYhTKbhhChGe0tazOOomx
 7mGNmDkJ9NyXBTccrWk3vozfs/7sw/fYyva1gxShXsWfekPSvIjqFI9ScxyIzKpQMFzF
 5x0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687256702; x=1689848702;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e5OEfbuuH8T9Dcj7iOcZAlKmwpUl+YWfTb2WCDK4aiY=;
 b=XG4ghnI0+zJxxNzpwsf5l4zHJA1MFFACtXxsnWbJ7+6Uk8YN3mTCAVLvZszet+7VsJ
 VKM1+H5SUOdrA5TVExi5GwheqX5BThUtXcs9qH4BFLeHJAwv0V3OKjrPuwY5Pi5hfMfD
 IADg19jcGrrGnyyG+k4uDdUy3P6Y0/coc7Z6wzUzEemEPU2rf6+kD1zgcSKo1iMv9u9h
 T7uFffD8s58s8FzKiikIOlSBzKtMaoju9NRe8n5LeX4tR+jqNbYgXCAXYlTryJfRWxia
 LNHtirNedbuhlB96V3jpwegIFvqM0Ph6sEtmpGnTyPybFNT67emxRJThtTya5ExVyo4E
 7++g==
X-Gm-Message-State: AC+VfDzemqnWnA/7fXxuVVEtDjzsGIc0vjESvveR1akfKAPuoJewVIgI
 XrP8opaMKuDVFHPEIQebn4Yd/w==
X-Google-Smtp-Source: ACHHUZ52TjPMigJ50JNXAtFQ3bp9hfv0SomodjmMlvxcAEb2APYNAWEqJCawvLiu9Mpg8H54AW7fSg==
X-Received: by 2002:a17:906:d54b:b0:988:6041:dd13 with SMTP id
 cr11-20020a170906d54b00b009886041dd13mr7218023ejc.37.1687256702617; 
 Tue, 20 Jun 2023 03:25:02 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a1709066b0900b009829fcb94fesm1127967ejr.37.2023.06.20.03.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:25:02 -0700 (PDT)
Message-ID: <0244c5da-e901-e456-3e6d-102dd24c41a9@linaro.org>
Date: Tue, 20 Jun 2023 12:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 15/34] target/arm/tcg: Export some generic vector
 helpers
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x633.google.com
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

On 6/19/23 17:54, Philippe Mathieu-Daudé wrote:
> We want to extract gvec helpers to a new translate-gvec.c
> file. Some helpers will still be accessed out of it, from
> the current translate.c. Expose their prototype.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/translate.h | 5 +++++
>   target/arm/tcg/translate.c | 8 ++++----
>   2 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

