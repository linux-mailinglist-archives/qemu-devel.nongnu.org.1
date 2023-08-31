Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C9D78F625
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 01:27:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbr3u-0002XC-8A; Thu, 31 Aug 2023 19:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbr3r-0002Wy-SQ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 19:26:52 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbr3p-0002rI-N3
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 19:26:51 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bf57366ccdso17319775ad.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 16:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693524408; x=1694129208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d/Q24oA1helZ50+WtVKHTLHCS0EBRtv89JMoBxhQ0Lc=;
 b=ob+UWdaHPaVK+ZJ66341giQaAnrM/KXx+dRn7ExWXkhVukbDAvX345mMXgUDCSBKlG
 1OiS4k9I7Jp6U9MxXnrEqZmdHa7/Tr2sCEVzJIrKnlR01RczkmKCEgJEQOi9fzAdwUCm
 z6yWrPs7YU3oh1YT6amEl4OmdHiM/UXXC4dvHSGyHt0AS2KmKcFewpBkRxB0Irl+woNP
 vqTwsLI6OfmnHOebtOSvxaDw2ShMYp+HIw52oRE9fDwBVcLK9OUdeekng8BPkGuk80sR
 KYAh4ESjomkBKRn+KWQZy7Buk4437BJKvVwo104s/uo3unNhmm+jfTKBppCYLSaKusQT
 unvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693524408; x=1694129208;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d/Q24oA1helZ50+WtVKHTLHCS0EBRtv89JMoBxhQ0Lc=;
 b=Vb7BjltlTTiWb/QS0pVdqlKlY45koq1UdiladNJfv11nPTVlMhtiftJLm7MaeyxcyH
 lyPL4YkvkXaq2ws/kM1Jioa6QpuwMaGK4lwKQaG/U9O1dsDAG8AxJ3LY4A5kamAEoivn
 WO18w4E0NkSx1jbY9pgTPazfrLnm7REFR5yX7a0/wZ9V2NOh0b+ohk0RLQrBfF09k6El
 GoxFQ5wTS2beXrzuDU5kQz1zEmybBonTSCjT5l/lJSsQ9iOHxLL6bW18v8ZqWJ8O6hYl
 Ez7IYOJq1ERYo5q/zUUgs0lgbCRDKMKneWOVtb094sZhgLfOhZfqNeqgE1ivtligRUti
 iJPA==
X-Gm-Message-State: AOJu0YxK/k1XcPBSTfkTHH9k/6gz6n/az1WxMnk8tW70dQ0oxf7rj7KG
 b/qmOVYSObCnOLBxfIeq3Mt1MT9xsqdEhq/nsLE=
X-Google-Smtp-Source: AGHT+IGp1u7VacQsC+1UyvVYig3jY6Zhn/VS+vzVfVC3iiCxKakxTFnoqTIz9pugi8npzhLpqlMuPA==
X-Received: by 2002:a17:902:ab1d:b0:1bd:ea18:925d with SMTP id
 ik29-20020a170902ab1d00b001bdea18925dmr1085026plb.6.1693524408304; 
 Thu, 31 Aug 2023 16:26:48 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902a70500b001993a1fce7bsm1719531plq.196.2023.08.31.16.26.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 16:26:47 -0700 (PDT)
Message-ID: <9fa6450c-4133-ac8d-05fb-84f6430ae491@linaro.org>
Date: Thu, 31 Aug 2023 16:26:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/mips: Simplify Loongson MULTU.G opcode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20230831201140.85799-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230831201140.85799-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 8/31/23 13:11, Philippe Mathieu-Daudé wrote:
> Since MULTU opcodes don't record the most significant bits
> of the infinite result, sign-extending the sources make no
> difference in the result.
> 
> Once we remove the sign extension of source registers, MULT
> and MULTU are identical (as are DMULT and DMULTU).
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/translate.c | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

