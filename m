Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0AC79FBAB
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:10:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfYR-0006YL-SE; Thu, 14 Sep 2023 02:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfYQ-0006YA-75
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:10:18 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfYN-0006fO-Or
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:10:17 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9aa0495f9cfso374721266b.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 23:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694671812; x=1695276612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+fxTA/AtWN/iwugOgDKG6O4PJ7gw8BspFauaykU3BPE=;
 b=iXv1HC2GT1zw4hGqEFKkr7Qfp8oRI7kzDk/q/5mkfgYX0jGpwm3rnhUWO/3LFl8b37
 mkLcQI32CIHA0kuMi8vvaDS0pU4NqemjJOheJxOm3H40orE6LmhlSLkVtJ7Oggkrqm6/
 NKSLF8iJkub4mf4a2dvYYDsvxWMBBMwn0ljnEF1wcxKorp4gBe9dSbqHmt63VFilojnC
 7Ub2LQ5ej044GJMNKE7h44vFWyUnkj0rbfs/ObOWie7efiM8WdZf761MUCgmu8lyU0d5
 SU08R61hjjEgFWzfijReVmgTkuKZV9ouKknWM8PVGijXYMOFM8VtttiXTXFidAVVntfq
 OVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694671812; x=1695276612;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+fxTA/AtWN/iwugOgDKG6O4PJ7gw8BspFauaykU3BPE=;
 b=w3I/glGV29YJ3pmmKHm6NOr1vlo75i4Ygag4bffiI58wmTrAU3q8EIJsqRcWcVf0aQ
 GqXNLyRvFHdbi/S4uel4fKgH06O7tdnGRfwaHZA+G3HKnEcTK+HKUIxBu/LG2eBc97IQ
 u+WJjwD9UtRBshfR7K/eIvak2HW5GThmCXVvEKmezKydfSEsVdONhybU+sqhnpEasA5M
 RN5dDresgoIXTA2ondJ5uGz00ttA5Zg0hIITx9ZbPa+Mjtqw4KhntmxEFv8YLOat1zj5
 ud0c1HE9BG3Bukp1wRBkxsp6FFqg2BrqqTuUsZRX2EnqY7LmYyyF6strg+b1BknN8wfh
 uSRg==
X-Gm-Message-State: AOJu0YxznQORYFPFKQLBdCgjWe5z58MGCjodhlqNaQCjvuuFVdPH4TqZ
 r5afk5Dl4dX2W58OJwplMq79goJ1DWh134ERP4w=
X-Google-Smtp-Source: AGHT+IE5zAArOnhKmh6ce0SUC4fsQy4eolrdbt7kJpjcjFlMlbZIuo0xzylIAOFM9FRNRz8Hoz76lw==
X-Received: by 2002:a17:907:7717:b0:9ad:b37f:9615 with SMTP id
 kw23-20020a170907771700b009adb37f9615mr1201405ejc.29.1694671812382; 
 Wed, 13 Sep 2023 23:10:12 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 u11-20020a170906068b00b00991faf3810esm500918ejb.146.2023.09.13.23.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 23:10:12 -0700 (PDT)
