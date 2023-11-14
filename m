Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E84F7EB651
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 19:24:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2y4F-0006P7-Dk; Tue, 14 Nov 2023 13:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2y4D-0006NP-GK
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 13:23:17 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2y4B-0004MJ-Jx
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 13:23:16 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc37fb1310so45301315ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 10:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699986194; x=1700590994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J2aUEChBwPTrdVgaxT76vdc0JWm1I1fUDdabRABMEv8=;
 b=MIUcN5/vDQWr0NL3zK8MGRUjb7qeF8YGlAB7mm1jt+2fUFniX8P6OG27Wv1EVaUihW
 QdFaV4ZnIwxjj4QNZMajLqepfABtgum4MCr2GyRL8emjDPBL33/mCxd8aAWNOm/JmXad
 QDxmNfzBLx/q/A+gaRSUestfzC2v57DCSqOG54O4OUdVj1FAlr941aG6aLjGquvEYZo8
 2nGOIph9wfLOpmnqYrVMvrts65vXbSV80tKQMuF67XEFpNKLrpQRICWaAMyb44EVzO+v
 sJymhOtcf2Ir6GIb8wHDSSuxhzWmnjWENHGAAa3eVEpT4Yw+Jk94s2UeU5DbNo5HH7/D
 2TMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699986194; x=1700590994;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J2aUEChBwPTrdVgaxT76vdc0JWm1I1fUDdabRABMEv8=;
 b=OjcLGK5Vp/EjHpwHl/6+YQmYy6P4DPE0vgxoAosaG76VaX/0fxkTtMWK+s+EJNiJqe
 /OgcAlbk9RNXUePsIcmHKK0BHMbuCgolwp25hH9vVPDY8eWGOB7kzKgOELpjzQHfUd0x
 miAWU8sXpKd/xPvkTxoAjybZYw11pTm0JvfwxTSYk9b9cT/TRM84TFI/hBFdgJIY87/b
 N0II1L0bhGdKbJM57/8COeVEUwQA7g/gwTwqh9qojMQGtOo3YEFlgEaUtivIS629VCiu
 a1IT6PYzbc2vQQcLWd9cnGNaCRyRknNvSRxScR/cnxzmQ9fNcGMn6hE5Yu/p2z/fSAqY
 GEpg==
X-Gm-Message-State: AOJu0YyIGRU8zhwMQoygPZ33CX2WXzAl3gNk7EtJm/2ejU2jDCNwwbDA
 guparzL/82MOtpdGI0qZxIAOvQ==
X-Google-Smtp-Source: AGHT+IG4lZ3AuKyibFMeAx6yBePVw77ZTIuTuSWivAbj1Wei4aulwvYkrU1HN27yFUET9t3pwH0lXQ==
X-Received: by 2002:a17:902:da8e:b0:1cc:47a6:12bf with SMTP id
 j14-20020a170902da8e00b001cc47a612bfmr3597100plx.47.1699986193681; 
 Tue, 14 Nov 2023 10:23:13 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a1709027d8800b001c74df14e6esm5941297plm.51.2023.11.14.10.23.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 10:23:13 -0800 (PST)
Message-ID: <f9f9291c-afcb-409c-bf96-ce840f9f36e6@linaro.org>
Date: Tue, 14 Nov 2023 10:23:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/arm: enable FEAT_RNG on Neoverse-N2
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231114103443.1652308-1-marcin.juszkiewicz@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114103443.1652308-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 11/14/23 02:34, Marcin Juszkiewicz wrote:
> I noticed that Neoverse-V1 has FEAT_RNG enabled so let enable it also on
> Neoverse-N2.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   target/arm/tcg/cpu64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 08db1dbcc7..fcda99e158 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1018,7 +1018,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
>       cpu->isar.id_aa64dfr1  = 0;
>       cpu->id_aa64afr0       = 0;
>       cpu->id_aa64afr1       = 0;
> -    cpu->isar.id_aa64isar0 = 0x0221111110212120ull; /* with Crypto */
> +    cpu->isar.id_aa64isar0 = 0x1221111110212120ull; /* with Crypto and FEAT_RNG */
>       cpu->isar.id_aa64isar1 = 0x0011111101211052ull;
>       cpu->isar.id_aa64mmfr0 = 0x0000022200101125ull;
>       cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

