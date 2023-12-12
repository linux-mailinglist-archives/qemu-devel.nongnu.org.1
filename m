Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3191380E12D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 03:02:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCs5K-00073Z-JG; Mon, 11 Dec 2023 21:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rCs5I-00073R-2M
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 21:01:20 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rCs5E-0007M5-GF
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 21:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702346477; x=1733882477;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=U5yaGOik9SkNhLSj5iQvJeloGYyllB618wcvIpW9jEk=;
 b=FwMLTeqCXwfl94t3N1RTDMW2q80Z+sUtnL+OnFsfkchvknkGQNYK00E2
 JkBmupz0HV6DiwKy1Zm8haKl7lxGTpFRwpAl61VUIJAhOTa1pbPrbVlZW
 P+Lrndq2q3m2K5EuDzdHHm/geXJ7Gxh0iUm86TYeYTgDTJV48LVDf3XwX
 PKQsRRDDfBJCd2IN9O+NkOSVokYGQFSEwlFHezZYTD7Ezm9+WHucD8QoQ
 2zGI7la/OcsAPcZekvfj0mckS/FcAZtmyUi67EZyMG3fEEC5j+qOg91n3
 BmyQojKPAbbkLvhYHfk6vBxCEnbnk31Sb+xwunHKgDOSSD9ZdblaWVre6 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1816156"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="1816156"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2023 18:01:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; d="scan'208";a="21322569"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 11 Dec 2023 18:01:03 -0800
Date: Tue, 12 Dec 2023 10:13:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Juan Quintela <juan.quintela@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, afaerber@suse.de, ale@rev.ng,
 anjo@rev.ng, bbauman@redhat.com, chao.p.peng@linux.intel.com,
 cjia@nvidia.com, cw@f00f.org, eblake@redhat.com,
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com,
 eric.auger@redhat.com, f4bug@amsat.org,
 "felipe@nutanix.com" <felipe.franciosi@nutanix.com>,
 "iggy@theiggy.com" <iggy@kws1.com>,
 "imp@bsdimp.com" <wlosh@bsdimp.com>, jan.kiszka@web.de,
 jgg@nvidia.com, jidong.xiao@gmail.com, jjherne@linux.vnet.ibm.com,
 joao.m.martins@oracle.com, konrad.wilk@oracle.com,
 mburton@qti.qualcomm.com, mdean@redhat.com, mimu@linux.vnet.ibm.com,
 peter.maydell@linaro.org, qemu-devel@nongnu.org,
 quintela@redhat.com, richard.henderson@linaro.org,
 shameerali.kolothum.thodi@huawei.com, stefanha@gmail.com,
 wei.w.wang@intel.com, z.huo@139.com, zwu.kernel@gmail.com,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: QEMU developers fortnightly conference call for agenda for
 2023-12-12
Message-ID: <ZXfBxcGGqE0t2SpC@intel.com>
References: <calendar-98548e19-3517-40fa-a2ae-1c384aa3f98f@google.com>
 <ZXcOtAIMqLjOheIa@intel.com>
 <e2462fb5-228a-443d-93ce-7069998128b0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2462fb5-228a-443d-93ce-7069998128b0@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Philippe,

On Mon, Dec 11, 2023 at 08:04:28PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon, 11 Dec 2023 20:04:28 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: QEMU developers fortnightly conference call for agenda for
>  2023-12-12
> 
> Hi Zhao,
> 

[snip]

> 
> FYI I have your series tagged for review (for generic QOM /
> machine [*]) but we need feedback from the x86 maintainers too,
> and eventually from riscv/arm too, since they might end up
> using your API.
> 
> [*] That said, I unlikely will have time the next 2 weeks.

Thanks for your help!

Best Regards,
Zhao

> 
> Regards,
> 
> Phil.
> 
> > Thanks,
> > Zhao
> 

