Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E6C7B3BED
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKze-0004GW-Fy; Fri, 29 Sep 2023 17:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKzW-0004G7-51
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:25:42 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKzT-0006W8-Gs
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:25:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c451541f23so119517125ad.2
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696022736; x=1696627536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=smR7Q+lRHJcVFB55SXcm+wKIt69RYGw6IJ7temvA/98=;
 b=BfZdYOj+bEhRsoLKDe9xVDb6IMFVNE5TziZqiFEkUtEIBXXmDz7pmgFmRj8zqnq8Ik
 nfgDgFBFbLYlNyGpLHbedB8DYAO6yvW5zskJUsGkQIjAkUZzCQb9LL9L4rr249oTFgyr
 khA5nt02JfyYX+VP51ctaDtUNR6xwWECtAdZbO2DVN18Xwg8Gm9ewLNLFViIsOymLvDA
 Aw1zxyfKJt0s4NYOWISEukrilXMZFPd0cS6JC4bfrZwC9EwomdjrcRKX6fuK7GhSPcqj
 B+TiNXysc46VBW3nmcmHPWRH0IIB1gEJvGYeUBiY6Bx0HsOpnqzBvVH7bwstGj6nF5Ub
 9SVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696022736; x=1696627536;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=smR7Q+lRHJcVFB55SXcm+wKIt69RYGw6IJ7temvA/98=;
 b=QfNwyjvY5EXTfG15LxCkmV88AxIr1dmP8nsWULxTqKWKsCWmH8LAvdNM9iGgtIVotQ
 cDjBmtAOERZ6Pz61J+4KuKqAdK74PaGvtWgYIyXZcJUZBrC/r8Ur2IdUDILXsk/nJk6O
 OEr9lkogRvTBv17u2oQr9FiUaPRq6wYjczCmmiCvi85JKwm/aulyB8i0UrqBbgt9I7Z3
 4DoyQISdAKLMrj9dhglfUqcP7Iat3HwmxRx0HqJRQtTqLNNm8VB2zS/mbyKSPb392KPL
 cLBDyhWGzLGW4m9mb6eCBVN1dLbUQbY0857tCd0be1FUyWRc/zOaq4E3Oq8AoabOGYKb
 zvhg==
X-Gm-Message-State: AOJu0Yw8Ypo/4mykCaOq1cpX+PWn41SceLfwZ68yFz10ZjRiRumH80MP
 2Tjbv31gIFpN2dFoQQSF2ICw9WJ7c//MRnv+8Uc=
X-Google-Smtp-Source: AGHT+IED0qOU16f//96EdX4RtnqYgH3CltQDlh90k+cZlMScCsPawFL1aCbV2oFh7ukqF808x2upPg==
X-Received: by 2002:a17:902:7201:b0:1bd:d15f:bdfa with SMTP id
 ba1-20020a170902720100b001bdd15fbdfamr4722456plb.68.1696022736685; 
 Fri, 29 Sep 2023 14:25:36 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 j21-20020a170902c3d500b001c62e3e1286sm3795747plj.166.2023.09.29.14.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:25:36 -0700 (PDT)
Message-ID: <115e0c9a-ffb7-1b63-9d90-6c59a5b0ced0@linaro.org>
Date: Fri, 29 Sep 2023 14:25:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 16/22] target/arm: Extract verify_accel_features() from
 cpu_realize()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-17-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-17-philmd@linaro.org>
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
> When looking at the arm_cpu_realizefn() method, most of the
> code run before the cpu_exec_realizefn() call checks whether
> the requested CPU features are compatible with the requested
> accelerator. Extract this code to a dedicated handler matching
> our recently added CPUClass::verify_accel_features() handler.

How much verification is this intended to do?
Can realize now be required to succeed?

For instance, the error for unset gt_cntfrq_hz just before timer_new could be moved to 
within this new function.


r~

