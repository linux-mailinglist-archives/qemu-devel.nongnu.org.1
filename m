Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB6F7D6D2E
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:32:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvdyS-0008AM-Id; Wed, 25 Oct 2023 09:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qvdyQ-00089u-7J
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:31:02 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qvdyL-000842-G3
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698240657; x=1729776657;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=olQ2ezotKWBDA6Of1wjDTlEYLDQ2rg4kphj/Smcpnw4=;
 b=lnD04hfszut7u6DInUq4uzWuPpI8Rx/6DiJcJBqDgweAGyRXFy4xKpQw
 b2k2MoQWJGtkeqBYzlAz4N0deYiQnV10wXAEDiqb7LmjNl33F1Tf+R9pB
 xxzBk7MTuXSZphh+y6G7EbJGLSCXWFfI546d41aMxvQtKg7OSNSdHz4RQ
 S221jr3krrlBwQ/xPVY53yd4GH9oQNxgLuONl270uqQgA7ZYZcNmtSQTx
 47JP0obHk8nQ6kPD+3U7ABtsnoGIVpAmfwvhEUD4DXjQJFFYmBqetTWUr
 xWEMkkqzRdph0V/2mrr39FI5QEhl/WEJ/KFRZjU9uP2UISBNkaQnZkZ4h A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="453775523"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; d="scan'208";a="453775523"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2023 06:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="6839921"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 25 Oct 2023 06:30:41 -0700
Date: Wed, 25 Oct 2023 21:42:29 +0800
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
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 00/20] Support smp.clusters for x86 in QEMU
Message-ID: <ZTkbRUTvdULkDbZU@intel.com>
References: <20231024090323.1859210-1-zhao1.liu@linux.intel.com>
 <9a8e0ab9-48cf-777b-92ac-cd515eec0cf9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a8e0ab9-48cf-777b-92ac-cd515eec0cf9@linaro.org>
Received-SPF: none client-ip=134.134.136.100;
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

On Wed, Oct 25, 2023 at 12:04:12PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed, 25 Oct 2023 12:04:12 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH v5 00/20] Support smp.clusters for x86 in QEMU
> 
> Hi Zhao,
> 
> On 24/10/23 11:03, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Hi list,
> > 
> > This is the our v5 patch series, rebased on the master branch at the
> > commit 384dbdda94c0 ("Merge tag 'migration-20231020-pull-request' of
> > https://gitlab.com/juan.quintela/qemu into staging").
> 
> Since the 4 first patches are not x86-specific (and are Acked
> by Michael), I'll queue them to shorten your series. I'll let
> Paolo look at the rest.

Thanks Philippe!

-Zhao


