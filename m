Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E2778B676
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:31:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qag3o-0000bb-7N; Mon, 28 Aug 2023 13:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qag3k-0000al-3M
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:29:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qag3g-0000C1-Um
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:29:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso16303705ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693243787; x=1693848587;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6sbBm8XlbDIJHNqtoqen6sBXyOk1jnfmJ/ryRQUWWfg=;
 b=T1NnCB2lFcPiE0vp++gAPkc7N3z6e3RB3jlj2KNBv9Dy3MC9fkrRk9Pha/AaWiXUFJ
 80jR6miF/Wg6G5CkqAutgsKdJnzqyhqvBZ6dT1bZijKhq6hDhIzq9NYvWRUbYMnLgNa5
 GO2CiREnxq0bTKYmhpXHqMbu89tHVUWEQ1dY2OK2kwtVeYonmk70etvXh35ajwY96JnX
 fh615iST1mVIeABgsIoj4K9ovZkQuR5YMm7QMqi7gedY0LOUFQNjdRVgM6x2ils2ua1n
 4JgGWrecfFCn0BX4D7VbD90ptjklcynuL4WQm+pnXsNb6FfCPdI+cx6O8cmKwHUgGg1E
 yuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243787; x=1693848587;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6sbBm8XlbDIJHNqtoqen6sBXyOk1jnfmJ/ryRQUWWfg=;
 b=ATccvs5EJcP7pSqmHxlZJ3dUpc5ULzEWNfwRCvQ+uueBBoQnkfqi997PsECr8sS8+H
 jSqLInoD/ofQIvxWx02A70b49qty1Tmd+pgvdblOG9T2IevHNixok4TYqD87hiez+nVY
 YqC4i+fNzrtNwf17dOTPhwuVPwfto7qJzbGrC475/g0H4N/Q6hkfUKGXWfXuFocJxsOc
 /qlAIDZIUBmbYUqJT552n18zXZGnlO/yjAqA5v+GWXJx67WRkYAgRDqK7ONfWolmFgQS
 4OOmV8ybS503Z6ChGCpxHS8QDXOUNdnXrFP1zSDIKYPSgfhqq0+od72eQM+3XfujTSgz
 VKRA==
X-Gm-Message-State: AOJu0YwywpGK4kM/F8SvKmc59cINSv5sPq2rwPWgdp9PixvkqvRcXsg8
 BspcaQ+FMDZZE/rYRZKSlOYXuwcWj9knR76Nea0=
X-Google-Smtp-Source: AGHT+IH1GpkZDq6EfdD3cMSKfBiyMAdmXRR2mt7vg8pJi6RtzzMhNS9BtwjmU3OAK7NRxP8j70kbnQ==
X-Received: by 2002:a17:902:dacd:b0:1c0:c86a:5425 with SMTP id
 q13-20020a170902dacd00b001c0c86a5425mr10255166plx.19.1693243787393; 
 Mon, 28 Aug 2023 10:29:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a170902868400b001bf2dcfe352sm7631662plo.234.2023.08.28.10.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 10:29:46 -0700 (PDT)
Message-ID: <8d4941d2-77e3-f9de-302f-b3f9d14141dc@linaro.org>
Date: Mon, 28 Aug 2023 10:29:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/11] Lower TCG vector ops to LSX
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn
References: <20230828152009.352048-1-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828152009.352048-1-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 8/28/23 08:19, Jiajie Chen wrote:
> This patch series allows qemu to utilize LSX instructions on LoongArch
> machines to execute TCG vector ops.
> 
> Jiajie Chen (11):
>    tcg/loongarch64: Import LSX instructions
>    tcg/loongarch64: Lower basic tcg vec ops to LSX
>    tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt
>    tcg/loongarch64: Lower add/sub_vec to vadd/vsub
>    tcg/loongarch64: Lower vector bitwise operations
>    tcg/loongarch64: Lower neg_vec to vneg
>    tcg/loongarch64: Lower mul_vec to vmul
>    tcg/loongarch64: Lower vector min max ops
>    tcg/loongarch64: Lower vector saturated ops
>    tcg/loongarch64: Lower vector shift vector ops
>    tcg/loongarch64: Lower bitsel_vec to vbitsel
> 
>   tcg/loongarch64/tcg-insn-defs.c.inc  | 6251 +++++++++++++++++++++++++-
>   tcg/loongarch64/tcg-target-con-set.h |    5 +
>   tcg/loongarch64/tcg-target-con-str.h |    1 +
>   tcg/loongarch64/tcg-target.c.inc     |  414 +-
>   tcg/loongarch64/tcg-target.h         |   37 +-
>   tcg/loongarch64/tcg-target.opc.h     |   12 +
>   6 files changed, 6601 insertions(+), 119 deletions(-)
>   create mode 100644 tcg/loongarch64/tcg-target.opc.h

Looks very good at a first pass.

We should probably improve tcg_gen_not_vec to try NOR.  This would support loongarch64, 
and allow the special expansion in PPC and S390X to be removed.

It would be good to support TCG_TARGET_HAS_shi_vec using VSLLI/VSRLI/VSRAI.

It would be good to support TCG_TARGET_HAS_roti_vec and TCG_TARGET_HAS_rotv_vec.



r~

