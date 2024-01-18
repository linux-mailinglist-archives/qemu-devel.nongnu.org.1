Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 751978311A9
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:11:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQIn8-00013J-Hn; Wed, 17 Jan 2024 22:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha@redhat.com>)
 id 1rQIn4-000137-EI
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:10:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha@redhat.com>)
 id 1rQIn1-00055w-Lt
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705547397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YzTi1I7g8xi8ZtKiAX4ChWU5hdWJqG7Cbe/0Dum9+/M=;
 b=WQ5cfyfkwpTsU1jRjtK2y5JRiEiUGA9p2pUc9BycQyNEEVWn7iAkgaeK18weid2gWprTQr
 w/8vKbMgoStZRM4TPigX2EoVGiCIaXYimiOYPP4YE5P5yj5/Xb1JG9H8N3NRyQlFTrEzct
 IlbzZwRvC1PRi3dzmGEnFmmm5I5ZGrs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-8HHkGZjkM2q9W8qw5hZsfQ-1; Wed, 17 Jan 2024 22:08:45 -0500
X-MC-Unique: 8HHkGZjkM2q9W8qw5hZsfQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2b047e8f9fso492828666b.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705547324; x=1706152124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzTi1I7g8xi8ZtKiAX4ChWU5hdWJqG7Cbe/0Dum9+/M=;
 b=NFpBbB131YxY3aS/UFDZ+WMdIVtKi0VGTqvWtBOtxXUB6vyIbsQtTVVi1FdmJ8SfDD
 lq/RPRVfP8icnl1DT5RezfqLu97drpwjsF8aSciKxemYFIG1GJBQZITGvYsiqENahjDH
 1GwB8Tl5lGnO8Heu9ygyNwspbOCh1yNWgy7CQFwZaOnKwziUcTA3jwVyYjkDpkFTDhyE
 qD1iCSk016mUL0xlvwkLDkFYunsQgGW7IZ42KnZt10ryAWvE8hS1W2j0OSy+WcJ6I4YU
 sUprDe7oHkQBCF130KjqNnDiRLlKqyzPlNi9Ribyh8Qv+QujH8FlX9mEDD1aHEM8pCnO
 cCaw==
X-Gm-Message-State: AOJu0YwUnY9u4jqWweBK6OqBeHcGgB4x7KAv4rLNJZ2Gr3RzfZF64TJ6
 ppGOQzxi1wCSxN8pLk3bHMU04454NfcI8rZYKzCFPgiBf39bs9ya2Yki1VWcy9qOu284Te5pEMC
 r8EmTzdGLp8nDkmnOhKtMBp1ap66mhLjWpOGwIF2arbM9jy+DS7EOQeq2b9c576iMBsxbKLG6rO
 2Yd0xk2ZgjJBh9X3Wb+4lNId39yEE=
X-Received: by 2002:a17:907:1602:b0:a2d:15e:873c with SMTP id
 cw2-20020a170907160200b00a2d015e873cmr105193ejd.15.1705547324388; 
 Wed, 17 Jan 2024 19:08:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnCK0XHO1oNzZprQ47EWJrP0c3sh1dJ0Q8rewHkCsRoraObr8A9MVflaGqbuCM73RXT5Rao5RqP8tPwltving=
X-Received: by 2002:a17:907:1602:b0:a2d:15e:873c with SMTP id
 cw2-20020a170907160200b00a2d015e873cmr105189ejd.15.1705547324041; Wed, 17 Jan
 2024 19:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20240117135554.787344-1-david@redhat.com>
 <20240117135554.787344-3-david@redhat.com>
In-Reply-To: <20240117135554.787344-3-david@redhat.com>
From: Zhenyu Zhang <zhenyzha@redhat.com>
Date: Thu, 18 Jan 2024 11:08:07 +0800
Message-ID: <CAJFLiBKiW0S5GJVvcYv2O3YtVSxmqzp1=1W10T_gnoxgOaWGBw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] memory-device: reintroduce memory region size check
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mario Casquero <mcasquer@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Michal Privoznik <mprivozn@redhat.com>, shan.gavin@gmail.com, 
 Guowen Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=zhenyzha@redhat.com;
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

[PATCH v1 2/2] memory-device: reintroduce memory region size check

Test on 64k basic page size aarch64
The patches work well on my Ampere host.
The test results are as expected.

(a) 1M with 512M THP
/home/zhenyzha/sandbox/qemu.main/build/qemu-system-aarch64 \
-name 'avocado-vt-vm1'  \
-sandbox on \
:
-nodefaults \
-m 4096,maxmem=3D32G,slots=3D4 \
-object memory-backend-ram,id=3Dmem1,size=3D1M \
-device pc-dimm,id=3Ddimm1,memdev=3Dmem1 \
-smp 4  \
-cpu 'host' \
-accel kvm \
-monitor stdio
-> backend memory size must be multiple of 0x200000

(b) 1G+1byte
/home/zhenyzha/sandbox/qemu.main/build/qemu-system-aarch64 \
-name 'avocado-vt-vm1'  \
-sandbox on \
:
-nodefaults \
-m 4096,maxmem=3D32G,slots=3D4 \
-object memory-backend-ram,id=3Dmem1,size=3D1073741825B \
-device pc-dimm,id=3Ddimm1,memdev=3Dmem1 \
-smp 4  \
-cpu 'host' \
-accel kvm \
-monitor stdio
-> backend memory size must be multiple of 0x200000

