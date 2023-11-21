Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 541507F29D1
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:10:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5NhP-000785-90; Tue, 21 Nov 2023 05:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1r5NhL-00072z-GN; Tue, 21 Nov 2023 05:09:39 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1r5NhH-0003r4-DW; Tue, 21 Nov 2023 05:09:38 -0500
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3ALA96BM056246;
 Tue, 21 Nov 2023 18:09:06 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.51) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 21 Nov 2023
 18:09:05 +0800
Date: Tue, 21 Nov 2023 18:09:05 +0800
To: Alistair Francis <alistair23@gmail.com>
CC: <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <edgar.iglesias@gmail.com>, <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <in.meng@windriver.com>,
 <liweiwei@iscas.ac.cn>, <dbarboza@ventanamicro.com>,
 <hiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>,
 <peterx@redhat.com>, <david@redhat.com>
Subject: Re: [PATCH v3 1/4] hw/core: Add config stream
Message-ID: <ZVyBwVbNIGy52rB9@ethan84-VirtualBox>
References: <20231114094705.109146-1-ethan84@andestech.com>
 <20231114094705.109146-2-ethan84@andestech.com>
 <CAKmqyKOVpATp-pjkvqZtJHF3B0M5NpUJqDeyin8rVG8gpbtj4w@mail.gmail.com>
 <CAKmqyKNF199hEJ_tuHwj361b38RvOivyszVWDtCLUAbNSaQh9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKNF199hEJ_tuHwj361b38RvOivyszVWDtCLUAbNSaQh9Q@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.51]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3ALA96BM056246
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Nov 21, 2023 at 03:28:13PM +1000, Alistair Francis wrote:
> On Tue, Nov 21, 2023 at 3:24 PM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Tue, Nov 14, 2023 at 7:49 PM Ethan Chen via <qemu-devel@nongnu.org> wrote:
> > >
> > > Make other device can use /hw/core/stream.c by select this config.
> > >
> > > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > > ---
> > >  hw/core/Kconfig     | 3 +++
> > >  hw/core/meson.build | 1 +
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/hw/core/Kconfig b/hw/core/Kconfig
> > > index 9397503656..628dc3d883 100644
> > > --- a/hw/core/Kconfig
> > > +++ b/hw/core/Kconfig
> > > @@ -27,3 +27,6 @@ config REGISTER
> > >
> > >  config SPLIT_IRQ
> > >      bool
> > > +
> > > +config STREAM
> > > +    bool
> > > \ No newline at end of file
> >
> > You are missing a newline here. I think checkpatch should catch this,
> > make sure you run it on all of your patches

Sorry for that. It is wired that this was not catched by checkpatch.

> >
> > > diff --git a/hw/core/meson.build b/hw/core/meson.build
> > > index 67dad04de5..d6ce14d5ce 100644
> > > --- a/hw/core/meson.build
> > > +++ b/hw/core/meson.build
> > > @@ -34,6 +34,7 @@ system_ss.add(when: 'CONFIG_REGISTER', if_true: files('register.c'))
> > >  system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
> > >  system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
> > >  system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
> > > +system_ss.add(when: 'CONFIG_STREAM', if_true: files('stream.c'))
> >
> > You have added the build but not the file. This will fail to compile.
> >
> > Each patch must compile and run when applied individually in order.
> > That way we maintain git bisectability. Can you please make sure that
> > the build is not broken as your patches are applied
> 
> Whoops! The file already exists.
> 
> We should only include the file stream.c once. So we should change the
> CONFIG_XILINX_AXI to select CONFIG_STREAM in this patch
> 

I will fix that in next revision.

Thanks,
Ethan Chen

