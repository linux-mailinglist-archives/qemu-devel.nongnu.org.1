Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 517A27147E5
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 12:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3a6Z-0004sw-1d; Mon, 29 May 2023 06:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3a6S-0004pn-EZ
 for qemu-devel@nongnu.org; Mon, 29 May 2023 06:27:52 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3a6O-0007T3-Oi
 for qemu-devel@nongnu.org; Mon, 29 May 2023 06:27:52 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-514859f3ffbso3670908a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685356065; x=1687948065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vJNgW7Vc6NDnBKEQWZLCi+QAbMD7KTMTqInMEGtIc9c=;
 b=hemSZS+FE94+6En8EsFpBjhKr0XJ5fxgcWv0hM1OkLGAiNyY1P0lve9y0F0JP7PHXT
 S6X07r0pYClwXvcgG3O6euQvCIL2pGCLzv0Kjv2DThAPG36mrISWiOLtpprqQdtH9vBc
 DANp2xL5ve7VwVjHVUKHHAB/epE6wG/jJiK9BMCXVqDmJRDrYWTulZp9PK8l2WtCWre7
 wMVj6j7RogqSKERJ4rtP3n8cBQn6KWcPYi3lL08rzR/cXh5lUp5ftSu/JzowAQ3dGqP0
 7mU+Gw70zM12aXi0X43cbbnsdf5g9f5WALRAnLZMZ//B64MzUfJ4fHeQ/X9IrIOqDqWH
 0WwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685356065; x=1687948065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vJNgW7Vc6NDnBKEQWZLCi+QAbMD7KTMTqInMEGtIc9c=;
 b=VO1ADbOoAmtENV8fJdgUC9I9MmrvCMpUnHDvcgLKnd8SaXkXZYCpM+GFN//K64pzE8
 uMtdkFJs9cFwvKmKM//MRo2OrSpgOW5iZ5Tuhf/vaC4vzteUUcm+p8TEqpzrztZqLy05
 JAWeRO0CA5RMeMagYDo38vLyzHFB+Wv3olVspjtXmIxyjbR0V73KK88d44ka9+cWPtO1
 8Zu4ojUM7ywr3sJt46xvGO7qxv3M5pWErEK9xFtPX5p5I8gbn5+OL26Qlt/Fo2mYBfPN
 xV8U+ozUrPWsh4bGs8PVkI5D5OWH2dUXLbDB4XRkitiKVVLIvFMlIwMfrpkBvY6gRKT1
 cfgQ==
X-Gm-Message-State: AC+VfDytFOxWHEtJbTSimkQNEG+XKFO3afrKXYyj8WNJzNzud4PQ9C9f
 3ILJP/6XbifFPkvx9gsdCDPhRZzgQ37KRT5qrlxDLw==
X-Google-Smtp-Source: ACHHUZ65b6H40DUcBRg92a782Wc4ej9j+Qx5ZWA9ctSXo/ezzQFGGpzVlweWY4A5ZJTOf1SDBsWEVrVqepshf31hp2U=
X-Received: by 2002:a05:6402:657:b0:50d:b16d:d21 with SMTP id
 u23-20020a056402065700b0050db16d0d21mr7201385edx.3.1685356064872; Mon, 29 May
 2023 03:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230428095533.21747-1-cohuck@redhat.com>
 <87v8gkzi5v.fsf@redhat.com>
 <CABJz62MGU-49Ucs-CYsd2hdH8mejWtjXXBNcbs92Kx+V=T2EwA@mail.gmail.com>
In-Reply-To: <CABJz62MGU-49Ucs-CYsd2hdH8mejWtjXXBNcbs92Kx+V=T2EwA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 May 2023 11:27:15 +0100
Message-ID: <CAFEAcA-vFQRGsD0emmCwMfyVMd2YGhZL-k_U5x63=G9JaLo=GQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/1] arm: enable MTE for QEMU + kvm
To: Andrea Bolognani <abologna@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Eric Auger <eauger@redhat.com>, 
 Juan Quintela <quintela@redhat.com>, Gavin Shan <gshan@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 29 May 2023 at 11:15, Andrea Bolognani <abologna@redhat.com> wrote:
