Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A1777951E
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:50:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVK9-0004rC-M1; Fri, 11 Aug 2023 12:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@gmx.us>) id 1qUVK7-0004qO-Kd
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:49:15 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@gmx.us>) id 1qUVK5-0000nn-Pd
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1691772539; x=1692377339; i=fan.ni@gmx.us;
 bh=A6M2hI18RBeWnhFAQRhVZSf9RInDyT+PXldHCI+QUUI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=W5Zd1Pi+/NrFLPrPIKxknGbIsNAalVJptPcYMTfW4ov28xf4UcnvhdFVPnlGpK62lypxJUp
 6i46MsbJkmG6K7v+kZJXpDajXl7tlCm86F8+pBvpOJDipXl3q9vvkygGdG/VPD9dzmcm/aXCi
 X0NZrOrjz1WDGbwHsf9XFIf7sPGEiHtUqt5W0SJKLgCKtyrH7qpLiqfqdKtAjWT7bSkZgSnj9
 GEb2S4cuj4qRVI6vjE1bljV8/8KHZBIDwhlfD3cVRAvpoEP4+ArS24Pta7sY/usj+k+QM2Xu3
 xWtM8dwEp+EovJxvzAJODuFeesa6W8nfmKGMoNuwDLT3WC9B2LJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([172.56.208.115]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgNcz-1prtEz3xiZ-00htYT; Fri, 11
 Aug 2023 18:48:59 +0200
Date: Fri, 11 Aug 2023 09:48:46 -0700
From: Fan Ni <fan.ni@gmx.us>
To: Maverickk 78 <maverickk1778@gmail.com>
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org
Subject: Re: CXL volatile memory is not listed
Message-ID: <ZNZmbkx4A58CEl/i@debian>
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
 <ZNURN6Zzf2hJfmt/@debian>
 <CALfBBTuRdwCcc-A88kMN7iub9BHx2xfFkfP8Lbrc+oSwfCS2nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALfBBTuRdwCcc-A88kMN7iub9BHx2xfFkfP8Lbrc+oSwfCS2nw@mail.gmail.com>
X-Provags-ID: V03:K1:Yy8qN3fEG+BVpiWgTnMrDPWSegn9up43HgU3mlQRVw5a46ISt6Z
 sSVmZFflpBzNHCoHzbdWOWOhTg9RnMvzsYciNph//0XFBdw6ui+U7v+4QBV4hrsW1MtHgk1
 FTuwVvRcc0rc99U171aLHbqdXINrCZzR7V7oyk9GUBEx2IqQqMeEln/3/E6JWewahGw7JUI
 M+LdUktDND9dL+tnPrdgA==
UI-OutboundReport: notjunk:1;M01:P0:8ErlSrVnU+w=;dXbu97I9r4m0nQqGcyzcM7rrhFJ
 IwB6POt3I3iuY+TndoQ1I4wOYKbJEZ3jiU1OIquZvElLuKTzXFvue7nXO2GEdgptYCBBK7VNc
 eSgK/YhxQU2fUPUaHsxE/5XgceCX7K34PPivbZ1rd1d2IxFhwsDOfnwGTUoFFWGnwTKCXlN/p
 rykTMYMuYwd7DKgna44DjVXlHFtIFyosXirkVsPxuhE1tVO5exjR0v+WaHjqBBfkRPpY/gF6P
 CU4LCXno+RB9fubiPPeL78zYdeKvkSBl/7MEsVGp279bvBn6gyI1bSEmg9J3jXwRh6Sus6cnm
 Ki9xKggv5F1myj283YqAUvWus9J+ObHA6smyNzzr5ebCj5sqVfsVkbOQGelqlP0E+H0Tk3slG
 vWMW33cLmUBeSPbHatKpWQwg+bnKJ9Ym8r8c+ib/51TuE91ZdJa0n/Sr60TICwCzx3cZ6OGpx
 nL0ITzEiu+kzF7EHHTqd4BwI6ggzQ3OdQS7Ig4vFatkRiXyMsj9wti6rNyBXZ2JfEIOEMankb
 scDU56VabcYmy5i+eHz70ziBl5nHUlsmn9GmW22jMbYux3gN8uNVrYfQlxOQsuVzXp2byDA+F
 BC25bPs8+67g3tj6mho6QCR3pihl/fOuH14gF7SaZeOUvtPcd83naMdgnRJhD+MfyNEzqkbGv
 qbqCgfZijr9aI4+Zw5ovXgYhRm7b8SJPMX+xLNQyD1+ozev+atI2Uy1AykDolOD/+3KvOLbLz
 dI+aFpg1/2s5K89AibXwCvheaZdCUTooEb5Yr/pj6/TABKHZqPyLIF2wqVB6vWzhoHZ5iAHoz
 YffjcP83hH0lsrTEg6+x/O6+fyJqtsfW9e6t0bPPGWlytrqB9yGwuqNFYI4DIq21N6jEkqa01
 7oS8+QSQptc6Hmsu/BRh4qcIMwvZVrgumw2xXAJUU6c3ef/W6kgWdA8N+5hZLWUqZ1s5nXKS9
 yLf70Tm70bGGWpOrp6yJ7fC9cyg=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.19; envelope-from=fan.ni@gmx.us;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 11, 2023 at 07:52:25AM +0530, Maverickk 78 wrote:
> Thanks Fan,
>
> cxl create-region works like a charm :)
>
> Since this gets listed as "System Ram(kmem)", I guess the kernel
> treats it as regular memory and
> allocates it to the applications when needed?
> or is there an extra effort needed to make it available for
> applications on the host?
>

