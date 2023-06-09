Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A7E729FA5
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 18:08:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7eea-00017n-5Z; Fri, 09 Jun 2023 12:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7eeX-00017Y-Js
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 12:07:53 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7eeS-00084P-Od
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 12:07:53 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51480d3e161so2957387a12.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686326866; x=1688918866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d2q+iD2oatzZJNMSb35yWPhbrydsyhb38QQ9VqspPFA=;
 b=qooEwqB8Ast64LQISUgZLjZJMudJwiSZhxlzaKq2Eb+zgfp+oqQWAJjs6k99mYd86W
 6WMxCADwPFbgA4/xyxpmd4vXvEL6IBzAFDbH9GA0EdRSJwHQ5NUAC34X5jl0G2/gC8Wi
 mwuSrc2QjIYPmxohB3+iOa5sgcgPNzPZx8eHvWqtUI0OQH2T/pvpOAxa/b5NmjeSi80W
 i1DLIIwqY/Gb0kRdT8M7iyU8syHYfbvfyBcwwBpCsY5KJ+BbmwR0NTBOywTnM8tKWFvZ
 L5fFzwD6YoIcxq+GK9gZq/kLEpjfxf6s8TkQToo+PND2HlObFTgyxzOUQjMX5TdH3CJV
 IOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686326866; x=1688918866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d2q+iD2oatzZJNMSb35yWPhbrydsyhb38QQ9VqspPFA=;
 b=R2wCNXxRVJED2Dea9u9bY8XpRfPKOJxs9TTZhCHhS6XqJ8Ur87P/kxa0nnNivdA1ED
 M61xsI+eleyApNlziJ1teppNBd+OiDxRkVEYA5DoGcB1kB5Yf/BlhrwMyBsVEsX06xDf
 EaeNbD3j4gssy8RXG1fvc+Dr1Rk84wdjpaY92UlbwC8Pp0dvDITMeURl/QapU81Glfhn
 C2qrnllj9rxFw6m6GQx2wlIdsEWpXPcotrVoGuEM/2RcHG8WX0j+K1EyUtjtNb1OMrSk
 Pr+2HYBFF9unmDPZLUHQuxU+jZxiePxDGWWGWa0wPnqWdccxqBPju2OO8AmuLGw3Jg/R
 6Q5Q==
X-Gm-Message-State: AC+VfDyVX0UrKvF0y5OkCl+uL84FSg2fjcmMDnS4BOzbmW+uALMbGAsB
 WaVeEkA56KL9Rk7qPqq1/QCR8TIGDAyqjkgaRkYPMedrLaJ4HF12
X-Google-Smtp-Source: ACHHUZ56cXi7MRNZIYS6lHZRuI+Doc48Tg/p0h8DMcyJ9PQQ/pbxGyrKDKoE69RkM720wWIzY5UFz9wXU1LBjXKu+QA=
X-Received: by 2002:a05:6402:31e6:b0:50b:c77e:b071 with SMTP id
 dy6-20020a05640231e600b0050bc77eb071mr1413754edb.18.1686326866423; Fri, 09
 Jun 2023 09:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8CsmTHXDf80fP_wAXG8_5J-AUeJqMRH5Nr23cF+ST8TA@mail.gmail.com>
 <8343e06a-12bc-b9b1-75ae-79d69fb2ebac@linaro.org>
In-Reply-To: <8343e06a-12bc-b9b1-75ae-79d69fb2ebac@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Jun 2023 17:07:35 +0100
Message-ID: <CAFEAcA98jdxyNQUZ+T3=9_RT8jCoobB_QLJzjS=BQ+9f1JsRKw@mail.gmail.com>
Subject: Re: arm: couple of finalize_memop related oddities
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 9 Jun 2023 at 17:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/9/23 03:47, Peter Maydell wrote:
> > I noticed a couple of finalize_memop related oddities while I
> > was rebasing my decodetree series:
> >
> > (1) in disas_ldst_reg_imm9(), we calculate a memop, but then
> > when we call gen_mte_check1_mmuidx() we don't pass the memop
> > as that function's memop argument, we just pass size. Everywhere
> > else that calls gen_mte_check* functions passes memop. Intentional?
>
> No, looks like a bug.
>
> > (2) disas_ldst_reg_roffset() and disas_ldst_reg_unsigned_imm()
> > use finalize_memop() for both vector and normal register
> > loads/stores. Should they be using finalize_memop_asimd()
> > for the vector versions?
> >
> > (3) disas_ldst_multiple_struct() and disas_ldst_single_struct()
> > use finalize_memop() even though they always load/store
> > vector registers. Should they be using finalize_memop_asimd() ?
>
> Yes.
>
> Everywhere that uses CreateAccDescASIMD in the pseudocode should use finalize_memop_asimd
> for clarity.  (If size is never 128-bit then it will be same as just finalize_memop, so
> some of those places were not actual bugs.  But definitely unclear.)

OK, thanks. The rebase of my decodetree patches for ld/st
turned out hairy enough that I think I'll resend a v2 of
that, so I'll add in some patches at the start that fix
these finalize_memop bits before the conversion.

-- PMM

