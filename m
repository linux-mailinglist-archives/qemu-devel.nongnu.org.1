Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 324197DFC4A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 23:19:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyg0Z-00087b-EZ; Thu, 02 Nov 2023 18:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyg0X-00087I-17
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 18:17:45 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyg0U-0001NH-57
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 18:17:44 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6c3443083f2so779037b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 15:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698963460; x=1699568260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Eca06IWM2KVXj0SQXZ12gVCGaRyRUaSk+4BrwFTTyFc=;
 b=qUtWEsQRrjDHeb5UDJJYv1Ma8vPNr6NI3VV9+sEjcY7yAw9u07EZbO+x+sWenyk2zJ
 9x+ybv69TK/VohUCkoBsp6OBz/MaxqhrVyuv8+pauCXtV9CvXNM1Jc09gMBAUBdkO6yL
 yHyxje6qLEH0VSxx5oSU7/+0foHW/s5QRRlTLiiYW9cFsur9t3B8zz/Nsq81N4CQLDK1
 NkvMrrYLDiPRUQtHbMu00brdPAWeIJCtwGqzqB3UBKiln7PJKWShMDMKoW1KUpBq6kIe
 i9fTNZRd+2asxQkeSgn/W/9GPwm30YRRSYZMkgaV1XPIp14nc/bxrXUaO4CmRrvW65TG
 pnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698963460; x=1699568260;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Eca06IWM2KVXj0SQXZ12gVCGaRyRUaSk+4BrwFTTyFc=;
 b=oDiqysYOyj2hMnH4NnnsKpAU2FdCrfRl1ebZVBC+yU5Zhn9e+/FP6wplT4/45ipDPX
 SMfznyIbhwqJ8mdv2nnZsRxjjKfFpMbkd9DXqTHkqsfUiLtT5kT69ZEwAn30eQzH6F5f
 zJQspj+3Q4YKnhGS0Wd+QsjCSzOJ6nsVjC769Rjp87cAWLBEeFeR1b0gml5rjNPw3JXW
 8JTfm0T3XCj6JSLlObfJR41Ar4N1/bGZ+qCxjoMvBlLX3mdM8R+K/QwY5pDiGW/rKB0f
 Ri0+TjS1S5eIO9dFd8DGCheWURywaI5Ml4aZ69LC4FZPxasBDRimuTv6v/y8AcNrYkqH
 5ZLA==
X-Gm-Message-State: AOJu0YwfALZE4iwB519Gl70fw2NGPoE/nqp19hMTaoomCqIz74JE+CWg
 EL+ezcuFanf2bL6qJbB9upEFxN4xFhYLdJ4t53k=
X-Google-Smtp-Source: AGHT+IH1ZWkOq6vGvzajHZGP4fIDuIB3K67vc2oodNg+5e0Jt2KHZAcatUxzDQBnu2lE4CK5nXRxKA==
X-Received: by 2002:a05:6a20:938c:b0:15e:108c:35b0 with SMTP id
 x12-20020a056a20938c00b0015e108c35b0mr19987288pzh.4.1698963460230; 
 Thu, 02 Nov 2023 15:17:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a170902d21200b001cc5225c20bsm183613ply.137.2023.11.02.15.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 15:17:39 -0700 (PDT)
Message-ID: <8b925fff-1351-4e8b-bfb5-8e0eb1421802@linaro.org>
Date: Thu, 2 Nov 2023 15:17:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/35] tcg: Introduce TCG_COND_TST{EQ,NE}
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Ping.  Running out of days before soft-freeze.  :-)

r~

