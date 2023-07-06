Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD3B74A306
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 19:20:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHSdj-0003tj-Cg; Thu, 06 Jul 2023 13:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHSdf-0003tS-9t
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 13:19:32 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHSdd-0006lg-OK
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 13:19:31 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7918b56b1e1so375682241.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688663968; x=1691255968;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ACeImtJ6aqYZ8jPRsDxJiRPMcSs4ubbimdgrNHIRmjE=;
 b=RCJTdVmYM8hNuue7bJqQI2BHfArfk6pRX/HYEEoFwfhpQVoA7CftHpVPtfXOOgG3es
 b6wUHhMaXg4j+nrAZUpMf/vDEyLXm3WHrHaIFjooMrUIwd8NFUeYml7PrlTbu55yJV9m
 totUo5UK83/N1Ztp3ujF668N7ewEzwaxmRFl8a9E4+2MUkmEgpVbPZ0yHNZgB0acra7t
 c4q4KiS/3+AnxiBDsoln6eX3FbwcrarZvu6LgbvjpDAJp0pfAOYnaBX2/cILTFebCn6Y
 rC0k/tDw2fIPP7akeGXW7q9fYfwI5Ek7vK1jEEsB4jGtVWIK00vpbULnTK2v5ORVglG7
 0UGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688663968; x=1691255968;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ACeImtJ6aqYZ8jPRsDxJiRPMcSs4ubbimdgrNHIRmjE=;
 b=OaHNLdetrTxl0JGHv5krsFAIKiOOCI4WTzbOcv/VVEGn3RSGXiF7ZS1qkU7RPXaeZL
 kQAglP1l+czW5cBCHLLcaAK7n2/P6crUlpmcRPkQmOfvkswONHzgJe5SziY+gSezKfKi
 po2RVqmjgN2nCjZHfEStCaWZdlrsaUJmnGUlZR3qWjW2w3M2DgVRhNBlNprq6S+pSCxP
 RWz2MLuhjdfxkpL7Yqy4ipIiBaTs5bKJUNDgfcOZczZpp33wKgGbdUGxfCxFfEu+TJDR
 iHJ9NnvUEnp8vTCwiZ8qHXV/pQVyWuSjZFOs9kF1s1vSXbts5mElkKb/9++3Nr2UhShv
 ncOg==
X-Gm-Message-State: ABy/qLZB/XS+6PyfT1mcgPPTsNJktl8rG1JAtcqRX5W+dOa2r0UbaQy0
 +yAq7FrVStke0E4cthQP2Hqnzg==
X-Google-Smtp-Source: APBJJlFp9mmCwnFaF7Bn5tDQR8v2LMPj2Gblla5L5+fUfh1kfqRT+4lmDyrotX8r7pQ/KFP0e0pQLA==
X-Received: by 2002:a67:f919:0:b0:444:ca02:98fb with SMTP id
 t25-20020a67f919000000b00444ca0298fbmr1601022vsq.21.1688663968183; 
 Thu, 06 Jul 2023 10:19:28 -0700 (PDT)
Received: from [192.168.41.77] ([95.152.217.99])
 by smtp.gmail.com with ESMTPSA id
 r28-20020ab04a5c000000b0079407293668sm185368uae.16.2023.07.06.10.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 10:19:27 -0700 (PDT)
Message-ID: <86bb5275-3e56-9b25-d75c-b9d8509447bf@linaro.org>
Date: Thu, 6 Jul 2023 18:19:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v2 00/14] target-arm queue
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230706132512.3534397-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230706132512.3534397-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/6/23 14:24, Peter Maydell wrote:
> Changes v1->v2 (fixing CI failures in v1, added a couple of
> extra patches in an attempt to avoid having to do a last
> minute arm pullreq next week):
>   * new patch to hopefully fix the build issue with the SVE/SME sysregs test
>   * dropped the IC IVAU test case patch
>   * new patch: fix over-length shift
>   * new patches: define neoverse-v1
> 
> thanks
> -- PMM
> 
> The following changes since commit 2a6ae69154542caa91dd17c40fd3f5ffbec300de:
> 
>    Merge tag 'pull-maintainer-ominbus-030723-1' ofhttps://gitlab.com/stsquad/qemu  into staging (2023-07-04 08:36:44 +0200)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git  tags/pull-target-arm-20230706
> 
> for you to fetch changes up to c41077235168140cdd4a34fce9bd95c3d30efe9c:
> 
>    target/arm: Avoid over-length shift in arm_cpu_sve_finalize() error case (2023-07-06 13:36:51 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Add raw_writes ops for register whose write induce TLB maintenance
>   * hw/arm/sbsa-ref: use XHCI to replace EHCI
>   * Avoid splitting Zregs across lines in dump
>   * Dump ZA[] when active
>   * Fix SME full tile indexing
>   * Handle IC IVAU to improve compatibility with JITs
>   * xlnx-canfd-test: Fix code coverity issues
>   * gdbstub: Guard M-profile code with CONFIG_TCG
>   * allwinner-sramc: Set class_size
>   * target/xtensa: Assert that interrupt level is within bounds
>   * Avoid over-length shift in arm_cpu_sve_finalize() error case
>   * Define new 'neoverse-v1' CPU type

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


