Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 012388B609C
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Apr 2024 19:52:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1V9t-0003Jv-35; Mon, 29 Apr 2024 13:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s1V9o-0003JK-7q
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 13:51:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s1V9Y-0006sW-T0
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 13:51:15 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VSrQj3KF0z6J9gC;
 Tue, 30 Apr 2024 01:48:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 43F44140C98;
 Tue, 30 Apr 2024 01:50:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Apr
 2024 18:50:47 +0100
Date: Mon, 29 Apr 2024 18:50:46 +0100
To: Markus Armbruster <armbru@redhat.com>
CC: <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>,
 <mst@redhat.com>, <qemu-devel@nongnu.org>, Dave Jiang <dave.jiang@intel.com>, 
 Huang Ying <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <imammedo@redhat.com>, <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH 3/6] hw/acpi: Generic Port Affinity Structure support
Message-ID: <20240429185046.00002a7c@Huawei.com>
In-Reply-To: <87r0ewcppm.fsf@pond.sub.org>
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
 <20240403102927.31263-4-Jonathan.Cameron@huawei.com>
 <87r0ewcppm.fsf@pond.sub.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 23 Apr 2024 12:56:21 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > These are very similar to the recently added Generic Initiators
> > but instead of representing an initiator of memory traffic they
> > represent an edge point beyond which may lie either targets or
> > initiators.  Here we add these ports such that they may
> > be targets of hmat_lb records to describe the latency and
> > bandwidth from host side initiators to the port.  A descoverable
> > mechanism such as UEFI CDAT read from CXL devices and switches
> > is used to discover the remainder fo the path and the OS can build
> > up full latency and bandwidth numbers as need for work and data
> > placement decisions.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi Markus,

I've again managed a bad job of defining an interface - thanks for
your help!

> > ---
> >  qapi/qom.json                            |  18 +++
> >  include/hw/acpi/acpi_generic_initiator.h |  18 ++-
> >  include/hw/pci/pci_bridge.h              |   1 +
> >  hw/acpi/acpi_generic_initiator.c         | 141 +++++++++++++++++------
> >  hw/pci-bridge/pci_expander_bridge.c      |   1 -
> >  5 files changed, 141 insertions(+), 38 deletions(-)
> >
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 85e6b4f84a..5480d9ca24 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -826,6 +826,22 @@
> >    'data': { 'pci-dev': 'str',
> >              'node': 'uint32' } }
> >  
> > +
> > +##
> > +# @AcpiGenericPortProperties:
> > +#
> > +# Properties for acpi-generic-port objects.
> > +#
> > +# @pci-bus: PCI bus of the hostbridge associated with this SRAT entry  
> 
> What's this exactly?  A QOM path?  A qdev ID?  Something else?

QOM path I believe as going to call object_resolve_path_type() on it.
Oddity is it's defined for the bus, not the host bridge that
we care about as the host bridge doesn't have a convenient id to let
us identify it.

e.g. It is specified via --device pxb-cxl,id=XXXX
of TYPE_PXB_CXL_HOST in the command line but ends up on the
TYPE_PCI_BUS with parent set to the PXB_CXL_HOST.
Normally we just want this bus for hanging root ports of it.

I can clarify it's the QOM path but I'm struggling a bit to explain
the relationship without resorting to an example.
This should also not mention SRAT as at some stage I'd expect DT
bindings to provide similar functionality.


> 
> > +#
> > +# @node: numa node associated with the PCI device  
> 
> NUMA
> 
> Is this a NUMA node ID?

Fair question with a non obvious answer.  ACPI wise it's a proximity domain.
In every other SRAT entry (which define proximity domains) this does map
to a NUMA node in an operating system as they contain at least either some
form of memory access initiator (CPU, Generic Initiator etc) or a target (memory).

A Generic Port is subtly different in that it defines a proximity domain
that in of itself is not what we'd think of as a NUMA node but
rather an entity that exists to provide the info to the OS to stitch
together non discoverable and discoverable buses.

So I should have gone with something more specific. Could add this to
the parameter docs, or is it too much?

@node: Similar to a NUMA node ID, but instead of providing a reference
       point used for defining NUMA distances and access characteristics
       to memory or from an initiator (e.g. CPU), this node defines the
       boundary point between non discoverable system buses which must be
       discovered from firmware, and a discoverable bus.  NUMA distances
       and access characteristics are defined to and from that point,
       but for system software to establish full initiator to target
       characteristics this information must be combined with information
       retrieved form the discoverable part of the path.  An example would
       use CDAT information read from devices and switches in conjunction
       with link characteristics read from PCIe Configuration space.




> 
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'struct': 'AcpiGenericPortProperties',
> > +  'data': { 'pci-bus': 'str',
> > +            'node': 'uint32' } }
> > +
> >  ##
> >  # @RngProperties:
> >  #
> > @@ -944,6 +960,7 @@
> >  { 'enum': 'ObjectType',
> >    'data': [
> >      'acpi-generic-initiator',
> > +    'acpi-generic-port',
> >      'authz-list',
> >      'authz-listfile',
> >      'authz-pam',
> > @@ -1016,6 +1033,7 @@
> >    'discriminator': 'qom-type',
> >    'data': {
> >        'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
> > +      'acpi-generic-port':          'AcpiGenericPortProperties',
> >        'authz-list':                 'AuthZListProperties',
> >        'authz-listfile':             'AuthZListFileProperties',
> >        'authz-pam':                  'AuthZPAMProperties',  
> 
> [...]
> 
> 


