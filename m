Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFC1716A05
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:48:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42Vy-0003MO-9H; Tue, 30 May 2023 12:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q42Vw-0003LO-8M
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:48:04 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q42Vu-00048s-DM
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:48:04 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64d2f99c8c3so3429965b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685465281; x=1688057281;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pbqMOgCrhJYMlNDeH0L+yLWqsv9mPLI5cwbSEItcaug=;
 b=Lne8F2AGQak76cG6LIR4LzBmZ25TtWHAtTjiS9qAumS/O90ffU6mrrSrI6Sk/xFSGQ
 8dTRHRue5rWb+y3c115Nm/k/LQSoN2fePbISC71h48Z1asLG5DIuYa7q3c3Lfco6FqHC
 DlAQXyI3PhXiocmNMzrsgXcohuYgc+XHAaAtx+G8pu5tshrsxm9OqFqn4NHfZ2+msgN9
 p2hTSUmpx2vOren+hwuzvMKrztpCQK0yeYBuxNm7gvUdGYeLahV1JKiP3DwSGWxIhi2z
 7hsFJmf6K6fO5TAVHOtteZAVGKCWEFrwzt2ieUcb8nmh9CxpWc+ChlHkFKvB2KHc6AI8
 IYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685465281; x=1688057281;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pbqMOgCrhJYMlNDeH0L+yLWqsv9mPLI5cwbSEItcaug=;
 b=VTbjcvEu98qvZ6kDEJr5PE30BOobjCqoIeFmOG3f7nENDVmO5I6kUbHHb2u4wxbjz9
 ZonJKyixjry4gEgxAdXUkzfZ35qWccyx9gIWMPzx/C1S7pVU+WNQl3LT08+19eyP0A0z
 pNgG57Z+lb+g0RzvDb2xTRkSfD2wDAvpv4lYgeNU3xVOIf6MsgWU530KfzURKDePc72o
 s+yDYNuQnlmWXyAWFjdIy3YdfWmZaYNxpGnxB8PEjoP/4aoOUcVKAXDSJV7XhWtWvi57
 UCwHCLYmqnbJPmeSWvrh/dKN/mWO4SnH+xGTzZKC1j15TmY8iOJefzSbUiP5RcDwYIHj
 JrCw==
X-Gm-Message-State: AC+VfDy0yRz7s8JtfLXUoaQEfzeNstxmE7O7Ooh4lFRb4tHgMLfZtw82
 oXyRUZA9owaxzZmQKj/NeWZHlA==
X-Google-Smtp-Source: ACHHUZ5LCQdNr/wiXFT908U/RNs/TPHcGLD9vo+/kKU5jFF4z8Fa1MV44a9S10dwjixaO3E/d81Jew==
X-Received: by 2002:a05:6a20:2588:b0:10b:dca5:74e5 with SMTP id
 k8-20020a056a20258800b0010bdca574e5mr3701122pzd.0.1685465280699; 
 Tue, 30 May 2023 09:48:00 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 r6-20020a632b06000000b0053f2037d639sm9055506pgr.81.2023.05.30.09.48.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 09:48:00 -0700 (PDT)
Message-ID: <491dc719-cfae-a79c-8b20-8251db0eb5aa@linaro.org>
Date: Tue, 30 May 2023 09:47:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v2 00/21] target-arm queue
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230530145237.1589144-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530145237.1589144-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 5/30/23 07:52, Peter Maydell wrote:
> v2: fix format string error
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
>    https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230530-1
> 
> for you to fetch changes up to ec683110def96b16be3931ec87baba65a3dc5ad0:
> 
>    docs: sbsa: correct graphics card name (2023-05-30 15:50:17 +0100)
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

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~



