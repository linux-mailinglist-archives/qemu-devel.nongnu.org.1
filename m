Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DABC17A2185
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:51:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA79-00081s-1z; Fri, 15 Sep 2023 10:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qhA70-0007jc-Qv
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qhA6y-0005pQ-RQ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDZd0j05ISiiASU+Undv8ratNzoMS8WQhDvNfKUB/cQ=;
 b=T7UUZ2Vl4aKRY1Di6O+uq7xIe7uwSOcBpffWQ6FHC+9qmoEewM/ou4u0BDj25BlIkYS5Y1
 eWz1uNKdWRKwTHlLGI4gYRSD/Kr34rfaaArrA2v184No2WEELj1RFaTJSxWEDMkDT64E1p
 7u5zesqHgKmMOzqbXz6oZU0F2b31S3s=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-zPk6BeyzNourZs-WjyNC0g-1; Fri, 15 Sep 2023 10:47:58 -0400
X-MC-Unique: zPk6BeyzNourZs-WjyNC0g-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-34fc965c70bso5324755ab.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 07:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694789277; x=1695394077;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DDZd0j05ISiiASU+Undv8ratNzoMS8WQhDvNfKUB/cQ=;
 b=aURm9DHZkWr7AgBPN/qPD0JKyzdKtY58OOPz7bKZsDb13z/fiTRW9u2PGUOz71SofX
 /tZwDfTri8V3kahjRnvW9oPzrw1/Z0+S1jcq+vuWjFAsN+TdlES8Dl/by9/mkoMh5dZF
 ujFFR9DwhEjVQL+W8g1zXDcyxkWsj2YWyg3OfCFabYapzXzJfnkOl5tccgHzAUibQ4CF
 RwYOHxeL45z/nYvA+6S1Mzqb/Ce3TUDdcsfyqdgORVhSUR/QeNYFrXYQY10GIv8e9Raq
 qkdXreEOP3DB6P4BjUkVT2g+v1rdOX46dIYN+hvZhJxIjeuR5bfYIPk3uyIzYfLnvE26
 ILpw==
X-Gm-Message-State: AOJu0YzUzRHjQ+aFOEO/KG8kmetb67YPZT6RHR9VPMFXKaibWyCyj6S7
 NJm58Q8E/W71gN8eCUt2UwZA3EHkUMa9P92b6kuGmrX8a2+HWoPABHCb3oQB+mcALgAiyiI0cAB
 KoJM8exUavfhTGxc=
X-Received: by 2002:a05:6e02:152:b0:349:3020:d103 with SMTP id
 j18-20020a056e02015200b003493020d103mr2261475ilr.25.1694789277387; 
 Fri, 15 Sep 2023 07:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYFh7dOoql31zCBrMZRAc1j1yiGoTS+TocXy1TXtr0DOsdvipZYMRqtaoX2EJ1ECww3PnOHg==
X-Received: by 2002:a05:6e02:152:b0:349:3020:d103 with SMTP id
 j18-20020a056e02015200b003493020d103mr2261447ilr.25.1694789277125; 
 Fri, 15 Sep 2023 07:47:57 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 g26-20020a02b71a000000b00433dd6c78b0sm1067707jam.97.2023.09.15.07.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 07:47:56 -0700 (PDT)
Date: Fri, 15 Sep 2023 08:47:54 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: ankita@nvidia.com, jgg@nvidia.com, shannon.zhaosl@gmail.com,
 peter.maydell@linaro.org, ani@anisinha.ca, aniketa@nvidia.com,
 cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 vsethi@nvidia.com, acurrid@nvidia.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Message-ID: <20230915084754.4b49d5c0.alex.williamson@redhat.com>
In-Reply-To: <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 15 Sep 2023 16:19:29 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> Hello Ankit,
>=20
> On 9/15/23 04:45, ankita@nvidia.com wrote:
> > From: Ankit Agrawal <ankita@nvidia.com>
> >=20
> > For devices which allow CPU to cache coherently access their memory,
> > it is sensible to expose such memory as NUMA nodes separate from
> > the sysmem node. Qemu currently do not provide a mechanism for creation
> > of NUMA nodes associated with a vfio-pci device.
> >=20
> > Implement a mechanism to create and associate a set of unique NUMA nodes
> > with a vfio-pci device.>
> > NUMA node is created by inserting a series of the unique proximity
> > domains (PXM) in the VM SRAT ACPI table. The ACPI tables are read once
> > at the time of bootup by the kernel to determine the NUMA configuration
> > and is inflexible post that. Hence this feature is incompatible with
> > device hotplug. The added node range associated with the device is
> > communicated through ACPI DSD and can be fetched by the VM kernel or
> > kernel modules. QEMU's VM SRAT and DSD builder code is modified
> > accordingly.
> >=20
> > New command line params are introduced for admin to have a control on
> > the NUMA node assignment. =20
>=20
> This approach seems to bypass the NUMA framework in place in QEMU and
> will be a challenge for the upper layers. QEMU is generally used from
> libvirt when dealing with KVM guests.
>=20
> Typically, a command line for a virt machine with NUMA nodes would look
> like :
>=20
>    -object memory-backend-ram,id=3Dram-node0,size=3D1G \
>    -numa node,nodeid=3D0,memdev=3Dram-node0 \
>    -object memory-backend-ram,id=3Dram-node1,size=3D1G \
>    -numa node,nodeid=3D1,cpus=3D0-3,memdev=3Dram-node1
>=20
> which defines 2 nodes, one with memory and all CPUs and a second with
> only memory.
>=20
>    # numactl -H
>    available: 2 nodes (0-1)
>    node 0 cpus: 0 1 2 3
>    node 0 size: 1003 MB
>    node 0 free: 734 MB
>    node 1 cpus:
>    node 1 size: 975 MB
>    node 1 free: 968 MB
>    node distances:
>    node   0   1
>      0:  10  20
>      1:  20  10
>=20
>   =20
> Could it be a new type of host memory backend ?  Have you considered
> this approach ?

Good idea.  Fundamentally the device should not be creating NUMA nodes,
the VM should be configured with NUMA nodes and the device memory
associated with those nodes.

I think we're also dealing with a lot of very, very device specific
behavior, so I question whether we shouldn't create a separate device
for this beyond vifo-pci or vfio-pci-nohotplug.

In particular, a PCI device typically only has association to a single
proximity domain, so what sense does it make to describe the coherent
memory as a PCI BAR to only then create a confusing mapping where the
device has a proximity domain separate from a resources associated with
the device?

It's seeming like this device should create memory objects that can be
associated as memory backing for command line specified NUMA nodes.
Thanks,

Alex


