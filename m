Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2E07C87F2
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:37:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJHL-0003Wj-Q9; Fri, 13 Oct 2023 10:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJHG-0003SG-Pr
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:36:36 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJHE-00017T-NX
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:36:34 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5a9bc2ec556so712221a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697207790; x=1697812590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SG4oJzUuOBzIvH5f3sY7LCjR/CLl66M8ktYhirPDb58=;
 b=PQ9ROgwnPOlH06bIDKOqFqyg9yMnTEU6f25v9tZIy9xQCiBd5Hpc7AnuHI7y4JSFVu
 zAYB0cEmEhiGloFeVBrPk8Wm04QvKYPlMGt1ZcIVbvdYRR2YScT0O3yjTJ35q7GBBIDG
 zsiKRf73aySN1jCwaZnXHacryUzeFRM8mr6OSrtGTlLcXdCiF07g1+WDW2QssCdIqCk5
 3/Mtn53Y00Pa0IT7OpSt/NZtr0XvjkeK4g/reNXuUKmvbs1IF80wqqLzgY4PrlYXt/oV
 aEedrfeqi7HcXCHUE3AFKVkrercMJodGSO3QWHa9Pom2+7wyGVYNTYGhQ0BrAIW2kozh
 h+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697207790; x=1697812590;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SG4oJzUuOBzIvH5f3sY7LCjR/CLl66M8ktYhirPDb58=;
 b=jl2o0zvyhOg/BoiH7mJ2Ps1So4evkdfUZ2LGGdFy7EX5rNUle72tiMwYNS/wSOjKuy
 ZdC2ukK68gNbWB0nrlqqz6pYYXt6O9/GnKt2pmA8OGCBoOUxotcRZ+34bEx3nRLXNKHK
 KlzxZhfZr9Acl5a6iorXr0e8BP7Ec0BgHmrkergvfFD8fomSffLc+d43oUjFIO8K2Q2W
 oxM3+yaa3fjWOFkfIRevLPrWuV5cDtegjsarNhPYXM0uJAguwh6PS3xWB48/3JD0+Dnh
 TdtlKGzaw2T11mQbT6BC/vPvZmfC3Kx4xi8D3D1uYhNE82ugmMQ832czTaurTdN5869B
 ljqA==
X-Gm-Message-State: AOJu0YyzpfMxapXrQzhnDxZ5WSUrjWNSJ/KY2tIH+YZo4e31cu3nCffb
 lpFKw1dhndwbs/DD/CD8r+BMXQ==
X-Google-Smtp-Source: AGHT+IHTRR1CxWgQ4vci2dI2qOpYFgvWyoxX6ZRf7E7CZKBr0MAiI1XDqHWmAB6+x4xVY/EFAwTztw==
X-Received: by 2002:a17:90a:1904:b0:27d:1ec3:4367 with SMTP id
 4-20020a17090a190400b0027d1ec34367mr4784269pjg.0.1697207789741; 
 Fri, 13 Oct 2023 07:36:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ch6-20020a17090af40600b00278eb908f78sm185168pjb.19.2023.10.13.07.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 07:36:29 -0700 (PDT)
Message-ID: <e0b86d94-29fc-4266-ac1d-4678fe36a71d@linaro.org>
Date: Fri, 13 Oct 2023 07:36:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] target: Move ArchCPUClass definition to 'cpu.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231013140116.255-1-philmd@linaro.org>
 <20231013140116.255-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013140116.255-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 10/13/23 07:01, Philippe Mathieu-Daudé wrote:
> The OBJECT_DECLARE_CPU_TYPE() macro forward-declares each
> ArchCPUClass type. These forward declarations are sufficient
> for code in hw/ to use the QOM definitions. No need to expose
> these structure definitions. Keep each local to their target/
> by moving them to the corresponding "cpu.h" header.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/cpu-qom.h      | 16 ---------------
>   target/alpha/cpu.h          | 13 +++++++++++++
>   target/arm/cpu-qom.h        | 27 -------------------------
>   target/arm/cpu.h            | 25 ++++++++++++++++++++++++
>   target/avr/cpu-qom.h        | 16 ---------------
>   target/avr/cpu.h            | 14 +++++++++++++
>   target/cris/cpu-qom.h       | 19 ------------------
>   target/cris/cpu.h           | 16 +++++++++++++++
>   target/hexagon/cpu-qom.h    |  1 -
>   target/hppa/cpu-qom.h       | 16 ---------------
>   target/hppa/cpu.h           | 14 +++++++++++++
>   target/i386/cpu-qom.h       | 39 -------------------------------------
>   target/i386/cpu.h           | 35 +++++++++++++++++++++++++++++++++
>   target/loongarch/cpu-qom.h  |  1 -
>   target/m68k/cpu-qom.h       | 16 ---------------
>   target/m68k/cpu.h           | 13 +++++++++++++
>   target/microblaze/cpu-qom.h | 16 ---------------
>   target/microblaze/cpu.h     | 13 +++++++++++++
>   target/mips/cpu-qom.h       | 20 -------------------
>   target/mips/cpu.h           | 17 ++++++++++++++++
>   target/nios2/cpu-qom.h      |  1 -
>   target/openrisc/cpu-qom.h   |  1 -
>   target/riscv/cpu-qom.h      | 16 +--------------
>   target/riscv/cpu.h          | 14 +++++++++++++
>   target/rx/cpu-qom.h         | 15 --------------
>   target/rx/cpu.h             | 14 +++++++++++++
>   target/s390x/cpu-qom.h      | 37 +----------------------------------
>   target/s390x/cpu.h          | 30 ++++++++++++++++++++++++++++
>   target/s390x/cpu_models.h   |  8 ++++----
>   target/sh4/cpu-qom.h        | 23 ----------------------
>   target/sh4/cpu.h            | 20 +++++++++++++++++++
>   target/sparc/cpu-qom.h      | 18 -----------------
>   target/sparc/cpu.h          | 18 +++++++++++++++--
>   target/tricore/cpu-qom.h    | 10 ----------
>   target/tricore/cpu.h        |  6 ++++++
>   target/xtensa/cpu-qom.h     | 21 --------------------
>   target/xtensa/cpu.h         | 20 +++++++++++++++++--
>   37 files changed, 284 insertions(+), 335 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

