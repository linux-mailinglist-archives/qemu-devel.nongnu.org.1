Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CB75FFCA
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 21:27:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qO1CA-00074K-46; Mon, 24 Jul 2023 15:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qO1Bw-00072G-9j
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 15:26:05 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qO1Bp-0001cB-0r
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 15:25:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso46432435e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 12:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690226750; x=1690831550;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qm57ZRbIbFtc6GFqlhdfyRe9TSCtFWRbE92HSWy9ko4=;
 b=RokEHgk9Tuwtr2h8/mzYgYUC53C1QQAPpipq1NyRtK5FJp4MJJxbWrU4qgcyUyPJSl
 dvHNZ0Ly9xhNsOP6Gix9f4x+Ael7yF3zIgyYFlp66UCzJeW1tsT87q449BKs5TmVbtcG
 nGEOpGddyYDCr2Tfh2bBB3TcqlNYMHn/YXN+VPFNRzePCRP7IEmB1bZgAC2G3rkNsGvm
 VaW/BJg9S9uoD5KxlKeI1LPCblg9+YDbIAryVmebscln3SFMXawJbesANcENzpI3WNAL
 cWsan/iLSsruEU5DUYUb0F6i7jPMz8ZLSR8Pe2ddaStHVzqn88vDikNudVlz2/AwyQeV
 Nx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690226750; x=1690831550;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qm57ZRbIbFtc6GFqlhdfyRe9TSCtFWRbE92HSWy9ko4=;
 b=F5vxrJxYsQtqngdKtIFN459S+nhhLc60HjGuFJUNSCUKBtFmBMQb8i/JKCIl+C5r8X
 dP4y09vFgLzCiCaM+3NDAVvE3m3JsiRrmGMEVQxU40vvVXHgnftJ/7By45U51zTt1vO5
 hq/lI1Bz8nmdOjcDyXQIYlMLAHb76marIV0+aKG41ElRGlhGEK3mzONlfnYtv0Y1x2FF
 YSPUFyFRDo6BL8fiO5freOO8+I+RAlSl49nF3KxNI0ilgU3KYAK8dQ7NttJoSfOhi6jJ
 2xXXMdLwmPzZWf+lJo7HxflUe27tcdH5IdcYBFEA9somN9B/94vB35bjkBY935bHEViy
 gu2A==
X-Gm-Message-State: ABy/qLaMv+tusvS1VQkjOA2txmduKo5d3uszXAVgt3LGZEPJ38jprbsH
 zuFzFQzz4mvy3MY/KN9yl743GXuI2fMjR6qHNIc=
X-Google-Smtp-Source: APBJJlGgWzlOdThamtDY1G9o3es9T/ebQul+KTBFGSEUZkoS3zHkKsD3z7vIlGSbLF09KKB6gOQIpA==
X-Received: by 2002:a1c:e902:0:b0:3f7:f2d0:b904 with SMTP id
 q2-20020a1ce902000000b003f7f2d0b904mr8984082wmc.8.1690226750221; 
 Mon, 24 Jul 2023 12:25:50 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.210.255])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a1cf70d000000b003fc080acf68sm13902554wmh.34.2023.07.24.12.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 12:25:49 -0700 (PDT)
Message-ID: <94f8f34f-5399-db60-734b-4833a231a287@linaro.org>
Date: Mon, 24 Jul 2023 21:25:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 2/3] hw/arm/armv7m: Add mpu-ns-regions and
 mpu-s-regions properties
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230724174335.2150499-1-peter.maydell@linaro.org>
 <20230724174335.2150499-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230724174335.2150499-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 24/7/23 19:43, Peter Maydell wrote:
> M-profile CPUs generally allow configuration of the number of MPU
> regions that they have.  We don't currently model this, so our
> implementations of some of the board models provide CPUs with the
> wrong number of regions.  RTOSes like Zephyr that hardcode the
> expected number of regions may therefore not run on the model if they
> are set up to run on real hardware.
> 
> Add properties mpu-ns-regions and mpu-s-regions to the ARMV7M object,
> matching the ability of hardware to configure the number of Secure
> and NonSecure regions separately.  Our actual CPU implementation
> doesn't currently support that, and it happens that none of the MPS
> boards we model set the number of regions differently for Secure vs
> NonSecure, so we provide an interface to the boards and SoCs that
> won't need to change if we ever do add that functionality in future,
> but make it an error to configure the two properties to different
> values.
> 
> (The property name on the CPU is the somewhat misnamed-for-M-profile
> "pmsav7-dregion", so we don't follow that naming convention for
> the properties here. The TRM doesn't say what the CPU configuration
> variable names are, so we pick something, and follow the lowercase
> convention we already have for properties here.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/armv7m.h |  8 ++++++++
>   hw/arm/armv7m.c         | 21 +++++++++++++++++++++
>   2 files changed, 29 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


