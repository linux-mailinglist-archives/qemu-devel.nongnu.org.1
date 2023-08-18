Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E70780DA0
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:12:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05m-0004xO-Kq; Fri, 18 Aug 2023 10:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwtL-0007BP-Un
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:39:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwtJ-00042u-KP
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:39:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fecfa50ccfso2795385e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 03:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692355180; x=1692959980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NKEJXcd8jE4m6adCSVr5KLiyJAHOe4h+URaRmpPyj6Q=;
 b=eg5ubr7XTbyjlFs1pK+MhffErSpr+OBj1MIuXKpBJJIE+gC+1LxZT+l+XDyKCHMfMx
 8ANXlRxZb7uER3jXpcIOUEYvmzTW7/5Eu1XMltC0f/BMw6P9qQwOhOp3sjicbkxqrmjW
 6ZU3/osnLntdj8p+k4YqeBERkCMnJ355HcOrGokHcXZ4G884rVg2vxFwKMGoMFHvAM+s
 4QaU9gg/yK1O4AdNrbbIm1ATo2TmqitK2scWq4xLZE6R07aJXagaiA/Z5OY7q5Ea5k6T
 oHoqjkCsNLPubrGFo28ACgcuMNyHae6/80Sk6PAD4BKbpGS9R1dGJl+dWI8D6daU9K0t
 EezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692355180; x=1692959980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NKEJXcd8jE4m6adCSVr5KLiyJAHOe4h+URaRmpPyj6Q=;
 b=mIoUwN35bnpEDAGa/um4eK0VTwp0hO/ivu6f2itrc6Cb20zhRhUR91f/wKZEIX8uan
 robosvskVZTkOnOXWsuec9yboMVwc/64uPh6ebXoW+h468WIjSdZ5boqsuqqneMqb4kk
 MzPHJ4H6oj6KXWpJxJyBHsoasBTwpOFEwYiBt61OwUsgDBo4JKqnKC+lQWAcg9RPYFbZ
 iDZLBn8R/t4hqFaNYuaM8UBd1kXPHMj7I4yMRmk8leknbIToeHnbtsBFh/IX09aZSqnM
 mJo2VLhDx23LHHeqHoW/cd7D2LuzkWcSttDxAZij4Dd1eP8YG6cFDU3/YifUtuL71kIc
 nGwA==
X-Gm-Message-State: AOJu0YxzVa1NSP0bjj07Ow+NbB56ewlFIkXPB6XPdugeuqhOnX+HNv8y
 ohBw6x1wemY9rPV3ZS94Z7YwEw==
X-Google-Smtp-Source: AGHT+IHft2K9WeSwf3C2yI9r0zFOb8oImPZ7R30yj8CQfz2r+xt52HwgWie80Wks2sclkbY3xur6ow==
X-Received: by 2002:a05:600c:4296:b0:3fe:d67d:5040 with SMTP id
 v22-20020a05600c429600b003fed67d5040mr723515wmc.5.1692355180004; 
 Fri, 18 Aug 2023 03:39:40 -0700 (PDT)
Received: from [192.168.24.175] ([92.88.170.62])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a7bcc8e000000b003fe1cac37d8sm5857820wma.11.2023.08.18.03.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 03:39:39 -0700 (PDT)
Message-ID: <c8b1453e-6549-7dd4-4bc3-ceac72331a77@linaro.org>
Date: Fri, 18 Aug 2023 12:39:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 11/18] target/loongarch: Add a check parameter to the
 TRANS macro
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230817093121.1053890-1-gaosong@loongson.cn>
 <20230817093121.1053890-12-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230817093121.1053890-12-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
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

On 17/8/23 11:31, Song Gao wrote:
> The default check parmeter is ALL.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/insn_trans/trans_arith.c.inc |   84 +-
>   .../loongarch/insn_trans/trans_atomic.c.inc   |   80 +-
>   target/loongarch/insn_trans/trans_bit.c.inc   |   56 +-
>   .../loongarch/insn_trans/trans_branch.c.inc   |   20 +-
>   target/loongarch/insn_trans/trans_extra.c.inc |   16 +-
>   .../loongarch/insn_trans/trans_farith.c.inc   |   72 +-
>   target/loongarch/insn_trans/trans_fcnv.c.inc  |   56 +-
>   .../loongarch/insn_trans/trans_fmemory.c.inc  |   32 +-
>   target/loongarch/insn_trans/trans_fmov.c.inc  |   16 +-
>   target/loongarch/insn_trans/trans_lsx.c.inc   | 1322 ++++++++---------
>   .../loongarch/insn_trans/trans_memory.c.inc   |   84 +-
>   .../insn_trans/trans_privileged.c.inc         |   16 +-
>   target/loongarch/insn_trans/trans_shift.c.inc |   30 +-
>   target/loongarch/translate.c                  |    3 +
>   target/loongarch/translate.h                  |    8 +-
>   15 files changed, 951 insertions(+), 944 deletions(-)

Please setup scripts/git.orderfile.

> diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
> index de7c1c5d1f..fd393ed76d 100644
> --- a/target/loongarch/translate.c
> +++ b/target/loongarch/translate.c
> @@ -127,6 +127,9 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
>       ctx->va32 = (ctx->base.tb->flags & HW_FLAGS_VA32) != 0;
>   
>       ctx->zero = tcg_constant_tl(0);
> +
> +    ctx->cpucfg1 = env->cpucfg[1];
> +    ctx->cpucfg2 = env->cpucfg[2];

Unrelated to this patch.

>   }

> @@ -35,6 +37,8 @@ typedef struct DisasContext {
>       TCGv zero;
>       bool la64; /* LoongArch64 mode */
>       bool va32; /* 32-bit virtual address */
> +    uint32_t cpucfg1;
> +    uint32_t cpucfg2;

Unrelated to this patch.

>   } DisasContext;

Removing unrelated cpucfgX:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


