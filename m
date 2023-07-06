Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB8E749ABE
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:35:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHNGh-000495-TX; Thu, 06 Jul 2023 07:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHNGf-00048q-QD
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:35:25 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHNGb-0004pS-Mq
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:35:24 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51dff848168so886445a12.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 04:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688643317; x=1691235317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=goLMMiocXftD+TzHWg/04C7yxuFBpGLnp+Zaq88+HvE=;
 b=bIL8j4+uaiyvIQk8cefG4gn3jyqUD5IjNUM6R2FAcYtsy923nZatCoW0EhZfFkEux6
 SOTWCjWE1xb3tgKDQlR4kTyxiwGigx3YisjC1tpBWxdtKRc9UTzaQjhZNB32EH1mYjyR
 oODZqgGoKzYSF7pnG3DbsXRABAK6CBRES0Vku97bW4iRuEUNLMZdy7OcoM5PFM7g/TCh
 kXK/yntXhU6XlV+XcCDH4Xw9ML6mHeALS5mPLtVYtnCAssqobeAQp3tu0miXH8nesgQn
 4QGmusMH/InCUoiA/uSpmfbQbLfX3a6cXgvgSdC7EOyYZiMm6RBXTL+HyvG4HLnDlLYv
 Mgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688643317; x=1691235317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=goLMMiocXftD+TzHWg/04C7yxuFBpGLnp+Zaq88+HvE=;
 b=HiL5Qha5BfduyeBW03AQ0v0MalYW+1ASvGoLYbNajijxTpOY8Ln7LI4hikiOZCRh1+
 aPgKV2SUuSLJdZeUfaykIuIFi1UfhJVDPEOM3ZeQbHqhfA7CiYCcFfowCwuluyFX7uRX
 mzRvXc+BsOcRKWO7Ki0qnCntD2kNkm07yKDQvcLEI+COHsQSgEstmkarLSXG8j38lN7t
 mW0+wprzmlBQ7u3psYd7/GlSak2tA1h/pLaNkjYSAy3rAt7HgpcAtNpGUu/ucGLOq2Po
 JoNCGPcR3XBjuKbJxCdpCDuYyWDdL2+Ac4+sb10VEUhhWfwaqoP31Q9pf3YnLD2365mt
 fesA==
X-Gm-Message-State: ABy/qLa/DyiWXXmzSe7RFDqOz9l6+NqNEIluBztPp3MnwpsCKoOvsxW+
 Hwml/002Oy2XW007a1xB04+bQY2BMji16VsenO+ebA==
X-Google-Smtp-Source: APBJJlF71dAT28cUptEiAxL/XGYvkvOWO8MshGdQaco7os8apHqRvzX2WNOYXT3fHfvtxCiCmHkNaaW3wa9UKQazgEc=
X-Received: by 2002:aa7:d699:0:b0:51d:8a53:d13 with SMTP id
 d25-20020aa7d699000000b0051d8a530d13mr1130846edr.42.1688643317449; Thu, 06
 Jul 2023 04:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
 <29a83e80-32b5-cbb2-8dbd-13192e485e1e@linaro.org>
 <d73e2121-ee38-3245-8a3b-804931ea80a2@linaro.org>
In-Reply-To: <d73e2121-ee38-3245-8a3b-804931ea80a2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jul 2023 12:35:06 +0100
Message-ID: <CAFEAcA_dKacrOG+rTO2jfo=jkTg4e8CjdumsLa+PjPHRJA_+bg@mail.gmail.com>
Subject: Re: [PULL 00/11] target-arm queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, 5 Jul 2023 at 06:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/5/23 06:57, Richard Henderson wrote:
> > https://gitlab.com/qemu-project/qemu/-/jobs/4592433432#L3723
> >
> >> /tmp/ccASXpLo.s: Assembler messages:
> >> /tmp/ccASXpLo.s:782: Error: selected processor does not support system register name
> >> 'id_aa64zfr0_el1'
> >> /tmp/ccASXpLo.s:829: Error: selected processor does not support system register name
> >> 'id_aa64smfr0_el1'
> >> make[1]: *** [Makefile:119: sysregs] Error 1
> >
> > I guess it's the change to Makefile.target, as I don't see any other likely candidates.
>
> Ho hum, that's *my* patch 5, "Fix SME full tile indexing".
> I'll have a closer look tomorrow.  Sorry about that.

I think we can fix this by using the S3_.... syntax
instead, and we can drop the #ifdef HAS_ARMV9_SME entirely:
these registers are in the ID register space so they will
read-as-zero and pass the test regardless of guest CPU type.
However, it doesn't look like I can run this CI job under
my personal gitlab account, so I'll have to do a blind
attempt at a fix and resubmit the pullreq for you to see...

thanks
-- PMM

