Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A54C97DA9A7
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 23:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwr2X-0008ND-0R; Sat, 28 Oct 2023 17:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwr2T-0008Mq-Rd
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 17:40:14 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwr2S-0006Ki-8j
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 17:40:13 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-351574aca7bso9915065ab.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 14:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698529211; x=1699134011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BdV3YadZuViCj2QFPCIJHJ4csisPwpXufeLqjPQWktc=;
 b=P0pJcTJ1s3c0ojggdjImRpnPGV6V8FKb3NRMqAYIOflEmOHfLnlhpphY3gv7b3l6xW
 eJvqGzWx4b+hV4pJ5v2aWmzYnfK+UP0ZPjhyRemGphR71YnTAPEI8hP4tQME1twcDvtM
 UCOEBZHcxW9mJk/zIvgKyS1CFsMdOZ4opRYGbkzmP1dRZGXXDKTM4iEfdVYUaITCaaLz
 oOBRLKoG5Ln/euaOHCq0Feo7UBjGqWjvTDWUYUcGwTwpJaNZu8LtZlAeEo4/k1sneDBR
 T3KPagVl/Y4djTBU9npF6dtVHmkOlI06r9MpEhExFxBIEQrf1aj18gHv53gD53b5KubZ
 PWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698529211; x=1699134011;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BdV3YadZuViCj2QFPCIJHJ4csisPwpXufeLqjPQWktc=;
 b=cIgiWdzBwOm9ckaidnH+N4eqGngXzCyzyp4C+xrzqSVbm8JUWrjVp8I5gm1/M4FFxo
 Ylj2/rVDVypyjFdeGlhbIsLVDpcKIoKTa5yDAzHmMDOUcBQltFJLb7+22UtKf0z5Qqwl
 eZbGlL6ertFmxE6ru5/28FIKRcVjaoYsH9PCY1nvBw0oTeznBTQsZqEJgPr+CKIuPil8
 Yq4tG8K27MzpL6PV3HAdh/itxerlbmXqjZKrtBnlZao0t3l67goh1/Inunb977cSfMRp
 aIswuQmPVxXye+1Z9BqJQyF9ob+Ft7oOot/JiOym2ZdGdLhu6ufXXoo+v0zaSAxpoG/v
 jpCA==
X-Gm-Message-State: AOJu0YxSqOaZneDDAFIwcSyVLOBPf3HstxYHWO2IGCYVxLRaPcabW2mG
 JQpzUZ4VQymrYnhs5J+hj4h1Rg==
X-Google-Smtp-Source: AGHT+IGPzsk45xd03ON5Ny94gYt0R+KLyc+ujA+4xSiOMKEw51dq+FwpUAghXZZvK7LTlR3P4kmTiQ==
X-Received: by 2002:a05:6e02:1c2c:b0:351:1647:5f7e with SMTP id
 m12-20020a056e021c2c00b0035116475f7emr8773481ilh.15.1698529210964; 
 Sat, 28 Oct 2023 14:40:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a170902ea8300b001c3267ae317sm2153242plb.165.2023.10.28.14.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 14:40:10 -0700 (PDT)
Message-ID: <1c4c0856-337e-4c5e-b2af-6caf35060b0a@linaro.org>
Date: Sat, 28 Oct 2023 14:40:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] target/loongarch: Add set_vec_extctx to set
 LSX/LASX instructions extctx_flags
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, laurent@vivier.e, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, laurent@vivier.eu
References: <20231010033701.385725-1-gaosong@loongson.cn>
 <20231010033701.385725-3-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010033701.385725-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x133.google.com
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

On 10/9/23 20:36, Song Gao wrote:
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/insn_trans/trans_vec.c.inc | 12 ++++++++++++
>   target/loongarch/internals.h                |  2 ++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
> index 98f856bb29..aef16ef44a 100644
> --- a/target/loongarch/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/insn_trans/trans_vec.c.inc
> @@ -23,8 +23,20 @@ static bool check_vec(DisasContext *ctx, uint32_t oprsz)
>   
>   #else
>   
> +static void set_vec_extctx(DisasContext *ctx, uint32_t oprsz)
> +{
> +    if (oprsz == 16) {
> +        ctx->extctx_flags |= EXTCTX_FLAGS_LSX;
> +    }
> +
> +    if (oprsz == 32) {
> +        ctx->extctx_flags |= EXTCTX_FLAGS_LASX;
> +    }
> +}
> +
>   static bool check_vec(DisasContext *ctx, uint32_t oprsz)
>   {
> +    set_vec_extctx(ctx, oprsz);
>       return true;
>   }

This doesn't do anything.  Nothing copies the changed value back to env.
Anyway, I think this is the wrong way to go about it.

If you want to track what the program is using, you should do it exactly like the real 
kernel: disable the execution unit, have the program trap, and the enable the execution 
unit when the trap occurs.  At this point, CSR_EUEN enable bits contain exactly which 
units have been used by the program.


r~


