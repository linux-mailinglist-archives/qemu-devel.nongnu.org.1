Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC81881F26E
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 23:26:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIcLN-0001Jq-KN; Wed, 27 Dec 2023 17:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcLL-0001JN-LQ
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:25:39 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcLK-0001qQ-5G
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:25:39 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-28bd623c631so4650410a91.3
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703715936; x=1704320736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AiGY0kPtwxFTxGkksWurGE880lO3T2ZhlpMNHkb3vJc=;
 b=QWJTWYWC6YHmqgBMGYejCFwj2/unx7Zlgoq9rdMuIL+hkFgcLzfNh1CNs44mJWx4Yf
 T+blWVNHRmQ7xzMn4Zzu/MZpdfztZoMYXtl3DDrmjBtsDqOf/YPAEfUI8LtloPCBfJvT
 Hw67axy5BTwu31CN+eVEcUm7WFAuJwWAUcpTXSHCuUkXBawMX+dTbMzTwJw9uuJXjps2
 2oKvCXzKZtnVISnXo3uSH7gvfQ1imDw6AMJhE30+QY59qQOF4b3oUoubKqnaNaWv5K9y
 CEpgUy4yrw/FHRNzbmYu1ucAqYvo5pAVDHTAAuOh473y+37om5X415eDatsmdItfuAFZ
 KCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703715936; x=1704320736;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AiGY0kPtwxFTxGkksWurGE880lO3T2ZhlpMNHkb3vJc=;
 b=d/PT/PzrnopEHXe5a8sBDhxb4PbOSoMP4IQTtHG4zWKVh3cUphG1Lw01kQI2jM8qkN
 6epOBYc6+WvbBFoM++P0rHGbLJ5LEN8N2a6pAyrircX4x+XMiEa+N0O+H1StNZuG0Kfc
 DZog4PfE1iO4dpMspI1nv6L/usYsl5RzHTID/axb4l26HZNR3waDgY4zzPH/DGDR+0IY
 MA/4T/kpFj2KuVQQVDCn3fE0GvHSDhwM+wHcCk9jZeWegnZyFuak9vTo+xHTKFLAIDQe
 Xq2zehstFstXjwsOMozYmQZj+hLiJrtaulBkr/wnHO/vyo0cdeD70skt5g/ji6PZw7B9
 pK7w==
X-Gm-Message-State: AOJu0YxhsdY9Im9y6Ztv5+aWINa4WOIwzEV3X07aW+tp3O7on/ctfOkH
 9t//vnc89S3NFQRa1mOhpjDBTdfrT3S9w1+mInAKX6Qd9hf37w==
X-Google-Smtp-Source: AGHT+IHHPw+Zc8KSZTg/MRT8pd4QGvzt8mczFB68V9oUEVNqIXKX8OqZdB8I2qNLjZde9BSxu2KVEA==
X-Received: by 2002:a17:90a:6b46:b0:28b:95f0:b6fa with SMTP id
 x6-20020a17090a6b4600b0028b95f0b6famr5311185pjl.28.1703715936559; 
 Wed, 27 Dec 2023 14:25:36 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 sm18-20020a17090b2e5200b002868abc0e6dsm17207121pjb.11.2023.12.27.14.25.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 14:25:36 -0800 (PST)
Message-ID: <994486ce-97d0-4194-94b3-2095aa4a1e11@linaro.org>
Date: Thu, 28 Dec 2023 09:25:30 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/35] target/arm: *_EL12 registers should UNDEF when
 HCR_EL2.E2H is 0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
> The alias registers like SCTLR_EL12 only exist when HCR_EL2.E2H
> is 1; they should UNDEF otherwise. We weren't implementing this.
> Add an intercept of the accessfn for these aliases, and implement
> the UNDEF check.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpregs.h |  3 ++-
>   target/arm/helper.c | 16 ++++++++++++++++
>   2 files changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

