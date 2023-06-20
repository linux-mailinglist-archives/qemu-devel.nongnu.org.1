Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ECC736E8F
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 16:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcFH-0006o0-Eb; Tue, 20 Jun 2023 10:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBcFE-0006nl-6t
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:22:08 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBcFC-0002xh-H8
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:22:07 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-510d6b939bfso6585345a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687270923; x=1689862923;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pbOPG7on5lx6uqj6I4Y3QLuj6yiZJ76vCcdEvuAj/KM=;
 b=sQhTwHdhHCYJjcFTPv4PqlKBVDPyb09IQFVRL7aqvroFOMculcopO5bNLq3YsV1mp4
 vhRmos67eE6Jy3nPd+ert/nZ5StQ9QIEUywkTdjFH2bFbSCo3wknRNDsjwWu4hnmGIot
 0b/th6jVsANiWdUbx9JdKBA8zzFMQTlKL5DGwQYmU+2gqYCLB20VRmw7ri+RDKwroPnX
 T1ztkBTa6g+yfGXIUojekTWe/UypQPMEutDhf3Siu/5Tfy39HIV2Ltq5dy6u+OTBdsLD
 w7XwmkvO9KjFVMjBSMRk0Z3cvY8uYCrOwFmlpqGzHQLpu8sKtmt5KE4Zgg7YG1853eKc
 A+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687270923; x=1689862923;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pbOPG7on5lx6uqj6I4Y3QLuj6yiZJ76vCcdEvuAj/KM=;
 b=PggcyqBlmE8TQgfHKfW2NaRTMhkG3q+z8VM4xRHI+XjSIFXqHY9Oc4efqkw0TSzR8b
 SpqoyQqFu5k5BAidf6kdKiPnPlaD3dRb/mBU1CWg9ePDDdSIb4EqtfOLwC5w0fcNWPAv
 2D3G7mM/KNS0ww3X+Y2hoYUMt9dxFVDwhdHNHlcoLwsfjc+VAZGDZw5lUScO9LjVNFiW
 +rPiXkuUXQJ8eZuhcYBhb7JgDOV1uzxFxs5VtShuJcPTpNXYpB+E6iVGorCO4B7ItnnU
 qBUVz2Qa7d9DCFjASPkUh0b06LGgLsf3reMzNyLEC9ih4ZfKJ6NrdMHPnb+Il7EaYWXK
 XI6w==
X-Gm-Message-State: AC+VfDxMBxFXgCx0H1qtcZGw+fG7/C9Qv2ORK/04wGVLEGUEiqAYCjyH
 qWqmPgadedro0nnvBj87q1MO8w==
X-Google-Smtp-Source: ACHHUZ5VkN/NSovxtD0M5SFeR4LtaWUPnmsIQTSvhAYTCNUqhkcB6JHrwEDbQE7k63x5ltWamhL1Bg==
X-Received: by 2002:aa7:c44d:0:b0:518:72d8:2cc5 with SMTP id
 n13-20020aa7c44d000000b0051872d82cc5mr8624704edr.33.1687270923427; 
 Tue, 20 Jun 2023 07:22:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a056402516700b00514bcbfd9e0sm1263625ede.46.2023.06.20.07.22.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 07:22:02 -0700 (PDT)
Message-ID: <a313b36b-dcc1-f812-ccbd-afed1cbd523b@linaro.org>
Date: Tue, 20 Jun 2023 16:22:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 4/5] tcg: Add host memory barriers to cpu_ldst.h
 interfaces
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230619142333.429028-1-richard.henderson@linaro.org>
 <20230619142333.429028-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230619142333.429028-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

On 19/6/23 16:23, Richard Henderson wrote:
> Bring the helpers into line with the rest of tcg in respecting
> guest memory ordering.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal.h  | 34 ++++++++++++++++++++++++++++++++++
>   accel/tcg/cputlb.c    | 10 ++++++++++
>   accel/tcg/user-exec.c | 10 ++++++++++
>   3 files changed, 54 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


