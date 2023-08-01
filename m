Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3C576B8A9
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:35:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQrNb-0004Hu-EX; Tue, 01 Aug 2023 11:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQrNV-0004Bp-Qs
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:33:41 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQrNT-0007Fo-Vm
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:33:41 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so12180488a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 08:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690904017; x=1691508817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dE2jP2TIq/70urDRnV9P6HEsOoDngG6zXY/HrtxpF1s=;
 b=E97sHnpUS29KfKRZlWq/JchqfWqV7xLZkBDeYDCC7SyGOKfqLB35DaFUs/9ZcGQeQ8
 u/SmusWZ2AJxzSBzSuFsSZhNicgp7Iz2NCzeV31jHObLtSMxRYF3DPc+uFpkWVH/qQ5R
 BtoGoH2J8/pFZBvpBOwQvyfR+EOb/uZ8ENlGfp+XdEULak+Snra72/VxGtqT9+f0tGI+
 PLPHJ2pNr7DD6/dagTv8Yhl0rIV8IqhSin1bD+yBALkwGkndU1GXfIlXiAmEg4mFIiAz
 8yMBA3zIeEorv2J2tPCCXH0AhA+5th+9+e7dlZPRdRlCi1EOSVM0c6nbPEE5xt4KPXjj
 GfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690904017; x=1691508817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dE2jP2TIq/70urDRnV9P6HEsOoDngG6zXY/HrtxpF1s=;
 b=LrHlt/3hrmpHr2yBVuiMjrxIvf3Ih5uDzbJdOWb0nG85yIYtmgAcjAoZHpH7kGKaBq
 MSDkU7mPExdFmveCbLZxHTdBrACsKeO1mBCNfCI4CT4kpglsnIC9C9tYjvfSeQWtQJx7
 rXDF1wTnD71eE3HpRb7AXMl9b64R9pUhQrL8voTGHXV7OaAqQvKkcRWVdzKDjTx9MPBC
 uC9cSJUO3hz6uiaRxUZv++V6SQuhJV17HiAc4bk0UelJ0bG8VfDLOwecDBF/PRIloTTd
 n30mJwWkOkHqAQjuMFHIWKYNKvSOE6nS7vpRjvT51zLaJ4UmTWYwdiN+2KgvvEXiccGO
 XQuw==
X-Gm-Message-State: ABy/qLb4MJJkFQVwr3yrPqB9cxfi0WZOu5AibRh44Q1HuSP//V7ZM/6j
 UFVYOtGJqfXkQiM6yvkaNLyuZ2HCQRBlAuCRRkFyeQ==
X-Google-Smtp-Source: APBJJlF87NZoN0EKj2UQXMMptOE9S3T67CHPOCrIzH5B1T8H5mj9wqxtAgUGCNTLYOomGKQ42dPmmoxgQQEk8hetViE=
X-Received: by 2002:aa7:c2d8:0:b0:51f:f079:875f with SMTP id
 m24-20020aa7c2d8000000b0051ff079875fmr3891588edp.4.1690904016750; Tue, 01 Aug
 2023 08:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230731224106.292845-1-keithp@keithp.com>
 <CAFEAcA9xAeSpn6g66di95RihCyUxfo4hys4LRD-uJrYXd9RVuA@mail.gmail.com>
 <87r0omol1r.fsf@keithp.com>
 <CAFEAcA-WHHn0-PfJ8vTgZL5xjvR+=n1_We3v7uRT+Phi6DzsMg@mail.gmail.com>
 <87o7jqok7o.fsf@keithp.com>
In-Reply-To: <87o7jqok7o.fsf@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2023 16:33:25 +0100
Message-ID: <CAFEAcA-N1uyX3cwZ_qtf77UyKA8xdTZ3jOX4Q3LPVDQDgmF1GQ@mail.gmail.com>
Subject: Re: [PATCH] target/nios2: Pass semihosting arg to exit
To: Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 1 Aug 2023 at 16:28, Keith Packard <keithp@keithp.com> wrote:
>
>
> > Yeah, the closest to a "standard" we have for nios2 is that
> > I asked the Codesourcery folks to document it in the libgloss
> > sources and put the URL to it in a comment at the top of
> > nios2-semi.c, given that there's no official spec and the
> > original and main guest-side user is libgloss.
> > m68k is in a similar position only without the URL
> > in our source file :-)
>
> Yeah, we had the same ask when getting risc-v semihosting merged. For
> that, I actually pushed through an "official" risc-v standard. I kinda
> wish I'd used the m68k model instead of the arm model as that provides
> simple POSIX semantics...

Yeah, there's a lot of stuff in the Arm semihosting API
that I wouldn't put in there for a from-new version
that didn't need to handle legacy guests. Notably the
"errno" concept is badly underspecified and/or broken.
On an architecture with a decent number of registers
it would probably also make sense to use them rather
than having every single call put its args in memory.

thanks
-- PMM

