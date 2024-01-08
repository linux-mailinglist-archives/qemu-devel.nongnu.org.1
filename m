Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FB8826F15
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:57:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMpBg-00052u-1z; Mon, 08 Jan 2024 07:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMpBW-00051m-PD
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:56:56 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMpBT-0007Er-3h
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:56:53 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3367f8f8cb0so1830575f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 04:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704718609; x=1705323409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F1Szk0h7YIyOnUKRSCOKIVxPUcBtgdQl+uheqjerzns=;
 b=nDvzY3yccy92qtXe3HbK5buf5UDIpPJcCn5aPfGZHX108i8ZsaWjBQS5ScrxG5/kOX
 CpzCnou0+cDx7LIIMhAxbJyMV0FDhO1AjqJvHmPYaUgcsLQ3grpaqM6GUz7IcWkvqkWc
 CKpxBdB3eeQ3z2HXPhEM8X7ABomqIPTtJCAX4goA6HKDIW0k82reTcZfMDAvvx+/Uiiq
 BMn84fDziIEUiUO0RB08fXEIfoOX2O/wF2qYl1zO31zmedhUfSIodFApPT558LZR3Bc/
 5zfvEzMq0unCehGziUDdld5YvR0zvJBC0xR+20iCXLJN1fy3BTCLl8TQPZhWEy+cKD//
 pMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704718609; x=1705323409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F1Szk0h7YIyOnUKRSCOKIVxPUcBtgdQl+uheqjerzns=;
 b=P8TNxDL+qUM1Woxw7DvxJpY0lm3btK964YRyEISrdvxCp4xZ/Nzuv//WezojK2wqOY
 iBeisfJOhLvEs3K857ASZpVhDcYhkxSepXd+RYg0gLr2SbjRbzQrvWGgJDCLMOOplkaJ
 ovSqM+Eg8WgzUwwGpfcxFEcJ9u8mezYseii3CFmWYDp+l+8KIZ3KKN15kAQu3xotjpmA
 eMuoZEUAVjUUhVV+rLAGB7JyRXF2OUd6UcMKsKHQAg6qo9ih5MUWRx7HY2wF83taLJNR
 lMtOn8OUXSd9quJHH/R6MNuGOXL6f7wbCC40VUTiK3RskbllsyPf28/RrD7PTyXMQJUC
 6fVA==
X-Gm-Message-State: AOJu0YwMztRG701qvNhuzdkVtudm07cwb6O8orTr7xsNiB+nyCwzNAIE
 2CLPCOg2pRtMVAYpSjQzl9Zuw+ZpbV96EA==
X-Google-Smtp-Source: AGHT+IHjJqcbaqi0OqD6LbG2ZX8wn8pPmpYVZyZocsTtL0vQ+KPXfIxyRaa30QLJevCP60TgrD7kCg==
X-Received: by 2002:a5d:4b91:0:b0:337:2c08:ae9c with SMTP id
 b17-20020a5d4b91000000b003372c08ae9cmr1642991wrt.141.1704718608864; 
 Mon, 08 Jan 2024 04:56:48 -0800 (PST)
Received: from [192.168.1.102] ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a5d5145000000b00336cbbf2e0fsm7749588wrt.27.2024.01.08.04.56.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 04:56:48 -0800 (PST)
Message-ID: <1c18863a-ecf9-4522-af75-793cd358c745@linaro.org>
Date: Mon, 8 Jan 2024 13:56:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: Don't #include <inttypes.h> in
 aarch64/system/vtimer.c
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240108125030.58569-1-iii@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240108125030.58569-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Ilya,

On 8/1/24 13:50, Ilya Leoshkevich wrote:
> make check-tcg fails on Fedora with:
> 
>      vtimer.c:9:10: fatal error: inttypes.h: No such file or directory
> 
> Fedora has a minimal aarch64 cross-compiler, which satisfies the
> configure checks, so it's chosen instead of the dockerized one.
> There is no cross-version of inttypes.h, however.

Presumably this isn't specific to aarch64 target, so what about
the other uses, shouldn't we clean all similar uses at once?

$ git grep inttypes.h tests/tcg | wc -l
       26

> Fix by using stdint.h instead. The test does not require anything
> from inttypes.h anyway.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/aarch64/system/vtimer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/aarch64/system/vtimer.c b/tests/tcg/aarch64/system/vtimer.c
> index 42f2f7796c7..7d725eced34 100644
> --- a/tests/tcg/aarch64/system/vtimer.c
> +++ b/tests/tcg/aarch64/system/vtimer.c
> @@ -6,7 +6,7 @@
>    * SPDX-License-Identifier: GPL-2.0-or-later
>    */
>   
> -#include <inttypes.h>
> +#include <stdint.h>
>   #include <minilib.h>
>   
>   /* grabbed from Linux */


