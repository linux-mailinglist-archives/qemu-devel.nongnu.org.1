Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BE97FADD3
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 23:59:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7kYK-0006Cl-J9; Mon, 27 Nov 2023 17:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1r7kYG-0006Bw-2C
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 17:58:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1r7kYC-0004pk-Nq
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 17:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701125879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4OLI+Pgg2mT/MxHuN4CHsnhmzDrDJCO/gEFpWoR3qzI=;
 b=dtzooY7tdtoY++yz0PILO+DA1U69CJiJ2Hx0+cTI1oa2v4SNrvfL5wCAxnD7vu/xD2+x+8
 btACOk6vi+b8GbXPzA32Dmd833hJm3UHuC8tIyFBkhaHWwqqvQ59mBJ3QufQUGVQffY2fU
 LdOUwpLJXGAFjgstLmjTMCAQm7npm6M=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-xFj3HWHUO3Cf5NTGsSHAoA-1; Mon, 27 Nov 2023 17:57:58 -0500
X-MC-Unique: xFj3HWHUO3Cf5NTGsSHAoA-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3b833b545f7so5130181b6e.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 14:57:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701125875; x=1701730675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4OLI+Pgg2mT/MxHuN4CHsnhmzDrDJCO/gEFpWoR3qzI=;
 b=JtLdu3jKXn3HzCYzvkW8IL0fxtOjAi7FR+IgPeMtLaU2n9luU18kkGVw+dc0HxacS9
 S1vG+I/hKIuRiApVs9dUreQulC0xajniv/aWVZ+jjSwMH7wWsV0ZfAlLzEUDfAdH15wC
 zlqpY7NirsXA+GgSDgxEhxaw2t0PcxDLaKteWLRXuecb4aD70XF322pPfHenXm4RJ3Ni
 IGGGrjbKOh2dikab7i2sRkye+Ju38q/DklwWGahARb6dwtCVmU/kll74piHOX1xUwGmW
 2zvSQVXSGoqW0Jkyx383qjFG4GTel5I0pZt/qkgfIovDOeU2jrWfdMEK/j1LoQyX2/dG
 swXA==
X-Gm-Message-State: AOJu0YxCGrUqh6hoIUb3hAoLyVKJePEF+PcD8nZXcHHp/8+uKqs2TBQF
 z7bAFZLkY4K8KlKuh8+aTR0MJ+Ys0olGhXFWZlA7U9HWrO9Z+Qi4UOtTh9pwqTUq1dvz+Wlp/WZ
 +ZXkXWyykbPm6gUU=
X-Received: by 2002:a05:6808:19a2:b0:3a8:f3e7:d67d with SMTP id
 bj34-20020a05680819a200b003a8f3e7d67dmr4009500oib.1.1701125875661; 
 Mon, 27 Nov 2023 14:57:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGge4UKkIR1QO1+ll/bHijrwBxt3TqxbhPEdtjjr3W1r20RRSr5JNvdQc+cwZmipMR0GKcCcg==
X-Received: by 2002:a05:6808:19a2:b0:3a8:f3e7:d67d with SMTP id
 bj34-20020a05680819a200b003a8f3e7d67dmr4009474oib.1.1701125875371; 
 Mon, 27 Nov 2023 14:57:55 -0800 (PST)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 bl14-20020a056808308e00b003b83edb8a89sm1662498oib.2.2023.11.27.14.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 14:57:54 -0800 (PST)
Date: Mon, 27 Nov 2023 15:57:52 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: <ankita@nvidia.com>
Cc: <jgg@nvidia.com>, <clg@redhat.com>, <shannon.zhaosl@gmail.com>,
 <peter.maydell@linaro.org>, <ani@anisinha.ca>, <berrange@redhat.com>,
 <eduardo@habkost.net>, <imammedo@redhat.com>, <mst@redhat.com>,
 <eblake@redhat.com>, <armbru@redhat.com>, <david@redhat.com>,
 <gshan@redhat.com>, <Jonathan.Cameron@huawei.com>, <aniketa@nvidia.com>,
 <cjia@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <vsethi@nvidia.com>, <acurrid@nvidia.com>, <dnigam@nvidia.com>,
 <udhoke@nvidia.com>, <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 1/2] qom: new object to associate device to numa node
Message-ID: <20231127155752.5ddc2569.alex.williamson@redhat.com>
In-Reply-To: <20231119130111.761-2-ankita@nvidia.com>
References: <20231119130111.761-1-ankita@nvidia.com>
 <20231119130111.761-2-ankita@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, 19 Nov 2023 18:31:10 +0530
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
> use this object to build the requisite GI Affinity Structure.
> 
> An admin can provide the range of nodes through a uint16 array host-nodes
> and link it to a device by providing its id. Currently, only PCI device is
> supported and an error is returned for acpi device. The following sample
> creates 8 nodes and link them to the PCI device dev0:
> 
> -numa node,nodeid=2 \
> -numa node,nodeid=3 \
> -numa node,nodeid=4 \
> -numa node,nodeid=5 \
> -numa node,nodeid=6 \
> -numa node,nodeid=7 \
> -numa node,nodeid=8 \
> -numa node,nodeid=9 \
> -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
> -object acpi-generic-initiator,id=gi0,pci-dev=dev0,host-nodes=2-9 \
> 
> [1] https://www.nvidia.com/en-in/technologies/multi-instance-gpu
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  hw/acpi/acpi-generic-initiator.c         | 84 ++++++++++++++++++++++++
>  hw/acpi/meson.build                      |  1 +
>  include/hw/acpi/acpi-generic-initiator.h | 30 +++++++++
>  qapi/qom.json                            | 18 +++++
>  4 files changed, 133 insertions(+)
>  create mode 100644 hw/acpi/acpi-generic-initiator.c
>  create mode 100644 include/hw/acpi/acpi-generic-initiator.h
> 
> diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initiator.c
> new file mode 100644
> index 0000000000..5ea51cb81e
> --- /dev/null
> +++ b/hw/acpi/acpi-generic-initiator.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-builtin-visit.h"
> +#include "qapi/visitor.h"
> +#include "qom/object_interfaces.h"
> +#include "qom/object.h"
> +#include "hw/qdev-core.h"
> +#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/pci.h"

