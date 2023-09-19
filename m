Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FAC7A5A01
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 08:35:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiUKD-0004Mk-Tl; Tue, 19 Sep 2023 02:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qiUKA-0004MR-91
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 02:35:06 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qiUK8-0001qs-5X
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 02:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695105304; x=1726641304;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DqkUMQn/In8KevNydS2PopJdFIUoHPBYavLYIY/byK4=;
 b=Knao/RwS++VcEXT4Yn7TrOFX/QmRxmvpR7iSoQz5nPOhqxDB16J5g3pJ
 9hkT6VlKlh1CxXPiZNHVxFADSqqXUQaeTUWMnzyIm6dYnnep1veMYJhWW
 zDwBhQMTLJb+STod3e9N4+5FOW31Ni8K18Zr1R3R5gIDCX2mTLz/gWZM4
 R7Qc2TTw493VvG4GoqdSdoKG2r/p2rAd7qAddtrkZcQSO7Rn8qwFBwLUX
 oJggZGG9Q8qtOjscAHFGwz6ru4JbBDoq8+2ntGwr4L7ZQNz9PfY9PIrIm
 KqdpAg79BOQH+mhgOey6ef1g/9hQJEZetwPQtZr/OzebMtlA7sSFOSZOR w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="360118812"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; d="scan'208";a="360118812"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 23:34:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="746111247"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; d="scan'208";a="746111247"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga002.jf.intel.com with ESMTP; 18 Sep 2023 23:34:56 -0700
Date: Tue, 19 Sep 2023 14:46:00 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 00/16] tests: Add CPU topology related smbios test cases
Message-ID: <ZQlDqNjFnJVXMpDO@liuzhao-OptiPlex-7080>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <663cf3d4-47ea-262d-36b3-cf826f870ef0@tls.msk.ru>
 <ZPbRLtS6Txn0a2LX@liuzhao-OptiPlex-7080>
 <20230915094735-mutt-send-email-mst@kernel.org>
 <20230915163055.7a989af4@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915163055.7a989af4@imammedo.users.ipa.redhat.com>
Received-SPF: none client-ip=192.55.52.151;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 15, 2023 at 04:30:55PM +0200, Igor Mammedov wrote:
> Date: Fri, 15 Sep 2023 16:30:55 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH 00/16] tests: Add CPU topology related smbios test cases
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> 
> On Fri, 15 Sep 2023 09:48:08 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Sep 05, 2023 at 02:56:46PM +0800, Zhao Liu wrote:
> > > Hi Michael,
> > > 
> > > On Fri, Sep 01, 2023 at 12:55:33PM +0300, Michael Tokarev wrote:  
> > > > Date: Fri, 1 Sep 2023 12:55:33 +0300
> > > > From: Michael Tokarev <mjt@tls.msk.ru>
> > > > Subject: Re: [PATCH 00/16] tests: Add CPU topology related smbios test cases
> > > > 
> > > > 25.08.2023 06:36, Zhao Liu wrote:  
> > > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > > > 
> > > > > Hi all,
> > > > > 
> > > > > This patchset is the follow up tests of previous topology fixes in
> > > > > smbios [1].
> > > > > 
> > > > > In this patchset, add these test cases:
> > > > > 
> > > > > 1. Add the case to test 2 newly added topology helpers (patch 1):
> > > > >     * machine_topo_get_cores_per_socket()
> > > > >     * machine_topo_get_threads_per_socket()
> > > > > 
> > > > > 2. Add the cases in bios-tables-test.c to:
> > > > >     * test smbios type4 table count (patch 2-4).
> > > > >     * test smbios type4 core count field (patch 5-7).
> > > > >     * update the test of smbios type4 core count2 field (patch 8-10).
> > > > >     * test smbios type4 thread count (patch 11-13).
> > > > >     * test smbios type4 thread count2 (patch 14-16).
> > > > > 
> > > > > With the above new cases, cover all commits of [1] in test.
> > > > > 
> > > > > [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06225.html  
> > > > 
> > > > Hmm.  I definitely didn't expect such a large patchset..  I asked for just
> > > > a small, maybe manual (from command-line) reproducer of the original issue,
> > > > so I can verify it is fixed before applying the change in question to qemu
> > > > stable trees.   
> > > 
> > > Since these issues are found by coding reading, they are "byproducts" of
> > > other topology-related work I've been woring on, not directly identified
> > > by any anomaly...
> > > 
> > > ...So I'm not quite sure what the consequences of these few misuses of
> > > topology fields are, and how they might manifest themselves.
> > >   
> > > > It is a large work.  Lemme at least give it a try in the
> > > > gitlab CI...  
> > > 
> > > The test cases are the ones that clearly define the relevant topology
> > > issues.
> > > 
> > > 
> > > Thanks,
> > > Zhao  
> > 
> > I think it's ok, as long as Igor's happy.
> 
> series looks fine to me
> (modulo cosmetic issues and better commit messages as noted in per patch review)

Thanks Igor!

-Zhao

> 
> > 
> > > > 
> > > > Philippe, can you pick this up for the misc tree?
> > > > 
> > > > /mjt  
> > 
> 

