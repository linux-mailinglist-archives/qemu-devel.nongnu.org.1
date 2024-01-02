Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1AF821C1E
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 14:00:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKeMo-00022f-8O; Tue, 02 Jan 2024 07:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rKeMm-00022O-1F; Tue, 02 Jan 2024 07:59:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rKeMh-0003oC-UE; Tue, 02 Jan 2024 07:59:31 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T4CY53bc6z6K9DH;
 Tue,  2 Jan 2024 20:56:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 9B29B140DE1;
 Tue,  2 Jan 2024 20:59:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Jan
 2024 12:58:23 +0000
Date: Tue, 2 Jan 2024 12:58:21 +0000
To: <ankita@nvidia.com>
CC: <jgg@nvidia.com>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>, <ani@anisinha.ca>,
 <berrange@redhat.com>, <eduardo@habkost.net>, <imammedo@redhat.com>,
 <mst@redhat.com>, <eblake@redhat.com>, <armbru@redhat.com>,
 <david@redhat.com>, <gshan@redhat.com>, <aniketa@nvidia.com>,
 <cjia@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <vsethi@nvidia.com>, <acurrid@nvidia.com>, <dnigam@nvidia.com>,
 <udhoke@nvidia.com>, <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 1/2] qom: new object to associate device to numa node
Message-ID: <20240102125821.00001aa0@Huawei.com>
In-Reply-To: <20231225045603.7654-2-ankita@nvidia.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Mon, 25 Dec 2023 10:26:02 +0530
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> NVIDIA GPU's support MIG (Mult-Instance GPUs) feature [1], which allows
> partitioning of the GPU device resources (including device memory) into
> several (upto 8) isolated instances. Each of the partitioned memory needs
> a dedicated NUMA node to operate. The partitions are not fixed and they
> can be created/deleted at runtime.
> 
> Unfortunately Linux OS does not provide a means to dynamically create/destroy
> NUMA nodes and such feature implementation is not expected to be trivial. The
> nodes that OS discovers at the boot time while parsing SRAT remains fixed. So
> we utilize the Generic Initiator Affinity structures that allows association
> between nodes and devices. Multiple GI structures per BDF is possible,
> allowing creation of multiple nodes by exposing unique PXM in each of these
> structures.
> 
> Introduce a new acpi-generic-initiator object to allow host admin provide the
> device and the corresponding NUMA nodes. Qemu maintain this association and
> use this object to build the requisite GI Affinity Structure. On a multi
> device system, each device supporting the features needs a unique
> acpi-generic-initiator object with its own set of NUMA nodes associated to it.
> 
> An admin can provide the range of nodes through a uint16 array host-nodes
> and link it to a device by providing its id. Currently, only PCI device is
> supported. The following sample creates 8 nodes per PCI device for a VM
> with 2 PCI devices and link them to the respecitve PCI device using
> acpi-generic-initiator objects:
> 
> -numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 \
> -numa node,nodeid=5 -numa node,nodeid=6 -numa node,nodeid=7 \
> -numa node,nodeid=8 -numa node,nodeid=9 \
> -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
> -object acpi-generic-initiator,id=gi0,pci-dev=dev0,host-nodes=2-9 \
> 
> -numa node,nodeid=10 -numa node,nodeid=11 -numa node,nodeid=12 \
> -numa node,nodeid=13 -numa node,nodeid=14 -numa node,nodeid=15 \
> -numa node,nodeid=16 -numa node,nodeid=17 \
> -device vfio-pci-nohotplug,host=0009:01:01.0,bus=pcie.0,addr=05.0,rombar=0,id=dev1 \
> -object acpi-generic-initiator,id=gi1,pci-dev=dev1,host-nodes=10-17 \

Hi Ankit,

Whilst I'm still not particularly keen on this use of GI nodes, the
infrastructure is now generic enough that it covers more normal use cases
so I'm almost fine with it going into QEMU. If you want to use it for unusual
things that's up to you ;)  Note that the following is about QEMU allowing
you to potentially shoot yourself in the foot rather than necessarily saying
the interface shouldn't allow a PCI dev to map to multiple GI nodes.

As per reply to the cover letter I definitely want to see SRAT table dumps
in here though so we can easily see what this is actually building.

I worry that some OS might make the assumption that it's one GI node
per PCI device though. The language in the ACPI specification is:

"The Generic Initiator Affinity Structure provides the association between _a_
generic initiator and _the_ proximity domain to which the initiator belongs".

The use of _a_ and _the_ in there makes it pretty explicitly a N:1 relationship
(multiple devices can be in same proximity domain, but a device may only be in one).
To avoid that confusion you will need an ACPI spec change.  I'd be happy to
support 

The reason you can get away with this in Linux today is that I only implemented
a very minimal support for GIs with the mappings being provided the other way
around (_PXM in a PCIe node in DSDT).  If we finish that support off I'd assume
the multiple mappings here will result in a firmware bug warning in at least
some cases.  Note the reason support for the mapping the other way isn't yet
in linux is that we never resolved the mess that a PCI re-enumeration will
cause (requires a pre enumeration pass of what is configured by fw and caching
of the path to all the PCIe devices that lets you access so we can reconstruct
the mapping post enumeration).

Also, this effectively creates a bunch of separate generic initiator nodes
and lumping that under one object seems to imply they are in general connected
to each other.

I'd be happier with a separate instance per GI node

  -object acpi-generic-initiator,id=gi1,pci-dev=dev1,nodeid=10
  -object acpi-generic-initiator,id=gi2,pci-dev=dev1,nodeid=11
etc with the proviso that anyone using this on a system that assumes a one
to one mapping for PCI

