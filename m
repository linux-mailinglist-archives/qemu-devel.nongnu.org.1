Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ECE82E335
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 00:19:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPWEM-0000ty-Iz; Mon, 15 Jan 2024 18:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPWEK-0000sO-Mz
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 18:18:56 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPWEI-0000P9-VB
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 18:18:56 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6d9344f30caso6144886b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 15:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705360733; x=1705965533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SlIdd+1c4bN9+wjNwCuFwswvXHyJYL9d5UnjCPykS78=;
 b=jnhFm+GGehAncVjCr6g4TUgd/x4zKG1RdX1J8tYS705pn34nGe6WNztYswqyTWq25w
 L50JTSx2JSsBhouGf54FPe1NP1G/NoqAsNi/ZEduXnhJ/dnDSgVxUYznFe7hJFd+vhMb
 D3jGeU5tXSZf3EEvT0oyiok0ROqfWZ/Jre0LZ77cLScE9bOKLC2LGNYCIC1AwGT/fTHx
 nL/OmGkh8RM3Ssrk2ujIlg8WoPBvWaDUApipkU6wSQmUrVSBH3OJbUtQiE+j44RnEaCt
 xMqwzAPsWOAEi0SJ7NYa0A72dnJW6a2jsGx2qKhfYSzrep7JrGCbvgtcsdJiX67l0m1X
 yvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705360733; x=1705965533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SlIdd+1c4bN9+wjNwCuFwswvXHyJYL9d5UnjCPykS78=;
 b=Wuy0r4Efa7YSUT5GxRiTxrgDrfrg+01mlyaXGxCLJrYpBG6KjGnadmfvg7Jdsl2e+c
 lAH/asdIKNTN23bHV7T5TgbVVNiL2YfpEzYBUUrJmm03nM8owEhMaH9yxguI7mNsQ1j/
 JgSnUz9xXvSnr2b9L+HgqHzY8Q1b21vuNS4hVVWG9EKhWhrez0MlA8ov6Yvl01VuVTbX
 75XWOZGx+W0y2OY9wTY28pHx4K0fkSf4gFzlVJm4u/8EP6Wm0cyAehvtlARQhh94o29f
 NSR7RjnTAEKfKBSMkOs+K0quiEPbnF4UrysXx5ANdQJV7idGjwyx1n+e4b5Ym5W4ANOx
 IPUA==
X-Gm-Message-State: AOJu0Yw3mZ43npLMvOGsaGWUprWRPRAa5tgNqctrVmRIYAYV3sjj25Xo
 IDViwgGlRD/m1hzEi+DeYAxCisEpqN6XNQ==
X-Google-Smtp-Source: AGHT+IEPR94aaTxJ3R0TlI+f12rlJeeIhcfT2a3IFH9A6MDk0KbQOfg1LnuT0S07+zRsFj6FJvCGqw==
X-Received: by 2002:a05:6a00:98a:b0:6da:bed1:c8b with SMTP id
 u10-20020a056a00098a00b006dabed10c8bmr8519810pfg.20.1705360732917; 
 Mon, 15 Jan 2024 15:18:52 -0800 (PST)
Received: from ?IPV6:2001:8004:2738:1dd9:85fe:4dd3:358e:ec4?
 ([2001:8004:2738:1dd9:85fe:4dd3:358e:ec4])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a056a001b4600b006d9a0902937sm8405580pfv.149.2024.01.15.15.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 15:18:52 -0800 (PST)
Message-ID: <f23eb285-16a8-44ee-991b-224b480dd91b@linaro.org>
Date: Tue, 16 Jan 2024 10:18:46 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user/riscv: vdso: fix call frame info in
 __vdso_rt_sigreturn
Content-Language: en-US
To: Vineet Gupta <vineetg@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, Edwin Lu
 <ewlu@rivosinc.com>, gnu-toolchain <gnu-toolchain@rivosinc.com>
References: <20240115231552.3217789-1-vineetg@rivosinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240115231552.3217789-1-vineetg@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 1/16/24 10:15, Vineet Gupta wrote:
> When testing gcc testsuite against QEMU v8.2 we found some additional
> failures vs. v8.1.2.
> 
> | FAIL: gcc.dg/cleanup-10.c execution test
> | FAIL: gcc.dg/cleanup-11.c execution test
> | FAIL: gcc.dg/cleanup-8.c execution test
> | FAIL: gcc.dg/cleanup-9.c execution test
> 
> All of these tests involve unwinding off signal stack and v8.2 did
> introduce a vdso with sigreturn trampoline and associated unwinding
> info. It seems that info is not correct and making it similar to
> to one in the linux kernel fixes the above failures.

So.. you didn't actually determine what might be off in the unwind info?

> +	.cfi_startproc
> +	.cfi_signal_frame
> +       raw_syscall __NR_rt_sigreturn
> +       .cfi_endproc

No, this is wrong.  It indicates that the unwind info is present and trivial.


r~


