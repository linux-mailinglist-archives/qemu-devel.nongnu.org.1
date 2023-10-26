Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9C27D79C2
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:44:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoUL-0008Sa-9Z; Wed, 25 Oct 2023 20:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvoUI-0008RE-VY
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:44:38 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvoUH-0000MP-3S
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:44:38 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ca215cc713so2161535ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698281075; x=1698885875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=we2zMIU8OLiozy+wkRrr8+eLMzJIqDWRke2TlpawU0I=;
 b=RSP20X8JMqzHdg0XSkUsRkPo9CrjrWPOdyT5j5ECcGqM0PfjbpnfF6h8RkHk7D1rpo
 iRTykBQ7pBBShO3OTfvGhT3sdyj3Scwqml9QUdhoPLmsQbeSd3UPywDHK4dS8ejzJ/Sp
 udfJLQAAnjhI/IHEAmg03IVfGvo4kiRZIDigqBW5ZtxJu95LSslKtzII9fh9boU886L9
 e8w68fp2OBXLZKakQ485Q9DpbuaVxDwoWRnB/wnC/Ar41e7elLaqACZLAQ4Fo9qJyWqs
 yTF0OBKsSmPvTzkpYCxsvj2dMRGLm/NBjoQv3bFM9MOc9aHwrDyaoarX06r9/GPxFDVO
 1zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698281075; x=1698885875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=we2zMIU8OLiozy+wkRrr8+eLMzJIqDWRke2TlpawU0I=;
 b=LTZJVHeighcihTjg+PZnSa2Ezo2pPV1VvZcJtGHktVZu1wzTLTuHO5mrivVt49Dq4M
 wMYLAEFN12hYUdjq6LuZUou96UQ1pvCk+o645vel5RgSblDS939Ftw3qVJq650ihdvjZ
 gp0uLLzwYKYNJJP/wIj+QiGR+ja3UaLbyKQXehPcvBEYVzbjK88y029MGhtMBfhtZNie
 ztYacuVnfQL+GJH2htwRAR3XMPijOHFdkQ9IoLbr+dRkIbiK1rGWqAu85ojfyKMuY+sN
 NyenG87RU8ZYpUEAJn6MLvYUCxbjlS5mndCMJGS1cczK9zEovJWDkJIxI1Gn43wufFJX
 JgCw==
X-Gm-Message-State: AOJu0YzBMA8hSOy9Qdc+mkmWyk+6bsP7Sz7niIG8nJk/Q9SGWH6vIo7t
 //iONoNwmgQDFoN/GjLG/fGfbA==
X-Google-Smtp-Source: AGHT+IHeyHvy4M0R4AdRUtYaG3Ue2jBgWk7TnhnQxKbIDx3tSO9oI3Ga/b8XkHTu6vJm01B3SzL/zw==
X-Received: by 2002:a17:902:e414:b0:1b8:94e9:e7cb with SMTP id
 m20-20020a170902e41400b001b894e9e7cbmr10750328ple.21.1698281075584; 
 Wed, 25 Oct 2023 17:44:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a170902c94700b001c5d09e9437sm7765138pla.25.2023.10.25.17.44.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 17:44:35 -0700 (PDT)
Message-ID: <79b3bf7e-71dc-4ac2-bbb0-eb27e6c70ae5@linaro.org>
Date: Wed, 25 Oct 2023 17:44:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] accel/tcg: Always require can_do_io
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
References: <20230914174436.1597356-1-richard.henderson@linaro.org>
 <20230914174436.1597356-7-richard.henderson@linaro.org>
 <CAJ307EjR0oKs6W=7ZgsqeM1XrHbTYF4sXN2vV9jn1eiRsMewVA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAJ307EjR0oKs6W=7ZgsqeM1XrHbTYF4sXN2vV9jn1eiRsMewVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 10/24/23 02:50, Clément Chigot wrote:
> Hi Richard,
> 
> This commit has broken some of our internal bareboard testing on
> Risc-V 64. At some point in our programs, there is an AMOSWAP (=
> atomic swap) instruction on I/O. But since this commit, can_do_io is
> set to false triggering an infinite loop.
> IIUC the doc (cf [1]), atomic operations on I/O are allowed.
> 
> I think there is a CF_LAST_IO flag missing somewhere to allow it, but
> I'm not sure where this should be. Do you have any ideas ?
> 
> Sadly I cannot provide a reproducer that easily, mainly because our
> microchip has a few patches not yet merged making our binaries not
> running on the upstream master.
> But here is a bit of the in_asm backtrace:
> 
>    | IN: system__bb__riscv_plic__initialize
>    | Priv: 3; Virt: 0
>    | 0x80000eb4:  1141              addi                    sp,sp,-16
>    | 0x80000eb6:  0c0027b7          lui                     a5,49154
>    | 0x80000eba:  e406              sd                      ra,8(sp)
>    | 0x80000ebc:  00010597          auipc                   a1,16
>              # 0x80010ebc
>    | 0x80000ec0:  47458593          addi                    a1,a1,1140
>    | 0x80000ec4:  f3ffe637          lui                     a2,-49154
>    | 0x80000ec8:  01878693          addi                    a3,a5,24
>    | 0x80000ecc:  00f58733          add                     a4,a1,a5
>    | 0x80000ed0:  9732              add                     a4,a4,a2
>    | 0x80000ed2:  4318              lw                      a4,0(a4)
>    | 0x80000ed4:  2701              sext.w                  a4,a4
>    | 0x80000ed6:  08e7a02f          amoswap.w               zero,a4,(a5)
>    | 0x80000eda:  0791              addi                    a5,a5,4
>    | 0x80000edc:  fed798e3          bne                     a5,a3,-16
>              # 0x80000ecc
>    |
>    | ----------------
>    | IN: system__bb__riscv_plic__initialize
>    | Priv: 3; Virt: 0
>    | 0x80000ed6:  08e7a02f          amoswap.w               zero,a4,(a5)
>    |
>    | ----------------
>    | IN: system__bb__riscv_plic__initialize
>    | Priv: 3; Virt: 0
>    | 0x80000ed6:  08e7a02f          amoswap.w               zero,a4,(a5)
>    | * Freeze *

I would expect two translations:

(1) with the original TB, aborts execution on !can_do_io.
(2) with the second TB, we get further into the actual execution and abort execution on 
TLB_MMIO.
(3) with the third TB, we clear CF_PARALLEL and execute under cpu_exec_step_atomic.

Both 2 and 3 should have had CF_LAST_IO set.
You can verify this with '-d exec' output.

As a trivial example from qemu-system-alpha bios startup:

> Trace 0: 0x7f2584008380 [00000000/fffffc0000003ee4/01000000/ff000000] uart_init_line
> cpu_io_recompile: rewound execution of TB to fffffc0000003ee4
> ----------------
> IN: uart_init_line
> 0xfffffc0000003f20:  stb        t8,0(t6)
> 
> Trace 0: 0x7f2584008a00 [00000000/fffffc0000003f20/01000000/ff018001] uart_init_line

Note that the final "/" field is cflags.  The first "Trace" corresponds to (1), where the 
store is in the middle of the TB.  You can see the io_recompile abort, then the second 
"Trace" contains {CF_COUNT=1, CF_LAST_IO, CF_MEMI_ONLY}.

In the short term, try adding CF_LAST_IO to cflags in cpu_exec_step_atomic.

I think probably the logic of CF_LAST_IO should always be applied now, since can_do_io is 
always live, and thus the flag itself should go away.


r~

