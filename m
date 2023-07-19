Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A22A5759E9A
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 21:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMCsx-0006js-IP; Wed, 19 Jul 2023 15:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMCsv-0006j7-JQ
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 15:30:53 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMCss-0001iL-Ui
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 15:30:53 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51fdf291330so10267748a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 12:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689795049; x=1690399849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OJQqgFzkBQJ/xjivG7R998BQ0GaqJt4Qt57Coj1ytBo=;
 b=r3rqO6035wazj2ZMkqmlnEgCSZEko0kALFm0yAJuu/S/oQbfKNTcsrqZu43q3zQADZ
 dzK2BgzWlTay2Xx6PSH6Nxi9bEgWFf2S7PparEwqAB2aCpvoWhCxB/ZV/gcaGvfv2YfA
 FW/1Be98pZJ6HxbOqcwGGxlY+eFyYgndB5+frSFG7Li947HsUcrsznm4QmaCFrrIdmGT
 wevZVL9p++j+PAgJQ72+B2CpJ2bqiQGiw99wREWK94fv6nUB3syqFabksGzlsvmge/t+
 6KU2Tao5bvmhf2d85tVU0ocgf/4AsQc3X8wSPl2xp8cEp0cKB8QECYea5MdeZMfd2+zh
 2Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689795049; x=1690399849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OJQqgFzkBQJ/xjivG7R998BQ0GaqJt4Qt57Coj1ytBo=;
 b=d+gEymKIacnLOvInxFCRmlFSNEBV8JwQg5TOIzXPt2McSANnl1rk2K5iHdntB9tCAK
 AbPxtXNmP5D3UXsG4KNK5eBb1Fo3q/ER8XcgLIKWw2TEH1YP9PlSd2nXi0MV2B11sc85
 AYS8CLAri4XeEYvKVg+KjqCf12rONaQlln/XiYGCLetLb8MtyzAGJcwyqDXs4J4GCLB7
 jihMfbv3K2jBlLNqlMwrwgyN1uZaf5mmMdbomDi6a+qclOO9DDjGnKnVAZVmmSVS5/55
 quXd2AdeeTV5csdi1/zXmm5pbWGOjFSOrUwaKhMABQTSdRfysOK03MYL1q0KpO7aCUpV
 BkBQ==
X-Gm-Message-State: ABy/qLbrENDcrORO9+eSqYgfEXKNZq/JCdqD8GT5JyygUiKBEY35963y
 4mf5GhMtCP6wwLYBAfhwN99bEKryFEK4dFSei7dHlw==
X-Google-Smtp-Source: APBJJlFpIBQmrUNSy2wuK32kHMRhVQMDMdcQFP6BefT1atM+xvlFX0K2Hg7FU9N6FkLZ661vAiZdx6Riefu48OhSi3A=
X-Received: by 2002:a05:6402:199:b0:521:77dd:c8d3 with SMTP id
 r25-20020a056402019900b0052177ddc8d3mr213720edv.27.1689795049495; Wed, 19 Jul
 2023 12:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230719073605.98222-3-its@irrelevant.dk>
In-Reply-To: <20230719073605.98222-3-its@irrelevant.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2023 20:30:38 +0100
Message-ID: <CAFEAcA8k8ZtrEQoXBfjBPm32PDa-Z+aHhdGZ7-g75YkZt2ZKrQ@mail.gmail.com>
Subject: Re: [PULL 0/1] hw/nvme fixes
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, 
 Fam Zheng <fam@euphon.net>, Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Wed, 19 Jul 2023 at 08:36, Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Hi,
>
> The following changes since commit 361d5397355276e3007825cc17217c1e4d4320f7:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-07-17 15:49:27 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request
>
> for you to fetch changes up to ea3c76f1494d0c75873c3b470e6e048202661ad8:
>
>   hw/nvme: fix endianness issue for shadow doorbells (2023-07-19 09:33:54 +0200)
>
> ----------------------------------------------------------------
> hw/nvme fixes
>
> * fix shadow doorbell endian issue
> -----BEGIN PGP SIGNATURE-----


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.1
for any user-visible changes.

-- PMM

