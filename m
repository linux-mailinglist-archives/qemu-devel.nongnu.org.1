Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C41AA874F
	for <lists+qemu-devel@lfdr.de>; Sun,  4 May 2025 17:29:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBbH0-00025H-OE; Sun, 04 May 2025 11:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBbGy-00024u-Cn
 for qemu-devel@nongnu.org; Sun, 04 May 2025 11:28:56 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBbGw-0008F9-Eb
 for qemu-devel@nongnu.org; Sun, 04 May 2025 11:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746372534; x=1777908534;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=J9/smkW5q83yck1y2PJ3JKCW/dKApmgCnzbc7HsQfnw=;
 b=dBmMOCywWM4pYmTrKjQ8DNgOB5Lb7AFq0dIcZB8sAbYT3E4b45qQzYQ1
 VeGuvqDQXuq0dO9a5mvh7fuYwEHVsQPXohlCXlJDgxROXEOf6DuJh41wA
 ySBeUQZliuZB8xTpPBVixQg/55gpzBnzbKDTjgxj2wHhYr9xKX5lzxKvT
 UdP8+BV77FTWGh0vytZbBFC8p7Zyf5ezznLyANvHxMaKLDv1W0vsgdkuq
 p8XY8nGuuVHrTxP62y4iqCEly4iTMECrwVzMXbRbpyvrq53WajPSnEbdx
 VqayB8neU6mdcr0UY2Du9EM0bPGNKJXvZ2PBH3xdACAiNfKa0ieiWZMGy Q==;
X-CSE-ConnectionGUID: mlDws07nRGWUw4/1y26KeA==
X-CSE-MsgGUID: rMZXus5VRoeyQb73bxFhTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="48131727"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="48131727"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2025 08:28:51 -0700
X-CSE-ConnectionGUID: JPK1M82UThOqeWbRZAUcPA==
X-CSE-MsgGUID: J9nTyXEPSVejE7Mt8nvwiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="136022702"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 04 May 2025 08:28:49 -0700
Date: Sun, 4 May 2025 23:49:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 43/55] i386/cgs: Rename *mask_cpuid_features() to
 *adjust_cpuid_features()
Message-ID: <aBeMnAcmR3/NmUIs@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-44-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-44-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 01, 2025 at 09:01:53AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:53 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 43/55] i386/cgs: Rename *mask_cpuid_features() to
>  *adjust_cpuid_features()
> X-Mailer: git-send-email 2.34.1
> 
> Because for TDX case, there are also fixed-1 bits that enfored by TDX
> module.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/confidential-guest.h | 20 ++++++++++----------
>  target/i386/kvm/kvm.c            |  2 +-
>  target/i386/sev.c                |  4 ++--
>  3 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


