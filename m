Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C918B7053
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Apr 2024 12:45:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ky5-0007tX-V4; Tue, 30 Apr 2024 06:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s1ky0-0007tE-1V
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:44:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s1kxu-0007kR-TU
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:44:07 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTGyK2JhLz6K8wd;
 Tue, 30 Apr 2024 18:43:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 27987140A08;
 Tue, 30 Apr 2024 18:43:55 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 11:43:54 +0100
Date: Tue, 30 Apr 2024 11:43:53 +0100
To: Markus Armbruster <armbru@redhat.com>
CC: <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>,
 <mst@redhat.com>, <qemu-devel@nongnu.org>, Dave Jiang <dave.jiang@intel.com>, 
 Huang Ying <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <imammedo@redhat.com>, <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH 3/6] hw/acpi: Generic Port Affinity Structure support
Message-ID: <20240430114353.00002ae5@huawei.com>
In-Reply-To: <87frv3e3vz.fsf@pond.sub.org>
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
 <20240403102927.31263-4-Jonathan.Cameron@huawei.com>
 <87r0ewcppm.fsf@pond.sub.org> <20240429185046.00002a7c@Huawei.com>
 <87frv3e3vz.fsf@pond.sub.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 30 Apr 2024 08:55:12 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
> 
> > On Tue, 23 Apr 2024 12:56:21 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >  
> >> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> >>   
> >> > These are very similar to the recently added Generic Initiators
> >> > but instead of representing an initiator of memory traffic they
> >> > represent an edge point beyond which may lie either targets or
> >> > initiators.  Here we add these ports such that they may
> >> > be targets of hmat_lb records to describe the latency and
> >> > bandwidth from host side initiators to the port.  A descoverable
> >> > mechanism such as UEFI CDAT read from CXL devices and switches
> >> > is used to discover the remainder fo the path and the OS can build
> >> > up full latency and bandwidth numbers as need for work and data
> >> > placement decisions.
> >> >
> >> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> >
> > Hi Markus,
> >
> > I've again managed a bad job of defining an interface - thanks for
> > your help!  
> 
> Good interfaces are hard!
> 
> >> > ---
> >> >  qapi/qom.json                            |  18 +++
> >> >  include/hw/acpi/acpi_generic_initiator.h |  18 ++-
> >> >  include/hw/pci/pci_bridge.h              |   1 +
> >> >  hw/acpi/acpi_generic_initiator.c         | 141 +++++++++++++++++------
> >> >  hw/pci-bridge/pci_expander_bridge.c      |   1 -
> >> >  5 files changed, 141 insertions(+), 38 deletions(-)
> >> >
> >> > diff --git a/qapi/qom.json b/qapi/qom.json
> >> > index 85e6b4f84a..5480d9ca24 100644
> >> > --- a/qapi/qom.json
> >> > +++ b/qapi/qom.json
> >> > @@ -826,6 +826,22 @@
> >> >    'data': { 'pci-dev': 'str',
> >> >              'node': 'uint32' } }
> >> >  
> >> > +
> >> > +##
> >> > +# @AcpiGenericPortProperties:
> >> > +#
> >> > +# Properties for acpi-generic-port objects.
> >> > +#
> >> > +# @pci-bus: PCI bus of the hostbridge associated with this SRAT entry    
> >> 
> >> What's this exactly?  A QOM path?  A qdev ID?  Something else?  
> >
> > QOM path I believe as going to call object_resolve_path_type() on it.  
> 
> QOM path then.
> 
> > Oddity is it's defined for the bus, not the host bridge that
> > we care about as the host bridge doesn't have a convenient id to let
> > us identify it.
> >
> > e.g. It is specified via --device pxb-cxl,id=XXXX
> > of TYPE_PXB_CXL_HOST in the command line but ends up on the
> > TYPE_PCI_BUS with parent set to the PXB_CXL_HOST.
> > Normally we just want this bus for hanging root ports of it.
> >
> > I can clarify it's the QOM path but I'm struggling a bit to explain
> > the relationship without resorting to an example.
> > This should also not mention SRAT as at some stage I'd expect DT
> > bindings to provide similar functionality.  
> 
> Let's start with an example.  Not to put it into the doc comment, only
> to help me understand what you need.  Hopefully I can then assist with
> improving the interface and/or its documentation.

