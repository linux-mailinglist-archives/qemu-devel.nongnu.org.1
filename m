Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C3C8FB1D0
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jun 2024 14:08:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sESwa-0001B1-Gh; Tue, 04 Jun 2024 08:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sESwW-0001Ak-NC
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sESwQ-0005Ec-Q7
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717502820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F1qyUFwzXpsvjcVcWPVmKtz1KW7a1gBKmRWus4frAtE=;
 b=AJzEb/OS1po27S3Wa0jgzrCONHU9XZwNR2tYyJ20rqX34mA38wDs6bFN+5W/pX5Mj5RIj1
 AS2W0nLekrc1YY+nTKhnyrgJq5D6FAMBgFFGxmyHGjRysM4qXfvJ26uSAUHCLqX5y/qCCF
 93Gq+MFZtOn62AqgxbYbX8wrqI1lojM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-pIx58PwUNJWJ2BWiSkuyyA-1; Tue,
 04 Jun 2024 08:06:56 -0400
X-MC-Unique: pIx58PwUNJWJ2BWiSkuyyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F25453C025CE;
 Tue,  4 Jun 2024 12:06:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 646DC111DD02;
 Tue,  4 Jun 2024 12:06:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8592B21E6687; Tue,  4 Jun 2024 14:06:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <ankita@nvidia.com>,  <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>,  <mst@redhat.com>,  <qemu-devel@nongnu.org>,  Dave
 Jiang <dave.jiang@intel.com>,  Huang Ying <ying.huang@intel.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  <eduardo@habkost.net>,
 <imammedo@redhat.com>,  <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>,  Michael Roth <michael.roth@amd.com>,  Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH 3/6] hw/acpi: Generic Port Affinity Structure support
In-Reply-To: <20240430114353.00002ae5@huawei.com> (Jonathan Cameron's message
 of "Tue, 30 Apr 2024 11:43:53 +0100")
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
 <20240403102927.31263-4-Jonathan.Cameron@huawei.com>
 <87r0ewcppm.fsf@pond.sub.org> <20240429185046.00002a7c@Huawei.com>
 <87frv3e3vz.fsf@pond.sub.org> <20240430114353.00002ae5@huawei.com>
Date: Tue, 04 Jun 2024 14:06:53 +0200
Message-ID: <87r0dc7vz6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Sorry for the late reply.  I had to put this aside, and I'm coming back
to it only now.

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Tue, 30 Apr 2024 08:55:12 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
>> 
>> > On Tue, 23 Apr 2024 12:56:21 +0200
>> > Markus Armbruster <armbru@redhat.com> wrote:
>> >  
>> >> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>> >>   
>> >> > These are very similar to the recently added Generic Initiators
>> >> > but instead of representing an initiator of memory traffic they
>> >> > represent an edge point beyond which may lie either targets or
>> >> > initiators.  Here we add these ports such that they may
>> >> > be targets of hmat_lb records to describe the latency and
>> >> > bandwidth from host side initiators to the port.  A descoverable
>> >> > mechanism such as UEFI CDAT read from CXL devices and switches
>> >> > is used to discover the remainder fo the path and the OS can build
>> >> > up full latency and bandwidth numbers as need for work and data
>> >> > placement decisions.
>> >> >
>> >> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
>> >
>> > Hi Markus,
>> >
>> > I've again managed a bad job of defining an interface - thanks for
>> > your help!  
>> 
>> Good interfaces are hard!
>> 
>> >> > ---
>> >> >  qapi/qom.json                            |  18 +++
>> >> >  include/hw/acpi/acpi_generic_initiator.h |  18 ++-
>> >> >  include/hw/pci/pci_bridge.h              |   1 +
>> >> >  hw/acpi/acpi_generic_initiator.c         | 141 +++++++++++++++++------
>> >> >  hw/pci-bridge/pci_expander_bridge.c      |   1 -
>> >> >  5 files changed, 141 insertions(+), 38 deletions(-)
>> >> >
>> >> > diff --git a/qapi/qom.json b/qapi/qom.json
>> >> > index 85e6b4f84a..5480d9ca24 100644
>> >> > --- a/qapi/qom.json
>> >> > +++ b/qapi/qom.json
>> >> > @@ -826,6 +826,22 @@
>> >> >    'data': { 'pci-dev': 'str',
>> >> >              'node': 'uint32' } }
>> >> >  
>> >> > +
>> >> > +##
>> >> > +# @AcpiGenericPortProperties:
>> >> > +#
>> >> > +# Properties for acpi-generic-port objects.
>> >> > +#
>> >> > +# @pci-bus: PCI bus of the hostbridge associated with this SRAT entry    
>> >> 
>> >> What's this exactly?  A QOM path?  A qdev ID?  Something else?  
>> >
>> > QOM path I believe as going to call object_resolve_path_type() on it.  
>> 
>> QOM path then.
>> 
>> > Oddity is it's defined for the bus, not the host bridge that
>> > we care about as the host bridge doesn't have a convenient id to let
>> > us identify it.

Copied from the example below:

    -object acpi-generic-port,id=bob11,pci-bus=cxl.1,node=2

where pci-bus=cxl.1 refers to

    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true

What is "the host bridge that we care about" in that example?

Is pci-bus=cxl.1 a surrogate for a reference to "the host bridge that we
care about"?  I.e. something that enables the C code to find the host
bridge?

