Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA11827C95
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 02:37:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN12I-0001g1-6r; Mon, 08 Jan 2024 20:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rN12E-0001ft-IB
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 20:36:07 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rN129-0001hS-71
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 20:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704764161; x=1736300161;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Jxw+wXgVK+0zB4+6hhfX23WMdxNd1wR6ZS873ze7Cag=;
 b=aQVpNMbAKNo/NlUWNX2xc8H/DAB0kh65gE1uT+W3F+VNg2pBMkztTbvh
 It3vhSuV3q1THXAm9aeVlItaRvA78BR8QJbrU3yt4AumPH3HWenXvwfhP
 Sv6RvWGuTxMg0/UOOpLjXqBsd2Haim7ygUnvL/nJLgAFbqbW2mqj75PWO
 /QBQjRDrQMTPLr+mTs8Pvf9zRL5VvglxXR3cAYZ5Yvd4VkgE0srDbDWhf
 Tp4ouRgBkXTdM8daq2HU2T2z2uBR54a0eVdbRR8Nz476BshFmtc5hb9CI
 PwEayH3EsgfP2vIYPTz+Sh/1N1dzlDJ64hM7K5DWIYx7kNMgp50uzlOyh Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="19554344"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; d="scan'208";a="19554344"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2024 17:35:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="731303854"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; d="scan'208";a="731303854"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 08 Jan 2024 17:35:46 -0800
Date: Tue, 9 Jan 2024 09:48:41 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v7 00/16] Support smp.clusters for x86 in QEMU
Message-ID: <ZZyl+TEFki3Pmxqm@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <1766d543-8960-4f92-970e-d05975c53e90@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1766d543-8960-4f92-970e-d05975c53e90@amd.com>
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Hi Babu,

On Mon, Jan 08, 2024 at 11:46:50AM -0600, Moger, Babu wrote:
> Date: Mon, 8 Jan 2024 11:46:50 -0600
> From: "Moger, Babu" <babu.moger@amd.com>
> Subject: Re: [PATCH v7 00/16] Support smp.clusters for x86 in QEMU
> 
> Hi  Zhao,
> 
> Ran few basic tests on AMD systems. Changes look good.
> 
> Thanks
> Babu
> 
> 
> Tested-by: Babu Moger <babu.moger@amd.com>
> 

Thanks much for your test!

Regards,
Zhao


