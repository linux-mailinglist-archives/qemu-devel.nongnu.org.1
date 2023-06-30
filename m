Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CF9743CE4
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:37:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEJ0-00036Q-OH; Fri, 30 Jun 2023 09:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFEIy-00035R-H4
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:36:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFEIw-0008Ee-So
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:36:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76abso6822765e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688132213; x=1690724213;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X7EByBzIB0Fqt9FLdwHYbuthaG5USnI3lT/g3UZqT7M=;
 b=USbQucOVgAFwmjLkTk4mRwAZSDgqO6zPmJ0CntPxdZghgZPMbUIVQzX14ilEVYRW3o
 WlDYDtSa74rrCVVprtJAdFpZ+eJwTJK1oHUTdcJW6T8QXzx0z93oBs533BKzjhpbAf2s
 z588iNuoI9Pp+mEVwA34IFuSsSL07XHqzyXbWjog+TTJwa9zs3Lr6Q3HzdAe/Jlbpt5T
 ZYTB0HKRRpto4KqhQa33JoumlL35AnghXfTqKpHL3EHFcyJXgf7FrEuhQLZc+i+On168
 HhOBHFC+CyKBaB6rizBoCGcuLyWAJ0ke5iJaD0CS1UDb6Jk2Q5f0l5SuatfWbX8A/lB1
 cdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688132213; x=1690724213;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X7EByBzIB0Fqt9FLdwHYbuthaG5USnI3lT/g3UZqT7M=;
 b=Sheu/uNFLEp9gQzkw1r+4VFzsD1K+P9PfevZKqxVlFRYcg7CBGHhyJurJm+Ed4iBwg
 CV6MrGhCx6pZnl6HQyy+2Dn+IEnVrRMnoKemAFmUyaWBXSJxUfIO1TwemzT34aaDJs8U
 P7ZgtWI5TtDUxmwCIXGrlSeCtv0tarTxsS5MzCCRXQzTQuIKrd2xW7ZoVgEEk4u7ZHm+
 LT4sDwY6bdfOlaLYpyZ751wSHoWVFYySHJcrTH9d2C+AWYNOg3OGHuOTbLMEyv249Dir
 QFxwrmfj/KY+pM8H0KBEyKyeCBmPGHcjOj5Mcwl0OIUdWr/OHE80wtMODLvtvjR0Q5/r
 tadw==
X-Gm-Message-State: AC+VfDxkmEHpuiDukJSnPc3T+PYhwBgeSfwL9uQ1uauMi0KcDS/4IT4V
 lAHh/yKMBh3SvaOUex6Y3S084fIavt6+SeXpbkw3nA==
X-Google-Smtp-Source: ACHHUZ4ugN5/aPl5cfLYnHuLwPK/H4koaqWzg789GSjxRdZFB2liygYpHNNo0vMlFkWAQ6JCFshRfA==
X-Received: by 2002:a7b:cd85:0:b0:3fb:40ff:1cbd with SMTP id
 y5-20020a7bcd85000000b003fb40ff1cbdmr1873433wmj.10.1688132213231; 
 Fri, 30 Jun 2023 06:36:53 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a7bcd0a000000b003fa99969e61sm13402067wmj.45.2023.06.30.06.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 06:36:52 -0700 (PDT)
Message-ID: <49f3d1c1-38fa-aa02-35f9-5db794b67a04@linaro.org>
Date: Fri, 30 Jun 2023 15:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/4] fpu: Add float64_to_int{32,64}_modulo
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: christoph.muellner@vrull.eu, alex.bennee@linaro.org
References: <20230527141910.1885950-1-richard.henderson@linaro.org>
In-Reply-To: <20230527141910.1885950-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 5/27/23 16:19, Richard Henderson wrote:
> Extract some common code from Alpha and Arm, and which will
> shortly also be required by the RISC-V Zfa extension.
> Added a new test for Alpha; I already had a RISU test for Arm.
> 
> 
> r~
> 
> 
> Richard Henderson (4):
>    fpu: Add float64_to_int{32,64}_modulo
>    tests/tcg/alpha: Add test for cvttq
>    target/alpha: Use float64_to_int64_modulo for CVTTQ
>    target/arm: Use float64_to_int32_modulo for FJCVTZS

Queued to tcg-next.


r~


