Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 899AD764FC1
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 11:29:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOx7L-0001Fo-P5; Thu, 27 Jul 2023 05:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nospam@kota.moe>) id 1qOx7G-00015b-9r
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 05:17:03 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nospam@kota.moe>) id 1qOx7D-0006qG-FK
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 05:17:02 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5839f38342fso7445687b3.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kota.moe; s=google; t=1690449413; x=1691054213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nj8QHqem1d1GbsBbw9uLi2jR9j+HzGDSggY9pO3H42E=;
 b=YMB55aG1MRI4nhXKs+yjxgTTmpZs6ibZh0cZE1dWfZjWp73yzsAHt9WA5/GeD4Va1w
 rBZxPdGD8zksV53P/AQY9MDH6u4QQvQXhrZP6jEW47JRJCTL9FOgANgsi5BRgLH26I8E
 vGtWXyulmBGAK1vqlyMxIz/rL4VevxLmHmdVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690449413; x=1691054213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nj8QHqem1d1GbsBbw9uLi2jR9j+HzGDSggY9pO3H42E=;
 b=Uo0HdbBkMGhDIz7CkZ5z1DsQHLLWXF+PuEYCZhI1An38+dzsPoU6VFLlDHIMW1uacw
 cmV0A1eSQ78k781N+PapGIzn9Jd7VJjfd22a1smhEncvrMwiLQnUL1LuXuf+0ZLpO/1P
 +D9wo5FO8rPIkj0L0rF8wLvj3TAmxSlE1RPqUhR2fLEiZJYEwMlK/U+7uUHI2uoxSPQH
 csxon595PrA/lY/1LufOPF2BDijmoLg9yP26CsDCaE3DXvGIJB4emd6lMVwBqlsBgZ4p
 rdEpoITPOg8aqOJH5cqibINzR0PM+/HXezwmGHYDDTqSKiegKllU5c9UklcDKZnmw7hO
 Q9TA==
X-Gm-Message-State: ABy/qLY2yYee/dLDy9W9vq/4GHRelpxcU8O8VjIMq9crlCxHUN0tXsMo
 bxDGlTJhmC+vsImkieuJadECf7WoweIafBd2u+P90w==
X-Google-Smtp-Source: APBJJlEeaxEgJg4otzfjbLZix9zH3qKMm8BbJoLaVUDz6qX/DE8R2FzWIvTNkuGxNMC1cCrQ4eANv2UchAb5Fl5ze4s=
X-Received: by 2002:a81:6dc9:0:b0:577:3d46:f90e with SMTP id
 i192-20020a816dc9000000b005773d46f90emr4602988ywc.32.1690449413542; Thu, 27
 Jul 2023 02:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230723185909.441455-1-nospam@kota.moe>
 <80dc2f6b-6cc7-c8fc-44c6-e6529c35d445@intel.com>
In-Reply-To: <80dc2f6b-6cc7-c8fc-44c6-e6529c35d445@intel.com>
From: =?UTF-8?B?4oCN5bCP5aSq?= <nospam@kota.moe>
Date: Thu, 27 Jul 2023 19:16:17 +1000
Message-ID: <CACsxjPZ6jJKn54xyK8waLgAaHa9-60qs5p0BqH0hX5ixH0GOdg@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Fix reporting of CPU dies when
 nr_cores=nr_threads=1
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, babu.moger@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=nospam@kota.moe; helo=mail-yw1-x1133.google.com
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

On Thu, 27 Jul 2023 at 11:25, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>
> On 7/24/2023 2:59 AM, =E5=B0=8F=E5=A4=AA wrote:
> > When QEMU is started with `-smp D,sockets=3D1,dies=3DD,cores=3D1,thread=
s=3D1` (that
> > is, 1 socket with D dies but each die contains just a single thread), b=
oth
> > Linux and Windows guests incorrectly interprets the system as having D
> > sockets with 1 die each
> >
> > Ultimately this is caused by various CPUID leaves not being die-aware i=
n
> > their "threads per socket" calculations, so this patch fixes that
> >
> > These changes are referenced to the AMD PPR for Family 19h Model 01h (M=
ilan)
> > and Family 17h Model 01h (Naples) manuals:
> >   - CPUID_Fn00000001_EBX[23:16]: Number of threads in the processor
> >                                  (Core::X86::Cpuid::SizeId[NC] + 1)
> >   - CPUID_Fn0000000B_EBX_x01[15:0]: Number of logical cores in processo=
r
> >                                     socket (not present until Rome)
> >   - CPUID_Fn80000001_ECX[1]: Multi core product
> >                              (Core::X86::Cpuid::SizeId[NC] !=3D 0)
> >   - CPUID_Fn80000008_ECX[7:0]: The number of threads in the package - 1
> >                                (Core::X86::Cpuid::SizeId[NC])
> >
> > Note there are two remaining occurences that I didn't touch:
> >   - CPUID_Fn8000001E_ECX[10:8]: Always 0 (1 node per processor) for Mil=
an.
> >                                 But for Naples, it can also be 2 or 4 n=
odes
> >                                 where each node is defined as one or tw=
o
> >                                 CCXes (CCD?). But Milan also has multip=
le
> >                                 CCXes, so clearly the definition of a n=
ode is
> >                                 different from model to model, so I've =
left
> >                                 it untouched. (QEMU seems to use the Na=
ples
> >                                 definition)
> >   - MSR_CORE_THREAD_COUNT: This MSR doesn't exist on Milan or Naples
>
> Is this patch specific to AMD CPU type? what's situation for Intel CPU?

I don't have a MCM Intel CPU to confirm against, but according to "Intel
Architectures Software Developer=E2=80=99s Manual":
 - 01h EBX[23:16]: Maximum number of addressable IDs for logical processors=
 in
                   this physical package
 - 0Bh EBX[15:0]: The number of logical processors across all instances of =
this
                  domain within the next higher-scoped domain. Note: The 0B=
h
                  leaf caps at the "core" domain, so Intel prefers using th=
e 1Fh
                  leaf instead which supports modules/tiles/dies/sockets. B=
ut
                  AMD doesn't support the 1Fh leaf yet
 - 80000001h ECX[1]: Reserved
 - 80000008h ECX: Reserved =3D 0
 - 8000001Eh: Unsupported
 - MSR_CORE_THREAD_COUNT[31:16]: The number of processor cores that are
                                 currently enabled in the physical package

So the changes seem compatible with Intel, though MSR_CORE_THREAD_COUNT sho=
uld
be updated to support dies as well. But in the absence of a MCM Intel CPU t=
o
test with, I don't feel comfortable making that change

