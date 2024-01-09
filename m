Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2D9828A7B
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 17:52:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNFL9-0005qt-TP; Tue, 09 Jan 2024 11:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rNFL3-0005qE-PS; Tue, 09 Jan 2024 11:52:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rNFL0-0001pd-1V; Tue, 09 Jan 2024 11:52:28 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8cPR6SfYz6K5xJ;
 Wed, 10 Jan 2024 00:50:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id B50D3140736;
 Wed, 10 Jan 2024 00:52:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 16:52:22 +0000
Date: Tue, 9 Jan 2024 16:52:21 +0000
To: Alex Williamson <alex.williamson@redhat.com>
CC: Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "clg@redhat.com" <clg@redhat.com>, "shannon.zhaosl@gmail.com"
 <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ani@anisinha.ca" <ani@anisinha.ca>,
 "berrange@redhat.com" <berrange@redhat.com>, "eduardo@habkost.net"
 <eduardo@habkost.net>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "david@redhat.com"
 <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, "Dheeraj Nigam"
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 1/2] qom: new object to associate device to numa node
Message-ID: <20240109165221.00003b8b@Huawei.com>
In-Reply-To: <20240104103941.019f9b54.alex.williamson@redhat.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
 <20240102125821.00001aa0@Huawei.com>
 <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <SA1PR12MB719917E2C9D98C04AE9058C4B0672@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240104103941.019f9b54.alex.williamson@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Thu, 4 Jan 2024 10:39:41 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 4 Jan 2024 16:40:39 +0000
> Ankit Agrawal <ankita@nvidia.com> wrote:
> 
> > Had a discussion with RH folks, summary follows:
> > 
> > 1. To align with the current spec description pointed by Jonathan, we first do
> >      a separate object instance per GI node as suggested by Jonathan. i.e.
> >      a acpi-generic-initiator would only link one node to the device. To 
> >      associate a set of nodes, those number of object instances should be
> >      created.
> > 2. In parallel, we work to get the spec updated. After the update, we switch
> >     to the current implementation to link a PCI device with a set of NUMA
> >     nodes.
> > 
> > Alex/Jonathan, does this sound fine?
> >   
> 
> Yes, as I understand Jonathan's comments, the acpi-generic-initiator
> object should currently define a single device:node relationship to
> match the ACPI definition.

Doesn't matter for this, but it's a many_device:single_node
relationship as currently defined. We should be able to support that
in any new interfaces for QEMU.

>  Separately a clarification of the spec
> could be pursued that could allow us to reinstate a node list option
> for the acpi-generic-initiator object.  In the interim, a user can
> define multiple 1:1 objects to create the 1:N relationship that's
> ultimately required here.  Thanks,

Yes, a spec clarification would work, probably needs some text
to say a GI might not be an initiator as well - my worry is
theoretical backwards compatibility with a (probably
nonexistent) OS that assumes the N:1 mapping. So you may be in 
new SRAT entry territory.

Given that, an alternative proposal that I think would work
for you would be to add a 'placeholder' memory node definition
in SRAT (so allow 0 size explicitly - might need a new SRAT
entry to avoid backwards compat issues). Then put the GPU
initiator part in a GI node and use the HMAT Memory Proximity
Domain Attributes magic linkage entry "Proximity Domain for
the Attached Initiator" to associate the placeholder memory
nodes with the GI / GPU.

I'd go to ASWG with a big diagram and ask 'how do I do this!'

If you do it code first I'm happy to help out with refining
the proposal. I just don't like the time of ASWG calls so tend
to not make them in person.

Or just emulate UEFI's CDAT (from CXL, but not CXL specific)
from your GPU and make it a driver problem ;)

Jonathan


> 
> Alex
> 


