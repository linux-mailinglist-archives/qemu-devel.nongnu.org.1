Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC9C7C87DB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:29:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJ9y-0004ts-Uu; Fri, 13 Oct 2023 10:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJ9k-0004pC-U1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:28:49 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJ9j-0007rw-6n
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:28:48 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c9b1e3a809so16471675ad.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697207325; x=1697812125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uyt+qXg+Yu02sLoQ9KAH2e6amZVR58RgLKOrspU/zpo=;
 b=MawsMIylqyHVMD+mTZAzphM2cpMYxoOTTH+CM9mxv+6Q4UpqIdQd/V048MTO1oif7R
 1WiSPo5vXsWas+O1tgqFzC65vqgGKCst1mMHEa1fABSzJYr/EMxjDWdoTJ4shoi9DuE5
 u1LvSTczHbef+T1bw1Wm8z8aBVttlcQ/ruhC7aVWrMDc+ltAiv880HqY29sJJDeAd9r2
 a35/r6WJj7r9EQVJxTcmiI/vQ9RVEcOmFgMD7IY14f8SjR4/b1DSrxtZl2tCsTCc9lWy
 X2utEl5Lc7okQ89c1y8BO7Yv0tE5Ix07yD8++acCeeFR7hcE7ZHkgs6o7VRlSvsDlO3K
 dNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697207325; x=1697812125;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uyt+qXg+Yu02sLoQ9KAH2e6amZVR58RgLKOrspU/zpo=;
 b=uiPH7ovUQ0CKw5eljWFCTPLa7AdKd2Ox2RQ5EIFRgYs85friPH9gsuJmBix+3PRNGY
 gVXbkHbN3HcoZelieH6BpxA3mktDlHQXEJeAYCiddiFr7FWjO44Mz1vSpPFoC/3g/aLa
 Eu7ooGk8IJ2x2s414bVmSeklrOQFCxx4nsOu04eIwB0pefAQVafb5goo8uphPhhxAW/n
 uQ77lnn13Riuc1snNjwOAk6Uzh9YGoXy2oZuEYWaKb+486yOERLlaE6v+W1eu2WEsn2x
 hx3ycUEsHIBtZqSVFDWZ7vOY7BZntRygwkao/g3fVw6QjYtk13XWrdCjGxH9+cepuMdc
 THKw==
X-Gm-Message-State: AOJu0Yx4he4Z0vGVmouWkrJIzdShDYK72Acq4wRN78/pNF/Jzq+oViSE
 F/k6cdlVcx3GVLJ37JVtenorUA==
X-Google-Smtp-Source: AGHT+IGFCf/Ew4ISLvdY7KUb8DW7xBlAqd9c14HZAn9PNXg8gs7DKT5LP+euC+3yONSWlglJ/07+GA==
X-Received: by 2002:a17:902:7242:b0:1c9:c577:a99c with SMTP id
 c2-20020a170902724200b001c9c577a99cmr8249805pll.38.1697207325521; 
 Fri, 13 Oct 2023 07:28:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a17090301c700b001b3bf8001a9sm3958048plh.48.2023.10.13.07.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 07:28:45 -0700 (PDT)
Message-ID: <94c85f01-6a17-492c-b67a-082d5e61907b@linaro.org>
Date: Fri, 13 Oct 2023 07:28:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] target/hexagon: Declare QOM definitions in
 'cpu-qom.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231013140116.255-1-philmd@linaro.org>
 <20231013140116.255-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013140116.255-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/13/23 07:01, Philippe Mathieu-Daudé wrote:
> "target/foo/cpu.h" contains the target specific declarations.
> 
> A heterogeneous setup need to access target agnostic declarations
> (at least the QOM ones, to instantiate the objects).
> 
> Our convention is to add such target agnostic QOM declarations in
> the "target/foo/cpu-qom.h" header.
> 
> Extract QOM definitions from "cpu.h" to "cpu-qom.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hexagon/cpu-qom.h | 28 ++++++++++++++++++++++++++++
>   target/hexagon/cpu.h     | 15 +--------------
>   2 files changed, 29 insertions(+), 14 deletions(-)
>   create mode 100644 target/hexagon/cpu-qom.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

