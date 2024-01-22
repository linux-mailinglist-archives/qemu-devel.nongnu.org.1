Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76914836827
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:28:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwCe-0007o3-6V; Mon, 22 Jan 2024 10:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRwCL-0007lH-8N
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:26:54 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRwCG-0005mM-RD
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:26:50 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2cd2f472665so31144251fa.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 07:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705937206; x=1706542006; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qOhfs5gaPkHmXD0MP+EgQTljDWkCNKnrKUdrekhKs1M=;
 b=KyxFYmXc1rkN0B+5i34zxpc4D+hFJY66Y5EOKuulcEaIUu8wYIyNUu19iWbmKAZyt1
 tBd4INevk0P7KSdGydSXUEj8+Nc/lbv7RDCK48zDaed5vtm6GyE6OM63sa/nNiPZESyB
 OyfDsByHgUVbCe7lhaZEZRxPcrBM5GYWlpDJfu649SOVGzWn9g7iYJKFHOc1sk9VVexv
 7pkycq5p3Mbdtg5RDtmP3hcUAys+mH1Y1CS/236rlJ3EtgjXfaj+JVt6hf5/97CJ4puw
 YzNaTf1OeX8X8TTxm8SYOVSDTCxxIhqkvZyrZjtL8+bd308P7nDRXAXqVbZCd4N15Mn9
 2HeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705937206; x=1706542006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qOhfs5gaPkHmXD0MP+EgQTljDWkCNKnrKUdrekhKs1M=;
 b=Tin0JPwSTby1f3MQoR9MZ6Ddo9t3LgAO7TqvjajJY/WOjisXmgdiy9BtXxHQ3ykTnU
 uxJk1dFzSGAuGqmxQWjWsRa/EXWBTTcxyVvFUo205gg/4WdoHglHcJ+xa7dOmYeE4/xy
 GKq9/eTKQeLL5Cy7wSTBaw3+ndgS+f65keX4baoHpgsRnZPMaMa/87Ec1Q7g1ZBOF/UJ
 9CxESSruU4xCO6jm0PMCpReGh0U935uEVY/rk7l/BSAqQOaF+yQzj6ptTx5uIXdMQjtE
 JN4X8fYH7Pnngo69tgUu6SljOtzBxXAqRGRjMN7Kj6nmc0spBFvjn0vkj/Iod+xyecdL
 Gajw==
X-Gm-Message-State: AOJu0Yzg78Zc6gVgz76QZf7taysXpCRgUKMkP4n9yA62n7vdU5lH9tsy
 yd0gI81FaPZD/QcXLbyn+YlhknTkYY5uQ08MslJnIVmKF05BnuoC9cA5CE6ikxCZKFU93xAty/q
 kaNcmh5VG1xZ3HgDGwfn0zpEBljttHlP5GJiACQ==
X-Google-Smtp-Source: AGHT+IG2hvU5b7EJKELZJAvdAZldOpR7lBaCcddUKkpA9sURNk55rjW9rWgTUiJ8MsuTBV3DuiGFmubBBHaHKapGiD8=
X-Received: by 2002:a05:651c:c2:b0:2cd:fa8e:6920 with SMTP id
 2-20020a05651c00c200b002cdfa8e6920mr1699946ljr.62.1705937206259; Mon, 22 Jan
 2024 07:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20240121002047.89234-1-richard.henderson@linaro.org>
In-Reply-To: <20240121002047.89234-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 15:26:34 +0000
Message-ID: <CAFEAcA84d+mq85kae=yiwNvg1Ja=SKch00mocuNok1VghiYozQ@mail.gmail.com>
Subject: Re: [PULL 0/8] tcg + linux-user patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Sun, 21 Jan 2024 at 00:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 3f2a357b95845ea0bf7463eff6661e43b97d1afc:
>
>   Merge tag 'hw-cpus-20240119' of https://github.com/philmd/qemu into staging (2024-01-19 11:39:38 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240121
>
> for you to fetch changes up to 1d5e32e3198d2d8fd2342c8f7f8e0875aeff49c5:
>
>   linux-user/elfload: check PR_GET_DUMPABLE before creating coredump (2024-01-21 10:25:07 +1100)
>
> ----------------------------------------------------------------
> tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
> tcg: Clean up error paths in alloc_code_gen_buffer_splitwx_memfd
> linux-user/riscv: Adjust vdso signal frame cfa offsets
> linux-user: Fixed cpu restore with pc 0 on SIGBUS
>
> ----------------------------------------------------------------

The new chacha test seems to consistently segfault on aarch64 host:

https://gitlab.com/qemu-project/qemu/-/jobs/5979230595
https://gitlab.com/qemu-project/qemu/-/jobs/5978381815
https://gitlab.com/qemu-project/qemu/-/jobs/5982075408

thanks
-- PMM

