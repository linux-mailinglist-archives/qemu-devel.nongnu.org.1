Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FA17C5A23
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 19:18:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqcpX-0001Xv-Lf; Wed, 11 Oct 2023 13:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qqcpU-0001XD-B2
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 13:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qqcpR-0006MJ-5m
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 13:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697044618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRcxOtc4ATLmd4zwFWAqTF/MYKU/85zd0BktQB6a4WU=;
 b=NM7Yvy4fJg6U9mGHxY25SwYtedDKuGrbAWQCBTYbZnjC3xpzc9yj1T7Zogf62IS9vY7YX7
 zIeLidoaeCk3XDzs98SIOYzAq0Tkz88CCr0s6gSYyhHLG2Te4dHJa1sWOp0deLfSMuy1K2
 QuMseFvn8P75vGv7jLSIytN+D88GygI=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-tvg8U9Z0M_you_WpRMMmDg-1; Wed, 11 Oct 2023 13:16:57 -0400
X-MC-Unique: tvg8U9Z0M_you_WpRMMmDg-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3510e81c6a5so11225ab.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 10:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697044616; x=1697649416;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aRcxOtc4ATLmd4zwFWAqTF/MYKU/85zd0BktQB6a4WU=;
 b=k6XTfD2FkbcnlbjlCsElqXevMNUsJkaEEsD6Yw2RpgZeiO8eRkMRVSWZbfRZ2fHSmT
 N1U9n53xfV3yw13zpt95kP8t9OCsZjnQqUTGMzFpJQAElwkPN5kfXhv4pwHdf2yLebPj
 UaKAK7dl3L3o8vdkF7tktC+Kqy1kOly7OXHVKAzh8LFTS2+nRHatLZZ32LMcCIaIZsXH
 sIGWAX9TrwuoSagvhR2qsCGetxGxIyUKEjGzFFzsblKdj92PRmf4SPGbrjjyJwlN+EAL
 qiMqHBHOWRUmmZgPHlGbxznWcbZ4HXKwVEzuwYYWQry4/6SmReCQcay3DXiVxAKkM5sf
 xOPw==
X-Gm-Message-State: AOJu0YwiL+ZsKK93ka/DYdKCoRHqeeKB92q4Wl6h6TUZjmlngLLbMmcg
 TIOEHl2JdRJsre6m5Odd2PYEP0uaVUy16LgMjeBRBzTpX2Cl24icZlNTrlesBZl/46UVv2pUpyc
 nNcayY9Qw5RG3RMA=
X-Received: by 2002:a05:6e02:218f:b0:350:efe8:b53f with SMTP id
 j15-20020a056e02218f00b00350efe8b53fmr28831513ila.7.1697044616314; 
 Wed, 11 Oct 2023 10:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgDUkO3n/Juqg/z+7G2SBicN485pVAQXa4o88q9WzYfl/19EHoB3QnvCQyBvR4xaw6MRagMw==
X-Received: by 2002:a05:6e02:218f:b0:350:efe8:b53f with SMTP id
 j15-20020a056e02218f00b00350efe8b53fmr28831473ila.7.1697044615950; 
 Wed, 11 Oct 2023 10:16:55 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 a10-20020a92d58a000000b00351076c43e3sm78592iln.4.2023.10.11.10.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 10:16:55 -0700 (PDT)
Date: Mon, 9 Oct 2023 15:16:11 -0600
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
Subject: Re: [PATCH v2 3/3] qom: Link multiple numa nodes to device using a
 new object
Message-ID: <20231009151611.02175567.alex.williamson@redhat.com>
In-Reply-To: <20231007201740.30335-4-ankita@nvidia.com>
References: <20231007201740.30335-1-ankita@nvidia.com>
 <20231007201740.30335-4-ankita@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, 8 Oct 2023 01:47:40 +0530
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
> we utilize the GI Affinity structures that allows association between nodes
> and devices. Multiple GI structures per BDF is possible, allowing creation of
> multiple nodes by exposing unique PXM in each of these structures.
> 
> Introducing a new nvidia-acpi-generic-initiator object, which inherits from
> the generic acpi-generic-initiator object to allow a BDF to be associated with
> more than 1 nodes.
> 
> An admin can provide the range of nodes using numa-node-start and
> numa-node-count and link it to a device by providing its id. The following
> sample creates 8 nodes and link them to the device dev0:
> 
>         -numa node,nodeid=2 \
>         -numa node,nodeid=3 \
>         -numa node,nodeid=4 \
>         -numa node,nodeid=5 \
>         -numa node,nodeid=6 \
>         -numa node,nodeid=7 \
>         -numa node,nodeid=8 \
>         -numa node,nodeid=9 \
>         -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
>         -object nvidia-acpi-generic-initiator,id=gi0,device=dev0,numa-node-start=2,numa-node-count=8 \

Why didn't we just implement start and count in the base object (or a
list)? It seems like this gives the nvidia-acpi-generic-initiator two
different ways to set gi->node, either node= of the parent or
numa-node-start= here.  Once we expose the implicit node count in the
base object, I'm not sure the purpose of this object.  I would have
thought it for keying the build of the NVIDIA specific _DSD, but that's
not implemented in this version.

I also don't see any programatic means for management tools to know how
many nodes to create.  For example what happens if there's a MIGv2 that
supports 16 partitions by default and makes use of the same vfio-pci
variant driver?  Thanks,

Alex

