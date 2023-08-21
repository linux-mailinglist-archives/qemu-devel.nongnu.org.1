Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 660F4782D43
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 17:28:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY6oJ-00087p-NL; Mon, 21 Aug 2023 11:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY6oF-00087L-0c
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 11:27:15 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY6oB-0002JK-49
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 11:27:14 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51e2a6a3768so4500854a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692631629; x=1693236429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTnMedEBTDAlKVPNoyNlz8hunvni+j6uuFc/vVCbUUE=;
 b=HB367TOV7BnE++yA13TxI0CYI64BRboz2tjkVHwt8f2CSknEPOdAw/t2X9iDZ0BIzs
 z+BzgDMFcG1rRE3/bVVr9L5ESnXiOkqedbiulN7qIQUQIq/wy5CbWW0VZ/7nV5Dqd16b
 G1OEy7umCo83g3+EARD5u78ZF5OlFxh0WSpLrjP9H48OB9WZ9LVhOeke7c81qbD0MwvJ
 idq/7MLF3VK3pnI7hBY+dJ4AtcITChWm1C69xCp7EleDD8A2b2SvougBw7Dd4h8yC4z0
 7KL/E7vM3GVYtjBmBPQgCt1ZyLnU5dsX6grdIwMUCdDr7H81kZBqBjBp5aaB0fg47YCT
 TuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692631629; x=1693236429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WTnMedEBTDAlKVPNoyNlz8hunvni+j6uuFc/vVCbUUE=;
 b=I9eDQ2VgPTUGS3bpNZCSMFaHFOLX4J6qOeLd4g0e+7ffrpF7nKgU0njDv+gTflsfGF
 oSP38m7XWemAJNCkqH/L3bAvr74eQ1PRcgfYvqy2jd5MLmTNyBEq/i6LjCM4BVZv6+RJ
 G3uD1Yv4ePxC0Z48cUC9NskUGoH5eL3bOO6FZKGLgP7q8xg7wu/9nO4jHyJa0RDIyexJ
 yb2ZcmcLQEddZC99TOfcPANTtMxuffQg9RCEQYL4CDkEZCeLzfYRU0KAgT2h7XEWlYFg
 HSyU/3DwtDa+1sVNNjmg1ByDrvvudAxp6d+1KDtY0x/SlrvK5QOKhzlEtT5gBgRtLhVs
 LfKQ==
X-Gm-Message-State: AOJu0YxRfoWq1vxP65TIldncbh0UQ57YK0fHIfpdvyYVnc6z3gfN8ArL
 TSRjeXsSuVhefyXY5VEWBYHPXCCFfvhEzFs0Fn9uxw==
X-Google-Smtp-Source: AGHT+IFLJ+/p96/atGdjRHKacRKbUx7R9Ts+oul00lZ7lLxiyUDPdOT+43qZLU849v3cP+FponJ3DZcJtUGdOZiMpCA=
X-Received: by 2002:aa7:cb42:0:b0:522:27ea:582 with SMTP id
 w2-20020aa7cb42000000b0052227ea0582mr5222742edt.37.1692631629052; Mon, 21 Aug
 2023 08:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230222110104.3996971-1-alex.bennee@linaro.org>
In-Reply-To: <20230222110104.3996971-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Aug 2023 16:26:58 +0100
Message-ID: <CAFEAcA8YSsByEUkVK7gWM51eoLR4JZV3P_GDakc3NaLAw=QwSA@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: properly document FEAT_CRC32
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 22 Feb 2023 at 11:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This is a mandatory feature for Armv8.1 architectures but we don't
> state the feature clearly in our emulation list. While checking verify
> our cortex-a76 model matches up with the current TRM by breaking out
> the long form isar into a more modern readable FIELD_DP code.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/system/arm/emulation.rst |  1 +
>  target/arm/cpu64.c            | 29 ++++++++++++++++++++++++++---
>  target/arm/cpu_tcg.c          |  2 +-
>  3 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rs=
t
> index 2062d71261..2c4fde5eef 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -14,6 +14,7 @@ the following architecture extensions:
>  - FEAT_BBM at level 2 (Translation table break-before-make levels)
>  - FEAT_BF16 (AArch64 BFloat16 instructions)
>  - FEAT_BTI (Branch Target Identification)
> +- FEAT_CRC32 (CRC32 instruction)
>  - FEAT_CSV2 (Cache speculation variant 2)
>  - FEAT_CSV2_1p1 (Cache speculation variant 2, version 1.1)
>  - FEAT_CSV2_1p2 (Cache speculation variant 2, version 1.2)

Would you mind resubmitting a version of this patch that just
fixes this documentation error and doesn't also do the other
stuff that caused this patch to not get through code review?

thanks
-- PMM

