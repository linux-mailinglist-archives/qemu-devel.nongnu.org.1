Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF087F0805
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 18:05:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4lDR-0000Lj-2w; Sun, 19 Nov 2023 12:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4lDM-0000KO-ES; Sun, 19 Nov 2023 12:04:08 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4lDH-0005Jf-5a; Sun, 19 Nov 2023 12:04:05 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41e1921da84so23127091cf.1; 
 Sun, 19 Nov 2023 09:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700413441; x=1701018241; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOn+Brn1l1hcFlplY1Qqcu1/Tt5OE5fxHb2aBdBdd6s=;
 b=U6xNMvVEpBS9bGfXlPrybIE1op2e/7FEKEVqFZmUtT5+mIhgkDE0lq4dHTFUkJ3Tnh
 We8zT7sJAj8xNJnQxs8iIn5WBRm86ocjry01feGVg3zD5Cdtz6zvessAHUdyOh9q/Q1f
 BVGNkC+4YeTugPFpp8xTcGRbNfhLNummjxrXaIhUJo3RQOD8L01o0F408eNnhuY6rQNx
 I8lGbU6Y08VCYPl0FdUfwe0cqYTJ52sIs8IOunFN7u2CXz3znZrxWoDm0slpUYp5ifzg
 lQzwUIgWblXvzIlLjkj73+x+g/Lqykxpjybg7oHScnXJK+7Kcr74YPoKBplfW+AbMk8r
 ngRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700413441; x=1701018241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FOn+Brn1l1hcFlplY1Qqcu1/Tt5OE5fxHb2aBdBdd6s=;
 b=PA8s+6IbMjoxwjK+9wjyMb4Xbvo8NnarIG/qCFAW1ySfdga9rbnV7HrV9tnYCo0rxN
 lqQK5OU9ZAgsc+CPogXgd9jmnvbrENZ2VCC5+uT77iVbG4X9S+GaeVmDIndauCDkERLJ
 3Tz84w+HGWnhAQ+LjImmi5lkXnb+CO6oQPkGDGtm4DzzV3gjOEsFn9pgcZW8i+2PvBuE
 iL8bmqYu7wVUYJA8eEoNnPr1YZ448cX6Y7vfxksBoEgdvK1sSVnVNs549aUX3cunrfKk
 HpG5P/LXFKEepRGY0F0eVUonHlh88h5R9FgYJm8mZLFXlQXv+a/wVBGhY4NTFUmIRIzd
 lOWQ==
X-Gm-Message-State: AOJu0Yx1nKQgjoQsIhGbzQGhf5HPr87drRnhWOoJbcm95EXcoY6F04k1
 Ug5nOs2Frn46sDDpKx0NtjRQkV6dDEKf1Od5SAI=
X-Google-Smtp-Source: AGHT+IHiK6GfpUlysfcgTgc3GKnrNdrT6WKQG/oZk9j785FZGx7crqTcOElJkxJw+ACK10+SUaJMJFBWwd5J28XRhPg=
X-Received: by 2002:a05:622a:1812:b0:420:ec71:3f2e with SMTP id
 t18-20020a05622a181200b00420ec713f2emr8549067qtc.24.1700413441141; Sun, 19
 Nov 2023 09:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20231118182531.2619772-1-dhoff749@gmail.com>
 <20231119022223-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231119022223-mutt-send-email-mst@kernel.org>
From: Dan Hoffman <dhoff749@gmail.com>
Date: Sun, 19 Nov 2023 11:03:54 -0600
Message-ID: <CAFXChKJGE92WEfOWsE0=eSfSM55abCA4baOsoPE8V--iWU1GGg@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=dhoff749@gmail.com; helo=mail-qt1-x834.google.com
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

On Sun, Nov 19, 2023 at 1:23=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sat, Nov 18, 2023 at 10:25:31AM -0800, Daniel Hoffman wrote:
> > `kvm_enabled()` is compiled down to `0` and short-circuit logic is
> > used to remmove references to undefined symbols at the compile stage.
> > Some build configurations with some compilers don't attempt to
> > simplify this logic down in some cases (the pattern appears to be
> > that the literal false must be the first term) and this was causing
> > some builds to emit references to undefined symbols.
> >
> > Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
>
> Could we add a bit more detail here? Will help make sure
> this does not break again in the future.

The configuration script was ran as such:  ../configure
--without-default-features --target-list=3Dx86_64-softmmu,i386-softmmu
--enable-debug --enable-tcg-interpreter --enable-debug-tcg
--enable-debug-mutex

I'm pretty sure the only relevant flags here are
--without-default-features, --target-list including x86_64-softmmu and
--enable-debug

The only error I see is this: [...]/hw/i386/x86.c:422:(.text+0x1004):
undefined reference to `kvm_hv_vpindex_settable' (the other
kvm_enabled() was moved for the sake of consistency). My compiler is
clang (16.0.6).

I haven't looked into the heuristics or logic for how the compile-time
short-circuit logic works, but I assumed only the first parameter is
"guaranteed" to be checked for a literal false (guaranteed is in
quotes because that's just how clang works, not because it's a feature
of the language IIRC).

This pattern relies on somes subtle behavior with the compiler, so my
suggestion going forward would be to not rely on code optimizations
removing undefined references based on short-circuit logic (instead
have some configuration macro defined that disables all relevant
code). I'm a new contributor, so I submitted the minimum to make it
work on my machine.

If you have any other questions, please let me know.

Thanks!

