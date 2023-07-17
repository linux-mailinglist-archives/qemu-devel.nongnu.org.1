Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E176D7566EA
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:57:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLPe4-0002Uz-Ub; Mon, 17 Jul 2023 10:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLPdj-0002PU-JU
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:55:55 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLPdh-0003w9-Hv
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:55:55 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3a3e1152c23so3345694b6e.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689605751; x=1692197751;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ymxi6ioO0vwSvwy0U6FXTK8PakdKTr95dhbgKuILM20=;
 b=F7azG1Oo4nyPG747vRtmozAaz8r/WdCagkhjfWx82NWt7K/ij5oxzOeUQ36G2uMK0g
 mQZuhG7HrWZkKBqP51Z25Xc5mYhMSKS3uNnynI1vRWuKrf9wVVGJ14VUj/jKWkTMDrb+
 SlAxnSqd076pxSHmSEJzS+3Nz1SURoIceU48kHvHACeUPUTZQf16Z5KK+dyBTV4aMppU
 Nfl1RZrGe3BJJ526q8nSeesiVa9TnlFTEmlMDh5bAicHmF9FBS4o4mQYnj9VHRdJ83Ml
 5ZGR93w4oThOsqkmNZrRGB+KtquBzprF1BmWh9MUxbsI+cTY156RhltNXWzmTxfZzG7x
 DC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689605751; x=1692197751;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ymxi6ioO0vwSvwy0U6FXTK8PakdKTr95dhbgKuILM20=;
 b=L6E0mMMyZeTxLmPxMiVWhHolIRL9RbOEdxJXKXKuDMrX6ymOUhVgbIoUfl3vYSfTDU
 bOgaVfu9Q5xEXM2jt/LsdIL5xQ5hxm0YGGqvJ7ECpyX5slO11P/5CrbpPDTNeVqDpJxA
 oXm6VYRPvgClaG4VPqkNGip6m01V+OYqR+ugET0I9qd/rcGamJYhXgi2UeyGwXE4nrhc
 6SCrX1PgKtMq0aEsOylcRP38cUT29DTKkDnbX7kxPx6vXKZOJTcClWo/7QfDRYFRdqpI
 W9Iz+XzELZP3UC2Pl9/1YV41LDvNAtSd3RtF1YhAljdAfmldFPZcedcUuF/eRC3QLdtI
 w9Jw==
X-Gm-Message-State: ABy/qLY1u8h1oMNRl/Kot52vezJJK1uyePiSlw2i6wjVU2Fdw8VRhWy5
 h63Hd2W/jTWoiJi1KHjhNY9bfg==
X-Google-Smtp-Source: APBJJlHjF9HzQGILcBA7YkPgamVlOZCjI1k8HOHzASBVsu/EEmRnNYpCdQqN8eVpq71Dhf0O+VrMGg==
X-Received: by 2002:a54:4f18:0:b0:3a4:f9b:b42e with SMTP id
 e24-20020a544f18000000b003a40f9bb42emr13547298oiy.26.1689605750854; 
 Mon, 17 Jul 2023 07:55:50 -0700 (PDT)
Received: from [192.168.224.227] ([172.58.109.253])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a0568080f0b00b003a1eae6ff73sm6863384oiw.36.2023.07.17.07.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 07:55:50 -0700 (PDT)
Message-ID: <2b2448e0-7e79-c23c-7021-31caa2b4d610@linaro.org>
Date: Mon, 17 Jul 2023 15:55:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] tcg/ppc: Fix race in goto_tb implementation
Content-Language: en-US
To: Jordan Niethe <jniethe5@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, alex.bennee@linaro.org, dbarboza@ventanamicro.com,
 npiggin@gmail.com, anushree.mathur@linux.vnet.ibm.com, mjt@tls.msk.ru,
 clg@kaod.org, bgray@linux.ibm.com
References: <20230717093001.13167-1-jniethe5@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230717093001.13167-1-jniethe5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 7/17/23 10:30, Jordan Niethe wrote:
> Commit 20b6643324 ("tcg/ppc: Reorg goto_tb implementation") modified
> goto_tb to ensure only a single instruction was patched to prevent
> incorrect behavior if a thread was in the middle of multiple
> instructions when they were replaced. However this introduced a race
> between loading the jmp target into TCG_REG_TB and patching and
> executing the direct branch.
> 
> The relevant part of the goto_tb implementation:
> 
>      ld TCG_REG_TB, TARGET_ADDR_LOCATION(TCG_REG_TB)
>    patch_location:
>      mtctr TCG_REG_TB
>      bctr
> 
> tb_target_set_jmp_target() will replace 'patch_location' with a direct
> branch if the target is in range. The direct branch now relies on
> TCG_REG_TB being set up correctly by the ld. Prior to this commit
> multiple instructions were patched in for the direct branch case; these
> instructions would initialize TCG_REG_TB to the same value as the branch
> target.
> 
> Imagine the following sequence:
> 
> 1) Thread A is executing the goto_tb sequence and loads the jmp
>     target into TCG_REG_TB.
> 
> 2) Thread B updates the jmp target address and calls
>     tb_target_set_jmp_target(). This patches a new direct branch into the
>     goto_tb sequence.
> 
> 3) Thread A executes the newly patched direct branch. The value in
>     TCG_REG_TB still contains the old jmp target.
> 
> TCG_REG_TB MUST contain the translation block's tc.ptr. Execution will
> eventually crash after performing memory accesses generated from a
> faulty value in TCG_REG_TB.
> 
> This presents as segfaults or illegal instruction exceptions.
> 
> Do not revert commit 20b6643324 as it did fix a different race
> condition. Instead remove the direct branch optimization and always use
> indirect branches.
> 
> The direct branch optimization can be re-added later with a race free
> sequence.
> 
> Fixes: 20b6643324 ("tcg/ppc: Reorg goto_tb implementation")
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1726
> Reported-by: Anushree Mathur<anushree.mathur@linux.vnet.ibm.com>
> Tested-by: Anushree Mathur<anushree.mathur@linux.vnet.ibm.com>
> Tested-by: Michael Tokarev<mjt@tls.msk.ru>
> Reviewed-by: Richard Henderson<richard.henderson@linaro.org>
> Co-developed-by: Benjamin Gray<bgray@linux.ibm.com>
> Signed-off-by: Jordan Niethe<jniethe5@gmail.com>
> Signed-off-by: Benjamin Gray<bgray@linux.ibm.com>
> 
> ---
> v2: - Use braces
>      - Collect tags
> ---
>   tcg/ppc/tcg-target.c.inc | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Applied to tcg-next.  We can re-add direct branches next cycle.


r~

