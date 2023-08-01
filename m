Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEDC76B74D
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 16:24:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQqGu-0005qb-6P; Tue, 01 Aug 2023 10:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQqGs-0005q7-6e
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 10:22:46 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQqGq-0004tZ-FR
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 10:22:45 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fe10f0f4d1so9444645e87.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690899763; x=1691504563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+kuX/EChX1xOdMZ2LS/4H20RD3DMHGuUOy1vmhdta0=;
 b=ZCEtL9l05AhGAU4KzxDAFuV7yifKF+sSoMYAm1qMrK8d939RFv96GZey6Lp8Don+vp
 nXyL1wfVAiakUXGy+5vucAeA9Ty8oJQ3i3tucsHv86ZrdMsk0f99m/rY3Ox4qdt/kMkr
 vgV0XCZ0TxGLOpa1WxKNIRt4XRb4N8ZINMOilSaJDRIBnEDBVrfnJFAjW3HjSlno2Vg2
 i2H2TjEHLkK24MAGPjl9+/6hwrRkM1K8u97dC5/wqqrFMnOEiLNa2M6RZbIIJIaSwRgj
 VRmskaDojB1LqcNMk4Z7M1ov8LERxQAur6n2RLl2vqnTTo5FCGIGFBT6M4DF8MJXiXB+
 lSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690899763; x=1691504563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q+kuX/EChX1xOdMZ2LS/4H20RD3DMHGuUOy1vmhdta0=;
 b=CaW/Rm13LrHaw6GnGdmLdRvC9PpyZK5/eISPcvq8OiJCvWS7yGh+x1On9pyjvXf/Uw
 5oTEC7M5enEyA2fC01jQUjH5XPVjOk8CijQSD2I5hCvp15JwEycPzLGXd6Glhje477rD
 cafApwb46DgM08iR3L3R864TQEsDE9s0A5cTQkZsGY6F1cVc1rbO0EB87TNijiBdsA3h
 Isvgk1U4S9EyF5d4INd5tqonzkqNWYhfmU6ywu691Mx0ya0aVQ9IZxfM+oIZHy01a2Nt
 FDYlBT3i8bm0PFXIxjI3zhmoL136FbFJSybw4ERyECzHD4cpKaCs9WDWqt1TZdK097xI
 4qsg==
X-Gm-Message-State: ABy/qLZrsW3x+gR3cck5iD/1/nNShRkOvcV4xwmj7I1UhFH9Ht3bk92M
 aWoDeb422qQIqLg4+MYScrgfhRkSFVgutxmF/Lii1g==
X-Google-Smtp-Source: APBJJlFbj25SejFnAAhFZw1UnhWYzT30hqVym47zXFVK9GlSOifqNeHm8Fgwr9Lfq3D+XirlAYyZBx4z43RyCYB+F4k=
X-Received: by 2002:ac2:47ea:0:b0:4fe:3a2f:681 with SMTP id
 b10-20020ac247ea000000b004fe3a2f0681mr1873949lfp.23.1690899762628; Tue, 01
 Aug 2023 07:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <ZMkPRJ3subSuW+Rg@p100>
In-Reply-To: <ZMkPRJ3subSuW+Rg@p100>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2023 15:22:31 +0100
Message-ID: <CAFEAcA8cEp2_vc0i9QMNeb7KkxsJecXjuYhYUR6nkL6-LLyFqw@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Emulate /proc/cpuinfo on aarch64 and arm
To: Helge Deller <deller@gmx.de>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

On Tue, 1 Aug 2023 at 14:57, Helge Deller <deller@gmx.de> wrote:
>
> Add emulation for /proc/cpuinfo for arm architecture.
> The output below mimics output as seen on debian porterboxes.


> +#if defined(TARGET_AARCH64) || defined(TARGET_ARM)
> +static int open_cpuinfo(CPUArchState *cpu_env, int fd)
> +{
> +    int i, num_cpus;
> +    const int is64 = TARGET_ABI_BITS == 64;
> +
> +    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +    for (i = 0; i < num_cpus; i++) {
> +        dprintf(fd, "processor\t: %d\n", i);
> +        if (!is64) {
> +            dprintf(fd, "model name\t: ARMv7 Processor rev 2 (v7l)\n");
> +        }
> +        dprintf(fd, "BogoMIPS\t: %d.00\n", is64 ? 100 : 50);
> +        dprintf(fd, "Features\t: %s\n",
> +                is64 ? "fp asimd evtstrm cpuid"
> +                     : "half thumb fastmult vfp edsp thumbee vfpv3 " \
> +                       "tls idiva idivt vfpd32 lpae");
> +        dprintf(fd, "CPU implementer\t: 0x%d\n", is64 ? 50 : 56);
> +        dprintf(fd, "CPU architecture: %d\n",    is64 ? 8 : 7);
> +        dprintf(fd, "CPU variant\t: 0x%d\n",     is64 ? 0 : 2);
> +        dprintf(fd, "CPU part\t: 0x%d\n",        is64 ? 0 : 584);
> +        dprintf(fd, "CPU revision\t: %d\n\n",    is64 ? 1 : 2);

If you want to do this you should hook it up to what the
CPU being emulated actually is and what features it has.
(Compare how we set the hwcaps.)

> +    }
> +    return 0;
> +}

thanks
-- PMM

