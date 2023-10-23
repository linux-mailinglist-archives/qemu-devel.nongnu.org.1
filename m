Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AFC7D4326
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4DG-0004hu-CH; Mon, 23 Oct 2023 19:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv4DD-0004hP-2H
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:19:55 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv4D7-0006Rq-IB
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:19:54 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b20577ef7bso3031309b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698103188; x=1698707988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mytmIONeCW6zDX9rbeVfacck6xVZsCOol5DsKHnoq6M=;
 b=YA9KdIKKIbBkMBUHV6Uxxh1yc4Bz9kWtvXvYfKlsAPrfWIZpESU7ffu+jox6vS1N+v
 ajsjYxyKd/3JFsx/IiLEdcu/5L3wSSwChMj+H1GkcR3FpBRw+XOGia75++eNtTm4n9Zg
 jghVEC1Vs1YkU7cqr9PoxDx6gY30VXdeX58E+EBpu0G5fcm577cOlMvVo6hTKg5umOoR
 wIxwqvF/lyJiE+yzSlCfohUjGaX0jIZCcXzgRXkk0gCUlbOMLyglmICZgTp/YKB+Hgvi
 mUqfGESuKcE0GRONlyGpVd9hwDOZWsfOvaYDCuqM4RrrAgCjhyrmAeU8jq/2aPg9xWdi
 3mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698103188; x=1698707988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mytmIONeCW6zDX9rbeVfacck6xVZsCOol5DsKHnoq6M=;
 b=ug5oHr+tIYqp7sbLMkPDb/QvaVxz56rWtkii/BzqjPJLXf/MmPu5A9LDXr0zgzbIP6
 o++/EnSptso+gAstrhqOta8DOTwcPGTKc7YBI6iawTu1ryvCOtyYsNmdgX1iqN01Za3S
 ySb45OzUaFzl0YrxpRZ1bY/XWTIxyOQwrrrvn6x2Toesh+6u058KQH2RTNL9tk3hyECc
 AQl7JuAy+uw3KKXjVHZRj2pk+nzq8ef8Iy4m3xvvY2rs1hd+dAD1gGfBKqdHppl+McZp
 ulhjMjFdNb/hQ/NtH/Mu2uXWcXqNubWcQpJHfFQYLJnfZ4YgBYMRvlVg+xwQyD0dNNL9
 FfSg==
X-Gm-Message-State: AOJu0Ywn2Ni8Q8PjQqHBuvcQ/9SEAFt0wC66OhJG+IgVFdT1pNK8X7zb
 E/5vugs8K7JKPkf2EmTixaMpYS+uje5mcy03nuM=
X-Google-Smtp-Source: AGHT+IGBQB0rN6DG2zKGGAD6bxvdxFy10NWQPaWY0hRRpMA5r74NuwW6x4Td0bAjUQpboV1Hfvb1kQ==
X-Received: by 2002:a05:6a00:1a09:b0:691:21:d9b9 with SMTP id
 g9-20020a056a001a0900b006910021d9b9mr7744747pfv.30.1698103187939; 
 Mon, 23 Oct 2023 16:19:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 z14-20020aa7990e000000b006b4ac8885b4sm6835977pff.14.2023.10.23.16.19.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 16:19:47 -0700 (PDT)
Message-ID: <3b1d340a-8b11-4b66-82c1-1e8ddbba466b@linaro.org>
Date: Mon, 23 Oct 2023 16:19:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/loongarch: Add llacq/screl instructions
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20231023153029.269211-2-c@jia.je>
 <20231023153029.269211-7-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231023153029.269211-7-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/23/23 08:29, Jiajie Chen wrote:
> --- a/target/loongarch/insn_trans/trans_atomic.c.inc
> +++ b/target/loongarch/insn_trans/trans_atomic.c.inc
> @@ -17,6 +17,14 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
>       return true;
>   }
>   
> +static bool gen_llacq(DisasContext *ctx, arg_rr *a, MemOp mop)
> +{
> +    arg_rr_i tmp_a = {
> +        .rd = a->rd, .rj = a->rj, .imm = 0
> +    };
> +    return gen_ll(ctx, &tmp_a, mop);
> +}
> +
>   static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
>   {
>       TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
> @@ -45,6 +53,14 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
>       return true;
>   }
>   
> +static bool gen_screl(DisasContext *ctx, arg_rr *a, MemOp mop)
> +{
> +    arg_rr_i tmp_a = {
> +        .rd = a->rd, .rj = a->rj, .imm = 0
> +    };
> +    return gen_sc(ctx, &tmp_a, mop);
> +}

This is incorrect.  You need to add the required memory barriers.

Should be like

- static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
+ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop, bool acq)
   {
       ...
+     if (acq) {
+         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+     }
       return true;
   }

- static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
+ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop, bool rel)
   {
       ...
+     if (rel) {
+         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+     }
       tcg_gen_brcond_tl(TCG_COND_EQ, t0, cpu_lladdr, l1);
       ...
   }

TRANS(ll_w, ALL, gen_ll, MO_TESL, false)
TRANS(sc_w, ALL, gen_sc, MO_TESL, false)
TRANS(ll_d, 64, gen_ll, MO_TEUQ, false)
TRANS(sc_d, 64, gen_sc, MO_TEUQ, false)
TRANS(llacq_w, LLACQ_SCREL, gen_ll, MO_TESL, true)
TRANS(screl_w, LLACQ_SCREL, gen_sc, MO_TESL, true)
TRANS(llacq_d, LLACQ_SCREL_64, gen_ll, MO_TEUQ, true)
TRANS(screl_d, LLACQ_SCREL_64, gen_sc, MO_TEUQ, true)


You should decode into a common argument format, rather than doing it by hand.

@rr_i0          .... ........ ..... ..... rj:5  rd:5     &rr_i imm=0

llacq_w         0011 10000101 01111 00000 ..... .....    @rr_i0
screl_w         0011 10000101 01111 00001 ..... .....    @rr_i0
llacq_d         0011 10000101 01111 00010 ..... .....    @rr_i0
screl_d         0011 10000101 01111 00011 ..... .....    @rr_i0



r~