>> > e.g. It is specified via --device pxb-cxl,id=XXXX
>> > of TYPE_PXB_CXL_HOST in the command line but ends up on the
>> > TYPE_PCI_BUS with parent set to the PXB_CXL_HOST.
>> > Normally we just want this bus for hanging root ports of it.
>> >
>> > I can clarify it's the QOM path but I'm struggling a bit to explain
>> > the relationship without resorting to an example.
>> > This should also not mention SRAT as at some stage I'd expect DT
>> > bindings to provide similar functionality.  
>> 
>> Let's start with an example.  Not to put it into the doc comment, only
>> to help me understand what you need.  Hopefully I can then assist with
>> improving the interface and/or its documentation.
>
> Stripping out some relevant bits from a test setup and editing it down
> - most of this is about creating relevant SLIT/HMAT tables.
>
> # First a CXL root bridge, root port and direct attached device plus fixed
> # memory window.  Linux currently builds a NUMA node per fixed memory window
> # but that's a simplification that may change over time.
>  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>  -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
>  -device cxl-type3,bus=cxl_rp_port0,volatile-memdev=cxl-mem1,persistent-memdev=cxl-mem2,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
>  -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
>
> # Next line is the port defintion - see that the pci-bus refers to the one in the id parameter for
> # the PXB CXL, but the ACPI table that is generated refers to the DSDT entry via a ACPI0016 entry.
> # So to get to that we use the PCI bus ID of the root bus that forms part of the root bridge (but
> # is a child object in qemu.
>  -numa node,nodeid=2 \
>  -object acpi-generic-port,id=bob11,pci-bus=cxl.1,node=2 \
>
> # The rest is a the setup for the hmat and slit tables.  I hid most of the config, but
> # left this here as key is that we specify values to and from the generic port 'node'
> # but it's not really a node as such, but just a point along the path to one.
>
>  -numa dist,src=0,dst=0,val=10 -numa dist,src=0,dst=1,val=21 -numa dist,src=0,dst=2,val=21 -numa dist,src=0,dst=3,val=21 -numa dist,src=0,dst=4,val=21 -numa dist,src=0,dst=5,val=21 \
>  -numa dist,src=1,dst=0,val=21 -numa dist,src=1,dst=1,val=10 -numa dist,src=1,dst=2,val=21 -numa dist,src=1,dst=3,val=21 -numa dist,src=1,dst=4,val=21 -numa dist,src=1,dst=5,val=21 \
>  -numa dist,src=2,dst=0,val=21 -numa dist,src=2,dst=1,val=21 -numa dist,src=2,dst=2,val=10 -numa dist,src=2,dst=3,val=21 -numa dist,src=2,dst=4,val=21 -numa dist,src=2,dst=5,val=21 \
>  -numa dist,src=3,dst=0,val=21 -numa dist,src=3,dst=1,val=21 -numa dist,src=3,dst=2,val=21 -numa dist,src=3,dst=3,val=10 -numa dist,src=3,dst=4,val=21 -numa dist,src=3,dst=5,val=21 \
>  -numa dist,src=4,dst=0,val=21 -numa dist,src=4,dst=1,val=21 -numa dist,src=4,dst=2,val=21 -numa dist,src=4,dst=3,val=21 -numa dist,src=4,dst=4,val=10 -numa dist,src=4,dst=5,val=21 \
>  -numa dist,src=5,dst=0,val=21 -numa dist,src=5,dst=1,val=21 -numa dist,src=5,dst=2,val=21 -numa dist,src=5,dst=3,val=21 -numa dist,src=5,dst=4,val=21 -numa dist,src=5,dst=5,val=10 \
>  -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=10 \
>  -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=800M \
>  -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-latency,latency=100 \
>  -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
>  -numa hmat-lb,initiator=0,target=4,hierarchy=memory,data-type=access-latency,latency=100 \
>  -numa hmat-lb,initiator=0,target=4,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
>  -numa hmat-lb,initiator=0,target=5,hierarchy=memory,data-type=access-latency,latency=200 \
>  -numa hmat-lb,initiator=0,target=5,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
>  -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-latency,latency=500 \
>  -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M \
>  -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-latency,latency=50 \
>  -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
>  -numa hmat-lb,initiator=1,target=4,hierarchy=memory,data-type=access-latency,latency=50 \
>  -numa hmat-lb,initiator=1,target=4,hierarchy=memory,data-type=access-bandwidth,bandwidth=800M \
>  -numa hmat-lb,initiator=1,target=5,hierarchy=memory,data-type=access-latency,latency=500 \
>  -numa hmat-lb,initiator=1,target=5,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M \
>   -numa hmat-lb,initiator=3,target=0,hierarchy=memory,data-type=access-latency,latency=20 \
>  -numa hmat-lb,initiator=3,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
>  -numa hmat-lb,initiator=3,target=2,hierarchy=memory,data-type=access-latency,latency=80 \
>  -numa hmat-lb,initiator=3,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
>  -numa hmat-lb,initiator=3,target=4,hierarchy=memory,data-type=access-latency,latency=80 \
>  -numa hmat-lb,initiator=3,target=4,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
>  -numa hmat-lb,initiator=3,target=5,hierarchy=memory,data-type=access-latency,latency=20 \
>  -numa hmat-lb,initiator=3,target=5,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
>  -numa hmat-lb,initiator=5,target=0,hierarchy=memory,data-type=access-latency,latency=20 \
>  -numa hmat-lb,initiator=5,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
>  -numa hmat-lb,initiator=5,target=2,hierarchy=memory,data-type=access-latency,latency=80 \
>  -numa hmat-lb,initiator=5,target=4,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
>  -numa hmat-lb,initiator=5,target=4,hierarchy=memory,data-type=access-latency,latency=80 \
>  -numa hmat-lb,initiator=5,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
>  -numa hmat-lb,initiator=5,target=5,hierarchy=memory,data-type=access-latency,latency=10 \
>  -numa hmat-lb,initiator=5,target=5,hierarchy=memory,data-type=access-bandwidth,bandwidth=800M

Uff!

Could you throw in output of "info qom-tree /"?

[...]


