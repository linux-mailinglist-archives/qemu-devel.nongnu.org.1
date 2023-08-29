Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C30C78CB48
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:31:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb2YQ-0008Af-EQ; Tue, 29 Aug 2023 13:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb2YF-00086u-JE
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:30:55 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb2YA-0003GN-Hj
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:30:51 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4ff882397ecso7197263e87.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693330244; x=1693935044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eY3UzQP6ULG4f1ZgXxt8dU7vQozVKBvBfHFAq70A7U4=;
 b=Gf04/8CpJGqnRYTHUjKcjAr5VTOM+SvFPWK/jlqxnrbXRl+zPBAj8jrFo3mwvX67F0
 xYrlJ6qem3+xniRbHNy9MzOip22DSttI0tWwOz+NVBUb7JHH4QKPrFTdn0GPhmn9MMOm
 cSO+czO83BMmdjGnQ4jcnnsMECjzW9w1P3JBdhIPbMseaW7n2wB4m7+PRcVzi8Tryth/
 U7YEUpLc/BejjkcFoot7s6b9gCXOmFnPZwGrnWmmR/gU0NbUu+P1mMx0zlmSqBFQkngi
 4qzruTIymYn76VrhuNjjCXcOgDUiMrb7kw4FG4TtnINP72ebcAlLUPSpkE2s9EvrD85p
 QhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693330244; x=1693935044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eY3UzQP6ULG4f1ZgXxt8dU7vQozVKBvBfHFAq70A7U4=;
 b=WrPLXUpnTvrnZ9cH2fyB6ROG0aSy2gNrYP1EK7jLict53h/MJJVNh9Q6SETYOmy6i9
 U5wBhJBrHofn7Dpw4ZfEJDalKWxfWGiUU4PUZYj7HMq6qFwhd8PBrJhyyzX+y7DrJ2a9
 HH0CCz/HNRApctUVDglWT3ThJCNliFXGOWEtbmtvy7g2nnP4WvfHUuDRyX7M1sFtLaPl
 LgOqe+l8Lo0bzDjgubZjWP/60PQbvd66/HxP+zOlBgegf0V8hjrU0/mKnhc2mx8m5NGJ
 pIRkUvnlL3YM4eJkpxXniNSpHrmfWZqkmSxbNdstxnulirM/o0gwk4YV2y79DrkWGmgD
 Mhig==
X-Gm-Message-State: AOJu0YzbIWxWzzypDr++HpcUNND9upGLYRejn8681L3gj+7MucCA11uv
 9MV+k+cUMZjSlOHdOzD7FA7BLxyFSGHOoJR9Rs/p9g==
X-Google-Smtp-Source: AGHT+IEunmya93rEQ5w7oc8ix0RFvs5Ut6YjdSKoSLlcl/3dSGrEOOcwXFhXU8ti+5k2jrbde7hKZeN0wkr41sHJ3M4=
X-Received: by 2002:a05:6512:3613:b0:500:8c19:d8c6 with SMTP id
 f19-20020a056512361300b005008c19d8c6mr15054324lfs.58.1693330244552; Tue, 29
 Aug 2023 10:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230828233821.43074-1-imp@bsdimp.com>
 <20230829135009.GA179554@fedora>
In-Reply-To: <20230829135009.GA179554@fedora>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 18:30:33 +0100
Message-ID: <CAFEAcA_S1rTZgi6h1o9Hj9=ZoEEWbKiJ5KZ7Mx1fH0_+eX6FSQ@mail.gmail.com>
Subject: Re: [PULL 00/36] 2023q3 bsd user patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org, 
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Kyle Evans <kevans@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Tue, 29 Aug 2023 at 14:51, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Applied, thanks. In the future, please invoke git-request-pull(1) with
> the public HTTPS repo URL to make it easier for anyone to fetch the
> changes:
>
> > are available in the Git repository at:
> >
> >  git@gitlab.com:bsdimp/qemu.git tags/2023q3-bsd-user-pull-request
>    ^^^^^^^^^^^^^^

Hi; it looks like this broke the clang-user build. Here's
a gitlab CI run on my local branch:
https://gitlab.com/pm215/qemu/-/jobs/4975956600

In file included from ../../linux-user/arm/cpu_loop.c:21:
../../linux-user/qemu.h:210:9: error: 'PRAGMA_DISABLE_PACKED_WARNING'
macro redefined [-Werror,-Wmacro-redefined]
#define PRAGMA_DISABLE_PACKED_WARNING                                   \
        ^
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/compiler.h:42:9:
note: previous definition is here
#define PRAGMA_DISABLE_PACKED_WARNING                                   \
        ^
1 error generated.

Looks like commit 15b950ecd16ecc added definitions
of PRAGMA_DISABLE_PACKED_WARNING and PRAGMA_REENABLE_PACKED_WARNING
to compiler.h without reconciling them with the
slightly different ones in linux-user/qemu.h.

Can we have a revert (or a quick fix), please ?

thanks
-- PMM

