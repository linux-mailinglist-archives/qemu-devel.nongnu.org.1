Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09293B5285E
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Sep 2025 07:55:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwaFl-0007Xc-LH; Thu, 11 Sep 2025 01:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwaFi-0007XC-Dw
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 01:53:50 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwaFf-0007os-Ov
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 01:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757570028; x=1789106028;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mOn25/OBJNKIXzgR0y+Cm3b4G0mwgLyRQad5q69Yfow=;
 b=AVgrlxuX6vhm30DjGqkqDHG+UyjoHapCf1G2cboOiAezDQFyRqkRZpcv
 +yxo2b6vcaeg0S5YmbwHvPtHFJDQ+NoJ14OXP4Aw5Jr9CafMqAUoIck9w
 aa1XakSkXLDvUQhJkoe4+aXfKW2iLqXkcH0BRzqKLVTbx73gHg6RvcE4Y
 J2HiYZshQEgU8gsyIal4Px/Ht99Zv6zafc5ZIBeINLudclSbN4bDvSebq
 /8GqWvYSnRKpUWQjsK1h9+iFgxpSlj90rtNGKkP5SBPH/Yp5hNFlf5uYX
 LYKLJlU6X7Ua76ncPitcJgvyg82v8p/cEo1ZFVdT6uKNQ/txtWbFAbjhP g==;
X-CSE-ConnectionGUID: j4cPKqxzTO2SOR8UcFu7rQ==
X-CSE-MsgGUID: 9p4CV6CaQD+OukLD/wgCVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="63720085"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; d="scan'208";a="63720085"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2025 22:53:44 -0700
X-CSE-ConnectionGUID: ebmq/tCnTNeeI3rH54U6Yw==
X-CSE-MsgGUID: 41FAp1AqQVmyrqCPbxZBxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; d="scan'208";a="173985090"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 10 Sep 2025 22:53:42 -0700
Date: Thu, 11 Sep 2025 14:15:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 05/33] rust: use inline const expressions
Message-ID: <aMJpBnrhXRrM0YGQ@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908105005.2119297-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Sep 08, 2025 at 12:49:37PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:37 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 05/33] rust: use inline const expressions
> X-Mailer: git-send-email 2.51.0
> 
> They were stabilized in Rust 1.79.0.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst            |  9 +++------
>  rust/qemu-api/src/callbacks.rs | 27 +--------------------------
>  rust/qemu-api/src/chardev.rs   |  2 +-
>  rust/qemu-api/src/qdev.rs      |  2 +-
>  rust/qemu-api/src/timer.rs     |  2 +-
>  rust/qemu-api/src/vmstate.rs   |  2 +-
>  6 files changed, 8 insertions(+), 36 deletions(-)
> 
> diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
> index e0ee4a9837d..98e3a33a3ce 100644
> --- a/docs/devel/rust.rst
> +++ b/docs/devel/rust.rst

...

> @@ -97,9 +94,9 @@ patches are welcome:
>    before QEMU can use them.  For now, there is special code in
>    ``util/error.c`` to support non-NUL-terminated file names.
>  
> -* associated const equality would be nice to have for some users of
> -  ``callbacks::FnCall``, but is still experimental.  ``ASSERT_IS_SOME``
> -  replaces it.
> +Associated const equality would be nice to have for some users of
> +``callbacks::FnCall``, but is still experimental.  Const assertions
> +are used instead.

nit: this format seems broken - this sentence should be after bullet.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


