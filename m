Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5657F180A
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 17:01:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r56h0-0004kl-6B; Mon, 20 Nov 2023 11:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r56gf-0004kA-6n
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:59:51 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r56gd-0002iA-EA
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:59:48 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507e85ebf50so5843324e87.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700495985; x=1701100785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Ur55kukUX0tKyWQqHONZfzhZhbO0pBb/iurEcRuyDQ=;
 b=m40/xqBNKs1UZLEm6YoetSA1sxOm5tCi33ScqPFAl+b8ZS4qcEk9F1Xxg+MbZ15J/y
 5GI+WLzMXa4CU+R7BoW6o3rVdvl9aQgEiMzyx3O8qTGpmodP+pg3hUsfIMA84ae3oIl9
 ocMDf0FEU5ecUkb8U5wThmUpXHOzz5vxBpHPgurEf+DRAbpdHbKY6GFQ0pk20W55bE3i
 77LpjN0haIiLHJf5DaH2u8lTTuh6h98NNPDrk58bJvhJ23BaA7W0E76xa0zFfr7S40zD
 tRO9q+00fE/hn4CyN9Y66TxBacVJbvpXwYJQNwzuRxjDJAnR7u35XekDtKuP1N0whsaM
 y3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700495985; x=1701100785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Ur55kukUX0tKyWQqHONZfzhZhbO0pBb/iurEcRuyDQ=;
 b=Pvvk+7Au8uEqLgXHQONFG7eMj1IFSQvHIVaQTRwAHaK+8YpSKy9BgzP6CyFfTg/7no
 dUVEmULCcVYt0QxYvdwQyvQB9JgO2AS6XkDPpiBoGYXEnzfBMmoaHtX3Y4DPy7J08b11
 sj0xwfjKrWSs++GIGM02kdcZozfSPMghmZV252RjbJXbjY0XkXbaa8vBNzx2LQP1F53z
 ir/M30KL1MVlmIgRX3VNIWfBvzs8WvxhundFM8aSavPYlez++eQzbNXDyLV/dMyMz2v0
 YfVnAgimk5rxR6VwoQ507nfGoBb84Qk2TmKW6058B2scEcRZDIfRolluymnWDmSVJ380
 KQiQ==
X-Gm-Message-State: AOJu0YzKlg0sBu28hbqJ7anYyJAF04655coU7z8wJK1ZkqlyC7CjLPsd
 ZX1h7c5v2MVgwVedVkKtUTUb1A==
X-Google-Smtp-Source: AGHT+IGQcZ3Tk5yRz3Kb2XJqv1WvELYX3oNWPRNKLPQdNNY6jgwW1IaMgzcBEgpQNXmDWDVAPT67eg==
X-Received: by 2002:ac2:5f87:0:b0:509:4bd1:6b63 with SMTP id
 r7-20020ac25f87000000b005094bd16b63mr4704853lfe.16.1700495984996; 
 Mon, 20 Nov 2023 07:59:44 -0800 (PST)
Received: from [192.168.174.227] ([91.223.100.4])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a197516000000b0050481c400e9sm1217438lfe.287.2023.11.20.07.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 07:59:44 -0800 (PST)
Message-ID: <e99f440c-6d95-4e7c-b08e-332897062997@linaro.org>
Date: Mon, 20 Nov 2023 07:59:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tcg/loongarch64: Fix tcg_out_mov() Aborted
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, git@xen0n.name, c@jia.je, maobibo@loongson.cn
References: <20231120065916.374045-1-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231120065916.374045-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=no autolearn_force=no
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

On 11/19/23 22:59, Song Gao wrote:
> On LoongArch host,  we got an Aborted from tcg_out_mov().
> 
> qemu-x86_64 configure with '--enable-debug'.
> 
>> (gdb) b /home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312
>> Breakpoint 1 at 0x2576f0: file /home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc, line 312.
>> (gdb) run hello
> [...]
>> Thread 1 "qemu-x86_64" hit Breakpoint 1, tcg_out_mov (s=0xaaaae91760 <tcg_init_ctx>, type=TCG_TYPE_V128, ret=TCG_REG_V2,
>>      arg=TCG_REG_V0) at /home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312
>> 312           g_assert_not_reached();
>> (gdb) bt
>> #0  tcg_out_mov (s=0xaaaae91760 <tcg_init_ctx>, type=TCG_TYPE_V128, ret=TCG_REG_V2, arg=TCG_REG_V0)
>>      at /home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312
>> #1  0x000000aaaad0fee0 in tcg_reg_alloc_mov (s=0xaaaae91760 <tcg_init_ctx>, op=0xaaaaf67c20) at ../tcg/tcg.c:4632
>> #2  0x000000aaaad142f4 in tcg_gen_code (s=0xaaaae91760 <tcg_init_ctx>, tb=0xffe8030340 <code_gen_buffer+197328>,
>>      pc_start=4346094) at ../tcg/tcg.c:6135
> [...]
>> (gdb) c
>> Continuing.
>> **
>> ERROR:/home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312:tcg_out_mov: code should not be reached
>> Bail out! ERROR:/home1/gaosong/code/qemu/tcg/loongarch64/tcg-target.c.inc:312:tcg_out_mov: code should not be reached
>>
>> Thread 1 "qemu-x86_64" received signal SIGABRT, Aborted.
>> 0x000000fff7b1c390 in raise () from /lib64/libc.so.6
>> (gdb) q
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index a588fb3085..5f68040230 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -308,6 +308,9 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>            */
>           tcg_out_opc_or(s, ret, arg, TCG_REG_ZERO);
>           break;
> +    case TCG_TYPE_V128:
> +        tcg_out_opc_vaddi_du(s, ret, arg, 0);
> +        break;

Is add with immediate zero really the canonical alias for "vector move"?

There is often some form that is recommended by the architecture, so that it may be 
recognized for register renaming.  Usually it is some form of logic instruction, not 
arithmetic.  I see that LLVM emits "vori.b dst, src, 0" for this case.

Regardless, this patch works to fix the assert so,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

