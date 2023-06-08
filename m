Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB72C728337
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 17:02:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7H8O-0002l6-N3; Thu, 08 Jun 2023 11:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7H8M-0002kM-9O
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 11:01:06 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7H8K-000503-MR
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 11:01:06 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51494659d49so1230796a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 08:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686236462; x=1688828462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMg1XesjhjEzyBggs7JPn+EnI4gQJbzev1tC7y28zJc=;
 b=tS8fsDmU/RTBnFGDD/qK6j1L9ktn+rd8xteCXK+qr8QBZkvcjcW9MKxnCaR62bHRFd
 QQK7BE1rWBorUexRMZLlnOfNWWx+5c45G3o+ikp0XzK9AdeH+KjqOuuUtxOmp9lxuHBg
 nlLbXX06Wz3M8sGFdHL11d5sLKDb0rTJV4dqLhmdJIvtdiB5k2ChYai3XcqfgS36k75Y
 cRbAlr3z3Biy6v8jAnJHc3d/eyHU3x3dmcwXZPcXZjZ+ZRyMRemo6tX0Vk+jEThglV4l
 DhCXbpef4sQQFC2B7mTI83TIY6wktFy0eVevo2TjYebMscQTgYibGpig+sUycn2wYfS/
 qTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686236462; x=1688828462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zMg1XesjhjEzyBggs7JPn+EnI4gQJbzev1tC7y28zJc=;
 b=EV/AJHpaOl4WQfo509X/o7abzZNeggQbsgz7wH9jVz5qdD+6V1bCSM2I99WdaZcCaZ
 L9Cpf4O/Hn78gd047v3+nVSSzvpUeDyYGgqBSUkSK9FqqUN0v5uA33F+kwoANzO7dk3y
 AuFoXMDOLIHFbFcJsaJ1QYxH8GBjkpacNC8FRpAVQJkvqsORpXzCvhOP0iddig5MjWZ8
 EGUe+nrOvVqbMa8Ssf93eS3mQwE8VlmGKtDsHcLJQbNgYR/1XvfT4Wt2UhIGOaN7RAE/
 LkNR6ykKuY9XLVUVQvNEDEYeVvmT9fsEaYosvhkmFx1onbJhSqxghoIyT+uwRxmRHcHD
 ctJg==
X-Gm-Message-State: AC+VfDyDiEcw69S7XynwNwhCzGoVjsXiLDkPGLAQ/90xJpx5jXW0lJvm
 ujbbZ4G6pNy9pSNSGodliimvoQ/5z3yvZ/L+TaRGfw==
X-Google-Smtp-Source: ACHHUZ5ta8vxZvPv92NsyrgPMuoh4Ofx96/+oEOMkxjcUwXp/w2e++jW/z5S9+yeWQR2Md+yP7bpTYJBAnul+4MTjoI=
X-Received: by 2002:aa7:cac5:0:b0:514:a696:1255 with SMTP id
 l5-20020aa7cac5000000b00514a6961255mr7031245edt.37.1686236462474; Thu, 08 Jun
 2023 08:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-13-philmd@linaro.org>
In-Reply-To: <20230531203559.29140-13-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 16:00:51 +0100
Message-ID: <CAFEAcA_BSA8s6_8BbMZG9wGWMg78u-k-GQ8ZG8n-MUCRNeEUDA@mail.gmail.com>
Subject: Re: [PATCH 12/15] hw/timer/arm_timer: Pass timer output IRQ as
 parameter to arm_timer_new
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 31 May 2023 at 21:37, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Both SP804State/IcpPitState peek at ArmTimerState internal state.
> This is fine so far but we want to convert ArmTimerState to QOM
> where peeking at QOM state internal should be avoided.
> ArmTimerState's IRQ is just a pointer, so we can pass/set it via
> argument, avoiding accessing ArmTimerState internal state except
> from the arm_timer_*() methods.

If we convert ArmTimerState to QOM then shouldn't the
irq become a sysbus IRQ on the ArmTimerState object,
and the looking at the internals go away automatically?

-- PMM

