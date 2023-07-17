Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B82B1756CE4
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 21:13:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLTeq-0006u6-3C; Mon, 17 Jul 2023 15:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLTee-0006tr-U5
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:13:08 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLTed-0005n5-Dk
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:13:08 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-765a5b93b5bso456250085a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 12:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689621186; x=1692213186;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f7n2bV6G5U+HHeAQzNT/JYjWCaGlhoaCKVYZoYb59zA=;
 b=hrdk+1dWb99l7Aggm+yLErxmX3U5jpIOvOBrc3TO+1Bh3YnidObO1IxwW/Hsj/Y30c
 GufyzCxeZYMKYvZiUmpFtBBEvl/9OjvTtAVBNGfe6cQVGcXFfFyz9WLzxd/n0b30lEp6
 rdGGYO0wZcHbhc7/MhKrjjLxD3P8lNO/BvyipnZ6YZ/lsiEtTkRZbFv9wmhopaV5BiPq
 ahKl+issml++OdSrZC/fG+/R1Zx8vDN+XGuhRcdc6zfY7Pb/QioHyliGD8sxjua1Civz
 V1AKBPhOu7h7GNB2rigbLnaXmwNRIox4ipbuAUCSIQ6Ehk2NOy30yD9KCTSVsAspK6pc
 OSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689621186; x=1692213186;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f7n2bV6G5U+HHeAQzNT/JYjWCaGlhoaCKVYZoYb59zA=;
 b=SGzC1xcINql2Qps1BrEhoxhb90FkSu8Rx8b0Wtcz5hHthYEd3TZbYnm/e01xbjn+AX
 Y08/98eGpKxLIcKNgeR807zRp2vJTY52RxJTHPDYpOKaYBPleOm0dBIZKyX4AZVEkvmD
 57zUMyQreT1D2HrTITrOUqoLTdotXsHxVEa245xWaANN1QheH0s6aaw2NayhUepX9nIP
 bUda972TRqGhYF8dF8AmiuGuJLvY1LmYO5zeOr3GuxLxNr99RRfSlOLxTOsWXi7jjwow
 C8pmIxEFbkQxzsmD0em/uqSTXWTlDLpBMnHaguKTXMpCnIugzomyiQYm8VoSEgUAF4VA
 KRnQ==
X-Gm-Message-State: ABy/qLbD3BCZKya6COcmTj4AmCzSgdk4OzE2iqj/K4jjdAU/5wnOK7XJ
 VZqbXipCOQWAfXKly9tIZBzN0A==
X-Google-Smtp-Source: APBJJlEIYEGWfOYinUrXgoj/1q0Yr4ZiFKw9pG2cBPzBAS4N6PkkmwDGOVbyLngHPZealxvBJ2p/eQ==
X-Received: by 2002:a05:620a:2591:b0:767:1c73:6a06 with SMTP id
 x17-20020a05620a259100b007671c736a06mr16284162qko.0.1689621186136; 
 Mon, 17 Jul 2023 12:13:06 -0700 (PDT)
Received: from [192.168.224.227] ([172.58.27.30])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a05620a136100b00767cfac77c3sm6247971qkl.134.2023.07.17.12.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 12:13:05 -0700 (PDT)
Message-ID: <b823ec4e-c5d6-b822-8ca6-c0afe346f6b4@linaro.org>
Date: Mon, 17 Jul 2023 20:12:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/7] target-arm queue
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230717124746.759085-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230717124746.759085-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x734.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 7/17/23 13:47, Peter Maydell wrote:
> A last small test of bug fixes before rc1.
> 
> thanks
> -- PMM
> 
> The following changes since commit ed8ad9728a9c0eec34db9dff61dfa2f1dd625637:
> 
>    Merge tag 'pull-tpm-2023-07-14-1' ofhttps://github.com/stefanberger/qemu-tpm  into staging (2023-07-15 14:54:04 +0100)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git  tags/pull-target-arm-20230717
> 
> for you to fetch changes up to c2c1c4a35c7c2b1a4140b0942b9797c857e476a4:
> 
>    hw/nvram: Avoid unnecessary Xilinx eFuse backstore write (2023-07-17 11:05:52 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * hw/arm/sbsa-ref: set 'slots' property of xhci
>   * linux-user: Remove pointless NULL check in clock_adjtime handling
>   * ptw: Fix S1_ptw_translate() debug path
>   * ptw: Account for FEAT_RME when applying {N}SW, SA bits
>   * accel/tcg: Zero-pad PC in TCG CPU exec trace lines
>   * hw/nvram: Avoid unnecessary Xilinx eFuse backstore write

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~




