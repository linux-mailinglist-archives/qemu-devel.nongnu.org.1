Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F55882AA81
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 10:06:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNr0u-0003nk-79; Thu, 11 Jan 2024 04:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rNr0n-0003mI-FC
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:06:05 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rNr0j-0003dv-OL
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704963961; x=1736499961;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WJYX7eVmKz0kBzx3Qx8aLWx4x2vYw6sUwUHVR0Zf0yM=;
 b=iamfiDRFRBGEGEEDL/ZIKex/hnr8VRWYdgL7YEv3MwXjBtMihyZMs5OX
 9L62au2UwmSZGqazqAd6juhj23VZhfpJY4Ed2FpIXGQZ4MhLh3d66Urto
 ceaFJSsAJnvMUYOLsJ8x/0HFDekrErdkP5lVy7PdL1TRhHr4auwOTQznE
 eJf0rTstmr97cpt7lgbgm5hfskIDlh7VbaUg+GmZvoVFdDYWBPKEGYRAw
 5766m5miiVLeWr59ctAJ1Yu1zEOJ5Au8LIeH9EAu+86xvfa9EDc06nNoz
 yLsPWytO5Mqz2Kangbp9SnM49th7+WkAJFVJZZ0068TJNIokWgiRrHJKb w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="389225289"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="389225289"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 01:05:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1113769799"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="1113769799"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga005.fm.intel.com with ESMTP; 11 Jan 2024 01:05:54 -0800
Date: Thu, 11 Jan 2024 17:18:50 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v7 07/16] i386: Support modules_per_die in X86CPUTopoInfo
Message-ID: <ZZ+yei0d1kRyJC7F@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-8-zhao1.liu@linux.intel.com>
 <866a3a37-cba8-425c-9d9b-57ad05b16bc4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <866a3a37-cba8-425c-9d9b-57ad05b16bc4@intel.com>
Received-SPF: none client-ip=134.134.136.20;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jan 11, 2024 at 01:53:53PM +0800, Xiaoyao Li wrote:

> > -    cores_per_pkg = topo_info.cores_per_die * topo_info.dies_per_pkg;
> > +    cores_per_pkg = topo_info.cores_per_module * topo_info.modules_per_die *
> > +                    topo_info.dies_per_pkg;
> 
> Nit. maybe we can introduce some helper function like
> 
> static inline uint32_t topo_info_cores_per_pkg(X86CPUTopoInfo *topo_info) {
> 	return topo_info.cores_per_module * topo_info.modules_per_die *
>                topo_info.dies_per_pkg;
> }
> 
> so we don't need to care how it calculates.

Yeah, will add this helper, maybe in another patch.

> 
> Besides,
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks!

-Zhao

