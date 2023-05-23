Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC49170E1E2
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:37:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V0E-0001HA-5c; Tue, 23 May 2023 12:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V0C-0001GC-6X
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:48 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V0A-0001jB-MG
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30aa1eb95a0so783234f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859805; x=1687451805;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u5sA82GFdaRd2RCrmSkmUiD/deMdvk/FmzejcTdMfwg=;
 b=kElv8Kyo3TXP9bfW0Zb6m1c7NMZP9ftuPB9Lwzaz4vt2BrG8BY9XpOK+HopQgDW6B4
 jbUyI7Vc/3d2u7K1b0gba/wHoasSUf4jH6BYA9DcqZ8m1LCBqjyDI3J2Fwe32c/HM40L
 KDocizoFmM22GbIreDaulBLu28D0LTM76I2tgwOmRa2pngO3ACvd3Zr81GAwI8NivibK
 0g2iWdDlFfXnz1297zao4arrE41pNSQV4fF61y4lwRgoKf+QWEZXKGczVlGhAnOWqv6Q
 pKgmOu2oRIAXXpXmhuYGgAN1hdGFvQ0+CaAWgcyXBxEen3Aq4ps8O3GB+urRtdlAiEja
 witA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859805; x=1687451805;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u5sA82GFdaRd2RCrmSkmUiD/deMdvk/FmzejcTdMfwg=;
 b=MSjw5zMD+RLgMJZZv/bQSz8xJOV56wmoQbqqD9n2za8MwzPZPOZV2s7QeohpI0d6Ka
 Mu6lsMIqg80n5qchUNEYKMZe1i8bGrrhqE6VDA8BVd+klOtM1KRVHofhYXEdFO6lI2jY
 5zS6G0Jbqjdgy5SHBDDhFlfcAK4MMkDIHSivJMXjiSLgxyIxSb4DSpPfG4tSIvIO8dd/
 1Q5JBazj1+BIdQ4P1BMPcrlsCsIwL+KIDdDNoC5mEiVTM/TpD651JNEndu2Trn1skx5r
 Oex3d0v5UBQlami8fuqtdtq9Nbe/teKDRolQICgjCXPKNocTu0N696nuEudCmqNDsB2d
 vz4w==
X-Gm-Message-State: AC+VfDxmogWOjWGNYOvw2Fw8pG5xn+YO1DEDwLWNfVceoqf05LAzmjgd
 APYV7Whux9sCQsk0T4FJDR8KIPU/aWFimmVXlqg=
X-Google-Smtp-Source: ACHHUZ5e/8nSBX1PPpNa4ZA0s0fO9MRbW9Arp64DjM0QW03GaQtLPg4LyWXFmb/fN1q3I6MMiTrnqA==
X-Received: by 2002:adf:e405:0:b0:309:268c:73dd with SMTP id
 g5-20020adfe405000000b00309268c73ddmr10796892wrm.14.1684859805395; 
 Tue, 23 May 2023 09:36:45 -0700 (PDT)
Received: from [192.168.1.102] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 z4-20020a056000110400b00307972e46fasm9378056wrw.107.2023.05.23.09.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 09:36:45 -0700 (PDT)
Message-ID: <91095202-d5e6-ddb0-88e6-acb26c5e319b@linaro.org>
Date: Tue, 23 May 2023 18:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 32/52] exec-all: Widen TranslationBlock pc and cs_base
 to 64-bits
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230523135322.678948-1-richard.henderson@linaro.org>
 <20230523135322.678948-33-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523135322.678948-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 23/5/23 15:53, Richard Henderson wrote:
> This makes TranslationBlock agnostic to the address size of the guest.
> Use vaddr for pc, since that's always a virtual address.
> Use uint64_t for cs_base, since usage varies between guests.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h | 4 ++--
>   accel/tcg/cpu-exec.c    | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


