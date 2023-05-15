Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 178327032B1
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:18:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyatw-0003LK-Qk; Mon, 15 May 2023 12:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1pyats-0003J1-8g
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:18:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1pyato-0004VM-9K
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:18:15 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKkzD14Ksz67DYv;
 Tue, 16 May 2023 00:17:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 17:18:08 +0100
Date: Mon, 15 May 2023 17:18:07 +0100
To: Gregory Price <gregory.price@memverge.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams
 <dan.j.williams@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vincent Hache <vhache@rambus.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [RFC] cxl: Multi-headed device design
Message-ID: <20230515171807.00006d8f@Huawei.com>
In-Reply-To: <ZBpe6btfLuuAS35g@memverge.com>
References: <ZBpe6btfLuuAS35g@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 21 Mar 2023 21:50:33 -0400
Gregory Price <gregory.price@memverge.com> wrote:

Hi Gregory,

Sorry I took so long to reply to this. Busy month...

Vince presented at LSF-MM so I feel it's fair game to CC him kernel
patches and he may be able to point you in right direction for a few
things in this mail.


> Originally I was planning to kick this off with a patch set, but i've
> decided my current prototype does not fit the extensibility requirements
> to go from SLD to MH-SLD to MH-MLD.
>=20
>=20
> So instead I'd like to kick off by just discussing the data structures
> and laugh/cry a bit about some of the frustrating ambiguities for MH-SLDs
> when it comes to the specification.
>=20
> I apologize for the sheer length of this email, but it really is just
> that complex.

hehe.  I read this far when you first sent it and decided to put
it on the todo list rather than reading the rest ;)

>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  What does the specification say about Multi-headed Devices?=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Defining each relevant component according to the specification:
>=20
> >
> > VCS - Virtual CXL Switch
> > * Includes entities within the physical switch belonging to a
> >   single VH. It is identified using the VCS ID.
> >=20
> >=20
> > VH - Virtual Hierarchy.
> > * Everything from the CXL RP down.
> >=20
> >=20
> > LD - Logical Device
> > * Entity that represents a CXL Endpoint that is bound to a VCS.
> >   An SLD device contains one LD.  An MLD contains multiple LDs.
> >=20
> >=20
> > SLD - Single Logical Device
> > * That's it, that's the definition.
> >=20
> >=20
> > MLD - Multi Logical Device
> > * Multi-Logical Device. CXL component that contains multiple LDs,
> >   out of which one LD is reserved for configuration via the FM API,
> >   and each remaining LD is suitable for assignment to a different
> >   host. Currently MLDs are architected only for Type 3 LDs.
> >=20
> >=20
> > MH-SLD - Mutli-Headed SLD
> > * CXL component that contains multiple CXL ports, each presenting an
> >   SLD. The ports must correctly operate when connected to any
> >   combination of common or different hosts.
> >=20
> >=20
> > MH-MLD - Multi-Headed MLD
> > * CXL component that contains multiple CXL ports, each presenting an MLD
> >   or SLD. The ports must correctly operate when connected to any
> >   combination of common or different hosts. The FM-API is used to
> >   configure each LD as well as the overall MH-MLD.
> >=20
> >   MH-MLDs are considered a specialized type of MLD and, as such, are
> >   subject to all functional and behavioral requirements of MLDs.
> >  =20
>=20
> Ambiguity #1:
>=20
> * An SLD contains 1 Logical Device.
> * An MH-SLD presents multiple SLDs, one per head.
>=20
> Ergo an MH-SLD contains multiple LDs which makes it an MLD according to t=
he
> definition of LD, but not according to the definition of MLD, or MH-MLD.

I'd go with 'sort of'.  SLD is a presentation of a device to a host.
It can be a normal single headed MLD that has been plugged directly into a =
host.

So for extra fun points you can have one MH-MLD that has some ports connect=
ed
to switches and other directly to hosts. Thus it can present as SLD on some
upstream ports and as MLD on others.

>=20
> Now is the winter of my discontent.
>=20
> The Specification says this about MH-SLD's in other sections
>=20
> > 2.4.3 Pooled and Shared FAM
> >=20
> > LD-FAM includes several device variants.
> >=20
> > A multi-headed Single Logical Device (MH-SLD) exposes multiple LDs, eac=
h with
> > a dedicated link.
> >=20
> >
> > 2.5 Multi-Headed Device
> >=20
> > There are two types of Multi-Headed Devices that are distinguied by how
> > they present themselves on each head:
> > *  MH-SLD, which present SLDs on all head
> > *  MH-MLD, which may present MLDs on any of their heads

