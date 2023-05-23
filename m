Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B53DC70E68C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 22:34:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Yi6-0006an-SC; Tue, 23 May 2023 16:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Yi4-0006a0-34
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:34:20 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Yi1-0004v5-Uq
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:34:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ae408f4d1aso1081535ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684874056; x=1687466056;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7gEJI7oDuvv7tbPXfhhHdYUHgNd16ndnIz40ch9e1So=;
 b=Hoq+Kc500oYdDFTZ6Nltx0bbGlpbgy9hRB17VAq6dXIaF16ImiJKcyuaDDFmCkdxxo
 WXn0ib0PB4GiU0kt2PaMMKOOv4ZK77E02BOHz86E1UDYqOPktqHpnDGEwAZURtb9eS8z
 p+biDHPNPFkl/5Ulh2iP8AX/y1O0d3L2q814IunGsgK7DqTDaZXPAhuspLmcYBNZ1MWP
 iIaBf5LpBiNyvqUI6vSunBNDHJT3PgEPKdLOI5rKVPhYkGjoE/bFupYWw6Im0L2JSODz
 XtlxoJRNiFdM6uqrm1dmnDoAmBsOYElo7gNTga4A+XOgs8De3IUfL/PuajPGIt/QY6KI
 sNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684874056; x=1687466056;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7gEJI7oDuvv7tbPXfhhHdYUHgNd16ndnIz40ch9e1So=;
 b=Sgp/3UhIuRosewC9amTsqZyiXf4n6vDzXMNlii+7gaayupxsbAFjW1e1k6oVSWj44e
 55pwicEube1Bl+d9iQHh/zZTAM1T0V7JUbjTezSoW3doLuXc+RRiusoHINuQvs30SYkM
 DyH3fTkSkflXVzbQFTwNgCteuBr9xabh+pP6+RqX9o5v+ogGdlo+ZTxor1ZJq+lg1NY7
 Y3dvLQBKF5I/bV4Dk/zFFqkFEFOq9sGIRCBGFf0b29XgUFrYPvIvp6aGF8EYRRrO/q6x
 bfbMXggDonEGCXvTYF1lAVedVL5vMYoegfYgn87lAunmlNqMOnMlrg81m3U8u7BoM52b
 xl6g==
X-Gm-Message-State: AC+VfDwGhunQbvaUilXVyWeq+m/Qhfauck/nCVbZafSy59LY1QPzw6zW
 /SC8lwSwQT0cqPHARU51N3+SjIyI7dNGwvkZs6k=
X-Google-Smtp-Source: ACHHUZ5zHv4+zIa+lxesQsAQQrrJ9UT6zJATPTDi/6U3WVOIoBPdbvhYGZnEQX9Fmb3AqIay7WkdAA==
X-Received: by 2002:a17:902:c402:b0:1ac:b259:87ea with SMTP id
 k2-20020a170902c40200b001acb25987eamr22116023plk.0.1684874056191; 
 Tue, 23 May 2023 13:34:16 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a170902d88800b001ab28f620d0sm7164495plz.290.2023.05.23.13.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 13:34:15 -0700 (PDT)
Message-ID: <22b1cd80-27ce-9821-c434-ebc31bf6760a@linaro.org>
Date: Tue, 23 May 2023 13:34:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/7] target/riscv: Use true diff for gen_pc_plus_diff
Content-Language: en-US
To: Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
References: <20230523135939.299246-1-liweiwei@iscas.ac.cn>
 <20230523135939.299246-6-liweiwei@iscas.ac.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523135939.299246-6-liweiwei@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/23/23 06:59, Weiwei Li wrote:
> Reduce reliance on absolute values by using true pc difference for
> gen_pc_plus_diff() to prepare for PC-relative translation.
> 
> Signed-off-by: Weiwei Li<liweiwei@iscas.ac.cn>
> Signed-off-by: Junqiang Wang<wangjunqiang@iscas.ac.cn>
> ---
>   target/riscv/insn_trans/trans_rvi.c.inc   |  6 ++----
>   target/riscv/insn_trans/trans_rvzce.c.inc |  2 +-
>   target/riscv/translate.c                  | 13 ++++++-------
>   3 files changed, 9 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

