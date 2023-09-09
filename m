Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B872799964
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 18:05:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf0Qz-0005AC-HX; Sat, 09 Sep 2023 12:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf0Qx-00059u-1C
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 12:03:43 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf0Qu-0004Ya-Lu
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 12:03:42 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68fac16ee5fso205988b3a.1
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694275419; x=1694880219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w7nWhNtsV3di0blxBdyHCDW/RE3siec7s2CQf2wEgmE=;
 b=Xv4Ofm9Z2yGvXJVlHMGFY8OsPdludU7JFaZcqMWPw+efUAkOHJoH0EgSNhAkeAMx3S
 ADFkZfiADbMAGm+X73hcYJrt0Vy49PRn8mSwwHulBpS1Wiuw1O82xte5zjpdgqd2UpdJ
 mWOQMe8bPuBSGwliqOh+ln5yHbR6vc/9/Ynbej0ZFIuICFB6BgVzTNDtbMP+qfmxB0Y7
 Xy6zXb3jPhE3EjX8MjGb06euqMkaiZb5msrBL0LgGzj3agUNiJPFplivKx6NwSO4P+/z
 sKfLS3MW8jTiE5hIK5KwPnA4SQ97H6SMeSKVQ9YV6jgMpxZ30hNpvPC2iBaZiZt12PYT
 BR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694275419; x=1694880219;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w7nWhNtsV3di0blxBdyHCDW/RE3siec7s2CQf2wEgmE=;
 b=RG5BDx5lgOzccZoWup9GLVwpD2PjZWOMbfK6IROEPk25Ms6BddgxjiUwS+HwlePSob
 gdn1N4Fpui3CdB7HXZ7nlH0s796HI2X50fg5amMcWEm9AEuJZe15lWatUvZF5Py+jtuK
 hEPJ1fj/SZF2OK0j+bRWnIcZ1GESBCRyV+B4vgI7msVpQNpFeFCmUQLrLsH112i9ypiS
 0i9+WwCHMZeATlLr7iH4/tH3tNdDymbz2wBsxMlQC5RNbi9iPrjj2OsTIiXJEU8iQdvr
 mh3c/BpO1ccw2fOqcQhPhAz96D6rhQJtdchg0mZpwuRgJxUUcEjjtbKa3xrSfQq5hNwJ
 Yhlg==
X-Gm-Message-State: AOJu0YwpqkFFqBlbf4vOxpEtLdwdZrhJB7iPy/lbJW1Ymqbo+Dg8w786
 xnjm5eCDi1gSpybmPXF51BVC4w==
X-Google-Smtp-Source: AGHT+IGaGYtsxW4cRxBXs8jPuLAOkr39Rgf3jUkh7UGRj6eICBOsX34nilQjpOjz5CvcweKOwL3qsA==
X-Received: by 2002:a05:6a00:4c8b:b0:68f:b3ed:7d4d with SMTP id
 eb11-20020a056a004c8b00b0068fb3ed7d4dmr554561pfb.15.1694275418905; 
 Sat, 09 Sep 2023 09:03:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 n24-20020a62e518000000b0068a4b944beasm2876187pff.78.2023.09.09.09.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 09:03:38 -0700 (PDT)
Message-ID: <183eb928-ce6f-365d-06e1-3eb21bddc9fc@linaro.org>
Date: Sat, 9 Sep 2023 09:03:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 10/14] target/arm: Define new TB flag for ATA0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907160340.260094-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/7/23 09:03, Peter Maydell wrote:
> Currently the only tag-setting instructions always do so in the
> context of the current EL, and so we only need one ATA bit in the TB
> flags.  The FEAT_MOPS SETG instructions include ones which set tags
> for a non-privileged access, so we now also need the equivalent "are
> tags enabled?" information for EL0.
> 
> Add the new TB flag, and convert the existing 'bool ata' field in
> DisasContext to a 'bool ata[2]' that can be indexed by the is_unpriv
> bit in an instruction, similarly to mte[2].
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h               |  1 +
>   target/arm/tcg/translate.h     |  4 ++--
>   target/arm/tcg/hflags.c        | 12 ++++++++++++
>   target/arm/tcg/translate-a64.c | 23 ++++++++++++-----------
>   4 files changed, 27 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

