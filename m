Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C980F780592
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 07:20:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWrsq-0002P8-JC; Fri, 18 Aug 2023 01:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maverickk1778@gmail.com>)
 id 1qWrso-0002Ol-5C
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 01:18:50 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maverickk1778@gmail.com>)
 id 1qWrsl-0005IW-GU
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 01:18:49 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-791262638ffso18353839f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 22:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692335926; x=1692940726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JK+gBhk7ou2vM8OJCNjC7ow3npc46slZN3uDwrJ33U8=;
 b=M/wbtaAA0yxSO/92hYgcrte3WLiq90mtzLpuT2dSafTCaQQAXAdYl4EFNDOJ4FzpKs
 D5ihTLwHLX2HyLdGMU/hECD3rZQiIl7RgFTgkOlhr+d31fMi//8PgYQZRfjISz8Q51Nh
 CfX9dGPifirF6Iv3mCrTgMzNeZ6HmgZs986BlEXfuNmZZ4h+9vzvUbpFGsXeWUJyyoFC
 aBLwx5OCzCfPFmR9rg7MGkR8KOCpNh8YTiD5i+xeZNEd1t3lbDEBROliO5dYMp5r7Vwf
 JEN760aIrq8tjk9ohEfEkTW3BP6ODjoX64ioYUBnIGt7VAIr7oHi+3QEPNwadH9JYrrn
 nY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692335926; x=1692940726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JK+gBhk7ou2vM8OJCNjC7ow3npc46slZN3uDwrJ33U8=;
 b=gXgnem0svXdWfcOcwVEeqUHQCIZrpXlpeVISClCNOhyh29Me9C1/DVpxuW1/9JHhoN
 MnghXI55U3OfJcoZlE7Lbz0BfcQ5KmFcvr3F9S5zVX8/GlUONbWZ1kwsWojRGSs0v9eT
 45ogF+AgWUM2b60MK+0XzENqv0j/1lsSjBZY2Rc+7C973bJ8kn2DjWgAdorGtZo2869m
 oFoiWG8SziKSdgaZSUcDWcJNFUWPXJnt6Xr9RXm2cQSoFwMO2MqzGlJq+U/LmXiXRCYY
 UpwjtuCSplalZ/bnAGXLHoZlPaeT7UsWjuz9qCs7/iiU+QZ/CXJr5zF83uBBebAkInzz
 OZzQ==
X-Gm-Message-State: AOJu0YzODO4MNo3UQfMAPh5Cj3gILPyTgAA51mW53moIce9UVDxlmIYF
 I0fxPrff5InK9J3PeOHc/IBikUXAG2wnclkiZho=
X-Google-Smtp-Source: AGHT+IEjKTA8YlfWuuFj1c3pLILaXVZg8U9xsCvi+zdw25t8MAf7/uLYvNBu1iEb+FXIGHL0omy4dh4eYefjZg0ccMI=
X-Received: by 2002:a6b:701a:0:b0:791:1028:2dcf with SMTP id
 l26-20020a6b701a000000b0079110282dcfmr1894092ioc.10.1692335925901; Thu, 17
 Aug 2023 22:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
 <20230810113512.00000516@Huawei.com>
 <CALfBBTud4Y7qxKB8nkZ5Lo5sQs-7-F9Rkso+iQGvLO07VyRcDA@mail.gmail.com>
 <20230811145458.000029c7@Huawei.com>
In-Reply-To: <20230811145458.000029c7@Huawei.com>
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Fri, 18 Aug 2023 10:48:35 +0530
Message-ID: <CALfBBTsMLP8_eTfmFt5mB+ywF1D0WTR7m=PBqUVzhhvcwC+zYA@mail.gmail.com>
Subject: Re: CXL volatile memory is not listed
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=maverickk1778@gmail.com; helo=mail-io1-xd34.google.com
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

Hi Jonathan,

The use case of CXL switch will always need some sort of management
agent + FM configuring the available CXL memory connected.

In most cases it would be bmc controller configuring MLD/MHD's to
host, and in very rare scenarios it may be one of the host interacting
with FM firmware inside the switch which would do the trick.

Another use case is static hardcoding between CXL memory & host in
built in cxl switch

There is no scenario where one of the host BIOS can push the select
CXL memory to itself.


Is my understanding correct?



On Fri, 11 Aug 2023 at 19:25, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 11 Aug 2023 08:04:26 +0530
> Maverickk 78 <maverickk1778@gmail.com> wrote:
>
> > Jonathan,
> >
> > > More generally for the flow that would bring the memory up as system ram
> > > you would typically need the bios to have done the CXL enumeration or
> > > a bunch of scripts in the kernel to have done it.  In general it can't
> > > be fully automated, because there are policy decisions to make on things like
> > > interleaving.
> >
> > BIOS CXL enumeration? is CEDT not enough? or BIOS further needs to
> > create an entry
> > in the e820 table?
> On intel platforms 'maybe' :)  I know how it works on those that just
> use the nice standard EFI tables - less familiar with the e820 stuff :)
>
> CEDT says where to find the the various bits of system related CXL stuff.
> Nothing in there on the configuration that should be used such as interleaving
> as that depends on what the administrator wants. Or on what the BIOS has
> decided the users should have.
>
> >
> > >
> > > I'm not aware of any open source BIOSs that do it yet.  So you have
> > > to rely on the same kernel paths as for persistent memory - manual configuration
> > > etc in the kernel.
> > >
> > Manual works with "cxl create regiton"  :)
> Great.
>
> Jonathan
>
> >
> > On Thu, 10 Aug 2023 at 16:05, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Wed, 9 Aug 2023 04:21:47 +0530
> > > Maverickk 78 <maverickk1778@gmail.com> wrote:
> > >
> > > > Hello,
> > > >
> > > > I am running qemu-system-x86_64
> > > >
> > > > qemu-system-x86_64 --version
> > > > QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
> > > >
> > > +Cc linux-cxl as the answer is more todo with linux than qemu.
> > >
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
> > >
> > > There are some problems upstream at the moment (probably not cxl related but
> > > I'm digging). So today I can't boot an x86 machine. (goody)
> > >
> > >
> > > More generally for the flow that would bring the memory up as system ram
> > > you would typically need the bios to have done the CXL enumeration or
> > > a bunch of scripts in the kernel to have done it.  In general it can't
> > > be fully automated, because there are policy decisions to make on things like
> > > interleaving.
> > >
> > > I'm not aware of any open source BIOSs that do it yet.  So you have
> > > to rely on the same kernel paths as for persistent memory - manual configuration
> > > etc in the kernel.
> > >
> > > There is support in ndctl for those enabling flows, so I'd look there
> > > for more information
> > >
> > > Jonathan
> > >
> > >
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
>