Yes. Once it is onlined, you can use it as regular memory.
CXL memory will serve as a zero-CPU memory-only NUMA node.
You can check it with numactl -H.

To use the cxl memory with an app, you can use
numactl --membind=3Dnuma_id app_name
#numa_id is the dedicated numa node where cxl memory sits.

One thing to notes, kvm will not work correctly with Qemu emulation when
you try to use cxl memory for an application, so do not enable kvm.

Fan

> On Thu, 10 Aug 2023 at 22:03, Fan Ni <fan.ni@gmx.us> wrote:
> >
> > On Wed, Aug 09, 2023 at 04:21:47AM +0530, Maverickk 78 wrote:
> > > Hello,
> > >
> > > I am running qemu-system-x86_64
> > >
> > > qemu-system-x86_64 --version
> > > QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
> > >
> > > qemu-system-x86_64 \
> > > -m 2G,slots=3D4,maxmem=3D4G \
> > > -smp 4 \
> > > -machine type=3Dq35,accel=3Dkvm,cxl=3Don \
> > > -enable-kvm \
> > > -nographic \
> > > -device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D52 \
> > > -device cxl-rp,id=3Drp0,bus=3Dcxl.0,chassis=3D0,port=3D0,slot=3D0 \
> > > -object memory-backend-file,id=3Dmem0,mem-path=3D/tmp/mem0,size=3D1G=
,share=3Dtrue \
> > > -device cxl-type3,bus=3Drp0,volatile-memdev=3Dmem0,id=3Dcxl-mem0 \
> > > -M cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.size=3D1G
> > >
> > >
> > > I was expecting the CXL memory to be listed in "System Ram", the lsm=
em
> > > shows only 2G memory which is System RAM, it's not listing the CXL
> > > memory.
> > >
> > > Do I need to pass any particular parameter in the kernel command lin=
e?
> > >
> > > Is there any documentation available? I followed the inputs provided=
 in
> > >
> > > https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/
> > >
> > > Is there any documentation/blog listed?
> >
> > If I remember it correctly, for volatile cxl memory, we need to create=
 a
> > region and then it will be discovered as system memory and shows up.
> >
> > Try to create a region with "cxl create-region".
> >
> > Fan
> > >