Yup. MH-SLD is the cheap device - not capable of MLD support to any upstream
port - so it can skip some functionality.

> >
> >
> > Management of heads in Multi-Headed Devices follows the model defined f=
or
> > the device presented by that head:
> > *  Heads that present SLDs may support the port management and control
> >     features that are available for SLDs
> > *  Heads that present MLDs may support the port management and control
> >    features that are available for MLDs
> > =20
>=20
> I want to make very close note of this.  SLD's are managed like SLDs
> SLDs, MLDs are managed like MLDs.  MH-SLDs, according to this, should be
> managed like SLDs from the perspective of each host.

True, but an MH-MLD device connected directly to a host will also=20
be managed (at some level anyway) as an SLD on that particular port.

>=20
> That's pretty straight forward.
>=20
> >
> > Management of memory resources in Multi-Headed Devices follows the model
> > defined for MLD components because both MH-SLDs and MH-MLDs must support
> > the isolation of memory resources, state, context, and management on a
> > per-LD basis.  LDs within the device are mapped to a single head.
> >=20
> > *  In MH-SLDs, there is a 1:1 mapping between heads and LDs.
> > *  In MH-MLDs, multiple LDs are mapped to at most one head.
> >=20
> >=20
> > Multi-Headed Devices expose a dedicated Component Command Interface (CC=
I),
> > the LD Pool CCI, for management of all LDs within the device. The LD Po=
ol
> > CCI may be exposed as an MCTP-based CCI or can be accessed via the Tunn=
el
> > Management Command command through a head=E2=80=99s Mailbox CCI, as det=
ailed in
> > Section 7.6.7.3.1. =20
>=20
> 2.5.1 continues on to describe "LD Management in MH-MLDs" but just ignores
> that MH-SLDs (may) exist.  That's frustrating to say the least, but I
> suppose we can gather from context that MH-SLD's *MAY NOT* have LD
> management controls.

Hmm. In theory you could have an MH-SLD that used a config from flash or si=
milar
but that would be odd.  We need some level of dynamic control to make these
devices useful.  Doesn't mean the spec should exclude dumb devices, but
we shouldn't concentrate on them for emulation.

One possible usecase would be a device that always shares all it's memory on
all ports. Yuk.


