Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E56C7780F2F
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:29:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1PE-0008V1-Db; Fri, 18 Aug 2023 11:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1P9-0008UJ-5S
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:28:51 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1P6-00044k-SA
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:28:50 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68876bbecb6so864169b3a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692372526; x=1692977326;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CAOYJmZTfb2CjXOKPOa72Fp9nwl9kPjtVNRVP0Mpo5c=;
 b=Ml/4OKuG14xyWqoMH5Wb4zP/I14WotwamHtm1VggLp8zBr+Ka2eCP2D3oJri+TGR5p
 ROab0OpEM5UnkkEM9hWlfl+Q9j+EfZJUGf9BrPpGjcSuiusL1EPwSSnxGZQcSWR/nyYB
 4TDOC0OEFK3JIRdHphPtRan4/2cG8JlP6aPhyuuLsklnxtKdL0hG/N7rgVEt1G67WHnb
 F0VVnRl/HW2i4kwlLVCluZxeAlHXcS/1W/s+0cv4JGNcTdkj+AcGE0kXVXQ5AeztWKAI
 yvyfHL+hq7J5OpxJyYNo2HdkaUWC1Ylnh71QxRkD03GYXhnJmnIahf9mctEtEdWOyqSs
 4XOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692372526; x=1692977326;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CAOYJmZTfb2CjXOKPOa72Fp9nwl9kPjtVNRVP0Mpo5c=;
 b=N8jbPUjMx62emHCkggr6qdhg+TtweqD26vYxe9UvDjl93pOEu3/J2SVTC44/RK8IQa
 NZFWAj9zK7nQIErkXoS4HiTral4nNa47u7WK6i+pIK27Rh4hjAeeobBkKz+3obB8w0wy
 ocqj65S+0VxUOzhrNrj/sy7JR8KB++0NxO84+Cvr0FnFDYk6a40kzHzvJ4RdX4F3ot3+
 7ELMFQAWp7M9xdDuLIdqxJEHlJu/3Esh0sGwFKsggAOtCjEgkBMieb6FlxpkX4npxWDH
 pFfUHmmYYPPpz9VGy4AJnJ2cgdc2FREhvX12ZBmf0SICCUuWDazfxn6zBXgjsGigdV63
 Bayw==
X-Gm-Message-State: AOJu0YyKHlOEwwkdwJY0r23Hp80ff6b/keSRs1gqU3Ok6ZY5sGyzFok0
 KjCo2mDqD9j1tNxbYuB8ZK6lOw==
X-Google-Smtp-Source: AGHT+IF+Mr7Y1O7HkrEmArX6EDe0bVukUr3qQ+Yb3O4F/vsbrPTC+TAKd7X6Gz344F0P4YurZFTUfA==
X-Received: by 2002:a05:6a00:17a6:b0:688:4371:2651 with SMTP id
 s38-20020a056a0017a600b0068843712651mr3604006pfg.29.1692372526435; 
 Fri, 18 Aug 2023 08:28:46 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:cf24:6daf:2b9e:7972?
 ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 a2-20020aa780c2000000b00688214cff65sm1688930pfn.44.2023.08.18.08.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 08:28:46 -0700 (PDT)
Message-ID: <5d7e7a70-3003-7058-a0b0-37966d37dbfa@linaro.org>
Date: Fri, 18 Aug 2023 08:28:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 11/18] target/loongarch: Add a check parameter to the
 TRANS macro
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: c@jia.je, philmd@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230817093121.1053890-1-gaosong@loongson.cn>
 <20230817093121.1053890-12-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230817093121.1053890-12-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
> The default check parmeter is ALL.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Song Gao<gaosong@loongson.cn>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

