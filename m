Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEAD72279F
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6APY-00034n-Qd; Mon, 05 Jun 2023 09:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6APX-00030c-4r
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 09:38:15 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6APV-0008Nl-98
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 09:38:14 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-51456392cbbso12432914a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 06:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685972291; x=1688564291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yJRpa/GQE8w5GC6UZJoClHK77tuIGKMKbmNhSCVbhJo=;
 b=MSQ0TMFKNurHtw01IG7hV0jkCWiIEhd3HSOfslmAHPoPSoNhmKQ8Rin24LmzdWgUvQ
 kILAb6834R5im7ilmvBe1lCpvQIa7cQizJjZH0ptvvCK/7DOV2W7dOgI+RIUtiaNQZLf
 8dFFezWLPRwWemwsQv1+SNjSVPSLh+Eq0mxaqrd7b9oDHttgh5zKHzRq1xK2xbb/3RID
 XN5ocguAGSpQkxNYsWIZl1b8Nh3zSCqBOedbKPOp+pWgrlg7q/ZLW43Tb8vx/vkGQWlM
 yg4LcYh+ZUlO1qbtVIfSF/7wEHzq2bwk0rbLP6LWvsuWRfWnvDbg9ENpgA879Zma55v1
 D+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685972291; x=1688564291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yJRpa/GQE8w5GC6UZJoClHK77tuIGKMKbmNhSCVbhJo=;
 b=I3mfxtCD5Lc9Tl8xSf9mpLhLKscjklGIpY3OTSUvEqIflv9y7Ddtg9marp9vsQe6Tx
 z+5G5NIYbkCjolicqNNiK5s91mVLmLAGLGRicXJ44ZOjguXSquZ9pB+5jwq2QotynbUt
 3LC7FoZgI0mIiIeawsCVze3jbECbZ2M40hpTmBK8ixFtSwaWtjaMHv/TGBPy2EKWU3J0
 XOwYfALXDF0ygeQwB8moNNA8HiH8FKKbSDAFm0kdrMN1V1yiPR00jmwK9+S+Bf6HpvYV
 POnt5JZUYKVY8CmOCbUgAoz2J795P4lFgQowYhcu6avIoZohtHbokY25RcTJ0FDfZP0t
 p/YQ==
X-Gm-Message-State: AC+VfDy16mHcUb2ZbR+WZsjueX6WUF8HTXee7PUKNE1+2lmtCruvkoMr
 5GcdpbSXDiMdLNCbky8V3umvJj/pkoeb98N11ukHyg==
X-Google-Smtp-Source: ACHHUZ4GH8Y/X1Jrogy/L6R+qO9bT6K+XLeuxd5C1hJYqFkx/GWmBr3QG44JaVxKvOX6hKRlxZVWo7rqJJEClU7ulAM=
X-Received: by 2002:a05:6402:354c:b0:506:71bd:3931 with SMTP id
 f12-20020a056402354c00b0050671bd3931mr10545012edd.2.1685972290777; Mon, 05
 Jun 2023 06:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230601153107.81955-1-fcagnin@quarkslab.com>
In-Reply-To: <20230601153107.81955-1-fcagnin@quarkslab.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2023 14:37:37 +0100
Message-ID: <CAFEAcA-8EBFJLb4SMCT=zy5Qy3gcybaTistVOckMOO+iQn_qRQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add gdbstub support to HVF
To: francesco.cagnin@gmail.com
Cc: qemu-devel@nongnu.org, mads@ynddal.dk, dirty@apple.com, 
 qemu-arm@nongnu.org, agraf@csgraf.de, pbonzini@redhat.com, 
 alex.bennee@linaro.org, philmd@linaro.org, 
 Francesco Cagnin <fcagnin@quarkslab.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 1 Jun 2023 at 16:31, <francesco.cagnin@gmail.com> wrote:
>
> From: Francesco Cagnin <fcagnin@quarkslab.com>
>
> This patch series aims to add gdbstub support to HVF (the 'QEMU accelerator
> on macOS that employs Hypervisor.framework') on Apple Silicon hosts.
>
> The proposed implementation, structured like the KVM counterpart, handles
> single-stepping, software breakpoints, hardware breakpoints and hardware
> watchpoints.
>
> The patch has been most recently tested working on a macOS Ventura 13.4
> ARM64 host and a Linux kernel 5.19 guest with the test script
> 'tests/guest-debug/test-gdbstub.py' (slightly updated to make it work with
> Linux kernels compiled on macOS, see
> https://gitlab.com/qemu-project/qemu/-/issues/1489).
>
> This version of the patch should fix previously reported issues on
> multi-cores guests. No other issues are known.
>
> The patch has been tested on top of QEMU v8.0.1 dabb418.



Applied to target-arm.next, thanks.

-- PMM

