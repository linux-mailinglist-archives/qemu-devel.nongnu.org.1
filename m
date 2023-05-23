Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0296170E09C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:34:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1U1b-00035r-49; Tue, 23 May 2023 11:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1U1Y-00035O-IS
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:34:08 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1U1W-0002nX-Kg
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:34:08 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d1a0d640cso4606586b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 08:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684856045; x=1687448045;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4O6hvzNlC2ottsJv+LnzbHWmgE2ikpfWnIjCi8CmnNY=;
 b=cOH7EDLGZSecWBWCU7P91nFIK/W+J0q+vVW85htez5pLXsNCnQO8Y+RVWSQrvyYi8X
 mBRxfwRBfy+HFthBa6qgrxeftYGg5NIU3lHeldh+viFK0Yb8ze5ESsFli1SLhzjRKZpH
 Y4UmW0DGBSVA6QhC8XNhEiHAs8/kUdghAUo7mYv3s/bp6P5FtTv5D1YMcsU/p+TN15MU
 1+Wb9FM/d+hvR7dVdK+ejeqxZRM2uB1jlzA6mU7VbZgPQAhqgPl04nqEsoaUCyD3pxex
 IrlF0KyM+IlURXOkVAddPDuXdUD+HNhAi7FqW0dpVcH4fVexC842U5T+fBxhuGV45Nlr
 6Qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684856045; x=1687448045;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4O6hvzNlC2ottsJv+LnzbHWmgE2ikpfWnIjCi8CmnNY=;
 b=FYNI5lMmi4o9Av14eqmSxj35rcx2AVvfnYJUqO0WAiR6qakgQIO39soaKbdCHGI1gX
 5RKJiJ58rZG4eABnhpgF0TRIJ+/RaWY2pXSSQMf9f8AF4PVcYlnkfzEsPQ62ECOL3dxk
 eFKZLCFChEuxEx9UO1qmN6i0XZyziWk8t3LJGkY2J13e3x5eptfIkLRfJtMzeMMF4EoY
 pTV7SLHBtSOsvnW0P00WrONXxcfoHBMsHP/dMw8Fyodc0FUBcKBlQWZodDwZ3ttLrdJ5
 tH3dXI9imKnfzxnfrYKhkmY2J8TSAxjQK4POcbVGo146aOLoegUmter6N3Z+TqgGujaS
 cKcw==
X-Gm-Message-State: AC+VfDxheBB++E1NH+nJtp1v2MzwJiYb3p9/tWyY5TdnZWCqaQjZCQza
 Iuq+haWVvFxA00yL0wIZdbGigw==
X-Google-Smtp-Source: ACHHUZ7sMJxYd2CtUJua5srsXEScJv9dvdYvpKHLToHl834l3mt7+1THxchO4C+UyHBWIMnK3gimgQ==
X-Received: by 2002:a05:6a20:a128:b0:10c:5d65:83ec with SMTP id
 q40-20020a056a20a12800b0010c5d6583ecmr3417925pzk.5.1684856045184; 
 Tue, 23 May 2023 08:34:05 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 a26-20020a62bd1a000000b0064f45b20703sm1199700pff.64.2023.05.23.08.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 08:34:04 -0700 (PDT)
Message-ID: <cb97eb41-1417-86a4-e26a-0e0da3e22c6f@linaro.org>
Date: Tue, 23 May 2023 08:34:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] softfloat: use QEMU_FLATTEN to avoid mistaken isra
 inlining
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Aurelien Jarno
 <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>
References: <20230523131107.3680641-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523131107.3680641-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 06:11, Alex Bennée wrote:
> Balton discovered that asserts for the extract/deposit calls had a
> significant impact on a lame benchmark on qemu-ppc. Replicating with:
> 
>    ./qemu-ppc64 ~/lsrc/tests/lame.git-svn/builds/ppc64/frontend/lame \
>      -h pts-trondheim-3.wav pts-trondheim-3.mp3
> 
> showed up the pack/unpack routines not eliding the assert checks as it
> should have done causing them to prominently figure in the profile:
> 
>    11.44%  qemu-ppc64  qemu-ppc64               [.] unpack_raw64.isra.0
>    11.03%  qemu-ppc64  qemu-ppc64               [.] parts64_uncanon_normal
>     8.26%  qemu-ppc64  qemu-ppc64               [.] helper_compute_fprf_float64
>     6.75%  qemu-ppc64  qemu-ppc64               [.] do_float_check_status
>     5.34%  qemu-ppc64  qemu-ppc64               [.] parts64_muladd
>     4.75%  qemu-ppc64  qemu-ppc64               [.] pack_raw64.isra.0
>     4.38%  qemu-ppc64  qemu-ppc64               [.] parts64_canonicalize
>     3.62%  qemu-ppc64  qemu-ppc64               [.] float64r32_round_pack_canonical
> 
> After this patch the same test runs 31 seconds faster with a profile
> where the generated code dominates more:
> 
> +   14.12%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000619420
> +   13.30%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000616850
> +   12.58%    12.19%  qemu-ppc64  qemu-ppc64               [.] parts64_uncanon_normal
> +   10.62%     0.00%  qemu-ppc64  [unknown]                [.] 0x000000400061bf70
> +    9.91%     9.73%  qemu-ppc64  qemu-ppc64               [.] helper_compute_fprf_float64
> +    7.84%     7.82%  qemu-ppc64  qemu-ppc64               [.] do_float_check_status
> +    6.47%     5.78%  qemu-ppc64  qemu-ppc64               [.] parts64_canonicalize.constprop.0
> +    6.46%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000620130
> +    6.42%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000619400
> +    6.17%     6.04%  qemu-ppc64  qemu-ppc64               [.] parts64_muladd
> +    5.85%     0.00%  qemu-ppc64  [unknown]                [.] 0x00000040006167e0
> +    5.74%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000b693fcffffd3
> +    5.45%     4.78%  qemu-ppc64  qemu-ppc64               [.] float64r32_round_pack_canonical
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Message-Id:<ec9cfe5a-d5f2-466d-34dc-c35817e7e010@linaro.org>
> [AJB: Patchified rth's suggestion]
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Cc: BALATON Zoltan<balaton@eik.bme.hu>
> ---
>   fpu/softfloat.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

