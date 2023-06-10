Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA9C72AC8A
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 17:19:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q80Mx-0007RS-Us; Sat, 10 Jun 2023 11:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q80Mv-0007R3-Lp
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 11:19:09 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q80Mu-0006bY-8F
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 11:19:09 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-256531ad335so1599034a91.0
 for <qemu-devel@nongnu.org>; Sat, 10 Jun 2023 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686410347; x=1689002347;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q9t8eqtLw5Ywg8Ex/bbvDfnCmIyt6Sz7MzFlAFdgR8I=;
 b=PM/uIhzpDCXB+4ucwlEZAxvuC+8KxR/7XVc0jwxEGctzvW9fKZpDsne7cVO0GogiLp
 X4dOPdAOYqj2cfXXfL4ugN0U1+XJLe3sfLMKhNotNHA8iUdJq1qlNZQpir7Zs/zeXIk9
 WxX4o8RJdA1SVDxXHtLhi4fJj7Z+pLAJnHoMDjjU5ZoHySn69cGYGvChhx+mgqsWUdWl
 rUYk+EdLPGurgPFIJTS+3jN7WsZlp4DKPPHtho7V2S428MlcZ2kjEBFrUR0DJHZvjRzE
 YQCUHrBgmZrSIYa5DgdjPQJErXwo4A7JAeRSQozAq2RCTcrtupXp+131fPJVfeZnABV6
 RClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686410347; x=1689002347;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q9t8eqtLw5Ywg8Ex/bbvDfnCmIyt6Sz7MzFlAFdgR8I=;
 b=Halo4TtLshicIADl+Try8bxoZQZ062JPP6e2MHBowgrSRveWP+/THGVniVn3l36rdZ
 gaBcnYTAwjBplBN+MT5uTesO4SgI39Hyr45NTZTolHmv10lkdjTTmYRwEm3jta5aXrhH
 CaxQRIDCeWhwKqn8I3FAewlzn1mw59RUDG1kbX2LykC6O9IVt1ofzRkRlLghkJczPRcA
 ahCXoXeJnE4ZlewDA9x52mZcUp2XKP/rvfPTYpRq/r/0Vxxunf/gIdHLxJlFsR5gVArT
 1zmNMjHrDbDP71T4b8BTaTpy9vRA4xgWytpD7MSwB0bl9OOHjgQLuohujyU9kakmt32s
 aI6A==
X-Gm-Message-State: AC+VfDzK6263ed7ZUaQ4FjxoFpgcwko0Qu0IApsTocEO1JWJ4keAWDUF
 /vWNSdA0Yx0PdvFxTqvJg025Zder+ZZIQoREXLQ=
X-Google-Smtp-Source: ACHHUZ6yb5zkBa5UlKiedRHQXBTR3bJKjJQXPo4RJYSXW+W09dT0lD98gLhj7fl1Tk8SunNsGM5dug==
X-Received: by 2002:a17:90b:ed8:b0:250:2311:1535 with SMTP id
 gz24-20020a17090b0ed800b0025023111535mr4238875pjb.24.1686410346968; 
 Sat, 10 Jun 2023 08:19:06 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:2db6:3c02:bd87:f559?
 ([2602:ae:1598:4c01:2db6:3c02:bd87:f559])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b00199193e5ea1sm5141708plh.61.2023.06.10.08.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jun 2023 08:19:06 -0700 (PDT)
Message-ID: <685aa7f0-ce5a-06bd-e011-54f1b6aec784@linaro.org>
Date: Sat, 10 Jun 2023 08:19:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/6] target/tricore: Add crc32.b insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230610105547.159148-1-kbastian@mail.uni-paderborn.de>
 <20230610105547.159148-6-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230610105547.159148-6-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/10/23 03:55, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/helper.h          | 1 +
>   target/tricore/op_helper.c       | 8 ++++++++
>   target/tricore/translate.c       | 7 +++++++
>   target/tricore/tricore-opcodes.h | 1 +
>   4 files changed, 17 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r

