Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 398D37F08CF
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 21:20:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4oGW-00038s-MZ; Sun, 19 Nov 2023 15:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4oGV-00038e-53; Sun, 19 Nov 2023 15:19:35 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4oGT-0000DL-Ks; Sun, 19 Nov 2023 15:19:34 -0500
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-77a453eb01cso249467285a.0; 
 Sun, 19 Nov 2023 12:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700425172; x=1701029972; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=toP+qbVrREpGudIghfFr3/qdKElUphH+SaeFRoysiu0=;
 b=b7D89z7kvLXSx2muPOgLa3KKeE9WuaPikh+90WgOVNtro0fIMUu2ZmKrtE9Oi30yWP
 93o7fKychI7D9DGcDxSHfW1utvmha2EY2/z4NdT0A2Ww1dpyFYSdhtS2V4ZHGXAp950x
 THGEpQBEJ1zknq/5lIqXN70RWyvKQKA80rQ9x1EI31qYr2c0P02amP27vxT1M9hebZIf
 R9uYXuaKMXVBJwDtt3GcTA8k6NAgVUwo05Gn/RT21N6zaMygIEihBW8kAOsz5z1fzQUk
 SaBsiBKRp8CDgBju5gIj/pAUu7Nmuaq6XTYMOlFxyXrZqnWdg3cNzrwQqG2Qh087mB3/
 1HTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700425172; x=1701029972;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=toP+qbVrREpGudIghfFr3/qdKElUphH+SaeFRoysiu0=;
 b=QiS3vFw4FyzGxn6mXX1FhU2PHorMLU1Mpb4/gDlWRmZwGM7OXbXsOkXmtHC8b0rtRL
 J0GzQgwJGFiChg63TAZn054pixG93LFQE/lfSoJD0FHUDf8PTrv6kdBm623xeMqwy6vh
 jdrGhn4dWO8DHR1pLbgjX+92U4skiDlgugNa+SDarqRnTfuy7yTQDhJCBrnQWL3rwtrj
 j1TNoG3Hn+iHg9phlkpi1YlUXMJoBkdmayQyuTEwT1SrtQZR1vYVgeTat07YVRRP9rkK
 HqXPM5H0K/SM8zdz+ZhuXWAl7Pp9c4nwpw335UNRF/2y7T6QcOOsrwDOnF3/jQk1x+x0
 D1Tg==
X-Gm-Message-State: AOJu0Yxy5L4e6x8JGr5WKYnpigTpYMB/5mDL0N8hyuEmOm3wkfdgzIuA
 oV4SMhAyBQ/USETt09B4nJiouErIFhwos9xjRe0=
X-Google-Smtp-Source: AGHT+IHzUpckRwA4eAvcQ29vnlBWSbZQwLBLoEmYpNWNoACmpPTN16kArHQrVxoOX6c3Kwf7/z8Fz6ot2j+rxhBA65M=
X-Received: by 2002:ac8:5a45:0:b0:41c:dd22:e7bf with SMTP id
 o5-20020ac85a45000000b0041cdd22e7bfmr8110955qta.42.1700425172247; Sun, 19 Nov
 2023 12:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20231118182531.2619772-1-dhoff749@gmail.com>
 <20231119022223-mutt-send-email-mst@kernel.org>
 <CAFXChKJGE92WEfOWsE0=eSfSM55abCA4baOsoPE8V--iWU1GGg@mail.gmail.com>
 <20231119150225-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231119150225-mutt-send-email-mst@kernel.org>
From: Dan Hoffman <dhoff749@gmail.com>
Date: Sun, 19 Nov 2023 14:19:25 -0600
Message-ID: <CAFXChKJ5-QEG+9Jsd6ZjkHJtssB0UdKS2Uy2iq1DMPjucuwUfA@mail.gmail.com>
Subject: Re: [PATCH] hw/i386: fix short-circuit logic with non-optimizing
 builds
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=dhoff749@gmail.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Clang 16.0.6

I can re-submit with the compiler and version if that helps.

On Sun, Nov 19, 2023 at 2:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Nov 19, 2023 at 11:03:54AM -0600, Dan Hoffman wrote:
> > On Sun, Nov 19, 2023 at 1:23=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Sat, Nov 18, 2023 at 10:25:31AM -0800, Daniel Hoffman wrote:
> > > > `kvm_enabled()` is compiled down to `0` and short-circuit logic is
> > > > used to remmove references to undefined symbols at the compile stag=
e.
> > > > Some build configurations with some compilers don't attempt to
> > > > simplify this logic down in some cases (the pattern appears to be
> > > > that the literal false must be the first term) and this was causing
> > > > some builds to emit references to undefined symbols.
> > > >
> > > > Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
> > >
> > > Could we add a bit more detail here? Will help make sure
> > > this does not break again in the future.
> >
> > The configuration script was ran as such:  ../configure
> > --without-default-features --target-list=3Dx86_64-softmmu,i386-softmmu
> > --enable-debug --enable-tcg-interpreter --enable-debug-tcg
> > --enable-debug-mutex
> >
> > I'm pretty sure the only relevant flags here are
> > --without-default-features, --target-list including x86_64-softmmu and
> > --enable-debug
> >
> > The only error I see is this: [...]/hw/i386/x86.c:422:(.text+0x1004):
> > undefined reference to `kvm_hv_vpindex_settable' (the other
> > kvm_enabled() was moved for the sake of consistency). My compiler is
> > clang (16.0.6).
> >
> > I haven't looked into the heuristics or logic for how the compile-time
> > short-circuit logic works, but I assumed only the first parameter is
> > "guaranteed" to be checked for a literal false (guaranteed is in
> > quotes because that's just how clang works, not because it's a feature
> > of the language IIRC).
> >
> > This pattern relies on somes subtle behavior with the compiler, so my
> > suggestion going forward would be to not rely on code optimizations
> > removing undefined references based on short-circuit logic (instead
> > have some configuration macro defined that disables all relevant
> > code). I'm a new contributor, so I submitted the minimum to make it
> > work on my machine.
> >
> > If you have any other questions, please let me know.
> >
> > Thanks!
>
> which compiler is this?
>
> --
> MST
>

