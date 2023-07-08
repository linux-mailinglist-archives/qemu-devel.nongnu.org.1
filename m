Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC1574BC7C
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 09:06:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI217-0000k0-3f; Sat, 08 Jul 2023 03:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI210-0000jZ-8i
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 03:05:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI20y-0004Pz-Pg
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 03:05:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3113da5260dso2597815f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 00:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688799955; x=1691391955;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1qVkEwb6moWDUJ+ZW9wfwfaX3iBhCeIO0YiyVVFXkEQ=;
 b=owXoP0Kh/C1Odzbh9IN/ZqyIVToJYwfAsByYm7GQuXkQzSDPhAJUVD6/l90yvxUK0X
 DF4UQj3LGrFuJxHXWg18Sl7MPfiPRFZfZ/hehYYSXJB5lhjxy8XhLceDBakflgI6n2Lm
 KBbT2OVvBedZhJueZjmGG7SWa77tY/83AFZlkods4UVE1h5KYmS2dsgiEksUViBi60GQ
 U4yzLf7CwptfsvdUANNWu4BXlWceQuRmmXgKAZCSYfWR+LZWScmGfib6+6X8OB9NEziZ
 j49BL2DZZxBog2G3ZOLI9k9DCF1GE8dDWbd8vKejhBPJIn7SF0V7h3fR4E/qNlYdN6eE
 5IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688799955; x=1691391955;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1qVkEwb6moWDUJ+ZW9wfwfaX3iBhCeIO0YiyVVFXkEQ=;
 b=kBbaBy/hiDITirProarQmKVxCqq/r86eKBPquohUTw85hmA1SuS0rh24dnOsaJOPHI
 kz3GsS9o8cu9yuB6sw+bsEPqQRGF4DFeKzdP9Ihgt+oRaPwAsLuH3dklmV0Hvo8DvIoT
 KHSaitL/z2LOdg15+COXQRFNc2L180CAYHfcpYUCtOxg4oMUrm9rGwGvuKhuAfMqmzK/
 j0ls5yNpyXwM9peDGP/O6BfBZN07CxUSXOkkN64nYMZLNKI0TxsA0SV39jNqKKs7ETLI
 imaxKtpxH/cHQnq18IGWWAxddS/LyYzgzwc2cfxUOMY8zkNKJ/G5BQpjTB06ENaoEQT3
 mjoQ==
X-Gm-Message-State: ABy/qLaRmSzwOkMFAWrzfBX0sDa0wCEnNB6/WN+yzVJ2kC9oXfKBaFQR
 BurSHn+H90kPsPTsTzw/5nQIP9vlW2tDv8yo53Sb/Q==
X-Google-Smtp-Source: APBJJlGSQ1lflQ5eStydXO7NyhapprBX3ni+lCTgp1SaPE15U4lXyoNtILP536jDTk6hPcNj7ro9hQ==
X-Received: by 2002:a05:6000:1151:b0:315:8a13:ef16 with SMTP id
 d17-20020a056000115100b003158a13ef16mr2278143wrx.69.1688799955432; 
 Sat, 08 Jul 2023 00:05:55 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 a5-20020adffb85000000b00313e4d02be8sm6269277wrr.55.2023.07.08.00.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jul 2023 00:05:55 -0700 (PDT)
Message-ID: <c136b420-5ee1-064f-b04e-0b401d847f66@linaro.org>
Date: Sat, 8 Jul 2023 08:05:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 25/46] target/loongarch: Implement xvsll xvsrl xvsra
 xvrotr
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-26-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-26-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 6/30/23 08:58, Song Gao wrote:
> This patch includes:
> - XVSLL[I].{B/H/W/D};
> - XVSRL[I].{B/H/W/D};
> - XVSRA[I].{B/H/W/D};
> - XVROTR[I].{B/H/W/D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/disas.c                     | 36 ++++++++++++++++++++
>   target/loongarch/insn_trans/trans_lasx.c.inc | 36 ++++++++++++++++++++
>   target/loongarch/insns.decode                | 33 ++++++++++++++++++
>   3 files changed, 105 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

