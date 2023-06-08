Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7113D727BB4
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 11:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7CBC-0002ee-6M; Thu, 08 Jun 2023 05:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q7CB7-0002bJ-Nf
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 05:43:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q7CB3-0003Oo-UY
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 05:43:37 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QcK3M64cSz6GCpY;
 Thu,  8 Jun 2023 17:41:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 8 Jun
 2023 10:43:23 +0100
Date: Thu, 8 Jun 2023 10:43:22 +0100
To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
CC: Fan Ni <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "gregory.price@memverge.com"
 <gregory.price@memverge.com>, "hchkuo@avery-design.com.tw"
 <hchkuo@avery-design.com.tw>, "cbrowy@avery-design.com"
 <cbrowy@avery-design.com>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, Adam Manzanares <a.manzanares@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>, "nmtadam.samsung@gmail.com"
 <nmtadam.samsung@gmail.com>, "nifan@outlook.com" <nifan@outlook.com>, "Ira
 Weiny" <ira.weiny@intel.com>
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Message-ID: <20230608104322.0000632f@Huawei.com>
In-Reply-To: <DM6PR18MB284486E36310719093C8A6D6AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
 <20230511175609.2091136-1-fan.ni@samsung.com>
 <647e1cf4e7e5e_7471a2948f@iweiny-mobl.notmuch>
 <20230605175112.GA2290821@bgt-140510-bm03>
 <DM6PR18MB2844A78EB692A69CE10031E2AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
 <20230607183059.GA2354376@bgt-140510-bm03>
 <DM6PR18MB284486E36310719093C8A6D6AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, PDS_OTHER_BAD_TLD=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 7 Jun 2023 18:52:14 +0000
Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:

> From: Fan Ni <fan.ni@samsung.com>
> Sent: Wednesday, June 7, 2023 11:31 AM
> To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>; qemu-devel@nongnu.org=
 <qemu-devel@nongnu.org>; linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.=
org>; gregory.price@memverge.com <gregory.price@memverge.com>; hchkuo@avery=
-design.com.tw <hchkuo@avery-design.com.tw>; cbrowy@avery-design.com <cbrow=
y@avery-design.com>; dan.j.williams@intel.com <dan.j.williams@intel.com>; A=
dam Manzanares <a.manzanares@samsung.com>; dave@stgolabs.net <dave@stgolabs=
.net>; nmtadam.samsung@gmail.com <nmtadam.samsung@gmail.com>; nifan@outlook=
.com <nifan@outlook.com>; Ira Weiny <ira.weiny@intel.com>
> Subject: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu=
=20
> =A0
> External Email
>=20
> ----------------------------------------------------------------------
> On Wed, Jun 07, 2023 at 06:13:01PM +0000, Shesha Bhushan Sreenivasamurthy=
 wrote:
> > Hi Fan,
> >=A0=A0=A0 I am implementing DCD FMAPI commands and planning to start pus=
hing changes to the below branch. That requires the contributions you have =
made. Can your changes be pushed to the below branch ?
> >=20
> > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-20=
23-05-25__;!!EwVzqGoTKBqv-0DWAJBm!Vt5uIqwW-L4c4gh02ulI4M762JNQ3_aE9k9lb6Qlw=
E2xm6T23ic7ig7Y77i1VN7l_RX_ySIQhre_z7Q0JA$  =20
>=20
> Can you push changes to the branch directly? I think it is Jonathan's pri=
vate
> branch. However, I can fork the branch and rebase my patch series atop and
> share with you the new repo if that helps you move forward your
> work.
> Let me know your thought.
>=20
> ss - I saw commits from others, so assumed you can. Since it is Jonathan'=
s private repo, I will step back and let him answer.

I tend to apply stuff in manually rather than given more people commit acce=
ss
to that particular gitlab tree.=20

Easiest option is to fork on gitlab and share the path of your own fork.

I normally queue reasonably mature stuff up on my tree, but that's about ma=
naging
the series sent with intent of being applied upstream + providing a fairly =
stable test
branch.  It's not intended as a general place for stuff in development (tho=
ugh I might
sneak out an extra branch myself from time to time if I want to talk about =
it :)

Jonathan

