Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EE17B0A7F
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 18:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlXXo-00035R-4p; Wed, 27 Sep 2023 12:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qlXXl-00034g-LT
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 12:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qlXXk-00080d-32
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 12:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695832662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGptkUYk2a0bcIuEp74s3b+JxLgf/suxM2uG6ghEpjA=;
 b=VXKdhwE76kJ9uQLEzVYD+wbHwPJ2ZP/zX2R84LnUPzuVrVEmEZmwi/prBzAWvNbSMF4LGE
 wh/mMomiyYKJ1g/hlKfNy+vWvdsrl/7+L3049AiTOskY+fP2vi12j9MTTizxuxi245mAuN
 TqiOEqaFS9MKQWIhMJWQxZ9NiOGDHd8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-c7mDxypYN1uMcGAM1uIHYg-1; Wed, 27 Sep 2023 12:37:40 -0400
X-MC-Unique: c7mDxypYN1uMcGAM1uIHYg-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-35165f3f809so9531015ab.3
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 09:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695832660; x=1696437460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGptkUYk2a0bcIuEp74s3b+JxLgf/suxM2uG6ghEpjA=;
 b=JyrvVrG8vvd8O8Oxd9vXUkEL3aKi0CQBHmYIK6YsroywInCihftxb7gNyapZDEXG5n
 buvHOeOUeBzoZYlGN06ZgDpMirZxBTl/T8xbqKGDLivVz3T9qSOA68GnYRR8JFJmDsNM
 RAjHPLnUs/M2SyJP58k8jv5OrhDOcbeBMAydPndLJP08Ho4HVUcGNL7hkHlPberQGy3K
 /LfBc6ynXeEvG2n8tpEkljxzhH7EeFmXhI42Wv7ts37Xl10Z0M/qkXJvcrhVQfx4q7O9
 CMIEh0OqHw/o3UEBjN2kopi3G46EIaPgQjVcP5Q1WhyYO9bsu4fTZ4RekhabkUjBoswu
 iF1Q==
X-Gm-Message-State: AOJu0YxaY+RZSoXKj/MnKvA0pV1gLVOSeKJEctDRJgeRctPf6LhHNXup
 ag4QS7GuBBw0hMhTPm6qOF4ROEvk52dvmx+V1W5afJVVTy0KQGIvLBYzJWoKTJhc5glUnsvQa67
 OK7fKZqUIbxhiQYY=
X-Received: by 2002:a05:6e02:1c2d:b0:34f:6742:1394 with SMTP id
 m13-20020a056e021c2d00b0034f67421394mr3199653ilh.1.1695832659862; 
 Wed, 27 Sep 2023 09:37:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKXktYumW9gQrLYug5Ih8jic5KbGRP4jKME7/hwnO7xftAv6BZUuUKReyAfokghFxwUi0SVQ==
X-Received: by 2002:a05:6e02:1c2d:b0:34f:6742:1394 with SMTP id
 m13-20020a056e021c2d00b0034f67421394mr3199633ilh.1.1695832659548; 
 Wed, 27 Sep 2023 09:37:39 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 b22-20020a02a596000000b0043a11ec651asm3985948jam.169.2023.09.27.09.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 09:37:38 -0700 (PDT)
Date: Wed, 27 Sep 2023 10:37:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Vikram Sethi <vsethi@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Ankit Agrawal <ankita@nvidia.com>, David
 Hildenbrand <david@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Andy Currid <ACurrid@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Gavin Shan <gshan@redhat.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>, "navneet.singh@intel.com"
 <navneet.singh@intel.com>
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Message-ID: <20230927103737.35068bae.alex.williamson@redhat.com>
In-Reply-To: <BYAPR12MB33369DCC79212D6040F00560BDC2A@BYAPR12MB3336.namprd12.prod.outlook.com>
References: <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
 <20230915084754.4b49d5c0.alex.williamson@redhat.com>
 <f129b30b-bd0c-4e30-6be9-384b2b79a26b@redhat.com>
 <BY5PR12MB3763FA9922B9059DC14CA80DB0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <b67c18d1-a648-81bc-1144-33fb839f2aa3@redhat.com>
 <BY5PR12MB37636F9E84CF92020769D859B0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <769b577a-65b0-dbfe-3e99-db57cea08529@redhat.com>
 <20230926131427.1e441670.alex.williamson@redhat.com>
 <BY5PR12MB37630E29E6E83BCD63FB3F2BB0C2A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20230927123318.00005aad@Huawei.com>
 <20230927135336.GA339126@nvidia.com>
 <20230927082434.3583361c.alex.williamson@redhat.com>
 <BYAPR12MB33369DCC79212D6040F00560BDC2A@BYAPR12MB3336.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 27 Sep 2023 15:03:09 +0000
