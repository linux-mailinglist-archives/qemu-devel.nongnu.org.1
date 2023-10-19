Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBDB7D0136
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:14:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXWn-0002PC-JP; Thu, 19 Oct 2023 14:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtXWk-0002Ax-SE
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:13:46 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtXWj-0007CM-2Z
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:13:46 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6bb4abb8100so15666b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697739223; x=1698344023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pybdNtLwm8pfpbyF8OSvAQPiYQ1DBDO5Kd2nRg3dGws=;
 b=U5tMyZRNGywyJb3SavT+TP6WWPI9E7Zid6CQD6J7Iy1Ybsq/WgmfD4UxHNu1MLU4FI
 7jj9y/L6wozB6SRcgHAvHhJaHU+YqcrnenG5OpFRDc2bCBTnPKDGF8IBqvBe5wiCdHbd
 sNKITdz5lVMM69p/3Fzd02GNJtAXJmTxVPWDVKrsMQA6LF2ocLwwPNrH719DbizbGmtG
 uROGuU7rVtyDMMadvpn5T8rrmW/MZx6+r2lESHVgBrIwqndQ4/1LQbLqPuQjQD3j/mdA
 IKlFn8l0UdATTBRSlUDlKzoznh8NjN3omM0J036YuslsBiz0VlhbPUUyWFCYNyOZFmDr
 0kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739223; x=1698344023;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pybdNtLwm8pfpbyF8OSvAQPiYQ1DBDO5Kd2nRg3dGws=;
 b=wDBZqplHGLGHwIp0zDinW6vEj7uK4gQW8sadHsLi8Pug6glvEOtlBXs8Pv4LLqv77F
 wSxm/GwQypUpQi5kRg8UBBlFBkaKiLgEf/X/dAJMAEzD+2tOgkS4OGpckMAzfzxuK5uf
 WRzhg7yLP/49EA2UV2iGGXw0VSnz1/p3x2WLtv767oD9qRi0KuD/+6CKbuub4lfChnNr
 rOjuNUjcXwX/qlsUIIGiLi933VwkvezNZiocwJAqozIcww8JVXykPMSkW0X4zlnconFy
 3YLfXR+1TjgIAEYci8ldZQ1Q4DlS8dtaTRtm9VaGlvaz6Woy7qEv35vyQxyBft9LNSg4
 joog==
X-Gm-Message-State: AOJu0YyBQNyonspsFkYXXphd4IXAPNbWRzreJSCcdZ98EGmKr+FcOciO
 vLbTcbhHSvFhGeCu39Ktclheew==
X-Google-Smtp-Source: AGHT+IEAz11ldgbAilffmuVBGZXKfERx5MDkuIS1msonvOfqqTCr0WeMYWukMOEoYPDPEGv+B6yAkw==
X-Received: by 2002:a05:6a00:18a2:b0:693:3963:847a with SMTP id
 x34-20020a056a0018a200b006933963847amr3558647pfh.30.1697739223416; 
 Thu, 19 Oct 2023 11:13:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 y21-20020aa79af5000000b0068be348e35fsm86762pfp.166.2023.10.19.11.13.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 11:13:43 -0700 (PDT)
Message-ID: <7dc0b6cc-7112-4f12-b52e-13f217d8dae3@linaro.org>
Date: Thu, 19 Oct 2023 11:13:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/54] target/riscv: deprecate the 'any' CPU type
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
 <20231012041051.2572507-13-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231012041051.2572507-13-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 10/11/23 21:10, Alistair Francis wrote:
> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
> The 'any' CPU type was introduced in commit dc5bd18fa5725 ("RISC-V CPU
> Core Definition"), being around since the beginning. It's not an easy
> CPU to use: it's undocumented and its name doesn't tell users much about
> what the CPU is supposed to bring. 'git log' doesn't help us either in
> knowing what was the original design of this CPU type.
> 
> The closest we have is a comment from Alistair [1] where he recalls from
> memory that the 'any' CPU is supposed to behave like the newly added
> 'max' CPU. He also suggested that the 'any' CPU should be removed.
> 
> The default CPUs are rv32 and rv64, so removing the 'any' CPU will have
> impact only on users that might have a script that uses '-cpu any'.
> And those users are better off using the default CPUs or the new 'max'
> CPU.
> 
> We would love to just remove the code and be done with it, but one does
> not simply remove a feature in QEMU. We'll put the CPU in quarantine
> first, letting users know that we have the intent of removing it in the
> future.
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02891.html
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20230912132423.268494-13-dbarboza@ventanamicro.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   docs/about/deprecated.rst | 12 ++++++++++++
>   target/riscv/cpu.c        |  5 +++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 8b136320e2..5e3965a674 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -327,6 +327,18 @@ QEMU's ``vhost`` feature, which would eliminate the high latency costs under
>   which the 9p ``proxy`` backend currently suffers. However as of to date nobody
>   has indicated plans for such kind of reimplementation unfortunately.
>   
> +RISC-V 'any' CPU type ``-cpu any`` (since 8.2)

You forgot to update linux-user/riscv/target_elf.h, which still uses "any", and thus all 
qemu-riscv64 invocations trigger the warning.


r~