> 
> [1] https://www.nvidia.com/en-in/technologies/multi-instance-gpu
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  hw/acpi/acpi-generic-initiator.c         | 61 ++++++++++++++++++++++++
>  include/hw/acpi/acpi-generic-initiator.h | 12 +++++
>  qapi/qom.json                            | 24 +++++++++-
>  3 files changed, 95 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initiator.c
> index 1ae79639be..8ef887c3a4 100644
> --- a/hw/acpi/acpi-generic-initiator.c
> +++ b/hw/acpi/acpi-generic-initiator.c
> @@ -150,3 +150,64 @@ void build_srat_generic_initiator(GArray *table_data)
>      }
>      g_slist_free(list);
>  }
> +
> +static void
> +nvidia_acpi_generic_initiator_set_node_start(Object *obj, Visitor *v,
> +                                             const char *name, void *opaque,
> +                                             Error **errp)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +    uint32_t value;
> +
> +    if (!visit_type_uint32(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (value >= MAX_NODES) {
> +        return;
> +    }
> +
> +    gi->node = value;
> +}
> +
> +static void
> +nvidia_acpi_generic_initiator_set_node_count(Object *obj, Visitor *v,
> +                                             const char *name, void *opaque,
> +                                             Error **errp)
> +{
> +    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> +    uint32_t value;
> +
> +    if (!visit_type_uint32(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    gi->node_count = value;
> +}
> +
> +static void nvidia_acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
> +{
> +    object_class_property_add(oc, NVIDIA_ACPI_GENERIC_INITIATOR_NODE_START_PROP,
> +                              "uint32", NULL,
> +                              nvidia_acpi_generic_initiator_set_node_start,
> +                              NULL, NULL);
> +    object_class_property_add(oc, NVIDIA_ACPI_GENERIC_INITIATOR_NODE_COUNT_PROP,
> +                              "uint32", NULL,
> +                              nvidia_acpi_generic_initiator_set_node_count,
> +                              NULL, NULL);
> +}
> +
> +static const TypeInfo nvidia_acpi_generic_initiator_info = {
> +    .parent = TYPE_ACPI_GENERIC_INITIATOR,
> +    .name = TYPE_NVIDIA_ACPI_GENERIC_INITIATOR,
> +    .instance_size = sizeof(NvidiaAcpiGenericInitiator),
> +    .class_size = sizeof(NvidiaAcpiGenericInitiatorClass),
> +    .class_init = nvidia_acpi_generic_initiator_class_init,
> +};
> +
> +static void
> +nvidia_acpi_generic_initiator_register_types(void)
> +{
> +    type_register_static(&nvidia_acpi_generic_initiator_info);
> +}
> +type_init(nvidia_acpi_generic_initiator_register_types);
> diff --git a/include/hw/acpi/acpi-generic-initiator.h b/include/hw/acpi/acpi-generic-initiator.h
> index e8e2670309..3e4cf42064 100644
> --- a/include/hw/acpi/acpi-generic-initiator.h
> +++ b/include/hw/acpi/acpi-generic-initiator.h
> @@ -9,10 +9,14 @@
>  #include "qom/object_interfaces.h"
>  
>  #define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
> +#define TYPE_NVIDIA_ACPI_GENERIC_INITIATOR "nvidia-acpi-generic-initiator"
>  
>  #define ACPI_GENERIC_INITIATOR_DEVICE_PROP "device"
>  #define ACPI_GENERIC_INITIATOR_NODE_PROP "node"
>  
> +#define NVIDIA_ACPI_GENERIC_INITIATOR_NODE_START_PROP "numa-node-start"
> +#define NVIDIA_ACPI_GENERIC_INITIATOR_NODE_COUNT_PROP "numa-node-count"
> +
>  typedef struct AcpiGenericInitiator {
>      /* private */
>      Object parent;
> @@ -47,6 +51,14 @@ typedef struct PCIDeviceHandle {
>      uint64_t res1;
>  } PCIDeviceHandle;
>  
> +typedef struct NvidiaAcpiGenericInitiator {
> +    AcpiGenericInitiator parent;
> +} NvidiaAcpiGenericInitiator;
> +
> +typedef struct NvidiaAcpiGenericInitiatorClass {
> +        AcpiGenericInitiatorClass parent_class;
> +} NvidiaAcpiGenericInitiatorClass;
> +
>  void build_srat_generic_initiator(GArray *table_data);
>  
>  #endif
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 86c87a161c..c29ad1388d 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -793,6 +793,24 @@
>  { 'struct': 'AcpiGenericInitiatorProperties',
>    'data': { 'device': 'str', 'node': 'uint32' } }
>  
> +##
> +# @NvidiaAcpiGenericInitiatorProperties:
> +#
> +# Properties for nvidia-acpi-generic-initiator objects.
> +#
> +# @device: the ID of the device to be associated with the nodes
> +#
> +# @numa-node-start: the ID of the numa node
> +#
> +# @numa-node-count: count of the numa nodes assocuated with the device
> +#
> +# Since: 8.0
> +##
> +{ 'struct': 'NvidiaAcpiGenericInitiatorProperties',
> +  'data': { 'device': 'str',
> +            'numa-node-start': 'uint32',
> +            'numa-node-count': 'uint32' } }
> +
>  ##
>  # @RngProperties:
>  #
> @@ -962,7 +980,8 @@
>      'tls-cipher-suites',
>      { 'name': 'x-remote-object', 'features': [ 'unstable' ] },
>      { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] },
> -    'acpi-generic-initiator'
> +    'acpi-generic-initiator',
> +    'nvidia-acpi-generic-initiator'
>    ] }
>  
>  ##
> @@ -1030,7 +1049,8 @@
>        'tls-cipher-suites':          'TlsCredsProperties',
>        'x-remote-object':            'RemoteObjectProperties',
>        'x-vfio-user-server':         'VfioUserServerProperties',
> -      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties'
> +      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
> +      'nvidia-acpi-generic-initiator':     'NvidiaAcpiGenericInitiatorProperties'
>    } }
>  
>  ##


