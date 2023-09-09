Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD139799A0F
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 18:43:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf12J-0000AY-UP; Sat, 09 Sep 2023 12:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf12H-0000A2-Gg
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 12:42:17 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf12F-00033F-85
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 12:42:17 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5657add1073so2040241a12.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694277733; x=1694882533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EcMiP7Tbx2CZY/5ppP5XQURC+CcP/9A8mvjU/2ZIuTQ=;
 b=CQJenVig/h39ooQHWcmbOzLLjVbf9qf/1dMfdTOP7iDOk7wy0fQnT8DYaFg0OTn2k1
 DUTXkzFzEUtDM+FtTslGacQ5rDLcAGRLs0+yjHN5obDcfu6pvugNPKfNNSnE/AW0YHBq
 SKE54GuznEygUdM8uTaR5WZrWs0KCMU7DSXpCq5n/WgBqbcGf8tGolYq3RbhB9NzObSf
 KWfSqbMW+tDRk7x+d6N133bVi+L2Xc5x+TIjZOhSmErQXF7tbXLJ859rU2SkhEbDsHLW
 fFlBqHM4KLcOJA6wa0esL9KT0UU/vZ5lNAQfNjVurPoxOZqOKXwAMfQLtIGZfcDIvMhu
 d6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694277733; x=1694882533;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EcMiP7Tbx2CZY/5ppP5XQURC+CcP/9A8mvjU/2ZIuTQ=;
 b=ozdtlSgbdUAAu+dDzdGtSV59vgFFYKBkSN0AovsPeyde+KrTkjMBn/EGXSNYp8tWw5
 JGi3iQEerh9qlGIt9q3sDIfaQT3Humxq24eCS6wzW0EqIkjHrpxGj90fTVkrS0Jdzari
 sCEnDQw1GTsryMW1KDQlAPdrW3zVIoTPeWwd7Nm+0EzNOjSzlKCL7NKtu5HN95ih+FPY
 R/MCmP5l2G4DKl072nsVmGz1FQw/5TFyy8jA3m+Eux/R9dz3G/pRwfyMZv4Hkb2JqlHC
 AEw7Wn0uDrJFUbe9j+FLWfwmgC2jqwn7OlqnmFAN0l6xpnkuGgihpgAa3GXl6VysTNh4
 FoaA==
X-Gm-Message-State: AOJu0YxzUMxWXUaSPr0BrIfsVIm2qX+7ZxQyC1WTrbgLxlPIVA5Jy8zo
 hWq/IGbVVazvpfhkLCu/Y2JYGA==
X-Google-Smtp-Source: AGHT+IEkYCZwlHg8XYJTXe4O1otJDhHM3GkffaUFOJwKsqZSwrFvvb3GYLlbOxquTphMK9BFtmMd9Q==
X-Received: by 2002:a17:90a:9ae:b0:261:2824:6b8c with SMTP id
 43-20020a17090a09ae00b0026128246b8cmr11731055pjo.13.1694277733106; 
 Sat, 09 Sep 2023 09:42:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y2-20020a1709027c8200b001bb8be10a84sm3443901pll.304.2023.09.09.09.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 09:42:12 -0700 (PDT)
Message-ID: <183c67af-4a96-176d-cb5f-9541a5d90de1@linaro.org>
Date: Sat, 9 Sep 2023 09:42:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 12/14] target/arm: Implement MTE tag-checking functions
 for FEAT_MOPS copies
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907160340.260094-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/7/23 09:03, Peter Maydell wrote:
> The FEAT_MOPS memory copy operations need an extra helper routine
> for checking for MTE tag checking failures beyond the ones we
> already added for memory set operations:
>   * mte_mops_probe_rev() does the same job as mte_mops_probe(), but
>     it checks tags starting at the provided address and working
>     backwards, rather than forwards
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/internals.h      | 17 +++++++
>   target/arm/tcg/mte_helper.c | 99 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 116 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

