Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CD7771AE2
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 08:57:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSu9r-0003vN-0l; Mon, 07 Aug 2023 02:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qSu9i-0003v7-9q
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 02:55:54 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qSu9f-0007bV-Ka
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 02:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691391351; x=1722927351;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=VLX8wAC09GXlRN+I9nQD+VV98aKqZ9cIYlr0xeNaEuk=;
 b=Srj/rxO2a1WmGPz67kc3HgTQsf4ELV/ovu1El/+Lr3j/+seB2i+9wQT3
 BYU8DB5mFdNhDQfVYx5gfSlaw4j5oo7I7nLJmzfeRbH1Tv6RqukhFDPdP
 DG7MnUurmMW8h+BERd+K+wRUbkvZEWhGjnvFVRfOvmE4ZXnkEKkg6W3e7
 B4AMxgKZf0cH6XCIOfUHKpB3+HQgamOYPesGgGm6KG8S2GUcKFgVDFzuD
 ui5X2OqeFjew+G3nApDR5RS/aEDwo8hlSqRoVIOWVg85iTzndxEoS4KW4
 yKgDfHuQJ+PTIhDrrD7Ma9wQ7ohF6qIUyh38mF/Gcpc8X5OQS23nR5vZ+ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="373220569"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="373220569"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2023 23:55:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="977321096"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="977321096"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2023 23:55:18 -0700
Date: Mon, 7 Aug 2023 15:05:47 +0800
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
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 01/17] i386: Fix comment style in topology.h
Message-ID: <ZNCXy95Iy1lpnRql@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-2-zhao1.liu@linux.intel.com>
 <626cb530-de91-b6f2-330b-dd4d8c6e30d9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <626cb530-de91-b6f2-330b-dd4d8c6e30d9@intel.com>
Received-SPF: none client-ip=134.134.136.24;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Hi Xiaoyao,

On Mon, Aug 07, 2023 at 10:16:46AM +0800, Xiaoyao Li wrote:
> Date: Mon, 7 Aug 2023 10:16:46 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v3 01/17] i386: Fix comment style in topology.h
> 
> On 8/1/2023 6:35 PM, Zhao Liu wrote:
> > From: Zhao Liu<zhao1.liu@intel.com>
> > 
> > For function comments in this file, keep the comment style consistent
> > with other places.
> > 
> > Signed-off-by: Zhao Liu<zhao1.liu@intel.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org
> 
> missing '>' at the end.

Good catch!

> 
> > Reviewed-by: Yanan Wang<wangyanan55@huawei.com>
> > Acked-by: Michael S. Tsirkin<mst@redhat.com>
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@Intel.com>

Thanks!

-Zhao

> 

