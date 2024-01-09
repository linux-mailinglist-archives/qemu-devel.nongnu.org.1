Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A79F829117
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 00:58:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNLxL-00069W-Ia; Tue, 09 Jan 2024 18:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rNLxJ-00069O-H7
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 18:56:25 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rNLx8-0004QI-VG
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 18:56:25 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50eaa8b447bso3748704e87.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 15:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704844559; x=1705449359; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=deI9GyKmvHyCD066H+Wu2YAjGfRVp8M+T1N2HV8O5I4=;
 b=ZWQZMk6WwM4wkC6dlWdlFUws+eI2qskBnDOU4ZFnPFLE9nrZMd2n+0zhUyOD4jAmrN
 5S26/BH299ssTGgkldn0rk3m48bIbDqm5uCUXRRrmMgUZMroO+bXZLFzD+IgeMMcuudp
 6SWkj9/AbBvFF12ztdfdOF+gogxuAJ+LjVtwiqy1PLhewoai9Ov0s5Ris+gs+T46jnfA
 dcZgeuMSk+sU12qUWHZLqVHu4aXS7dvCnVMBIpDVa1f5YPKjddeWO+b3YfatGFk59q3G
 1qo8uPzDNbgyWM2CMmwUp5kEq0+9BiY/j8xapZMTVHnk1LsfPpe7Thg2I99UjEe91t1j
 awNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704844559; x=1705449359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=deI9GyKmvHyCD066H+Wu2YAjGfRVp8M+T1N2HV8O5I4=;
 b=emlBqUInUCjj25JVdq8zcYoDVdA/jIkvDzoUEh5DoKhLzUmkAliVNBLeUj8YPavaAK
 LanhoTdTwq3ZgZzjPcePjdD9qLk8HutYSKk5vN793vdthJiKq8NP/FuwPloh6LFmaKyJ
 At1ZzZlXoH3Z7k5fGfVIRnPS9q36jD3mz4Hs/w34lR/nToKJBQqTzMCKSSNLpaTzi8ZP
 NniLKvfkIaC17eyS0SqdEgzc8/2ZO6gnsyHWVpj5nECgYGJcVARr6HUjD4Y4UFPiCt4X
 QSH7XPAW/0lwgBZax+LmUzMMUA9tbFOy0vIqWkgfjFEysA4LkKIhyknfgTxR3QkQbTzb
 2Htw==
X-Gm-Message-State: AOJu0YyhQ/fWlGH46pLgrXKsrrnAXx5UN8YcoIUrW1sIaX8Z5g7Mg4Iw
 KprHIzGj6ADMDsiWG/7AYBTUfmRokkGwSj5G/b5DcYZSjSHVkQ==
X-Google-Smtp-Source: AGHT+IH8niV1qNroh8QduYcojlVVDQFS9X2GkpYdi7ulR8Zvv4CkOMPH0UDDuHXqgIb4u1lPoAwHj9mmHs1ntGL5UpY=
X-Received: by 2002:a05:6512:1587:b0:50e:7be8:4705 with SMTP id
 bp7-20020a056512158700b0050e7be84705mr24917lfb.260.1704844558979; Tue, 09 Jan
 2024 15:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20240101075315.43167-2-horenchuang@bytedance.com>
 <ZZXX95yvk/WTIBT/@memverge.com>
 <CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com>
 <ZZwtmiucNXxmrZ7S@memverge.com>
 <CAAYibXhfUu8dMwvBmWz4P6N9-yLao0QwAFozk4rS_0GPsEZd7Q@mail.gmail.com>
 <CAAYibXgf6i5+aqopCrVu5ZveDJ9WP2M2AJaUUaj5qFXFHQQxmQ@mail.gmail.com>
 <ZZydwBTS4NeSizzb@memverge.com>
 <CAAYibXhY5p6VN7yAMpmfAgHO+gsf51dvNw68y__RYV+43CVVLQ@mail.gmail.com>
 <ZZ2lNoTQ8hDHADTT@memverge.com>
 <CAAYibXjcVu-13h9jHpt2fZ3wmjz-_Dyj+WfUh0AEpid87GLriQ@mail.gmail.com>
 <ZZ3FAegN/ezu9Ghy@memverge.com>
In-Reply-To: <ZZ3FAegN/ezu9Ghy@memverge.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Tue, 9 Jan 2024 15:55:46 -0800
Message-ID: <CAAYibXhTUgd+z3Xqk7yeWqQmHxtDmf3Ud_01iEHS0KRj9GhjUw@mail.gmail.com>
Subject: Re: [External] Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem:
 qapi/qom: Add an ObjectOption for memory-backend-* called HostMemType and its
 arg 'cxlram'
