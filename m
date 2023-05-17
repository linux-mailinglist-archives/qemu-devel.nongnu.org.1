Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D714706AF1
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 16:19:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzHzl-00088A-Nu; Wed, 17 May 2023 10:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1pzHzg-00084e-NV
 for qemu-devel@nongnu.org; Wed, 17 May 2023 10:19:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1pzHzc-0004ok-59
 for qemu-devel@nongnu.org; Wed, 17 May 2023 10:19:08 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QLwDk2KCCz6D8yh;
 Wed, 17 May 2023 22:17:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 17 May
 2023 15:19:00 +0100
Date: Wed, 17 May 2023 15:18:59 +0100
To: Gregory Price <gregory.price@memverge.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams
 <dan.j.williams@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vincent Hache <vhache@rambus.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [RFC] cxl: Multi-headed device design
Message-ID: <20230517151859.000055b4@Huawei.com>
In-Reply-To: <ZGMglwWwZCP4FUtW@memverge.com>
References: <ZBpe6btfLuuAS35g@memverge.com>
 <20230515171807.00006d8f@Huawei.com>
 <ZGMglwWwZCP4FUtW@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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

On Tue, 16 May 2023 02:20:07 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Mon, May 15, 2023 at 05:18:07PM +0100, Jonathan Cameron wrote:
> > On Tue, 21 Mar 2023 21:50:33 -0400
> > Gregory Price <gregory.price@memverge.com> wrote:
> >  =20
> > >=20
> > > Ambiguity #1:
> > >=20
> > > * An SLD contains 1 Logical Device.
> > > * An MH-SLD presents multiple SLDs, one per head.
> > >=20
> > > Ergo an MH-SLD contains multiple LDs which makes it an MLD according =
to the
> > > definition of LD, but not according to the definition of MLD, or MH-M=
LD. =20
> >=20
> > I'd go with 'sort of'.  SLD is a presentation of a device to a host.
> > It can be a normal single headed MLD that has been plugged directly int=
o a host.
> >=20
> > So for extra fun points you can have one MH-MLD that has some ports con=
nected
> > to switches and other directly to hosts. Thus it can present as SLD on =
some
> > upstream ports and as MLD on others.
> > =20
>=20
> I suppose this section of the email was really to just point out that
> what constitutions a "multi-headed", "logical", and "multi-logical"
> device is rather confusing from just reading the spec.  Since writing
> this, i've kind of settled on:
>=20
> MH-* - anything with multiple heads, regardless of how it works
> SLD - one LD per head, but LD does not imply any particular command set
> MLD - multiple LD's per head, but those LD's may only attach to one head
> DCD - anything can technically be a DCD if it implements the commands
>=20
> Trying to figure out, from the spec, "what commands an MH-SLD" should
> implement to be "Spec Compliance" was my frustration.  It's somewhat
> clear now that the answer is "Technically nothing... unless its an MLD".

Sounds about right :)  Some of this is intentional - it's a grab bag
of features an options not a nice clean definition of 'the right set
to implement'. Market should probably drive that. I think expectation is
defacto feature set standards will happen - but outside of the CXL spec.

>=20
> > > I want to make very close note of this.  SLD's are managed like SLDs
> > > SLDs, MLDs are managed like MLDs.  MH-SLDs, according to this, should=
 be
> > > managed like SLDs from the perspective of each host. =20
> >=20
> > True, but an MH-MLD device connected directly to a host will also=20
> > be managed (at some level anyway) as an SLD on that particular port.
> > =20
>=20
> The ambiguous part is... what commands relate specifically to an SLD?
> The spec isn't really written that way, and the answer is that an SLD is
> more of a lack of other functionality (specifically MLD functionality),
> rather than its own set of functionality.

Yup.

>=20
> i.e. an SLD does not require an FM-Owned LD for management, but an MHD,
> MLD, and DCD all do (at least in theory).

DCD 'might' though I don't think anything in the spec rules that you 'must'
control the SLD/MLD via the FM-API, it's just a spec provided option.
=46rom our point of view we don't want to get more creative so lets assume
it does.

I can't immediately think of reason for a single head SLD to have an FM own=
ed
LD, though it may well have an MCTP CCI for querying stuff about it from an=
 FM.

