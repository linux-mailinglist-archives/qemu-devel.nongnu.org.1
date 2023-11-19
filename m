Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 536797F08E4
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 21:43:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4ocW-0008Mk-4z; Sun, 19 Nov 2023 15:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4ocU-0008MY-Jf; Sun, 19 Nov 2023 15:42:18 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4ocT-0004Hg-16; Sun, 19 Nov 2023 15:42:18 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1ef36a04931so2357637fac.2; 
 Sun, 19 Nov 2023 12:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700426535; x=1701031335; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsO9DcxY6YOIubMhRfSb8f/AMwczpb2vl9qQ1ISj1QI=;
 b=D24BHL8Y8hLJVKuz8Xtei4fVeGJz2gfvtqL3od1FZLx6zxRqN4/eZVY7n/PQXQbCeQ
 bSuWkTrCau1Kb9ky+TcWHQcrhDYbmSFVcgZC347DO/duK6jygCJSL5/3WvrdfXeZxFXH
 6Swe5U8QmJxBzi+L4syZ/UVYltAP9wZOxpAEFGm6/hrwXMa3BB9ZemL4TTzpXzdqzPwO
 scg7e71Gs9lCURar6W1EvLEtUl2LU5jUMoseX+RuemBLRXB/Xkz7CUeSnS6XzRAMiXLJ
 TCGNZ7izPGH1tTnUvLv63JsnQrBM67J4D9kGFPzpauKqAzfym+TGealBonpJgE3mwSkJ
 o6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700426535; x=1701031335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bsO9DcxY6YOIubMhRfSb8f/AMwczpb2vl9qQ1ISj1QI=;
 b=IWjgpyQYCjVER56pdOVC0bzXNQNkGSUNKdidOmMx5DiWJyXqY57SL7hnkP662eNNjd
 muSImH7TbvupjmKZd6gDimBWjFHa9j8N3HJfR0QILIRYms9S5ABq2d/tpC/cZIM2cP0J
 wy0XiPqBXS+15Z6CcvrIaOn0zB/VdxwMFBTx6QKy5t41SS67EuCXgeXyajlBxeo659/u
 Xh3Puvf2+yBo7qg/hohptlBubQNkZY6pL26PeyVJmTgPWtTal+L/H0haUCSmKIj8rOTo
 wMTwG+IuxlJZp5pCLRUPaSCiGp4IFhirBthz9ZkNhyVvdoEgkhXDqD6+WWjE7OqfhgP8
 ZiIw==
X-Gm-Message-State: AOJu0YxRvtnIaEmObqcCWLjyFNiZptpHDwIh2V80NWgnFyWsnM3IeYcb
 kHnHZ0RdQeA3Yf3GKPNzB+Upezwp/WJU+V+9Hc8=
X-Google-Smtp-Source: AGHT+IHirFydcEHpupQpwTowD6GekIp4CIRD9AVgGLEAtwhxWJ4zYg+dE6ytU0SRbzEArY78r6CNselxt4JezfDW9gM=
X-Received: by 2002:a05:6871:522a:b0:1e9:faca:bd1d with SMTP id
 ht42-20020a056871522a00b001e9facabd1dmr7467794oac.24.1700426535156; Sun, 19
 Nov 2023 12:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20231118182531.2619772-1-dhoff749@gmail.com>
 <20231119022223-mutt-send-email-mst@kernel.org>
 <CAFXChKJGE92WEfOWsE0=eSfSM55abCA4baOsoPE8V--iWU1GGg@mail.gmail.com>
 <20231119150225-mutt-send-email-mst@kernel.org>
 <CAFXChKJ5-QEG+9Jsd6ZjkHJtssB0UdKS2Uy2iq1DMPjucuwUfA@mail.gmail.com>
 <20231119152434-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231119152434-mutt-send-email-mst@kernel.org>
From: Dan Hoffman <dhoff749@gmail.com>
Date: Sun, 19 Nov 2023 14:42:08 -0600
Message-ID: <CAFXChK+5hCrcDK28t0Tv7ragU81-8=u7RckaLBNG+bB2p+W2jg@mail.gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=dhoff749@gmail.com; helo=mail-oa1-x2c.google.com
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

Submitted a v3 with the minimum reproducible build configuration

On Sun, Nov 19, 2023 at 2:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Nov 19, 2023 at 02:19:25PM -0600, Dan Hoffman wrote:
> > Clang 16.0.6
> >
> > I can re-submit with the compiler and version if that helps.
>
> Worth mentioning this and the flags used I think.
>
> > On Sun, Nov 19, 2023 at 2:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Sun, Nov 19, 2023 at 11:03:54AM -0600, Dan Hoffman wrote:
> > > > On Sun, Nov 19, 2023 at 1:23=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Sat, Nov 18, 2023 at 10:25:31AM -0800, Daniel Hoffman wrote:
> > > > > > `kvm_enabled()` is compiled down to `0` and short-circuit logic=
 is
> > > > > > used to remmove references to undefined symbols at the compile =
stage.
> > > > > > Some build configurations with some compilers don't attempt to
> > > > > > simplify this logic down in some cases (the pattern appears to =
be
> > > > > > that the literal false must be the first term) and this was cau=
sing
> > > > > > some builds to emit references to undefined symbols.
> > > > > >
> > > > > > Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
> > > > >
> > > > > Could we add a bit more detail here? Will help make sure
> > > > > this does not break again in the future.
> > > >
> > > > The configuration script was ran as such:  ../configure
> > > > --without-default-features --target-list=3Dx86_64-softmmu,i386-soft=
mmu
> > > > --enable-debug --enable-tcg-interpreter --enable-debug-tcg
> > > > --enable-debug-mutex
> > > >
> > > > I'm pretty sure the only relevant flags here are
> > > > --without-default-features, --target-list including x86_64-softmmu =
and
> > > > --enable-debug
> > > >
> > > > The only error I see is this: [...]/hw/i386/x86.c:422:(.text+0x1004=
):
> > > > undefined reference to `kvm_hv_vpindex_settable' (the other
> > > > kvm_enabled() was moved for the sake of consistency). My compiler i=
s
> > > > clang (16.0.6).
> > > >
> > > > I haven't looked into the heuristics or logic for how the compile-t=
ime
> > > > short-circuit logic works, but I assumed only the first parameter i=
s
> > > > "guaranteed" to be checked for a literal false (guaranteed is in
> > > > quotes because that's just how clang works, not because it's a feat=
ure
> > > > of the language IIRC).
> > > >
> > > > This pattern relies on somes subtle behavior with the compiler, so =
my
> > > > suggestion going forward would be to not rely on code optimizations
> > > > removing undefined references based on short-circuit logic (instead
> > > > have some configuration macro defined that disables all relevant
> > > > code). I'm a new contributor, so I submitted the minimum to make it
> > > > work on my machine.
> > > >
> > > > If you have any other questions, please let me know.
> > > >
> > > > Thanks!
> > >
> > > which compiler is this?
> > >
> > > --
> > > MST
> > >
>