(c) Unliagned hugetlb size (2M)
/home/zhenyzha/sandbox/qemu.main/build/qemu-system-aarch64 \
-name 'avocado-vt-vm1'  \
-sandbox on \
:
-nodefaults \
-m 4096,maxmem=3D32G,slots=3D4 \
-object memory-backend-file,id=3Dmem1,prealloc=3Dyes,mem-path=3D/mnt/kvm_hu=
gepage,size=3D2047M
\
-device pc-dimm,id=3Ddimm1,memdev=3Dmem1 \
-smp 4  \
-cpu 'host' \
-accel kvm \
-monitor stdio
-> backend memory size must be multiple of 0x200000

(d)  2M with 512M hugetlb size
/home/zhenyzha/sandbox/qemu.main/build/qemu-system-aarch64 \
-name 'avocado-vt-vm1'  \
-sandbox on \
:
-nodefaults \
-m 4096,maxmem=3D32G,slots=3D4 \
-object memory-backend-file,id=3Dmem1,mem-path=3D/dev/hugepages/tmp,size=3D=
2M \
-device pc-dimm,id=3Ddimm1,memdev=3Dmem1 \
-smp 4  \
-cpu 'host' \
-accel kvm \
-monitor stdio
-> memory size 0x200000 must be equal to or larger than page size 0x2000000=
0

(e)  511M with 512M hugetlb size
/home/zhenyzha/sandbox/qemu.main/build/qemu-system-aarch64 \
-name 'avocado-vt-vm1'  \
-sandbox on \
:
-nodefaults \
-m 4096,maxmem=3D32G,slots=3D4 \
-object memory-backend-file,id=3Dmem1,mem-path=3D/dev/hugepages/tmp,size=3D=
511M \
-device pc-dimm,id=3Ddimm1,memdev=3Dmem1 \
-smp 4  \
-cpu 'host' \
-accel kvm \
-monitor stdio
-> memory size 0x1ff00000 must be equal to or larger than page size 0x20000=
000

Tested-by: Zhenyu Zhang <zhenzha@redhat.com>



On Wed, Jan 17, 2024 at 9:56=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> We used to check that the memory region size is multiples of the overall
> requested address alignment for the device memory address.
>
> We removed that check, because there are cases (i.e., hv-balloon) where
> devices unconditionally request an address alignment that has a very larg=
e
> alignment (i.e., 32 GiB), but the actual memory device size might not be
> multiples of that alignment.
>
> However, this change:
>
> (a) allows for some practically impossible DIMM sizes, like "1GB+1 byte".
> (b) allows for DIMMs that partially cover hugetlb pages, previously
>     reported in [1].
>
> Both scenarios don't make any sense: we might even waste memory.
>
> So let's reintroduce that check, but only check that the
> memory region size is multiples of the memory region alignment (i.e.,
> page size, huge page size), but not any additional memory device
> requirements communicated using md->get_min_alignment().
>
> The following examples now fail again as expected:
>
> (a) 1M with 2M THP
>  qemu-system-x86_64 -m 4g,maxmem=3D16g,slots=3D1 -S -nodefaults -nographi=
c \
>                      -object memory-backend-ram,id=3Dmem1,size=3D1M \
>                      -device pc-dimm,id=3Ddimm1,memdev=3Dmem1
>  -> backend memory size must be multiple of 0x200000
>
> (b) 1G+1byte
>
>  qemu-system-x86_64 -m 4g,maxmem=3D16g,slots=3D1 -S -nodefaults -nographi=
c \
>                    -object memory-backend-ram,id=3Dmem1,size=3D1073741825=
B \
>                    -device pc-dimm,id=3Ddimm1,memdev=3Dmem1
>  -> backend memory size must be multiple of 0x200000
>
> (c) Unliagned hugetlb size (2M)
>
>  qemu-system-x86_64 -m 4g,maxmem=3D16g,slots=3D1 -S -nodefaults -nographi=
c \
>                    -object memory-backend-file,id=3Dmem1,mem-path=3D/dev/=
hugepages/tmp,size=3D511M \
>                    -device pc-dimm,id=3Ddimm1,memdev=3Dmem1
>  backend memory size must be multiple of 0x200000
>
> (d) Unliagned hugetlb size (1G)
>
>  qemu-system-x86_64 -m 4g,maxmem=3D16g,slots=3D1 -S -nodefaults -nographi=
c \
>                     -object memory-backend-file,id=3Dmem1,mem-path=3D/dev=
/hugepages1G/tmp,size=3D2047M \
>                     -device pc-dimm,id=3Ddimm1,memdev=3Dmem1
>  -> backend memory size must be multiple of 0x40000000
>
> Note that this fix depends on a hv-balloon change to communicate its
> additional alignment requirements using get_min_alignment() instead of
> through the memory region.
>
> [1] https://lkml.kernel.org/r/f77d641d500324525ac036fe1827b3070de75fc1.17=
01088320.git.mprivozn@redhat.com
>
> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
> Reported-by: Michal Privoznik <mprivozn@redhat.com>
> Fixes: eb1b7c4bd413 ("memory-device: Drop size alignment check")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/mem/memory-device.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index a1b1af26bc..e098585cda 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -374,6 +374,20 @@ void memory_device_pre_plug(MemoryDeviceState *md, M=
achineState *ms,
>          goto out;
>      }
>
> +    /*
> +     * We always want the memory region size to be multiples of the memo=
ry
> +     * region alignment: for example, DIMMs with 1G+1byte size don't mak=
e
> +     * any sense. Note that we don't check that the size is multiples
> +     * of any additional alignment requirements the memory device might
> +     * have when it comes to the address in physical address space.
> +     */
> +    if (!QEMU_IS_ALIGNED(memory_region_size(mr),
> +                         memory_region_get_alignment(mr))) {
> +        error_setg(errp, "backend memory size must be multiple of 0x%"
> +                   PRIx64, memory_region_get_alignment(mr));
> +        return;
> +    }
> +
>      if (legacy_align) {
>          align =3D *legacy_align;
>      } else {
> --
> 2.43.0
>