Stripping out some relevant bits from a test setup and editing it down
- most of this is about creating relevant SLIT/HMAT tables.

# First a CXL root bridge, root port and direct attached device plus fixed
# memory window.  Linux currently builds a NUMA node per fixed memory window
# but that's a simplification that may change over time.
 -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
 -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
 -device cxl-type3,bus=cxl_rp_port0,volatile-memdev=cxl-mem1,persistent-memdev=cxl-mem2,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
 -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \

# Next line is the port defintion - see that the pci-bus refers to the one in the id parameter for
# the PXB CXL, but the ACPI table that is generated refers to the DSDT entry via a ACPI0016 entry.
# So to get to that we use the PCI bus ID of the root bus that forms part of the root bridge (but
# is a child object in qemu.
 -numa node,nodeid=2 \
 -object acpi-generic-port,id=bob11,pci-bus=cxl.1,node=2 \

# The rest is a the setup for the hmat and slit tables.  I hid most of the config, but
# left this here as key is that we specify values to and from the generic port 'node'
# but it's not really a node as such, but just a point along the path to one.

 -numa dist,src=0,dst=0,val=10 -numa dist,src=0,dst=1,val=21 -numa dist,src=0,dst=2,val=21 -numa dist,src=0,dst=3,val=21 -numa dist,src=0,dst=4,val=21 -numa dist,src=0,dst=5,val=21 \
 -numa dist,src=1,dst=0,val=21 -numa dist,src=1,dst=1,val=10 -numa dist,src=1,dst=2,val=21 -numa dist,src=1,dst=3,val=21 -numa dist,src=1,dst=4,val=21 -numa dist,src=1,dst=5,val=21 \
 -numa dist,src=2,dst=0,val=21 -numa dist,src=2,dst=1,val=21 -numa dist,src=2,dst=2,val=10 -numa dist,src=2,dst=3,val=21 -numa dist,src=2,dst=4,val=21 -numa dist,src=2,dst=5,val=21 \
 -numa dist,src=3,dst=0,val=21 -numa dist,src=3,dst=1,val=21 -numa dist,src=3,dst=2,val=21 -numa dist,src=3,dst=3,val=10 -numa dist,src=3,dst=4,val=21 -numa dist,src=3,dst=5,val=21 \
 -numa dist,src=4,dst=0,val=21 -numa dist,src=4,dst=1,val=21 -numa dist,src=4,dst=2,val=21 -numa dist,src=4,dst=3,val=21 -numa dist,src=4,dst=4,val=10 -numa dist,src=4,dst=5,val=21 \
 -numa dist,src=5,dst=0,val=21 -numa dist,src=5,dst=1,val=21 -numa dist,src=5,dst=2,val=21 -numa dist,src=5,dst=3,val=21 -numa dist,src=5,dst=4,val=21 -numa dist,src=5,dst=5,val=10 \
 -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=10 \
 -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=800M \
 -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-latency,latency=100 \
 -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
 -numa hmat-lb,initiator=0,target=4,hierarchy=memory,data-type=access-latency,latency=100 \
 -numa hmat-lb,initiator=0,target=4,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
 -numa hmat-lb,initiator=0,target=5,hierarchy=memory,data-type=access-latency,latency=200 \
 -numa hmat-lb,initiator=0,target=5,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
 -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-latency,latency=500 \
 -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M \
 -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-latency,latency=50 \
 -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
 -numa hmat-lb,initiator=1,target=4,hierarchy=memory,data-type=access-latency,latency=50 \
 -numa hmat-lb,initiator=1,target=4,hierarchy=memory,data-type=access-bandwidth,bandwidth=800M \
 -numa hmat-lb,initiator=1,target=5,hierarchy=memory,data-type=access-latency,latency=500 \
 -numa hmat-lb,initiator=1,target=5,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M \
  -numa hmat-lb,initiator=3,target=0,hierarchy=memory,data-type=access-latency,latency=20 \
 -numa hmat-lb,initiator=3,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
 -numa hmat-lb,initiator=3,target=2,hierarchy=memory,data-type=access-latency,latency=80 \
 -numa hmat-lb,initiator=3,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
 -numa hmat-lb,initiator=3,target=4,hierarchy=memory,data-type=access-latency,latency=80 \
 -numa hmat-lb,initiator=3,target=4,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
 -numa hmat-lb,initiator=3,target=5,hierarchy=memory,data-type=access-latency,latency=20 \
 -numa hmat-lb,initiator=3,target=5,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
 -numa hmat-lb,initiator=5,target=0,hierarchy=memory,data-type=access-latency,latency=20 \
 -numa hmat-lb,initiator=5,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
 -numa hmat-lb,initiator=5,target=2,hierarchy=memory,data-type=access-latency,latency=80 \
 -numa hmat-lb,initiator=5,target=4,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
 -numa hmat-lb,initiator=5,target=4,hierarchy=memory,data-type=access-latency,latency=80 \
 -numa hmat-lb,initiator=5,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
 -numa hmat-lb,initiator=5,target=5,hierarchy=memory,data-type=access-latency,latency=10 \
 -numa hmat-lb,initiator=5,target=5,hierarchy=memory,data-type=access-bandwidth,bandwidth=800M