>=20
> > >=20
> > > 2.5.1 continues on to describe "LD Management in MH-MLDs" but just ig=
nores
> > > that MH-SLDs (may) exist.  That's frustrating to say the least, but I
> > > suppose we can gather from context that MH-SLD's *MAY NOT* have LD
> > > management controls. =20
> >=20
> > Hmm. In theory you could have an MH-SLD that used a config from flash o=
r similar
> > but that would be odd.  We need some level of dynamic control to make t=
hese
> > devices useful.  Doesn't mean the spec should exclude dumb devices, but
> > we shouldn't concentrate on them for emulation.
> >=20
> > One possible usecase would be a device that always shares all it's memo=
ry on
> > all ports. Yuk.
> >  =20
>=20
> I can say that the earliest forms of MH-SLD, and certainly pre-DCD, is
> likely to present all memory on all ports, and potentially provide some
> custom commands to help hosts enforce exclusivity.
>=20
> It's beyond the spec, but this can actually be emulated today with the
> MH-SLD setup I describe below.  Certainly I expected a yuk factor to
> proposing it, but I think the reality is on the path to 3.0 and DCD
> devices we should at least entertain that someone will probably do this
> with real hardware.

=46rom point of view of the Spec what you describe is an MH-SLD in which
all the memory is shared - non coherent.  That's a valid choice - be it
a much nastier option than either DCD based or sharing with coherency.

It might fall out as an option in a flexibly defined MLD, but I'm not
particularly interested in that case (don't mind if you are though!)

>=20
> > > For the simplest MH-SLD device, these fields would be immutable, and
> > > there would be a single LD for each head, where head_id =3D=3D ld_id.=
 =20
> >=20
> > Agreed.
> >  =20
> > >=20
> > > So summarizing, what I took away from this was the following:
> > >=20
> > > In the simplest form of MH-SLD, there's is neither a switch, nor is
> > > there LD management.  So, presumably, we don't HAVE to implement the
> > > MHD commands to say we "have MH-SLD support". =20
> >=20
> > Whilst theoretically possible - I don' think such a device is interesti=
ng.
> > Minimum I'd want to see is something with multiple upstream SLD ports
> > and a management LD with appropriate interface to poke it.
> >=20
> >
> > The MLD side of things is interesting only once we support MLDs in gene=
ral
> > in QEMU CXL emulation and even then they are near invisible to a host
> > and are more interesting for emulating fabric management.
> >=20
> > What you may want to do is take Fan's work on DCD and look at doing
> > a simple MH-SLD device that uses same cheat of just using QMP commands
> > to do the configuration.  That's an intermediate step to us getting
> > the FM-API and similar commands implemented.
> >  =20
>=20
> I actually think it's a good step to go from MH-SLD to MH-SLD+DCD while
> not having to worry about the complexity of MLD and switches.

Maybe, there are other flows that only work for MLD and switches that aren't
MHD related (hotplug basically) so those might get explored in parallel.

>=20
> (I have not gotten the chance to review the DCD patch set yet, it's on
> my list for after ISC'23, I presume this is what has been done).

At moment it's just an SLD with DCD presentation to host.  Nothing on the c=
ontrol
side.


>=20
> My thoughts would be that you would have something like the following:
>=20
> -device ct3d,... etc etc
> -device cxl-dcd,type3-backend=3Dmem0,manager=3Dtrue

DCD is just an aspect of a type 3 device.  I'm fine with a manager
element, but don't call it cxl-dcd.

>=20
> the manager would be the owner of the FM-Owned LD, and therefore the
> system responsible for managing requests for memory.
>=20
> How we pass those messages between instances is then an exercise for the
> reader.
>=20
>=20
> What I have been doing is just creating a shared memory region with
> mkipc and using a separate program to initiate that shared state before
> launching the guests.  I'll talk about this a little further down.
>=20
>=20
> > >=20
> > > ... snip ...
> > >=20
> > > 3. MH-SLD w/ Pool CCI  (Implementing only Get Multi-Headed Info) =20
> >=20
> > I'd do this + DCD.
> >  =20
>=20
> I concur, and it's what i was looking into next.
>=20
> I think your other notes on MH-* with switches is really where I was
> left scratching my head.
>=20
> When I look at Switch/MLD functionality vs DCD, I have a gut feeling the
> vast majority of early device vendors are going to skip right over
> switches and MLD setups and go directly to MH-SLD+DCD.

Yup. That's likely  - though probably more driven by switch latency concerns
than by complexity.  MLDs aren't too bad, and the DCD parts etc are the
same as for SLD.

>=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > 2. MH-SLD No Switch, No Pool CCI.
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > But it's also not very useful.  You can only use the memory in devdax
> > > mode, since it's a shared memory region. You could already do this via
> > > the /dev/shm interface, so it's not even new functionality.
> > >=20
> > > In theory you could build a pooling service in software-only on top of
> > > memory blocks. That's an exercise left to the reader. =20
> >=20
> > Yeah. Let's not do this step.
> >  =20
>=20
> To late :].  It was useful as a learning exercise, but it's definitely
> not upstream quality.  I may post it for the sake of the playground, but
> I too would recommend against this method of pooling in the long term.
>=20
> I made a proto-DCD command set that was reachable from each memdev
> character device, and exposed it to every qemu instance as part of ct3d
> (I'm still learning the QEMU ecosystem, so was easier to bodge it in
> than make a new device and link it up).
>=20
> Then I created a shared memory region with mkipc, and implemented a
> simple mutex in the space, as well as all the record keeping needed to
> manage sections/extents.
>=20
> > > shmid1=3D`ipcmk -M 4096 | grep -o -E '[0-9]+' | head -1`
> > > ./cxl_mhd_init 4 $shmid1
> > > -device cxl-type3,bus=3Drp0,volatile-memdev=3Dmem0,id=3Dcxl-mem0,mhd=
=3Dtrue,mhd_head=3D0,mhd_shmid=3D$1
> > >=20
> > > ./cxl_mhd_init would simply setup the nr_heads/lds field and such
> > > and set ldmap[0-3] to the values [0-3].  i.e. the head-to-ld mappings
> > > are static (head_id=3D=3Dld_id).
> > > ... snip ...
> > >
> > > shmid1=3D`ipcmk -M 4096 | grep -o -E '[0-9]+' | head -1`
> > > ./cxl_mhd_init 4 $shmid1
> > > -device cxl-mhd-sld,bus=3Drp0,volatile-memdev=3Dmem0,id=3Dcxl-mem0,mh=
d_head=3D0,mhd_shmid=3Dshmid =20
>=20
> The last step was a few extra lines in the read/write functions to
> ensure accesses to "Valid addresses" that "Aren't allocated" produce
> errors.
>=20
> At this point, each guest is capable basically using the device to do
> the coordination for you by simply calling the allocate/deallocate
> functions.
>=20
> And that's it, you've got pooling.  Each guest sees the full extent of
> the entire device, but must ask the device for access to a given
> section, and the section can be translated into a memory block number
> under the given numa node.
>=20

This is a valid model, but I'd do the management out of band.=20
We could add BI support though if that's really useful (I don't think
I can go into why non coherency is a problem in some real hardware for
this usecase... watch this space)

