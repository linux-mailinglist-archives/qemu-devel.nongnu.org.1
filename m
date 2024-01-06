Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1EC825E6E
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 07:01:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLzig-0003D0-F7; Sat, 06 Jan 2024 00:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLzid-0003Ck-Er
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 00:59:39 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLzia-0004Y0-M3
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 00:59:39 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-552d39ac3ccso2149874a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 21:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704520772; x=1705125572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TP5ubnLFEUP8bCQUNCtogctaDcnIbCfZpR0c+RvPaLE=;
 b=NE0N3FZuT4M644E1mtQF1EaKxDDHhmfJ70AIHxvBuxXtPVcFcllB+AhguZErcWlEH8
 1jouLXskHQmxRMk0Qnknm1jNY9581MwwlkieaIzBGewHD2HIsu51yxh/8bdtpuvbnJXi
 4JQzEA+NB62Jgi3IMkL3Axfbi40OGymkSlO6fGbXu4PaBQiUxEAzJHdObyig0k6queIr
 wQJxB30kuCLz4ErQEuwyObKEJ6jB1EcZqCc8EE8Frjia6v2iRKZ6ewYgPoQvnUTou9Mj
 vm8GGiuqqT4olLLnS8Aags63wMz7x3gYNdgMtUarbTVlEQhhAdZJwfMCaCNl0PSf2X5m
 xMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704520772; x=1705125572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TP5ubnLFEUP8bCQUNCtogctaDcnIbCfZpR0c+RvPaLE=;
 b=SYS5KIG/e8ttFIV4Jv/0VFAMI7Oauudkaj6zgnLnZAh630qog68J1Z/MPTR2/JZsXw
 c7aKgw+dSncpMIS0eOQAQBsp62B36L+v8NSzKgmaMMz35XBIZBx4gXmexmMlknfhYdbM
 nSNRx3GoJ4z7YaS4CbYBIjmqdXOwhd2UjQzeeZpZWd02jbQnS/lBOxGonIAINJbi7XWP
 NH0cGEjPFLHayR/gWjkdbgDcPc34xpfgK/oEg7kIm2lLjUZxrE9Hi2e/cP7AtSgGTXxx
 5x/wUvOPbh4T3lEmRG7zqJEDzqJB8wjgkfIWERSyrkqpLAsOduI+iQmrSg0J6eI9XS1T
 36sQ==
X-Gm-Message-State: AOJu0YxZkjWZMuktfnAV5sSKsxepdTVWsDtOc5c2600kOXps65f4MATJ
 YVoj4iaC/N9tVAvrNwhJusnA7cM4hC5lMw/OKNuvl+xOq9cibQ==
X-Google-Smtp-Source: AGHT+IGQTogDZIrGTNqCN9zcFH+YgeYItqs7cJaYdSTGjI2XuSp5CfzjXcRhvAYHztqR96zfm0o8sBRRWnHdTheCFY4=
X-Received: by 2002:a17:907:5c9:b0:a28:7265:5915 with SMTP id
 wg9-20020a17090705c900b00a2872655915mr553546ejb.20.1704520771751; Fri, 05 Jan
 2024 21:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com>
 <ZZXX95yvk/WTIBT/@memverge.com>
In-Reply-To: <ZZXX95yvk/WTIBT/@memverge.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Fri, 5 Jan 2024 21:59:19 -0800
Message-ID: <CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com>
Subject: Re: [External] Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem:
 qapi/qom: Add an ObjectOption for memory-backend-* called HostMemType and its
 arg 'cxlram'
To: Gregory Price <gregory.price@memverge.com>
Cc: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Widawsky <ben.widawsky@intel.com>, 
 Gregory Price <gourry.memverge@gmail.com>, Fan Ni <fan.ni@samsung.com>, 
 Ira Weiny <ira.weiny@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x531.google.com
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

On Wed, Jan 3, 2024 at 1:56=E2=80=AFPM Gregory Price <gregory.price@memverg=
e.com> wrote:
>
> On Sun, Dec 31, 2023 at 11:53:15PM -0800, Ho-Ren (Jack) Chuang wrote:
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
>
> Stupid questions:
>
> Why not just use `host-nodes` and pass in the numa node you want to
> allocate from? Why should QEMU be made "CXL-aware" in the sense that
> QEMU is responsible for figuring out what host node has CXL memory?
>
> This feels like an "upper level software" operation (orchestration), rath=
er
> than something qemu should internally understand.

I don't have a "big picture" and I am learning. Maybe we proposed
something not useful :-) I replied to the same question on a fork of
this thread.

