Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF2573B81D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:50:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgF2-0003mK-2Q; Fri, 23 Jun 2023 08:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCgF0-0003lk-0O
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:50:18 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCgEy-0001oa-EA
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:50:17 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51be42391a3so1217276a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687524615; x=1690116615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dq1Cu43aqN3HHE4m7iXqF8Mucg6wVGiggmuzHPd3Opo=;
 b=TP9TnSmnFjR82TzfLRwGD53PZjDOEhdefykALqGfdmzDpDlV+qAEWK5tjIzeGei4i2
 22/X1iyOPOlpDHLAEJioWazYINxh9WW2xXjxKuR0BisOLxHmUpnseyaNUWNEXcxfNp70
 2KcJAeyy/H9NRs2ovy8fo0gvRnsvdoTwtLPMIlYss2cK7hFm4Zz2p1ZPoClkLBXzXI2e
 o37+J0Rg+EmRZJTAn7tjkqVspYva3KXwW4O7cZvYzh1mnNHVXo5pIXfIM8FNev7gxVAH
 MgTokL8ADh8dvyIosMV6Zj0x1VSXUdWDz61ckSRAOi3MjmjQmXh/ljfos8elgV0gnMlD
 QMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687524615; x=1690116615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dq1Cu43aqN3HHE4m7iXqF8Mucg6wVGiggmuzHPd3Opo=;
 b=UGUjrOCbXfQXPO+M+44vFOCj5b1SBHv9xWnThf91bEubigyVAx3DFQhS5ZuklfY3hS
 pSB/Ke5RapQfuqKvI6xt2FsEG4eey6WVEtPKVU44Jfhl1UDcEURGjd4PDrivScGUdXEB
 1VdpKzTzS1JaPAKrUq9H0Pom21p1Mxzi2Kh7ydd74Vl2ocNXjhYlBqTwQZBZrYAFZhxT
 TcOMfD8vEvgxbyf9SVhEq7QgGYwNA8nI79AyH3wJLPSZjuIM6lixIt1o14RR3gp9FGw/
 o3u5xEStPm+4EmJ3sxv2EFGzzoZl/63kYXuMnmUzA2mKbhcMTHg6swrdWSDVdcqEKfgz
 z10w==
X-Gm-Message-State: AC+VfDzg5tMPkVza3tUz8591FDOWUL9oUdZBVfzodZmTGCL7eLkuS4zR
 t9eQczlSrbyxsnX7f1zOFERxMPqc9bNTL/oKlW73ay3bnUeg2Do8
X-Google-Smtp-Source: ACHHUZ42nlTSjHIEEePqpUC4PuvUWrdCeJsxune8X7Y7fzGi29BqiDCgdtQHQMxC7ldSK6rL6wjQMFZHEpCv6HjHFsg=
X-Received: by 2002:a05:6402:2683:b0:51a:4c1e:c94a with SMTP id
 w3-20020a056402268300b0051a4c1ec94amr16232847edd.2.1687524614770; Fri, 23 Jun
 2023 05:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221216204845.19290-1-tsimpson@quicinc.com>
 <20221216204845.19290-20-tsimpson@quicinc.com>
In-Reply-To: <20221216204845.19290-20-tsimpson@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 13:50:03 +0100
Message-ID: <CAFEAcA8gTAYQD_a85OGPMs8KgvLRBZ0vok3QL=K3N29BnuoiHw@mail.gmail.com>
Subject: Re: [PULL 19/21] target/hexagon: import parser for idef-parser
To: qemu-devel@nongnu.org, bcain@quicinc.com
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 stefanha@redhat.com, Anton Johansson <anjo@rev.ng>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Montesel <babush@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 16 Dec 2022 at 20:51, Taylor Simpson <tsimpson@quicinc.com> wrote:
>
> From: Anton Johansson <anjo@rev.ng>
>
> Signed-off-by: Alessandro Di Federico <ale@rev.ng>
> Signed-off-by: Paolo Montesel <babush@rev.ng>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
> Message-Id: <20220923173831.227551-10-anjo@rev.ng>

Hi; Coverity points out (CID 976926) that here:

> --- /dev/null
> +++ b/target/hexagon/idef-parser/idef-parser.y

> +lvalue : FAIL
> +         {
> +             @1.last_column = @1.last_column;

...we have coded an "x = x" assignment that has no
effect. Was this supposed to be something else, or should it
just be deleted?

> +             yyassert(c, &@1, false, "Encountered a FAIL token as lvalue.\n");
> +         }
> +       | REG
> +         {
> +             $$ = $1;
> +         }
> +       | var
> +         {
> +             $$ = $1;
> +         }
> +       ;

thanks
-- PMM

