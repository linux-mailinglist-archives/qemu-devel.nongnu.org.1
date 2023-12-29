Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C1581FED4
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 11:09:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ9mu-0004Wl-Uw; Fri, 29 Dec 2023 05:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9ms-0004Vc-3P
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 05:08:18 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9mi-0000Ps-KK
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 05:08:17 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33723ad790cso271191f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 02:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703844487; x=1704449287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1NOutDzrsxwjyP0Yzwtvj4YzDS2c028AJe8eTDKx+U0=;
 b=PbTVtXw3Norwk6uWLxglU29DriaB+LSdG7NjIWRuD4QrBVhsC4NBsoFXUg1CLgsnAu
 IoW3AUYgxa7T2W+ZiajjPRRBNOEhk6OpjFX0Tz4kBWkWzGXixAATgB4fofb8kktz2bDY
 yz1uKqsA43UhKKu2hkNyW2SMLkpaOhgJ68aSsCz9m+qUjZKqMsEYJEICcqdctmmwgOH/
 SBEL8v7Uv6CG/M5Sb/yG0OGMpYM+Ae3vdgUUhtx6IIPq3VUBpGmfZfdgSmIZ7L17r7Ju
 zu2SHKHbGVklPtQ8e1I4OejH2ZbER+5WyH+w8VeQoTxPb5dXVcpP/5LEuccUtLc3avn3
 XmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703844487; x=1704449287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1NOutDzrsxwjyP0Yzwtvj4YzDS2c028AJe8eTDKx+U0=;
 b=nQ8t4SBkdC4RHvBbrRXXRAnVf+JoQf6wxyKHcDWWGc8PyJggj1WrFeTUzNbMkgVosQ
 wx1Us9wr6/GwVFE7oifIVlZSDgbxQmMwDdeslOVTcYl3YR0Syzv879kPa5eepb9mn73I
 5JnVfq5eQx6NzVtU0JJpRawmz+QFkOmaCISiOJ/VaMx9cNAGqWVFCFDLHguyaAJgY2No
 VNGzlLwiA37x7UzkSPXP2gkecrlggmy1daj043CcP6mzzfQ+/lpQ8WdDMVCIe2PAMhFq
 gsM/eRlnXMDop4YoB7x27BTztm+cn3TpxQNJF50BePrmPlANL0FMlsy4jsLZ8lAO/WUD
 OvUw==
X-Gm-Message-State: AOJu0YzW/VTlzDq6SFcOZMYRtgCsa95urA7IxNXAOu/fOqalJZcST8L3
 +JlBPcevdVzQfTXJb1DtUoyYin5hqv4ENA==
X-Google-Smtp-Source: AGHT+IE5aue8c7i4XxzqhuRBaOAeADwE6z9moz9RnQl6AaAmO+dC2VKniLL9YIwg8BEA8SJb1laSbw==
X-Received: by 2002:a5d:4a85:0:b0:336:8663:abb with SMTP id
 o5-20020a5d4a85000000b0033686630abbmr4047051wrq.103.1703844486529; 
 Fri, 29 Dec 2023 02:08:06 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.55])
 by smtp.gmail.com with ESMTPSA id
 c17-20020adffb11000000b0033725783839sm765222wrr.110.2023.12.29.02.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 02:08:06 -0800 (PST)
Message-ID: <bf627980-1edd-4743-889c-c27bbae971aa@linaro.org>
Date: Fri, 29 Dec 2023 11:08:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/loongarch: move translate modules to tcg/
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, maobibo@loongson.cn, zhaotianrui@loongson.cn
References: <20231229092435.3416025-1-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231229092435.3416025-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

