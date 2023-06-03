Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 765B4720DFB
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 07:49:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5K8G-0003vv-OH; Sat, 03 Jun 2023 01:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5K8E-0003vU-4B
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 01:48:54 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5K8C-0006jW-LB
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 01:48:53 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-51b4ef5378bso2644275a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 22:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685771331; x=1688363331;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EOdk+HUMN2eR6RYccMzF9Dr9ED6N3+pWS8567hzCL1c=;
 b=lNCk5lSXjElxx+ca8CnKoB2eylkz1rQ42k9VXvUJqMRVUqUVTI+xqSwfYVGhxNyE6h
 WjhAt/Wn92T+2mkcYP4ISBP7bODOT9FQtls3PoSMm5aHaXH61fnr/IxSRCP1Li7uWvpd
 rhORA09uzx2x8Yk9mHkwEZMWZKyzypTKzjruXpchvPKA+hi7TWySJY5VgyPKiB+Y0afW
 TXF2VZC0sycuBIBKLQhI8zwCAxJpOHkrtT6ha3VhGU/DAOMafIMovihbwU0AupQlednJ
 SfcrhJXEoyzsrKmuOTxIyUUm4Ik7fwkKfRWLEpyyR+dVH2KwEdbK4YWZaqHqwjBBzJch
 K7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685771331; x=1688363331;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EOdk+HUMN2eR6RYccMzF9Dr9ED6N3+pWS8567hzCL1c=;
 b=DpfMzsI8E0U009QPWdInEGdPUbgRGlAH5YBNIMPMnslVzqJ4L/ITebA24NgEFREnFL
 I/DM3s3PIkfo64223WtIMP8Dz0mPm7UqxHPsu/lkTDjHBjtZ7uX8Vzv9BbvGOVuV5rxU
 mhCrIo6m3BpOP4arz4Rm/9y3PVwNBLHw9+reQSdA531FoOBR/ziofnMeJGr07Wgu5e9g
 3ltGFhFLO6KvbT7HfNqLZBqeT0XoD8DMCIfhXLJpA8ORpsaJc++8M9t6/bWyKw3vN/PC
 daTmTwMRkT5TOuy2DHGqnI70AqmFMCuUWG1aoxSH/MPsKqdHyuE9vP7Oq8RoKIEhGGFs
 QE1w==
X-Gm-Message-State: AC+VfDwK0Hcot2sPLEdom+g/3uQyKYUvZhIjXmAIYi/xO3Jndb2ptIvW
 L4wkR/k6h9Vw43kHtdM494WJ8jwxusBlOxcYahQ=
X-Google-Smtp-Source: ACHHUZ6cTfSo5AU7n8zRtd8LWwOsNSMOlMdy+8H0PXkUABYiSISMNLZt0cFXsmzpBBjT2Hm8aiWIlw==
X-Received: by 2002:a17:903:124a:b0:1ae:8892:7d27 with SMTP id
 u10-20020a170903124a00b001ae88927d27mr2062218plh.42.1685771330927; 
 Fri, 02 Jun 2023 22:48:50 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a17090322c400b001ac5896e96esm2304849plg.207.2023.06.02.22.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 22:48:50 -0700 (PDT)
Message-ID: <f031f9b5-f7e7-315e-26db-010994230695@linaro.org>
Date: Fri, 2 Jun 2023 22:48:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 03/20] target/arm: Convert barrier insns to decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 6/2/23 08:52, Peter Maydell wrote:
> +# Barriers
> +
> +CLREX           1101 0101 0000 0011 0011 imm:4 010 11111
...
> +ISB             1101 0101 0000 0011 0011 imm:4 110 11111

The two imm:4 fields are ignored; use ---- instead?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

