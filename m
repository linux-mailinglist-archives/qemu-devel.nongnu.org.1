Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F2581F298
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 23:53:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIclP-0001wJ-Fb; Wed, 27 Dec 2023 17:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIclN-0001vh-F8
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:52:33 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIclL-0001gK-Vc
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:52:33 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d43df785c2so8367805ad.1
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703717549; x=1704322349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dyK4dlB79ep5tRmkctbq/cCDmKB/TR7LOzqV/FFXhoQ=;
 b=m8QrlIJL2JEgn/rDcppt2zYReA3DyIUlWeW69lBS/LMZtZ8ZkOHNQvGevAjnraicFb
 hb3oG4Gx+2dW0ORPKrIs7pYAlu1BNgT2U05FMJ7HflP7KAiF7qDgOHKUd2kl1ZFSbENp
 jONXOg4xrHNX/TGF10VdRwRIzpuRIfHIs9TF8G5ukBGUFigHnmLO3WYHtP0CbRJVZgZt
 OhGpw9trx/YCYW5XEOs59mPBMsCACumNgqq/iwUULbFkCOzgLBGjleuPXtnvc/cDJT6x
 lPmUbbDEm/z9ASqba+Q6IlAb6bQVrp9stLKpG9Vv9V3gBIdqRaoAVICWsA7p+dp12LdW
 J0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703717549; x=1704322349;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dyK4dlB79ep5tRmkctbq/cCDmKB/TR7LOzqV/FFXhoQ=;
 b=N7ATptycs9ay+pMu/cTpai+YZAXbyas/vxtmZpJBgfgulRby0M9EMJoJ/U3VekDnx8
 EuvUg+5SzG1PbqQujk3+6Pdbq8Z4/HoW9RFUIpq3YRFTBAKNxxSQsQ9/5NeaKsyWKvxZ
 PdwYYY4Nth0+lmMZXbWeOQBfOrubegHk6RdOfj8Oa61Ca1sWjruLl2iYiVu82BC003sS
 ZxJwYRTBe9zQgvsHY3P43knIkGN4eFdreB1CBcZKS6mmpBIVWhVux8GyL9P2sIr/SGQJ
 N7MIrfHbCwPQKwf9/3SYEtS2s4cKXlAXU2ookoDogB36E9pOaPGgYFeLR4ZNbhDNxbsO
 e4Xg==
X-Gm-Message-State: AOJu0Yz6a+phRc6CIS6WgmnyOcDnxENhf2h1iy+vyIRupA/EXe+34Ywq
 xcl0mQkjI8Dj4FNRoDuLM8cC6Z6mTaYG3g==
X-Google-Smtp-Source: AGHT+IFvIjuehzQE9whgwAhHFevLg8WvXPoQmt4UwT5aesG1Fdd81NuVl7npAZcVLg22gqGyNS0+MQ==
X-Received: by 2002:a17:902:ea95:b0:1d0:98d7:f2e1 with SMTP id
 x21-20020a170902ea9500b001d098d7f2e1mr3953112plb.139.1703717549587; 
 Wed, 27 Dec 2023 14:52:29 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a17090264c800b001d1cd7e4ad2sm12800875pli.125.2023.12.27.14.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 14:52:29 -0800 (PST)
Message-ID: <d99f7393-1540-4167-b864-313f343f53e4@linaro.org>
Date: Thu, 28 Dec 2023 09:52:24 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/35] target/arm: Don't honour PSTATE.PAN when
 HCR_EL2.{NV, NV1} == {1, 1}
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-19-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/18/23 22:32, Peter Maydell wrote:
> For FEAT_NV, when HCR_EL2.{NV,NV1} is {1,1} PAN is always disabled
> even when the PSTATE.PAN bit is set. Implement this by having
> arm_pan_enabled() return false in this situation.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

