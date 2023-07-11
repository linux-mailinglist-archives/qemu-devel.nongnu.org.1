Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3386774F5B8
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 18:41:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGQ3-0000yw-PF; Tue, 11 Jul 2023 12:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJGQ0-0000yY-Ea
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:40:52 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJGPy-0003y5-SG
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:40:52 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51e429e1eabso5693909a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689093649; x=1691685649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=13nQg2vhp8ED9+RDZ67JJ784+Le9sQq8Ht2lQnNXXG0=;
 b=wGpJRClGPK2gFVFAmm62SRbGa2b68looD0D2c+g2ahzb5IDFLeTKdA8iApEzmy62Kt
 6Qxeqw3uA9xA73fLgxMck/HONw/SHM5qfrS6AnMxId4T3H4grVbTDsWffgPMGocD4OHV
 Tdi87QybEgtZpt5faQ1Ekbhalh+GfOlF/qZ7mpZj4n6Gf+aUVBLt4v5KS2/G00Knk24y
 RAvytoFPWjpt+SZzuq9yCddtiRKAFmq66Qm5ySTQT8UVeoQqr0NESv5qtKm0eq2qPLYr
 7HV5+jbILXXorSoBNZzFxGvzVDsa13UT3eaYCjWyVYAwecQYSVZLVoc+3iLkgcdr4zn7
 a7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689093649; x=1691685649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=13nQg2vhp8ED9+RDZ67JJ784+Le9sQq8Ht2lQnNXXG0=;
 b=kZt6+VGRWWDq4pozH5KhdyUFnD7jjbYKBCg+brKyNgaLOBnhaZvllED4xQRCo7kZ8Y
 7S4YMb25IPXEQriJvB9Kmp6O/xpO8uLutc0931bLp3L6x+7rJAYK52c+3mRd8jyN7pkF
 eOq44HiCKIjNk+A6Q8bQCMtcWe7A7/jKgLw490MhndqT1eOGt64CeMgD3bu+Ei2gG41c
 QxAFME5vbn2p6aby7j5t2YWtZa8OG/fDhobxcjihbk9SQUXKvVai2rFz2d77bfu1Z/Hi
 yOozrzwwj7qve0DI1M/u61rNiLzwHBZLHDKVh8VB7+UloabEufRjRSF7vSo1Rtuz4eeH
 G0pA==
X-Gm-Message-State: ABy/qLaOZOg25A4MK7j0DcVPaVyvZlIcir4+zrQCLqBId0+CNWvTvqyo
 oYBYElj/CIaKMxr+w1a6CUfV0Vcc3jg9Q6nhBLGKcQ==
X-Google-Smtp-Source: APBJJlFXmLSc5el0jVZk3G1NN/IyKP6w+gIqwwFtUhNHhvOsSpJzTpDE+Ep9F1kyn+Oqa0bh40xm4okvAfKr+Qrab7A=
X-Received: by 2002:aa7:d741:0:b0:51e:2664:f695 with SMTP id
 a1-20020aa7d741000000b0051e2664f695mr15576542eds.23.1689093649325; Tue, 11
 Jul 2023 09:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230626153945.76180-1-richard.henderson@linaro.org>
 <20230626153945.76180-7-richard.henderson@linaro.org>
In-Reply-To: <20230626153945.76180-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2023 17:40:38 +0100
Message-ID: <CAFEAcA-VvS_Of9mJNNic3xdrMjEbT6bkNpsyYMdGUOr4gUy_fg@mail.gmail.com>
Subject: Re: [PULL 06/22] accel/tcg/cpu-exec.c: Widen pc to vaddr
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
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

On Mon, 26 Jun 2023 at 16:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Anton Johansson <anjo@rev.ng>
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20230621135633.1649-7-anjo@rev.ng>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> -static void log_cpu_exec(target_ulong pc, CPUState *cpu,
> +static void log_cpu_exec(vaddr pc, CPUState *cpu,
>                           const TranslationBlock *tb)
>  {
>      if (qemu_log_in_addr_range(pc)) {
>          qemu_log_mask(CPU_LOG_EXEC,
>                        "Trace %d: %p [%08" PRIx64
> -                      "/" TARGET_FMT_lx "/%08x/%08x] %s\n",
> +                      "/%" VADDR_PRIx "/%08x/%08x] %s\n",
>                        cpu->cpu_index, tb->tc.ptr, tb->cs_base, pc,
>                        tb->flags, tb->cflags, lookup_symbol(pc));

This again has lost the zero-padding. I noticed this one because
I have a workflow where I post-process these log files to
extract the executed PC values.

We've also lost the "PC is padded to the appropriate size
depending on whether this is a 32-bit or 64-bit guest CPU",
which is a bit of a shame.

thanks
-- PMM

