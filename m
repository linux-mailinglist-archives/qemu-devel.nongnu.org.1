Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BC6A9FFC9
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Apr 2025 04:29:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ahQ-0003BP-Cl; Mon, 28 Apr 2025 22:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u9ahL-000385-Ur
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 22:27:52 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u9ahJ-0004M2-Pe
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 22:27:51 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5f4b7211badso8927793a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 19:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1745893666; x=1746498466; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jl/4sSEJTGo3BJOin8dUOd1ajyiTYdgwqywjjk3cQf0=;
 b=ma21rwRLt9yQIgdQdxVO9parDzitXQH+ilx9fWUl56DR0T3wiienhvqPCpCzRdu2zj
 YmZRlEPIUUS5Z3BQe6KKwFfaXvJ5mTcI0/gmhvT92DuLpxUx6vZ6cWke3osszfRlzwU6
 vBOspaoVjluj753wtCXNWe+WKfspmE7kFPKRGf7mIELvBEo8x5XqD534DRMRPLc66Zmx
 KOanXSZYaj7pwvggSxAQEnytm2LavLQlJ/WleRWC6IBMLGFu+VEtsASHIdWqznqTQmeB
 PkpxIw2k3IGJxRsgCz9cz9dA676XRo6Gx4oFULr3WVrAncG7ymnFlykc53iWbskBilcI
 aIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745893666; x=1746498466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jl/4sSEJTGo3BJOin8dUOd1ajyiTYdgwqywjjk3cQf0=;
 b=X/S8sNv1RcoABwQtBBRvw2iyhPJG0Q1gXhLktyqAdqM5hHUAxjgtuF3yi9TMC1TnHH
 q9svUmiK0XUEIC977eZxZ+PVqzJ1oNhtqjcZoB68loudeAN17Lapl84lfhwXCupovsw2
 sxjL+1gWiWOKUBzCwfTJ1Bm9s3x78GqWkbpsEB1GNV8WPueR2wlSSL7CqMmk3yfh59+K
 Y0kIAgDQ1ufyu0BMskUA96HjF0C1gIhnszTHbq8zZwAdgFeQZewqPgSReCft1xOSx7kb
 D8Ojw82HIGNEOcRbItnNDX29WfTbIM3J+ls6DbApW8+XaX2AwwUGFC36JSuSIGgc3fGn
 sqJA==
X-Gm-Message-State: AOJu0YxhzSJPxmkiWLm2Wf1COeBEdw4PdaSwmr/7zmQ5kl7TUhMRek1o
 x6kfX4Ygbs1xbC8BG5xPkX5dB+24hdWWUCHFYFWeX1T+bU7WGtoCGZ7JRMD2ufm/swLEDHkTxc1
 RjQCzfqnWDCqTSP4a72HD9Cn+Grc2FhggSpL0RlW2hJgm0TPNBMU=
X-Gm-Gg: ASbGnct7XnUcnJKy+IgG0Av1aJpdyJkgVvuJpMl1A/a4GYSAHfNVNESHesrncbWyduI
 65AoEq2ee9aWMX2XrQ1vmGytOWN/UBzKwe9xeJMX3NOVXsEtt3RmyuSMcwSl4rDJcYBW4/Cg610
 6w0y6u4XDx2AFjHwfRHgTWYN5cKM1osKDwPlE=
X-Google-Smtp-Source: AGHT+IGuEAyu7UEwIL7VXVTKmcXJ3BbPnbZjOCnaxOpqtDjCTkqo9wsbOPo36p3c7cPkyXqSjabNCNwbpPwgectn/S4=
X-Received: by 2002:a17:907:6d23:b0:ace:6f45:b5c6 with SMTP id
 a640c23a62f3a-acec84f8058mr86737766b.22.1745893666505; Mon, 28 Apr 2025
 19:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250409025131.3670-1-jim.shu@sifive.com>
 <CALw707qbE1wRhPkWw3dXWj0gvtvzqhUH73m98LpfFPFgVhkaGw@mail.gmail.com>
In-Reply-To: <CALw707qbE1wRhPkWw3dXWj0gvtvzqhUH73m98LpfFPFgVhkaGw@mail.gmail.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Tue, 29 Apr 2025 10:27:34 +0800
X-Gm-Features: ATxdqUHviN3FJDRaqxjE22DL1BCtk1eYmQ5CNvP4-wXuA5u3PDoMZkpDcFAmMVQ
Message-ID: <CALw707pHE6b7Rr1289+E0Ef7gPS2kx4j3swBApruHqfjnq=niw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Several sstc extension fixes
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

Gentle ping on this patch.

Thanks,
Jim

On Wed, Apr 9, 2025 at 10:58=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote:
>
> Sorry, I forgot to write v2 changes in cover-letter.
>
> Changes in v2:
> - Remove duplicated code in riscv_timer_stce_changed() function
> - Add sstc spec description in the commit log
>
>
> On Wed, Apr 9, 2025 at 10:51=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrot=
e:
> >
> > This patch series contains several sstc fixes:
> >
> > (1) Writing to ACLINT mtime should also update the period of S/VS-mode
> >     timer, just like M-mode timer.
> > (2) VSTIP bit of $mip CSR should check both M-mode and H-mode STCE.
> > (3) Writing to STCE bit may enable/disable sstc extension in S/VS-mode,
> >     which should update the timer and IRQ pending bits.
> >
> >
> > Jim Shu (4):
> >   target/riscv: Add the checking into stimecmp write function.
> >   hw/intc: riscv_aclint: Fix mtime write for sstc extension
> >   target/riscv: Fix VSTIP bit in sstc extension.
> >   target/riscv: Enable/Disable S/VS-mode Timer when STCE bit is changed
> >
> >  hw/intc/riscv_aclint.c     |  5 +++
> >  target/riscv/csr.c         | 53 ++++++++++++++++++++++++++++++-
> >  target/riscv/time_helper.c | 65 ++++++++++++++++++++++++++++++++++++--
> >  target/riscv/time_helper.h |  1 +
> >  4 files changed, 121 insertions(+), 3 deletions(-)
> >
> > --
> > 2.17.1
> >

