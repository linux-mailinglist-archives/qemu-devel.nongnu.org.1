Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3A67727D8
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:35:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT1JS-0003XV-Lw; Mon, 07 Aug 2023 10:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qT1JN-0003WY-1I
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:34:22 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qT1JL-0001EQ-7t
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691418859; x=1722954859;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0hLdm5I3eItgSLJViwHBUVJYIaPC6Thk0v8Ge1ql0sE=;
 b=OzUrXYvYYErGJvS2n6jGUcWdDLES3jS7MQYjSzAzasQkd58PkepJZoj6
 XwHYjaKo/j1uaXnYEzYwXd4nDlqVWXAlkmq/AS/Rgl0BycxDxhLaOCU2c
 4fBjN3y5qvShZtVpxYNZomNHziZ8u2qQS002QZe0h/lvhfYD4nDqwsm8V
 0bZhVXx+Z6R8d5jUUMJLwQfaT3nA3lFGDY0Vva1ppEdWaMdSqVFapcmZ0
 zkt2U7QIETzFpTfdSfgyU1VYBmtBMufpWHVSVLJ009ClTw1FYo98Swg4Q
 KmbnX43rMmVELZnTHuSHSHQczmbOJHQHkP/fLocdhrrWCa4E9dmylxuF4 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350150347"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; d="scan'208";a="350150347"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 07:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1061614560"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; d="scan'208";a="1061614560"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2023 07:32:15 -0700
Date: Mon, 7 Aug 2023 22:42:44 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: Re: [PATCH v3 03/17] softmmu: Fix CPUSTATE.nr_cores' calculation
Message-ID: <ZNEC5HsjeoemD29V@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-4-zhao1.liu@linux.intel.com>
 <17d46d49-844c-60ed-56cc-0e671564948a@intel.com>
 <ZNCi6uNsVB1F39XD@liuzhao-OptiPlex-7080>
 <7d3d2630-4ac4-8875-8c6f-054000462755@intel.com>
 <ZNDAsj0N/FoBXG/b@liuzhao-OptiPlex-7080>
 <bddb9f52-e07c-83bb-8af8-1e726616f42a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bddb9f52-e07c-83bb-8af8-1e726616f42a@intel.com>
Received-SPF: none client-ip=192.55.52.136;
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

Hi Xiaoyao,

[snip]

> 
> I see.
> 
> Can we pull the patch into this series (define a common CPUTopoInfo in
> CPUState and drop env->nr_dies, cs->nr_cores and cs->nr_threads) and let the
> hybrid series later to rename it to X86ApicidTopoInfo?
>

Yes, we can spilt these from hybrid series.

But if I merge these into this series, it makes the v4 change a bit too
much for subsequent reviews.

I could cook another series to do these cleanups after this series.

Thanks,
Zhao

