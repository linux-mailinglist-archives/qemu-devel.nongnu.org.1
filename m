Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 003D581F294
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 23:44:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIccn-0006zO-5K; Wed, 27 Dec 2023 17:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIccl-0006yr-AY
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:43:39 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIccj-0007WC-SH
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:43:39 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6d9b050e88cso680975b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703717016; x=1704321816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0XElOhpyqmy21IFqJpyfpjJnoAaHQngj9z1twuTv65c=;
 b=SDThEL1cB7f72X8+jNNvDyfyjOCKExu0A8KU7GXek/iiwojBqSAgM9zxW0+q6sfib4
 W2DYV+CSvvs5Ur57C+admET6Yyj5re1qXaFL/Djp4cN8noEbnJYFx/FtDB2Myahy1hPF
 Bwem4juyBhvXCQC+nFBi/BeNQn19M7+fsRKWa6r+x01DysFTl1xTIN9kCFFOzhIhmyhk
 TPVNkj09EmbQac+kTWuuBm3lrhzd4H8gamnMuy1NgWl8KDdIdzf4wnxOiK9mf/em7pnv
 3Doknz2+taqL50rBpIeHl1IDA1MMxC4CV29uPNWNBj2K/WOt6zKiDqWKM/oO49dMy+fK
 sUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703717016; x=1704321816;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0XElOhpyqmy21IFqJpyfpjJnoAaHQngj9z1twuTv65c=;
 b=vHDSyVEvRkW2rqW57/ClaMeuOEMda/U4BwniEn+QUm34d93qlMnX7AdzmGiSVgt/zJ
 9dQLQopc7NMhohqgofyr8y8tG0WJcLMmKhaVk3Fme96vHDoUHH1eq3JmrbZlhaYrp/KZ
 maOLPEM5RYIG/D0p0Kb1EnB8Pdx+W9h65+rCnAgf8WE3h/dqo3zFujUsO5Yz0Nmtrw6G
 3mpm+2EphrBDobo0EL/vhaILx7FXvJ1pJeKV1kAx1Z4aBoUIfh1r82Wg7QFKOW3tpjgq
 zLAMb0WMIAbPtzgYg08rKdB12kvKS4CKuhycLuVehz1ijldEjy7A17+Sq325yb2wJaQj
 qc0w==
X-Gm-Message-State: AOJu0YzbKqw38T9ceziHXHUSxe2DmmmOmLUmtzg6VfAGeDapCIdYIFK/
 40El+dPECz6Cm1zEoWhhS/QdKTskOL9AG5bzvRRHf70IK5ultA==
X-Google-Smtp-Source: AGHT+IFAInfdZNKIuNvByCbTTIVU9cbEhrD9TEurakU+UEU5ji5qMSg/cSyK5gDYb1C0KB6V/TlpBg==
X-Received: by 2002:a05:6a00:2d1a:b0:6d9:b569:baba with SMTP id
 fa26-20020a056a002d1a00b006d9b569babamr2572971pfb.61.1703717016453; 
 Wed, 27 Dec 2023 14:43:36 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a056a001a8a00b006d99cd6ec89sm8403478pfv.185.2023.12.27.14.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 14:43:36 -0800 (PST)
Message-ID: <b41279a0-103d-4d4a-909e-c055b63f8f6d@linaro.org>
Date: Thu, 28 Dec 2023 09:43:33 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/35] target/arm: Set SPSR_EL1.M correctly when nested
 virt is enabled
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-16-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
> FEAT_NV requires that when HCR_EL2.{NV,NV1} == {1,0} and an exception
> is taken from EL1 to EL1 then the reported EL in SPSR_EL1.M should be
> EL2, not EL1.  Implement this behaviour.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

