Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CE386A90F
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 08:37:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEUK-000787-CA; Wed, 28 Feb 2024 02:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfETG-0006uk-Fe
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 02:35:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfETB-0002CT-KL
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 02:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709105711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jtYXyLnp7bwjoHJPkkzUrax45s0QLF/9oIKbZvcy6ho=;
 b=NJ35E/Wzf0RNVrqQ99HXJMbAh492UvLRfp1V9OYsbJVgg8pQ5u2FYNFRuPn7iVSJ+4QzZU
 rE/nDuoidyehCfL8n88E/g4oOpY09iU/oIIj1qxAOYMODMvaOSvUISCCquKqct2eMTotdW
 a66UyBe1Cgty9WfJwS+BCt77W5LHtns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-yvBg73o0OGyLeYZYnIRusg-1; Wed, 28 Feb 2024 02:35:07 -0500
X-MC-Unique: yvBg73o0OGyLeYZYnIRusg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7871085A58A;
 Wed, 28 Feb 2024 07:35:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30BCC400D783;
 Wed, 28 Feb 2024 07:35:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D84221E6767; Wed, 28 Feb 2024 08:35:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: <ankita@nvidia.com>
Cc: <jgg@nvidia.com>,  <alex.williamson@redhat.com>,  <clg@redhat.com>,
 <shannon.zhaosl@gmail.com>,  <peter.maydell@linaro.org>,
 <ani@anisinha.ca>,  <berrange@redhat.com>,  <eduardo@habkost.net>,
 <imammedo@redhat.com>,  <mst@redhat.com>,  <eblake@redhat.com>,
 <armbru@redhat.com>,  <david@redhat.com>,  <gshan@redhat.com>,
 <Jonathan.Cameron@huawei.com>,  <zhiw@nvidia.com>,  <mochs@nvidia.com>,
 <pbonzini@redhat.com>,  <aniketa@nvidia.com>,  <cjia@nvidia.com>,
 <kwankhede@nvidia.com>,  <targupta@nvidia.com>,  <vsethi@nvidia.com>,
 <acurrid@nvidia.com>,  <dnigam@nvidia.com>,  <udhoke@nvidia.com>,
 <qemu-arm@nongnu.org>,  <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 1/2] qom: new object to associate device to numa node
In-Reply-To: <20240223124223.800078-2-ankita@nvidia.com> (ankita@nvidia.com's
 message of "Fri, 23 Feb 2024 12:42:22 +0000")
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-2-ankita@nvidia.com>
Date: Wed, 28 Feb 2024 08:35:05 +0100
Message-ID: <8734td3uty.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

