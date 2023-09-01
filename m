Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDE478FF4B
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 16:36:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc5FG-0002sh-Rc; Fri, 01 Sep 2023 10:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qc5FB-0002iL-2Q
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:35:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qc5F7-0005vG-0P
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:35:27 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso1657412f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693578923; x=1694183723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0A14nTsMaWAlb4eO07U8xOqzu6M+h3W1AlcJ2Ln7R2E=;
 b=vU8g87mg4e/FQoyIb+y0YfIV3apiGTxrRaTfZkknSarb4RUSr+m36hNsrdmef8PpLt
 fIav+ndJlXrpIW0FouHsabb75xPcGJsmHLOEW408y772mvM/Gnj9zhiW1PaWtHlLQTRZ
 9iV3tNDAe9HiMv4voEjiJjOE9oedaJT7ZMpKfc17gRQeCYuEb3WB1Lx7Rqxjyzn1Msv/
 LvfIcecK4olkKaqVkZk6AtzgmsYdkkzFPB2mv0PZaDVz/QeKDkv7jksaV7QCeruavSww
 PBf1gG9kQ/jQ9Dj10Coig670uDsLS5zuRDx6L/ddwmaVTs0dpSuq3p5Dyt6wMN48sK4z
 EPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693578923; x=1694183723;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0A14nTsMaWAlb4eO07U8xOqzu6M+h3W1AlcJ2Ln7R2E=;
 b=eglo3FIF/A1n7m3H5wggB2SmTk1lUWkY9zlaCBE0wXDsJPHcZHEkcTjXyAQyKv+Cwd
 MUKUQU6KLpzQUBC4gE9eKofdLPJR50uZm0wvczo5nHGSYbHRNoy7qZYQtj6nwnsLRn5E
 O9qQWmSC7rjtaRxxvRRWdh/McRbwhZqwJMTbk7Pfpn34i3Ff4+vGPqUStNhPyxwW4/Ia
 jwayliynRovo0AuKIVEnsuxOMkML4GZxXYkm7D2K1t4nlDmuyCz0F5dKKOUIOpnBq/c1
 sUH/WjFVE2QzgCF+6XlujsL0gNdwPdVfNY8Bfy7WGhle8pJcoeqtkv9VygKlC0vSwsIF
 Muaw==
X-Gm-Message-State: AOJu0YzJW52H5Amuoasnfocq+jXRDbnQGNVoFp8nhG1mNdw7zdCGrR3p
 1HhZaYsLzFIeMH9o7zcH4I8rBaGweNcQfBUbwao=
X-Google-Smtp-Source: AGHT+IGQLRALYHRQMzHpkapVv6JO2MMGSzJpAj0Id7poMBUq5mlNqj89bEdo9BmiRN00tPHcnxwllQ==
X-Received: by 2002:a5d:4c84:0:b0:317:df82:2868 with SMTP id
 z4-20020a5d4c84000000b00317df822868mr2406083wrs.26.1693578923202; 
 Fri, 01 Sep 2023 07:35:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.203.220])
 by smtp.gmail.com with ESMTPSA id
 f9-20020adff989000000b00319756d5b80sm5501607wrr.29.2023.09.01.07.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 07:35:22 -0700 (PDT)
Message-ID: <b5a63263-12d3-7400-867a-6c3344184026@linaro.org>
Date: Fri, 1 Sep 2023 16:35:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 01/13] linux-user: Split out cpu/target_proc.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
 <20230824010237.1379735-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824010237.1379735-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 24/8/23 03:02, Richard Henderson wrote:
> Move the various open_cpuinfo functions into new files.
> Move the m68k open_hardware function as well.
> All other guest architectures get a boilerplate empty file.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/target_proc.h     |   1 +
>   linux-user/alpha/target_proc.h       |   1 +
>   linux-user/arm/target_proc.h         |   1 +
>   linux-user/cris/target_proc.h        |   1 +
>   linux-user/hexagon/target_proc.h     |   1 +
>   linux-user/hppa/target_proc.h        |  26 ++++
>   linux-user/i386/target_proc.h        |   1 +
>   linux-user/loongarch64/target_proc.h |   1 +
>   linux-user/m68k/target_proc.h        |  16 +++
>   linux-user/microblaze/target_proc.h  |   1 +
>   linux-user/mips/target_proc.h        |   1 +
>   linux-user/mips64/target_proc.h      |   1 +
>   linux-user/nios2/target_proc.h       |   1 +
>   linux-user/openrisc/target_proc.h    |   1 +
>   linux-user/ppc/target_proc.h         |   1 +
>   linux-user/riscv/target_proc.h       |  37 ++++++
>   linux-user/s390x/target_proc.h       | 109 +++++++++++++++++
>   linux-user/sh4/target_proc.h         |   1 +
>   linux-user/sparc/target_proc.h       |  16 +++
>   linux-user/x86_64/target_proc.h      |   1 +
>   linux-user/xtensa/target_proc.h      |   1 +
>   linux-user/syscall.c                 | 176 +--------------------------
>   22 files changed, 226 insertions(+), 170 deletions(-)
>   create mode 100644 linux-user/aarch64/target_proc.h
>   create mode 100644 linux-user/alpha/target_proc.h
>   create mode 100644 linux-user/arm/target_proc.h
>   create mode 100644 linux-user/cris/target_proc.h
>   create mode 100644 linux-user/hexagon/target_proc.h
>   create mode 100644 linux-user/hppa/target_proc.h
>   create mode 100644 linux-user/i386/target_proc.h
>   create mode 100644 linux-user/loongarch64/target_proc.h
>   create mode 100644 linux-user/m68k/target_proc.h
>   create mode 100644 linux-user/microblaze/target_proc.h
>   create mode 100644 linux-user/mips/target_proc.h
>   create mode 100644 linux-user/mips64/target_proc.h
>   create mode 100644 linux-user/nios2/target_proc.h
>   create mode 100644 linux-user/openrisc/target_proc.h
>   create mode 100644 linux-user/ppc/target_proc.h
>   create mode 100644 linux-user/riscv/target_proc.h
>   create mode 100644 linux-user/s390x/target_proc.h
>   create mode 100644 linux-user/sh4/target_proc.h
>   create mode 100644 linux-user/sparc/target_proc.h
>   create mode 100644 linux-user/x86_64/target_proc.h
>   create mode 100644 linux-user/xtensa/target_proc.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