>=20
> Ok, now lets talk about why this is a bad and why you shouldn't do it
> this way:
>=20
> * Technically a number of bios/hardware interleave functionality can
>   bite you pretty hard when making the assumption that memory blocks are
>   physically contiguous hardware addresses. However, that assumption
>   holds if you simply don't turn those options on, so it might be useful
>   as an early-adopter platform.

I'd never enumerate these from BIOS - doesn't make sense for something
there for dynamic runtime allocation.
Interleave indeed hard - don't do it (yet)

>=20
>=20
> * The security posutre of a device like this is bad.  It requires each
>   attached host to clear the memory before releasing it.  There isn't
>   really a good way to do this in numa-mode, so you would have to
>   implement custom firmware commands to ensure it happens, and that
>   means custom drivers blah blah blah - not great.
>=20
>   Basically you're trusting each host to play nice.  Not great.
>   But potentially useful for early adopters regardless.

Agreed. I'd put it down as horrible - no one should build this ;)

>=20
>=20
> * General compaitibility and being in-spec - this design requires a
>   number of non-spec extensions, so just generally not recommended,
>   certainly not here in QEMU.

Hmm. Does it?  Looks to me like it would be present to hosts as multiple
SLDs with volatile regions and a CDAT that presents DSMAS with
flags for Shareable / !Hardware managed coherency (or wire up
the missing bits of BI enablement in QEMU - doesn't actually do anything
but we should provide the various registers and correctly enable it
in the kernel)

The fact it's an MHD isn't visible to the hosts, so I think this
is spec compliant if odd.

If you meant the control path.  Also fine as long as you just do it through
memory and a 'convention' on software side for where that shared set
of info is + some fun algorithms to deal with mutex etc. Needs BI support
though.

