Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F4829635
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:22:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUlY-0002iF-4S; Wed, 10 Jan 2024 04:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNUlU-0002hf-8V
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:20:48 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNUlS-0004YT-JE
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:20:48 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3376555b756so2195620f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704878444; x=1705483244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zRh7Q1VaMxmG+7vx/MbE/rf3HeKnarkuoHvJJEfgQVY=;
 b=SzeGYypaWvCwi0EF7oJXYaXpxyJJqHCZrOnPMYceWCTeCZeCEZrHkjU+cowRAtocjx
 C9JydvSPw8O2yBeQpw+1S6vFIjNc1e14VQQ49dstqqGamSjyONfpSHYoXeLRpoMRwrbc
 RwhScIexCXrR+a+EJtVqH3ZNktRDLSUAfYpQ+1nUj9INoYwt4KAUEWyPHvKp3u7gThHd
 Ns6qzSfHbNwEsF0FZjjTbRH1RUpFrx8P6U6vth8sSCSqdDqBO2cp5Uf3xgktxAN7FEOn
 PgAEwFQC5owGGZDNTCDmHdgapqVDFkDCftBbKsq1IhYP2L/5MipSczU3JlrDf5WJoc5E
 xC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704878444; x=1705483244;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zRh7Q1VaMxmG+7vx/MbE/rf3HeKnarkuoHvJJEfgQVY=;
 b=mJP+Btk/rhyQMBEELxCJbqCm87FwfHkn0v6y03asr7OkwYw4E5lkp6ROvepIKRvmM2
 D3/3PIf+Zd5T++mDTzSUUk29N0Kki4EByVMD9vjOBkuPUApJv9xF+m4JEArmzSrUkJ5c
 lmOcTnwgvNlgVPcKiEP+FtEXT+CjjeMj02dKfPSHQOWKXAOVtiquR0R0vzjDpk3Eg1Tz
 0FdliHHNoHizpufQ1X9EIwPCXp/wbmlf92GWEzxThlSRhkt5kwYrnYVBzi03nf8dXNTF
 2pzgYYl5bfxsnFbc2gJ9NRvoLqRGG/hXKMfSlGET5EOvwwjYJfYlE/eYC1F93HDcejg5
 mOxQ==
X-Gm-Message-State: AOJu0Yx9e5r4e4jiBiJOc1yZiS/GX2skjCWIavKYwOTXEKu8BFv0wsbn
 oBKYACQ5RtZj72/iiXHjTZNJ2owCnhRQvg==
X-Google-Smtp-Source: AGHT+IGP3zL69JxTPTQ/yrMMWJddtHXQJfT9n0CTJmGDLcGmLKVD78ZN+O0Fsr8PhtJNpxMGFss5IQ==
X-Received: by 2002:adf:f3c7:0:b0:336:c5b5:2713 with SMTP id
 g7-20020adff3c7000000b00336c5b52713mr444694wrp.43.1704878444379; 
 Wed, 10 Jan 2024 01:20:44 -0800 (PST)
Received: from [192.168.69.100] ([176.167.134.179])
 by smtp.gmail.com with ESMTPSA id
 df8-20020a5d5b88000000b003376d4248a9sm4394079wrb.71.2024.01.10.01.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 01:20:44 -0800 (PST)
Message-ID: <ce60886a-601e-454c-a8e2-a6844720a89d@linaro.org>
Date: Wed, 10 Jan 2024 10:20:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] target/loongarch: Implement set vcpu intr for kvm
Content-Language: en-US
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, yangxiaojuan@loongson.cn,
 xianglai li <lixianglai@loongson.cn>
References: <20240105075804.1228596-1-zhaotianrui@loongson.cn>
 <20240105075804.1228596-9-zhaotianrui@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240105075804.1228596-9-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Tianrui,

On 5/1/24 08:58, Tianrui Zhao wrote:
> Implement loongarch kvm set vcpu interrupt interface,
> when a irq is set in vcpu, we use the KVM_INTERRUPT
> ioctl to set intr into kvm.
> 
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> Reviewed-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c               | 34 +++++++++++++++++++++-------
>   target/loongarch/kvm/kvm.c           | 15 ++++++++++++
>   target/loongarch/kvm/kvm_loongarch.h | 16 +++++++++++++
>   target/loongarch/trace-events        |  1 +
>   4 files changed, 58 insertions(+), 8 deletions(-)
>   create mode 100644 target/loongarch/kvm/kvm_loongarch.h
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 6614a094c8..dfbbe0ace1 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -11,7 +11,6 @@
>   #include "qapi/error.h"
>   #include "qemu/module.h"
>   #include "sysemu/qtest.h"
> -#include "exec/cpu_ldst.h"
>   #include "exec/exec-all.h"
>   #include "cpu.h"
>   #include "internals.h"
> @@ -20,8 +19,16 @@
>   #ifndef CONFIG_USER_ONLY
>   #include "sysemu/reset.h"
>   #endif
> -#include "tcg/tcg.h"
>   #include "vec.h"
> +#include "sysemu/kvm.h"
> +#include "kvm/kvm_loongarch.h"

Shouldn't this header ^ ...

> +#ifdef CONFIG_KVM

... goes here?

> +#include <linux/kvm.h>
> +#endif
> +#ifdef CONFIG_TCG
> +#include "exec/cpu_ldst.h"
> +#include "tcg/tcg.h"
> +#endif

