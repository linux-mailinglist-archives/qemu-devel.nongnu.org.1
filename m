Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CAE772798
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:24:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT18c-0005Ok-Ms; Mon, 07 Aug 2023 10:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qT18a-0005OZ-6A
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:23:12 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qT18X-0007Ko-VU
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691418190; x=1722954190;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=L2x3UbxKQBM0WqdzPq8aQhaE1+2l3XWf/cMoa+iNM7s=;
 b=kI2B9oMXvHnp0j+YTn6SmNoRmHdZZfOCUEvaILGmOAat/YgHbmHkmYqV
 RETBVRAa2Dd58gmmDhQkqOuwt02wKqLF4uIyWjFED5bb2wBeisKxciSww
 Lre7nMo9KC7hSDKSmXZdzBCqUm22CQM3sS4uCRo7SmNqepPI4N/MjwtXI
 lNJEGtP54RGwnyt6YP+vwDSJGiWpKbTHV4lxJ0qCoEbgH4dcdwEN/mKz7
 VWaO7/B7bPFrbz3CZE2cSVlt0XrvOTKBTTcVy/qT8e5NbHNcyZQIUKAai
 G9PlQAVnhTNrPm5IsThaRAseq3p4fn+x/wVMIU3J3HC9d9SKZRwZu9/sn w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373309162"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; d="scan'208";a="373309162"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 07:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="766014711"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; d="scan'208";a="766014711"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga001.jf.intel.com with ESMTP; 07 Aug 2023 07:21:06 -0700
Date: Mon, 7 Aug 2023 22:31:35 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>
Subject: Re: [PATCH v2 2/3] hw/smbios: Fix thread count in type4
Message-ID: <ZNEAR7nK1pY/BFH+@liuzhao-OptiPlex-7080>
References: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
 <20230601092952.1114727-3-zhao1.liu@linux.intel.com>
 <598990ac-e5f8-fdcc-5936-e219491c4d0f@tls.msk.ru>
 <32cfa897-4472-083f-88cd-a3c3e3c405b0@tls.msk.ru>
 <20230807115615.278fb838@imammedo.users.ipa.redhat.com>
 <ddfe932b-57b7-8f48-03aa-82e1964dda2a@tls.msk.ru>
 <20230807121129.30e6fe1e@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807121129.30e6fe1e@imammedo.users.ipa.redhat.com>
Received-SPF: none client-ip=134.134.136.24;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Igor,

On Mon, Aug 07, 2023 at 12:11:29PM +0200, Igor Mammedov wrote:
> Date: Mon, 7 Aug 2023 12:11:29 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v2 2/3] hw/smbios: Fix thread count in type4
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> 
> On Mon, 7 Aug 2023 13:06:47 +0300
> Michael Tokarev <mjt@tls.msk.ru> wrote:
> 
> > 07.08.2023 12:56, Igor Mammedov wrote:
> > > On Sat, 5 Aug 2023 09:00:41 +0300
> > > Michael Tokarev <mjt@tls.msk.ru> wrote:
> [...]
> > The whole thing - provided the preparational patch a1d027be95
> > "machine: Add helpers to get cores/threads per socket" is also
> > picked up - applies cleanly and in a stright-forward way to 8.0
> > and even to 7.2, and passes the usual qemu testsuite. Sure thing
> > since the issues weren't noticed before, the testsuite does not
> > cover this area.  It'd be nice to have some verifier to check if
> > the whole thing actually works after applying the patchset.
> 
> Zhao Liu,
> can you help us out with adding test cases to cover the code
> you are touching?

Yes, sure.

Just double check, I should add these 2 test cases:
1. in "bios-tables-test.c" to test smbios type4 topology related things, and
2. also in "test-smp-parse.c" to test our new topology helpers.

Do I understand correctly?

-Zhao

> 
> [...]
> 

