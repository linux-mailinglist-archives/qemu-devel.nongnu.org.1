Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C60A96F15
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Apr 2025 16:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Emm-00007K-3e; Tue, 22 Apr 2025 10:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7Emi-00006l-PB
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:39:41 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7Emg-0002yp-PA
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745332779; x=1776868779;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SnPHDxL2Xm7h4qwqTjPJrK+IRPi/N8xAagIAyLxnoXo=;
 b=QdNBwKLQirJKTwv523PYfGLUfD7BNHWQTNkP9udzV/JfA6qjJsLeTSI6
 MOZR9Snlr6Jd3pug6wa0iVZdpFJfpL7OlS0iRPnMPiULV1uYKu6p2obNQ
 t9yhV56owylr9u0fb4dD1kwy3YS5FUN9vtdLMqOFWbHeMUIr04nOllq7L
 SSALmyaD3t9zmE7jsIlMKyYPUJMV4bS5ZMCSB7A4WQDKa7Ii9DtpfUyjc
 LZ6dZaMV7zga04Rs1EtcWvEl3NmfJ2eZE0IZpde+7ymp8DzCAA4KVZhAR
 tMiN2a70OJ0uru7hZqgrx5dt0IXoGaRec/fkCJTvvJ4M6kIkVFVNuTrYX g==;
X-CSE-ConnectionGUID: zzibEwSQSFS3v95ojnAsrA==
X-CSE-MsgGUID: Pvase6FjSmerrGr7O2lnPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="72283559"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="72283559"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 07:39:37 -0700
X-CSE-ConnectionGUID: S6938VuOSXSKbha1A3aupw==
X-CSE-MsgGUID: GBdg6vdDQyiy0iv0uBFq0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="132031648"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 22 Apr 2025 07:39:33 -0700
Date: Tue, 22 Apr 2025 23:00:29 +0800
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
Subject: Re: [PATCH v8 10/55] i386/tdx: Make sept_ve_disable set by default
Message-ID: <aAevDQfpQSkQLqGH@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-11-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-11-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Apr 01, 2025 at 09:01:20AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:20 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 10/55] i386/tdx: Make sept_ve_disable set by default
> X-Mailer: git-send-email 2.34.1
> 
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> For TDX KVM use case, Linux guest is the most major one.  It requires
> sept_ve_disable set.  Make it default for the main use case.  For other use
> case, it can be enabled/disabled via qemu command line.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/kvm/tdx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


