Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF8A7D4300
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:02:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv3w8-0000FJ-Ma; Mon, 23 Oct 2023 19:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv3w6-0000Es-Cy
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:02:14 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv3w4-0003p4-Pd
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:02:14 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-27d3ede72f6so3382984a91.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698102129; x=1698706929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y9PYANdOg5z7Qq+Ec1Bb8Oa/zNaKlSLWGQd3rN1X6/g=;
 b=zzHJc07hjMcT7Dztn7dXLNRNtsgGGgxhHsXIWxxQO9dSJpsnU7Z++6+ytelIHttXTd
 exMUSISQeaJSTzWXdD6ejjPGL2sr1uA5up8qjW0al89E+iSkQVPu+8k09DiyrPcarZPL
 w36JCg1MXnOcxdFwQH7LBXeYDGT0dMsChMW4m/6AQFXiLZHEeGWAWLMjeNq4y+WqLDIA
 zC3sj3bYmyJY59IKPwdRf3njNoXPNBj2fkzNP9AT6jt/KlHa944Ud0FAPnkBVS3thivh
 4gCiU6o9EVq6TDZkgdXM5LL+ee9Wf+PR2+9LgeZp1W49vfgTvNetjEIa5WzqbloUtEFD
 RdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698102129; x=1698706929;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y9PYANdOg5z7Qq+Ec1Bb8Oa/zNaKlSLWGQd3rN1X6/g=;
 b=Om58cZrFd/rereS+5hC2P9ODAFnaAC0H6Ih7O6NCWyjibfPVb7bZkxvS8YVfzaTAfR
 qaePrNfsQiCm9i68uGaxzFXgA0J8j7WONgCHyj1l3rEgEWb1GclqmKpM9U8J3bz5R1sX
 /mWTLh0jOHz8+qa3oe4xqGPRr2w8ME6g+1ZNC5DKBeAMJhYhKKRaUFltPDbGDAmCqpqt
 r2kf27J45D2Avg5H6CsPZf62LDg7zl3TrSEdiR6Kw+PGUi48EKoyLN0qn213hwS71nWk
 F1lwJoj8mbKR2VC0DHgR5DBDpXh45NXWrnXLrPDQzVwqHCvULgzoCjSRLSAYxl3jknA6
 AXXQ==
X-Gm-Message-State: AOJu0YwR2hBmaT1Ol4zHXZnZLt/1sLYBIh6T0xAbdydGDj1o56o+N1JI
 aHec0jv2cnabWOqnbmQHcJFWqg==
X-Google-Smtp-Source: AGHT+IG1Ifq1fydweoUX6n7rKmKlzz+O/i9xZQo8u70YdbnuHnmMgThvsexkBtdkeMNRJAsVBEdJVg==
X-Received: by 2002:a17:90a:194:b0:27d:5964:4ef0 with SMTP id
 20-20020a17090a019400b0027d59644ef0mr10954890pjc.10.1698102129224; 
 Mon, 23 Oct 2023 16:02:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ga8-20020a17090b038800b0027d0af2e9c3sm8106910pjb.40.2023.10.23.16.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 16:02:08 -0700 (PDT)
Message-ID: <599d17bf-65c5-4728-bcc3-aa8b058e8af5@linaro.org>
Date: Mon, 23 Oct 2023 16:02:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/loongarch: Add estimated reciprocal
 instructions
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20231023153029.269211-2-c@jia.je>
 <20231023153029.269211-6-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231023153029.269211-6-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 10/23/23 08:29, Jiajie Chen wrote:
> Add the following new instructions in LoongArch v1.1:
> 
> - frecipe.s
> - frecipe.d
> - frsqrte.s
> - frsqrte.d
> - vfrecipe.s
> - vfrecipe.d
> - vfrsqrte.s
> - vfrsqrte.d
> - xvfrecipe.s
> - xvfrecipe.d
> - xvfrsqrte.s
> - xvfrsqrte.d
> 
> They are guarded by CPUCFG2.FRECIPE. Altought the instructions allow
> implementation to improve performance by reducing precision, we use the
> existing softfloat implementation.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   target/loongarch/cpu.h                         |  1 +
>   target/loongarch/disas.c                       | 12 ++++++++++++
>   target/loongarch/insn_trans/trans_farith.c.inc |  4 ++++
>   target/loongarch/insn_trans/trans_vec.c.inc    |  8 ++++++++
>   target/loongarch/insns.decode                  | 12 ++++++++++++
>   target/loongarch/translate.h                   |  6 ++++++
>   6 files changed, 43 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

