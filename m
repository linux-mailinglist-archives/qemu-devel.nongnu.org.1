Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5F07C46FE
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 03:04:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqNdM-0003de-7I; Tue, 10 Oct 2023 21:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1qqNQd-0005YV-CG
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 20:50:23 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1qqNQa-0003e9-Ld
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 20:50:23 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7b5f0bbe137so697858241.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 17:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696985419; x=1697590219; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPKgkr91uM5AObuWaBYVQhYKDTMWlaMX8cV3B9ISbDc=;
 b=ihSrnFbMaZewwDHg1qoYDy8t7Q+awBDjDDYaR926CWDTf8RuXCscF23UZDJgcnQi9l
 ynmpzlNkeTtpjFLmShjhmjKzOzgBM8PRhha5cePquv70ZtJSs15G1UYTJB70JP8b8vKg
 yXu/R4ZyqrnwKeUtdENi+/K/2Kk4Y4fFKXogZHxblNirkm8u5a8IJnzuEH0sAUWV5vRU
 VdCgR+gy4IcDfMs9/zA+rB/eTVmi1yGxWuZHRGLCiP5j2pChk4i7b0xG6XG2AI2NoiqF
 nGb6tscXT94OrQHRNy7SU2GZX5ZlHDbCq3lvlscIy0NxzlqID0KqqVIgHjEDNnny+DkP
 IwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696985419; x=1697590219;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rPKgkr91uM5AObuWaBYVQhYKDTMWlaMX8cV3B9ISbDc=;
 b=advHdcDGwtTSvzN7nrJIgoEXjS3yoZG2ODJYxn9EfzbQiuiRdm4fXkr8QevETIjzFd
 i23ldDsog2g5EKyPEn9ajZIWCy0QTCHWSTe0Uzt1KdgeAnKwj7Y2DZcDNZqpqAe8RLvP
 BewbNicIqNWYWFqR++wrYYzH8Qg7rN1VK72VOzXov+yY+Mg2h+6pUppKipyoT42AISTa
 W9EhbP/3x8B5SuDWOD7vtpy8WsD7/khgyjgczb8/nXtFPQMZRdsyy0/blPRxy9agjLG4
 XFasrhvYnwAV1+fFkBlUT7ApJSzuH0ASMH64GO/oXntk07AonqD+drtnbYW2nqa1q5BN
 EkVw==
X-Gm-Message-State: AOJu0Yz2SObLBJcUBgqEVNVqutpk9wP4uE9ZbkKJENbhNmbEhT6KC+Q2
 qLK4ciq3W0GGpUd+1yxb2dvUS+wu/aObjMQ4Zkw=
X-Google-Smtp-Source: AGHT+IH0+uz17t03KroJwYQWYgJWtkEyt4arP89HpZ6Zo55Q8JtOleCM3pI4UUxZYvAf4kyHQuWXnOwZuylTagfXCYs=
X-Received: by 2002:a67:cd95:0:b0:452:6c9d:89e8 with SMTP id
 r21-20020a67cd95000000b004526c9d89e8mr19040600vsl.21.1696985419293; Tue, 10
 Oct 2023 17:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAB=+i9S4NSJ7iNvqguWKvFvo=cMQC21KeNETsqmJoEpj+iDmig@mail.gmail.com>
 <ZSKupRw+mRrASUaY@memverge.com>
In-Reply-To: <ZSKupRw+mRrASUaY@memverge.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Wed, 11 Oct 2023 09:50:07 +0900
Message-ID: <CAB=+i9S_uAUfPWSR2mJ=EzB-O2w-puK232CxbgWn8mx+YpMJCQ@mail.gmail.com>
Subject: Re: Accessing emulated CXL memory is unstable
To: Gregory Price <gregory.price@memverge.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 10 Oct 2023 21:03:30 -0400
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

