Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61158A3020F
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Feb 2025 04:15:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thgjh-0003lM-Ai; Mon, 10 Feb 2025 22:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thgjb-0003kq-Bd; Mon, 10 Feb 2025 22:14:51 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thgjZ-0001mN-HS; Mon, 10 Feb 2025 22:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739243690; x=1770779690;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vEMccvdUcs1wk/m5+iaF+9Mst+vCkUBq0NDrczoEjI8=;
 b=MJf+ixF950h9esUcrSNHOAi6JEQZlXdvX4A/VqtS8HKztvPjZyl8mRpc
 BawDhOJWf8iUry4CR+bWICERbiPhvtloaGwsjl3cL9RuKo7L/8/FYFKIn
 wj29nXnocPK/x3Zqz7JlkRs80FXjfjfSrsLWz1NAncMvaWEeIQZApXtfY
 7ZuPNPjZSYOgVU87AtoDX9cLTI0Y5Gib0/ypV8Ytt5dYwfdXYpW6wTK9D
 w15df8I4fcVkYSfT5T+VEHj+MJEJ68kHkRHFj6qLD9GKxmolfQhl6vxMg
 PJ8G3WmoJVQ3RfqBJ4xP5MYoO1AztXQkzuk1wa5HFF4PsW1fwELk28ivn g==;
X-CSE-ConnectionGUID: SnXnBoTeR5KDu9Z4z3qm4g==
X-CSE-MsgGUID: d4Fp5UaEQmC/jxXMMZXNrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39712882"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; d="scan'208";a="39712882"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 19:14:47 -0800
X-CSE-ConnectionGUID: MKBhmkeOTzCivtBCHGQ7oA==
X-CSE-MsgGUID: CAqb7YMETd6E7fQhbqEBag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="143281775"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 10 Feb 2025 19:14:45 -0800
Date: Tue, 11 Feb 2025 11:34:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 11/12] rust: chardev, qdev: add bindings to
 qdev_prop_set_chr
Message-ID: <Z6rFOEKtcx59L/PB@intel.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
 <20250207101623.2443552-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207101623.2443552-12-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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

On Fri, Feb 07, 2025 at 11:16:22AM +0100, Paolo Bonzini wrote:
> Date: Fri,  7 Feb 2025 11:16:22 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 11/12] rust: chardev, qdev: add bindings to
>  qdev_prop_set_chr
> X-Mailer: git-send-email 2.48.1
> 
> Because the argument to the function is an Owned<Chardev>, this also
> adds an ObjectType implementation to Chardev.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs |  1 +
>  rust/qemu-api/meson.build        |  1 +
>  rust/qemu-api/src/chardev.rs     | 19 +++++++++++++++++++
>  rust/qemu-api/src/lib.rs         |  1 +
>  rust/qemu-api/src/qdev.rs        |  9 +++++++++
>  5 files changed, 31 insertions(+)
>  create mode 100644 rust/qemu-api/src/chardev.rs
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


