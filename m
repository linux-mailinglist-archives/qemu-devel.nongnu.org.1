Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE8E82A7F5
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 08:02:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNp4M-00022r-1j; Thu, 11 Jan 2024 02:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rNp4K-00022O-9V
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:01:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rNp4H-0001c5-TP
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704956493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R9RxyL7BNCG6WzOUiQDBiDLY8C3CuDVjlJ93IG4mPvA=;
 b=LpCB4WXL3FK89EkEajn29shCKOzra3wKhtafpTI2lBweAQhnRMGvfdn9G0Tlg56Z1rBrYj
 XXMzhuRLNTjknuEo6TEk/uqvZBszdmxvDzNw0PhgBvOAdPWOnypA9wN8Er43J1veRxSDd8
 TIS4auw40+SZfagh92FPEos/kpoyabA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-C_kgjc8JPoC_jzg131RKpw-1; Thu, 11 Jan 2024 02:01:30 -0500
X-MC-Unique: C_kgjc8JPoC_jzg131RKpw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33693a2dae7so2838889f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 23:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704956489; x=1705561289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9RxyL7BNCG6WzOUiQDBiDLY8C3CuDVjlJ93IG4mPvA=;
 b=vWksYY1ysQM9dIJwteH3pTrZt4ASpCEiLzSXjZvWQnYYhXGS0daGyQEF2v2xjuZy5J
 ihXbcuwiVEw6LGCQh1XVB2IGTK7KGZQBc8QreA0oteMkM6ZUVxweFU14WymPuZ0EGiQv
 xZa3fpV/yrw+MZjfRtddFnu7lp2RyNNE/+Bv02ZwJw2/n97CrqtHyzbJCpBst4wFjHzF
 mvNsfK/qZvChngW0NmQV7/xySU71w/ZDtbgBpgVfHApetkveBSZqkZoSez51VPHMXBi6
 CB1ZVR4NVFWen6XHEkzfi/s8sug0VSYsrkpGzixk4g9qApYAAnNaQtCcGzK/01hSloLJ
 011A==
X-Gm-Message-State: AOJu0YxCPshoZdfOVMB4o3soGKEtPYru3UoqLc01yA/wWnnNK3k55Vky
 e8dIvCxgJyC+CNpgvLOJBvNr/wxOHMtcgQ8fGQ7Ohh2gpeeR9XTkpmqGYanHeLQoTeF8Ha4CD1j
 FiiDvGP78hwTRxZVepFvsfHQ=
X-Received: by 2002:adf:fe07:0:b0:336:c4c1:2d7c with SMTP id
 n7-20020adffe07000000b00336c4c12d7cmr329530wrr.41.1704956489306; 
 Wed, 10 Jan 2024 23:01:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuZrgPfx17VVbaxBOk5qN5QcvxKQ4VumazIx4JLYQflHIrUAEgsforHrETRsR3ZP9p9iq98g==
X-Received: by 2002:adf:fe07:0:b0:336:c4c1:2d7c with SMTP id
 n7-20020adffe07000000b00336c4c12d7cmr329499wrr.41.1704956488909; 
 Wed, 10 Jan 2024 23:01:28 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
 by smtp.gmail.com with ESMTPSA id
 m8-20020adfe948000000b00336710ddea0sm393142wrn.59.2024.01.10.23.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 23:01:27 -0800 (PST)
Date: Thu, 11 Jan 2024 02:01:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ani@anisinha.ca" <ani@anisinha.ca>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>,
 Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 1/2] qom: new object to associate device to numa node
Message-ID: <20240111015923-mutt-send-email-mst@kernel.org>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
 <20240102125821.00001aa0@Huawei.com>
 <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <SA1PR12MB719917E2C9D98C04AE9058C4B0672@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240104103941.019f9b54.alex.williamson@redhat.com>
 <20240109165221.00003b8b@Huawei.com>
 <16d54fd2-9bab-46cd-a1b7-9742674453d6@redhat.com>
 <659f25e98bbb_5cee2945@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <659f25e98bbb_5cee2945@dwillia2-xfh.jf.intel.com.notmuch>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jan 10, 2024 at 03:19:05PM -0800, Dan Williams wrote:
