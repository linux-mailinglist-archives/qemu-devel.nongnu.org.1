Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05537780F3E
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:33:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1T4-00018T-R0; Fri, 18 Aug 2023 11:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1T2-00018L-LT
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:32:52 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1T0-0005E4-8v
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:32:52 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68872cadc7cso907359b3a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692372768; x=1692977568;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N82SKD0KGIZ588euZF12bqNcZmL1PjPnOz+FHFdBHM8=;
 b=LlfjEi4ovjsa3CRBrZJdhtqTNwQQ6CdBZMtHfg2qIpxixIsOeYiLTxQRF3Tp3w/msW
 fyeSlr/Qx/2ZMVfpflN/1bIQoYcHEmnpcmdHtkUvLJWl92qlwX8fUK8V7g5VF+E7RGMr
 JB2L6SL3T4ZVPQP6ZGUqoGjeiDT6g3Oe568ni3LENlJOji/Yeoaik/TcU80Rq6aHG+e2
 +pABFc+IX8MCmCB7n28zy6XtfhzdcvKdPldAYuHRC/A0RxmfwDL7N+RkAStHJFm+gvac
 WSBxcIlfx4yAKTCD4Bqp1TgOdS/rkNUnnB4ZFQlHZZp4guwTQgmsa2GMc9QTbvVcHBME
 l3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692372768; x=1692977568;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N82SKD0KGIZ588euZF12bqNcZmL1PjPnOz+FHFdBHM8=;
 b=Dby4HUL3dHMyeY2BumAOISqaKh2d+9iMxh7lu56ElZ9l0bSKAiv1jTbPW61jo6iQp8
 7rezoLW4vIdnHvN+ijq4Fgq2Cnsa7qFLIszurSdOPTLNCQn1+y0lbo88r634m6oUhIaU
 kjeML/3wmtu7Xr1S8NRBGLwFg/PX+UMFE2bZCECnhr4x6xcirYjXFuaTjsrYnfWjeSJz
 Lc4sH+21iCGDfnKsLJq4rQlJeGFAMV3fyJxTYvRQW9NOOPaGtwfj2ADHYgNpFK/8eayv
 17H8jglAxY5e4VStzlOni/3akSvWgn846MMqMbnoD/7SlIryfmpWvVFRkLKTA31fiwAe
 s36A==
X-Gm-Message-State: AOJu0YxmXqw8JMJo7yKeBuaIyAjoiEVj3AqAhRUQC97Uh7flPccicDm4
 EQ6GyaSChoL9sWnFSRhAifr+Ug==
X-Google-Smtp-Source: AGHT+IEWLeLT5Aan7vtmKRpsyTj5ArMzjcb28P3VcsyI9n/iRGxCIHyVpOWi4UBotOwLyonmGQ4b4w==
X-Received: by 2002:a05:6a00:4c86:b0:688:742b:5c56 with SMTP id
 eb6-20020a056a004c8600b00688742b5c56mr3317697pfb.23.1692372767745; 
 Fri, 18 Aug 2023 08:32:47 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:cf24:6daf:2b9e:7972?
 ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a637b52000000b0055bf13811f5sm1676596pgn.15.2023.08.18.08.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 08:32:47 -0700 (PDT)
Message-ID: <615a41c6-e3a0-7629-4a24-cb1cdaad39ed@linaro.org>
Date: Fri, 18 Aug 2023 08:32:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 12/18] target/loongarch: Add avail_64 to check
 la64-only instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: c@jia.je, philmd@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230817093121.1053890-1-gaosong@loongson.cn>
 <20230817093121.1053890-13-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230817093121.1053890-13-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.454,
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

On 8/17/23 02:31, Song Gao wrote:
> The la32 instructions listed in Table 2 at
> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#overview-of-basic-integer-instructions
> 
> Co-authored-by: Jiajie Chen<c@jia.je>
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insn_trans/trans_arith.c.inc | 42 ++++++----
>   .../loongarch/insn_trans/trans_atomic.c.inc   | 76 +++++++++----------
>   target/loongarch/insn_trans/trans_bit.c.inc   | 28 +++----
>   .../loongarch/insn_trans/trans_branch.c.inc   |  4 +-
>   target/loongarch/insn_trans/trans_extra.c.inc | 24 ++++--
>   target/loongarch/insn_trans/trans_fmov.c.inc  |  4 +-
>   .../loongarch/insn_trans/trans_memory.c.inc   | 68 ++++++++---------
>   target/loongarch/insn_trans/trans_shift.c.inc | 24 +++---
>   target/loongarch/translate.h                  |  2 +
>   9 files changed, 149 insertions(+), 123 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