Vikram Sethi <vsethi@nvidia.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Wednesday, September 27, 2023 9:25 AM
> > To: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Ankit Agrawal
> > <ankita@nvidia.com>; David Hildenbrand <david@redhat.com>; C=C3=A9dric =
Le
> > Goater <clg@redhat.com>; shannon.zhaosl@gmail.com;
> > peter.maydell@linaro.org; ani@anisinha.ca; Aniket Agashe
> > <aniketa@nvidia.com>; Neo Jia <cjia@nvidia.com>; Kirti Wankhede
> > <kwankhede@nvidia.com>; Tarun Gupta (SW-GPU) <targupta@nvidia.com>;
> > Vikram Sethi <vsethi@nvidia.com>; Andy Currid <ACurrid@nvidia.com>;
> > qemu-arm@nongnu.org; qemu-devel@nongnu.org; Gavin Shan
> > <gshan@redhat.com>; ira.weiny@intel.com; navneet.singh@intel.com
> > Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
> >=20
> >=20
> > On Wed, 27 Sep 2023 10:53:36 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >  =20
> > > On Wed, Sep 27, 2023 at 12:33:18PM +0100, Jonathan Cameron wrote:
> > > =20
> > > > CXL accelerators / GPUs etc are a different question but who has one
> > > > of those anyway? :) =20
> > >
> > > That's exactly what I mean when I say CXL will need it too. I keep
> > > describing this current Grace & Hopper as pre-CXL HW. You can easially
> > > imagine draping CXL around it. CXL doesn't solve the problem that
> > > motivates all this hackying - Linux can't dynamically create NUMA
> > > nodes. =20
> >=20
> > Why is that and why aren't we pushing towards a solution of removing th=
at
> > barrier so that we don't require the machine topology to be configured =
to
> > support this use case and guest OS limitations?  Thanks,
> > =20
>=20
> Even if Linux could create NUMA nodes dynamically for coherent CXL or CXL=
 type devices,=20
> there is additional information FW knows that the kernel doesn't. For exa=
mple,
> what the distance/latency between CPU and the device NUMA node is. While =
CXL devices
> present a CDAT table which gives latency type attributes within the devic=
e, there would still be some
> guesswork needed in the kernel as to what the end to end latency/distance=
 is.=20
> It's probably not the best outcome to just consider this generically far =
memory" because=20
> is it further than Intersocket memory access or not matters.=20
> Pre CXL devices such as for this patchset don't even have CDAT so the ker=
nel by itself has
> no idea if this latency/distance is less than or more than inter socket m=
emory access latency
> even.
> So specially for devices present at boot, FW knows this information and s=
hould provide it.=20
> Similarly, QEMU should pass along this information to VMs for the best ou=
tcomes. =20

Yeah, AFAICT we're not doing any of that in this series.  We're only
creating some number of nodes for the guest driver to make use of and
describing in the generated _DSD the set of nodes associated for use by
the device.  How many nodes are required, how the guest driver
partitions coherent memory among the nodes, and how the guest assigns a
distance to the nodes is unspecified.

A glance at the CDAT spec seems brilliant in this regard, is there such
a table for this device or could/should the vfio-pci variant driver
provide one?  I imagine this is how the VM admin or orchestration tool
would learn to configure nodes and the VMM would further virtualize
this table for the guest OS and drivers.  Thanks,

Alex


