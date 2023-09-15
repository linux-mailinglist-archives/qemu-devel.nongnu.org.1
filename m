Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA467A1775
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 09:30:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh3Gh-0002qv-Dp; Fri, 15 Sep 2023 03:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qh3Gd-0002hx-Td
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:29:31 -0400
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qh3Gc-0006Qa-Bd
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694762970; x=1726298970;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=vqSqSV0hnxMFN7cPcJHLkiwDafrzR/OIFFgsA1wIytc=;
 b=iu/ZvB8xWwdp7B2skfZ+g5O26oIe94p28efCSMLMhf0BNnF/jccHIBxM
 j5T0R/xun0wVqDB7cwEtoqXgp7qiMZqTmwJqPUN51vJO9Pg40M/T562n7
 znvIdIAx8y6Vt6vBnStrA7Z7Jkp7DmhpaUgn3ixY5D04yVSmA5UC+RWGE
 nIMi2EME5U+1RWzzV512nlzvu5WNS+U6qltDBUead6V3hBryaknnsk+Fd
 seaBC2Bf7IoDci1plQh1B65hE2qwk57x0anpQoDgcLDesAdy8mweuUOZ0
 Vge7ePntatJVXuu5f1FRyJbjbgNbvdx49U537jWXR7xS0VtLrtFgbdJFY Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="465549060"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; d="scan'208";a="465549060"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 00:29:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="738234049"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; d="scan'208";a="738234049"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga007.jf.intel.com with ESMTP; 15 Sep 2023 00:29:23 -0700
Date: Fri, 15 Sep 2023 15:40:25 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 04/21] hw/cpu: Update the comments of nr_cores and
 nr_dies
Message-ID: <ZQQKaeReXGprHMPk@liuzhao-OptiPlex-7080>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
 <20230914072159.1177582-5-zhao1.liu@linux.intel.com>
 <b6acd6c8-fffe-2826-bc02-0968af0236a1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6acd6c8-fffe-2826-bc02-0968af0236a1@linaro.org>
Received-SPF: none client-ip=192.55.52.43;
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

On Thu, Sep 14, 2023 at 09:32:31AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu, 14 Sep 2023 09:32:31 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH v4 04/21] hw/cpu: Update the comments of nr_cores and
>  nr_dies
> 
> On 14/9/23 09:21, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > In the nr_threads' comment, specify it represents the
> > number of threads in the "core" to avoid confusion.
> > 
> > Also add comment for nr_dies in CPUX86State.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Changes since v3:
> >   * The new patch split out of CPUSTATE.nr_cores' fix. (Xiaoyao)
> > ---
> >   include/hw/core/cpu.h | 2 +-
> >   target/i386/cpu.h     | 1 +
> >   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>

Thanks!

-Zhao

