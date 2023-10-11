Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CBE7C480A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 04:56:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqPOa-0000BS-QZ; Tue, 10 Oct 2023 22:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqPOY-0000BC-To
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 22:56:22 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqPOX-00087y-0t
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 22:56:22 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso1101256666b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 19:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696992979; x=1697597779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lfejmu0fed9jzJQJl9bYK7nnwauq98g5xtw+qWD1PB4=;
 b=zN0pK2RJkVTkDossO+3x4VCIzekUx7GTD1lNPODcoVKthr5kdY6D6+c+YjWMcyKUoF
 1vzD8ofVoIe8guVJLP0/3sAuDmWTVUPm+sh/4wKGT+bYpcI7cYUQCH9KGjoNVJZvrKPH
 gSGT4C4VBiAyYFGzIDNtO3ddg3jNTsIuUxsuV0AlXncquFgMYIysBxk5qhJXVel8bUpx
 tkFNXMoSLRbnZcgBnK7RN/oPZtKs4G4KAQ66P8YqiLAPC1BB3rOAV6UycoIgRA8GXPSU
 ubrkKUMWuxeuKqvnAmjToW8erISBtSoOrdaVGs94ugN5QHKjNQBXmPdeaDhUoEdAFL5v
 KaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696992979; x=1697597779;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lfejmu0fed9jzJQJl9bYK7nnwauq98g5xtw+qWD1PB4=;
 b=FKHGgqKL+MVaTnGHNZMY5F8e4PZJDwkWRJh4YufI2pD7KuIMT135qa+5DSl+gaSnd6
 VQWjAvW6DZGvz8MnhJBoBHUoWu52oOLI90X41ydFoaXoK+7l0UQx3/m4xxatOrJ2jGE/
 KnlJFiEhLpwiyAyKt8/OQqH6Q+lE7ovQt1Xfgz1TOlAkCyPcAY+oaNYWedYH7jwwelGP
 37oB6kjXNvx6gaRQdsaGTG7GvGKPjBUZ2yKVJGW/1AThpzDZclvswtmP+zjpONzm37tU
 NWHVOoCyTKb91obbKPN0AtXdnNUU3SpEyEG33FUwafqZUKdbGRLNoKujxMBw+Za7yzCn
 t7BQ==
X-Gm-Message-State: AOJu0Yy/o/Hl5aF9e0v3OkBF/87RGMbuWSFUBgxaWMcYAYjIYxjwr+yY
 z+qp15UcVi02NqqneU87hyCg7g==
X-Google-Smtp-Source: AGHT+IEUiOgBTZwsDp2qaWW9mB0p6/rF7r1VbnY60qxYtxdDpcO86CsSe1aSdzoojgJBUbOlxkKJkw==
X-Received: by 2002:a17:906:846c:b0:9b6:8155:cbf4 with SMTP id
 hx12-20020a170906846c00b009b68155cbf4mr17170768ejc.47.1696992979194; 
 Tue, 10 Oct 2023 19:56:19 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 si5-20020a170906cec500b009ae0042e48bsm9129261ejb.5.2023.10.10.19.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 19:56:18 -0700 (PDT)
Message-ID: <1f552f71-3b47-a2be-67c5-fdca86bf59f7@linaro.org>
Date: Wed, 11 Oct 2023 04:56:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH RFC v4 4/9] target/loongarch: Implement kvm get/set
 registers
Content-Language: en-US
To: xianglai li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Bibo Mao <maobibo@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <cover.1696841645.git.lixianglai@loongson.cn>
 <f4399db694265f34dbe9aafd024c56470e8a0f54.1696841645.git.lixianglai@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <f4399db694265f34dbe9aafd024c56470e8a0f54.1696841645.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Li and Zhao,

On 9/10/23 11:01, xianglai li wrote:
> From: Tianrui Zhao <zhaotianrui@loongson.cn>
> 
> Implement kvm_arch_get/set_registers interfaces, many regs
> can be get/set in the function, such as core regs, csr regs,
> fpu regs, mp state, etc.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: Tianrui Zhao <zhaotianrui@loongson.cn>
> 
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>   meson.build                   |   1 +
>   target/loongarch/cpu.c        |   3 +
>   target/loongarch/cpu.h        |   2 +
>   target/loongarch/kvm.c        | 406 +++++++++++++++++++++++++++++++++-
>   target/loongarch/trace-events |  13 ++
>   target/loongarch/trace.h      |   1 +
>   6 files changed, 424 insertions(+), 2 deletions(-)
>   create mode 100644 target/loongarch/trace-events
>   create mode 100644 target/loongarch/trace.h


> +static int kvm_larch_getq(CPUState *cs, uint64_t reg_id,
> +                                 uint64_t *addr)
> +{
> +    struct kvm_one_reg csrreg = {
> +        .id = reg_id,
> +        .addr = (uintptr_t)addr
> +    };
> +
> +    return kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &csrreg);
> +}

This is kvm_get_one_reg().

> +static int kvm_larch_putq(CPUState *cs, uint64_t reg_id,
> +                                 uint64_t *addr)
> +{
> +    struct kvm_one_reg csrreg = {
> +        .id = reg_id,
> +        .addr = (uintptr_t)addr
> +    };
> +
> +    return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &csrreg);
> +}

This is kvm_set_one_reg().

> +
> +#define KVM_GET_ONE_UREG64(cs, ret, regidx, addr)                 \
> +    ({                                                            \
> +        err = kvm_larch_getq(cs, KVM_IOC_CSRID(regidx), addr);    \
> +        if (err < 0) {                                            \
> +            ret = err;                                            \
> +            trace_kvm_failed_get_csr(regidx, strerror(errno));    \
> +        }                                                         \
> +    })
> +
> +#define KVM_PUT_ONE_UREG64(cs, ret, regidx, addr)                 \
> +    ({                                                            \
> +        err = kvm_larch_putq(cs, KVM_IOC_CSRID(regidx), addr);    \
> +        if (err < 0) {                                            \
> +            ret = err;                                            \
> +            trace_kvm_failed_put_csr(regidx, strerror(errno));    \
> +        }                                                         \
> +    })


