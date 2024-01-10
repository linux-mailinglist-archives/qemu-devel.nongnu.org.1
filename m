Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ACE829CA6
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 15:32:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNZch-0006Yn-Cf; Wed, 10 Jan 2024 09:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rNZcb-0006YT-8h
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 09:32:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rNZcX-0007Yp-I8
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 09:31:56 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T99Cq6dbgz6K982;
 Wed, 10 Jan 2024 22:29:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id D7072140B63;
 Wed, 10 Jan 2024 22:31:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Jan
 2024 14:31:47 +0000
Date: Wed, 10 Jan 2024 14:31:46 +0000
To: Hao Xiang <hao.xiang@bytedance.com>
CC: Gregory Price <gregory.price@memverge.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Gregory
 Price" <gourry.memverge@gmail.com>, Fan Ni <fan.ni@samsung.com>, Ira Weiny
 <ira.weiny@intel.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, David Hildenbrand <david@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel P.
 =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, <qemu-devel@nongnu.org>, "Ho-Ren (Jack) Chuang"
 <horenc@vt.edu>, <linux-cxl@vger.kernel.org>
Subject: Re: [External] Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem:
 qapi/qom: Add an ObjectOption for memory-backend-* called HostMemType and
 its arg 'cxlram'
Message-ID: <20240110143146.00001a56@Huawei.com>
In-Reply-To: <CAAYibXhTUgd+z3Xqk7yeWqQmHxtDmf3Ud_01iEHS0KRj9GhjUw@mail.gmail.com>
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
 <CAAYibXhTUgd+z3Xqk7yeWqQmHxtDmf3Ud_01iEHS0KRj9GhjUw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 9 Jan 2024 15:55:46 -0800
Hao Xiang <hao.xiang@bytedance.com> wrote:

> On Tue, Jan 9, 2024 at 2:13=E2=80=AFPM Gregory Price <gregory.price@memve=
rge.com> wrote:
> >
> > On Tue, Jan 09, 2024 at 01:27:28PM -0800, Hao Xiang wrote: =20
> > > On Tue, Jan 9, 2024 at 11:58=E2=80=AFAM Gregory Price
> > > <gregory.price@memverge.com> wrote: =20
> > > >
> > > > If you drop this line:
> > > >
> > > > -numa node,memdev=3Dvmem0,nodeid=3D1 =20
> > >
> > > We tried this as well and it works after going through the cxlcli
> > > process and created the devdax device. The problem is that without the
> > > "nodeid=3D1" configuration, we cannot connect with the explicit per n=
uma
> > > node latency/bandwidth configuration "-numa hmat-lb". I glanced at the
> > > code in hw/numa.c, parse_numa_hmat_lb() looks like the one passing the
> > > lb information to VM's hmat.
> > > =20
> >
> > Yeah, this is what Jonathan was saying - right now there isn't a good
> > way (in QEMU) to pass the hmat/cdat stuff down through the device.
> > Needs to be plumbed out.
> >
> > In the meantime: You should just straight up drop the cxl device from
> > your QEMU config.  It doesn't actually get you anything.
> > =20
> > > From what I understand so far, the guest kernel will dynamically
> > > create a numa node after a cxl devdax device is created. That means we
> > > don't know the numa node until after VM boot. 2. QEMU can only
> > > statically parse the lb information to the VM at boot time. How do we
> > > connect these two things? =20
> >
> > during boot, the kernel discovers all the memory regions exposed to
> > bios. In this qemu configuration you have defined:
> >
> > region 0: CPU + DRAM node
> > region 1: DRAM only node
> > region 2: CXL Fixed Memory Window (the last line of the cxl stuff)
> >
> > The kernel reads this information on boot and reserves 1 numa node for
> > each of these regions.
> >
> > The kernel then automatically brings up regions 0 and 1 in nodes 0 and 1
> > respectively.
> >
> > Node2 sits dormant until you go through the cxl-cli startup sequence.
> >
> >
> > What you're asking for is for the QEMU team to plumb hmat/cdat
> > information down through the type3 device.  I *think* that is presently
> > possible with a custom CDAT file - but Jonathan probably has more
> > details on that.  You'll have to go digging for answers on that one. =20
>=20
> I think this is exactly what I was looking for. When we started with
> the idea of having an explicit CXL memory backend, we wanted to
> 1) Bind a virtual CXL device to an actual CXL memory node on host.
> 2) Pass the latency/bandwidth information from the CXL backend into
> the virtual CXL device.
> I didn't have a concrete idea of how to do 2)
> With the discussion here, I learned that the information is passed
> from CDAT. Just looked into the virtual CXL code and found that
> ct3_build_cdat_entries_for_mr() is the function that builds this
> information. But the latency and bandwidth there are currently
> hard-coded. I think it makes sense to have an explicit CXL memory
> backend where QEMU can query the CXL memory attributes from the host
> and pass that information from the CXL backend into the virtual CXL
> type-3 device.

There is probably an argument for a memory backend to be able to take
perf numbers in general (I don't see this as being CXL specific) or for
us adding more parameters to the cxl device entry, but for now you can
inject a cdat file that presents whatever you like. =20

What we are missing though is generic port creation, so even with
everything else in place it won't quite work yet. There was a hacky
patch for generic ports, but it's not upstream yet (or in my tree).

Usefully there is work under review for adding generic initiators to
qemu that we can repurpose most of for GPs.

Jonathan

