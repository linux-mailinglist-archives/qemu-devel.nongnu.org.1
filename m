Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B738582DDDD
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 17:47:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPQ7P-0004kN-Pr; Mon, 15 Jan 2024 11:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPQ7O-0004kE-1Q
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:47:22 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPQ7M-0008VU-3z
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:47:21 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55976b32185so244746a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 08:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705337238; x=1705942038; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HKTubv46a1c9PtP8lA6lkJVHEeFmP1Cu2GL8FlU9pJk=;
 b=jcioKTPvxJ05ZU6HT2D40vz7GyqrhskmRlAO7DReoo4IFNXNyu2GtqSUf0bbRz+D1Y
 rcbSc1skeonUQ2pouG0P+HdHd3gh/jMWfQvw4Sfpnr2fbJdK2KloDuZmRhfiAI7v7el9
 xAC7jkpzjG+pMmk4QukCecA1S+ftOZBpk5qbPhiXatOdQ2HAkqtRxpG2ZxPyhWEVmuta
 IuXq9Qt5EmZgqxqMbGnWxostxNB76kEZqe9IQ4vmWp9AVBkaMWc+mbyINqxqk4pvek9V
 hITpCunOHvA75MhN8/Om6zoXRL8FAv+SQ53mmMuGu278xJyPoocAPGVW0hcXVL6ZZDVz
 81Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705337238; x=1705942038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HKTubv46a1c9PtP8lA6lkJVHEeFmP1Cu2GL8FlU9pJk=;
 b=Ivo0UNA+F0Wlh/d57vzUfWKJyPtxa6fiDDTdh4SeUPZAwXik5e/u6CYafFmBOoPPu6
 CzLh397KFz40kPzyOEJC3qgaLpFuijXYryAS1rnsMEKbqfGeoWODx1QDnGtEz9C3uTUa
 Aif8YOdeff+duE1ZQjeNHFP3+gBlmcV9T/CMuic4VWrew+o46n7BopwC0y8gBuiJtNn5
 L3YV9vpf9hrY4Oy8zVKiuUAeLiVmtPZA+AY4ezuD+aQGEh24BCUdKsrQpBbYkgHcBZVX
 rQImoZHIngNhgOfpnhbMyfdaS4Zdh+kdO/u7WgwnduNtw4fTcz7Ku//PgVuACrw/g4/r
 yleQ==
X-Gm-Message-State: AOJu0YwhdNaIVxcU5RwBqaw1f9lZoD3qIsRlAL1vKbdyrw6ccRSTN2G/
 ze5q7rXG0iFTWNvK7rPNQDFnUtvGr/AX9Hm3pItGzqavMv6j9w==
X-Google-Smtp-Source: AGHT+IEzRXaKqaxrowTYJDg55mEHaeflHEt4s69AJpHcXcFlFPtT/kIHwBfimlJRpJ6sBJWdqbf9wieubxh8Jf0Kx7Q=
X-Received: by 2002:a05:6402:312a:b0:559:7030:a2a7 with SMTP id
 dd10-20020a056402312a00b005597030a2a7mr391454edb.27.1705337238298; Mon, 15
 Jan 2024 08:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20240109124333.224240-1-shlomop@pliops.com>
 <CAFEAcA9WYrhuokJ_ox5CH0Et+WxiB_dwfHtsTZCb9cCfAveL9w@mail.gmail.com>
 <CAHzK-V2E8EQsh9V2tdqrEF651dPJchA9yLAzrFjFjun1tC8nKg@mail.gmail.com>
 <CAFEAcA-fFRSf2ndOwANjByUCyp0Z_rqjdQgoSHFKumz2041c8g@mail.gmail.com>
 <f20db31b-8f10-6a8d-bb2a-fdc269d6776a@gmail.com>
In-Reply-To: <f20db31b-8f10-6a8d-bb2a-fdc269d6776a@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 16:47:06 +0000
Message-ID: <CAFEAcA_x4CyQ0wF7-x-4oq4OUYsuJcbL3xLrz3D0cmWYmfs75w@mail.gmail.com>
Subject: Re: [PATCH V2] Handle wrap around in limit calculation
To: Shlomo Pongratz <shlomopongratz@gmail.com>
Cc: qemu-devel@nongnu.org, andrew.sminov@gmail.com, peter.maydell@linaro.com, 
 shlomop@pliops.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 15 Jan 2024 at 13:51, Shlomo Pongratz <shlomopongratz@gmail.com> wrote:
>
> On 15/01/2024 12:37, Peter Maydell wrote:
> > For instance, the kernel code suggests that pre-460A
> > there's a 32 bit limit register, and post-460A there
> > is a 64-bit limit (with an "UPPER_LIMIT" register to
> > access the top 32 bits), plus a PCIE_ATU_INCREASE_REGION_SIZE
> > flag bit. That suggests we might either:
> >   (1) implement all that
> >   (2) say we're implementing a pre-460A version with a
> >       32 bit limit field
> > Presumably we're aiming for (2) here, but I find the
> > arithmetic you have in this patch completely confusing:
> > it doesn't look like something hardware would be doing
> > when it has a 64 bit base address register and a 32 bit limit
> > address register. It's also weird as C code, because you
> > add 0x100000000 when calculating tlimit, but this will
> > have no effect because of the AND with 0xffffffff in
> > the following line.
> >
> > My guess at what the hardware is doing is "the actual
> > limit address takes its low 32 bits from the limit address
> > register and the high 32 bits from the high 32 bits of
> > the base address".

> The original code which claims to be based on i.MX6 Applications Processor
> actually fails for the example given there in page 4131 where the lower
> is set to 0xd0000000
> the upper to 0x8000000 and the limit to 0xd000ffff which gives us a size
> of 0x8000000000010000,
> which is a negative number. Therefore some fix need to be done.

Ah, I hadn't realised that this PCI controller was documented
in the i.MX6 applications processor reference manual. Looking
at that I see that the "upper base address register" is documented
as "Forms bits [63:32] of the start (and end) address of the address
region to be translated". That "(and end)" part confirms my
guess that the 64-bit limit address is supposed to be formed by
putting together the upper-base-address with the limit value.

> Your suggestion solve this issue and gives the correct address even if
> the addresses are translated by for example by a multiple of 4G, e.g
> 0x200000000,
> but it won't work if the range is translated in a way that is cross 4G
> boundary (e.g. translate by 0x2ffff000).
>
> After reviewing the mathematics I've found a solution which to my
> humiliation is more simple and it is likely that the HW
> is doing it, and this is just to ignore the high 32 bits of the
> calculation's result. That is:
> const uint64_t size = ((uint64_t)viewport->limit - base + 1) & 0xffffffff;

That gives the wrong answer for the case where the limit register
is set to 0xFFFF_FFFF (it will give you 0 rather than 0x1_0000_0000).

I think my suggestion is:

   uint64_t base = viewport->base;
   uint64_t limit = viewport->limit;
   uint64_t size;

   /*
    * Versions 460A and above of this PCI controller have a
    * 64-bit limit register. We currently model the older type
    * where the limit register is 32 bits, and the upper 32 bits
    * of the end address are the same as the upper 32 bits of
    * the start address.
    */
   limit = deposit64(limit, 32, 32, extract64(base, 32, 32));
   size = limit - base + 1;

That's a fairly clear implementation of what the docs say the
behaviour is, and it gives us a nice easy place to add 64-bit
limit register support if we ever need to (by guarding the setting
of 'limit' with an "if 64-bit limit registers not enabled" check).

thanks
-- PMM

