Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DB5827606
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 18:09:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMt6R-0005vb-Nj; Mon, 08 Jan 2024 12:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMt6P-0005vQ-2X
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 12:07:53 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMt6F-00046J-ED
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 12:07:52 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5542a7f1f3cso2299566a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 09:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704733657; x=1705338457; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4MMM+UQpixc+gEjmOwj/w8/BM/QPjyKfxXE3k88bihI=;
 b=Ze8P7eMS0UmF2HcMleH6grmIFol48m8bM8LztYw/Ab946g0JTB+W/qU3ZeXO5+5wah
 5fA2riHY9fBNcTU2haoj7P40zxJ26eyc48RyOjf1x32OQ/5rqnSTHRp55f6z4fl1lkx5
 HasBZJsPhxetfGLEESMpv2uYQl+yr2v/dGy6Iah1rUvmG+Bp9rcKLUeET6nfjbI60aJg
 /5vUU0lDG9B4QmBGskAkvnDaHP3fGVwlyrmvhNBtQk0A0l0OMFCQ9ZMtTy6wgW1uZit4
 Q5elUr6DTpUeaYB/ayM4Qg9eT/bYdNHbDHNw0Yd5M0J9+2+ZKaVe0Wp+sfHfmTJ82EJ8
 RoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704733657; x=1705338457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4MMM+UQpixc+gEjmOwj/w8/BM/QPjyKfxXE3k88bihI=;
 b=QCdJGMeLJnlJKFnhhXna32ukB1eyJXFwsUXk+vgzVSKA98h2FSTrdp1DRsvHzndP1A
 wE2SJjTYfZKm+1juoBl4l4uFVOvuYZ8YQdsLAQQ3z90VwrAisdjQFjmNEcV0aXK72bTh
 n1vN4ATRwSfSXY9EMTHN0qAYCxZ7u0K3a4fZUDbmJ3nwPNot6vfabUKeggICWnSAbi7g
 F8qtkbAYVx2qmo9Myq1n4HPH10uTX85AC9q+xnmjDRkCfFe4ORUIjc3/DOXkvvJb97ZO
 Et17UcdI8eh0WDqhJoIpYV45uXjZHwbplWybyJGSgd5XuoSWQd3YhIpTuFhXGe6fYlMb
 1lOg==
X-Gm-Message-State: AOJu0YxTUos07Rv9gI05NwsFcq0+NTa1JagG9vYnEFhTC1ZJCutmwxSc
 c2D1VEq4Awew2CL3/Eju47EWyBnZ8SN9jShqtUKoHbRNzx/HZ8ekFcJl3JYh
X-Google-Smtp-Source: AGHT+IGThVVmtlOYHhtq6gggVNN1OHJAxq2bYM2MDeZo7IpkWfvtlasE4UtNxn0wExQeIoSk3Tk3phf4z24xUaWVXaE=
X-Received: by 2002:a50:a411:0:b0:557:754f:922f with SMTP id
 u17-20020a50a411000000b00557754f922fmr1930946edb.71.1704733657335; Mon, 08
 Jan 2024 09:07:37 -0800 (PST)
MIME-Version: 1.0
References: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
 <CAFEAcA8DdsHQ0eCYnh4vNoybodj0mcHCnOMEr9b_aOk7yO2Osw@mail.gmail.com>
 <ea7dd9f7-b40f-436c-a469-97ef26ac66a2@tls.msk.ru>
 <d08930a4-7e01-41eb-b118-b20fea0f8556@tls.msk.ru>
In-Reply-To: <d08930a4-7e01-41eb-b118-b20fea0f8556@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 17:07:26 +0000
Message-ID: <CAFEAcA_wnSF-OAKNaDNjbEiMi-AXv2srJ5JjmiaT4+_wWee9aw@mail.gmail.com>
Subject: Re: virtio-pci in qemu-system-arm is broken in 8.2
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 4 Jan 2024 at 17:17, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 04.01.2024 19:25, Michael Tokarev wrote:
> ...
> > this archive contains kernel+initrd.  I run it this way:
> >
> > qemu-system-arm -append root=LABEL=debvm -nographic -machine type=virt \
> >   -drive media=disk,format=raw,file=vmlinuz,if=virtio,snapshot=on \
> >   -no-user-config -m 1G -kernel vmlinuz -initrd initrd.img
>
> This is actually even more fishy.
>
> The reproducer needs -cpu max to "work." Without -cpu max, it
> fails to recognize virtio pci devices in both cases - in 8.2.0
> with or without the commit in question (b8f7959f28c4f36496).
> Only with -cpu max it works after reverting b8f7959f28c.
>
> Additional kernel message in case when it doesn't work:
>
> [    1.372841] pci-host-generic 4010000000.pcie: \
>    can't claim ECAM area [mem 0x10000000-0x1fffffff]: \
>    address conflict with pcie@10000000 [mem 0x10000000-0x3efeffff]
>
> which isn't generated in case everything's ok.

I'm trying to figure out what kind of kernel config causes
this. If I do an upstream build of v6.6.9 with this config:
https://people.linaro.org/~peter.maydell/arm-6.6.9-config

then it successfully probes the PCI device even with -cpu max:

pci-host-generic 4010000000.pcie: host bridge /pcie@10000000 ranges:
pci-host-generic 4010000000.pcie:       IO 0x003eff0000..0x003effffff
-> 0x0000000000
pci-host-generic 4010000000.pcie:      MEM 0x0010000000..0x003efeffff
-> 0x0010000000
pci-host-generic 4010000000.pcie:      MEM 0x8000000000..0xffffffffff
-> 0x8000000000
pci-host-generic 4010000000.pcie: Memory resource size exceeds max for 32 bits
pci-host-generic 4010000000.pcie: ECAM at [mem
0x4010000000-0x401fffffff] for [bus 00-ff]
pci-host-generic 4010000000.pcie: PCI host bridge to bus 0000:00

So what's different about your kernel and config that
causes the pci controller not to probe?

thanks
-- PMM

