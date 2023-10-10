Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0817E7C01B1
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 18:33:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqFeE-0002BV-4T; Tue, 10 Oct 2023 12:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqFeB-0002AM-FF
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:31:51 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqFe9-0000mM-QR
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:31:51 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-692eed30152so4373520b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696955508; x=1697560308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vB+QmkraRtZCsi89Zf4K6tayTUTJ0Cs24dgBq9pAp9k=;
 b=MlsYdXxn90UyRj2oemHWved1rsjq34VgEEgyZR9w/P9T0571yOxNHAU9BaYTxoWBrQ
 ds0UV4SnUr7fohccoXsuMORRPyBr7KPKazaTYprkRvhlOV4OfXNGvLGyPjfosn7s2GMY
 cTCF0M4E0+L4FlzpEs8LZjd1SNxXvE01RTiKcbD5Afz73y444V6in1rKNh/aDO5TAAmO
 FmX/As0JbXcJX8O6YguxY/bPk77njn7z2eOJD60dUPEChjK5VJAM20IVBoc7Q9u49tOI
 +43paeewzqzJRr0hIj/6ZtpCxkMudaJsBKQT9q/nU0LwAXCh8huz7piJ7ZwNdEkKxOuw
 CYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696955508; x=1697560308;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vB+QmkraRtZCsi89Zf4K6tayTUTJ0Cs24dgBq9pAp9k=;
 b=gkfH5m5oYSmDQcWvZ66FI/2uIvkiy9UKjXkJdsyyBZHe9RJkyJ45mxnwVMC9tyUpIY
 bRUXwpAXFxSYabZI3bx8+tg75frp+7C9e1wrMPwWb66FInvgXbPJcTn+m/cpKsiYZlzg
 s3PT+XRSEUCQBXzn79ycJ58m+cinkVuU0yfPrgR5rMn6RVUr01VnoajlT9IYrux+JlWE
 QZV0Xv7GsnWDKO9Vnf+YXrkera18LcYzXUzw3Fam+liAAvREMypjiOM7XNPM24lfBSD0
 9YC4rFpzGsi3xlwseijNd6gkwERUdG1SAuvYtahFwP63xbwSekYAL8wCtYeGhq1F394D
 h+Lw==
X-Gm-Message-State: AOJu0Yza9KNokufBYJ5pHoTt/yATtIO3j5VcCMTpyKdaeKiy/q4GV2Gs
 Kv85ThjLJp5S7Qik+4gas2WLbg==
X-Google-Smtp-Source: AGHT+IEhgdZ3OLyrnBc+K591gDtfc4ZG2+l2n5aLhau5uScWBR5rAAeRfzg2vgDh3/isfXZYAqhQuA==
X-Received: by 2002:a05:6a20:9189:b0:153:b16e:8db1 with SMTP id
 v9-20020a056a20918900b00153b16e8db1mr19064107pzd.10.1696955508114; 
 Tue, 10 Oct 2023 09:31:48 -0700 (PDT)
Received: from ?IPV6:2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d?
 ([2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d])
 by smtp.gmail.com with ESMTPSA id
 h18-20020a170902eed200b001c5bcc9d916sm340376plb.176.2023.10.10.09.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 09:31:47 -0700 (PDT)
Message-ID: <71193623-d5fc-44f9-8fe3-325b33c85c58@linaro.org>
Date: Tue, 10 Oct 2023 09:31:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Use a direct cast for better performance
Content-Language: en-US
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com
References: <20231007090232.3329594-1-rjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231007090232.3329594-1-rjones@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 10/7/23 02:02, Richard W.M. Jones wrote:
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
> ---
>   target/riscv/cpu_helper.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 3a02079290..6174d99fb2 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -66,7 +66,11 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>                             uint64_t *cs_base, uint32_t *pflags)
>   {
>       CPUState *cs = env_cpu(env);
> -    RISCVCPU *cpu = RISCV_CPU(cs);
> +    /*
> +     * Using the checked cast RISCV_CPU(cs) imposes ~ 5% overhead when
> +     * qemu cast debugging is enabled, so use a direct cast instead.
> +     */
> +    RISCVCPU *cpu = (RISCVCPU *)cs;

RISCVCPU *cpu = env_archcpu(env);

and avoid "CPUState *cs" entirely.


r~

