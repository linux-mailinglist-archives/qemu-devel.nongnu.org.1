Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 627737FB983
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 12:36:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7wN7-00056I-88; Tue, 28 Nov 2023 06:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7wN3-00054r-03
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 06:35:17 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7wMw-0007V1-Ah
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 06:35:16 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54b7ef7f4d5so2323341a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 03:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701171307; x=1701776107; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8oLUjrcYtg8cs13kkl75yFaPVI6wnMNwlZ8Sc8CMXr0=;
 b=pgbtYhfCK5vUnzOyEQqxOFl7T9DRHs3yIKieXaS8j5xQechu/Vk7rm11rLJqroWAh1
 ExkV9yT7KY2dr7RWsAIB+ChOzPGAhcY1ks8oUZbVne3YnKTnXL0jpw1kvHM+iykHQTLu
 NZxJyJyM+FLUZG/7z70oJ7vVZDP1I9NgO+z+QclXsz9pv/87NLuab1ZZz5kdqKQ1CPUG
 GlSUcOTcw9SZNwr4sdeO3lCPMNl3p3ZTjiynZ7GIzEcjvhfzeEO62BFz3Qa/BFHIjtqu
 N/mX32zj9QtImsTbws1u+CZf5U52hrGqfiZhhHNROETCKWAR3daEFTVyxqsH+gVGMhgm
 W5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701171307; x=1701776107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8oLUjrcYtg8cs13kkl75yFaPVI6wnMNwlZ8Sc8CMXr0=;
 b=Zbr8qo0vfNVlovtpxqj33aDaO9ajyT08EskWXC8IX61sjLK+JYhkm+1ZWcioYm8Qr+
 RJdRjV7NzQnkpOk/PfODWmcOCyn0Y0tHKh5rqKUKqlrLz6V2oyZKllTRN2HwVC0y/7Uu
 7edIXp6hy05MawogsrVwlQuvhovm215QProkg7F1FFMYLc5OH4kJlawgbx0303oinNa2
 6s+tSzcfcfZ4QDKqjRVUACWxL6QBkQNzKDsX5ZJ6hTQii775hweh8JEh8WiNj2Nxsv1M
 Ke54U213c3q8bZBQZQYhWprkYY/SWYy3P25MBdcko+Vxb9UyRlPVR/8cjt2IyBRFJGvm
 nA9Q==
X-Gm-Message-State: AOJu0YxLtYKJvfIX1sqvA7/Ke/2RHDRo1By8CaWVEpRB8TUbaptdbQCm
 LcIvwAQWV8Sig/aCnKYKiTtI0iTLeK9GXjwIhSL2bQ==
X-Google-Smtp-Source: AGHT+IHF1hLARiQlaOFV6cDP6l1MUyZoWMl1tTGXQkv2y4liWbkqzPXuhboDn/nDvoaLJHSCALpulEsW/eyVHbU07iE=
X-Received: by 2002:a50:d514:0:b0:54b:6d25:6969 with SMTP id
 u20-20020a50d514000000b0054b6d256969mr4706314edi.5.1701171306920; Tue, 28 Nov
 2023 03:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20191105234100.22052-1-beata.michalska@linaro.org>
 <20191105234100.22052-5-beata.michalska@linaro.org>
 <95cc7c22-939f-4ce0-aecd-d0ff7b0e7c9c@linaro.org>
In-Reply-To: <95cc7c22-939f-4ce0-aecd-d0ff7b0e7c9c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2023 11:34:55 +0000
Message-ID: <CAFEAcA-G7hbnRv52btWkpDs-1rgFqyVGgRVx-hG40i7zgsykaQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] target/arm: Add support for DC CVAP & DC CVADP ins
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, quintela@redhat.com, 
 dgilbert@redhat.com, shameerali.kolothum.thodi@huawei.com, 
 eric.auger@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 28 Nov 2023 at 11:24, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi,
>
> On 6/11/19 00:41, Beata Michalska wrote:
> > ARMv8.2 introduced support for Data Cache Clean instructions
> > to PoP (point-of-persistence) - DC CVAP and PoDP (point-of-deep-persist=
ence)
> > - DV CVADP. Both specify conceptual points in a memory system where all=
 writes
> > that are to reach them are considered persistent.
> > The support provided considers both to be actually the same so there is=
 no
> > distinction between the two. If none is available (there is no backing =
store
> > for given memory) both will result in Data Cache Clean up to the point =
of
> > coherency. Otherwise sync for the specified range shall be performed.
> >
> > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> > ---
> >   linux-user/elfload.c |  2 ++
> >   target/arm/cpu.h     | 10 ++++++++++
> >   target/arm/cpu64.c   |  1 +
> >   target/arm/helper.c  | 56 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   4 files changed, 69 insertions(+)
>
>
> > +#ifndef CONFIG_USER_ONLY
> > +static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaqu=
e,
> > +                          uint64_t value)
> > +{
> > +    ARMCPU *cpu =3D env_archcpu(env);
> > +    /* CTR_EL0 System register -> DminLine, bits [19:16] */
> > +    uint64_t dline_size =3D 4 << ((cpu->ctr >> 16) & 0xF);
> > +    uint64_t vaddr_in =3D (uint64_t) value;
> > +    uint64_t vaddr =3D vaddr_in & ~(dline_size - 1);
> > +    void *haddr;
> > +    int mem_idx =3D cpu_mmu_index(env, false);
> > +
> > +    /* This won't be crossing page boundaries */
> > +    haddr =3D probe_read(env, vaddr, dline_size, mem_idx, GETPC());
> > +    if (haddr) {
> > +
> > +        ram_addr_t offset;
> > +        MemoryRegion *mr;
> > +
> > +        /* RCU lock is already being held */
> > +        mr =3D memory_region_from_host(haddr, &offset);
> > +
> > +        if (mr) {
> > +            memory_region_do_writeback(mr, offset, dline_size);
> > +        }
> > +    }
> > +}
>
>
> > +#ifndef CONFIG_USER_ONLY
> > +    /* Data Cache clean instructions up to PoP */
> > +    if (cpu_isar_feature(aa64_dcpop, cpu)) {
>
> Am I correct understanding this is a TCG-only feature?

For KVM, whether the vCPU implements these cache
maintenance instructions is up to it -- like all insns,
QEMU doesn't ever see if the guest executes them or not
(either the host CPU just implements them, or the host
kernel traps and handles them). The code in this patch is
specifically for the QEMU TCG emulation of them.

thanks
-- PMM

