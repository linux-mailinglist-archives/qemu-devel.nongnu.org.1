Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A537E746C67
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:53:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbmH-0001Wp-He; Tue, 04 Jul 2023 04:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbmE-0001Vj-NP
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:52:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbmD-0003fg-4a
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:52:50 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc244d39dso70580115e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688460768; x=1691052768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LsKz9iDr3dATA9eWIngXeVQnMxH64ehFECIJZueriT8=;
 b=keT6ja/RAaDOJCwUKNKUR3gDZ2RzwEojvUsTub9+KkNPdKoIG4qT3EuFzEk/w3l9w0
 RIpHowz9RyHm94UJQQLIYgs55jByqcq1/a1yJ3uCAVDM4XjL5vaaQ+UbB0sfW91FSA+O
 cU2L4LsHeDvznePGDfE0iBPOKbTv0kZYf1ptzvq8sgZ0JMI41NgLoEcA1RNetG9spoek
 Bubl/kB6mOjf/XOVLrDiJTQWku/I8XNgHdlSWEtmrYhYy880ADocSwsYUyaLk1wW+DU+
 sE8ICVVd5qiQv7R3qnTk0S5WrnbBPUPasy1aq9S5h6pkJNCUHcr/lPdXKDngp510bXkC
 tRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688460768; x=1691052768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LsKz9iDr3dATA9eWIngXeVQnMxH64ehFECIJZueriT8=;
 b=E1wwvVSiefucGUXuLBKf0QezDeKvAOMWCVEDrm4cKlK7mpqo4a09syIVDgwIf4gxOn
 V8q6ygRlCuqD/CkWy5YpWil6h558DnMg2n5zu/sb2G/v+7svebH3HLMvaIYMKOREnjs/
 /W/znHbJfKKUz4yB6Mk5flXBpJt2RVVVYfpPItkGzh8pj4rarp5OFKmeDXu2eQI4zZ8w
 btRjiCmCm3EKkNcwlavZwzR1crCH8hBtHcDBMbfB/sbJJXLE2AYQFPYtQEfRBFD0qu+U
 PZbgK22Q5wggSa5gAnlCLBKXs7SN0xvYuo96XXUGPIjQywBIPHv8YcU+2T5WoRwUUhAb
 Qh3w==
X-Gm-Message-State: AC+VfDy4pdPrDn49rGlPMJtkh+RINvQ+S+fr4hG738uKaFrgQwhB24hb
 Xy6v5K2lguZEF83nIPNwdXtz2g==
X-Google-Smtp-Source: ACHHUZ6w160ObyElo854tFsyPg2OPZrLlaHLPcwmTCi1q/8bE5KxD6dFg59/RyapZbEGY7fpuSOb4A==
X-Received: by 2002:a7b:ca56:0:b0:3fa:9720:4c53 with SMTP id
 m22-20020a7bca56000000b003fa97204c53mr16461624wml.34.1688460767873; 
 Tue, 04 Jul 2023 01:52:47 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 a15-20020adffacf000000b0031434c08bb7sm5921437wrs.105.2023.07.04.01.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:52:47 -0700 (PDT)
Message-ID: <b21483b7-0c56-623e-f287-4fa8189dc9f2@linaro.org>
Date: Tue, 4 Jul 2023 10:52:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 07/13] ppc440: Add busnum property to PCIe controller model
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <9ededc930d3ba2ea3f0748d71410d36b7b453fdb.1688421085.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <9ededc930d3ba2ea3f0748d71410d36b7b453fdb.1688421085.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 4/7/23 00:02, BALATON Zoltan wrote:
> Instead of guessing controller number from dcrn_base add a property so
> the device does not need knowledge about where it is used.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc440_uc.c | 25 +++++++++++--------------
>   1 file changed, 11 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



