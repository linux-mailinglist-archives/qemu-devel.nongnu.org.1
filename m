Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDC0708E1B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 05:07:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzqS4-0001BN-LM; Thu, 18 May 2023 23:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yang.zhong@linux.intel.com>)
 id 1pzqS1-0001BF-G1
 for qemu-devel@nongnu.org; Thu, 18 May 2023 23:06:41 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yang.zhong@linux.intel.com>)
 id 1pzqRz-00024G-AT
 for qemu-devel@nongnu.org; Thu, 18 May 2023 23:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684465599; x=1716001599;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WqP8SaooeeILRj3gi9sPt85eCjJfCx4rhanC9WdZ4JI=;
 b=GVjB+GLvO/ga3jlNhbMVFmBFVgprMH+3FT+ieugUCT7Pul7qPYkKqO6W
 Orc2zV1yuU0+00GUQbSt30fkVrdAIWU5pYVQdZjz5sHNlcMnhYDXlvSM/
 Q23t2FYapyj2gNAcXcDp9OOD18S7foyW2WhGQB1Q/13H3CQ8g83SteMQU
 l53BXOW013t2n5Ty+1BRSRs8WZno2FBzdDn+EwCHmz2bDdu6b//PROIJ9
 q/xaGAVH0d11W8KjIrE5KEJu9JhRwBii2FDkDzpHCXWuOCn+5zsTzVKQm
 ucTbsTeCciSCFxGZIjdLYk+EPk8vcOI84EDthrJcHc8EBLcZhFhil7Iiy w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336856080"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="336856080"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 20:06:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="702372145"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="702372145"
Received: from yangzhon.bj.intel.com (HELO yangzhon) ([10.238.157.60])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 20:06:34 -0700
Date: Thu, 18 May 2023 23:06:23 -0400
From: Yang Zhong <yang.zhong@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/68] i386, build system, KVM changes for 2023-05-18
Message-ID: <ZGbnrwKTTO1PsDhT@yangzhon>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
Received-SPF: none client-ip=134.134.136.126;
 envelope-from=yang.zhong@linux.intel.com; helo=mga18.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Paolo, please help add below queued sgx fix into this PULL request, which was
missed from last time, thanks a lot!
https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg00841.html
https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg00896.html

Regards,
Yang

