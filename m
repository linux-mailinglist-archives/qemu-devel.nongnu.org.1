Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 083597C5670
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:11:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZvk-0003Qn-My; Wed, 11 Oct 2023 10:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qqZvd-0003Kc-RG
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:11:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qqZvY-000895-Nb
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:11:12 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5F6H5xhmz6K6hC;
 Wed, 11 Oct 2023 22:10:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 15:10:52 +0100
Date: Wed, 11 Oct 2023 15:10:51 +0100
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: Gregory Price <gregory.price@memverge.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: Accessing emulated CXL memory is unstable
Message-ID: <20231011151051.0000343c@Huawei.com>
In-Reply-To: <CAB=+i9S_uAUfPWSR2mJ=EzB-O2w-puK232CxbgWn8mx+YpMJCQ@mail.gmail.com>
References: <CAB=+i9S4NSJ7iNvqguWKvFvo=cMQC21KeNETsqmJoEpj+iDmig@mail.gmail.com>
 <ZSKupRw+mRrASUaY@memverge.com>
 <CAB=+i9S_uAUfPWSR2mJ=EzB-O2w-puK232CxbgWn8mx+YpMJCQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 11 Oct 2023 09:50:07 +0900
Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

> On Wed, Oct 11, 2023 at 12:54=E2=80=AFAM Gregory Price
> <gregory.price@memverge.com> wrote:
> >
> > On Tue, Oct 10, 2023 at 10:35:03AM +0900, Hyeonggon Yoo wrote: =20
> > > Hello folks,
> > >
> > > I experienced strange application crashes/internal KVM errors
> > > while playing with emulated type 3 CXL memory. I would like to know
> > > if this is a real issue or I missed something during setup.
> > >
> > > TL;DR: applications crash when accessing emulated CXL memory,
> > > and stressing VM subsystem causes KVM internal error
> > > (stressing via stress-ng --bigheap)
> > > =20
> > ... =20
> > >
> > > Hmm... it crashed, and it's 'invalid opcode'.
> > > Is this because the fetched instruction is different from what's
> > > written to memory during exec()?
> > > =20
> >
> > This is a known issue, and the working theory is 2 issues: =20
>=20
> Okay, at least it's a known issue. Thank you for confirming that!
Yeah - have an outstanding request in my list to at least print a
warning on this.  There are usecases where you want to use KVM
and the emulated support but there are gremlins as you discovered.

>=20
> >
> > 1) CXL devices are implemented on top of an MMIO-style dispatch system
> >    and as a result memory from CXL is non-cacheable.  We think there
> >    may be an issue with this in KVM but it hasn't been investigated
> >    fully.
> >
> > 2) When we originally got CXL memory support, we discovered an edge case
> >    where code pages hosted on CXL memory would cause a crash whenever an
> >    instruction spanned across a page barrier.  A similar issue could
> >    affect KVM.

The TCG case was thought to be fixed.  KVM will indeed blow up if you
try to run instructions out of the emulated CXL memory whether or not they
cross page boundaries.  That could be fixed by a caching layer inbetween
so KVM thought it was running on page based translation but CXL was
doing some interesting write back stuff underneath. Can sort of see how
it might work but it's complex.

> >
> > We haven't done much research into the problem beyond this.  For now, we
> > all just turn KVM off while we continue development. =20
>=20
> Thank you for summarizing the current state of the issue.
> Hope it will be resolved! ;)

Any resolution whilst retaining the full routing / decoder emulation in
QEMU is tricky to put it lightly.  No one has taken it on yet as mostly
TCG get's us going.

>=20
> But I'm not sure if turning off KVM solves the problem.
> `numactl --membind=3D1 --show` works fine, but other basic UNIX commands =
like ls
> crashes QEMU when it's bind to the CXL NUMA node.

Hmm. This is new if KVM is definitely off?

>=20
> [root@localhost ~]# numactl --membind=3D1 --show
> policy: bind
> preferred node: 1
> physcpubind: 0
> cpubind: 0
> nodebind: 0
> membind: 1
> [root@localhost ~]# numactl --membind=3D1 ls
>=20
> qemu: fatal: cpu_io_recompile: could not find TB for pc=3D(nil)
> RAX=3D0000777f80000000 RBX=3D0000000000000000 RCX=3D0000000000000028
> RDX=3D0000000000000000
> RSI=3D0000000000000354 RDI=3D0000000000000000 RBP=3Dffff88810628af40
> RSP=3Dffffc900008cfd20
> R8 =3Dffff88810628af40 R9 =3Dffffc900008cfcc4 R10=3D000000000000000d
> R11=3D0000000000000000
> R12=3D0000000390440000 R13=3Dffff888107a464c0 R14=3D0000000000000000
> R15=3Dffff88810a49cd18
> RIP=3Dffffffff810743e6 RFL=3D00000007 [-----PC] CPL=3D0 II=3D0 A20=3D1 SM=
M=3D0 HLT=3D0
> ES =3D0000 0000000000000000 00000000 00000000
> CS =3D0010 0000000000000000 ffffffff 00af9b00 DPL=3D0 CS64 [-RA]
> SS =3D0000 0000000000000000 00000000 00000000
> DS =3D0000 0000000000000000 00000000 00000000
> FS =3D0000 0000000000000000 00000000 00000000
> GS =3D0000 ffff88817bc00000 00000000 00000000
> LDT=3D0000 0000000000000000 00000000 00008200 DPL=3D0 LDT
> TR =3D0040 fffffe0000003000 00004087 00008900 DPL=3D0 TSS64-avl
> GDT=3D     fffffe0000001000 0000007f
> IDT=3D     fffffe0000000000 00000fff
> CR0=3D80050033 CR2=3D00007fcb2504641c CR3=3D0000000390440000 CR4=3D007506=
f0
> DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
> DR3=3D0000000000000000
> DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
> CCS=3D0000777f80000000 CCD=3D0000000390440000 CCO=3DADDQ
> EFER=3D0000000000000d01
> FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80
> FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
> FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
> FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
> FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000
> YMM00=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> YMM01=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> YMM02=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> YMM03=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> YMM04=3D0000000000000000 0000000000000000 00006968705f6e6f 657800006c6c65=
77
> YMM05=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> YMM06=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> YMM07=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> YMM08=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> YMM09=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> YMM10=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> YMM11=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> YMM12=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> YMM13=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> YMM14=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> YMM15=3D0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> cxl2.sh: line 24:  5386 Aborted                 (core dumped) $QEMU
> -cpu Cascadelake-Server -smp 1 -M q35,cxl=3Don -m 4G,maxmem=3D8G,slots=3D4
> -object memory-backend-ram,id=3Dvmem0,share=3Don,size=3D4G -device pxb-cc
>=20
> --
> Cheers,
> Hyeonggon
>=20