>
> On Mon, May 22, 2023 at 02:04:28PM +0200, Cornelia Huck wrote:
> > On Fri, Apr 28 2023, Cornelia Huck <cohuck@redhat.com> wrote:
> > > Another open problem is mte vs mte3: tcg emulates mte3, kvm gives the guest
> > > whatever the host supports. Without migration support, this is not too much
> > > of a problem yet, but for compatibility handling, we'll need a way to keep
> > > QEMU from handing out mte3 for guests that might be migrated to a mte3-less
> > > host. We could tack this unto the mte property (specifying the version or
> > > max supported), or we could handle this via cpu properties if we go with
> > > handling compatibility via cpu models (sorting this out for kvm is probably
> > > going to be interesting in general.) In any case, I think we'll need a way
> > > to inform kvm of it.
> >
> > Before I start to figure out the initialization breakage, I think it
> > might be worth pointing to this open issue again. As Andrea mentioned in
> > https://listman.redhat.com/archives/libvir-list/2023-May/239926.html,
> > libvirt wants to provide a stable guest ABI, not only in the context of
> > migration compatibility (which we can handwave away via the migration
> > blocker.)
>
> Yeah, in order to guarantee a stable guest ABI it's critical that
> libvirt can ask for a *specific* version of MTE (MTE or MTE3) and
> either get exactly that version, or an error on QEMU's side.
>
> > The part I'm mostly missing right now is how to tell KVM to not present
> > mte3 to a guest while running on a mte3 capable host (i.e. the KVM
> > interface for that; it's more a case of "we don't have it right now",
> > though.) I'd expect it to be on the cpu level, rather than on the vm
> > level, but it's not there yet; we also probably want something that's
> > not fighting whatever tcg (or other accels) end up doing.
> >
> > I see several options here:
> > - Continue to ignore mte3 and its implications for now. The big risk is
> >   that someone might end up implementing support for MTE in libvirt again,
> >   with the same stable guest ABI issues as for this version.
> > - Add a "version" qualifier to the mte machine prop (probably with
> >   semantics similar to the gic stuff), with the default working with tcg
> >   as it does right now (i.e. defaulting to mte3). KVM would only support
> >   "no mte" or "same as host" (with no stable guest ABI guarantees) for
> >   now. I'm not sure how hairy this might get if we end up with a per-cpu
> >   configuration of mte (and other features) with kvm.
> > - Add cpu properties for mte and mte3. I think we've been there before
> >   :) It would likely match any KVM infrastructure well, but we gain
> >   interactions with the machine property. Also, there's a lot in the
> >   whole CPU model area that need proper figuring out first... if we go
> >   that route, we won't be able to add MTE support with KVM anytime soon,
> >   I fear.
> >
> > The second option might be the most promising, except for potential
> > future headaches; but a lot depends on where we want to be going with
> > cpu models for KVM in general.
>
> What are the arguments for/against making MTE a machine type option
> or CPU feature flag? IIUC on real hardware you get "mte" or "mte3"
> listed in /proc/cpuinfo, so a CPU feature would seem a pretty natural
> fit to me, but I seem to recall that Peter was pushing for keeping it
> a machine property instead.

The arguments for a machine property are:
 * MTE needs not just CPU support but also system level support
   (on real hardware there needs to be actual tag ram somewhere
   out there in the system; for TCG we need to create the tag
   RAM in the virt board code)
 * it's what we're already doing for TCG, so it keeps the UI
   consistent between TCG and KVM
 * it's what we already do for things like the virtualization
   extensions and TrustZone emulation (which also generally need
   to be supported not just by the CPU but also by the board)

thanks
-- PMM

