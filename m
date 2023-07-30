Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5E8768630
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 17:22:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ89K-0005Nz-QC; Sun, 30 Jul 2023 11:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQ89I-0005Nn-TK
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 11:16:00 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQ89H-00075U-7l
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 11:16:00 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-522382c4840so5456299a12.2
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690730157; x=1691334957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I6N4JHDlp6mM34fNNXZsqapzqRDG6xCHyQepCbY627Y=;
 b=hjlAjfUpCXQm0GLPqH5/P8aLnRIKTYRm7ifm3ZDlmpkf6VLpa8d5NuLWaKwMMGn2pp
 wkR1OXCjxxcRw+1b+WKGmxNTSIR+e6YEEU8+NzoC1hmGOrj3OME44j3RI+jwLqpxXljU
 BUsZbqihMJ1/HzFHrIQQC/uwkFJj20dFu4pIDqoelI4LYd80Qz9IeMOUzmk4AgvcE4AV
 uSecYdTCJvVvEq1dnnFMn0sEBNkFPIQfCWrbBz8BRWZtvEl2/yaBGbymQJ1NKBYahAYU
 rxF9ZN1Yka5lCEUh2/dD+LBIOyTEatM7Sij6yUN7B2/GKemeu3pcWxCvK+lOzHf7mn4s
 /TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690730157; x=1691334957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I6N4JHDlp6mM34fNNXZsqapzqRDG6xCHyQepCbY627Y=;
 b=Y80vnOZNBXaUXxnLnWksPTmfwn0wEXWR7sLeat/YrYonvNP1O9vTKf/VvqaCI+Rebp
 AXk71Xg2k/YGNRUsB7JNVK6KcyK6cVggHrxoLNHUPMcOyBHRhz+merOY6iK3KyiJGFp6
 QHB5U8w/1NzSgY8edlqFRsnYXORSnoEjAN6cG25Q0cY0LyCC7qChTkPEEFKKbKTjNYaU
 OFY7g6PeQaGyyV9klColUgZJPGhqHGkS1kf9mbeEbK6LNY28HeRQFTT4DRcwHbJjhGgd
 +m3zh4MZA96tOYlT7+5Wkmz4k38XiGOxMnDOpWITSnazIF47YBx/ULSWEJRNC0G7NsVG
 YBGw==
X-Gm-Message-State: ABy/qLauimvhfJ/Sdbf2JapoO+WMCUZF/BlljKbH29K1lanYH++DouAq
 fUTIg35i/XlX5KBQCZphqawtfVw75tBmBP+m8CbMZg==
X-Google-Smtp-Source: APBJJlFb2xcXeHb6yM7b4UQTqV6QUqx7MnSTjEyfTUy687gGpxUeE4VNyKNPokYUgbzhgkXvIJCb+AT9loxXfmt+PEY=
X-Received: by 2002:a05:6402:1612:b0:51d:98d0:3049 with SMTP id
 f18-20020a056402161200b0051d98d03049mr6940192edv.21.1690730157509; Sun, 30
 Jul 2023 08:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230730064057.357598-1-dinahbaum123@gmail.com>
In-Reply-To: <20230730064057.357598-1-dinahbaum123@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 30 Jul 2023 16:15:46 +0100
Message-ID: <CAFEAcA8pmQybhWPWdPfSSOXa7Xuh_oGgQBTmN3i8xUuBD0_=bw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Enable -cpu <cpu>,help
To: Dinah Baum <dinahbaum123@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sun, 30 Jul 2023 at 08:21, Dinah Baum <dinahbaum123@gmail.com> wrote:
>
> This patch adds the ability to query for CPU
> features. Currently it is limited to the architecture that
> support feature probing (arm, i386, and s390x).
>
> Ex:
> athlon features:
>   3dnow=<qbool>
>   3dnowext=<qbool>
>   3dnowprefetch=<qbool>
>   ...
>
> Suggested-by: Peter Maydell
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1480

Ccing Markus for review of the option parsing parts...

thanks
-- PMM

>
> Dinah Baum (3):
>   qapi: Moved architecture agnostic data types to `machine`
>   qapi, target/: Enable 'query-cpu-model-expansion' on all architectures
>   cpu, softmmu/vl.c: Change parsing of -cpu argument to allow -cpu
>     cpu,help to print options for the CPU type similar to how the
>     '-device' option works.
>
>  cpu.c                            |  61 ++++++++++++++
>  include/exec/cpu-common.h        |   7 ++
>  include/qapi/qmp/qdict.h         |   1 +
>  qapi/machine-target.json         | 138 +------------------------------
>  qapi/machine.json                | 130 +++++++++++++++++++++++++++++
>  qemu-options.hx                  |   7 +-
>  qobject/qdict.c                  |   5 ++
>  softmmu/vl.c                     |  35 +++++++-
>  target/arm/arm-qmp-cmds.c        |   7 +-
>  target/arm/cpu.h                 |   7 ++
>  target/i386/cpu-sysemu.c         |   7 +-
>  target/i386/cpu.h                |   6 ++
>  target/s390x/cpu.h               |   7 ++
>  target/s390x/cpu_models_sysemu.c |   6 +-
>  14 files changed, 273 insertions(+), 151 deletions(-)
>