On Wed, Oct 11, 2023 at 12:54=E2=80=AFAM Gregory Price
<gregory.price@memverge.com> wrote:
>
> On Tue, Oct 10, 2023 at 10:35:03AM +0900, Hyeonggon Yoo wrote:
> > Hello folks,
> >
> > I experienced strange application crashes/internal KVM errors
> > while playing with emulated type 3 CXL memory. I would like to know
> > if this is a real issue or I missed something during setup.
> >
> > TL;DR: applications crash when accessing emulated CXL memory,
> > and stressing VM subsystem causes KVM internal error
> > (stressing via stress-ng --bigheap)
> >
> ...
> >
> > Hmm... it crashed, and it's 'invalid opcode'.
> > Is this because the fetched instruction is different from what's
> > written to memory during exec()?
> >
>
> This is a known issue, and the working theory is 2 issues:

Okay, at least it's a known issue. Thank you for confirming that!

>
> 1) CXL devices are implemented on top of an MMIO-style dispatch system
>    and as a result memory from CXL is non-cacheable.  We think there
>    may be an issue with this in KVM but it hasn't been investigated
>    fully.
>
> 2) When we originally got CXL memory support, we discovered an edge case
>    where code pages hosted on CXL memory would cause a crash whenever an
>    instruction spanned across a page barrier.  A similar issue could
>    affect KVM.
>
> We haven't done much research into the problem beyond this.  For now, we
> all just turn KVM off while we continue development.

Thank you for summarizing the current state of the issue.
Hope it will be resolved! ;)

But I'm not sure if turning off KVM solves the problem.
`numactl --membind=3D1 --show` works fine, but other basic UNIX commands li=
ke ls
crashes QEMU when it's bind to the CXL NUMA node.

[root@localhost ~]# numactl --membind=3D1 --show
policy: bind
preferred node: 1
physcpubind: 0
cpubind: 0
nodebind: 0
membind: 1
[root@localhost ~]# numactl --membind=3D1 ls

qemu: fatal: cpu_io_recompile: could not find TB for pc=3D(nil)
RAX=3D0000777f80000000 RBX=3D0000000000000000 RCX=3D0000000000000028
RDX=3D0000000000000000
RSI=3D0000000000000354 RDI=3D0000000000000000 RBP=3Dffff88810628af40
RSP=3Dffffc900008cfd20
R8 =3Dffff88810628af40 R9 =3Dffffc900008cfcc4 R10=3D000000000000000d
R11=3D0000000000000000
R12=3D0000000390440000 R13=3Dffff888107a464c0 R14=3D0000000000000000
R15=3Dffff88810a49cd18
RIP=3Dffffffff810743e6 RFL=3D00000007 [-----PC] CPL=3D0 II=3D0 A20=3D1 SMM=
=3D0 HLT=3D0
ES =3D0000 0000000000000000 00000000 00000000
CS =3D0010 0000000000000000 ffffffff 00af9b00 DPL=3D0 CS64 [-RA]
SS =3D0000 0000000000000000 00000000 00000000
DS =3D0000 0000000000000000 00000000 00000000
FS =3D0000 0000000000000000 00000000 00000000
GS =3D0000 ffff88817bc00000 00000000 00000000
LDT=3D0000 0000000000000000 00000000 00008200 DPL=3D0 LDT
TR =3D0040 fffffe0000003000 00004087 00008900 DPL=3D0 TSS64-avl
GDT=3D     fffffe0000001000 0000007f
IDT=3D     fffffe0000000000 00000fff
CR0=3D80050033 CR2=3D00007fcb2504641c CR3=3D0000000390440000 CR4=3D007506f0
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
DR3=3D0000000000000000
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
CCS=3D0000777f80000000 CCD=3D0000000390440000 CCO=3DADDQ
EFER=3D0000000000000d01
FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80
FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000
YMM00=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM01=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM02=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM03=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM04=3D0000000000000000 0000000000000000 00006968705f6e6f 657800006c6c6577
YMM05=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM06=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM07=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM08=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM09=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM10=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM11=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM12=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM13=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM14=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
YMM15=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000
cxl2.sh: line 24:  5386 Aborted                 (core dumped) $QEMU
-cpu Cascadelake-Server -smp 1 -M q35,cxl=3Don -m 4G,maxmem=3D8G,slots=3D4
-object memory-backend-ram,id=3Dvmem0,share=3Don,size=3D4G -device pxb-cc

--
Cheers,
Hyeonggon

