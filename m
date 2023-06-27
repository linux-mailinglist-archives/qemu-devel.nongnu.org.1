Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C75D173FC22
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:44:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE82i-0006kI-DQ; Tue, 27 Jun 2023 08:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE82f-0006fr-MW
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:43:33 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE82d-0001Zt-Ej
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:43:33 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-98e0c1d5289so397271766b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687869809; x=1690461809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1mTG0cvKU+zMeoqHlEai9X0XN4bdRY0Fj+S2ZVFglsw=;
 b=JGscvSjGoIt5zVRLMj+z4pQB3/0FtPmXup22DqGc0zhhp0riN4aIMg20E/BBLW2E98
 WdgKEMXAsf/vjSlW+0rzfMzh92/bntJIhsUWrs+pYQ2RCqNBJn7CruxkEX4Num2CPpjq
 Cu1VAziumpAykPKlGGwPoVrLybX8oEiiXC+oMQ6cOOpJ6MspwTxN5xTynf2HfJc/4PuS
 agFOT6HJF3FjtKyGBOUzZ4+wnAxZAWbCIkMijKhC8/MTL7fmrPW4o1umQGjvwNPZj3qk
 Dv8C/gAh/xvAnE5RsFwiY2mA4XOXlcUBSuvjWJC3jAaqrWkQFNjoTjLU6ISTyg2Xge7U
 FZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687869809; x=1690461809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1mTG0cvKU+zMeoqHlEai9X0XN4bdRY0Fj+S2ZVFglsw=;
 b=RgF54Ar1RJQ6OWzGU8jWAYZKdj9NEVLeMS/ZeoveGMjdnacDIhrHTCZePSBAkInPd/
 UHXbZ6OB1f271YcSQytTy1nkeS8wU/htQSwiH5jj5kD4bZz0fnjLMxFPuMOJyRDum0fw
 0DlapQQJHBHPV2vDhdA9KeEuuRG+a5QlOz6f1eUDJTJ99pHgdMAK3GpmHZGHSZBUpvQR
 LM7WFvzSeUbHlo6sYR+Axl24DtsRnVTLRCTcX96wrFobva2l/i8cYCLoS3TtbMbi3YG/
 WC9+OKV/F4ofoDTWf5d6JKLZ3BJCPQGx+oWA/ILFBMD6NbXTDPcaUPS6jA44FA2xYwNC
 ICOQ==
X-Gm-Message-State: AC+VfDw9iJIv3Zg/SuRVwMubYYIX3cKFWAs1vUfuRB9CyDymC0s2V+8b
 8+BHCJr2gMrXMF+9vdtKgcQuS29hzZKfrfUEjQM=
X-Google-Smtp-Source: ACHHUZ7fuT0GL83RVg8Gj86ErRvzE6j5P8CLlQ8jWsCVG81jwLRBBrRfpqNvsX0LXyM1vFUtszJWyg==
X-Received: by 2002:a17:907:a42c:b0:991:bf04:204f with SMTP id
 sg44-20020a170907a42c00b00991bf04204fmr5098434ejc.60.1687869809706; 
 Tue, 27 Jun 2023 05:43:29 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b0098dd3981be9sm4477872ejg.224.2023.06.27.05.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 05:43:29 -0700 (PDT)
Message-ID: <7b6c659f-a9d3-c883-ff53-3226c8d31bb8@linaro.org>
Date: Tue, 27 Jun 2023 14:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 16/16] accel: Rename HVF 'struct hvf_vcpu_state' ->
 AccelCPUState
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, xen-devel@lists.xenproject.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paul Durrant <paul@xen.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230624174121.11508-1-philmd@linaro.org>
 <20230624174121.11508-17-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230624174121.11508-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 24/6/23 19:41, Philippe Mathieu-Daudé wrote:
> We want all accelerators to share the same opaque pointer in
> CPUState.
> 
> Rename the 'hvf_vcpu_state' structure as 'AccelCPUState'.
> 
> Use the generic 'accel' field of CPUState instead of 'hvf'.
> 
> Replace g_malloc0() by g_new0() for readability.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Not even built on x86!

Per IRC chat:
Tested-by: Peter Maydell <peter.maydell@linaro.org>

> ---
>   include/hw/core/cpu.h       |   4 -
>   include/sysemu/hvf_int.h    |   2 +-
>   target/i386/hvf/vmx.h       |  22 ++--
>   accel/hvf/hvf-accel-ops.c   |  18 ++--
>   target/arm/hvf/hvf.c        | 108 +++++++++----------
>   target/i386/hvf/hvf.c       | 104 +++++++++---------
>   target/i386/hvf/x86.c       |  28 ++---
>   target/i386/hvf/x86_descr.c |  26 ++---
>   target/i386/hvf/x86_emu.c   |  62 +++++------
>   target/i386/hvf/x86_mmu.c   |   4 +-
>   target/i386/hvf/x86_task.c  |  10 +-
>   target/i386/hvf/x86hvf.c    | 208 ++++++++++++++++++------------------
>   12 files changed, 296 insertions(+), 300 deletions(-)


