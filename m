Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5694074BC78
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 09:03:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI1xa-0007E9-TF; Sat, 08 Jul 2023 03:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI1xQ-0007Cn-Lz
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 03:02:16 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI1xO-0003tH-TQ
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 03:02:16 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f9fdb0ef35so4319870e87.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 00:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688799732; x=1691391732;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z27sFwABe1Tr/gPTISDicXttjZCxJnkYwXLcnmmo14Y=;
 b=zEKthN5Y8ilkJwr/PvZGe2a7qw3di99w6uzyJLewE6K4MNYK3VvQpS5/nwLqKhWiej
 DchUDMT7MAqW1gojdSXeQBIz6SFKbhHEAHwPfE6BlojYc6UdfefAzxo4lj7aZM20zdWx
 4pp+ZUt5AxDjBGR3m3uZZXymZJw8Y29p7corhUROsqGT+t/WeiSa5q1q4blfEm4fLxv9
 Xy6ftYQYW51PR4lRJU+9l1FjLslPJPU8b5q4CmFsah53LKdkLno6L5BuQ9FpqLyrHvlL
 i3rTPYJEtO3GPPek4tMQuE77DfORtmY2QEPAZajMJ61h5aQ38LstbFmRwGOfscZOL8/h
 HG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688799732; x=1691391732;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z27sFwABe1Tr/gPTISDicXttjZCxJnkYwXLcnmmo14Y=;
 b=BDxf2mMKjeL1H50mpZcwmgeBcQNUayfHyT8SpT1lMw8xWbYU1JQIsV4YVsZoJY6y7F
 Lqx6cBcRoFxda6bPagj1LY/2p+Hb8ziS+TjBMZ8HxHHvbnpcd1YM693hB+9CBcjCzgm2
 UVvzAsI5oz664caHvVM6uwBywjU8wO0+wDfCUThX5qA90uCUr28xQ38WPH+rx5Fep7r5
 255TKhPRQJV7JOcEokujCjQ4JJ2gelo0OypI92peKbR1b4sBtxlFZNCC1Pl5xHXWR8U9
 af5qk8tTgOdwF/oLx5WhNUP3xH12zPIXlYT5crPlxiXtTf7BHv7ff0S7r61LbcwrKi3W
 A3FA==
X-Gm-Message-State: ABy/qLYYTT2hvm9gq1B7ZHi4NSYYSljC4+sJNlWEN7ASZ57NgEYLbvOY
 khSCHmDSpNfTGkym0mPZVEKoojhqQ81PKpBAr4Iulw==
X-Google-Smtp-Source: APBJJlHRCm+f4hoHGkpvh4Aqoc7czghepvaWcLtXBNAIm9goScNMk7m9N3WRE95VhdxqAZocSCtRlQ==
X-Received: by 2002:a05:6512:3b1e:b0:4f6:3677:553 with SMTP id
 f30-20020a0565123b1e00b004f636770553mr6414423lfv.38.1688799732318; 
 Sat, 08 Jul 2023 00:02:12 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a05600c280400b003fc07e17d4esm529905wmb.2.2023.07.08.00.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jul 2023 00:02:12 -0700 (PDT)
Message-ID: <14593a2b-93e2-929e-98de-0868c5c05830@linaro.org>
Date: Sat, 8 Jul 2023 08:02:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 23/46] target/loognarch: Implement xvldi
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-24-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-24-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x131.google.com
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
> - XVLDI.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/disas.c                     | 7 +++++++
>   target/loongarch/insn_trans/trans_lasx.c.inc | 2 ++
>   target/loongarch/insn_trans/trans_lsx.c.inc  | 6 ++++--
>   target/loongarch/insns.decode                | 2 ++
>   4 files changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

