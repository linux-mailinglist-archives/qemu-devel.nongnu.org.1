Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61759832E53
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 18:47:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQsxH-0001aa-2R; Fri, 19 Jan 2024 12:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQsxE-0001aO-M7
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:46:56 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQsxD-0002Xv-0Z
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:46:56 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5578485fc0eso1093398a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 09:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705686412; x=1706291212; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4DPUS/85mH1IUR8PZOdL+FrwMo1NGzgrtCBUZEAw+W0=;
 b=bTxi+/OBTNcef5zkiXigQlvqnpqeRi3ythEfoNmqtPBAOLNUnwmySJVfZCwruygaaQ
 NqYQA3qs47gLlqjjklvp5EvSObJMNqZt+nYz3SyopNVfbzq9XJkgXo0rokFYoHHuFyaJ
 RJEqKv4eRdL31J1neDgJ/GxfUKcnC4ZKaB/hWR8HyP/pptY5oKbTyQKTW2AnkeZmhlis
 PLun9mbWfvHjo8hOAIn03pFf5qv/PpknvWu9PGI5/U83QF46rCon4+dhyALkoW4A3f1U
 vqKU5jLzChoPsfEUCNV5szGK0jUwrsgX8dZ4oG33L5wNgg7ebozOazu1UxxI5iPmF/A8
 dKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705686412; x=1706291212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4DPUS/85mH1IUR8PZOdL+FrwMo1NGzgrtCBUZEAw+W0=;
 b=UIumYm1/egqP/7YBcHNYvG+/x4tnRYdUPUyGNwld3p9W8wgA+880iXTSQSLPhuAaBk
 6RXCE3eZaznq1zA/4DkHpRU/K+1g6H4MS5dQ4JtrODi5j5cqUrasm5A5Z/O76b2wO9cv
 en2U93G0RQFgu0o3IKCWStv7KXZJd2Y7gUqtTkg4dgmhlCfwa8dojkC4aHPSb0ZmTyQQ
 pmnSQgyro4rYJztOB9qxYFXvkI7vQgjg/9avJtCHSifyDo93rnDT8VsT4vOD2q9ZMhMS
 JlyuF4fyDILqzrGwoFMJ+qsDOez3hhhNMn288Q7QUxpr0Sd6yaLYwPiHg0MI0fWB4ekM
 zKEQ==
X-Gm-Message-State: AOJu0YzPASjF/2tod1R8gZVrzrDeDtCgZzDcFfV91BJr2gQQZpJ3CV/P
 i4urMnRLrNxD16XyRfzu5lcP5006C7vaoOgoI0rIFUgC25v0opWaAmdplGXcjZBM6lolBSDo2UQ
 Zbo8fLqGwcXyK201SDy92fENrYqlh4OYpTWDPWg==
X-Google-Smtp-Source: AGHT+IG0B7aNIVkKCWeCZQ0WuDTG7erEJghhYfTdLnHBH1JoO0bJBldhGglLEnZRfDjL4S3kCb4zPBrHc1m515c5pCU=
X-Received: by 2002:a05:6402:30a7:b0:559:f5dc:d8c1 with SMTP id
 df7-20020a05640230a700b00559f5dcd8c1mr64092edb.76.1705686412561; Fri, 19 Jan
 2024 09:46:52 -0800 (PST)
MIME-Version: 1.0
References: <20240115043431.3900922-1-bin.meng@windriver.com>
 <20240115043431.3900922-4-bin.meng@windriver.com>
 <CAFEAcA9Z_9Mg_R2ToEo=++UAdq789-q2S8CjHLT6fyp_zXrh-A@mail.gmail.com>
 <ba16062e-e2c9-95b8-8b35-c388f348e126@redhat.com>
In-Reply-To: <ba16062e-e2c9-95b8-8b35-c388f348e126@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 17:46:41 +0000
Message-ID: <CAFEAcA8pSQ15zxhO2pFWS8h+xJHqcLt+CSJ78En2SG1m--izWQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/acpi: Update virt/SSDT.memhp
To: Laszlo Ersek <lersek@redhat.com>
Cc: Bin Meng <bin.meng@windriver.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 19 Jan 2024 at 17:19, Laszlo Ersek <lersek@redhat.com> wrote:
>
> On 1/19/24 15:29, Peter Maydell wrote:
> > On Mon, 15 Jan 2024 at 04:35, Bin Meng <bin.meng@windriver.com> wrote:
> >>
> >> The Arm dtb changes caused an address change:
> >>
> >>  DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000001)
> >>  {
> >>      [ ... ]
> >> -    Name (MEMA, 0x43C80000)
> >> +    Name (MEMA, 0x43D80000)
> >>  }
> >>
> >> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> >>
> >> ---
> >
> > You should follow up (with Laszlo?) to make sure we understand
> > why reducing the size of the generated dtb has caused this
> > change in the ACPI tables. In particular, if we made the
> > dtb *smaller* why has the allocated address here got *larger*?
>
> As a very roughly stated trait (i.e., I'm not claiming this is an exact,
> hard rule), the UEFI memory allocator hands out chunks top-down. An
> earlier allocation (such as the DTB's) shrinking is consistent with
> further allocations being serviced at higher addresses.
>
> >
> > This particular bit of the ACPI tables does seem to be
> > annoyingly unstable, though -- for instance commit 55abfc1ffbe54c0
> > we had to change this figure when we updated to a newer EDK2
> > version, and similarly commit 5f88dd43d0 for the same reason.
> > I wonder if we can or should make our data-check be more
> > loose about the address reported here, given what Laszlo
> > says about how we're basically looking at the address of some
> > memory the guest allocated. (cc'd the bios-tables-test
> > maintainers for their opinion.)
>
> Right, the allocation address is generally unpredictable. (That's why
> the ACPI linker/loader "language" had to be extended with an extra
> command, for the sake of the vmgenid device -- so that the firmware
> could send the allocation GPA back to QEMU in an "architected" way.)
>
> >
> > I'm also a little concerned that if the ACPI generated
> > tables care about the dtb size then we're now going to
> > have a situation where any patch we make to the virt board
> > that changes the generated dtb at all will result in the
> > ACPI tables changing. That would be annoying.
>
> This is generally inevitable, it's just how the ACPI linker/loader
> works. The guest allocator can only work with the memory map it gets
> from QEMU. The same effect is triggered BTW if you don't change the DTB
> but change (on the QEMU command line) the guest RAM size. The ACPI
> tables will be allocated at different addresses than before, and so the
> pointer fields in other tables, to those tables, will also change.

Mmm, but previously we weren't packing the dtb we created,
so it would always be the same 1MB regardless of what and
how much we put into it. After this patchset it will be packed
down to its "real" size, so the size will be much more variable.

thanks
-- PMM

