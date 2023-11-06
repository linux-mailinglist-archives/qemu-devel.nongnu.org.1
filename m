Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4907E7E27A5
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:50:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00vA-0006xm-Jp; Mon, 06 Nov 2023 09:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r00v5-0006rP-AQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:49:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r00v0-0003L1-CI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:49:38 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40836ea8cbaso32318315e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699282171; x=1699886971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZXl0fa8RuDws95Qzrt8I0p4dUeB9fB4UJONm7LU/deg=;
 b=Psv4QY45vl0SUy+SdHw9zw4VLLvHBvJ+SE8o3YOQxmNY+UgC5mCbO4LxnN0F8gtKJk
 TWW5tAq8vhM7LASZPQOnTiJOmhaulZsvmeu4hYji1BsfUxmjva/TXGj6zuFnCy/F1LRk
 7Pgw+/pPv+kMBN0ZyVWMQ+cVU1r0NyCirzCSTXjVkC/Hh1DoVO3FsHzG+9FEvBpu9cgk
 mqgaW4YhJXpt27uu8Gbvt2gVYHImiGtZQgLwV6u2V1/MYvCXkIk/o0JL01J2MSL3Imuv
 M7TsTiwlY6yJUTmhqzzWhcsvhd4XgiOUDk3ZJeNdSLR7CJrYHxSjetPHkk24dJ3vzuds
 hsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699282171; x=1699886971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXl0fa8RuDws95Qzrt8I0p4dUeB9fB4UJONm7LU/deg=;
 b=Q/s2MtoycuQdk8quM+rH7gDrZU9fw/nTFIuSV2oMaro64Fd6jJJ6TC1zNMaWqcLH7y
 +XzbFN9DY1MqOsbfjDJ8a1VsYnXgePz0ilnnVH6b/fFKvM6t8MiB+mM2hH+qW95pENhQ
 4ClVxD5c1QfDqJbdaQdsUfiASerkNFyIF3PkxJMz9Ak2MHZmYknbEzDBDgPnxbv7rVSw
 tkAWeYVZdrT5mrw/LQCyAvjpYhXlBQiCzisk4oF05aavVHn1LOBAHQl6E1l3LWUfNkpN
 byubp7+o116w1pQovbBb24sSI33g66EEQQxKCNiJasJqBe8d2CRZNA1pt1gVbh+lqBxp
 L5yQ==
X-Gm-Message-State: AOJu0YyjW48YEKPvgnZnc/qUfva+nVmWjfyGlf0hJ+M6ZqRfBC8oOz5e
 gWyQIYi92pytTHfWYl2B6mJ6vA==
X-Google-Smtp-Source: AGHT+IGwJ9dw1cQZe5UbzvFhmGHqg1LdESGZVr7JwuYLowug30YOz1jDV+QZx8bxgmfPz+fLHMLx0w==
X-Received: by 2002:a05:600c:3148:b0:401:bdd7:499d with SMTP id
 h8-20020a05600c314800b00401bdd7499dmr24783115wmo.25.1699282171164; 
 Mon, 06 Nov 2023 06:49:31 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 f14-20020a5d50ce000000b00326f0ca3566sm9592833wrt.50.2023.11.06.06.49.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 06:49:30 -0800 (PST)
Message-ID: <ffe5e4b3-4c9a-9cee-f997-f53be1656b21@linaro.org>
Date: Mon, 6 Nov 2023 15:49:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] NOTFORMERGE tcg/i386: Assert sub of immediate has
 been folded
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231026013945.1152174-1-richard.henderson@linaro.org>
 <20231026013945.1152174-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231026013945.1152174-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 26/10/23 03:39, Richard Henderson wrote:
> A release build should simply accept and emit the subtract.
> I'm not even sure if this is reasonable to keep for debug.
> 
> Not-Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                 | 49 ++++++++++++++++++++++++++-------------
>   tcg/i386/tcg-target.c.inc | 13 ++++++++---
>   2 files changed, 43 insertions(+), 19 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index a507c111cf..408647af7e 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3618,23 +3618,40 @@ liveness_pass_1(TCGContext *s)
>           do_addsub2:
>               nb_iargs = 4;
>               nb_oargs = 2;
> -            /* Test if the high part of the operation is dead, but not
> -               the low part.  The result can be optimized to a simple
> -               add or sub.  This happens often for x86_64 guest when the
> -               cpu mode is set to 32 bit.  */
> -            if (arg_temp(op->args[1])->state == TS_DEAD) {
> -                if (arg_temp(op->args[0])->state == TS_DEAD) {
> -                    goto do_remove;
> -                }
> -                /* Replace the opcode and adjust the args in place,
> -                   leaving 3 unused args at the end.  */
> -                op->opc = opc = opc_new;
> -                op->args[1] = op->args[2];
> -                op->args[2] = op->args[4];
> -                /* Fall through and mark the single-word operation live.  */
> -                nb_iargs = 2;
> -                nb_oargs = 1;
> +            /*
> +             * Test if the high part of the operation is dead, but the low
> +             * part is still live.  The result can be optimized to a simple
> +             * add or sub.
> +             */
> +            if (arg_temp(op->args[1])->state != TS_DEAD) {
> +                goto do_not_remove;
>               }
> +            if (arg_temp(op->args[0])->state == TS_DEAD) {
> +                goto do_remove;
> +            }
> +            /*
> +             * Replace the opcode and adjust the args in place, leaving 3
> +             * unused args at the end.  Canonicalize subi to andi.

Typo s/andi/addi/.

> +             */
> +            op->args[1] = op->args[2];
> +            {
> +                TCGTemp *src2 = arg_temp(op->args[4]);
> +                if (src2->kind == TEMP_CONST) {
> +                    if (opc_new == INDEX_op_sub_i32) {
> +                        src2 = tcg_constant_internal(TCG_TYPE_I32,
> +                                                     (int32_t)-src2->val);
> +                        opc_new = INDEX_op_add_i32;
> +                    } else if (opc_new == INDEX_op_sub_i64) {
> +                        src2 = tcg_constant_internal(TCG_TYPE_I64, -src2->val);
> +                        opc_new = INDEX_op_add_i64;
> +                    }
> +                }
> +                op->args[2] = temp_arg(src2);
> +            }
> +            op->opc = opc = opc_new;
> +            /* Mark the single-word operation live.  */
> +            nb_iargs = 2;
> +            nb_oargs = 1;
>               goto do_not_remove;

For tcg/tcg.c with your S-o-b and a reworded description:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


