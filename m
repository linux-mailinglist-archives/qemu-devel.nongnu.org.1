Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF2981F27D
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 23:32:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIcR8-0002fo-9I; Wed, 27 Dec 2023 17:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcR5-0002ex-7n
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:31:35 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcR3-0003RI-Hk
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:31:35 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d2e6e14865so26036495ad.0
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703716291; x=1704321091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FsZGIWeG2hw9IGXz2FNwqsrVLiylnT9+GDPK4wVWU2E=;
 b=yk74IZJ3ib/Qvpu/VdRMLnhmltu92O+dSr0kJ4GkLSaQSRuR1xzPrp1cqpu25fNLVh
 LYcWAsj582RHjwklldvsYaHxnIxnBkgSfoEl7Zi1gzPzictOP+tQb3T+Ul2Q3evOOibE
 Lt9DMB4erUejRSnUKtnq+spbpaTJg7lxLwOwN2iryrZmeiINTjkVyDvMLSDhNMkZcgIU
 FwHQdqnE5zNPRRiLlPOPYWg9bSzrPFQM0+1uq0GbXK9oinfuvowFO96UvpCXZLyEyUHf
 R7ReGrlt3RZ0fihOPa9nbtkvRX2YU/atvG3JvlZ+ybkpl1GqPl++NeO34c9fuef7G76Q
 0mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703716291; x=1704321091;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FsZGIWeG2hw9IGXz2FNwqsrVLiylnT9+GDPK4wVWU2E=;
 b=MIZdLUlYKP73wAOEfIC+2P+uDXpoqAFTFjPsoHbEMUUsBSMzeHOZY7WRNBVApfgzyi
 BZSHg83rgoBb72m9gl8RlonoCYH+4tWjCoPPL+UkGYAOdRHYTcmitGBFreKXlX2dHkn7
 q8IJdQ1sJQIfpvYRn3iZhg42+WnUwGXONcUHkSGsn19GW4XhPHr8hw9TAZhfLJQ3dNaK
 YiDRMWb3up0G/rksTVbzctlY23GzIcBtBit3aDmHb8A/5x1aiE+8yfxZqk9PU1voDKH0
 AHZbbCbeJkG22y5ExIpBs9A3OPJ9CgFY4imNajqUDbyn1yx6I3luAu021tq6B3o4To09
 PjCA==
X-Gm-Message-State: AOJu0Yyt/a274GFl8TQh130SBJUZ+7DkYYTN1AmaRWbKMjIfAGxJaqoQ
 O3UwLCtcnZf/A439gzbhiI5CRCntQmBCiA==
X-Google-Smtp-Source: AGHT+IGTeFSBdFp37mjeBe3lnRB5i8dhYvh9yoBRIGqTFnCLohxY12b/iqQ45zVWOTpwV26LW97asQ==
X-Received: by 2002:a17:902:6e08:b0:1d4:6de3:15a7 with SMTP id
 u8-20020a1709026e0800b001d46de315a7mr1467142plk.110.1703716291603; 
 Wed, 27 Dec 2023 14:31:31 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170902e9cc00b001d473e4f451sm3618340plk.201.2023.12.27.14.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 14:31:31 -0800 (PST)
Message-ID: <69462f3b-8129-4c83-9c1e-4fba96f2dfa9@linaro.org>
Date: Thu, 28 Dec 2023 09:31:26 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/35] target/arm: Make EL2 cpreg accessfns safe for
 FEAT_NV EL1 accesses
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 12/18/23 22:32, Peter Maydell wrote:
> FEAT_NV and FEAT_NV2 will allow EL1 to attempt to access cpregs that
> only exist at EL2. This means we're going to want to run their
> accessfns when the CPU is at EL1. In almost all cases, the behaviour
> we want is "the accessfn returns OK if at EL1".
> 
> Mostly the accessfn already does the right thing; in a few cases we
> need to explicitly check that the EL is not 1 before applying various
> trap controls, or split out an accessfn used both for an _EL1 and an
> _EL2 register into two so we can handle the FEAT_NV case correctly
> for the _EL2 register.
> 
> There are two registers where we want the accessfn to trap for
> a FEAT_NV EL1 access: VSTTBR_EL2 and VSTCR_EL2 should UNDEF
> an access from NonSecure EL1, not trap to EL2 under FEAT_NV.
> The way we have written sel2_access() already results in this
> behaviour.
> 
> We can identify the registers we care about here because they
> all have opc1 == 4 or 5.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/debug_helper.c | 12 +++++++-
>   target/arm/helper.c       | 65 ++++++++++++++++++++++++++++++++++-----
>   2 files changed, 69 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

