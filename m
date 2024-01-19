Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C70A88325D4
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 09:38:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQkNG-0007xh-1y; Fri, 19 Jan 2024 03:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1rQkN7-0007xE-JW
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 03:37:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1rQkN5-0007BB-BP
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 03:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705653422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkOSqHOURncpH4YybVJaiGFAFfcHoU8jgk3GrFSoK2c=;
 b=Xng7DSvWakH9dhhTgKxhyQm+fiSHYp/hMkrdrm9XwZbuaLvqyv48pzPrfZg/QbZcqPnKhu
 2sncitXWXAUx4hx646yyQJgDgWCtcn5D/Jhkqda7mPXAOxG5Bk7gwIb3wkXI4FFbvkASm2
 QB0lKFdHOZmg/qX18/Na9tOXtfivxNc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-Cfpdwg72OYKTG7oA9Y5cCw-1; Fri, 19 Jan 2024 03:35:26 -0500
X-MC-Unique: Cfpdwg72OYKTG7oA9Y5cCw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2cd853c15adso5125761fa.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 00:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705653325; x=1706258125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkOSqHOURncpH4YybVJaiGFAFfcHoU8jgk3GrFSoK2c=;
 b=QAkGUp27JCmInOrYqMadRfbiKZdmxda0nab09r9QuZWS718MiNjmrV2PdKFjvozSTZ
 JV6HgqjnycbbVomUC/TxcTsZAnEZqhHL+RWpVTAn7QMuSYxfbmjc63kFTAFkauNp1H68
 erkyyHS2mRPwyfl0lGZPXs7AT83vKu4IBoSrLVyPr1PYY1CWzCP77ZF3/nxbgW75ovCI
 Itn3N6EEXa9tTjTFGOEuQDp8NIBNZund1PUIrSQE+x+pkPNHBh2ThJJup3rljbzWAA3G
 AOON01eIrbl8MXxYDb+iNqlMkv03vttktiIWRkzYHansGxIbVfi2kmJ3jv9ivHVZrQUF
 W2LQ==
X-Gm-Message-State: AOJu0Yx6suArl10RgavMUsE1xg7+nFjvM+NZCoyGyRCdbAOusoQmBEDF
 uf90fIEjVvVhppctU4n/tdche88bt2tFZpH6JXKNoGZAFS/ibehRHbJjRCNXohJSpUH/aNbsGqn
 PGjX2Exj+VD4wat/fsCiBLFF0MGQb8Lb3LrV+Iq/IJodw3kk6XRUWaz2QVGj4HFQhbedQEIGqP9
 EU9v9h5umKJlLFxqlE7Dp+p0jCE9E=
X-Received: by 2002:a2e:7015:0:b0:2cc:ef7a:9b7d with SMTP id
 l21-20020a2e7015000000b002ccef7a9b7dmr1173877ljc.39.1705653325472; 
 Fri, 19 Jan 2024 00:35:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB1l0qNRVNco4NKTk/cn8LMCU3T9UCdIS98q0S8/erxwmh63ViEFl5PZUx2OKXA9D97cNY5y2NjP3JYsw6h+0=
X-Received: by 2002:a2e:7015:0:b0:2cc:ef7a:9b7d with SMTP id
 l21-20020a2e7015000000b002ccef7a9b7dmr1173807ljc.39.1705653319534; Fri, 19
 Jan 2024 00:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20240117135554.787344-1-david@redhat.com>
 <20240117135554.787344-3-david@redhat.com>
 <CAJFLiBKiW0S5GJVvcYv2O3YtVSxmqzp1=1W10T_gnoxgOaWGBw@mail.gmail.com>
In-Reply-To: <CAJFLiBKiW0S5GJVvcYv2O3YtVSxmqzp1=1W10T_gnoxgOaWGBw@mail.gmail.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Fri, 19 Jan 2024 09:35:08 +0100
Message-ID: <CAMXpfWsmBK3ceM_j_+DD7qtqs_GV84Narm8uqq_DkJc1yX2YEg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] memory-device: reintroduce memory region size check
To: Zhenyu Zhang <zhenyzha@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Michal Privoznik <mprivozn@redhat.com>, shan.gavin@gmail.com, 
 Guowen Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This series has also been successfully tested in x86_64.

