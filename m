Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD1E821BAB
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 13:32:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKdwY-0003Jx-Ca; Tue, 02 Jan 2024 07:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rKdwU-0003JF-EA; Tue, 02 Jan 2024 07:32:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rKdwR-0006Oc-Q1; Tue, 02 Jan 2024 07:32:22 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T4Bxj4gbpz6K7JW;
 Tue,  2 Jan 2024 20:29:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id B7DFA140DDB;
 Tue,  2 Jan 2024 20:31:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Jan
 2024 12:31:45 +0000
Date: Tue, 2 Jan 2024 12:31:43 +0000
To: <ankita@nvidia.com>
CC: <jgg@nvidia.com>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>, <ani@anisinha.ca>,
 <berrange@redhat.com>, <eduardo@habkost.net>, <imammedo@redhat.com>,
 <mst@redhat.com>, <eblake@redhat.com>, <armbru@redhat.com>,
 <david@redhat.com>, <gshan@redhat.com>, <aniketa@nvidia.com>,
 <cjia@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <vsethi@nvidia.com>, <acurrid@nvidia.com>, <dnigam@nvidia.com>,
 <udhoke@nvidia.com>, <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 0/2] acpi: report numa nodes for device memory using GI
Message-ID: <20240102123143.00006486@Huawei.com>
In-Reply-To: <20231225045603.7654-1-ankita@nvidia.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Mon, 25 Dec 2023 10:26:01 +0530
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> There are upcoming devices which allow CPU to cache coherently access
> their memory. It is sensible to expose such memory as NUMA nodes separate
> from the sysmem node to the OS. The ACPI spec provides a scheme in SRAT
> called Generic Initiator Affinity Structure [1] to allow an association
> between a Proximity Domain (PXM) and a Generic Initiator (GI) (e.g.
> heterogeneous processors and accelerators, GPUs, and I/O devices with
> integrated compute or DMA engines).
> 
> While a single node per device may cover several use cases, it is however
> insufficient for a full utilization of the NVIDIA GPUs MIG
> (Mult-Instance GPUs) [2] feature. The feature allows partitioning of the
> GPU device resources (including device memory) into several (upto 8)
> isolated instances. Each of the partitioned memory requires a dedicated NUMA
> node to operate. The partitions are not fixed and they can be created/deleted
> at runtime.
> 
> Linux OS does not provide a means to dynamically create/destroy NUMA nodes
> and such feature implementation is expected to be non-trivial. The nodes
> that OS discovers at the boot time while parsing SRAT remains fixed. So we
> utilize the GI Affinity structures that allows association between nodes
> and devices. Multiple GI structures per device/BDF is possible, allowing
> creation of multiple nodes in the VM by exposing unique PXM in each of these
> structures.
> 
> Implement the mechanism to build the GI affinity structures as Qemu currently
> does not. Introduce a new acpi-generic-initiator object that allows an
> association of a set of nodes with a device. During SRAT creation, all such
> objected are identified and used to add the GI Affinity Structures. Currently,
> only PCI device is supported. On a multi device system, each device supporting
> the features needs a unique acpi-generic-initiator object with its own set of
> NUMA nodes associated to it.
> 
> The admin will create a range of 8 nodes and associate that with the device
> using the acpi-generic-initiator object. While a configuration of less than
> 8 nodes per device is allowed, such configuration will prevent utilization of
> the feature to the fullest. This setting is applicable to all the Grace+Hopper
> systems. The following is an example of the Qemu command line arguments to
> create 8 nodes and link them to the device 'dev0':
> 
> -numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 \
> -numa node,nodeid=5 -numa node,nodeid=6 -numa node,nodeid=7 \
> -numa node,nodeid=8 -numa node,nodeid=9 \
> -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
> -object acpi-generic-initiator,id=gi0,pci-dev=dev0,host-nodes=2-9 \
> 

I'd find it helpful to see the resulting chunk of SRAT for these examples
(disassembled) in this cover letter and the patches (where there are more examples).


