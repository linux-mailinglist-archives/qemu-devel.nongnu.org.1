Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6FA7E2E7B
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 21:56:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r06dE-0006Ai-L4; Mon, 06 Nov 2023 15:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r06dC-0006AZ-V0
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 15:55:34 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r06dB-0002Z4-B4
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 15:55:34 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5437269a661so11766166a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 12:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699304132; x=1699908932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KGtnYj3nPwAa9YgLQ66CNdlqNxa7/TTMNphQ3qmiZg0=;
 b=F7Mv0EKkJ3gDlAWDkHlcvpWhf2vUGZbdybcfObo69zrNFpVg/p4Cf+xWJAAZyT6cnY
 SwEQ6xWlojP7TyL8bECyGcMfgqKwTUGcQjH+01WrzADSCLPLKSAPHbfATFjPgnTtS5IC
 +W3+wLsbBB72x9u1NFtr236vzBCJA3KlIwue1sK/RvIaBvzptN/sqh2H/Povwl99oUZq
 E0goKU2UM8W4DyubTQjtwhpTvHBId2GWw0fjuYvic5wA/fNGQ0mqtWp9Jgvr9jGBdSYk
 skPdxgTSCHxRqqz8F4JNBvfpgyKvUXHxYtibZCpRHj5Y+z6owPEzrPbQamHp3QsS7q9X
 H4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699304132; x=1699908932;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KGtnYj3nPwAa9YgLQ66CNdlqNxa7/TTMNphQ3qmiZg0=;
 b=Ji03tP5VVS7lkzMhM71z+A6sR07JO0SS78cnV+WVfOhG6JHQfoUEgP4AlDgosnRGrM
 /FejFe6sxsKO0N7h7++cKgLjAtRBq5aAKzhUV1+wnBH2L8Ueo6d1Tv4b6ciBgtvIoJBP
 PdB1Oky371yfbsV+J2CtkYrzRQ7V8ZxRSg1gcXUyGdEZeLwZDio8KfojDenXxS+RW3LQ
 zAHL+SWXhPXJr5mWnlNx6zScLbrAwoY7eDdOGeadQaKKcF+Uv28nyWhlkyDrz7rYgoqE
 hVZO6QbDlpEou/ineJEpkL8RTDBPPcMXsX3QbBauDUdlUfJT/wgr8qU/+QGoYcCOaH2t
 kv2Q==
X-Gm-Message-State: AOJu0Yxox6iewpUD+pXUAHZ88/nkND4XlL40i9bx9IdTGFV3kyj3T0//
 6h5QMYrkZCeaqoh+M+rIO/2sVQ==
X-Google-Smtp-Source: AGHT+IFniXlUB4O4MzXdtNs6M9sOT+S0mg8UgLvDb3lCYcL4R8Z4NMOEOnP0FN4FGIxgwVPCxhiJFg==
X-Received: by 2002:a17:906:b08d:b0:9c5:7f5d:42dc with SMTP id
 x13-20020a170906b08d00b009c57f5d42dcmr466146ejy.33.1699304131663; 
 Mon, 06 Nov 2023 12:55:31 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 z8-20020a1709067e4800b0099bd1a78ef5sm245251ejr.74.2023.11.06.12.55.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 12:55:31 -0800 (PST)
Message-ID: <2fa479f5-a223-4893-9499-29692c137f57@linaro.org>
Date: Mon, 6 Nov 2023 21:55:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/35] tcg/i386: Pass x86 condition codes to
 tcg_out_cmov
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-13-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

On 28/10/23 21:44, Richard Henderson wrote:
> Hoist the tcg_cond_to_jcc index outside the function.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


