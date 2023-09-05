Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39781792098
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 08:47:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdPp9-0003tD-Aw; Tue, 05 Sep 2023 02:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qdPp5-0003sF-9x
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 02:46:04 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qdPp1-00047m-TB
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 02:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693896359; x=1725432359;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=O+dEPCQnL+2wSg5Nn7VYYX0xrekGwi8H664sI7YtD1g=;
 b=PV6jeR0iKsI4lVWXBJC4mybcLKqjaXpiv/MY1q2DFVYPol/DszXrCwxe
 bz+nMNJWtLgIfW5Thu3TQDGNN+ESlLKRyFqXW/i+B5nWjVkRz/FsYmzp+
 pltSm/ydD6l59Bc7shERwlj07yKSrSLrRzuyMiK1iGvAbiQa01HUrjesY
 TU0ABkZ5BY7akzY1dAsyQCBzlc/c5OJPooG8+7ZB3xIqZvO9slJBM/OnL
 3OYnU/e3/f6yoEn6Ajzzc3pqYFKxli5rgJKgtPxaV9q5lr6GHLe8hz3uA
 3rmWGvXFeJoGPMLpQedZ9mO6KJFNjy0knz9AteTzzhoFI3+alOUMqChJt A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="357031007"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; d="scan'208";a="357031007"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2023 23:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="884210038"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; d="scan'208";a="884210038"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2023 23:45:41 -0700
Date: Tue, 5 Sep 2023 14:56:46 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 00/16] tests: Add CPU topology related smbios test cases
Message-ID: <ZPbRLtS6Txn0a2LX@liuzhao-OptiPlex-7080>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <663cf3d4-47ea-262d-36b3-cf826f870ef0@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663cf3d4-47ea-262d-36b3-cf826f870ef0@tls.msk.ru>
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

Hi Michael,

On Fri, Sep 01, 2023 at 12:55:33PM +0300, Michael Tokarev wrote:
> Date: Fri, 1 Sep 2023 12:55:33 +0300
> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: Re: [PATCH 00/16] tests: Add CPU topology related smbios test cases
> 
> 25.08.2023 06:36, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Hi all,
> > 
> > This patchset is the follow up tests of previous topology fixes in
> > smbios [1].
> > 
> > In this patchset, add these test cases:
> > 
> > 1. Add the case to test 2 newly added topology helpers (patch 1):
> >     * machine_topo_get_cores_per_socket()
> >     * machine_topo_get_threads_per_socket()
> > 
> > 2. Add the cases in bios-tables-test.c to:
> >     * test smbios type4 table count (patch 2-4).
> >     * test smbios type4 core count field (patch 5-7).
> >     * update the test of smbios type4 core count2 field (patch 8-10).
> >     * test smbios type4 thread count (patch 11-13).
> >     * test smbios type4 thread count2 (patch 14-16).
> > 
> > With the above new cases, cover all commits of [1] in test.
> > 
> > [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06225.html
> 
> Hmm.  I definitely didn't expect such a large patchset..  I asked for just
> a small, maybe manual (from command-line) reproducer of the original issue,
> so I can verify it is fixed before applying the change in question to qemu
> stable trees. 

Since these issues are found by coding reading, they are "byproducts" of
other topology-related work I've been woring on, not directly identified
by any anomaly...

...So I'm not quite sure what the consequences of these few misuses of
topology fields are, and how they might manifest themselves.

> It is a large work.  Lemme at least give it a try in the
> gitlab CI...

The test cases are the ones that clearly define the relevant topology
issues.


Thanks,
Zhao

> 
> Philippe, can you pick this up for the misc tree?
> 
> /mjt

