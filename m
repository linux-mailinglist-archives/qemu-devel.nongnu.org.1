Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C0C81F374
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 01:43:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIeTX-0005qJ-FT; Wed, 27 Dec 2023 19:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIeTV-0005q0-MX
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:42:13 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIeTU-0005OP-5s
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:42:13 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d3eae5c1d7so23607375ad.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 16:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703724130; x=1704328930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NT5Q1fK6GV6MyLjZ4T9sXMjlwRF+piKN+7u4Jl4Q3cc=;
 b=nBw3KTDTaKc1yIQDcNLZuRYmkE+FY8teG4lkPSErv2LZ/ROK/k/MzzklEhugjDioQ3
 HBHV8MW1ccW7Us5KswXtS0Px9fz7uHOLGt36KfP5uSLUoQ0e/mkolmaaPzMVE7n06oXB
 Ng1aFTtp9enh4P+k6zWNJVprEH2/XSVGtN2SPJBTxXfuiv4QaHAfCgiRaMDDCTw5TbP1
 efexHuCHJmLj55wrQ+0inrnicaMUYRi0RugBcOLj9lpptwE45NUjc+TA7PznZVcPZlb6
 5zAZgYs6sM7Le8NHpPtR7nfrCu1s2iTB/o5xg+4xId5n53BD456AyvR3ZIGAVuvHD4vO
 qrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703724130; x=1704328930;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NT5Q1fK6GV6MyLjZ4T9sXMjlwRF+piKN+7u4Jl4Q3cc=;
 b=JhnxGP7PmviNKFXbdw1p3Pmna3vjO0oq8MNsoYfyCbHzlyCfsbdcctRU93tifCC8rP
 jHKDy1YnFbwRg5XjRTOGLl7owUMdzlRVPUQFzxiUd8USemP1bFDL3VCt/X1KOUWp32jP
 nAzZO9wu7REHtB31XgGZgO6uUVtuziJckf4QBd5zYzEAg7wTA4UckiduFLSYmqKArREB
 bbt+RicavAez/A8Cyl2CK2n+4muBUbnJAlySoE26ufFrVFHWnC24gseXsZ1RqKv1qvRd
 efTxRYBwH63fnb78D6oPEmwzbAeFEYCG1bHzhx5slMBbgVFC73m6TgZ9WVW+4qxQDiZT
 gKPQ==
X-Gm-Message-State: AOJu0Ywc1F6ZjJvWgt4JJQrQ+kcKonFSmbKZOlvnnasUv1RSyp/dawwi
 V2zacgjkCcu1hxDyNXD8OYta40SQ4VqTxg==
X-Google-Smtp-Source: AGHT+IFmp4OoeWlKqlXJFcP+7SNqc5XdUn4KaNFand4LkMGV1JrfDpbt96fmrMYEXr8+GreUaa2vyQ==
X-Received: by 2002:a17:902:ba81:b0:1d0:c986:8aae with SMTP id
 k1-20020a170902ba8100b001d0c9868aaemr4037172pls.97.1703724130266; 
 Wed, 27 Dec 2023 16:42:10 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a170902db0a00b001cfcd4eca11sm12572426plx.114.2023.12.27.16.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 16:42:09 -0800 (PST)
Message-ID: <bf5e3af4-75a0-4398-8a54-eb8bdf641eb6@linaro.org>
Date: Thu, 28 Dec 2023 11:42:05 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/35] target/arm: Mark up VNCR offsets (offsets
 0x100..0x160)
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-30-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-30-peter.maydell@linaro.org>
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

On 12/18/23 22:32, Peter Maydell wrote:
> Mark up the cpreginfo structs to indicate offsets for system
> registers from VNCR_EL2, as defined in table D8-66 in rule R_CSRPQ in
> the Arm ARM.  This commit covers offsets 0x100 to 0x160.
> 
> Many (but not all) of the registers in this range have _EL12 aliases,
> and the slot in memory is shared between the _EL12 version of the
> register and the _EL1 version.  Where we programmatically generate
> the regdef for the _EL12 register, arrange that its
> nv2_redirect_offset is set up correctly to do this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/debug_helper.c |  1 +
>   target/arm/helper.c       | 22 ++++++++++++++++++++++
>   2 files changed, 23 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +        /*
> +         * If the _EL1 register is redirected to memory by FEAT_NV2,
> +         * then it shares the offset with the _EL12 register,
> +         * and which one is redirected depends on HCR_EL2.NV1.
> +         */
> +        if (new_reg->nv2_redirect_offset) {
> +            assert(new_reg->nv2_redirect_offset & NV2_REDIR_NV1);
> +            new_reg->nv2_redirect_offset &= ~NV2_REDIR_NV1;
> +            new_reg->nv2_redirect_offset |= NV2_REDIR_NO_NV1;
> +        }

Could use xor to flip both bits at once.


r~


