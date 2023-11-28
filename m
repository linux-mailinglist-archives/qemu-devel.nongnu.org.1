Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6C47FB69A
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 11:04:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7uwO-0005v5-Se; Tue, 28 Nov 2023 05:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uwM-0005uT-VC
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:03:38 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uwL-0006Yb-1I
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:03:38 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54af0eca12dso5500517a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 02:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701165814; x=1701770614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rJJScPtOpa+hNpggTrp2M/ryFIsx93bzfQDuzRSLjBU=;
 b=XGNgL2X7YuzsN7zLeOLUn9GDlmX2I8nhxpq56WQ3yhQvX2dZJrGACKFBdkXN99rXpO
 eZDRYTvIE4UpuE4GT3v+vsuqN6HrudMnTfMr6I3pFtVTm+dEW7PrZG6nK/fM6WrZaEcl
 kW5XNB/wnnN+4F8Zix8nKPulZ5Msm/D0vAVePR+14tSKXcwzVJM1pMawa5oMD3smwarv
 N24ZTtySqplaXOGHZAzf9N/jwIxcD2DmK6mkN6YbnU1LEeeluqS0sVVjTwOVDz8M04mo
 bAKuDvxRKRrLe+mMO1R0MopMkfwMwueNT2bM1qlF/n0n5o1j/4nRIfWd5jPxj/AssIR2
 ukcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701165814; x=1701770614;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rJJScPtOpa+hNpggTrp2M/ryFIsx93bzfQDuzRSLjBU=;
 b=nPzBEiR7Lyk8k22AtnUDtlVMFzQ9NWrN47ihM6fMv+dcqWhjxzuQHxcKtW/hDbC/fx
 2sfEesbbFIWR/HIH60pwX8P4Au3BpaVGRpVYr7GNVYpEQ4UHc/BHcOsDxoK7CT3b9hTC
 6y4ISQj64fWINlqIb8x0rBDgjPyLTHCLc6xSVX3kXhgD47KV9URtSqtEZi502bi8qVd9
 S7rcFqpzGYvylfIQAag7FMJRhDMEn3r7zT5e7OWSw5Mj3SYOrlwUVJHrEhs0kVhRXZC3
 lKArYBJn9yxYU7D+SAR7eVJAvv6YvRcs0oGsdRGVwTKoDYvreRqupYHA9cZaN/8yamtq
 5gkg==
X-Gm-Message-State: AOJu0Yy+VGOnM+2TdWP3FAZG0VC7fCavWf6q+cWlUh9QUaHnc8cOTs27
 +QiukZF7a75+CEA7IgozhKw3lQ==
X-Google-Smtp-Source: AGHT+IGhQPZPsYZUaI8zV2escCUygen5HJXIFUHHggyFb2pZ/NP0vnMZ/PbF7OPiRJzfatq5IwAoyQ==
X-Received: by 2002:a17:906:74d0:b0:a02:9e68:93ed with SMTP id
 z16-20020a17090674d000b00a029e6893edmr9949466ejl.1.1701165814121; 
 Tue, 28 Nov 2023 02:03:34 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 r22-20020a170906351600b00a0c01560bdfsm3835090eja.139.2023.11.28.02.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 02:03:33 -0800 (PST)
Message-ID: <c772249f-e8e1-414f-b6e9-3bf224ff14a9@linaro.org>
Date: Tue, 28 Nov 2023 11:03:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v2 4/8] target/riscv/cpu.c: add
 riscv_cpu_is_32bit()
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com
References: <20231127113752.1290265-1-dbarboza@ventanamicro.com>
 <20231127113752.1290265-5-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231127113752.1290265-5-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 27/11/23 12:37, Daniel Henrique Barboza wrote:
> Next patch will need to retrieve if a given RISCVCPU is 32 or 64 bit.
> The existing helper riscv_is_32bit() (hw/riscv/boot.c) will always check
> the first CPU of a given hart array, not any given CPU.
> 
> Create a helper to retrieve the info for any given CPU, not the first
> CPU of the hart array. The helper is using the same 32 bit check that
> riscv_cpu_satp_mode_finalize() was doing.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   target/riscv/cpu.c | 7 ++++++-
>   target/riscv/cpu.h | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


