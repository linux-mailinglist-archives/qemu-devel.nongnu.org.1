Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C065D7B06B5
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 16:26:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlVT2-00088D-DJ; Wed, 27 Sep 2023 10:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qlVT0-00087t-UO
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qlVSz-0004DG-1Z
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695824680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEV3RARKEJVMV8WdrWIeCRPMCdojUOSEeKIO0o8Dd3I=;
 b=G0Gyn+m5KMDfAlWreon+nZI+CMv6WFMT84k0Z/GYfCmjUL931xSjq7+7z6Pht0KGczDd2l
 LK/SzAmaSMkB6dvHuvuqkpxuCK5/cqG5cMdDyGZXjcGs2BsxfFO81212+yCDykZyc8/uJP
 QPsTPXAqTnmW/vh+NmWQ7p3iiwAkBlM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-Ynfbt4pUNdmSpHriKo5n7g-1; Wed, 27 Sep 2023 10:24:38 -0400
X-MC-Unique: Ynfbt4pUNdmSpHriKo5n7g-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-79fc1c4948aso1048789039f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 07:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695824677; x=1696429477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEV3RARKEJVMV8WdrWIeCRPMCdojUOSEeKIO0o8Dd3I=;
 b=tus8C2S2QUQhZdRLw5H2dQxjAXS1m8ZnPnNdkX/ofqoAmBOO4glbJiFV7Os/O1MgY7
 XejTdZJWo/SpFpmG7lUgEmRTdnGogme+yBIRoybDxAdbMu7P9v7v4QxsJjD88nLd/sdt
 /pJFJaKukiQsztlsONdlS5a7SYLr4ZPfOBCpUwzi2e76lTl5GjWOcMdgiHxvOienCXkw
 6lwyFizsm1NoTTx8oLUjKJpxFY7auW8hXOzLRmvGOXB6U7x22BzytQdHS3Wq3uu15eQp
 2O29nEwg0vXD+/ymMnZOGp2EerCeoGnzJURk5nEMNhVacjKPDxkiAvVDDuZ45OJDk75K
 ShnA==
X-Gm-Message-State: AOJu0YytE6x4884sh8jSV1f0dk1n0ebREni1kd2/G0x/Vm0/W0tJvYEC
 9jXaXLmsXUw2rj4C6A2OGvdfbP4eoDDT/52RfBhhpjYVgCFR3wmI9L9RdJ2sodtQWiVroqRCrhw
 MybPLQILN59fV7qk=
X-Received: by 2002:a6b:f314:0:b0:792:82f8:749d with SMTP id
 m20-20020a6bf314000000b0079282f8749dmr2247502ioh.10.1695824677780; 
 Wed, 27 Sep 2023 07:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPjml2R3LeRZFda66cH4jRvgS4N5EzIVgRSuWbXFegmD4L/NYWKsd6m6QllzHfZ/h+N7Bp4A==
X-Received: by 2002:a6b:f314:0:b0:792:82f8:749d with SMTP id
 m20-20020a6bf314000000b0079282f8749dmr2247482ioh.10.1695824677503; 
 Wed, 27 Sep 2023 07:24:37 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 n16-20020a056638121000b00439c46ad69esm3840840jas.115.2023.09.27.07.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 07:24:36 -0700 (PDT)
Date: Wed, 27 Sep 2023 08:24:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ankit Agrawal
 <ankita@nvidia.com>, David Hildenbrand <david@redhat.com>, =?UTF-8?B?Q8Op?=
 =?UTF-8?B?ZHJpYw==?= Le Goater <clg@redhat.com>, "shannon.zhaosl@gmail.com"
 <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ani@anisinha.ca" <ani@anisinha.ca>, Aniket
 Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Andy Currid <ACurrid@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Gavin Shan <gshan@redhat.com>,
 ira.weiny@intel.com, navneet.singh@intel.com
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Message-ID: <20230927082434.3583361c.alex.williamson@redhat.com>
In-Reply-To: <20230927135336.GA339126@nvidia.com>
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
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 27 Sep 2023 10:53:36 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Sep 27, 2023 at 12:33:18PM +0100, Jonathan Cameron wrote:
> 
> > CXL accelerators / GPUs etc are a different question but who has one
> > of those anyway? :)  
> 
> That's exactly what I mean when I say CXL will need it too. I keep
> describing this current Grace & Hopper as pre-CXL HW. You can easially
> imagine draping CXL around it. CXL doesn't solve the problem that
> motivates all this hackying - Linux can't dynamically create NUMA
> nodes.

Why is that and why aren't we pushing towards a solution of removing
that barrier so that we don't require the machine topology to be
configured to support this use case and guest OS limitations?  Thanks,

Alex


