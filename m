Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 067BAA422E8
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Feb 2025 15:25:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmZN7-0001qf-Gp; Mon, 24 Feb 2025 09:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmZN3-0001q9-4R; Mon, 24 Feb 2025 09:23:45 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmZN1-0004h3-3y; Mon, 24 Feb 2025 09:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740407023; x=1771943023;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=F63oDHIOkTzajWN5/wlB/GDNtKR4H5i+yJtuQGFW2zI=;
 b=JfjG8J4vj4r09FXfYpHODF5Fba6vmwx4I5D+BWAmUb+1bVAhQsj0wk+l
 Viu/sq5qNT74DhF1r9gq5GZIcrmBrZiI4+3cY00L7KEweavdsak9k9OS9
 nE1QKeA7p5V8rqewsE3VkyqiCQCvy3p0WWxSoBkBNp7O/6U37sxPIBPGa
 kqTZws9OAF5dtw1nm5c30FtyplJLXdPYJgEnTCxE3xXrvvi+VuSeSxOnZ
 H/c5CqWFBv8cCTT0SRVTDsBja/uQ86BjAw1h3oawnBODX9LvuYTa5yafW
 ekj49lt1vRw+X5siGFTrSdiGUYUFzzIXPZPdV6Gfcg8SmoSPtb1hFbMck Q==;
X-CSE-ConnectionGUID: nFIGPLUORGyxRM8zcwHLlg==
X-CSE-MsgGUID: TACspP4+RuqcVP67yN7UIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="66533870"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="66533870"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 06:23:38 -0800
X-CSE-ConnectionGUID: e5CMqHvaT/uCSTAATttmvQ==
X-CSE-MsgGUID: 7t89qivjQ4emw+HVQXg9OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="121035133"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 24 Feb 2025 06:23:35 -0800
Date: Mon, 24 Feb 2025 22:43:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 01/15] rust: add IsA bounds to QOM implementation traits
Message-ID: <Z7yFfCZiBzf067m7@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Fri, Feb 21, 2025 at 06:03:28PM +0100, Paolo Bonzini wrote:
> Date: Fri, 21 Feb 2025 18:03:28 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 01/15] rust: add IsA bounds to QOM implementation traits
> X-Mailer: git-send-email 2.48.1
> 
> Check that the right bounds are provided to the qom_isa! macro
> whenever the class is defined to implement a certain class.
> This removes the need to add IsA<> bounds together with the
> *Impl trait bounds.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/qdev.rs | 2 +-
>  rust/qemu-api/src/qom.rs  | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


