Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 296187FA123
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 14:35:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7bkq-0003jO-Kp; Mon, 27 Nov 2023 08:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r7bkS-0003j4-SO; Mon, 27 Nov 2023 08:34:05 -0500
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r7bkP-0003sF-9j; Mon, 27 Nov 2023 08:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701092041; x=1732628041;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IBsFcy4w1dKm+23pKQZlJwWpVjYAkfH33Tq2KajTDsU=;
 b=DkhBbUeFOkeZkxhNKeI1A+CGFT26AI60sswJOJO4Idsk7OPJbhIrLYc+
 nkkOqkTFu/SMS9pGO7i6LqPjmwwb8asVygGOweFx9Ctn/e/tNr3Bh9dBj
 Ug03i4TIX5wt+Z2/AVSLocRmIDLfnSOaBmXKA4Yh5r3FjEIizbRT6hXi5
 uXIblFJ2KPe9ZNDaldhj0g2uL86g4fWsb6cM6HLNmkBWJZy103242zUL4
 ZzJnyVB6vR3GR7sKd2EpkRVn2CbA9MOIdvkeU4lj7ElN1q7PIFsjVMye6
 sA4uFP+Kt9EzkkNH7u0kJbStPKzn+1BwiLBO4ZPg2Z6mU3VQawl2sc7oX Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="459193956"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; d="scan'208";a="459193956"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 05:33:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="9780377"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2023 05:33:42 -0800
Date: Mon, 27 Nov 2023 21:45:58 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC] docs/s390: Fix wrong command example in
 s390-cpu-topology.rst
Message-ID: <ZWSdlgfp50IuyHqd@intel.com>
References: <20231127093915.565710-1-zhao1.liu@linux.intel.com>
 <0c9271e79189edff10a85f99fe8a27ae287ad796.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c9271e79189edff10a85f99fe8a27ae287ad796.camel@linux.ibm.com>
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
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

Hi Nina,

On Mon, Nov 27, 2023 at 01:58:32PM +0100, Nina Schoetterl-Glausch wrote:
> Date: Mon, 27 Nov 2023 13:58:32 +0100
> From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Subject: Re: [RFC] docs/s390: Fix wrong command example in
>  s390-cpu-topology.rst
> 
> On Mon, 2023-11-27 at 17:39 +0800, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > From s390_possible_cpu_arch_ids() in hw/s390x/s390-virtio-ccw.c, the
> > "core-id" is the index of pssible_cpus->cpus[], so it should only be
> 
> s/pssible_cpus/possible_cpus/

Thanks!

> 
> > less than possible_cpus->len, which is equal to ms->smp.max_cpus.
> > 
> > Fix the wrong "core-id" 112 because it is greater than maxcpus (36) in
> 
> Maybe s/is greater/isn't less/ since the valid ids are 0-35 inclusive.

Ok.

> 
> > -smp.
> > 
> > Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Thanks! Let me refresh a new version quickly.

-Zhao