>=20
> >=20
> > A few different moving parts are needed and I think we'd end up with so=
mething that
> > looks like
> >=20
> > -device cxl-mhd,volatile-memdev=3Dmem0,id=3Dbackend
> > -device cxl-mhd-sld,mhd=3Dbackend,bus=3Drp0,mhd-head=3D0,id=3Ddev1,tunn=
el=3Dtrue
> > -device cxl-mhd-sld,mhd=3Dbackend,bus=3Drp1,mhd-head=3D1,id=3Ddev2
> >=20
> > dev1 provides the tunneling interface, but the actual implementation of
> > the pool CCI and actual memory mappings is in the backend. Note that ba=
ckend
> > might be proxy to an external process, or a client/server approach betw=
een multiple
> > QEMU instances. =20
>=20
> I've hummed and hawwed over external process vs another QEMU instance and=
 I
> still haven't come to a satisfying answer here.  It feels extremely
> heavy-handed to use an entirely separate QEMU instance just for this,
> but there's nothing to say you can't just host it in one of the
> head-attached instances.

MHD is only really interesting (for hardware coherent sharing anyway)
if you have multiple host OS so that's multiple QEMU instances.

If there is a 'main' instance of QEMU then everything should still work
though so can leave the subordinate instances for future work.

>=20
> I basically skipped this and allowed each instance to send the command
> themselves, but serialized it with a mutex.  That way each instance can
> operate cleanly without directly coordinating with each other.  I could
> see a vendor implementing it this way on early devices.

That control would have to be out of band if using memory, or require BI.
BI requires CXL 3.0 host, whereas a DCD based MHD (sure defined in CXL 3.0)=
 would
work with a CXL 2.0 host - well probably even a CXL 1.1 host, but who wants
to bother with those..

I suspect we'll see impdef versions.  DCD is at heart pretty simple though
so I'd expect it to turn up fairly fast after first memory pool devices.


>=20
> I don't have a good answer for this yet, but maybe once I review the DCD
> patch set I'll have more opinions.
>=20
> >=20
> > or squish some parts and make a more extensible type3 device and have.
> >=20
> > -device cxl-type3,volatile-memdev=3Dmem0,bus=3Drp0,mhd-head=3D0,id=3Dde=
v1,mhd-main=3Dtrue
> > -device cxl-type3,mhd=3Ddev1,bus=3Drp1,mhd-head=3D1,id=3Ddev2
> >  =20
>=20
> I originally went this route, but the downside of this is "What happens
> when the main dies and has to restart".  There's all of kinds of
> badness associated with that.  It's why i moved the shared state into a
> separately created mkipc region.

Modelling. I don't care if that happens :)  You are right however that
it would need more care. External process probably makes sense - can
be pretty light weight.

>=20
> >=20
> > To my mind there are a series of steps and questions here.
> >=20
> > Which 'hotplug model'.
> > 1) LD model for moving capacity
> >   - If doing LD model, do MLDs and configurable switches first. Needed =
as a step along the
> >     path anyway.  Deal with all the mess that brings and come back to M=
HD - as you note it
> >     only makes sense with a switch in the path, so MLDs are a subset of=
 the functionality anyway.
> >=20
> > 2) DCD model for moving cacapcity
> >   - MH-SLD with a pool CCI used to do DCD operations on the LDs.  Exten=
sion of
> >     what Fan Ni is looking at.  He's making an SLD pretend to be a devi=
ce
> >     where DCD makes sense - whilst still using the CXL type 3 device. W=
e probably shouldn't
> >     do that without figuring out how to do an MHD-SLD - or at least a h=
ead that we intend
> >     to hang this new stuff off - potentially just using the existing ty=
pe 3 device with
> >     more parameters as one of the MH-SLD heads that doesn't have the co=
ntrol interface and
> >     different parameters if it does have the tunnel to the Pool CCI.
> >  =20
>=20
> Personally I think we should focus on the DCD model.  In fact, I think
> we're already very close to this, as my personal prototype showed this
> can work fairly cleanly, and I imagine I'll have a quick MHD patch set
> once I get the change to review the DCD patch set.

Agreed. It's easier.

>=20
> If I'm being the honest, the more I look at the LD model, the less I
> like it, but I understand that's how scale is going to be achieved.  I
> don't know if focusing on that design right now is going to produce
> adoption in the short term, since we're not likely to see those devices
> for a few years.
>=20
> MH-SLD+DCD is likely to show up much sooner, so I will target that.

Yup.  The switch case is interesting for driving Fabric Manager architecture
so I'd like to enable it at somepoint, but device wise MH-SLD+DCD is probab=
ly
going to come first.

I might extend the switch CCI or the MCTP CCI PoC enough to get comms up and
query stuff, but focus will be on a mailbox on the MHD - note have to ensure
only one of those for the FM API controls driving DCD.=20

Jonathan

>=20
> ~Gregory


