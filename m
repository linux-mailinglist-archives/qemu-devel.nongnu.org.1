Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43370822FAE
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 15:38:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL2MI-0005HN-Aj; Wed, 03 Jan 2024 09:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rL2MF-0005Gy-VG
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 09:36:36 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rL2MC-0005kN-TX
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 09:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704292593; x=1735828593;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=V08c2ngZZiZj/MzDx+DvdwyKzwBG1YJ1UmQkO7805aw=;
 b=mYx9dvTSqVNpfUwtU+kVZxksjBMw6JD5O7tlisIFJxMrq7iJEF9fxPc4
 Fj+jdxtBZdDZt5dRHnK3J83PGyr/eEZ9y8C8FX8VO70OIwgxcFC8DYxV+
 zHOcwMLRddpWStIoa9zsIkzsWYHSBgs5gv3St/OgtHw5gtoqWySi46iDo
 OvlQYLuInN4khJfL2Sdt4GpFlDXKFY6o5jk2GoBXmtZrFdt/jJphfFSY8
 vzKD0NsyBwak/uVzxN+ycfQo7ipSgDijXsnnk9Kl7GI4+6vVK9AmshsgV
 /BfTSThS1eqa9qH/JSQarNVVguzXzZvGqH0HWwOfR//WKdlPR4vc1Mpy1 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="15656712"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; d="scan'208";a="15656712"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2024 06:36:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="808844758"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; d="scan'208";a="808844758"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga008.jf.intel.com with ESMTP; 03 Jan 2024 06:36:28 -0800
Date: Wed, 3 Jan 2024 22:49:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] softmmu: remove obsolete comment about libvirt timeouts
Message-ID: <ZZVz8Mt3InMvl5WO@intel.com>
References: <20240103123042.2400677-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240103123042.2400677-1-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
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

On Wed, Jan 03, 2024 at 12:30:42PM +0000, Daniel P. Berrangé wrote:
> Date: Wed,  3 Jan 2024 12:30:42 +0000
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH] softmmu: remove obsolete comment about libvirt timeouts
> 
> For a long time now, libvirt has pre-created the monitor connection
> socket and passed the pre-opened FD into QEMU during startup. Thus
> libvirt does not have any timeouts waiting for the monitor socket
> to appear, it is immediately connected.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  system/vl.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/system/vl.c b/system/vl.c
> index 6b87bfa32c..1d1508e28f 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1911,7 +1911,6 @@ static bool object_create_early(const char *type)
>       * Allocation of large amounts of memory may delay
>       * chardev initialization for too long, and trigger timeouts
>       * on software that waits for a monitor socket to be created
> -     * (e.g. libvirt).

From the commit message of 6546d0dba6c2 ("vl: Delay initialization of
memory backends"), and related bugzilla, I understand the only software
Eduardo wanted to describe is libvirt.

Do you know of any other software that has the similar timeout mechanism?
If there is no other software, the description of "trigger timeouts on
software ..." in the comment could be deleted as well.

Otherwise,
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Regards,
Zhao

>       */
>      if (g_str_has_prefix(type, "memory-backend-")) {
>          return false;
> -- 
> 2.43.0
> 
> 

