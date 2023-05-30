Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D787166D6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 17:19:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q417d-0005sF-CB; Tue, 30 May 2023 11:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q417Q-0004sY-5R
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:18:40 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q417N-0007O8-6k
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:18:39 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-514924b4f8cso5789591a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685459915; x=1688051915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tVORMHIcX6LuKdvbuhlEaqupobkYB9pBO6CCzD1eKNs=;
 b=HJM7YHov1KXF8blUZzHKAmJQ5ypZdpuCsqyOlRvX/Hoy7FV0CiupsP/b5wg2Mii9uD
 3keiKsMaME1qxDf8ka3WOxhFYdeKqewLgMoZfEcsfC33CxR4WSTDIxGOmn+ajk9nCq0S
 VwhT8X1mwnpsz+BC2tktQpcUAVeSKAW5h+VqpiwJsJiLZ5EDi0xzlmHKYzrZbgG+Yx0R
 QOVdDP8yYGfnA9M7/UtmcQHqfU+/YiU25FOxmlH5+bTf6BZ9Vg/hGPO04z6xx/DgdSCu
 8ttiklK7CBYIRiUFj80k8yFo21fSXUrI6tVs3ujkMCXjpaikoqogvZjSF5iSxd3dU3AV
 6NlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685459915; x=1688051915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tVORMHIcX6LuKdvbuhlEaqupobkYB9pBO6CCzD1eKNs=;
 b=jmLrOqQ3kUJBBDDrCxVvSaiJ5+96+MQfr+qgDJA2T2VAXQWa7SAb7xmXmwGWylPauo
 Fij2SeDOfUXAP2s69FSSrIGoJ49Lt7B+ECI+I+Oq1jK4W+riAF+7f0iTcUHst/DaKXl4
 4Vfr2Xbfoi2adC9Unk3GWyjJ3fa3b5U6sijl5AC4YxwAK+yN+BGDMiav2VsrFmpQHpSL
 Lek0wGttD2895C5Wy+dNYtcMT9mOeVCI6NPXch8HVLc1VuLDEfrC/B5I0Uhw3XcQTPLk
 ZPJ4A2CtP5RvKMHsD3DeHUiP5kvDPGQZ1jQ1DbalSMbnXHq/fV7YymPJPotmOwDTHfhq
 Kfgg==
X-Gm-Message-State: AC+VfDw74nUnQJ9kXb5h5kLBvwHaAM4mmzCy2mcOiCd3vs0lni60gGRF
 XTtNEm6RUlZ8iGGhDQ7DbutBb4Vg7+SmdY+9L1rmzH+nl93S30kd
X-Google-Smtp-Source: ACHHUZ5Xo0G7gvVJObA7NnuDxj7idTwXfMmJpPFaQ6xrY8eRFZyPVYFk7DK3XsSs2wGnpBDN0ET84/CtFHVKMJa+mzQ=
X-Received: by 2002:aa7:d850:0:b0:514:9dd7:4bcc with SMTP id
 f16-20020aa7d850000000b005149dd74bccmr1811366eds.14.1685459915506; Tue, 30
 May 2023 08:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-3-richard.henderson@linaro.org>
 <CAFEAcA8E_wbiL=xxc=qzfbhBjTsGVxpMGYex_Ezsn_=47DJP3w@mail.gmail.com>
 <5192c74b-38fb-7f2e-7b27-58d210c1b087@linaro.org>
 <CAFEAcA8tPuFMz8BZ5P-SJS42q8E_TZ1_5DJL-0kOvzeT-Fymmw@mail.gmail.com>
 <a7ba5e1c-ca59-b114-229a-07930f6ba683@linaro.org>
 <CAFEAcA_BS4b1MR=7zwVXB+eTXcVc2QhvzcvsoQn9mZ-xeps41w@mail.gmail.com>
 <528627e2-f4d5-fd44-a57b-23b37ca79935@linaro.org>
In-Reply-To: <528627e2-f4d5-fd44-a57b-23b37ca79935@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 16:18:24 +0100
Message-ID: <CAFEAcA83A5Bj6SqcvXjEDtnCg2jdjAmM5zBhK8RDThoyyx31sw@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] accel/tcg: Fix check for page writeability in
 load_atomic16_or_exit
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 30 May 2023 at 16:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/30/23 07:48, Peter Maydell wrote:
> > On Tue, 30 May 2023 at 15:29, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 5/30/23 07:06, Peter Maydell wrote:
> >>>> This is about falling through to the cmpxchg below: if !PAGE_WRITE_ORG, then the page is
> >>>> really not writable, we will SIGSEGV, and handle_sigsegv_accerr_write will kill the process.
> >>>
> >>> Right, but if !PAGE_WRITE_ORG then that implies also !PAGE_WRITE,
> >>> so we do that even without this change ?
> >>
> >> But !PAGE_WRITE does not imply !PAGE_WRITE_ORG.
> >
> > Hmm. In what situation do we mark a page writeable when the
> > guest didn't ask for it to be writeable ?
>
> I don't know -- it seems backward, I know.
>
> I *think* it's a race condition, where PAGE_WRITE changes.
> That's what the test case is trying to provoke, anyway.

That sounds like the theory I had earlier, that we
don't have the mmap lock, so the other thread can
get in and turn the RO-only-because-of-the-JIT page
back to RW, so we don't want to do the non-atomic
access for the "RO-only-because-of-JIT" cases.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