<ankita@nvidia.com> writes:

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
> Implement the mechanism to build the GI affinity structures as Qemu currently
> does not. Introduce a new acpi-generic-initiator object to allow host admin
> link a device with an associated NUMA node. Qemu maintains this association
> and use this object to build the requisite GI Affinity Structure.
>
> When multiple numa nodes are associated with a device, it is required to
> create those many number of acpi-generic-initiator objects, each representing
> a unique device:node association.
>
> Following is one of a decoded GI affinity structure in VM ACPI SRAT.
> [0C8h 0200   1]                Subtable Type : 05 [Generic Initiator Affinity]
> [0C9h 0201   1]                       Length : 20
>
> [0CAh 0202   1]                    Reserved1 : 00
> [0CBh 0203   1]           Device Handle Type : 01
> [0CCh 0204   4]             Proximity Domain : 00000007
> [0D0h 0208  16]                Device Handle : 00 00 20 00 00 00 00 00 00 00 00
> 00 00 00 00 00
> [0E0h 0224   4]        Flags (decoded below) : 00000001
>                                      Enabled : 1
> [0E4h 0228   4]                    Reserved2 : 00000000
>
> [0E8h 0232   1]                Subtable Type : 05 [Generic Initiator Affinity]
> [0E9h 0233   1]                       Length : 20
>
> An admin can provide a range of acpi-generic-initiator objects, each
> associating a device (by providing the id through pci-dev argument)
> to the desired numa node (using the node argument). Currently, only PCI
> device is supported.
>
> For the grace hopper system, create a range of 8 nodes and associate that
> with the device using the acpi-generic-initiator object. While a configuration
> of less than 8 nodes per device is allowed, such configuration will prevent
> utilization of the feature to the fullest. The following sample creates 8
> nodes per PCI device for a VM with 2 PCI devices and link them to the
> respecitve PCI device using acpi-generic-initiator objects:
>
> -numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 \
> -numa node,nodeid=5 -numa node,nodeid=6 -numa node,nodeid=7 \
> -numa node,nodeid=8 -numa node,nodeid=9 \
> -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
> -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
> -object acpi-generic-initiator,id=gi1,pci-dev=dev0,node=3 \
> -object acpi-generic-initiator,id=gi2,pci-dev=dev0,node=4 \
> -object acpi-generic-initiator,id=gi3,pci-dev=dev0,node=5 \
> -object acpi-generic-initiator,id=gi4,pci-dev=dev0,node=6 \
> -object acpi-generic-initiator,id=gi5,pci-dev=dev0,node=7 \
> -object acpi-generic-initiator,id=gi6,pci-dev=dev0,node=8 \
> -object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=9 \
>
> -numa node,nodeid=10 -numa node,nodeid=11 -numa node,nodeid=12 \
> -numa node,nodeid=13 -numa node,nodeid=14 -numa node,nodeid=15 \
> -numa node,nodeid=16 -numa node,nodeid=17 \
> -device vfio-pci-nohotplug,host=0009:01:01.0,bus=pcie.0,addr=05.0,rombar=0,id=dev1 \
> -object acpi-generic-initiator,id=gi8,pci-dev=dev1,node=10 \
> -object acpi-generic-initiator,id=gi9,pci-dev=dev1,node=11 \
> -object acpi-generic-initiator,id=gi10,pci-dev=dev1,node=12 \
> -object acpi-generic-initiator,id=gi11,pci-dev=dev1,node=13 \
> -object acpi-generic-initiator,id=gi12,pci-dev=dev1,node=14 \
> -object acpi-generic-initiator,id=gi13,pci-dev=dev1,node=15 \
> -object acpi-generic-initiator,id=gi14,pci-dev=dev1,node=16 \
> -object acpi-generic-initiator,id=gi15,pci-dev=dev1,node=17 \
>
> The performance benefits can be realized by providing the NUMA node distances
> appropriately (through libvirt tags or Qemu params). The admin can get the
> distance among nodes in hardware using `numactl -H`.
>
> [1] https://www.nvidia.com/en-in/technologies/multi-instance-gpu
>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  hw/acpi/acpi-generic-initiator.c         | 70 ++++++++++++++++++++++++
>  hw/acpi/meson.build                      |  1 +
>  include/hw/acpi/acpi-generic-initiator.h | 32 +++++++++++
>  qapi/qom.json                            | 17 ++++++
>  4 files changed, 120 insertions(+)
>  create mode 100644 hw/acpi/acpi-generic-initiator.c
>  create mode 100644 include/hw/acpi/acpi-generic-initiator.h
>
> diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initiator.c
> new file mode 100644
> index 0000000000..1ade2f723f
> --- /dev/null
> +++ b/hw/acpi/acpi-generic-initiator.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
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
> +
> +    gi->node = MAX_NODES;
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
> +static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
> +                                            const char *name, void *opaque,
> +                                            Error **errp)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +    uint32_t value;
> +
> +    if (!visit_type_uint32(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (value >= MAX_NODES) {
> +        error_printf("%s: Invalid NUMA node specified\n",
> +                     TYPE_ACPI_GENERIC_INITIATOR);
> +        exit(1);
> +    }
> +
> +    gi->node = value;
> +}
> +
> +static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
> +{
> +    object_class_property_add_str(oc, "pci-dev", NULL,
> +        acpi_generic_initiator_set_pci_device);
> +    object_class_property_add(oc, "node", "int", NULL,
> +        acpi_generic_initiator_set_node, NULL, NULL);
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
> index 0000000000..2f183b029a
> --- /dev/null
> +++ b/include/hw/acpi/acpi-generic-initiator.h
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + */
> +
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
> +    uint16_t node;
> +} AcpiGenericInitiator;
> +
> +typedef struct AcpiGenericInitiatorClass {
> +        ObjectClass parent_class;
> +} AcpiGenericInitiatorClass;
> +
> +#endif
> diff --git a/qapi/qom.json b/qapi/qom.json
> index c53ef978ff..7efa0e14f6 100644
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
> +# @node: numa node associated with the PCI device

NUMA

> +#
> +# Since: 9.0
> +##
> +{ 'struct': 'AcpiGenericInitiatorProperties',
> +  'data': { 'pci-dev': 'str',
> +            'node': 'uint32' } }
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

Jonathan, you pointed out interface design issues in your review of v2.
Are you fully satisfied with the interface in v3?


