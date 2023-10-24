Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2FA7D43FF
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 02:27:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv5Fa-0006bV-Lk; Mon, 23 Oct 2023 20:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv5FY-0006aj-Ty
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 20:26:24 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv5FV-0003cg-PV
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 20:26:23 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9d3a21f7aso32395485ad.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 17:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698107180; x=1698711980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gvVyGBM8T6J19KXSvJoJDVcHQm+/47YxyeikL42z7hc=;
 b=p9+CgfGhlpBnD4o10lp+ZeUZK33vBnOjee49YWRV2Y7PS93wp1HRYc11Lic+Glk5OI
 VYgWZB/kLaqEyzw2BfPddzc4h9f0prlY5FE7jTd2j4sgr2lTkGro8X1qUOuu3yMqqSAp
 aNWlQnFxeakM7cfqU+6rLOK3JzVsHT6OzYSTwZvRoCe9k4C+h6cHUV1vx2fbcB4QaDhk
 NMc9SNfFaJy8zxnv6MlcYiE/4fca9/1TJgzwkbsMlqbnNxLGfj3HU9/t7p8z+p/1awat
 1/TONnFU8QiMswM5eK8ORUJ2tHsu1lqxVJifuZf6Idtab73VdreyP0jQd6tp/v2qJZ66
 gaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698107180; x=1698711980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gvVyGBM8T6J19KXSvJoJDVcHQm+/47YxyeikL42z7hc=;
 b=NSp5phHvVs0EfT64luBN9jPmpQbsu7/rKd9Ajyez9L8n1DEdvucD/v9F7Yopm2RylV
 h3bT4/jXOUqq5UDnp9pUekHHtDNThLlM3AfvAB/7it98wT/38aCu1N/UJBxlTSmNlv7Z
 M+2cw6QA9E4ydByYj36vNq6u9XIGHUt72DIhaBhFcg2Mznt0wf6hGZDFURg2ZS2zVoWO
 5V6IjTexcxK8mWsKo2lW9X3HGEnosjCfSWZo0wD8ri2FOFKs07UIqLsXwcUf/FBk73+i
 h5i+qGJjlpKWWob77Tf65CzW8SZbBcDfvnv/e2ZxiaGI/ZlB5DZfd6Yk8rysL25iKvEA
 3TgA==
X-Gm-Message-State: AOJu0Yzuh8WDfBxCukful2pctGJJXR+pEeezyfT1BEmGbDRNQzUVcNKo
 6XUV+3fYTagYmlV5KwzbXU4KDw==
X-Google-Smtp-Source: AGHT+IG0A6sXduSr1MwmQPpw222loHCtZTt36ClEEF+PEAfAuRW/yL3kODCedkVpm751W24UsOjQ9A==
X-Received: by 2002:a17:903:184:b0:1c6:1bf9:d88d with SMTP id
 z4-20020a170903018400b001c61bf9d88dmr13454862plg.44.1698107180209; 
 Mon, 23 Oct 2023 17:26:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ix5-20020a170902f80500b001bb750189desm6513500plb.255.2023.10.23.17.26.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 17:26:19 -0700 (PDT)
Message-ID: <db537981-e8ee-419c-9bc1-d9092ec60deb@linaro.org>
Date: Mon, 23 Oct 2023 17:26:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/9] target/cris: Use tcg_gen_sextract_tl
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231023160944.10692-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/23/23 09:09, Philippe Mathieu-Daudé wrote:
> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC: please double-check bits
> ---
>   target/cris/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index 65b07e1d80..3a161f8f73 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -336,8 +336,7 @@ static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv b, TCGv ccs)
>        */
>       t = tcg_temp_new();
>       tcg_gen_shli_tl(d, a, 1);
> -    tcg_gen_shli_tl(t, ccs, 31 - 3);
> -    tcg_gen_sari_tl(t, t, 31);
> +    tcg_gen_sextract_tl(t, ccs, 3, 1);

tcg_gen_sextract_tl(t, ccs, ctz32(N_FLAG), 1);

Also, it appears t_gen_cris_mstep consumes CCS without making sure that it is up-to-date.
Edgar?


r~