>=20
> Fan
>=20
> >=20
> >=20
> > From: Fan Ni <fan.ni@samsung.com>
> > Sent: Monday, June 5, 2023 10:51 AM
> > To: Ira Weiny <ira.weiny@intel.com>
> > Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; jonathan.cameron@hua=
wei.com <jonathan.cameron@huawei.com>; linux-cxl@vger.kernel.org <linux-cxl=
@vger.kernel.org>; gregory.price@memverge.com <gregory.price@memverge.com>;=
 hchkuo@avery-design.com.tw <hchkuo@avery-design.com.tw>; cbrowy@avery-desi=
gn.com <cbrowy@avery-design.com>; dan.j.williams@intel.com <dan.j.williams@=
intel.com>; Adam Manzanares <a.manzanares@samsung.com>; dave@stgolabs.net <=
dave@stgolabs.net>; nmtadam.samsung@gmail.com <nmtadam.samsung@gmail.com>; =
nifan@outlook.com <nifan@outlook.com>
> > Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu=20
> > =A0
> > On Mon, Jun 05, 2023 at 10:35:48AM -0700, Ira Weiny wrote: =20
> > > Fan Ni wrote: =20
> > > > Since the early draft of DCD support in kernel is out
> > > > (https://urldefense.com/v3/__https://lore.kernel.org/linux-cxl/2023=
0417164126.GA1904906@bgt-140510-bm03/T/*t__;Iw!!EwVzqGoTKBqv-0DWAJBm!RHzXPI=
cSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21LzAGN=
Ok$ ),
> > > > this patch series provide dcd emulation in qemu so people who are i=
nterested
> > > > can have an early try. It is noted that the patch series may need t=
o be updated
> > > > accordingly if the kernel side implementation changes. =20
> > >=20
> > > Fan,
> > >=20
> > > Do you have a git tree we can pull this from which is updated to a mo=
re
> > > recent CXL branch from Jonathan?
> > >=20
> > > Thanks,
> > > Ira =20
> >=20
> > Hi Ira,
> >=20
> > I have a git tree of the patch series based on Jonathan's branch
> > cxl-2023-02-28: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__=
github.com_moking_qemu-2Ddev_tree_dcd-2Drfe&d=3DDwIFAg&c=3DnKjWec2b6R0mOyPa=
z7xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=3Dw6dicn5kXEG4Imk6=
TpICIjdA6KJ-xt84dtHui-Y0fv5H13bijtzEvjxECKE5MHYf&s=3D3yeO9RN5FY3gPfO2y19X05=
7YeqRTTQTQNfNA-Gfir_Q&e=3D .
> >=20
> > That may be not new enough to include some of the recent patches, but I=
 can
> > rebase it to a newer branch if you can tell me which branch you want to=
 use.
> >=20
> > Thanks,
> > Fan
> >  =20
> > >  =20
> > > >=20
> > > > To support DCD emulation, the patch series add DCD related mailbox =
command
> > > > support (CXL Spec 3.0: 8.2.9.8.9), and extend the cxl type3 memory =
device
> > > > with dynamic capacity extent and region representative.
> > > > To support read/write to the dynamic capacity of the device, a host=
 backend
> > > > is provided and necessary check mechnism is added to ensure the dyn=
amic
> > > > capacity accessed is backed with active dc extents.
> > > > Currently FM related mailbox commands (cxl spec 3.0: 7.6.7.6) is no=
t supported
> > > > , but we add two qmp interfaces for adding/releasing dynamic capaci=
ty extents.
> > > > Also, the support for multiple hosts sharing the same DCD case is m=
issing.
> > > >=20
> > > > Things we can try with the patch series together with kernel dcd co=
de:
> > > > 1. Create DC regions to cover the address range of the dynamic capa=
city
> > > > regions.
> > > > 2. Add/release dynamic capacity extents to the device and notify the
> > > > kernel.
> > > > 3. Test kernel side code to accept added dc extents and create dax =
devices,
> > > > and release dc extents and notify the device
> > > > 4. Online the memory range backed with dc extents and let applicati=
on use
> > > > them.
> > > >=20
> > > > The patch series is based on Jonathan's local qemu branch:
> > > > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cx=
l-2023-02-28__;!!EwVzqGoTKBqv-0DWAJBm!RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOI=
eUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21OO3UHEM$=20
> > > >=20
> > > > Simple tests peformed with the patch series:
> > > > 1 Install cxl modules:
> > > >=20
> > > > modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem
> > > >=20
> > > > 2 Create dc regions:
> > > >=20
> > > > region=3D$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> > > > echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> > > > echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> > > > echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> > > > echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode
> > > > echo 0x10000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> > > > echo 0x10000000 > /sys/bus/cxl/devices/$region/size
> > > > echo=A0 "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> > > > echo 1 > /sys/bus/cxl/devices/$region/commit
> > > > echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> > > >=20
> > > > /home/fan/cxl/tools-and-scripts# cxl list
> > > > [
> > > >=A0=A0 {
> > > >=A0=A0=A0=A0 "memdevs":[
> > > >=A0=A0=A0=A0=A0=A0 {
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "memdev":"mem0",
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "pmem_size":536870912,
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "ram_size":0,
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "serial":0,
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "host":"0000:0d:00.0"
> > > >=A0=A0=A0=A0=A0=A0 }
> > > >=A0=A0=A0=A0 ]
> > > >=A0=A0 },
> > > >=A0=A0 {
> > > >=A0=A0=A0=A0 "regions":[
> > > >=A0=A0=A0=A0=A0=A0 {
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "region":"region0",
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "resource":45365592064,
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "size":268435456,
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "interleave_ways":1,
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "interleave_granularity":256,
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "decode_state":"commit"
> > > >=A0=A0=A0=A0=A0=A0 }
> > > >=A0=A0=A0=A0 ]
> > > >=A0=A0 }
> > > > ]
> > > >=20
> > > > 3 Add two dc extents (128MB each) through qmp interface
> > > >=20
> > > > { "execute": "qmp_capabilities" }
> > > >=20
> > > > { "execute": "cxl-add-dynamic-capacity-event",
> > > >=A0=A0=A0=A0=A0 "arguments": {
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "path": "/machine/periphe=
ral/cxl-pmem0",
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "region-id" : 0,
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "num-extent": 2,
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "dpa":0,
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "extent-len": 128
> > > >=A0=A0=A0=A0=A0 }
> > > > }
> > > >=20
> > > > /home/fan/cxl/tools-and-scripts# lsmem
> > > > RANGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SIZE=A0=A0 STATE REMOVABLE=A0=A0 BL=
OCK
> > > > 0x0000000000000000-0x000000007fffffff=A0=A0=A0 2G=A0 online=A0=A0=
=A0=A0=A0=A0 yes=A0=A0=A0 0-15
> > > > 0x0000000100000000-0x000000027fffffff=A0=A0=A0 6G=A0 online=A0=A0=
=A0=A0=A0=A0 yes=A0=A0 32-79
> > > > 0x0000000a90000000-0x0000000a9fffffff=A0 256M offline=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 338-339
> > > >=20
> > > > Memory block size:=A0=A0=A0=A0=A0=A0 128M
> > > > Total online memory:=A0=A0=A0=A0=A0=A0 8G
> > > > Total offline memory:=A0=A0=A0 256M
> > > >=20
> > > >=20
> > > > 4.Online the momory with 'daxctl online-memory dax0.0' to online th=
e memory
> > > >=20
> > > > /home/fan/cxl/ndctl# ./build/daxctl/daxctl online-memory dax0.0
> > > > [=A0 230.730553] Fallback order for Node 0: 0 1
> > > > [=A0 230.730825] Fallback order for Node 1: 1 0
> > > > [=A0 230.730953] Built 2 zonelists, mobility grouping on.=A0 Total =
pages: 2042541
> > > > [=A0 230.731110] Policy zone: Normal
> > > > onlined memory for 1 device
> > > >=20
> > > > root@bgt-140510-bm03:/home/fan/cxl/ndctl# lsmem
> > > > RANGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SIZE=A0=A0 STATE REMOVABLE BLOCK
> > > > 0x0000000000000000-0x000000007fffffff=A0=A0=A0 2G=A0 online=A0=A0=
=A0=A0=A0=A0 yes=A0 0-15
> > > > 0x0000000100000000-0x000000027fffffff=A0=A0=A0 6G=A0 online=A0=A0=
=A0=A0=A0=A0 yes 32-79
> > > > 0x0000000a90000000-0x0000000a97ffffff=A0 128M=A0 online=A0=A0=A0=A0=
=A0=A0 yes=A0=A0 338
> > > > 0x0000000a98000000-0x0000000a9fffffff=A0 128M offline=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 339
> > > >=20
> > > > Memory block size:=A0=A0=A0=A0=A0=A0 128M
> > > > Total online memory:=A0=A0=A0=A0 8.1G
> > > > Total offline memory:=A0=A0=A0 128M
> > > >=20
> > > > 5 using dc extents as regular memory
> > > >=20
> > > > /home/fan/cxl/ndctl# numactl --membind=3D1 ls
> > > > CONTRIBUTING.md=A0 README.md=A0 clean_config.sh=A0 cscope.out=A0=A0=
 git-version-gen
> > > > ndctl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 scripts=A0=A0 test.h=
=A0=A0=A0=A0=A0 version.h.in COPYING=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 acpi.h
> > > > config.h.meson=A0=A0 cxl=A0=A0=A0=A0=A0=A0=A0=A0=A0 make-git-snapsh=
ot.sh=A0=A0 ndctl.spec.in=A0 sles=A0=A0=A0=A0 tools
> > > > Documentation=A0=A0=A0=A0=A0=A0=A0 build=A0=A0=A0=A0=A0=A0 contrib=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 daxctl=A0=A0=A0=A0=A0=A0=A0 meson.build=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rhel
> > > > tags=A0=A0=A0=A0=A0=A0=A0 topology.png LICENSES=A0=A0=A0 ccan=A0=A0=
=A0=A0=A0=A0=A0 cscope.files
> > > > git-version=A0 meson_options.txt=A0=A0=A0=A0=A0 rpmbuild.sh=A0=A0=
=A0 test=A0=A0=A0=A0 util
> > > >=20
> > > >=20
> > > > QEMU command line cxl configuration:
> > > >=20
> > > > RP1=3D"-object memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-pat=
h=3D/tmp/cxltest.raw,size=3D512M \
> > > > -object memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3D/tm=
p/cxltest2.raw,size=3D512M \
> > > > -object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tm=
p/lsa.raw,size=3D512M \
> > > > -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > > > -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,sl=
ot=3D2 \
> > > > -device cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa=
1,dc-memdev=3Dcxl-mem2,id=3Dcxl-pmem0,num-dc-regions=3D1\
> > > > -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.interl=
eave-granularity=3D8k"
> > > >=20
> > > >=20
> > > > Kernel DCD support used to test the changes
> > > >=20
> > > > The code is tested with the posted kernel dcd support:
> > > > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/ke=
rnel/git/cxl/cxl.git/log/?h=3Dfor-6.5*dcd-preview__;Lw!!EwVzqGoTKBqv-0DWAJB=
m!RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7l=
r21q5Iza3M$=20
> > > >=20
> > > > commit: f425bc34c600e2a3721d6560202962ec41622815
> > > >=20
> > > > To make the test work, we have made the following changes to the ab=
ove kernel commit:
> > > >=20
> > > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > > index 5f04bbc18af5..5f421d3c5cef 100644
> > > > --- a/drivers/cxl/core/mbox.c
> > > > +++ b/drivers/cxl/core/mbox.c
> > > > @@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CX=
L_MEM_COMMAND_ID_MAX] =3D {
> > > >=A0=A0=A0=A0=A0 CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
> > > >=A0=A0=A0=A0=A0 CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> > > >=A0=A0=A0=A0=A0 CXL_CMD(GET_DC_EXTENT_LIST, 0x8, CXL_VARIABLE_PAYLOA=
D, 0),
> > > > +=A0=A0 CXL_CMD(GET_DC_CONFIG, 0x2, CXL_VARIABLE_PAYLOAD, 0),
> > > >=A0 };
> > > >=A0=20
> > > >=A0 /*
> > > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > > index 291c716abd49..ae10e3cf43a1 100644
> > > > --- a/drivers/cxl/core/region.c
> > > > +++ b/drivers/cxl/core/region.c
> > > > @@ -194,7 +194,7 @@ static int cxl_region_manage_dc(struct cxl_regi=
on *cxlr)
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cxlds->dc_list_gen_num =3D e=
xtent_gen_num;
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(cxlds->dev, "No of p=
reallocated extents :%d\n", rc);
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable_irq(cxlds->cxl_irq[CXL_EVENT=
_TYPE_DCD]);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*enable_irq(cxlds->cxl_irq[CXL_EVE=
NT_TYPE_DCD]);*/
> > > >=A0=A0=A0=A0=A0 }
> > > >=A0=A0=A0=A0=A0 return 0;
> > > >=A0 err:
> > > > @@ -2810,7 +2810,8 @@ int cxl_add_dc_extent(struct cxl_dev_state *c=
xlds, struct resource *alloc_dpa_re
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 dev_dax->align, memremap_compat_align()))) {
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rc =3D alloc_dev_dax_range(d=
ev_dax, hpa,
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resource_size(alloc_dpa_res));
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rc)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;
> > > >=A0=A0=A0=A0=A0 }
> > > >=A0=20
> > > >=A0=A0=A0=A0=A0 rc =3D xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_da=
x, GFP_KERNEL);
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > index 9e45b1056022..653bec203838 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -659,7 +659,7 @@ static int cxl_event_irqsetup(struct cxl_dev_st=
ate *cxlds)
> > > >=A0=20
> > > >=A0=A0=A0=A0=A0 /* Driver enables DCD interrupt after creating the d=
c cxl_region */
> > > >=A0=A0=A0=A0=A0 rc =3D cxl_event_req_irq(cxlds, policy.dyncap_settin=
gs, CXL_EVENT_TYPE_DCD,
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IRQF_SHARED | IRQF_ONESHOT | IRQF_NO_A=
UTOEN);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IRQF_SHARED | IRQF_ONESHOT);
> > > >=A0=A0=A0=A0=A0 if (rc) {
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(cxlds->dev, "Failed =
to get interrupt for event dc log\n");
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;
> > > > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_=
mem.h
> > > > index 6ca85861750c..910a48259239 100644
> > > > --- a/include/uapi/linux/cxl_mem.h
> > > > +++ b/include/uapi/linux/cxl_mem.h
> > > > @@ -47,6 +47,7 @@
> > > >=A0=A0=A0=A0=A0 ___C(SCAN_MEDIA, "Scan Media"),=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \
> > > >=A0=A0=A0=A0=A0 ___C(GET_SCAN_MEDIA, "Get Scan Media Results"),=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
> > > >=A0=A0=A0=A0=A0 ___C(GET_DC_EXTENT_LIST, "Get dynamic capacity exten=
ts"),=A0=A0=A0=A0=A0=A0=A0=A0 \
> > > > +=A0=A0 ___C(GET_DC_CONFIG, "Get dynamic capacity configuration"),=
=A0=A0=A0=A0=A0=A0=A0=A0 \
> > > >=A0=A0=A0=A0=A0 ___C(MAX, "invalid / last command")
> > > >=A0=20
> > > >=A0 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> > > >=20
> > > >=20
> > > >=20
> > > > Fan Ni (7):
> > > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to outp=
ut
> > > >=A0=A0=A0=A0 payload of identify memory device command
> > > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add dynamic capacity region represe=
ntative
> > > >=A0=A0=A0=A0 and mailbox command support
> > > >=A0=A0 hw/mem/cxl_type3: Add a parameter to pass number of DC region=
s the
> > > >=A0=A0=A0=A0 device supports in qemu command line
> > > >=A0=A0 hw/mem/cxl_type3: Add DC extent representative to cxl type3 d=
evice
> > > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add=
/release
> > > >=A0=A0=A0=A0 dynamic capacity response
> > > >=A0=A0 Add qmp interfaces to add/release dynamic capacity extents
> > > >=A0=A0 hw/mem/cxl_type3: add read/write support to dynamic capacity
> > > >=20
> > > >=A0 hw/cxl/cxl-mailbox-utils.c=A0 | 389 +++++++++++++++++++++++++++-
> > > >=A0 hw/mem/cxl_type3.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 492 ++++++++++++=
+++++++++++++++++++-----
> > > >=A0 include/hw/cxl/cxl_device.h |=A0 50 +++-
> > > >=A0 include/hw/cxl/cxl_events.h |=A0 16 ++
> > > >=A0 qapi/cxl.json=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 44 =
++++
> > > >=A0 5 files changed, 924 insertions(+), 67 deletions(-)
> > > >=20
> > > > --=20
> > > > 2.25.1 =20
> > >=20
> > > =20


