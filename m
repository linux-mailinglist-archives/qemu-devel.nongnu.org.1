Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02798A4363B
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Feb 2025 08:37:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmpUv-0005vd-JX; Tue, 25 Feb 2025 02:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmpUd-0005sj-P1; Tue, 25 Feb 2025 02:36:41 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmpUa-0008DM-UL; Tue, 25 Feb 2025 02:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740468997; x=1772004997;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=T34SlHfKaqCquR0uLbmqWZL7AKE9Q9Hxkgq24e4Nj2Q=;
 b=RIm229Mf1ZOvPV/eQwC5uXj0G5+VyzRcrT/04chSfFMZNpFtmINHTxCP
 pYu2UVhSQbLDBpmXxJkgSI3Sf0m5CXIl0kbHssQG0N6UI8bUYPGBgfFPj
 RMzp3AnningWq2H87HTqe7xw/oZK0+nRo3oFyWNgf5l/JnkOmLljqI5Ii
 FuXEyi+RSk0TBgJkZ85DbgHH1vL09LjprVoSnEvJBrtOY91iTCBxTvw/S
 /9fpmOp9bwaGkT2CG+r8UU1xINVMAXhpssbxDuOoIO9F8GDaqlgHpFkX1
 JNc9q9Urxj5Se4FVPpfYBfY5Xwb6cj+qjUVRJy1HAmgYZXitnEtZPoYYh Q==;
X-CSE-ConnectionGUID: tYL/W3PbRH+BbFhPOCODjg==
X-CSE-MsgGUID: 8gdNTaAQR4CTOmynK8TNEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="45045974"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="45045974"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 23:36:35 -0800
X-CSE-ConnectionGUID: 8oOuoD0rRxy6YftZwXbF5Q==
X-CSE-MsgGUID: yVlb5Z7mTm+WVQXvMmZtrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="121277453"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 24 Feb 2025 23:36:32 -0800
Date: Tue, 25 Feb 2025 15:56:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 08/15] rust: timer: wrap QEMUTimer with Opaque<>
Message-ID: <Z713mocA7X+pGnol@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Fri, Feb 21, 2025 at 06:03:35PM +0100, Paolo Bonzini wrote:
> Date: Fri, 21 Feb 2025 18:03:35 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/15] rust: timer: wrap QEMUTimer with Opaque<>
> X-Mailer: git-send-email 2.48.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                |  7 -------
>  rust/qemu-api/src/timer.rs | 24 +++++++++++++++++-------
>  2 files changed, 17 insertions(+), 14 deletions(-)

Thanks!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


