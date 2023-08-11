Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96800778560
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 04:24:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUHnV-0008U9-73; Thu, 10 Aug 2023 22:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maverickk1778@gmail.com>)
 id 1qUHnU-0008U1-3u
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 22:22:40 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maverickk1778@gmail.com>)
 id 1qUHnS-0008VQ-If
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 22:22:39 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34911a634edso5733755ab.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 19:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691720557; x=1692325357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XbbCx49wRpP4DxUXKnhwVZHka1TPFZPDIatFvbZ4Jug=;
 b=YEUdjllhtxycgD6IrlkShVoS8icFqsXRe9CcGz9/FpruV/EetUADiuAw/HHt3bgjVf
 SO/IeQCGMqVNj/KoRggxjNy9bNjFr/DWoAQLS6SsPrs27td/rRqxv6/Gu86ByYyw4KEY
 Y+L/Wq5HewHpPMROUFaiJFTyZhsqvknVdlqdpErpw35gF3oCd8I1IknxLDJxaoASM2RZ
 rWhuzTedKhrnVsvBDM5X9jAcirlxs4Ljl0KLl4gdUlIe84djSx023hDIpqYFP0Pygscn
 s0mLM2sMCZJ6wX1WoX0HBafa+F1cUnuEJL1VSrW51hMonHMB66x9ffeY8CcbdHieDiLb
 mCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691720557; x=1692325357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XbbCx49wRpP4DxUXKnhwVZHka1TPFZPDIatFvbZ4Jug=;
 b=S8gi2aRqb6KqxxOgTlSwEF+aDvWcgNOk2WUrQznq4by4QPHi5eELXowyMen3z6eUf9
 s0hs/lyyTJUYYeAJqClbyu8bY6PN28Mzh0M6ZkgxzdJaGTxqs1jOrjulRF95zV40IgAM
 0oIVEMR0w4vWZS0drx+B1LEodXfFuE/if3McCrOpa57WjO7qe8gQQs8931E4k2EZ0KQn
 DMzTQfHcKxtmInrNBCRYesfDj2NnO0GvIJvgCNYtf1/SMT+XnpveTxovooxNDTB0VzdP
 SI208NC9PHGg5GMbNUq6N5r3qEGWXpYBYrCcQdnIF+Si9uVwGFoyTszsGuVYtyPp1eXC
 z67w==
X-Gm-Message-State: AOJu0YwO0FqLU2dsnmp4kVTL36i1j36R9kuUxCyv7PTMcyz7UXDjhecu
 wNqL0CqG4Tv5vSjkI39IopGXgToA/XHiJknpAnw=
X-Google-Smtp-Source: AGHT+IHjqUSZ3i7Fjwy9A3JxZl5rrWF0bAn3QNc5pbA8T/p6nOJcvtBFCa0gr2CX3ROLjxdbLWJXLubuKjQJeGm7MgI=
X-Received: by 2002:a05:6e02:1be2:b0:348:1a1d:79a5 with SMTP id
 y2-20020a056e021be200b003481a1d79a5mr773169ilv.15.1691720556754; Thu, 10 Aug
 2023 19:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
 <ZNURN6Zzf2hJfmt/@debian>
In-Reply-To: <ZNURN6Zzf2hJfmt/@debian>
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Fri, 11 Aug 2023 07:52:25 +0530
Message-ID: <CALfBBTuRdwCcc-A88kMN7iub9BHx2xfFkfP8Lbrc+oSwfCS2nw@mail.gmail.com>
Subject: Re: CXL volatile memory is not listed
To: Fan Ni <fan.ni@gmx.us>
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=maverickk1778@gmail.com; helo=mail-il1-x12f.google.com
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

Thanks Fan,

cxl create-region works like a charm :)

Since this gets listed as "System Ram(kmem)", I guess the kernel
treats it as regular memory and
allocates it to the applications when needed?
or is there an extra effort needed to make it available for
applications on the host?

On Thu, 10 Aug 2023 at 22:03, Fan Ni <fan.ni@gmx.us> wrote:
>
> On Wed, Aug 09, 2023 at 04:21:47AM +0530, Maverickk 78 wrote:
> > Hello,
> >
> > I am running qemu-system-x86_64
> >
> > qemu-system-x86_64 --version
> > QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
> >
> > qemu-system-x86_64 \
> > -m 2G,slots=4,maxmem=4G \
> > -smp 4 \
> > -machine type=q35,accel=kvm,cxl=on \
> > -enable-kvm \
> > -nographic \
> > -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> > -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> > -object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=1G,share=true \
> > -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
> > -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G
> >
> >
> > I was expecting the CXL memory to be listed in "System Ram", the lsmem
> > shows only 2G memory which is System RAM, it's not listing the CXL
> > memory.
> >
> > Do I need to pass any particular parameter in the kernel command line?
> >
> > Is there any documentation available? I followed the inputs provided in
> >
> > https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/
> >
> > Is there any documentation/blog listed?
>
> If I remember it correctly, for volatile cxl memory, we need to create a
> region and then it will be discovered as system memory and shows up.
>
> Try to create a region with "cxl create-region".
>
> Fan
> >

