Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E24CD71607E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:50:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yo9-00072z-Eb; Tue, 30 May 2023 08:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yo2-0006vN-C0
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:50:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yo0-0006s0-R8
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:50:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f6dbe3c230so45989755e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685451027; x=1688043027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z9NXJBTYuX2yVfFEwemBKzXghuXIm3ndqcC1KCID+tQ=;
 b=MNeEvAXqpGAJ97zZ4ZWbFy8C30mnh0yeQCeSkuXfyN43e0ovRH0g5eD4/Z6mCef3HL
 VoZKuQE1ybl6y4Y64vg8Tn+OGI0O2S4mA6HCC3frd3ZDcDrTiyGVF8SU87r9hLFQv/AG
 apYQKe0zTd1vEGeSofYv9zDBWKCdDKwtOoRKnK0GAR+p7Ft03s1+RQeRelMt754GOFQo
 sJGXo4yfkaNzAKkanVIHD/fiGg69rHYFPyloUOn6vd04xNVxfckT5+iuhvvs/UmOxcfD
 Z2181a1LWofUgh23rASXw7cvdph5F2M9IO+SnjwwYPjYWlMleUR13TB3b+zJiIEx3wEy
 Gzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685451027; x=1688043027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z9NXJBTYuX2yVfFEwemBKzXghuXIm3ndqcC1KCID+tQ=;
 b=IweU2xC69fAeAIOZ7lqDHEy2qN8XiBrV8rZpYZ+4oqhT0949D+FLEKwKT+boOXoCVz
 FvzIuf3ayxTwGvPF3immtH1TFRPSqpeE9Iy/HkosTugpTDVJq1KVMOP8jae0KZlnAIos
 Hw2qAaP+lHi8JIsxL1/1IOkRYk9tQpTaYnfREc4yFBS8Y5a8qYzWHM17igf483hH3woh
 fcmuHnXqFqT+ia1AoLUD/7b7mIjzEMmqEOJKVVqjEG5CBP5oyvY+w6Y9xduEPCL2NKdm
 6vrD6iSOJSbjLQ5pX9UHsoa9mRlQp1APl78NBXWh61IN/F3WDxkb8gSUFohGwoOtDVwV
 c+Mg==
X-Gm-Message-State: AC+VfDyY4fA8QAMAZzA4Iv/ZIdfnRVKhzaH5P0Rb4vlElbti5780y8qE
 MLycw44ME5DiOJ4OFAOeTQZqrQ==
X-Google-Smtp-Source: ACHHUZ6kj46pWrEEsIOIvrWWX0A0bDpL39BnCmm3UxBcVlEB/IoTvGZWHRsz88oh90UoWhridV6/ww==
X-Received: by 2002:adf:dfc1:0:b0:307:7e22:dfc3 with SMTP id
 q1-20020adfdfc1000000b003077e22dfc3mr2108746wrn.63.1685451027261; 
 Tue, 30 May 2023 05:50:27 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 r10-20020adfda4a000000b0030644bdefd8sm3200373wrl.52.2023.05.30.05.50.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:50:26 -0700 (PDT)
Message-ID: <50a81b76-84c2-79b0-4e20-16ec16555c77@linaro.org>
Date: Tue, 30 May 2023 14:50:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 02/20] target/arm: Add feature test for FEAT_LSE2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
 <20230525232558.1758967-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230525232558.1758967-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 26/5/23 01:25, Richard Henderson wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


