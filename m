Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C340736995
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:41:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYnb-00078N-Mt; Tue, 20 Jun 2023 06:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYnX-00071C-T4
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:41:19 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYnV-0004nW-8Q
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:41:19 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-983f499fc81so552680766b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687257658; x=1689849658;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l2B88WAxDKTAhmdEJd5y+99JCn30leL/D9HthiGd4RI=;
 b=XkaNEWZruAaMFG4PXvw6iTi4wUvFjPfHIxl9Cb6TXpBNywyqikDBxEGDITNPuxepJS
 pdTLPFlQDYOFwsOngHqNX1ICGnsgIYW7CgaeC7/y93J4JAQZTMs2RvgvBirEcABNz38g
 CX/bxKEvVHlQTcnQx3InxX2DrocxTxhf27rhpx9liE8GcZfb2d7EkyXOm4HvEZihvJTu
 8VF0PeRTNo6zdH2UVkHtd9l3duNer3oEyBMYtnoal4oP7e1I4Xn1IAPi55DUOoEzPAgS
 3IiEJCw/JDgFJ5CzG1bgVeSzLt5K1d2wtKqEtdnCQxRM2h28YS0NRGyhvdxONrSd6r8o
 AWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257658; x=1689849658;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l2B88WAxDKTAhmdEJd5y+99JCn30leL/D9HthiGd4RI=;
 b=Gm3uSix3I9CKkzMsbYWUoa1hdX0Npo4FSzo/Kd/bNPWB6yF1Fs/DpKu6Dzv3MYPjQV
 XFGvax43zUVWhE9zQk4lbKBDjrUlFYV3fO7aHd2TeTUSl1WzLF56cdV5i4Baj5Zw6cts
 z8svdJTLqBG+FN1KqwCkaXhVZEjyZp/V6tmRAG6Ntb+sU4w074C/N7WjSGluINQDg25/
 2LNjc5czSneikGkF/Ctn49C+wAxhMIKVWojyWDyWSQlG4MKxgEqoiu2EH1Oplm196U0h
 i43gEtfhgBNfCUFI/ZbrRpTc0dVYy1F0MqM1cAetMah3C1dwdcYlERY9QsnewzJz1tFa
 C6RA==
X-Gm-Message-State: AC+VfDzt/zBd7scqoQyBdgEpr045Db9XKfIYyWd6PMXgQLajNeZxSTlp
 8a95mMwoyZ/q+rfoimlWEfDSyg==
X-Google-Smtp-Source: ACHHUZ43kgMScfssFBLodIJRFVXmiWF0h7taa1SbhSB3aHp7/KHSHgF6MrYi52SCunARuTXCrh0nGQ==
X-Received: by 2002:a17:907:e8b:b0:988:9b29:564f with SMTP id
 ho11-20020a1709070e8b00b009889b29564fmr5763597ejc.40.1687257658644; 
 Tue, 20 Jun 2023 03:40:58 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a170906258600b009871b3f961asm1141363ejb.58.2023.06.20.03.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:40:58 -0700 (PDT)
Message-ID: <19a70379-f24f-6152-808a-139dbc1293b0@linaro.org>
Date: Tue, 20 Jun 2023 12:40:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 26/34] target/arm/tcg: Extract MemTag definitions to
 'helper-mte.h.inc'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-14-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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

On 6/19/23 17:55, Philippe Mathieu-Daudé wrote:
> helper.h is used by all units, but not all require the crypto
> definitions. Move them to a new header, which we only include
> where necessary, removing the need for "exec/helper-proto.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/helper-a64.h.inc | 16 ----------------
>   target/arm/tcg/helper-mte.h.inc | 23 +++++++++++++++++++++++
>   target/arm/tcg/mte_helper.c     |  4 +++-
>   target/arm/tcg/translate-a64.c  |  6 ++++++
>   4 files changed, 32 insertions(+), 17 deletions(-)
>   create mode 100644 target/arm/tcg/helper-mte.h.inc

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

