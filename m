Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B50711170
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 18:55:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2EEj-0003K7-M1; Thu, 25 May 2023 12:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q2EEh-0003Ja-Mq
 for qemu-devel@nongnu.org; Thu, 25 May 2023 12:54:47 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q2EEg-0006Ll-85
 for qemu-devel@nongnu.org; Thu, 25 May 2023 12:54:47 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6ad13a1fbceso1293427a34.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685033685; x=1687625685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pQEAy0LhIbDL76aAiiMzyqY3WLz9EzhyYRF8ON1xaCY=;
 b=BEMrH4Sg6AYiBdJgi3cNLSEL8NrUalnBHSesDMHPeqUyFyg0rxSPx27Qx4lMtAEBoe
 33sbV/SSpEFaLaTtsjQvuJJceFclaU7gEkupl2l1dEGu5zi+xbh4c/1LrOuiTwoegKUb
 sQCmNd/HoJH5J+f5TZggTQFjJ4PsR8sPzCcVOIKzBMUOphOZ/BIgGGTvuYfaJh9GKjq9
 lSDA/wQ8c3jz++9sNEvcHw8YDx0oZMo/5o//3uqpw4LgQXcdj2jpb+3FpZ1QEt2msmX6
 JFYgp7jwYBBwvvRR9U1ZDgKj/ASPzTuGzndKjbVlsnD2QHikKE+vH08+KQy3kPsnjCqV
 rgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685033685; x=1687625685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQEAy0LhIbDL76aAiiMzyqY3WLz9EzhyYRF8ON1xaCY=;
 b=MkP0qI8A2w9f2P/bgQSt9vaHZjusW+iy3+N0VvgdRody6PCJqFRdxaiZnDUsqYMGki
 7X4Xy9wgvMvMFX8g0gov/0E31esArOz0dTY0133mXnwCMI1uu6GmhH+5ug9VGqadhn5K
 i4tjP3SamN2qdNK3STEEhlxlt1nSKUC58o2Hb+Z7/wAh3c82XvcfY0+CTbiwAbquzX0f
 yHCoJ3apNyKA1AZkWDlFpuT8EY5BWS+nJX1r189gafCPWUnuaUXR1D0oVgKixeDji4kt
 Jq0gcBSE55LKE46HDNIBUzLSjHEifNGaMr/UtafHXruTphvpmlO8g8Ac577/34D1SFVm
 J1Cg==
X-Gm-Message-State: AC+VfDzlaoTyg0bH6cliZyywAJIm6pfkIg/wMMYNCz9QH73zESo74JQu
 7PTqM1U9Zm4eKiLEH5B4tpiubA==
X-Google-Smtp-Source: ACHHUZ4KGYTmll31uL4n9T4nxiEIZ1/uAwVV4NxVJ16xkYJxPYMdSPODwd/FAVWMgvx0HXE9Za98cg==
X-Received: by 2002:a05:6808:1917:b0:398:2c02:20a2 with SMTP id
 bf23-20020a056808191700b003982c0220a2mr137482oib.17.1685033685146; 
 Thu, 25 May 2023 09:54:45 -0700 (PDT)
Received: from sunil-laptop ([106.51.186.3]) by smtp.gmail.com with ESMTPSA id
 w16-20020a056808091000b003907c4bc505sm678664oih.11.2023.05.25.09.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 09:54:44 -0700 (PDT)
Date: Thu, 25 May 2023 22:24:37 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3] hw/riscv: virt: Assume M-mode FW in pflash0 only when
 "-bios none"
Message-ID: <ZG+SzQYPoyYfMFVi@sunil-laptop>
References: <20230523102805.100160-1-sunilvl@ventanamicro.com>
 <CABJz62MQ5uRHUP4LLKt=AxTf-Sz0aTEOLWDz=9ftK=H3tZ9JUg@mail.gmail.com>
 <ZG5KgLQ4H/leWKJi@sunil-laptop>
 <CABJz62NHXrBKkc3Gux0TXOjUCO4up-OunwJ6UO94ts+rTgVsAg@mail.gmail.com>
 <ZG94lvAYggnRBfLQ@sunil-laptop>
 <CABJz62NUpY35u2ykPXVHp8a_RUyjCnC1_DpWsYNuSBftHe4qBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABJz62NUpY35u2ykPXVHp8a_RUyjCnC1_DpWsYNuSBftHe4qBQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, May 25, 2023 at 04:19:12PM +0000, Andrea Bolognani wrote:
> On Thu, May 25, 2023 at 08:32:46PM +0530, Sunil V L wrote:
> > On Thu, May 25, 2023 at 01:43:28PM +0000, Andrea Bolognani wrote:
> > > I have also tried booting an openSUSE Tumbleweed "JeOS" image, since
> > > that's the only distro I'm aware of that uses UEFI boot on RISC-V at
> > > this point - though they use U-Boot's UEFI support rather than edk2.
> > >
> > > During that attempt, I ended up in the edk2 shell. Running
> > >
> > >   fs0:\efi\boot\bootriscv64.efi
> > >
> > > brings up GRUB just fine, but selecting the default boot entry
> > > results in
> > >
> > >   Loading Linux 6.3.2-1-default ...
> > >   Loading initial ramdisk ...
> > >   EFI stub: Booting Linux Kernel...
> > >   EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> > >   EFI stub: Generating empty DTB
> > >   EFI stub: Exiting boot services...
> > >
> > > being printed, after which it's back to OpenSBI and from there to
> > > edk2 again.
> >
> > Thanks!. Please add -machine acpi=off in qemu command to boot the
> > kernel.
> 
> Yup, that worked! It booted all the way to the login prompt :)
> 
> Note that libvirt automatically adds acpi=off, so that won't be a
> concern for libvirt users.
> 
Great!. Thanks. Since we decided to keep acpi enabled by default in
qemu similar to other architectures, we need to turn this off until
complete ACPI support is merged in linux kernel. Thanks for the
information that libvirt turns it off by default.

> > > > > Going further and testing libvirt integration. After hacking around
> > > > > other issues, I finally stumbled upon this error:
> > > > >
> > > > >   qemu-system-riscv64: Property 'virt-machine.pflash0' not found
> > > >
> > > > Thanks!. This needs some investigation. Let me look into supporting
> > > > this.
> > >
> > > Yes please! It's critical to libvirt integration. Feel free to CC me
> > > when you post patches and I'll gladly test them.
> >
> > Sure, I have the fix ready. I need to convert this into a patch series
> > now. Will send it soon and thanks in advance for helping with testing.
> 
> Excellent! Looking forward to it :)
> 
Sent.

Thanks,
Sunil