On 10/28/23 12:44, Richard Henderson wrote:
> Expose a pair of comparison operators that map to the "test"
> comparison that is available on many architectures.
> 
> Changes for v2:
>    * Add TCGCond to tcg_target_const_match.
>      This fixes a long-standing issue with ppc and s390x backends,
>      in that CMPI for signed comparisons has signed immediate and
>      CMPLI for unsigned comparisons has unsigned immediate.
>      But now allows different immediates for the TST comparisons.
>    * tcg/i386: Generate TEST x,x for power-of-two in {7,15,31,63}.
>    * tcg/i386: Generate BT n,x for other power-of-two.
>    * tcg/ppc: tcg_target_const_match improvements
>    * tcg/s390x: tcg_target_const_match improvements
>    * target/m68k: Use TST{EQ,NE} for gen_fcc_cond.
> 
> I wanted more testing, so I went looking for low-hanging fruit.
> I didn't see any within target/arm, probably due to how we represent NZCV,
> and I didn't want to overlap anything that Paolo might be doing with
> target/i386, so I landed on trget/m68k.  Tested via our float_convd.
> 
> 
> r~
> 
> 
> Richard Henderson (35):
>    tcg: Introduce TCG_COND_TST{EQ,NE}
>    tcg/optimize: Split out arg_is_const_val
>    tcg/optimize: Split out do_constant_folding_cond1
>    tcg/optimize: Do swap_commutative2 in do_constant_folding_cond2
>    tcg/optimize: Split out arg_new_constant
>    tcg/optimize: Handle TCG_COND_TST{EQ,NE}
>    tcg: Add TCGConst argument to tcg_target_const_match
>    tcg/aarch64: Support TCG_COND_TST{EQ,NE}
>    tcg/aarch64: Generate TBZ, TBNZ
>    tcg/aarch64: Generate CBNZ for TSTNE of UINT32_MAX
>    tcg/arm: Support TCG_COND_TST{EQ,NE}
>    tcg/i386: Pass x86 condition codes to tcg_out_cmov
>    tcg/i386: Move tcg_cond_to_jcc[] into tcg_out_cmp
>    tcg/i386: Support TCG_COND_TST{EQ,NE}
>    tcg/i386: Improve TSTNE/TESTEQ vs powers of two
>    tcg/loongarch64: Support TCG_COND_TST{EQ,NE}
>    tcg/mips: Support TCG_COND_TST{EQ,NE}
>    tcg/riscv: Support TCG_COND_TST{EQ,NE}
>    tcg/sparc64: Implement tcg_out_extrl_i64_i32
>    tcg/sparc64: Hoist read of tcg_cond_to_rcond
>    tcg/sparc64: Pass TCGCond to tcg_out_cmp
>    tcg/sparc64: Support TCG_COND_TST{EQ,NE}
>    tcg/ppc: Sink tcg_to_bc usage into tcg_out_bc
>    tcg/ppc: Use cr0 in tcg_to_bc and tcg_to_isel
>    tcg/ppc: Tidy up tcg_target_const_match
>    tcg/ppc: Add TCG_CT_CONST_CMP
>    tcg/ppc: Support TCG_COND_TST{EQ,NE}
>    tcg/s390x: Split constraint A into J+U
>    tcg/s390x: Add TCG_CT_CONST_CMP
>    tcg/s390x: Support TCG_COND_TST{EQ,NE}
>    tcg/tci: Support TCG_COND_TST{EQ,NE}
>    target/alpha: Use TCG_COND_TST{EQ,NE} for BLB{C,S}
>    target/alpha: Use TCG_COND_TST{EQ,NE} for CMOVLB{C,S}
>    target/alpha: Use TCG_COND_TSTNE for gen_fold_mzero
>    target/m68k: Use TCG_COND_TST{EQ,NE} in gen_fcc_cond
> 
>   docs/devel/tcg-ops.rst           |   2 +
>   include/tcg/tcg-cond.h           |  49 +++-
>   tcg/aarch64/tcg-target-con-set.h |   5 +-
>   tcg/aarch64/tcg-target-con-str.h |   1 +
>   tcg/i386/tcg-target-con-set.h    |   6 +-
>   tcg/i386/tcg-target-con-str.h    |   1 +
>   tcg/ppc/tcg-target-con-set.h     |   5 +-
>   tcg/ppc/tcg-target-con-str.h     |   1 +
>   tcg/s390x/tcg-target-con-set.h   |   8 +-
>   tcg/s390x/tcg-target-con-str.h   |   3 +-
>   target/alpha/translate.c         |  94 +++----
>   target/m68k/translate.c          |  74 +++--
>   tcg/optimize.c                   | 464 +++++++++++++++++++++++--------
>   tcg/tcg.c                        |  38 ++-
>   tcg/tci.c                        |  14 +
>   tcg/aarch64/tcg-target.c.inc     | 165 ++++++++---
>   tcg/arm/tcg-target.c.inc         |  62 +++--
>   tcg/i386/tcg-target.c.inc        | 178 ++++++++----
>   tcg/loongarch64/tcg-target.c.inc |  59 ++--
>   tcg/mips/tcg-target.c.inc        |  44 ++-
>   tcg/ppc/tcg-target.c.inc         | 277 +++++++++++++-----
>   tcg/riscv/tcg-target.c.inc       |  23 +-
>   tcg/s390x/tcg-target.c.inc       | 246 ++++++++++------
>   tcg/sparc64/tcg-target.c.inc     |  70 +++--
>   tcg/tci/tcg-target.c.inc         |   3 +-
>   25 files changed, 1342 insertions(+), 550 deletions(-)
> 


