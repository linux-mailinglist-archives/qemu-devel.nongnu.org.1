Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 390AC77DDB3
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 11:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWD80-00076y-AM; Wed, 16 Aug 2023 05:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWD7x-000757-I7
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 05:47:45 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWD7u-0004aw-IA
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 05:47:45 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fe28f92d8eso9922708e87.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692179261; x=1692784061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mPtG8vcloFr4rOm6gYDLJyZiPPX4MSZ3bGhD+Ih54Xs=;
 b=o/fJtImolmEVkXBf5u+K/4Zogxoz6sBLuAl+ebTeTNq4aH2DbMDRbLpMN7Ruz8ALW0
 M0JpVbAOQzav+4dJO7herah78WtZdzioxoeAI6eKO9fAdiueB0Xu6WXCg67DJxoRMLF1
 ycqgRarK1XBetfvlU+dnCV8uyDTpfvNFQQsJsJHL6Q2jFoqhGEeiUggAzq/e+xLyRS4j
 BgHvydWlc9A2R6K+qu+COXjPHDdG1mqMvy4FhJjqGGsOPRJyr8g28qHrurs6sxpO7IrA
 umtESZ4Pbf2VMjo0RsMEPrfWTBy05GA+PseTn0txvypfBNvFEHbnQqLLRDIIyupg5lXM
 UY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692179261; x=1692784061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mPtG8vcloFr4rOm6gYDLJyZiPPX4MSZ3bGhD+Ih54Xs=;
 b=brzsgxbp2AsT6KaDBtWDYLQryvV149flkszCZqtuXmqxqbFj9Rlaa8Px26Hy2cVoae
 GuiGeJbwXWVcl1imZnnHiQ4BPuPmwpVe40OwJlixwyIUUrg7XYPtTvmKTx7JQthrj5zW
 ahOW3vwUBPLsiLeQ3BxCluHLZoaDVCEc0WcKI+kHs4sYqxgUUh22f+haTopluhrB0WM+
 82HSsej6n0yupVOgNLL8ZQOLBTQKbTl/urwn64pQzz3YOLxd2e+0Hs1Nqj+lOHE4PKbg
 cGj3AZ0j+nQ4+ckDhWlVfYG+HUVCQFd0pHmwTHGVdX37jC6Y6H/vEiSpWiAnkGOf18Cc
 gAtg==
X-Gm-Message-State: AOJu0YxCE35vWjZibqceO3x1Uq6sfUgVIA89Cd9FWA1sF8a5UedB4IAU
 FhqgrizX4zpM43f3/6xIaL+VDw==
X-Google-Smtp-Source: AGHT+IEFA9stFgcfnZNUZYwz1Zp/y5vkm/yocwjOD8J3a8xb6plYzn2A5ht9gobbEALA90ob3m+4sw==
X-Received: by 2002:a05:6512:4016:b0:4f8:7781:9875 with SMTP id
 br22-20020a056512401600b004f877819875mr1423571lfb.60.1692179260202; 
 Wed, 16 Aug 2023 02:47:40 -0700 (PDT)
Received: from [192.168.69.115] (mna75-h02-176-184-40-35.dsl.sta.abo.bbox.fr.
 [176.184.40.35]) by smtp.gmail.com with ESMTPSA id
 f9-20020a7bc8c9000000b003fba92fad35sm23655542wml.26.2023.08.16.02.47.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 02:47:39 -0700 (PDT)
Message-ID: <aace73af-1286-708a-733f-2826e75c8a42@linaro.org>
Date: Wed, 16 Aug 2023 11:47:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 0/2] nvme: avoid dynamic stack allocations
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
References: <20230811174751.784620-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230811174751.784620-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.045,
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

On 11/8/23 19:47, Peter Maydell wrote:
> The QEMU codebase has very few C variable length arrays, and if we can
> get rid of them all we can make the compiler error on new additions.
> This is a defensive measure against security bugs where an on-stack
> dynamic allocation isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> We last had a go at this a few years ago, when Philippe wrote
> patches for this:
> https://patchew.org/QEMU/20210505211047.1496765-1-philmd@redhat.com/
> Some of the fixes made it into the tree, but some didn't (either
> because of lack of review or because review found some changes
> that needed to be made). I'm going through the remainder as a
> non-urgent Friday afternoon task...

Thanks for refreshing this, I totally forgot about it :/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> This patchset deals with two VLAs in the NVME code.
> 
> thanks
> -- PMM
> 
> Peter Maydell (1):
>    hw/nvme: Avoid dynamic stack allocation
> 
> Philippe Mathieu-Daudé (1):
>    hw/nvme: Use #define to avoid variable length array
> 
>   hw/nvme/ctrl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 


