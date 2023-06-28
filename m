Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4AD7408B3
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 04:52:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qELHJ-0001dx-VC; Tue, 27 Jun 2023 22:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qELHE-0001dM-4X
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 22:51:28 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qELHB-0003LH-JJ
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 22:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687920685; x=1719456685;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Zf2frQHwMdYhor+E5OrVaOfTwW1dGX6/Zhsv3Sdy0DI=;
 b=B6nIpE9SAiMXaqe4HZDW1hHRFbtP4FMjpJ9agBDk8r0Pdk/TA4smGNUw
 /6D+qyNrfJ8OfdBHbBcIb6ci9UtWrcNe5sJ86D2sZo3xPv8udhzDGzNhF
 9+fRh8wEsP/8X9whTZV+ueQQ7hThXpX6HKAUySB6Ob9K2eeRUxJuNOtcQ
 h2E2ch64m9mXfs3C/hll8cFuRapMoeG9UPgpbbAw/XMXoViUcWy5YhJTE
 RcdBnwmzBFYxXkmufcHp/9PtulzNFk9b+jZDoon7fV4Cp0PHuQcCPxtv6
 QfheHWorsAENP4gDwckRfUOMS6Hmxu5Q97SSfNj5toc3VptdRrnto2lAf w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="448118658"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="448118658"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 19:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="746475540"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="746475540"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga008.jf.intel.com with ESMTP; 27 Jun 2023 19:50:32 -0700
Date: Wed, 28 Jun 2023 11:00:31 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 0/4] hw/smbios: Cleanup topology related variables
Message-ID: <ZJuiT8EFy9KGe/KB@liuzhao-OptiPlex-7080>
References: <20230620103958.3907565-1-zhao1.liu@linux.intel.com>
 <20230626154817.60613bc5@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626154817.60613bc5@imammedo.users.ipa.redhat.com>
Received-SPF: none client-ip=192.55.52.43;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga05.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 26, 2023 at 03:48:17PM +0200, Igor Mammedov wrote:
> Date: Mon, 26 Jun 2023 15:48:17 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v3 0/4] hw/smbios: Cleanup topology related variables
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> 
> On Tue, 20 Jun 2023 18:39:54 +0800
> Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Hi all,
> > 
> > This is my v3 patch series based on 48ab886d3da4f ("Merge tag 'pull-
> > target-arm-20230619' of https://git.linaro.org/people/pmaydell/qemu-arm
> > into staging").
> > 
> > Compared with v2 [1], v3 introduces 2 helpers to wrap the calculation of
> > threads/cores per socket so that smbios can use these 2 helpers directly
> > to avoid calculation error caused by missing topology changes.
> > 
> > Also due to the introduction of these two helpers, I involve more people
> > for review of this v3.
> 
> other than nitpicking in patch 1/4, the series looks good to me.

Thanks Igor! I'll fix the 1/4 and refresh a new version.

-Zhao

> 
> > 
> > 
> > Introduction
> > ============
> > 
> > This patchset is split from my previous hybrid topology RFC [2].
> > 
> > There are three places for topology-related cleanup:
> > 
> > 1. Fix the calculation of the number of sockets.
> > 
> >    Due to the misuse of the smp.cpus variable and the change in the
> >    meaning of smp.cores, the calculation of socket number in smbios is
> >    incorrect. This can be fixed by using smp.sockets directly.
> > 
> > 2. Fix core count in type4.
> > 
> >    The meaning of smp.cores changed so that the calculation of cores
> >    per socket became wrong.
> > 
> >    v3 introduces the helper "machine_topo_get_cores_per_socket()" to
> >    wrap the calculation of cores per socket. This can help other modules
> >    avoid calculation error caused by missing topology changes.
> > 
> > 3. Fix thread count in type4.
> > 
> >    I also found that the definition of thread count in type4 doesn't
> >    match the spec (smbios 3.0.0) and cleaned it up as well.
> > 
> >    Similar to core count, v3 uses a new helper to fix this.
> > 
> > [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg00072.html
> > [2]: https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg03205.html
> > 
> > 
> > Regards,
> > Zhao
> > 
> > ---
> > Zhao Liu (4):
> >   machine: Add helpers to get cores/threads per socket
> >   hw/smbios: Fix smbios_smp_sockets caculation
> >   hw/smbios: Fix thread count in type4
> >   hw/smbios: Fix core count in type4
> > 
> >  hw/smbios/smbios.c  | 16 ++++++++++------
> >  include/hw/boards.h | 12 ++++++++++++
> >  2 files changed, 22 insertions(+), 6 deletions(-)
> > 
> 