There's nothing related to vfio here except for the example use case,
surely you don't need the above two headers.

> +#include "hw/pci/pci_device.h"
> +#include "sysemu/numa.h"
> +#include "hw/acpi/acpi-generic-initiator.h"
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
> +    gi->device = NULL;
> +    gi->nodelist = NULL;
> +}
> +
> +static void acpi_generic_initiator_finalize(Object *obj)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +
> +    g_free(gi->device);
> +    qapi_free_uint16List(gi->nodelist);
> +}
> +
> +static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
> +                                                  Error **errp)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +
> +    gi->device = g_strdup(val);
> +}
> +
> +static void acpi_generic_initiator_set_acpi_device(Object *obj, const char *val,
> +                                                   Error **errp)
> +{
> +    error_setg(errp, "Generic Initiator ACPI device not supported");
> +}
> +
> +static void
> +acpi_generic_initiator_set_host_nodes(Object *obj, Visitor *v, const char *name,
> +                                      void *opaque, Error **errp)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +    uint16List *l;
> +
> +    visit_type_uint16List(v, name, &(gi->nodelist), errp);
> +
> +    for (l = gi->nodelist; l; l = l->next) {
> +        if (l->value >= MAX_NODES) {
> +            error_setg(errp, "Invalid host-nodes value: %d", l->value);
> +            qapi_free_uint16List(gi->nodelist);
> +            return;
> +        }
> +    }
> +}
> +
> +static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
> +{
> +    object_class_property_add_str(oc, ACPI_GENERIC_INITIATOR_PCI_DEVICE_PROP,
> +                                  NULL, acpi_generic_initiator_set_pci_device);
> +    object_class_property_add_str(oc, ACPI_GENERIC_INITIATOR_ACPI_DEVICE_PROP,
> +                                  NULL, acpi_generic_initiator_set_acpi_device);

This doesn't allow introspection of acpi-dev support, the property
shouldn't be added until the support is available.  At least we've
thought about it now and we might use a comment to describe the
intention that ACPI devices could be supported by this option in the
future.

> +    object_class_property_add(oc, ACPI_GENERIC_INITIATOR_HOSTNODE_PROP, "int",
> +        NULL,
> +        acpi_generic_initiator_set_host_nodes,
> +        NULL, NULL);
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
> index 0000000000..db3ed02c80
> --- /dev/null
> +++ b/include/hw/acpi/acpi-generic-initiator.h
> @@ -0,0 +1,30 @@
> +#ifndef ACPI_GENERIC_INITIATOR_H
> +#define ACPI_GENERIC_INITIATOR_H
> +
> +#include "hw/mem/pc-dimm.h"
> +#include "hw/acpi/bios-linker-loader.h"
> +#include "qemu/uuid.h"
> +#include "hw/acpi/aml-build.h"
> +#include "qom/object.h"
> +#include "qom/object_interfaces.h"
> +
> +#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
> +
> +#define ACPI_GENERIC_INITIATOR_PCI_DEVICE_PROP "pci-dev"
> +#define ACPI_GENERIC_INITIATOR_ACPI_DEVICE_PROP "acpi-dev"
> +#define ACPI_GENERIC_INITIATOR_HOSTNODE_PROP "host-nodes"
> +
> +typedef struct AcpiGenericInitiator {
> +    /* private */
> +    Object parent;
> +
> +    /* public */
> +    char *device;
> +    uint16List *nodelist;
> +} AcpiGenericInitiator;
> +
> +typedef struct AcpiGenericInitiatorClass {
> +        ObjectClass parent_class;
> +} AcpiGenericInitiatorClass;
> +
> +#endif
> diff --git a/qapi/qom.json b/qapi/qom.json
> index c53ef978ff..f726f5ea41 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -794,6 +794,22 @@
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
> +# @acpi-dev: ACPI device ID to be associated with the node
> +#
> +# @host-nodes: numa node list
> +#
> +# Since: 8.2

8.2 is in freeze, this is 9.0 material.  Thanks,

Alex

> +##
> +{ 'struct': 'AcpiGenericInitiatorProperties',
> +  'data': { '*pci-dev': 'str', '*acpi-dev': 'str', 'host-nodes': ['uint16'] } }
> +
>  ##
>  # @RngProperties:
>  #
> @@ -911,6 +927,7 @@
>  ##
>  { 'enum': 'ObjectType',
>    'data': [
> +    'acpi-generic-initiator',
>      'authz-list',
>      'authz-listfile',
>      'authz-pam',
> @@ -981,6 +998,7 @@
>              'id': 'str' },
>    'discriminator': 'qom-type',
>    'data': {
> +      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
>        'authz-list':                 'AuthZListProperties',
>        'authz-listfile':             'AuthZListFileProperties',
>        'authz-pam':                  'AuthZPAMProperties',


