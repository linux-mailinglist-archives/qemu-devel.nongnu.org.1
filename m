Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC73078055C
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 07:08:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWrgp-000259-3p; Fri, 18 Aug 2023 01:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maverickk1778@gmail.com>)
 id 1qWrge-00022i-UA
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 01:06:18 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maverickk1778@gmail.com>)
 id 1qWrgZ-0008VS-0x
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 01:06:15 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79093c0c68bso18449139f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 22:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692335167; x=1692939967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NboQbtQRE5XDdhMnkEM71ABQBV691NoP08bDIdh5BUw=;
 b=LjzSKfzEf+EOM1nAfCjWlqmRO+D/qogIq2AMcQZRftaMiPmPPBiwQ8/G5LFvIFV21e
 34SSuQXwvPTMbhl/9gLwoOa0QlNlfg4qMYAs5K5uxJVy+0OwwffYS0yZ83DvzoD1S/Z0
 QxJpeqhDW0ch/8sDoje4YW55FB+lGAj8tMD9XpdEDOHWlCVtJHuLX/yIs1HUABJigv9t
 E4rrp0UWrJYWivuPzXfkoMytUeuDDnkaS+WEYisCtrbJPJInYcKZoz7xvXG5Zx1n/sYO
 itBrdoecDYd9UvUEmQmEdQf46d5tmrzOUHot2CaUgrebQibu2UlqAesdIj7aepnnHH5O
 LMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692335167; x=1692939967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NboQbtQRE5XDdhMnkEM71ABQBV691NoP08bDIdh5BUw=;
 b=Z8XXFGBIliDDCAMlHRHNpj2jNW2n51hFSQBCKMVnLs7ah3M1EdXLSBRIhl28mW0Iyx
 9/wNDtoNGy5m4LgY15NjJnGGgxnxYk1IjGfb9ndetTI5zw9ctd/1xCJaetKH4PSxuV5v
 gfeTdW4wd/k0v0U7lTaJftQFNG09Lju70WdwqWpbJKiQvY5QNEV4t4T2Q7UkN8+UBFDp
 NxV9N2+/shAl/xKXd/1981XSG/ih+PQLCkI2fTYJZVooODu6/VIX8ioG9gh6afrXqXVa
 5N0X3iHO3CUdWbJCzcLrFoUCp01C9Tlxb3L58jgdYhjvUB4p4jgvb/HjrL4zlC85H8v0
 4Hkg==
X-Gm-Message-State: AOJu0YybJ56DMgXZmkKGO+XZ2zG/V/3BaiUywqXc0guMqUPi79TZ3i/w
 5J7FKJJxhUawm5pLqbChvE9bEKCMRjpb56sI1po=
X-Google-Smtp-Source: AGHT+IEzTgQtlRE9ME3SFdyvKzpiw7CK/lAvGURrLFbtIgLbDE2hCAWegGqfz/NCGExhSY+l5AwL3a2CBK0p5BpKUL4=
X-Received: by 2002:a5e:8516:0:b0:790:aedd:3e81 with SMTP id
 i22-20020a5e8516000000b00790aedd3e81mr2027859ioj.8.1692335166798; Thu, 17 Aug
 2023 22:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
 <ZNURN6Zzf2hJfmt/@debian>
 <CALfBBTuRdwCcc-A88kMN7iub9BHx2xfFkfP8Lbrc+oSwfCS2nw@mail.gmail.com>
 <ZNZmbkx4A58CEl/i@debian>
In-Reply-To: <ZNZmbkx4A58CEl/i@debian>
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Fri, 18 Aug 2023 10:35:55 +0530
Message-ID: <CALfBBTvQJ8-zpyNyt9zXzd22XoRu+seQkff8t5w_gZps+aNr9w@mail.gmail.com>
Subject: Re: CXL volatile memory is not listed
To: Fan Ni <fan.ni@gmx.us>
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=maverickk1778@gmail.com; helo=mail-io1-xd36.google.com
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

Hi Fan

Awesome, thanks for the info!

On Fri, 11 Aug 2023 at 22:19, Fan Ni <fan.ni@gmx.us> wrote:
>
> On Fri, Aug 11, 2023 at 07:52:25AM +0530, Maverickk 78 wrote:
> > Thanks Fan,
> >
> > cxl create-region works like a charm :)
> >
> > Since this gets listed as "System Ram(kmem)", I guess the kernel
> > treats it as regular memory and
> > allocates it to the applications when needed?
> > or is there an extra effort needed to make it available for
> > applications on the host?
> >
>
> Yes. Once it is onlined, you can use it as regular memory.
> CXL memory will serve as a zero-CPU memory-only NUMA node.
> You can check it with numactl -H.
>
> To use the cxl memory with an app, you can use
> numactl --membind=numa_id app_name
> #numa_id is the dedicated numa node where cxl memory sits.
>
> One thing to notes, kvm will not work correctly with Qemu emulation when
> you try to use cxl memory for an application, so do not enable kvm.
>
> Fan
>
> > On Thu, 10 Aug 2023 at 22:03, Fan Ni <fan.ni@gmx.us> wrote:
> > >
> > > On Wed, Aug 09, 2023 at 04:21:47AM +0530, Maverickk 78 wrote:
> > > > Hello,
> > > >
> > > > I am running qemu-system-x86_64
> > > >
> > > > qemu-system-x86_64 --version
> > > > QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
> > > >
> > > > qemu-system-x86_64 \
> > > > -m 2G,slots=4,maxmem=4G \
> > > > -smp 4 \
> > > > -machine type=q35,accel=kvm,cxl=on \
> > > > -enable-kvm \
> > > > -nographic \
> > > > -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> > > > -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> > > > -object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=1G,share=true \
> > > > -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
> > > > -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G
> > > >
> > > >
> > > > I was expecting the CXL memory to be listed in "System Ram", the lsmem
> > > > shows only 2G memory which is System RAM, it's not listing the CXL
> > > > memory.
> > > >
> > > > Do I need to pass any particular parameter in the kernel command line?
> > > >
> > > > Is there any documentation available? I followed the inputs provided in
> > > >
> > > > https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/
> > > >
> > > > Is there any documentation/blog listed?
> > >
> > > If I remember it correctly, for volatile cxl memory, we need to create a
> > > region and then it will be discovered as system memory and shows up.
> > >
> > > Try to create a region with "cxl create-region".
> > >
> > > Fan
> > > >

