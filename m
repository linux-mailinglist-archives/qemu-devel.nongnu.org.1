Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE1875CA30
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:38:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrFt-0006MY-Hy; Fri, 21 Jul 2023 10:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMrFq-0006LQ-NT
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:37:14 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMrFp-0000jn-2z
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:37:14 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31438512cafso1698707f8f.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689950231; x=1690555031;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kk8wB/JqPLkU/SzyS/BOhjWKztvFr3bHFKf4h8PkNI4=;
 b=jnR3YQOcUx1yPYSBH7KH8Vym/X55//QJgH4PPvpxRi+ean/QBoQRxURULP46ZMcO75
 i/4fQx0LKeaoeUAsZ6j4V7DgewTo3NkU60qOLY0ip11GHKv7d3Dj1yZiEITXmGHVO1g2
 55JrcTZBurwhUrcRPVwJYboO0Tur0q4ALEAxiU2BwhNFPnaH71i2TWuc7rSLnJwo+erN
 /okovWblVqEQh9feY1I9F98lHz73aimtsTV3HtCTPSgxaR0XxU/8xmNoj6XkwVcAXKHl
 tfWmVGK41Gr4trcPOMiQdiPiVKIhhMQVe5sqw95hspf1VjgsxIIFFdooJRERR5U0arbU
 Lirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689950231; x=1690555031;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kk8wB/JqPLkU/SzyS/BOhjWKztvFr3bHFKf4h8PkNI4=;
 b=exPRnFhP366rjCC6sLYz612bUDcIdyedPrwShcn1dLz/SejqPDxnfNFkudgYHqh1wo
 8PkriwVSIkIK8evEW8SlhpJ4IXkForjxDB/U+1xE6MjKjt1YRDnxGZdKAwb6NpD7tiYo
 Bb3LA8lMM1odNRNLW3Wepxge0F7vVSw+n0K7FBWSTVJlYUZ2+amH7i1dg1kqDyB77/cj
 PzldeKrpqYJ1qkKJSfKZtVjUJ5lfWXTiim3REKPKqmjyI1eGhkTepiQVcJqKePkrwKn6
 4et+Ar8ndETebMFzfH4APlj7Ye5wiUz7kkLhH5DZ0YkM8IJF6Vz+33XITdn//FfvvFJ0
 HU6A==
X-Gm-Message-State: ABy/qLZrgLS10iZZX1u+hLQ2dD9UUrpRb7+2pPyxzFTQAj0XbEt2N/Ef
 xKR2yM7roGl+Blw0gzdSwj46oA==
X-Google-Smtp-Source: APBJJlGVqPRWLN8CzqdZnhzvVBnO2sGyHhBlHiDw1aKCWmO75jBqhxuiFZaaOhdDdNiaazllhYzs8w==
X-Received: by 2002:a5d:6952:0:b0:313:e8bf:a6e with SMTP id
 r18-20020a5d6952000000b00313e8bf0a6emr1638801wrw.21.1689950231034; 
 Fri, 21 Jul 2023 07:37:11 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.192.5])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a5d49cf000000b003143765e207sm4390907wrs.49.2023.07.21.07.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 07:37:10 -0700 (PDT)
Message-ID: <3b93823c-3d12-0d67-b814-54a3922d027f@linaro.org>
Date: Fri, 21 Jul 2023 16:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/riscv/cpu.c: do not run 'host' CPU with TCG
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20230721133411.474105-1-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230721133411.474105-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 21/7/23 15:34, Daniel Henrique Barboza wrote:
> The 'host' CPU is available in a CONFIG_KVM build and it's currently
> available for all accels, but is a KVM only CPU. This means that in a
> RISC-V KVM capable host we can do things like this:
> 
> $ ./build/qemu-system-riscv64 -M virt,accel=tcg -cpu host --nographic
> qemu-system-riscv64: H extension requires priv spec 1.12.0
> 
> This CPU does not have a priv spec because we don't filter its extensions
> via priv spec. We shouldn't be reaching riscv_cpu_realize_tcg() at all
> with the 'host' CPU.
> 
> We don't have a way to filter the 'host' CPU out of the available CPU
> options (-cpu help) if the build includes both KVM and TCG. What we can
> do is to error out during riscv_cpu_realize_tcg() if the user chooses
> the 'host' CPU with accel=tcg:
> 
> $ ./build/qemu-system-riscv64 -M virt,accel=tcg -cpu host --nographic
> qemu-system-riscv64: 'host' CPU is not compatible with TCG acceleration
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6b93b04453..08db3d613f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1395,6 +1395,11 @@ static void riscv_cpu_realize_tcg(DeviceState *dev, Error **errp)

/me wonders why this method isn't used as AccelCPUClass:cpu_realizefn().

>       CPURISCVState *env = &cpu->env;
>       Error *local_err = NULL;
>   
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_CPU_HOST)) {
> +        error_setg(errp, "'host' CPU is not compatible with TCG acceleration");
> +        return;
> +    }

We should manage that generically, likely in CPUClass.
We could define riscv CPU with a DEFINE_CPU_WITH_CLASS() macro to pass
the class_init() handler. Anyhow meanwhile your patch is sufficient, so

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


