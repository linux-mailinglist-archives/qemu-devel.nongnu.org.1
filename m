Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC12F825D74
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 01:47:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLupO-0007lg-Eb; Fri, 05 Jan 2024 19:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLupE-0007lO-FZ
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 19:46:12 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLup9-00054Z-6c
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 19:46:07 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so8807966b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 16:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704501957; x=1705106757; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNoN3Ij+Cd17C0GUAoGM7Rr6uhOfADaZ28dH1HWgLyg=;
 b=EXAuzHCT5L77WFsUhRGtGfsP6Ni8zDzmDbgj/s0rT3oY1Z0SGG3i9DXAc/DE0JW8Vz
 LFJPjytow21UnPdgqeKW2HIKj1fcTTBkK3NUJJiliLZ1sCx2z+LhBl+14z25eVJu6HoM
 CMlk5fwwiupFxRsgbrZ+DyNpFSWlwwyuCrDsT8dgBf4WA1HXiFVw3EwCn2Bk0rs/Mlv1
 LDNCi31hy2G29kWEa06chPfb/rMJLjfBP6SZ131n6WnOeQAxJzTy8EJ+RVgRB9vey6Ni
 bFW3B3xkWxM3ODXmR5n+1peWBVtgCYthC/KNaAGBNpOIrm+WI9UEruameafco3sy3oBy
 GXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704501957; x=1705106757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNoN3Ij+Cd17C0GUAoGM7Rr6uhOfADaZ28dH1HWgLyg=;
 b=oORdsm2Nd/Xaq1DIXlDIo76Jq/OBIGavPEbwhv0kRI5pHOvqAsAqAr6d24xv7SAQEs
 WYM2NO0OGtu2HZroOGxzfAWF6PSwtx9VPvw29bCqv5jFqf39idSfltOuQm8XdbE/er2X
 B3VdZJmzTGYNSNDbbvAJuZCfj7SW87JLRm5m3G91HZM/CRBASIkq2zZrxbuzxzhczU7w
 /DV9IQBNcBTQrw20eXz69ooFdHl7xupZ27jvOmY/8F0Elmvd287jsPAmUJmUsM2EY6bV
 O211f2ku9yjY5ngmp0VaGy2pf50b7JJPjGbrc2jPPECIMq/0tvQ+iOcw0KwY8/GokPrz
 01Ww==
X-Gm-Message-State: AOJu0Yy5jjNtozPw0nu6d+QpM6zBgA1RycoVYM1JC1eO1KAeG6do192t
 GJCJnhfbAdwSWnhRJwmFKtpqniY3Z9vV7k9XZukSdHtKcVo/Dw==
X-Google-Smtp-Source: AGHT+IEswPo5jFQads7GsL6Js6uz2hURc4eup2AE3Rs5C3QzDVqwMiOyL3m3wGWnnUXkk0GCf/iKzssXBe0dgchMgLE=
X-Received: by 2002:a17:906:245a:b0:a29:513b:dda6 with SMTP id
 a26-20020a170906245a00b00a29513bdda6mr47137ejb.225.1704501957579; Fri, 05 Jan
 2024 16:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com>
 <3ecd3b5a-c4d3-4fd5-b75b-d89b1d4b45e5@redhat.com>
In-Reply-To: <3ecd3b5a-c4d3-4fd5-b75b-d89b1d4b45e5@redhat.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Fri, 5 Jan 2024 16:45:46 -0800
Message-ID: <CAAYibXhjuhi9jupkSWE-9fdC=HaH-R=NXMyAs1tPiqGX6OF9rg@mail.gmail.com>
Subject: Re: [External] Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem:
 qapi/qom: Add an ObjectOption for memory-backend-* called HostMemType and its
 arg 'cxlram'
To: David Hildenbrand <david@redhat.com>
Cc: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Widawsky <ben.widawsky@intel.com>, 
 Gregory Price <gourry.memverge@gmail.com>, Fan Ni <fan.ni@samsung.com>, 
 Ira Weiny <ira.weiny@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x635.google.com
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

On Tue, Jan 2, 2024 at 5:04=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 01.01.24 08:53, Ho-Ren (Jack) Chuang wrote:
> > Introduce a new configuration option 'host-mem-type=3D' in the
> > '-object memory-backend-ram', allowing users to specify
> > from which type of memory to allocate.
> >
> > Users can specify 'cxlram' as an argument, and QEMU will then
> > automatically locate CXL RAM NUMA nodes and use them as the backend mem=
ory.
> > For example:
> >       -object memory-backend-ram,id=3Dvmem0,size=3D19G,host-mem-type=3D=
cxlram \
> >       -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> >       -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,=
slot=3D2 \
> >       -device cxl-type3,bus=3Droot_port13,volatile-memdev=3Dvmem0,id=3D=
cxl-vmem0 \
> >       -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D19G,cxl-fmw.0.int=
erleave-granularity=3D8k \
> >
>
> You can achieve the exact same thing already simply by using memory
> policies and detecting the node(s) before calling QEMU, no?

Yes, I agree this can be done with memory policy and bind to the CXL
memory numa nodes on host.

>
> There has to be a good reason to add such a shortcut into QEMU, and it
> should be spelled out here.

So our end goal here is to enable CXL memory in the guest VM and have
the guest kernel to recognize the CXL memory to the correct memory
tier (slow tier) in the Linux kernel tiered memory system.

Here is what we observed:
* The kernel tiered memory system relies on calculating the memory
attributes (read/write latency, bandwidth from ACPI) for fast vs slow
tier.
* The kernel tiered memory system has two path to recognize a memory
tier 1) in mm subsystem init, memory_tier_init 2) in kmem driver
device probe dev_dax_kmem_probe. Since the ACPI subsystem is
initialized after mm, reading the memory attributes from ACPI can only
be done in 2). CXL memory has to be presented as a devdax device,
which can then be probed by the kmem driver in the guest and
recognized as the slow tier.

We do see that QEMU has this option "-numa hmat-lb" to set the memory
attributes per VM's numa node. The problem is that setting the memory
attributes per numa node means that the numa node is created during
guest kernel initialization. A CXL devdax device can only be created
post kernel initialization and new numa nodes are created for the CXL
devdax devices. The guest kernel is not reading the memory attributes
from "-numa hmat-lb" for the CXL devdax devices.

So we thought if we create an explicit CXL memory backend, and
associate that with the virtual CXL type-3 frontend, we can pass the
CXL memory attributes from the host into the guest VM and avoid using
memory policy and "-numa hmat-lb", thus simplifying the configuration.
We are still figuring out exactly how to pass the memory attributes
from the CXL backend into the VM. There is probably a solution to
"-numa hmat-lb" for the CXL devdax devices as well and we are also
looking into it.

>
> --
> Cheers,
>
> David / dhildenb
>

