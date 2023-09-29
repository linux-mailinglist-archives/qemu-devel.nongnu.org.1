Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8BF7B3BE2
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:21:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKuY-0000rr-Ki; Fri, 29 Sep 2023 17:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKuX-0000qe-Ep
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:20:33 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKuV-0004sk-Vx
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:20:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c5c91bece9so119630605ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696022430; x=1696627230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7OiZxqmR5p6N3phys1pUHX8D0KI8G/EY569fA9lGy44=;
 b=w7aCCTw07H2HM2ZbcvChIHGypHX7RLpSpFnsDzBlD7UT96srBszbDSdKkdMI687mfo
 t8DJX9XxBXji8V1OblEGYPjVn8YsJwPP2eUxpEl9LSVVm8B3YfUjFgfrgLSknv7Abhqv
 wHbhSF+MF9oBFr7H/DuGU85v2T2xEzRkMSL/0K1hxhJJgsmUe3kMoZZedEglSuJOOavs
 32QfqEyUOiv3IHQN4FcmoJYqcQDQwxToKUKncT+VVnPQjQa4FFhixde8kyEGmPpUi3tl
 kon4VuJpXndtaDJp9Fz8vFDiQUlgOmsDnKl/gIDiPOMYs9z55vUcf/mHOb5oaJ7JN8Su
 G0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696022430; x=1696627230;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7OiZxqmR5p6N3phys1pUHX8D0KI8G/EY569fA9lGy44=;
 b=Pf5x3mhMLgQxD8EuCVCjaZhlNxA9klm0LaRtxtxmGW+Le4NX+2SdhXCG3js3EJxm6P
 /T3i3YRKeM/qnrQRjlwChebku5W0gs9vfriBCT6MW5LSn903VM1koMtm0MhhV6SgJOS0
 qgCtY4Ec8JKWKHZU0+SuL4EzYT/3QqI8mi8rmg+Oro4votUqdCI4Uhhuu2LLPCWC6P5C
 zRTtABYldsexG9Ao900+Sbr4Ng+WdyOQzMBVd5HxDaKZnq2xQW4lKqPcGOzZcvHQBi8V
 fHD0zsQceoUcM73w9NReFoK0HsC0kyhn8y80ygILSL0s0ReyKSV6oXU+wsc1o6+NrrAS
 sLpQ==
X-Gm-Message-State: AOJu0YzJaF8Y9hBEkmjD+mrNIIWX8VfWReHnk+fyHveH5pQ628qly5Ca
 WLyjElFvSA2gCXWLIXoZWpVdhF5a496aWry/Lww=
X-Google-Smtp-Source: AGHT+IFHg4r4o52a+fxYA69qkYY9TR1yV2nx2GkGRbu3DHDaN8IV1CLm8Vu1ljAvLlEVqwoKxmtDnA==
X-Received: by 2002:a17:902:eec6:b0:1c6:d34:5279 with SMTP id
 h6-20020a170902eec600b001c60d345279mr5424948plb.13.1696022430388; 
 Fri, 29 Sep 2023 14:20:30 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a170902bc4600b001c60a04e1cesm12217916plz.36.2023.09.29.14.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:20:29 -0700 (PDT)
Message-ID: <ea178151-a519-15b1-d537-dc6ede9540d6@linaro.org>
Date: Fri, 29 Sep 2023 14:20:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 12/22] target/mips: Create clock *after* accelerator vCPU
 is realized
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> Architecture specific hardware doesn't have a particular dependency
> on the accelerator vCPU (created with cpu_exec_realizefn), and can
> be initialized*after*  the vCPU is realized. Doing so allows further
> generic API simplification (in few commits).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/cpu.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

