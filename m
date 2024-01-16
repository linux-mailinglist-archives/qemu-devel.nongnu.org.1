Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8464282F07D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 15:23:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPkKz-000458-Je; Tue, 16 Jan 2024 09:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPkKp-00044h-28
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 09:22:36 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPkKn-0005Fn-Cg
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 09:22:34 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-557c188f313so15561466a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 06:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705414951; x=1706019751; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRfWSGVBWxQhcFH7WKGFHlQ8cRGBToksyEb1SA8gE8k=;
 b=ue5rLJOR0uBuWJTRm0X+vUFucoZxzeuAKqQv3s0l1Xe0L9yJgfkBXbZTsUj0Qkq9i7
 fj1doB4P5e+hxaVycJae31zNbXlYvsfA78B7+8ZppSFnsYJnM2COLE5PRZuStwtFo3i4
 Gt0oApXg0Pca5yE+vQdIDn2a545vucW4kJhx0BjdpRzSqB7Br2NNT9yilPcpdKcxtEvX
 dr+H2gWZCxTvzdbPx/lLFiusfen2CngvRgE5gpjwp0zH8y7PiPr1L9fEJryqdXXk9ww9
 JND9H1JWNxVe7XK3/b0dpbX8iSccmFCfat2YZVcUFLgIxiznSB+hRzScWN4rV1EZuVS8
 +fcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705414951; x=1706019751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jRfWSGVBWxQhcFH7WKGFHlQ8cRGBToksyEb1SA8gE8k=;
 b=QpNhbyJASw+3knE90QZjThPC6aQorCBNruKHSOk4IeKjy3RsDpSjRhaOT/36RSJMrD
 VXv7TB3HxD/X2htBkZyn75AfFJQyPnDZSVyJ7ZDfDnRVfGy2CVrWVCR+7hTf2vvb1gIk
 /ybHAlC3U6BufI9JFabA+PDpB2cjubc68pb7slC0S7ngiJTu+Yp5trSlK+tvefhwe60y
 5+VHIolEOP44021Wb3fqRfQ43sF9jstDaJ5vAO8439YtWD8JUh2g4RD0ChTDxRVbk+PI
 zV99FB6nFjcXd1hS6EsWFUjyM4pQjbrXy8EQMfCF7WVV84HB1MnAMgmmLMSeWc/akh9r
 +6lg==
X-Gm-Message-State: AOJu0YxVJjwYL2TA6EP+pCg6rfoDYwGImnweCzCgFXFvh9XsfGTj7I/d
 u6r/FxU1CR7hkDHQAnQurSM3Z0T+UvbSCC3cAFldWzHvPDlHgw==
X-Google-Smtp-Source: AGHT+IFklL9wu9RE8dFpkBmCEC7aWTq8khYnv2Z6v882fO2jvuLS9u7qSFvIJSpWTCCComxlTr7dHUDDbRbvUbXSEWo=
X-Received: by 2002:a05:6402:234e:b0:557:8077:efe4 with SMTP id
 r14-20020a056402234e00b005578077efe4mr8807229eda.27.1705414951121; Tue, 16
 Jan 2024 06:22:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+ji3pGBJBp+trjM-RhgkYjOs8rrtLJgHsaNvf=EyGtWB4gAow@mail.gmail.com>
In-Reply-To: <CA+ji3pGBJBp+trjM-RhgkYjOs8rrtLJgHsaNvf=EyGtWB4gAow@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2024 14:22:19 +0000
Message-ID: <CAFEAcA-L2vepWXfgaHW=ogLAvAZjJd5yv1hm6dBU6dsEOS_gCA@mail.gmail.com>
Subject: Re: Assistance Required for QEMU Hardfault Error with Cortex-M33 on
 MPS2AN505
To: sanjana gogte <sanj27272@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 16 Jan 2024 at 14:16, sanjana gogte <sanj27272@gmail.com> wrote:
>
> I hope this message finds you well. I am reaching out to seek your expert=
ise regarding a persistent issue I have encountered while working with QEMU=
, specifically a hardfault error when emulating the MPS2AN505 with a Cortex=
-M33 core.
>
> I have been grappling with this issue for some time and am unsure of the =
next steps to take. Could you please advise on potential areas to investiga=
te or adjustments that might resolve this error? I am particularly curious =
if the issue lies with the vector table placement or the configuration in m=
y linker script.
>
> The error I am facing is as follows:
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
>
> This occurs when I attempt to run my kernel.elf file using the following =
QEMU command:
>
> qemu-system-arm -machine mps2-an505 -cpu cortex-m33 \
>                 -m 16M \
>                 -nographic -serial mon:stdio \
>                 -device loader,file=3Dkernel.elf

(1) Tell us what QEMU version you're using.

(2) Give us the debug logs, by adding
 -D qemu.log -d
in_asm,exec,cpu,int,cpu_reset,unimp,guest_errors,nochain -singlestep

Your guest is probably crashing in early bootup, and the
only way to tell where is to debug it.

Also, your interrupt vector table is too short, because
you've only put in the first two entries (SP and reset PC).
This will result in unhelpfully confusing behaviour if
the CPU ever takes some other kind of exception.

thanks
-- PMM

