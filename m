Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6808E816A34
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 10:51:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFAGs-00050x-Rf; Mon, 18 Dec 2023 04:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rFAGp-00050P-G1
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 04:50:43 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rFAGk-0006uH-A2
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 04:50:42 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9fa2714e828so323284766b.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 01:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1702893034; x=1703497834;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQ1Q2t0RwPtu0bFelHIi3HIMqk3CpxWdHNbgZvgQC3o=;
 b=ZxQx0YCDVcSgSuZ1fo9FeEhu4k+D9FUEx2L4Ap+TN5BmvdFm1tVokmVaUOZW/xNd8Z
 /EllVtf0MtnYzQUlUKAa+cY/BnVMY7I46dm5UUJfqVwkQ2Z1l1pBUwQS494LXkX+gfTm
 Ip0wsDLedQgc8DoITzU4JhwPqjJzLFok9mFK6JaNIVIvm7WVyrv8Oh8SNEyHmlmILUmg
 UHijr/nqkCUzPVYnagekTJKN1RCet+6dNNHA5CMM6+KSnPMoLvrr7fWxdRRx1enhXPUx
 88cSKKD1GWnODA/PHFVE7MumJm9HwGo+b3O8AeliXB4a9B/Pd1YoyWf/rGra2Iwtu295
 0p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702893034; x=1703497834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQ1Q2t0RwPtu0bFelHIi3HIMqk3CpxWdHNbgZvgQC3o=;
 b=NvxMs3qwNV7lv3fxH3B9GS1qzLbMuYky2ZBcIcPevrz1/wWNLi9C7zozLjwou2f1KR
 VHyNh4+HvnwIX/5WLaZ4gFAUxiVYJGTZNOgTMRNDPr9YRrSfRpDJjbnPS7KvPyMp6SAV
 a3N40/6ev4rAJ3SdfzJxHcYwQAtcTPmt3Hvi4im6GirMo0V5sYh7M+W7KNk1cSFGrVGx
 kpajz51RJnkeVWmzj+dchN4ekHk2fYeEgVPNuhrJ2ltbHW5kfLwOn05wPn2kGth+K/SK
 Qz2MyibTnB+KpOKqrU9KtNDin6n7dTy5bl6C5FlWZXUVwvTCp3Wk27nleHdpD8C+pt02
 YvhQ==
X-Gm-Message-State: AOJu0YyJWlXKqtMru9lZZ038O528TpFezRcRwHejDjnyuUGtvX1Udz6L
 IhqUOvhvd6BqQw5Gv2Aton2i2Qed9yyeEPc6PeymhRWLAPuF7m4ZQoY=
X-Google-Smtp-Source: AGHT+IEkwNnM51fIly3/TOxHNTcUrg/ASt3NK+KsNuYq6G9TYrM2sEhoM2TELIlWa5KkdAbtQserkv9wwhimyUTzwxg=
X-Received: by 2002:a17:907:7288:b0:a02:2177:ad14 with SMTP id
 dt8-20020a170907728800b00a022177ad14mr8930996ejc.73.1702893034519; Mon, 18
 Dec 2023 01:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
 <20231211071204.30156-3-tomoyuki.hirose@igel.co.jp>
 <CAFEAcA90fJgPGAjO0c4a=G+ge9bp1piVw40zt_rNHEoCTc_ngg@mail.gmail.com>
 <CAFS=Ec=fNB11TWWoJ847mF8v6=MkEefcMROwEyPQo9pceipNJg@mail.gmail.com>
 <CAFEAcA83J==kC5qUZBw8jE75iy=F0ojUKL2uvonU0RZ7iCqjSQ@mail.gmail.com>
In-Reply-To: <CAFEAcA83J==kC5qUZBw8jE75iy=F0ojUKL2uvonU0RZ7iCqjSQ@mail.gmail.com>
From: Tomoyuki Hirose <tomoyuki.hirose@igel.co.jp>
Date: Mon, 18 Dec 2023 18:50:18 +0900
Message-ID: <CAFS=EcndyH6cDr7EntmWdrWU6kgKXsK94vTWeTyJ71dhd0sZ4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/usb/hcd-xhci.c: allow unaligned access to
 Capability Registers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Dec 12, 2023 at 7:26=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 12 Dec 2023 at 01:43, Tomoyuki Hirose
> <tomoyuki.hirose@igel.co.jp> wrote:
> >
> > Thanks for comment.
> >
> > On Mon, Dec 11, 2023 at 10:57=E2=80=AFPM Peter Maydell <peter.maydell@l=
inaro.org> wrote:
> > > We should definitely look at fixing the unaligned access
> > > stuff, but the linked bug report is not trying to do an
> > > unaligned access -- it wants to do a 2-byte read from offset 2,
> > > which is aligned. The capability registers in the xHCI spec
> > > are also all at offsets and sizes that mean that a natural
> > > read of them is not unaligned.
> >
> > Shouldn't I link this bug report?
> > Or is it not appropriate to allow unaligned access?
>
> The bug report is definitely relevant. But depending
> on how tricky the unaligned access handling turns out to
> be to get right, we might be able to fix the bug by
> permitting aligned-but-not-4-bytes accesses. (I'm
> a bit surprised that doesn't work already, in fact:
> we use it in other devices.)
>
> thanks
> -- PMM

Thank you for answering my question.
The unaligned access handling of my patch is not so tricky.
If the access is unaligned, just correct the access size
and address and read the value as before.
Also, it is allowed by the specifications, and byte access
was possible even on real devices.

Regards,
Tomoyuki HIROSE