>=20
> Lets see if that assumption holds.
>=20
> > 7.6.7.3 MLD Port Command Set
> >
> > 7.6.7.3.1 Tunnel Management Command (Opcode 5300h) =20
>=20
> The referenced section at the end of 2.5 seems to also suggest that
> MH-SLDs do not (or don't have to?) implement the tunnel management
> command set.  It sends us to the MLD command set, and SLDs don't get
> managed like MLDs - ergo it's not relevant?
>=20
> The final mention of MH-SLDs is mentioned in section 9.13.3
>=20
> > 9.13.3 Dynamic Capacity Device
> > ...
> >  MH-SLD or MH-MLD based DCD shall forcefully release shared Dynamic
> >  Capacity associated with all associated hosts upon a Conventional Reset
> >  of a head.
> > =20
>=20
> From this we can gather that the specification foresaw someone making a
> memory pool from an MH-SLD... but without LD management. We can fill in
> some blanks and assume that if someone wanted to, they could make a
> shared memory device and implement pooling via software controls.

When you say software controls?  I'm not sure I follow.=20
>=20
> That'd be a neat bodge/hack.  But that's not important right now.
>=20
Fair enough. Moving on.

>=20
> Finally, we look at what the mailbox command-set requirements are for
> multi-headed devices:
>=20
> > 7.6.7.5 Multi-Headed Device Command Set
> > The Multi-Headed device command set includes commands for querying the
> > Head-to-LD mapping in a Multi-Headed device. Support for this command
> > set is required on the LD Pool CCI of a Multi-Headed device.
> > =20
>=20
> Ambiguity #2: Ok, now we're not sure whether an MH-SLD is supposed to
> expose an LD Pool CCI or not.  Also, is a MH-SLD supposed to show up
> as something other than just an SLD?  This is really confusing.
>=20
> Going back to the MLD Port Command set, we see
>=20
> > Valid targets for the tunneled commands include switch MLD Ports,
> > valid LDs within an MLD, and the LD Pool CCI in a Multi-Headed device. =
=20
>=20
> Whatever the case, there's only a single command in the MHD command set:
>=20
> > 7.6.7.5.1 Get Multi-Headed Info (Opcode 5500h) =20
>=20
> This command is pretty straight forward, it just tells you what the head
> to LD mapping is for each of the LDs in the device.  Presumably this is
> what gets modified by the FM-APIs when LDs are attached to VCS ports.
>=20
> For the simplest MH-SLD device, these fields would be immutable, and
> there would be a single LD for each head, where head_id =3D=3D ld_id.

Agreed.

>=20
>=20
>=20
> So summarizing, what I took away from this was the following:
>=20
> In the simplest form of MH-SLD, there's is neither a switch, nor is
> thereo LD management.  So, presumably, we don't HAVE to implement the
> MHD commands to say we "have MH-SLD support".

Whilst theoretically possible - I don' think such a device is interesting.
Minimum I'd want to see is something with multiple upstream SLD ports
and a management LD with appropriate interface to poke it.

The MLD side of things is interesting only once we support MLDs in general
in QEMU CXL emulation and even then they are near invisible to a host
and are more interesting for emulating fabric management.

What you may want to do is take Fan's work on DCD and look at doing
a simple MH-SLD device that uses same cheat of just using QMP commands
to do the configuration.  That's an intermediate step to us getting
the FM-API and similar commands implemented.

>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D
>  Design
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Ok... that's a lot to break down.  Here's what I think the roadmap
> toward multi-headed multi-logical device support should look like:
>=20
> 1. SLD - we have this.  This is struct CXLType3Dev

We could look at Switch + MLD after this, but lots of work to
get the FM-API stuff in place that makes that interesting.
The advantage being we'd have the ability to move LDs around that I
think you are interested in.

>=20
> 2. MH-SLD No Switch, No Pool CCI.

I'd fiddle that a little.  To be useful it needs the functionality
that a pool CCI provides - something to change the confirmation, but
that can be impdef - (QMP stuff like Fan Ni did for DCD).
I'm not sure we want to upstream the QMP side of things but it gives
a path to start messing around iwth this quicker.

>=20
> 3. MH-SLD w/ Pool CCI  (Implementing only Get Multi-Headed Info)

I'd do this + DCD.

>=20
> 4. MH-SLD w/ Switch (Implementing remap-ability of LD to Head)

Hmm. You want this for migration I guess.  I'd be tempted to jump
directly to DCD.  I'm not even sure if the spec really allows this
sort of remapping with out a switch / MHD because DCD covers that gap.

>=20
> 5. MH-MLD - the whole kit and kaboodle.
>=20
>=20
> Lets talk about what the first MH-SLD might look like.
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 2. MH-SLD No Switch, No Pool CCI.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 1. The device has a "memory pool" that "backs" each Logical Device, and
>    the specification does not limit whether this memory is discrete
>    or may be shared between heads.
>=20
>    In QEMU, we can represent this with a shared or file memory backend:
>=20
> -object memory-backend-file,id=3Dmem0,mem-path=3D/tmp/mem0,size=3D4G,shar=
e=3Dtrue
>=20
>=20
> 2. Each QEMU instance has a discrete SLD that amounts to its own private
>    CXLType3Dev.  However, each "Head" maps back to the same common
>    memory backend:
>=20
> -device cxl-type3,bus=3Drp0,volatile-memdev=3Dmem0,id=3Dcxl-mem0
>=20
>=20
> And that's it.  In fact, you can do this now, no changes needed!
>=20
>=20
> But it's also not very useful.  You can only use the memory in devdax
> mode, since it's a shared memory region. You could already do this via
> the /dev/shm interface, so it's not even new functionality.
>=20
> In theory you could build a pooling service in software-only on top of
> memory blocks. That's an exercise left to the reader.

Yeah. Let's not do this step.

>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 3. MH-SLD w/ Pool CCI  (Implementing only Get Multi-Headed Info)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This is a little more complicated, we have our first bit of shared
> state.  Originally I had considered a shared memory region in
> CXLType3Dev, but this is a backwards abstraction (A MH-SLD contains
> mutliple SLDs, an SLD does not contain an MHD State).


>=20
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 7b72345079..1a9f2708e1 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -356,16 +356,6 @@ typedef struct CXLPoison {
>  typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
>  #define CXL_POISON_LIST_LIMIT 256
>=20
> +struct CXLMHDState {
> +    uint8_t nr_heads;
> +    uint8_t nr_lds;
> +    uint8_t ldmap[];
> +};
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -377,15 +367,6 @@ struct CXLType3Dev {
>      HostMemoryBackend *lsa;
>      uint64_t sn;
>=20
> +
> +    /* Multi-headed device settings */
> +    struct {
> +        bool active;
> +        uint32_t headid;
> +        uint32_t shmid;
> +        struct CXLMHDState *state;
> +    } mhd;
> +
>=20
>=20
> The way you would instantiate this would be a via a separate process
> that initializes the shared memory region:
>=20
> shmid1=3D`ipcmk -M 4096 | grep -o -E '[0-9]+' | head -1`
> ./cxl_mhd_init 4 $shmid1
> -device cxl-type3,bus=3Drp0,volatile-memdev=3Dmem0,id=3Dcxl-mem0,mhd=3Dtr=
ue,mhd_head=3D0,mhd_shmid=3D$1
>=20
> ./cxl_mhd_init would simply setup the nr_heads/lds field and such
> and set ldmap[0-3] to the values [0-3].  i.e. the head-to-ld mappings
> are static (head_id=3D=3Dld_id).
>=20
>=20
>=20
> But like I said, this is a backwards abstraction, so realistically we
> should flip this around such that we have the following:
>=20
> struct CXLMHD_SharedState {
> 	uint8_t nr_heads;
> 	uint8_t nr_lds;
> 	uint8_t ldmap[];
> };
>=20
> struct CXLMH_SLD {
> 	uint32_t headid;
> 	uint32_t shmid;
> 	struct CXLMHD_SharedState *state;
> 	struct CXLType3Dev sld;
> };
>=20
> The shared state would be instantiated the same way as above.
>=20
> With this we'd basically just create a new memory device:
>=20
> hw/mem/cxl_mh_sld.c
>=20
>=20
> This is pretty straightforward - we just expose some of cxl_type3.c
> functions in order to instantiate the device accordingly, the rest of it
> just becomes passthrough because... it's just a cxl_type3.c device.
>=20
>=20
> This ultimately manifests as:
>=20
> shmid1=3D`ipcmk -M 4096 | grep -o -E '[0-9]+' | head -1`
>=20
> ./cxl_mhd_init 4 $shmid1
>=20
> -device cxl-mhd-sld,bus=3Drp0,volatile-memdev=3Dmem0,id=3Dcxl-mem0,mhd_he=
ad=3D0,mhd_shmid=3Dshmid
>=20
>=20
> Note: This is the patch set i'm working towards, but I presume there
> might be some (strong) opinions, so i didn't want to get too far into
> development before posting this.

Key here is that what is actually interesting is MH-SLD with Dynamic Capaci=
ty,
not just sharing the whole mapped memory.  That gives us the flexibility to
move memory between heads.

A few different moving parts are needed and I think we'd end up with someth=
ing that
looks like

-device cxl-mhd,volatile-memdev=3Dmem0,id=3Dbackend
-device cxl-mhd-sld,mhd=3Dbackend,bus=3Drp0,mhd-head=3D0,id=3Ddev1,tunnel=
=3Dtrue
-device cxl-mhd-sld,mhd=3Dbackend,bus=3Drp1,mhd-head=3D1,id=3Ddev2

dev1 provides the tunneling interface, but the actual implementation of
the pool CCI and actual memory mappings is in the backend. Note that backend
might be proxy to an external process, or a client/server approach between =
multiple
QEMU instances.

The Pool CCI is accessed via tunnel from dev1 and can both query everything=
 about
the two heads and also perform DCD capacity add / release on the LDs. That =
can
potentially include shared capacity and all the other bells and whistles we=
 get
doing DCD on an MLD device.

or squish some parts and make a more extensible type3 device and have.

-device cxl-type3,volatile-memdev=3Dmem0,bus=3Drp0,mhd-head=3D0,id=3Ddev1,m=
hd-main=3Dtrue
-device cxl-type3,mhd=3Ddev1,bus=3Drp1,mhd-head=3D1,id=3Ddev2

Possibly adding socket numbers as options if we are doing multi qemu support
(can do that later I think as long as we've thought about how to do the com=
mand
 line).=20
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 4. MH-SLD w/ Switch (Implementing LD management in an SLD)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Is it even rational to try to build such a device?
>=20
> MH-SLDs have a 1-to-1 mapping of Head:Logical Device.
>=20
> Presumably each SLD maps the entirety of the "pooled" memory,
> but the specification does not state that is true.  You could, for
> example, setup each Logical Device to map to a particular portion of the
> shared/pooled memory area:

DCD is again key here.
You can't move LDs around on an MH-SLD, but5 you can move capacity around
between them using DCD.

>=20
> -object memory-backend-file,id=3Dmem0,mem-path=3D/tmp/mem0,size=3D4G,shar=
e=3Dtrue
>=20
> QEMU #1
> -device cxl-mhd-sld,bus=3Drp0,volatile-memdev=3Dmem0,id=3Dcxl-mem0,mhd_he=
ad=3D0,mhd_shmid=3Dshmid,dpa_base=3D0,dpa_limit=3D1G
>=20
> QEMU #2
> -device cxl-mhd-sld,bus=3Drp0,volatile-memdev=3Dmem0,id=3Dcxl-mem0,mhd_he=
ad=3D0,mhd_shmid=3Dshmid,dpa_base=3D1G,dpa_limit=3D1G
>=20
> ... and so on.
>=20
> At least in theory, this would involve implementing something that
> changes which SLD is mapped to a QEMU instance - but functionally this
> is just changing the base and limit of each SLD.
>=20
> It's interesting from a functional testing perspective, there's a bunch
> of CCI/Tunnel commands that could be implemented, and presumably this
> would require a separate process to manage/serialize appropriately.
>=20

If this is interesting, do a normal MLD and switch first. The MHD case is
something to stack on top of that.


> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 5. MH-MLD - the whole kit and kaboodle.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> If we implemented MH-SLD w/ Switching, then presumably it's just on step
> further to create an MLD:
>=20
> struct CXLMH_MLD {
>         uint32_t headid;
>         uint32_t shmid;
>         struct CXLMHD_SharedState *state;
>         struct CXLType3Dev ldmap[];
> };
>=20
> But i'm greatly oversimplifying here.  It's much more expressive to
> describe an MLD in terms of a multi-tired switch in the QEMU topology,
> similar to what can be done right now:
>=20
> -device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D12 \
> -device cxl-rp,id=3Drp0,port=3D0,bus=3Dcxl.0,chassis=3D0,slot=3D0 \
> -device cxl-rp,id=3Drp1,port=3D1,bus=3Dcxl.0,chassis=3D0,slot=3D1 \
> -device cxl-upstream,bus=3Drp0,id=3Dus0 \
> -device cxl-downstream,port=3D0,bus=3Dus0,id=3Dswport0,chassis=3D0,slot=
=3D4 \
> -device cxl-downstream,port=3D1,bus=3Dus0,id=3Dswport1,chassis=3D0,slot=
=3D5 \
> -device cxl-type3,bus=3Dswport0,volatile-memdev=3Dmem0,id=3Dcxl-mem0 \
> -M cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.size=3D4G,cxl-fmw.0.interleave-g=
ranularity=3D4k
>=20
>=20
> But in order to make this multi-headed, some amount of this state would n=
eed
> to be encapsulated in a shared memory region (or would it? I don't know, i
> haven't finished this thought experiment yet).

Someone (wherever the LD pool CCI is) needs to hold shared state.
Lots of options for that.=20

>=20
>=20
> =3D=3D=3D=3D=3D
>  FIN=20
> =3D=3D=3D=3D=3D
>=20
> I realize this was a long.  If you made it to the end of this email,
> thank you reading my TED talk.  I greatly appreciate any comments,
> even if it's just "You've gone too deep, Gregory." ;]

:) You've only just got started.  This goes much deeper!

>=20
> Regards,
> ~Gregory

To my mind there are a series of steps and questions here.

Which 'hotplug model'.
1) LD model for moving capacity
  - If doing LD model, do MLDs and configurable switches first. Needed as a=
 step along the
    path anyway.  Deal with all the mess that brings and come back to MHD -=
 as you note it
    only makes sense with a switch in the path, so MLDs are a subset of the=
 functionality anyway.

2) DCD model for moving cacapcity
  - MH-SLD with a pool CCI used to do DCD operations on the LDs.  Extension=
 of
    what Fan Ni is looking at.  He's making an SLD pretend to be a device
    where DCD makes sense - whilst still using the CXL type 3 device. We pr=
obably shouldn't
    do that without figuring out how to do an MHD-SLD - or at least a head =
that we intend
    to hang this new stuff off - potentially just using the existing type 3=
 device with
    more parameters as one of the MH-SLD heads that doesn't have the contro=
l interface and
    different parameters if it does have the tunnel to the Pool CCI.

Implementing MCTP CCI.  Probably a later step, but need to think what that =
looks like.
I'm thinking we proxy it through to wherever the pool CCI ends up.  Should =
be easy enough
if a little ugly.

So question is whether it's worth a highly modular design, or we just keep =
tacking
flexibility onto existing Type 3 device emulation.  These are all type 3 de=
vices
after all ;)

Lots of fun details to hammer out.

Jonathan


