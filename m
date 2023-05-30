Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E8C716373
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:16:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4073-0006Yy-7S; Tue, 30 May 2023 10:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q406p-0006Qm-DJ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:14:00 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q406m-00079z-TZ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:13:58 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d5b4c400fso5034760b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685456035; x=1688048035;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rK1Ae2nwuSyhjMaaI9DJGs+cUdGvULf1dL+Wo9d/36E=;
 b=G54vVlSO752zlAfeW/iU60jerS2vajJBgxgjL3gSPc62uBLdU2yY+pIMkk7Za9WApH
 mYKUzl7L+h7RYcq8vQy001vS884lCWgK2eHqcYeyZf68KFp44V7AyZHBM9Z3mZw5BWdX
 XVgOtFRIED+qkFGPRBTbVcDV8YXNvdGEM4dAtdXQqr+HlcHWkbjXS8697Z10GkUDwvYm
 f01ee50N+SmIkaen7JyMXFxIkZI3BYMtoSF6iLCIAMKVboyO6ld4fwq6FJnhoj5RpIqW
 L3DUZz1Bju7ETxvDLQLXT/5U0a6mBGFF3vu3xIe2z2xiBblmCt1y6pcdHWqpevi6TdJu
 RHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685456035; x=1688048035;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rK1Ae2nwuSyhjMaaI9DJGs+cUdGvULf1dL+Wo9d/36E=;
 b=RShq1OCD/DMPHplYSkxojkcI9e5MsQQbtdFTqMg+rSKBdO/CSVnnDnYrVtDuNiVE6A
 a1uKNfTiZS0BEPcwQ0A+Geid9NKxEGbAt54LatHX4CF1h2YBfRej3CVcIUKncOyj1ya+
 iQ32mOO3FiZDuzQ/D0cJD2o//qLtzQZuDF788vu7Cuz1UiiHLb09fOEi1vQTknMvTTn5
 0W7gyI7kdrX23U9meCp+Tvk6jKdymtkPa29O6BynqOti/wrPSoXeGDalbGb+YoSQ3p2U
 l6Na96PXumiKwl3EITnncPZfVWjU83AmcBcCGj923mySsAWAr8PPo38H0v5MaiMlIMrJ
 yClw==
X-Gm-Message-State: AC+VfDxoHQoHCMjqi5jP5x5xp/f3yxtCOSODNbn4zjhvoXyv5B2FAUql
 mdfQnvMA0oEno/7/a18q5vnIgw==
X-Google-Smtp-Source: ACHHUZ6XpGLWCvWLR2VqFwKPhn6SqJli7Yj7P9ej3TAXv9qN9O3hg/nnVrnrsvF3aZPP/3UZUcU0Eg==
X-Received: by 2002:a05:6a00:21d6:b0:63d:2d7d:b6f2 with SMTP id
 t22-20020a056a0021d600b0063d2d7db6f2mr2347665pfj.4.1685456035095; 
 Tue, 30 May 2023 07:13:55 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 a25-20020aa78659000000b0063d3801d196sm296480pfo.23.2023.05.30.07.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 07:13:54 -0700 (PDT)
Message-ID: <78a87b8d-a889-fe3c-e807-84cf73c51a9e@linaro.org>
Date: Tue, 30 May 2023 07:13:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/21] target-arm queue
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 5/30/23 06:25, Peter Maydell wrote:
> Hi; here's the latest batch of arm changes. The big thing
> in here is the SMMUv3 changes to add stage-2 translation support.
> 
> thanks
> -- PMM
> 
> The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d89ca95e43:
> 
>    Merge tag 'pull-ppc-20230528' of https://gitlab.com/danielhb/qemu into staging (2023-05-29 14:31:52 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230530
> 
> for you to fetch changes up to b03d0d4f531a8b867e0aac1fab0b876903015680:
> 
>    docs: sbsa: correct graphics card name (2023-05-30 13:32:46 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * fsl-imx6: Add SNVS support for i.MX6 boards
>   * smmuv3: Add support for stage 2 translations
>   * hw/dma/xilinx_axidma: Check DMASR.HALTED to prevent infinite loop
>   * hw/arm/xlnx-zynqmp: fix unsigned error when checking the RPUs number
>   * cleanups for recent Kconfig changes
>   * target/arm: Explicitly select short-format FSR for M-profile
>   * tests/qtest: Run arm-specific tests only if the required machine is available
>   * hw/arm/sbsa-ref: add GIC node into DT
>   * docs: sbsa: correct graphics card name
>   * Update copyright dates to 2023

Printf failure on aarch64-macos and cross-mipsel:

https://gitlab.com/qemu-project/qemu/-/jobs/4374716505#L3662
https://gitlab.com/qemu-project/qemu/-/jobs/4374716612#L4963

../hw/arm/smmuv3.c:423:23: error: format specifies type 'unsigned long' but the argument 
has type 'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]
                       cfg->s2cfg.vttb,  cfg->s2cfg.eff_ps);
                       ^~~~~~~~~~~~~~~
/private/var/folders/76/zy5ktkns50v6gt5g8r0sf6sc0000gn/T/cirrus-ci-build/include/qemu/log.h:54:30: 
note: expanded from macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ~~~     ^~~~~~~~~~~


r~

