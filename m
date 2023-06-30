Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B95C74419B
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 19:49:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIFE-0003K6-2I; Fri, 30 Jun 2023 13:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFIFB-0003Jg-WE
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 13:49:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFIFA-0000rh-7X
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 13:49:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fa8cd4a113so22621155e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688147354; x=1690739354;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gt1/zkp1UjpZSVzPEFTelDhjkSv6strgB6PbHIhgVpQ=;
 b=G7SEETT1IV2/xcbpNy8+ZWC0bpASsjToWnLg2glN9XlVfqr6+SmTDmGCnKjA7OcH3J
 1zdhutTSrOAlDR6kNoK1kZUUkxcQwRZabo6Q/wQaWSLTajbErLbUkNIyP6XeBc8gaTt8
 Xa0hRM6M+al3pJO3QWZHXV3eHDlrQ9CJNLhRpfoXGGcKZLzK0F0HOgHwiU5+LCP9xrEu
 lr4NuSINZRQhq67Lw8Qalv8rTJNJM3dSPG9P6EulzWsUPoLFgsEl/e2eJ1JpSgi1CHH6
 nvP8RwfwZEWP2ynEhowo2WuyQTPPZJwdt6FnyXkaxHJBVS5W+eJ/sBRfUTnPh4cG3tdB
 qX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688147354; x=1690739354;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gt1/zkp1UjpZSVzPEFTelDhjkSv6strgB6PbHIhgVpQ=;
 b=IlS98ixON0SqWcrkUoy6wLiQEKSqe2tfwIq2odaUQKOyQ2lfK5GmsIzQO7wY9XuvaT
 81yeKfPC0J5d2HThD5gXUqZC9Xf9BFped7W/6IuRvWlQ1GzT68gCET2B+i5W0pa0SF4o
 HJSyrMJQ/wgUwQgjedwgHYFmk0p9jBybPVcKsb+QYtJih2My2XtonSvyE71ZDcDklMrF
 u+aFJ0Ini8CFk/h0oWuw9H0XdUght3sALRvroybh8Rfm0Tyg2tADnbh9wFmIwoW8FZxb
 O4LGQNBL4CGPIPN91h2EKzTP5AsQSHDGm8xwBZ+aWhBr/z0u0gmot+6MzoSO8kW4yv9h
 CTjA==
X-Gm-Message-State: ABy/qLaPBjIja0M9RQrKbQF0qs8wV5eSnR84dd9Y32bKMojE5lvJ3UzQ
 SKblW/8AX1ypuY795yRzrqLLgg==
X-Google-Smtp-Source: APBJJlHkNQr0i6tII4qvtDgVD8VQOo+ZNP9GPsMHmML+KpyRygo1G6E1/82YSVlWiIM0OgwZABoLWw==
X-Received: by 2002:adf:e685:0:b0:313:e96e:98f2 with SMTP id
 r5-20020adfe685000000b00313e96e98f2mr2924117wrm.6.1688147354279; 
 Fri, 30 Jun 2023 10:49:14 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a7bc8cc000000b003fbbe41fd78sm4251726wml.10.2023.06.30.10.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 10:49:14 -0700 (PDT)
Message-ID: <50c87d7b-a5b0-9a33-e527-a76811aa18c7@linaro.org>
Date: Fri, 30 Jun 2023 19:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6] riscv: Add support for the Zfa extension
Content-Language: en-US
To: Christoph Muellner <christoph.muellner@vrull.eu>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Jeff Law <jeffreyalaw@gmail.com>, Tsukasa OI <research_trasio@irq.a4lg.com>,
 liweiwei@iscas.ac.cn, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Rob Bradford <rbradford@rivosinc.com>
References: <20230630170230.1043454-1-christoph.muellner@vrull.eu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630170230.1043454-1-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/30/23 19:02, Christoph Muellner wrote:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
> 
> This patch introduces the RISC-V Zfa extension, which introduces
> additional floating-point instructions:
> * fli (load-immediate) with pre-defined immediates
> * fminm/fmaxm (like fmin/fmax but with different NaN behaviour)
> * fround/froundmx (round to integer)
> * fcvtmod.w.d (Modular Convert-to-Integer)
> * fmv* to access high bits of float register bigger than XLEN
> * Quiet comparison instructions (fleq/fltq)
> 
> Zfa defines its instructions in combination with the following extensions:
> * single-precision floating-point (F)
> * double-precision floating-point (D)
> * quad-precision floating-point (Q)
> * half-precision floating-point (Zfh)
> 
> Since QEMU does not support the RISC-V quad-precision floating-point
> ISA extension (Q), this patch does not include the instructions that
> depend on this extension. All other instructions are included in this
> patch.
> 
> The Zfa specification can be found here:
>    https://github.com/riscv/riscv-isa-manual/blob/master/src/zfa.tex
> The Zfa specifciation is frozen and is in public review since May 3, 2023:
>    https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/SED4ntBkabg
> 
> The patch also includes a TCG test for the fcvtmod.w.d instruction.
> The test cases test for correct results and flag behaviour.
> Note, that the Zfa specification requires fcvtmod's flag behaviour
> to be identical to a fcvt with the same operands (which is also
> tested).
> 
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> 
> ---
> 
> This patch depends on float64_to_int64_modulo(), which is provided
> by a patchset from Richard Henderson:
>    https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg07022.html
> 
> Changes in v6:
> * Address issues in trans_fmvp_d_x() and trans_fmvh_x_d()
> 
> Changes in v5:
> * Merge all three commits
> * Address issues reported by Richard
> 
> Changes in v4:
> * Rebase and resolve conflicts
> * Fix whitespace issue (thanks Rob)
> * Add patch to implemnt fcvtmod.w.d using float64_to_int64_modulo()
> * Add (demo) test for fcvtmod.w.d
> 
> Changes in v3:
> * Add disassembler support
> * Enable Zfa by default
> * Remove forgotten comments in the decoder
> * Fix fli translation code (use movi instead of ld)
> * Tested against SPEC CPU2017 fprate
> * Use floatN_[min|max] for f[min|max]m.* instructions
> 
> Changes in v2:
> * Remove calls to mark_fs_dirty() in comparison trans functions
> * Rewrite fround(nx) using float*_round_to_int()
> * Move fli* to translation unit and fix NaN-boxing of NaN values
> * Reimplement FCVTMOD.W.D
> * Add use of second register in trans_fmvp_d_x()
> 
>   disas/riscv.c                             | 151 +++++++
>   target/riscv/cpu.c                        |   8 +
>   target/riscv/cpu_cfg.h                    |   1 +
>   target/riscv/fpu_helper.c                 | 154 +++++++
>   target/riscv/helper.h                     |  19 +
>   target/riscv/insn32.decode                |  26 ++
>   target/riscv/insn_trans/trans_rvzfa.c.inc | 521 ++++++++++++++++++++++
>   target/riscv/translate.c                  |   1 +
>   tests/tcg/riscv64/Makefile.target         |   6 +
>   tests/tcg/riscv64/test-fcvtmod.c          | 345 ++++++++++++++
>   10 files changed, 1232 insertions(+)
>   create mode 100644 target/riscv/insn_trans/trans_rvzfa.c.inc
>   create mode 100644 tests/tcg/riscv64/test-fcvtmod.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