Message-ID: <2bc511e7-9932-dd75-fb13-c3bb0196111a@linaro.org>
Date: Thu, 14 Sep 2023 08:10:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 12/24] tcg: Rename cpu_env to tcg_env
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914024435.1381329-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 14/9/23 04:44, Richard Henderson wrote:
> Allow the name 'cpu_env' to be used for something else.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h                             |    2 +-
>   target/arm/tcg/translate-a32.h                |    2 +-
>   target/arm/tcg/translate-a64.h                |    4 +-
>   target/arm/tcg/translate.h                    |   16 +-
>   target/hexagon/gen_tcg.h                      |  120 +-
>   target/hexagon/gen_tcg_hvx.h                  |   20 +-
>   target/hexagon/macros.h                       |    8 +-
>   target/mips/tcg/translate.h                   |    6 +-
>   accel/tcg/translator.c                        |    8 +-
>   target/alpha/translate.c                      |  142 +-
>   target/arm/tcg/translate-a64.c                |  374 ++---
>   target/arm/tcg/translate-m-nocp.c             |   24 +-
>   target/arm/tcg/translate-mve.c                |   52 +-
>   target/arm/tcg/translate-neon.c               |   78 +-
>   target/arm/tcg/translate-sme.c                |    8 +-
>   target/arm/tcg/translate-sve.c                |  172 +--
>   target/arm/tcg/translate-vfp.c                |   56 +-
>   target/arm/tcg/translate.c                    |  228 +--
>   target/avr/translate.c                        |   64 +-
>   target/cris/translate.c                       |   68 +-
>   target/hexagon/genptr.c                       |   36 +-
>   target/hexagon/idef-parser/parser-helpers.c   |    2 +-
>   target/hexagon/translate.c                    |   48 +-
>   target/hppa/translate.c                       |  144 +-
>   target/i386/tcg/translate.c                   |  580 ++++----
>   target/loongarch/translate.c                  |   18 +-
>   target/m68k/translate.c                       |  302 ++--
>   target/microblaze/translate.c                 |   50 +-
>   target/mips/tcg/lcsr_translate.c              |    6 +-
>   target/mips/tcg/msa_translate.c               |   34 +-
>   target/mips/tcg/mxu_translate.c               |    4 +-
>   target/mips/tcg/translate.c                   | 1284 ++++++++---------
>   target/mips/tcg/vr54xx_translate.c            |    2 +-
>   target/nios2/translate.c                      |   48 +-
>   target/openrisc/translate.c                   |   84 +-
>   target/ppc/translate.c                        |  362 ++---
>   target/riscv/translate.c                      |   50 +-
>   target/rx/translate.c                         |   56 +-
>   target/s390x/tcg/translate.c                  |  424 +++---
>   target/sh4/translate.c                        |  124 +-
>   target/sparc/translate.c                      |  328 ++---
>   target/tricore/translate.c                    |  220 +--
>   target/xtensa/translate.c                     |  188 +--
>   tcg/tcg-op-gvec.c                             |  288 ++--
>   tcg/tcg-op-ldst.c                             |   22 +-
>   tcg/tcg-op.c                                  |    2 +-
>   tcg/tcg.c                                     |    4 +-
>   target/cris/translate_v10.c.inc               |   28 +-
>   target/i386/tcg/decode-new.c.inc              |    2 +-
>   target/i386/tcg/emit.c.inc                    |  262 ++--
>   .../loongarch/insn_trans/trans_atomic.c.inc   |    4 +-
>   .../loongarch/insn_trans/trans_branch.c.inc   |    2 +-
>   target/loongarch/insn_trans/trans_extra.c.inc |   10 +-
>   .../loongarch/insn_trans/trans_farith.c.inc   |    6 +-
>   target/loongarch/insn_trans/trans_fcmp.c.inc  |    8 +-
>   .../loongarch/insn_trans/trans_fmemory.c.inc  |    8 +-
>   target/loongarch/insn_trans/trans_fmov.c.inc  |   20 +-
>   target/loongarch/insn_trans/trans_lsx.c.inc   |   44 +-
>   .../loongarch/insn_trans/trans_memory.c.inc   |    8 +-
>   .../insn_trans/trans_privileged.c.inc         |   52 +-
>   target/mips/tcg/micromips_translate.c.inc     |   12 +-
>   target/mips/tcg/nanomips_translate.c.inc      |  200 +--
>   target/ppc/power8-pmu-regs.c.inc              |    8 +-
>   target/ppc/translate/branch-impl.c.inc        |    2 +-
>   target/ppc/translate/dfp-impl.c.inc           |   22 +-
>   target/ppc/translate/fixedpoint-impl.c.inc    |    2 +-
>   target/ppc/translate/fp-impl.c.inc            |   50 +-
>   .../ppc/translate/processor-ctrl-impl.c.inc   |    8 +-
>   target/ppc/translate/spe-impl.c.inc           |   30 +-
>   target/ppc/translate/storage-ctrl-impl.c.inc  |   26 +-
>   target/ppc/translate/vmx-impl.c.inc           |   34 +-
>   target/ppc/translate/vsx-impl.c.inc           |   54 +-
>   .../riscv/insn_trans/trans_privileged.c.inc   |    8 +-
>   target/riscv/insn_trans/trans_rvbf16.c.inc    |   10 +-
>   target/riscv/insn_trans/trans_rvd.c.inc       |   48 +-
>   target/riscv/insn_trans/trans_rvf.c.inc       |   46 +-
>   target/riscv/insn_trans/trans_rvh.c.inc       |    8 +-
>   target/riscv/insn_trans/trans_rvi.c.inc       |   16 +-
>   target/riscv/insn_trans/trans_rvm.c.inc       |   16 +-
>   target/riscv/insn_trans/trans_rvv.c.inc       |  130 +-
>   target/riscv/insn_trans/trans_rvvk.c.inc      |   30 +-
>   target/riscv/insn_trans/trans_rvzce.c.inc     |    2 +-
>   target/riscv/insn_trans/trans_rvzfa.c.inc     |   38 +-
>   target/riscv/insn_trans/trans_rvzfh.c.inc     |   54 +-
>   target/riscv/insn_trans/trans_rvzicbo.c.inc   |    8 +-
>   target/riscv/insn_trans/trans_svinval.c.inc   |    6 +-
>   target/riscv/insn_trans/trans_xthead.c.inc    |    2 +-
>   target/s390x/tcg/translate_vx.c.inc           |  104 +-
>   target/hexagon/README                         |   10 +-
>   target/hexagon/gen_tcg_funcs.py               |   16 +-
>   90 files changed, 3808 insertions(+), 3808 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