> 
> >> > +#
> >> > +# @node: numa node associated with the PCI device    
> >> 
> >> NUMA
> >> 
> >> Is this a NUMA node ID?  
> >
> > Fair question with a non obvious answer.  ACPI wise it's a proximity domain.
> > In every other SRAT entry (which define proximity domains) this does map
> > to a NUMA node in an operating system as they contain at least either some
> > form of memory access initiator (CPU, Generic Initiator etc) or a target (memory).
> >
> > A Generic Port is subtly different in that it defines a proximity domain
> > that in of itself is not what we'd think of as a NUMA node but
> > rather an entity that exists to provide the info to the OS to stitch
> > together non discoverable and discoverable buses.
> >
> > So I should have gone with something more specific. Could add this to
> > the parameter docs, or is it too much?
> >
> > @node: Similar to a NUMA node ID, but instead of providing a reference
> >        point used for defining NUMA distances and access characteristics
> >        to memory or from an initiator (e.g. CPU), this node defines the
> >        boundary point between non discoverable system buses which must be
> >        discovered from firmware, and a discoverable bus.  NUMA distances
> >        and access characteristics are defined to and from that point,
> >        but for system software to establish full initiator to target
> >        characteristics this information must be combined with information
> >        retrieved form the discoverable part of the path.  An example would
> >        use CDAT information read from devices and switches in conjunction
> >        with link characteristics read from PCIe Configuration space.  
> 
> This is mostly greek to me :)  Bit I don't think it's too much.
> 
> >> > +#
> >> > +# Since: 9.1
> >> > +##
> >> > +{ 'struct': 'AcpiGenericPortProperties',
> >> > +  'data': { 'pci-bus': 'str',
> >> > +            'node': 'uint32' } }
> >> > +
> >> >  ##
> >> >  # @RngProperties:
> >> >  #
> >> > @@ -944,6 +960,7 @@
> >> >  { 'enum': 'ObjectType',
> >> >    'data': [
> >> >      'acpi-generic-initiator',
> >> > +    'acpi-generic-port',
> >> >      'authz-list',
> >> >      'authz-listfile',
> >> >      'authz-pam',
> >> > @@ -1016,6 +1033,7 @@
> >> >    'discriminator': 'qom-type',
> >> >    'data': {
> >> >        'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
> >> > +      'acpi-generic-port':          'AcpiGenericPortProperties',
> >> >        'authz-list':                 'AuthZListProperties',
> >> >        'authz-listfile':             'AuthZListFileProperties',
> >> >        'authz-pam':                  'AuthZPAMProperties',    
> >> 
> >> [...]
> >> 
> >>   
> 