To: Gregory Price <gregory.price@memverge.com>
Cc: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Gregory Price <gourry.memverge@gmail.com>, 
 Fan Ni <fan.ni@samsung.com>, Ira Weiny <ira.weiny@intel.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=hao.xiang@bytedance.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 9, 2024 at 2:13=E2=80=AFPM Gregory Price <gregory.price@memverg=
e.com> wrote:
>
> On Tue, Jan 09, 2024 at 01:27:28PM -0800, Hao Xiang wrote:
> > On Tue, Jan 9, 2024 at 11:58=E2=80=AFAM Gregory Price
> > <gregory.price@memverge.com> wrote:
> > >
> > > If you drop this line:
> > >
> > > -numa node,memdev=3Dvmem0,nodeid=3D1
> >
> > We tried this as well and it works after going through the cxlcli
> > process and created the devdax device. The problem is that without the
> > "nodeid=3D1" configuration, we cannot connect with the explicit per num=
a
> > node latency/bandwidth configuration "-numa hmat-lb". I glanced at the
> > code in hw/numa.c, parse_numa_hmat_lb() looks like the one passing the
> > lb information to VM's hmat.
> >
>
> Yeah, this is what Jonathan was saying - right now there isn't a good
> way (in QEMU) to pass the hmat/cdat stuff down through the device.
> Needs to be plumbed out.
>
> In the meantime: You should just straight up drop the cxl device from
> your QEMU config.  It doesn't actually get you anything.
>
> > From what I understand so far, the guest kernel will dynamically
> > create a numa node after a cxl devdax device is created. That means we
> > don't know the numa node until after VM boot. 2. QEMU can only
> > statically parse the lb information to the VM at boot time. How do we
> > connect these two things?
>
> during boot, the kernel discovers all the memory regions exposed to
> bios. In this qemu configuration you have defined:
>
> region 0: CPU + DRAM node
> region 1: DRAM only node
> region 2: CXL Fixed Memory Window (the last line of the cxl stuff)
>
> The kernel reads this information on boot and reserves 1 numa node for
> each of these regions.
>
> The kernel then automatically brings up regions 0 and 1 in nodes 0 and 1
> respectively.
>
> Node2 sits dormant until you go through the cxl-cli startup sequence.
>
>
> What you're asking for is for the QEMU team to plumb hmat/cdat
> information down through the type3 device.  I *think* that is presently
> possible with a custom CDAT file - but Jonathan probably has more
> details on that.  You'll have to go digging for answers on that one.

I think this is exactly what I was looking for. When we started with
the idea of having an explicit CXL memory backend, we wanted to
1) Bind a virtual CXL device to an actual CXL memory node on host.
2) Pass the latency/bandwidth information from the CXL backend into
the virtual CXL device.
I didn't have a concrete idea of how to do 2)
With the discussion here, I learned that the information is passed
from CDAT. Just looked into the virtual CXL code and found that
ct3_build_cdat_entries_for_mr() is the function that builds this
information. But the latency and bandwidth there are currently
hard-coded. I think it makes sense to have an explicit CXL memory
backend where QEMU can query the CXL memory attributes from the host
and pass that information from the CXL backend into the virtual CXL
type-3 device.

>
>
> Now - even if you did that - the current state of the cxl-type3 device
> is *not what you want* because your memory accesses will be routed
> through the read/write functions in the emulated device.
>
> What Jonathan and I discussed on the other thread is how you might go
> about slimming this down to allow pass-through of the memory without the
> need for all the fluff.  This is a non-trivial refactor of the existing
> device, so i would not expect that any time soon.
>
> At the end of the day, quickest way to get-there-from-here is to just
> drop the cxl related lines from your QEMU config, and keep everything
> else.

Agreed. We need the kernel to be capable of reading the memory
attributes from HMAT and establish the correct memory tier for
system-DRAM (on a CPUless numa node). Currently system-DRAM is assumed
to always be fast tier.

>
> >
> > Assuming that the same issue applies to a physical server with CXL.
> > Were you able to see a host kernel getting the correct lb information
> > for a CXL devdax device?
> >
>
> Yes, if you bring up a CXL device via cxl-cli on real hardware, the
> subsequent numa node ends up in the "lower tier" of the memory-tiering
> infrastructure.
>
> ~Gregory