However, I'll leave it up to those more familiar with the QEMU numa
control interface design to comment on whether this approach is preferable
to making the gi part of the numa node entry or doing it like hmat.

-numa srat-gi,node-id=10,gi-pci-dev=dev1

etc

> 
> [1] https://www.nvidia.com/en-in/technologies/multi-instance-gpu
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  hw/acpi/acpi-generic-initiator.c         | 70 ++++++++++++++++++++++++
>  hw/acpi/meson.build                      |  1 +
>  include/hw/acpi/acpi-generic-initiator.h | 27 +++++++++
>  qapi/qom.json                            | 17 ++++++
>  4 files changed, 115 insertions(+)
>  create mode 100644 hw/acpi/acpi-generic-initiator.c
>  create mode 100644 include/hw/acpi/acpi-generic-initiator.h
> 
> diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initiator.c
> new file mode 100644
> index 0000000000..e05e28e962
> --- /dev/null
> +++ b/hw/acpi/acpi-generic-initiator.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/acpi-generic-initiator.h"
> +#include "hw/pci/pci_device.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-builtin-visit.h"
> +#include "qapi/visitor.h"
> +#include "qemu/error-report.h"
> +
> +OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
> +                   ACPI_GENERIC_INITIATOR, OBJECT,
> +                   { TYPE_USER_CREATABLE },
> +                   { NULL })
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
> +
> +static void acpi_generic_initiator_init(Object *obj)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +    bitmap_zero(gi->host_nodes, MAX_NODES);
> +    gi->pci_dev = NULL;
> +}
> +
> +static void acpi_generic_initiator_finalize(Object *obj)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +
> +    g_free(gi->pci_dev);
> +}
> +
> +static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
> +                                                  Error **errp)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +
> +    gi->pci_dev = g_strdup(val);
> +}
> +
> +static void
> +acpi_generic_initiator_set_host_nodes(Object *obj, Visitor *v, const char *name,
> +                                      void *opaque, Error **errp)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +    uint16List *l = NULL, *host_nodes = NULL;
> +
> +    visit_type_uint16List(v, name, &host_nodes, errp);
> +
> +    for (l = host_nodes; l; l = l->next) {
> +        if (l->value >= MAX_NODES) {
> +            error_setg(errp, "Invalid host-nodes value: %d", l->value);
> +            break;
> +        } else {
> +            bitmap_set(gi->host_nodes, l->value, 1);
> +        }
> +    }
> +
> +    qapi_free_uint16List(host_nodes);
> +}
> +
> +static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
> +{
> +    object_class_property_add_str(oc, "pci-dev", NULL,
> +        acpi_generic_initiator_set_pci_device);
> +    object_class_property_add(oc, "host-nodes", "int", NULL,
> +        acpi_generic_initiator_set_host_nodes, NULL, NULL);
> +}
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index fc1b952379..2268589519 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -1,5 +1,6 @@
>  acpi_ss = ss.source_set()
>  acpi_ss.add(files(
> +  'acpi-generic-initiator.c',
>    'acpi_interface.c',
>    'aml-build.c',
>    'bios-linker-loader.c',
> diff --git a/include/hw/acpi/acpi-generic-initiator.h b/include/hw/acpi/acpi-generic-initiator.h
> new file mode 100644
> index 0000000000..9643b81951
> --- /dev/null
> +++ b/include/hw/acpi/acpi-generic-initiator.h
> @@ -0,0 +1,27 @@
> +#ifndef ACPI_GENERIC_INITIATOR_H
> +#define ACPI_GENERIC_INITIATOR_H
> +
> +#include "hw/mem/pc-dimm.h"
> +#include "hw/acpi/bios-linker-loader.h"
> +#include "hw/acpi/aml-build.h"
> +#include "sysemu/numa.h"
> +#include "qemu/uuid.h"
> +#include "qom/object.h"
> +#include "qom/object_interfaces.h"
> +
> +#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
> +
> +typedef struct AcpiGenericInitiator {
> +    /* private */
> +    Object parent;
> +
> +    /* public */
> +    char *pci_dev;
> +    DECLARE_BITMAP(host_nodes, MAX_NODES);
> +} AcpiGenericInitiator;
> +
> +typedef struct AcpiGenericInitiatorClass {
> +        ObjectClass parent_class;
> +} AcpiGenericInitiatorClass;
> +
> +#endif
> diff --git a/qapi/qom.json b/qapi/qom.json
> index c53ef978ff..7b33d4a53c 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -794,6 +794,21 @@
>  { 'struct': 'VfioUserServerProperties',
>    'data': { 'socket': 'SocketAddress', 'device': 'str' } }
>  
> +##
> +# @AcpiGenericInitiatorProperties:
> +#
> +# Properties for acpi-generic-initiator objects.
> +#
> +# @pci-dev: PCI device ID to be associated with the node
> +#
> +# @host-nodes: numa node list associated with the PCI device.
> +#
> +# Since: 9.0
> +##
> +{ 'struct': 'AcpiGenericInitiatorProperties',
> +  'data': { 'pci-dev': 'str',
> +            'host-nodes': ['uint16'] } }
> +
>  ##
>  # @RngProperties:
>  #
> @@ -911,6 +926,7 @@
>  ##
>  { 'enum': 'ObjectType',
>    'data': [
> +    'acpi-generic-initiator',
>      'authz-list',
>      'authz-listfile',
>      'authz-pam',
> @@ -981,6 +997,7 @@
>              'id': 'str' },
>    'discriminator': 'qom-type',
>    'data': {
> +      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
>        'authz-list':                 'AuthZListProperties',
>        'authz-listfile':             'AuthZListFileProperties',
>        'authz-pam':                  'AuthZPAMProperties',


