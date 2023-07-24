Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5579775F81B
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:22:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvVY-0008WI-Cu; Mon, 24 Jul 2023 09:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNvVW-0008W4-UK
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:21:50 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNvVV-0006c3-8A
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:21:50 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fdddf92b05so6156443e87.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 06:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690204907; x=1690809707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4q1LlgadzsNkuoYqfXr5kY7/NbopM7zJxUmRzYUpCy4=;
 b=eroBgMoJ5dM6jS+b8vgrzgW7VJ5cKBO++4dwmgK/jDhUgozII6TnL2Gkzj6dhgV7ff
 bVDEDHfAxYCfn5RieoMQhwc+huI/I6Thm27S4xISMKKq6xVjbCPifYkSkPvDEg336HTO
 nQ4SCrucxGmtwIJAKovu0cmrazZ/5wZIuOkUM8SZOXntO3clflAaxkeCm2uU6xZuY6EV
 ZVmpe8A+M5Auf9IHPblDq5TkI20fz/xH7FRW4Z2VdNxIQhj2x3VJYIf48GZAaywOoq7z
 1UzaHfKvktFDcOuzEnJCr/+mhFiDYu9+W0VGdN/Te6brpf9r/LjHs51GNLTR1yCPfuvo
 Q3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690204907; x=1690809707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4q1LlgadzsNkuoYqfXr5kY7/NbopM7zJxUmRzYUpCy4=;
 b=Rj3fXFJ9+ASd6dxAIBgu7FEjWjd9uR0IU+WIxhyf1Rz6buPJjiZg3zc4bSLjXxGQlQ
 OShSIsYaSm/usIpHbziL5lELty1bGflCPaPD5NeTbSw7RQ2AcpWGdozlYJQBwAIeibA0
 aAORzGtNao1c5gzMdvWb1wMNAhAbLxRLXx7nxOY1XCnTbGLyDYVfEgMxKrT6DjMuX7nW
 8E5ZRGsoV8REyNpFulRHGg67BxRNJSdCoNK87WGOiypYlQ4+njhNqf2AJ1A0IH8DTqdA
 dArStijvHvtkBxrUxo36SmKY97Qz6L7x0n1XJla/8h9xe47wDuIwmpRpTdNW0gxgJbPe
 44Dw==
X-Gm-Message-State: ABy/qLZZ5yprggdWZqOLds4/mpxgkWpD8/5wkBpZ/sB24hv9fapicqbp
 0y8sXT/fyeJfb1tHTkzB2Y9k04v7HV3o3dzTEcrJOA==
X-Google-Smtp-Source: APBJJlFPwArfmWKC5sfGKAu24SD+rBhjJnO2MqPKQuf4PxMLguzBfzugWYLqyp/2YLJiyiF2U/GH6n1KacXGn4c9F5s=
X-Received: by 2002:a05:6512:3ac:b0:4fd:c84f:30d4 with SMTP id
 v12-20020a05651203ac00b004fdc84f30d4mr5255320lfp.36.1690204907500; Mon, 24
 Jul 2023 06:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230724085328.4936-1-richard.henderson@linaro.org>
In-Reply-To: <20230724085328.4936-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 14:21:36 +0100
Message-ID: <CAFEAcA_+ESKNMH-bWbBUCke=42=7N=Dso6vGAp9cEiYHFc1KrQ@mail.gmail.com>
Subject: Re: [PULL for-8.1-rc1 0/7] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Mon, 24 Jul 2023 at 09:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit d1181d29370a4318a9f11ea92065bea6bb159f83:
>
>   Merge tag 'pull-nbd-2023-07-19' of https://repo.or.cz/qemu/ericb into staging (2023-07-20 09:54:07 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230724
>
> for you to fetch changes up to 32b120394c578bc824f1db4835b3bffbeca88fae:
>
>   accel/tcg: Fix type of 'last' for pageflags_{find,next} (2023-07-24 09:48:49 +0100)
>
> ----------------------------------------------------------------
> accel/tcg: Zero-pad vaddr in tlb debug output
> accel/tcg: Fix type of 'last' for pageflags_{find,next}
> accel/tcg: Fix sense of read-only probes in ldst_atomicity
> accel/tcg: Take mmap_lock in load_atomic*_or_exit
> tcg: Add earlyclobber to op_add2 for x86 and s390x
> tcg/ppc: Fix race in goto_tb implementation
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.1
for any user-visible changes.

-- PMM

