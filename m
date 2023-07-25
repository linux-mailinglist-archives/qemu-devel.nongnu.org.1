Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C295761C41
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:50:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJMD-0005bQ-DL; Tue, 25 Jul 2023 10:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOJMB-0005ah-Ha
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:49:47 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOJMA-0007Nn-0u
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:49:47 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-51ff0e3d8c1so8049630a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690296584; x=1690901384;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+XFZvnY541sTbdBd5J62UEkk/7UZxsMqVRwJB9C7Cr4=;
 b=ZWwL2+PX2jrcIi4cWKDAcn91ECA/1rLMgG9LgHGhk+dDNslYoJ6sYG4LHnJNU7pwU2
 g2yQtX5t2Ao9nPHDTh2y/DnnRGth2AP+hnZoZIR6Lbt2G+DlhF6HbZjFlTpKxFH2Y/ta
 PHhrbcfWIaRMYsBrlir0fU7vTEwFouVJwuh2igC0ZjV6XgGGenmqhvREnAR4y+XTAgvO
 Sm3nsTGW+csnrJS5nePeD3lOdNDCpkWk+xE87yJ1GkbYV5oRbByXOYN9DJJd+I/hq/Gp
 fXQONYK2/MHMkvlOFb4vDqvOkcHbN/XV9N/7bGuONja5O9FFrEL70kaL/HJ2W0yC56jB
 ZnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690296584; x=1690901384;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+XFZvnY541sTbdBd5J62UEkk/7UZxsMqVRwJB9C7Cr4=;
 b=XS4M1JXVzXRlbWTK1kQkEVSUTy+HqfTeiFxYPC5OkoSrTuCNjadA+WAH3woUpkMiZz
 aaSEeBkV5OXdMfKcmJKBWkTycE309zASqcWntSH3nZ8SLXdNyGKe2O2dqMB1/baHHfUR
 5/+RDSMpawvBv5VeLcFOMizVcHQAJMVMda1VAQANES4690SjGY9fu1MvKLTgyeirh4Vk
 E9s2Jg0oX0fABEOwZ8VvWwhsvPDUD42gEw8I7XMOE0QHFm6F3CW0pwwEE4h3Zdf1Kj9y
 /jr7dpQ+62X8/FqOqgfdFXYEnclN+pyORE965U28+IBIeL/+50q+67nuPzSO6pKucqm3
 zPPA==
X-Gm-Message-State: ABy/qLbN/8uBBFoc/CGaM+4s0bTnLEcXQn8qRw58vcnH7N67sjbl5UyX
 AQIjMzdlyXhXYjAAckQcqaUlDu6hn+DApaqBBecFSr2p9AH6UPZv
X-Google-Smtp-Source: APBJJlHFCeVe60M8WHaP/Ia6H5Q8aPVZrpdF1U6WtWBV1INDrLC2RfN3NEo6/0fHp79C0QdYIWnr/EW81ogZ+xNZsno=
X-Received: by 2002:aa7:c707:0:b0:51e:34a1:8bf7 with SMTP id
 i7-20020aa7c707000000b0051e34a18bf7mr10524643edq.39.1690296583783; Tue, 25
 Jul 2023 07:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230725102503.2283907-1-peter.maydell@linaro.org>
In-Reply-To: <20230725102503.2283907-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2023 15:49:32 +0100
Message-ID: <CAFEAcA80GcCXtDAx8wx-bhms3ecm4Da-n7qZw7JBE8Dty-3xqg@mail.gmail.com>
Subject: Re: [PULL 0/5] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 25 Jul 2023 at 11:25, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> target-arm queue: just bugfixes, mostly mine.
>
> thanks
> -- PMM
>
> The following changes since commit 885fc169f09f5915ce037263d20a59eb226d473d:
>
>   Merge tag 'pull-riscv-to-apply-20230723-3' of https://github.com/alistair23/qemu into staging (2023-07-24 11:34:35 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230725
>
> for you to fetch changes up to 78cc90346ec680a7f1bb9f138bf7c9654cf526d5:
>
>   tests/decode: Suppress "error: " string for expected-failure tests (2023-07-25 10:56:52 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * tests/decode: Suppress "error: " string for expected-failure tests
>  * ui/curses: For curses display, recognize a few more control keys
>  * target/arm: Special case M-profile in debug_helper.c code
>  * scripts/git-submodule.sh: Don't rely on non-POSIX 'read' behaviour
>  * hw/arm/smmu: Handle big-endian hosts correctly
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.1
for any user-visible changes.

-- PMM

