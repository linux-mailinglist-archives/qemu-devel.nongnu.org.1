Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6519574B10F
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 14:41:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHkl1-00014T-UO; Fri, 07 Jul 2023 08:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qHkkw-00012z-8l
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 08:40:14 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qHkko-0004WG-7y
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 08:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688733606; x=1720269606;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jo9j1gRD33r+fHtYkDrBTo2PvKobaddsXlgdzrd6/CI=;
 b=MktuqBtKe47GcGlPyQ6wx1JYriv4TFH2TyIfmxlZWzuWTmTePBjeDm9R
 nCyF+qnJKXj03QKcRwvSJaHCAw6BLGI6hMdLTm/eGwJ/iAb5NUu0qjcVm
 oyga6RjeePYYi8cD8+rjRlt9ohxvVLdBtXhnct6h6jFXG6DCHNiBr/4kP
 eQvt0BCR3ABUty4UyFazdhL361HIPTZt0n2c+pwEkmFjAbZ8QRlVuEAKu
 2pOBgJudq7i5FBhydDwPbHO8FE5px4Trc7YmNxTNV+dNopP4PeB7OZ9Ny
 5yBYr8RQGvJdIB41LCMvCdGLnqRFHoSe+RNrnMJ/zEIm137RWfJqnrHJq g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="366462427"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; d="scan'208";a="366462427"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2023 05:40:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="697228529"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; d="scan'208";a="697228529"
Received: from linux.bj.intel.com ([10.238.156.127])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2023 05:39:58 -0700
Date: Fri, 7 Jul 2023 20:37:53 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH v2 0/6] Add new CPU model GraniteRapids
Message-ID: <ZKgHIX7lKegQ1dIi@linux.bj.intel.com>
References: <20230706054949.66556-1-tao1.su@linux.intel.com>
 <20230707105237.74092-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707105237.74092-1-pbonzini@redhat.com>
Received-SPF: none client-ip=134.134.136.24;
 envelope-from=tao1.su@linux.intel.com; helo=mga09.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Jul 07, 2023 at 12:52:37PM +0200, Paolo Bonzini wrote:
> Queued, thanks.

Paolo, thanks!

> 
> Paolo
> 