On 29/12/23 10:24, Song Gao wrote:
> Introduce the target/loongarch/tcg directory. Its purpose is to hold the TCG
> code that is selected by CONFIG_TCG
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/{ => tcg}/constant_timer.c     |  0
>   target/loongarch/{ => tcg}/csr_helper.c         |  0
>   target/loongarch/{ => tcg}/fpu_helper.c         |  0
>   target/loongarch/{ => tcg}/iocsr_helper.c       |  0
>   target/loongarch/{ => tcg}/op_helper.c          |  0
>   target/loongarch/{ => tcg}/tlb_helper.c         |  0
>   target/loongarch/{ => tcg}/translate.c          |  0
>   target/loongarch/{ => tcg}/vec_helper.c         |  0
>   .../{ => tcg}/insn_trans/trans_arith.c.inc      |  0
>   .../{ => tcg}/insn_trans/trans_atomic.c.inc     |  0
>   .../{ => tcg}/insn_trans/trans_bit.c.inc        |  0
>   .../{ => tcg}/insn_trans/trans_branch.c.inc     |  0
>   .../{ => tcg}/insn_trans/trans_extra.c.inc      |  0
>   .../{ => tcg}/insn_trans/trans_farith.c.inc     |  0
>   .../{ => tcg}/insn_trans/trans_fcmp.c.inc       |  0
>   .../{ => tcg}/insn_trans/trans_fcnv.c.inc       |  0
>   .../{ => tcg}/insn_trans/trans_fmemory.c.inc    |  0
>   .../{ => tcg}/insn_trans/trans_fmov.c.inc       |  0
>   .../{ => tcg}/insn_trans/trans_memory.c.inc     |  0
>   .../{ => tcg}/insn_trans/trans_privileged.c.inc |  0
>   .../{ => tcg}/insn_trans/trans_shift.c.inc      |  0
>   .../{ => tcg}/insn_trans/trans_vec.c.inc        |  0
>   target/loongarch/meson.build                    | 17 ++---------------
>   target/loongarch/tcg/meson.build                | 15 +++++++++++++++
>   24 files changed, 17 insertions(+), 15 deletions(-)
>   rename target/loongarch/{ => tcg}/constant_timer.c (100%)
>   rename target/loongarch/{ => tcg}/csr_helper.c (100%)
>   rename target/loongarch/{ => tcg}/fpu_helper.c (100%)
>   rename target/loongarch/{ => tcg}/iocsr_helper.c (100%)
>   rename target/loongarch/{ => tcg}/op_helper.c (100%)
>   rename target/loongarch/{ => tcg}/tlb_helper.c (100%)
>   rename target/loongarch/{ => tcg}/translate.c (100%)
>   rename target/loongarch/{ => tcg}/vec_helper.c (100%)
>   rename target/loongarch/{ => tcg}/insn_trans/trans_arith.c.inc (100%)
>   rename target/loongarch/{ => tcg}/insn_trans/trans_atomic.c.inc (100%)
>   rename target/loongarch/{ => tcg}/insn_trans/trans_bit.c.inc (100%)
>   rename target/loongarch/{ => tcg}/insn_trans/trans_branch.c.inc (100%)
>   rename target/loongarch/{ => tcg}/insn_trans/trans_extra.c.inc (100%)
>   rename target/loongarch/{ => tcg}/insn_trans/trans_farith.c.inc (100%)
>   rename target/loongarch/{ => tcg}/insn_trans/trans_fcmp.c.inc (100%)
>   rename target/loongarch/{ => tcg}/insn_trans/trans_fcnv.c.inc (100%)
>   rename target/loongarch/{ => tcg}/insn_trans/trans_fmemory.c.inc (100%)
>   rename target/loongarch/{ => tcg}/insn_trans/trans_fmov.c.inc (100%)
>   rename target/loongarch/{ => tcg}/insn_trans/trans_memory.c.inc (100%)
>   rename target/loongarch/{ => tcg}/insn_trans/trans_privileged.c.inc (100%)
>   rename target/loongarch/{ => tcg}/insn_trans/trans_shift.c.inc (100%)
>   rename target/loongarch/{ => tcg}/insn_trans/trans_vec.c.inc (100%)
>   create mode 100644 target/loongarch/tcg/meson.build


> diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
> index 18e8191e2b..a004523439 100644
> --- a/target/loongarch/meson.build
> +++ b/target/loongarch/meson.build
> @@ -3,31 +3,18 @@ gen = decodetree.process('insns.decode')
>   loongarch_ss = ss.source_set()
>   loongarch_ss.add(files(
>     'cpu.c',
> +  'gdbstub.c'

Preferably a preliminary commit "gdbstub.c is not specific to TCG and
can be used by other accelerators ...". Otherwise just mention it in
this patch description.

>   ))
> -loongarch_tcg_ss = ss.source_set()
> -loongarch_tcg_ss.add(gen)
> -loongarch_tcg_ss.add(files(
> -  'fpu_helper.c',
> -  'op_helper.c',
> -  'translate.c',
> -  'gdbstub.c',
> -  'vec_helper.c',
> -))
> -loongarch_tcg_ss.add(zlib)
>   
>   loongarch_system_ss = ss.source_set()
>   loongarch_system_ss.add(files(
>     'loongarch-qmp-cmds.c',
>     'machine.c',
> -  'tlb_helper.c',
> -  'constant_timer.c',
> -  'csr_helper.c',
> -  'iocsr_helper.c',
>   ))
>   
>   common_ss.add(when: 'CONFIG_LOONGARCH_DIS', if_true: [files('disas.c'), gen])
>   
> -loongarch_ss.add_all(when: 'CONFIG_TCG', if_true: [loongarch_tcg_ss])
> +subdir('tcg')
>   
>   target_arch += {'loongarch': loongarch_ss}
>   target_system_arch += {'loongarch': loongarch_system_ss}
> diff --git a/target/loongarch/tcg/meson.build b/target/loongarch/tcg/meson.build
> new file mode 100644
> index 0000000000..bb7411e5e5
> --- /dev/null
> +++ b/target/loongarch/tcg/meson.build
> @@ -0,0 +1,15 @@

You missed the CONFIG_TCG check, you can use either:

   if 'CONFIG_TCG' in config_all
      subdir('tcg')
   endif

in target/loongarch/meson.build, but since your target seems well
designed and doesn't require TCG stub, you can do directly here:

   if 'CONFIG_TCG' not in config_all
     subdir_done()
   endif

so the rest of this file isn't processed.

> +loongarch_ss.add([zlib, gen])
> +
> +loongarch_ss.add(files(
> +  'fpu_helper.c',
> +  'op_helper.c',
> +  'vec_helper.c',
> +  'translate.c',

(since moved/new, let's sort these files alphabetically).

> +))
> +
> +loongarch_system_ss.add(files(
> +  'constant_timer.c',
> +  'iocsr_helper.c',
> +  'tlb_helper.c',
> +  'csr_helper.c',

(Ditto)

> +))


