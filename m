Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C3E7F12FB
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 13:14:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r53AA-0002fw-6J; Mon, 20 Nov 2023 07:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r53A5-0002fN-Ry
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 07:13:59 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r53A4-0007Lo-42
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 07:13:57 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5401bab7525so6171706a12.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 04:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700482434; x=1701087234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VMcSmPM52XARy4Pdj+aniY6ddRnTaznLc+N2nXNi/Lo=;
 b=V6nrknBLXN2wTRdvTtejQX5Lkr6bWIMZM2mfNi/ahqrMApzSlKEeRt3WEgF8/RIPYn
 iU1YXKpKO8mOhWEFbFogJwW7SESedqZkxF6LJ2l8ZtqYWdNNY13N9D6DwPxxWt0W/RSa
 0oQBgskqC52Y2gPBe9uNoFXHYfv9fwxO9zSipFo3+AAQCl4ikSSyZsSuk8HY6Q/ACE4T
 cUKXrQSKHLoW7BWnD0WQ4r1XFFIi1Hi2c0zObFfdKzBnlYWIDDhCRy4HOEAgDb9valwg
 O2X5dDFIyDnBh7Rjcz6Zjnxw8DoQiWGWqNjBpjIHHZ9DnWUo9rNuheALavxCxJAHYrEM
 ZV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700482434; x=1701087234;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VMcSmPM52XARy4Pdj+aniY6ddRnTaznLc+N2nXNi/Lo=;
 b=CBozNOgXMqGJAKEuSnxDAs+0dA26Vwl+aJ9B0m5xHVTO+a9YSMNtWfPjoLLXt6VM1S
 eVEFhlSy3ebr8cmb/r90wbTNOjHnQbfabGUYWIMixw4IlSP9EYHODFNDVUGbxsWIKys+
 aDFwxplYNBiHCfWq8/Mj9q+4eLhbizF2MdfaHR0mH7vEyCR9l6qN9sbnpoYKV4CWwniW
 S/UxLZchnQcdtCKdrQ8sHSBUFu5p/E4PkvDFzdB2/0CTHhjzxHCTnL7HAoqp5OnF0WeZ
 d5bYA9Mxc/82sJjJ0sgUPlSAjZkmUVZyllATcB3CJ4aHZlEv2sPADz30P2e6GaA2Ozzi
 Y+6A==
X-Gm-Message-State: AOJu0Ywo0G+7n8J6kkm31pZHCopr2sIWDDxpgDPVruuEdOIfE781ysLk
 GP3pVYar8dyRED3MFbh6b5gZpS2IU4sGFRvp5JI=
X-Google-Smtp-Source: AGHT+IG3xIcnYX7WH2huwBvJphBmAiiZ1PcXrQ7yn2yGgSXvuqoNGmDX3fbjns9z59enIgeyTTPquA==
X-Received: by 2002:a17:906:1ca:b0:9de:cfa1:f077 with SMTP id
 10-20020a17090601ca00b009decfa1f077mr4533189ejj.14.1700482434373; 
 Mon, 20 Nov 2023 04:13:54 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 mf3-20020a170906cb8300b009f28db2b702sm3800891ejb.209.2023.11.20.04.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 04:13:53 -0800 (PST)
Message-ID: <2944be42-01aa-4313-be90-6139e6826d1d@linaro.org>
Date: Mon, 20 Nov 2023 13:13:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2 1/1] tcg/loongarch64: Fix tcg_out_mov() Aborted
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, git@xen0n.name, c@jia.je, maobibo@loongson.cn
References: <20231120065916.374045-1-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231120065916.374045-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 20/11/23 07:59, Song Gao wrote:
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

Available since commit af88a28414 ("tcg/loongarch64: Import LSX
instructions"), missed when LSX host instruction got enabled in
commit 16288ded94 ("tcg/loongarch64: Lower basic tcg vec ops to LSX").


Fixes: 16288ded94 ("tcg/loongarch64: Lower basic tcg vec ops to LSX")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

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
>       default:
>           g_assert_not_reached();
>       }


