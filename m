Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCC3786C94
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 12:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ7JE-0004aG-Qo; Thu, 24 Aug 2023 06:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZ7JC-0004Zp-UB
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 06:11:22 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZ7JA-0004ft-PQ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 06:11:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fef56f7222so31788785e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692871878; x=1693476678;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gQuYHmaS+RYcDuor8WwtrAfj5FNpNIFbQn+Fs1h0f/Y=;
 b=IsaBJjSR0rczP1b/MHL5JS+LH6+5H9HT0s/gHHFe1a0wdwGuj7ai1i34ReE+snyeZr
 YpH/hoNpR7U4Nwuc/+9nzRhSL1R/XOfI8V+6vJFpDEZYNv1VShIqcuOD+j2ezBxKBr0Z
 z3HsL5Sri6cipTr0vsudecpW+KcpE8sBTqveii3tls7kR6bhv5Pyo0XvcD2hUyNH3Rcc
 4w7LbrrltVcVf8gwJOUb2LABdfDCgdlZwwhJwGQodloitSV2ORp7qO4gfOARUm0Xku9Z
 JarfXRk2rSE1Zd+7ymbqXELCqh+K6svFNQ4X8h3mYA3DvtfhMArVK7BkcoRzwbXh6SA/
 2vRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692871878; x=1693476678;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gQuYHmaS+RYcDuor8WwtrAfj5FNpNIFbQn+Fs1h0f/Y=;
 b=g4yx3vLm9P+uy4zUJzCmD3SgqR8sqqvpF35rLDx5clQdRSyc/i1YirXvPGQ42qoPgd
 HPX/RgFi7pdxe3JLFUfmJe47HzyUpSVuRhqI85UHOHReuSAbevXek1wjHRx+DtJpg1tK
 SD3ORJ/TXY7+a22UzL4Xlb3RYwpykiidl8zT7cjHxHY43JBqWddq9hyfJIUhCzkq4Q12
 I14C0FTsQoicuGIPCTcndfSWMA4H8S5pQtphFVSgTpoBPc/jnLbqy4lU+qa4UIYMRI5S
 sOLRHnoxx2tYeUe6PUk0Gv4Xx1HPckbVz0evN1Iz5yym0B+Fn+rdr7cESUdIcNyciFFk
 Mz+A==
X-Gm-Message-State: AOJu0Yxlsww+g0nbVo8XgBe91vKF0EEVo5455EaPPCP1KfhmFkCH/2Xk
 LcClm44psuFD6R6/VQPenvyWjPtO+rb5VoukjhE=
X-Google-Smtp-Source: AGHT+IEm3YVG8+FqQHrCb/soJK/dmz+xXfnnooe+aZW5g+slW2nSkp/rslafUcyrqS+fRPZiVi00Bg==
X-Received: by 2002:a1c:7210:0:b0:400:2dc5:1fed with SMTP id
 n16-20020a1c7210000000b004002dc51fedmr3036697wmc.33.1692871878090; 
 Thu, 24 Aug 2023 03:11:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.238.90])
 by smtp.gmail.com with ESMTPSA id
 x21-20020a05600c21d500b003fef30b28b2sm2172620wmj.18.2023.08.24.03.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 03:11:17 -0700 (PDT)
Message-ID: <aaf22c74-f917-0f9d-1d3c-86fa872fedf6@linaro.org>
Date: Thu, 24 Aug 2023 12:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 08/24] mips: spelling fixes
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-7-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823065335.1919380-7-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 23/8/23 08:53, Michael Tokarev wrote:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   hw/mips/malta.c                 |  2 +-
>   target/mips/cpu-defs.c.inc      |  2 +-
>   target/mips/tcg/msa_helper.c    | 12 ++++++------
>   target/mips/tcg/mxu_translate.c |  6 +++---
>   4 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