> David Hildenbrand wrote:
> > On 09.01.24 17:52, Jonathan Cameron wrote:
> > > On Thu, 4 Jan 2024 10:39:41 -0700
> > > Alex Williamson <alex.williamson@redhat.com> wrote:
> > > 
> > >> On Thu, 4 Jan 2024 16:40:39 +0000
> > >> Ankit Agrawal <ankita@nvidia.com> wrote:
> > >>
> > >>> Had a discussion with RH folks, summary follows:
> > >>>
> > >>> 1. To align with the current spec description pointed by Jonathan, we first do
> > >>>       a separate object instance per GI node as suggested by Jonathan. i.e.
> > >>>       a acpi-generic-initiator would only link one node to the device. To
> > >>>       associate a set of nodes, those number of object instances should be
> > >>>       created.
> > >>> 2. In parallel, we work to get the spec updated. After the update, we switch
> > >>>      to the current implementation to link a PCI device with a set of NUMA
> > >>>      nodes.
> > >>>
> > >>> Alex/Jonathan, does this sound fine?
> > >>>    
> > >>
> > >> Yes, as I understand Jonathan's comments, the acpi-generic-initiator
> > >> object should currently define a single device:node relationship to
> > >> match the ACPI definition.
> > > 
> > > Doesn't matter for this, but it's a many_device:single_node
> > > relationship as currently defined. We should be able to support that
> > > in any new interfaces for QEMU.
> > > 
> > >>   Separately a clarification of the spec
> > >> could be pursued that could allow us to reinstate a node list option
> > >> for the acpi-generic-initiator object.  In the interim, a user can
> > >> define multiple 1:1 objects to create the 1:N relationship that's
> > >> ultimately required here.  Thanks,
> > > 
> > > Yes, a spec clarification would work, probably needs some text
> > > to say a GI might not be an initiator as well - my worry is
> > > theoretical backwards compatibility with a (probably
> > > nonexistent) OS that assumes the N:1 mapping. So you may be in
> > > new SRAT entry territory.
> > > 
> > > Given that, an alternative proposal that I think would work
> > > for you would be to add a 'placeholder' memory node definition
> > > in SRAT (so allow 0 size explicitly - might need a new SRAT
> > > entry to avoid backwards compat issues).
> > 
> > Putting all the PCI/GI/... complexity aside, I'll just raise again that 
> > for virtio-mem something simple like that might be helpful as well, IIUC.
> > 
> > 	-numa node,nodeid=2 \
> > 	...
> > 	-device virtio-mem-pci,node=2,... \
> > 
> > All we need is the OS to prepare for an empty node that will get 
> > populated with memory later.
> > 
> > So if that's what a "placeholder" node definition in srat could achieve 
> > as well, even without all of the other acpi-generic-initiator stuff, 
> > that would be great.
> 
> Please no "placeholder" definitions in SRAT. One of the main thrusts of
> CXL is to move away from static ACPI tables describing vendor-specific
> memory topology, towards an industry standard device enumeration.
> 
> Platform firmware enumerates the platform CXL "windows" (ACPI CEDT
> CFMWS) and the relative performance of the CPU access a CXL port (ACPI
> HMAT Generic Port), everything else is CXL standard enumeration.

I assume memory topology and so on apply, right?  E.g PMTT etc.
Just making sure.


> It is strictly OS policy about how many NUMA nodes it imagines it wants
> to define within that playground. The current OS policy is one node per
> "window". If a solution believes Linux should be creating more than that
> I submit that's a discussion with OS policy developers, not a trip to
> the BIOS team to please sprinkle in more placeholders. Linux can fully
> own the policy here. The painful bit is just that it never had to
> before.


