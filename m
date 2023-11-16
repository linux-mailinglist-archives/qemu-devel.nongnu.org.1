Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDAB7EE4F8
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 17:09:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3euk-0007h8-Ew; Thu, 16 Nov 2023 11:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3eui-0007gS-H9
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 11:08:20 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3euf-0001AA-Qp
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 11:08:20 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c54c8934abso12952201fa.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 08:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700150896; x=1700755696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bbt3Z6ihV8TA3zjJcKpw5cDUTO6AlSytICD8fk5xQeQ=;
 b=gc03RLABEXrarFnZ8LA+RJWLFtbQkEAzccCL8lAXTPPJ/H8A3kMXDguc9z9Z4dijLf
 kbEcC2s/Bkj0bJDgXWeCRJaZKxrQwmFhk0NTvGIxscaKXxH9uzGTDscFJsMxDTk9V2Qf
 ZwqI0FRl36nJKq4/VY6dzIrCa1Cmu0/GQyT7nRzOy0kDe1F9ycWBQ5B9hacUF7sMAUvV
 nVOjIBwzMJdn+ZnD3Sks0tY76UQBLiCjhiGq5OgYkPaCui0T/a8Cjkm12llRDxVinl2E
 ZRDeO52QdnNqla528gxvh4SMvM+bqf7BZlPnXBkqK7zyshhh9M1YN1AppBCtTNs0veeb
 Jgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700150896; x=1700755696;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bbt3Z6ihV8TA3zjJcKpw5cDUTO6AlSytICD8fk5xQeQ=;
 b=W236F9Fj3r+wNHiJ1qA8fmwQfz0HQdS8ZNfQnkPrlQu4qG5OzLiohQKwqz7s7t9yIp
 5rfy1KEvT+H3h/yMKhsiL06DSgixUx5ulZ6NgQPSxlwA5BWTy/XA0+VtKHBU1aeGqDpg
 QbQhte9WEToxp7kkZ6J+qz2Wbv8rq7EULW3c9h0/AJU3D3PuVU9vvJplxUQJd3b8Xsjw
 aYXPoL6uovHUPjP1Po5BvgOBLw91Z7EqA5ze8DlkbqF+0C0IWsb/UETGJlgNDNl0CiNX
 dLyrnt4pFkyRB1tQPIB4n7qmJ5ctfKlfbWJ+VLwOXjeIGl/rO2mIL5ECyRBei/VRy4Fl
 9T8g==
X-Gm-Message-State: AOJu0YzX6WrgLVGmypRzhFUCL4HtmwN5U1P2IXfnuFKND+7NRLsEEjpi
 CiHRl2v4dI6lQwgolVozmiCYXA==
X-Google-Smtp-Source: AGHT+IHnKVTf3wkdeY89d1vkwnb/JryKdw9OT+Zg7iJ+beWhg7xwa9qleI0kR336xkKrChw+J4QEvg==
X-Received: by 2002:a05:651c:1422:b0:2c6:eb44:2e12 with SMTP id
 u34-20020a05651c142200b002c6eb442e12mr6895205lje.43.1700150895898; 
 Thu, 16 Nov 2023 08:08:15 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 az23-20020a05600c601700b004054dcbf92asm4353398wmb.20.2023.11.16.08.08.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 08:08:15 -0800 (PST)
Message-ID: <d7a80e9e-9ffd-476c-ac98-a92838e11b5e@linaro.org>
Date: Thu, 16 Nov 2023 17:08:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/31] cpu: Call object_class_dynamic_cast() once in
 cpu_class_by_name()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 imp@bsdimp.com, kevans@freebsd.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org, imammedo@redhat.com,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com,
 kfting@nuvoton.com, wuhaotsh@google.com, nieklinnenbank@gmail.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, mrolnik@gmail.com,
 edgar.iglesias@gmail.com, bcain@quicinc.com, gaosong@loongson.cn,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, shorne@gmail.com, npiggin@gmail.com, clg@kaod.org,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com, shan.gavin@gmail.com
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-4-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114235628.534334-4-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 15/11/23 00:56, Gavin Shan wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> For all targets, the CPU class returned from CPUClass::class_by_name()
> and object_class_dynamic_cast(oc, CPU_RESOLVING_TYPE) need to be
> compatible. Lets apply the check in cpu_class_by_name() for once,
> instead of having the check in CPUClass::class_by_name() for individual
> target.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Gavin, this patch is missing your S-o-b tag. Do you mind responding to
this email with it? Thanks!

> ---
>   hw/core/cpu-common.c   | 8 +++++---
>   target/alpha/cpu.c     | 3 ---
>   target/arm/cpu.c       | 4 +---
>   target/avr/cpu.c       | 8 +-------
>   target/cris/cpu.c      | 4 +---
>   target/hexagon/cpu.c   | 4 +---
>   target/hppa/cpu.c      | 7 +------
>   target/loongarch/cpu.c | 8 +-------
>   target/m68k/cpu.c      | 4 +---
>   target/openrisc/cpu.c  | 4 +---
>   target/riscv/cpu.c     | 4 +---
>   target/tricore/cpu.c   | 4 +---
>   target/xtensa/cpu.c    | 4 +---
>   13 files changed, 16 insertions(+), 50 deletions(-)


