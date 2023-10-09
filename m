Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B36FE7BD872
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:24:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpnQg-00015Q-5I; Mon, 09 Oct 2023 06:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpnQe-00015F-QW
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:24:00 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpnQd-0004Ce-7l
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:24:00 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9b2f73e3af3so745869266b.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696847037; x=1697451837; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Z4b7G/SFwIVi2v7PRX9eW9qQChjcCs5lp5d1EpGb1w=;
 b=hacTN2aG81o0Z5gos8WZlH9kWISu+ohwVDJaurF/Hbyb9cuKkZ7an3PezNsTuFMdey
 PCc1HkYhWHC3FnNRrHOUZYTtL0sqDK1YoGL3JHpYhNa29BPQ5MN6kr6bOtcU7u7M1iZW
 0O1snIMTROsIj8yhUzmWQZVvnZT47WNsGErdrlBV8jJ16zn/7GGnyCpL8LJh8/7lcsuD
 A0x0P9uye56dawLOwNuxza/xdP6ol5HIBv35ydPf1AIkMbyKe1Aj5L8s4EwRsDK2P7qs
 XaWpl6c2i/JulnjyDZzuHFSlMcX+Qh/KhSOHixusg4kM0Te6QnP4YKDca03nAaHlMC7I
 XxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696847037; x=1697451837;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Z4b7G/SFwIVi2v7PRX9eW9qQChjcCs5lp5d1EpGb1w=;
 b=ZBKKM5L4DQuTm2i5mv2MMvyNe2lmur4Kp5Pf0PSvsbOSQS5vXDveMypKZE8kiBQwYr
 CuM/bAwERwhkwEWVJWuh0B0hDOSgFgGD6NN/zXje8W7zIRkvmDh9IwI6fuQC73LzrabW
 hmMXC5DwlBXNek9ttb3XIDRGorqtkKrXH+CrGAN2V/ysk/7kO9n5gFIMulb9jOrvusly
 ZWuj+gaiy1HL7sICURjJk6LHL4W+C2p8EvGD3jSvrzEx3ZouWfh9faixiKuB3TumFXXe
 F8p0zR/X/pSB7d9ck+7nxZQsJxHqxnv9qMzzPKd7+IywClfIfUUdvHMC2CLiUgtWLU6f
 bA+A==
X-Gm-Message-State: AOJu0YzzAHe9s4RwvyQqGbxIJMi7jyyXQ/sIM6K05fQB5MNqZg+NE0Aa
 82UgOmhXxlS+T78rXMrwDKAPNA==
X-Google-Smtp-Source: AGHT+IGCHaZ7CExS0iXpMkqikxd3bS7ftbCsbm1Gp6Mo1hvuKHUS+f5JwWdK+owLNKA6yUP7NQs5MQ==
X-Received: by 2002:a17:906:1097:b0:9ae:4878:1172 with SMTP id
 u23-20020a170906109700b009ae48781172mr14149491eju.7.1696847037487; 
 Mon, 09 Oct 2023 03:23:57 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 jp20-20020a170906f75400b0099bcb44493fsm6610096ejb.147.2023.10.09.03.23.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 03:23:57 -0700 (PDT)
Message-ID: <87bc3f73-f3d5-0431-6339-6d8c978b89c4@linaro.org>
Date: Mon, 9 Oct 2023 12:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] target/riscv: Use a direct cast for better performance
Content-Language: en-US
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com
References: <20231008215147.3362612-1-rjones@redhat.com>
 <20231008215147.3362612-2-rjones@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231008215147.3362612-2-rjones@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.818,
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

Hi Richard,

On 8/10/23 23:50, Richard W.M. Jones wrote:
> RISCV_CPU(cs) uses a checked cast.  When QOM cast debugging is enabled
> this adds about 5% total overhead when emulating RV64 on x86-64 host.
> 
> Using a RISC-V guest with 16 vCPUs, 16 GB of guest RAM, virtio-blk
> disk.  The guest has a copy of the qemu source tree.  The test
> involves compiling the qemu source tree with 'make clean; time make -j16'.
> 
> Before making this change the compile step took 449 & 447 seconds over
> two consecutive runs.
> 
> After making this change, 428 & 422 seconds.
> 
> The saving is about 5%.
> 
> Thanks: Paolo Bonzini
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu_helper.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 3a02079290..479d9863ae 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -66,7 +66,11 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>                             uint64_t *cs_base, uint32_t *pflags)
>   {
>       CPUState *cs = env_cpu(env);
> -    RISCVCPU *cpu = RISCV_CPU(cs);

You might want to use:

        RISCVCPU *cpu =  env_archcpu(env);

Other occurences in target/riscv/internals.h.

> +    /*
> +     * Using the checked cast RISCV_CPU(cs) imposes ~ 5% overhead when
> +     * QOM cast debugging is enabled, so use a direct cast instead.
> +     */
> +    RISCVCPU *cpu = (RISCVCPU *)cs;
>       RISCVExtStatus fs, vs;
>       uint32_t flags = 0;
>   


