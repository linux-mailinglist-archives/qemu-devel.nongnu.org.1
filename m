Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5334A76B7EC
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 16:46:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQqcV-0007B8-Gd; Tue, 01 Aug 2023 10:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQqcS-0007An-JK
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 10:45:04 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQqcQ-0006D7-Vy
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 10:45:04 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51bece5d935so8241707a12.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690901101; x=1691505901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fI/utFtZvmCMqFWeUiqwvkWlQhA9XgSuWD+cHUDyR1E=;
 b=I7N4w0N0a7B3OID2dRxjJwr0XxB+sHgmLBqTnlogcEFSwskv+9Mlld2r7UYgD7Tj6c
 0gtpAUPtCXOADF5rxtXgp1LEkON48nHzuCZgjSee6OFZbvy3i8YT178QcsYsw/RvI3IH
 YVuE4gbwLcvDBqXv7Ml4BrJ5EZtRGwMoVPs39Q/SkuckoTk78QDt+c08OS41lgs4yx41
 5rmyz0MkbTSXiWxPwOyPXHuOHwRRy2RWqP9i/wCeph6JycXhlAl4qJ8dSjhlqN8gbQTY
 t69yhwWPZRIpWvuTvM48Y7SrF884oHkIQtWh0bAGDOTuH/rfuTP6SCruIOA1KtGHB/CX
 B8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690901101; x=1691505901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fI/utFtZvmCMqFWeUiqwvkWlQhA9XgSuWD+cHUDyR1E=;
 b=fvF+v8gNK2gsIINbn0QBN+6aXG3lOgWMm69QUn+kATwSO5gfWE4wt1Sj1ByV27dMTL
 zzu9kJq4PtPJjZaOw1jJGqE3L++IFl0VW6MhXxZIZdRUUd8Bium2GLwN1/wmX7KvjmyT
 iz+YBFhC+dpEhL+Ccpy8TAn3sirHoEpYQofzswfs3irxT9X9KrxhK3IXELQAEM0VBVuc
 XfCwcBls8u9i5PXfrquNln/H/qbxFCTLh9HNYz337+PJ7yrkjwbbyt2hUjTER02YkUkt
 ZEZslUQ2NyoiULnzxNC7IBDxXojR2mdEwxrf0e8MaNb85krm/+PXW7j9eWiTac1ni+Ur
 /GeQ==
X-Gm-Message-State: ABy/qLavCwcvToKwPElkN5vBxP70G4/l//LziyiNlqdcP5om6q3Eu8S+
 ltrg3klx34hI/MP+dZ81H8v9Rbjhuhr3Fm/7C9JjvA==
X-Google-Smtp-Source: APBJJlGFZiNjcJdyKRjBR2KK4jDOO3XBJbnOriY56P6y2e5MrHv5dp+I910ZUHZgvXJ2qU5p+8KGbMKA5u25CKz0QQQ=
X-Received: by 2002:a50:ec94:0:b0:522:37da:7920 with SMTP id
 e20-20020a50ec94000000b0052237da7920mr2697272edr.12.1690901101172; Tue, 01
 Aug 2023 07:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <ZMkPRJ3subSuW+Rg@p100>
 <CAFEAcA8cEp2_vc0i9QMNeb7KkxsJecXjuYhYUR6nkL6-LLyFqw@mail.gmail.com>
 <02f59869-fca4-4c8b-fc52-0073fb0ef8f9@gmx.de>
In-Reply-To: <02f59869-fca4-4c8b-fc52-0073fb0ef8f9@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2023 15:44:50 +0100
Message-ID: <CAFEAcA9Q2RSYMR_6e7rHMQxgaCbL638DOBPwHpQYh+kXrOwmbw@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Emulate /proc/cpuinfo on aarch64 and arm
To: Helge Deller <deller@gmx.de>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 1 Aug 2023 at 15:41, Helge Deller <deller@gmx.de> wrote:
>
> On 8/1/23 16:22, Peter Maydell wrote:
> > On Tue, 1 Aug 2023 at 14:57, Helge Deller <deller@gmx.de> wrote:
> >>
> >> Add emulation for /proc/cpuinfo for arm architecture.
> >> The output below mimics output as seen on debian porterboxes.
> >
> >
> >> +#if defined(TARGET_AARCH64) || defined(TARGET_ARM)
> >> +static int open_cpuinfo(CPUArchState *cpu_env, int fd)
> >> +{
> >> +    int i, num_cpus;
> >> +    const int is64 = TARGET_ABI_BITS == 64;
> >> +
> >> +    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> >> +    for (i = 0; i < num_cpus; i++) {
> >> +        dprintf(fd, "processor\t: %d\n", i);
> >> +        if (!is64) {
> >> +            dprintf(fd, "model name\t: ARMv7 Processor rev 2 (v7l)\n");
> >> +        }
> >> +        dprintf(fd, "BogoMIPS\t: %d.00\n", is64 ? 100 : 50);
> >> +        dprintf(fd, "Features\t: %s\n",
> >> +                is64 ? "fp asimd evtstrm cpuid"
> >> +                     : "half thumb fastmult vfp edsp thumbee vfpv3 " \
> >> +                       "tls idiva idivt vfpd32 lpae");
> >> +        dprintf(fd, "CPU implementer\t: 0x%d\n", is64 ? 50 : 56);
> >> +        dprintf(fd, "CPU architecture: %d\n",    is64 ? 8 : 7);
> >> +        dprintf(fd, "CPU variant\t: 0x%d\n",     is64 ? 0 : 2);
> >> +        dprintf(fd, "CPU part\t: 0x%d\n",        is64 ? 0 : 584);
> >> +        dprintf(fd, "CPU revision\t: %d\n\n",    is64 ? 1 : 2);
> >
> > If you want to do this you should hook it up to what the
> > CPU being emulated actually is and what features it has.
> > (Compare how we set the hwcaps.)
>
> Nice!
> I didn't know about those elf hwcaps...

In an ideal world guest code should only look at the
hwcaps (which are the ABI-stable interface the kernel
provides), not at what's in /proc/cpuinfo. But of
course if you're a shell script then cpuinfo is a lot
easier to deal with...

thanks
-- PMM