>
> >       -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> >       -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,=
slot=3D2 \
> >       -device cxl-type3,bus=3Droot_port13,volatile-memdev=3Dvmem0,id=3D=
cxl-vmem0 \
>
> For a variety of performance reasons, this will not work the way you
> want it to.  You are essentially telling QEMU to map the vmem0 into a
> virtual cxl device, and now any memory accesses to that memory region
> will end up going through the cxl-type3 device logic - which is an IO
> path from the perspective of QEMU.

I didn't understand exactly how the virtual cxl-type3 device works. I
thought it would go with the same "guest virtual address ->  guest
physical address -> host physical address" translation totally done by
CPU. But if it is going through an emulation path handled by virtual
cxl-type3, I agree the performance would be bad. Do you know why
accessing memory on a virtual cxl-type3 device can't go with the
nested page table translation?

>
> You may want to double check that your tests aren't using swap space in
> the guest, because I found in my testing that linux would prefer to use
> swap rather than attempt to use virtual cxl-type3 device memory because
> of how god-awful slow it is (even if it is backed by DRAM).

We didn't enable swap in our current test setup. I think there was a
kernel change making the mm page reclamation path to use cxl memory
instead of swap if you enable memory tiering. Did you try that? Swap
is persistent storage. I would be very surprised if virtual cxl is
actually slower than swap.

>
>
> Additionally, this configuration will not (should not) presently work
> with VMX enabled.  Unless I missed some other update, QEMU w/ CXL memory
> presently crashes when VMX is enabled for not-yet-debugged reasons.

When we had a discussion with Intel, they told us to not use the KVM
option in QEMU while using virtual cxl type3 device. That's probably
related to the issue you described here? We enabled KVM though but
haven't seen the crash yet.

>
> Another possiblity: You mapped this memory-backend into another numa
> node explicitly and never onlined the memory via cxlcli.  I've done
> this, and it works, but it's a "hidden feature" that probably should
> not exist / be supported.

I thought general purpose memory nodes are onlined by default?

>
>
>
> If I understand the goal here, it's to pass CXL-hosted DRAM through to
> the guest in a way that the system can manage it according to its
> performance attributes.

Yes.

>
> You're better off just using the `host-nodes` field of host-memory
> and passing bandwidth/latency attributes though via `-numa hmat-lb`

We tried this but it doesn't work from end to end right now. I
described the issue in another fork of this thread.

>
> In that scenario, the guest software doesn't even need to know CXL
> exists at all, it can just read the attributes of the numa node
> that QEMU created for it.

We thought about this before. But the current kernel implementation
requires a devdax device to be probed and recognized as a slow tier
(by reading the memory attributes). I don't think this can be done via
the path you described. Have you tried this before?

>
> In the future to deal with proper dynamic capacity, we may need to
> consider a different backend object altogether that allows sparse
> allocations, and a virtual cxl device which pre-allocates the CFMW
> can at least be registered to manage it.  I'm not quite sure how that
> looks just yet.

Are we talking about CXL memory pooling?

>
> For example: 1-socket, 4 CPU QEMU instance w/ 4GB on a cpu-node and 4GB
> on a cpuless node.
>
> qemu-system-x86_64 \
> -nographic \
> -accel kvm \
> -machine type=3Dq35,hmat=3Don \
> -drive file=3D./myvm.qcow2,format=3Dqcow2,index=3D0,media=3Ddisk,id=3Dhd =
\
> -m 8G,slots=3D4,maxmem=3D16G \
> -smp cpus=3D4 \
> -object memory-backend-ram,size=3D4G,id=3Dram-node0,numa=3DX \ <-- extend=
 here
> -object memory-backend-ram,size=3D4G,id=3Dram-node1,numa=3DY \ <-- extend=
 here
> -numa node,nodeid=3D0,cpus=3D0-4,memdev=3Dram-node0 \          <-- cpu no=
de
> -numa node,initiator=3D0,nodeid=3D1,memdev=3Dram-node1 \       <-- cpules=
s node
> -netdev bridge,id=3Dhn0,br=3Dvirbr0 \
> -device virtio-net-pci,netdev=3Dhn0,id=3Dnic1,mac=3D52:54:00:12:34:77 \
> -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D10 \
> -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D10485760 \
> -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D20 \
> -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D5242880
>
> [root@fedora ~]# numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3
> node 0 size: 3965 MB
> node 0 free: 3611 MB
> node 1 cpus:
> node 1 size: 3986 MB
> node 1 free: 3960 MB
> node distances:
> node   0   1
>   0:  10  20
>   1:  20  10
>
> [root@fedora initiators]# cd /sys/devices/system/node/node1/access0/initi=
ators
> node0  read_bandwidth  read_latency  write_bandwidth  write_latency
> [root@fedora initiators]# cat read_bandwidth
> 5
> [root@fedora initiators]# cat read_latency
> 20
>
>
> ~Gregory

