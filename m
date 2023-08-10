Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F8477809A
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 20:45:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUAdu-0008KT-TV; Thu, 10 Aug 2023 14:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qUAds-0008KK-Nl
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:44:16 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qUAdr-0000dK-3a
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:44:16 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4475af775c7so515640137.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 11:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691693054; x=1692297854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBqNN6FRLL3a4ZKoXkjtrSpT37DGeze+7We/GgUkpFA=;
 b=rtVrqB12pZEQt7OW//hEMx2zYMPx3n9Xt56zd252o6o/8nlM5ej72BumPfsF9sbZBc
 1v3WvUkSAlZcePiTyC9wGJmU4obTaR6vRoZYCM2fL2+fR94NRYXXb8F2Yj8CDekSFX3x
 wZ40ywXSdvWsdu3IHz3dSh2J52Tq31juKasay9gJKixedhs0jJlvs6oCI6isKre3gV4p
 wRxFT63dIB+U6g1Bhl58Mswcjhss0dITAqJ1ychTTAKFlq0BlnKcherNZju+oNnHUcBW
 nFI21gjfKqtsrRks3ciivQc1WCVXOd54QAYmmn+XErE2JxeoKP3Ptxwc3oxeaUbTWWdp
 VGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691693054; x=1692297854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBqNN6FRLL3a4ZKoXkjtrSpT37DGeze+7We/GgUkpFA=;
 b=P+oZK9RL8XidjuCLnM+buraCJzr1ixmb/bgcX0nv/+MLiIpYOyUrGOOZoBRAAvmpeC
 4Fkfm7PuVFi3UZ7TQvCyMfCgmLsIOgFoIfonUJZrU/EXm3l7ovbgyT2nx471/ZkiX0cq
 kzEYR4SodyKYroF2m5Mxri3kFcD8ivoyo3tVJ9QC1UaF8Gkx2t0zU9Ke0Y6k6u90vqxO
 v5omPUjxYZUD812zOQc6tMYNHqB9TCpc2/rxyxUc2XIvZLUb9DusIswfy6AIXwdRBtxm
 8McDgtlpGvjgPPiOSI1i/2c/0GzeTcBu8m/dIacsuZLt4figrVX/SwPNLvNp1HRivZGy
 l48g==
X-Gm-Message-State: AOJu0YwD9c7bXSLOsmQbiEwC4xU0gSd80GGmh0iy/cOUqpQuXHXBYJqY
 bZFqwA+lt0gMAL/Ytz5egN0Ta5sU7StFjeFBXkc=
X-Google-Smtp-Source: AGHT+IHYfAC7s1R28QPNBL72qfS2/BI9Ys/W9RPNpaQL8FPT56+7HBWnwdJaNyoFp2dPx7Q3n5sFGPBSmWtS41PRtN4=
X-Received: by 2002:a67:ebd4:0:b0:443:895d:1b53 with SMTP id
 y20-20020a67ebd4000000b00443895d1b53mr2659186vso.10.1691693053936; Thu, 10
 Aug 2023 11:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMLU-D6C2BA5LjDjKg_t-xAh9kg+WgmfRxkxDbtujkBBw@mail.gmail.com>
 <20230724060532.3574-1-18622748025@163.com>
In-Reply-To: <20230724060532.3574-1-18622748025@163.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 10 Aug 2023 14:43:47 -0400
Message-ID: <CAKmqyKNunidr8gv9pEvKFir66NBfu_HcJ7axMviwJ_-RQ=QSEA@mail.gmail.com>
Subject: Re: Re: [PATCH] target/riscv: Clearing the CSR values at reset and
 syncing the MPSTATE with the host
To: "liguang.zhang" <18622748025@163.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 24, 2023 at 2:06=E2=80=AFAM liguang.zhang <18622748025@163.com>=
 wrote:
>
> > On Tue, Jul 18, 2023 at 10:22=E2=80=AFPM liguang.zhang <18622748...@163=
.com> wrote:
> > >
> > > From: "liguang.zhang" <liguang.zh...@hexintek.com>
> > >
> > > Fix the guest reboot error when using KVM
> > > There are two issues when rebooting a guest using KVM
> > > 1. When the guest initiates a reboot the host is unable to stop the v=
cpu
> > > 2. When running a SMP guest the qemu monitor system_reset causes a vc=
pu crash
> > >
> > > This can be fixed by clearing the CSR values at reset and syncing the
> > > MPSTATE with the host.
> > >
> > > Signed-off-by: liguang.zhang <liguang.zh...@hexintek.com>
> >
> > Thanks!
> >
> > When sending new versions of patches please increment the patch
> > version:
> > https://www.qemu.org/docs/master/devel/submitting-a-patch.html#when-res=
ending-patches-add-a-version-tag
> >
>
> Sorry about it, since i'm confused about the git send-email, original mai=
l thread lost. -> https://www.mail-archive.com/qemu-devel@nongnu.org/msg977=
038.html
> I would like to resubmit and track the email history.

No worries :)

I have noticed that when you send the patch emails I get multiple
emails sent a few minutes apart. I count at least 8 copies of the same
email. Do you mind trying to fix whatever is causing that?

>
> > The patch looks good, but don't we need an equivalent for the get regis=
ter call?
> >
> > Alistair
>
> Sorry, "get register call" refers to which section? It was not mentioned =
in the previous suggestions for modifications.

You are adding code to kvm_arch_put_registers() don't you also need to
add code to kvm_arch_get_registers()? and a *_mpstate_to_qemu()
function to match?

> Follow the original modification suggestions, I hope to upstream as soon =
as possible, as it has been delayed for quite some time.

Upstreamig code is an iterative process. Just because something wasn't
brought up in the first version doesn't mean it won't be raised later.

I'm sorry it has taken so long. If you don't get a reply within a week
please ping your patches or responses. Ensuring you follow patch
submission best practices can help improve the upstreaming speed, such
as incrementing patch versions and responding with plain text inline.

Hopefully just one more revision is required :)

Alistair

>
> Thanks ~
>

