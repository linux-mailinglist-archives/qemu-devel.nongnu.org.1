Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 280BB7D64A6
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 10:12:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYyd-00009L-AP; Wed, 25 Oct 2023 04:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qvYyT-00008V-Qw
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 04:10:46 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qvYyR-0004GY-Tt
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 04:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698221444; x=1729757444;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=AhaeKMDNwHqScAHYtVYxZLMzslvCZAv2P4CFwMLMaJ8=;
 b=nctlHacORadFYJ0du+E0bVd1UMWyLn3X38OeNwDjXEPLqLWxJKvaVtEU
 LzwZLINXZaDosCk+V0ktxhFWMVrLELNs/5U6wEGjVrHhX6NWz7wdVqSJx
 n179EIVEAC0dPuebparS2bQKysz68MlpS9dqQVNT5arD+WR2SLg0U6N8C
 AxN2Mxzm3ych04hFQ2glQndU5XAJhzbCxQJ/kvmGxDiuUPHL9vTzP7sqV
 ynNOrLUfnKFNbP4cPC4vxrpW6oqYGZ63j9OXLMET5+1Hayw45GD+KOttu
 aDFOuuSUnHv7Q/gqagGpfKxX6OyRuhquaIeAGzK+FPnx8rxojQCBoJ+x3 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="18212"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="18212"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2023 01:10:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="882376636"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; d="scan'208";a="882376636"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga004.jf.intel.com with ESMTP; 25 Oct 2023 01:10:28 -0700
Date: Wed, 25 Oct 2023 16:22:07 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 02/20] tests: Rename test-x86-cpuid.c to test-x86-topo.c
Message-ID: <ZTjQLxBjJOiV1Wt2@intel.com>
References: <20231024090323.1859210-1-zhao1.liu@linux.intel.com>
 <20231024090323.1859210-3-zhao1.liu@linux.intel.com>
 <88dce00d-20ed-4219-8b4b-1ac0dd30a514@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88dce00d-20ed-4219-8b4b-1ac0dd30a514@redhat.com>
Received-SPF: none client-ip=192.198.163.8;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, Oct 24, 2023 at 11:09:34AM +0200, Thomas Huth wrote:
> Date: Tue, 24 Oct 2023 11:09:34 +0200
> From: Thomas Huth <thuth@redhat.com>
> Subject: Re: [PATCH v5 02/20] tests: Rename test-x86-cpuid.c to
>  test-x86-topo.c
> 
> On 24/10/2023 11.03, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > The tests in this file actually test the APIC ID combinations.
> > Rename to test-x86-topo.c to make its name more in line with its
> > actual content.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Tested-by: Babu Moger <babu.moger@amd.com>
> > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com> 

Thanks!

-Zhao

