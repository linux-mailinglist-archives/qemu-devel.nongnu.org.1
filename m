Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3DC740584
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 23:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEG7C-0004DV-DE; Tue, 27 Jun 2023 17:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEG74-0004D7-5E
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:20:38 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEG72-00079V-Ao
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:20:37 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-986d8332f50so632538066b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687900835; x=1690492835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v6o7p0DiJ2Xsbd/IQge6tJOiaSTLEHYOk/zbQydUGgc=;
 b=PEQKpmI75Qn0scpnTjECgb5ake1TLwTmktjHJZq366NW5jN5nddKzQ0PoJ2kr91ClA
 8JzDNXUoZ1OK8GsXJOhWkXJVAgEpH2V32v3tF6o0Y69NGsYO8wsmbXbdR65OMAswKPJY
 QQ6BKDWekvPCC+fI3+gag2kvtkZjlTrrY9Jt7s0NZFoDuL1DvpReT9b5NxmZ7UPR5Rmh
 xc7wL5Si7AX4U+rkfmVQSfSkMJ9rrnBvDCxxe21BMHEu/Ym+UKxZ4nvn8QtOFu1TY2dF
 8H+RLtDWEofPyh7QwcbGegc+XHhL8qVkKb/rDD/YS2V8ESaimDKSrc6B7WhRx1Pao735
 7KNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687900835; x=1690492835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v6o7p0DiJ2Xsbd/IQge6tJOiaSTLEHYOk/zbQydUGgc=;
 b=Xs1aqdSmpKfYtKSpCaDko7XQxRJivBiBC/gJ/ak+ctifk24XbPYP0nXIqI/6hNC8zx
 o4fC8yWkxNxaa7DVvNHKNe/RS8susNARI0f/udOKyjfpoFArMRuDbC1olxCBIbeVaqyy
 Bl0q2i1XBNLhgPeaBg+0zZ7W/EiqR/PmNsNL4LX6jfcENCAsMXdZQmg6H5EfP6IirNDa
 o9HR2/+WabbdPNhnZ0nUSA5aMd5wB8lmZCt7kmbs5eNdJde8EBht86CxLe5LtcDBWyJW
 RPUlCJnqAXsP3RH8SHoMeRtXNXrLGTcqC73Uh3/YUQM5enjHOcBqnV/w4uwLD28w+pfz
 qLqA==
X-Gm-Message-State: AC+VfDydLgTOuwK8Ui/ktF4+EegCWtlPjQaukDg/VdWTSz8eqP9YiJMN
 CWhSp2VUCab+C0HbXhACPICgVPQnGAFZwYceKOY=
X-Google-Smtp-Source: ACHHUZ7xP1HpQb4fPovfpi0XKf4usW7SvoHfuZUluylDuD20CwK/JuaDZDi5MKX3EcovA5TcoqQcCg==
X-Received: by 2002:a17:907:d0c:b0:973:91f7:508a with SMTP id
 gn12-20020a1709070d0c00b0097391f7508amr32242942ejc.4.1687900834940; 
 Tue, 27 Jun 2023 14:20:34 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 sd25-20020a170906ce3900b00991e4bc6717sm2257225ejb.6.2023.06.27.14.20.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 14:20:34 -0700 (PDT)
Message-ID: <d3f2ec9d-dcad-d5a3-8587-d39f9479158f@linaro.org>
Date: Tue, 27 Jun 2023 23:20:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v5 02/19] hw/riscv/virt.c: skip 'mmu-type' FDT if satp
 mode not set
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com
References: <20230627163203.49422-1-dbarboza@ventanamicro.com>
 <20230627163203.49422-3-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627163203.49422-3-dbarboza@ventanamicro.com>
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

On 27/6/23 18:31, Daniel Henrique Barboza wrote:
> The absence of a satp mode in riscv_host_cpu_init() is causing the
> following error:
> 
> $ sudo ./qemu/build/qemu-system-riscv64  -machine virt,accel=kvm \
>      -m 2G -smp 1  -nographic -snapshot \
>      -kernel ./guest_imgs/Image \
>      -initrd ./guest_imgs/rootfs_kvm_riscv64.img \
>      -append "earlycon=sbi root=/dev/ram rw" \
>      -cpu host
> **
> ERROR:../target/riscv/cpu.c:320:satp_mode_str: code should not be
> reached
> Bail out! ERROR:../target/riscv/cpu.c:320:satp_mode_str: code should
> not be reached
> Aborted
> 
> The error is triggered from create_fdt_socket_cpus() in hw/riscv/virt.c.
> It's trying to get satp_mode_str for a NULL cpu->cfg.satp_mode.map.
> 
> For this KVM cpu we would need to inherit the satp supported modes
> from the RISC-V host. At this moment this is not possible because the
> KVM driver does not support it. And even when it does we can't just let
> this broken for every other older kernel.
> 
> Since mmu-type is not a required node, according to [1], skip the
> 'mmu-type' FDT node if there's no satp_mode set. We'll revisit this
> logic when we can get satp information from KVM.
> 
> [1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/cpu.yaml
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/riscv/virt.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


