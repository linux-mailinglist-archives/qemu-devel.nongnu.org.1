Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA5CA3957C
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Feb 2025 09:34:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkJ2X-0004nB-00; Tue, 18 Feb 2025 03:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkJ2U-0004mS-S0; Tue, 18 Feb 2025 03:33:10 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkJ2S-0002a2-D4; Tue, 18 Feb 2025 03:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867588; x=1771403588;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Oy4o/5QqzkOOJZntuC8UraATNOghv87gR7WxkdfsV88=;
 b=SpL7bAmrmnTlolepFwz+Haow/m/9MD9zvLqkQhcdfADYzErTzSkBEMIR
 UdaSZbgL5A1selVYFsS/uRZrEWPfGd00z5Ho1wnx0/8R7lW9RKfxUwjpY
 e+w6EaZ9D69z044dL2od2k6l4/+UdwGiTmUUcZwxAhFkXRLnvdTg4gv9B
 zKjLyCydzydmIEL4BZnzIsVSNh89x3MqXZY4U/uxOZeW53L6yUP67rNN/
 YHSKhF0pR5wlJDffXDEjwoTa2NtEsGw7J1I9e+dsSed9Yv481TA5fO3yL
 v1uF/C4z3M9CATIvzLYEHmTpaTYgIq4C6eeLPZl7s3RSSoPkLOXycqJ26 w==;
X-CSE-ConnectionGUID: mqs6gmaESR2xqkoyhAcKbw==
X-CSE-MsgGUID: C6ZIdl7FTgaY98NpMTYG6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="28151559"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="28151559"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:33:05 -0800
X-CSE-ConnectionGUID: OFddgGyXSqmrEBKPndL7ww==
X-CSE-MsgGUID: ghqW2pMNQzKT0kRZA/opXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119536540"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 18 Feb 2025 00:33:04 -0800
Date: Tue, 18 Feb 2025 16:52:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] docs: rust: fix typos
Message-ID: <Z7RKVpvgffMeF9CM@intel.com>
References: <20250218080458.426402-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218080458.426402-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

On Tue, Feb 18, 2025 at 09:04:58AM +0100, Paolo Bonzini wrote:
> Date: Tue, 18 Feb 2025 09:04:58 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] docs: rust: fix typos
> X-Mailer: git-send-email 2.48.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