Tested-by: Mario Casquero <mcasquer@redhat.com>

On Thu, Jan 18, 2024 at 4:08=E2=80=AFAM Zhenyu Zhang <zhenyzha@redhat.com> =
wrote:
>
> [PATCH v1 2/2] memory-device: reintroduce memory region size check
>
> Test on 64k basic page size aarch64
> The patches work well on my Ampere host.
> The test results are as expected.
>
> (a) 1M with 512M THP
> /home/zhenyzha/sandbox/qemu.main/build/qemu-system-aarch64 \
> -name 'avocado-vt-vm1'  \
> -sandbox on \
> :
> -nodefaults \
> -m 4096,maxmem=3D32G,slots=3D4 \
> -object memory-backend-ram,id=3Dmem1,size=3D1M \
> -device pc-dimm,id=3Ddimm1,memdev=3Dmem1 \
> -smp 4  \
> -cpu 'host' \
> -accel kvm \
> -monitor stdio
> -> backend memory size must be multiple of 0x200000
>
> (b) 1G+1byte
> /home/zhenyzha/sandbox/qemu.main/build/qemu-system-aarch64 \
> -name 'avocado-vt-vm1'  \
> -sandbox on \
> :
> -nodefaults \
> -m 4096,maxmem=3D32G,slots=3D4 \
> -object memory-backend-ram,id=3Dmem1,size=3D1073741825B \
> -device pc-dimm,id=3Ddimm1,memdev=3Dmem1 \
> -smp 4  \
> -cpu 'host' \
> -accel kvm \
> -monitor stdio
> -> backend memory size must be multiple of 0x200000
>
> (c) Unliagned hugetlb size (2M)
> /home/zhenyzha/sandbox/qemu.main/build/qemu-system-aarch64 \
> -name 'avocado-vt-vm1'  \
> -sandbox on \
> :
> -nodefaults \
> -m 4096,maxmem=3D32G,slots=3D4 \
> -object memory-backend-file,id=3Dmem1,prealloc=3Dyes,mem-path=3D/mnt/kvm_=
hugepage,size=3D2047M
> \
> -device pc-dimm,id=3Ddimm1,memdev=3Dmem1 \
> -smp 4  \
> -cpu 'host' \
> -accel kvm \
> -monitor stdio
> -> backend memory size must be multiple of 0x200000
>
> (d)  2M with 512M hugetlb size
> /home/zhenyzha/sandbox/qemu.main/build/qemu-system-aarch64 \
> -name 'avocado-vt-vm1'  \
> -sandbox on \
> :
> -nodefaults \
> -m 4096,maxmem=3D32G,slots=3D4 \
> -object memory-backend-file,id=3Dmem1,mem-path=3D/dev/hugepages/tmp,size=
=3D2M \
> -device pc-dimm,id=3Ddimm1,memdev=3Dmem1 \
> -smp 4  \
> -cpu 'host' \
> -accel kvm \
> -monitor stdio
> -> memory size 0x200000 must be equal to or larger than page size 0x20000=
000
>
> (e)  511M with 512M hugetlb size
> /home/zhenyzha/sandbox/qemu.main/build/qemu-system-aarch64 \
> -name 'avocado-vt-vm1'  \
> -sandbox on \
> :
> -nodefaults \
> -m 4096,maxmem=3D32G,slots=3D4 \
> -object memory-backend-file,id=3Dmem1,mem-path=3D/dev/hugepages/tmp,size=
=3D511M \
> -device pc-dimm,id=3Ddimm1,memdev=3Dmem1 \
> -smp 4  \
> -cpu 'host' \
> -accel kvm \
> -monitor stdio
> -> memory size 0x1ff00000 must be equal to or larger than page size 0x200=
00000
>
> Tested-by: Zhenyu Zhang <zhenzha@redhat.com>
>
>
>
> On Wed, Jan 17, 2024 at 9:56=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > We used to check that the memory region size is multiples of the overal=
l
> > requested address alignment for the device memory address.
> >
> > We removed that check, because there are cases (i.e., hv-balloon) where
> > devices unconditionally request an address alignment that has a very la=
rge
> > alignment (i.e., 32 GiB), but the actual memory device size might not b=
e
> > multiples of that alignment.
> >
> > However, this change:
> >
> > (a) allows for some practically impossible DIMM sizes, like "1GB+1 byte=
".
> > (b) allows for DIMMs that partially cover hugetlb pages, previously
> >     reported in [1].
> >
> > Both scenarios don't make any sense: we might even waste memory.
> >
> > So let's reintroduce that check, but only check that the
> > memory region size is multiples of the memory region alignment (i.e.,
> > page size, huge page size), but not any additional memory device
> > requirements communicated using md->get_min_alignment().
> >
> > The following examples now fail again as expected:
> >
> > (a) 1M with 2M THP
> >  qemu-system-x86_64 -m 4g,maxmem=3D16g,slots=3D1 -S -nodefaults -nograp=
hic \
> >                      -object memory-backend-ram,id=3Dmem1,size=3D1M \
> >                      -device pc-dimm,id=3Ddimm1,memdev=3Dmem1
> >  -> backend memory size must be multiple of 0x200000
> >
> > (b) 1G+1byte
> >
> >  qemu-system-x86_64 -m 4g,maxmem=3D16g,slots=3D1 -S -nodefaults -nograp=
hic \
> >                    -object memory-backend-ram,id=3Dmem1,size=3D10737418=
25B \
> >                    -device pc-dimm,id=3Ddimm1,memdev=3Dmem1
> >  -> backend memory size must be multiple of 0x200000
> >
> > (c) Unliagned hugetlb size (2M)
> >
> >  qemu-system-x86_64 -m 4g,maxmem=3D16g,slots=3D1 -S -nodefaults -nograp=
hic \
> >                    -object memory-backend-file,id=3Dmem1,mem-path=3D/de=
v/hugepages/tmp,size=3D511M \
> >                    -device pc-dimm,id=3Ddimm1,memdev=3Dmem1
> >  backend memory size must be multiple of 0x200000
> >
> > (d) Unliagned hugetlb size (1G)
> >
> >  qemu-system-x86_64 -m 4g,maxmem=3D16g,slots=3D1 -S -nodefaults -nograp=
hic \
> >                     -object memory-backend-file,id=3Dmem1,mem-path=3D/d=
ev/hugepages1G/tmp,size=3D2047M \
> >                     -device pc-dimm,id=3Ddimm1,memdev=3Dmem1
> >  -> backend memory size must be multiple of 0x40000000
> >
> > Note that this fix depends on a hv-balloon change to communicate its
> > additional alignment requirements using get_min_alignment() instead of
> > through the memory region.
> >
> > [1] https://lkml.kernel.org/r/f77d641d500324525ac036fe1827b3070de75fc1.=
1701088320.git.mprivozn@redhat.com
> >
> > Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
> > Reported-by: Michal Privoznik <mprivozn@redhat.com>
> > Fixes: eb1b7c4bd413 ("memory-device: Drop size alignment check")
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  hw/mem/memory-device.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> > index a1b1af26bc..e098585cda 100644
> > --- a/hw/mem/memory-device.c
> > +++ b/hw/mem/memory-device.c
> > @@ -374,6 +374,20 @@ void memory_device_pre_plug(MemoryDeviceState *md,=
 MachineState *ms,
> >          goto out;
> >      }
> >
> > +    /*
> > +     * We always want the memory region size to be multiples of the me=
mory
> > +     * region alignment: for example, DIMMs with 1G+1byte size don't m=
ake
> > +     * any sense. Note that we don't check that the size is multiples
> > +     * of any additional alignment requirements the memory device migh=
t
> > +     * have when it comes to the address in physical address space.
> > +     */
> > +    if (!QEMU_IS_ALIGNED(memory_region_size(mr),
> > +                         memory_region_get_alignment(mr))) {
> > +        error_setg(errp, "backend memory size must be multiple of 0x%"
> > +                   PRIx64, memory_region_get_alignment(mr));
> > +        return;
> > +    }
> > +
> >      if (legacy_align) {
> >          align =3D *legacy_align;
> >      } else {
> > --
> > 2.43.0
> >
>


