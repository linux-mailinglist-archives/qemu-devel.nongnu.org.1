Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E4FA43880
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Feb 2025 10:01:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmqnl-000279-Cl; Tue, 25 Feb 2025 04:00:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmqni-00026q-F1; Tue, 25 Feb 2025 04:00:26 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmqng-00012e-E0; Tue, 25 Feb 2025 04:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740474024; x=1772010024;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xWI8T+q8rb3C7FgAT/yj9F9cOxxEafVfjKUGomPew68=;
 b=nox2e7x0s85/aufW+SCUJRLyHpaZDjIygIidP4PCpyHv68gyJpLmZJ4K
 qRECwOS7JPLd2uxSSWPFQmmo9WMWuMSSu1P4BVVr7VSRu7v2SL6dWjjfj
 0GoBnaCpGDRQF19zf6WMH1peL+r+i+m2RYeJ/g0j19Uk+ramqOZpC7YxM
 /lA3ZhU+CTCwfgUKBg4/006v7B/bdk3r4cq9g0rg2aL82qev7zCimUd8/
 3RXpDFzUlXLIZbvV+UqrnEByiVxidRI/NMj1TQKMz4+CWaoaq3G0Biido
 BGoMOQr7urj77i2JlOKVJp6eJxjKvX0LdYDAT/EVon/aEb4IpVPWdzRx3 Q==;
X-CSE-ConnectionGUID: KEK4VnyGS+G1twygOq9RLQ==
X-CSE-MsgGUID: anBdQl/RQ36UHqTXFuz/8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41525097"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="41525097"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 01:00:17 -0800
X-CSE-ConnectionGUID: yVNsP/j1Q92kJPIZyMQDfA==
X-CSE-MsgGUID: IohBt4OiRUWE6MpC+HRHuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="116527942"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 25 Feb 2025 01:00:17 -0800
Date: Tue, 25 Feb 2025 17:19:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 14/15] rust: chardev: wrap Chardev with Opaque<>
Message-ID: <Z72LOYowebz77E/+@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-15-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-15-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
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

On Fri, Feb 21, 2025 at 06:03:41PM +0100, Paolo Bonzini wrote:
> Date: Fri, 21 Feb 2025 18:03:41 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 14/15] rust: chardev: wrap Chardev with Opaque<>
> X-Mailer: git-send-email 2.48.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/bindings.rs | 3 ---
>  rust/qemu-api/src/chardev.rs  | 8 ++++++--
>  rust/qemu-api/src/qdev.rs     | 1 +
>  3 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


