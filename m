Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA66E72E3F2
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 15:21:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q93wN-0000cT-7b; Tue, 13 Jun 2023 09:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q93wI-0000bb-Mi
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:20:03 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q93wG-0006qJ-OA
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686662400; x=1718198400;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pNFH4JwPCYF8TBeuPI1XWTw8Bh3QnsIP8OvvAgHWW74=;
 b=lvrF9/FxUv++Kc2o+jf3hg5yGxPkxuCmhPwk6yg5HjeNCjTBYAraZKna
 TvklHN4BIORyxB5jBZSh5wubm8PLt7Wmt2LYDIBYxQUOuuIkDSAR8tud8
 NgNdVDYAe3ul38a5pT005fXTo0rO5wQEX2UCWdmTD1/h97CQIggdiwkgP
 rQPuFpIs8ZJ/qfBFb3MWJIQ47ZRbcqKkMn82OtN62/h8OFXH9XN7vXzQp
 xdr30t4qT3GFfzcoLlohL5f+zKkqE23MJ3sXZqaGtSZYM+g0DAiCMzd93
 BdQ97gDDMXWvZnotkvbgfWERW0BukOe+sEhIHhSOIyqvSeDsgZGFkX0PS g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361696807"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; d="scan'208";a="361696807"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2023 06:19:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="744680318"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; d="scan'208";a="744680318"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga001.jf.intel.com with ESMTP; 13 Jun 2023 06:19:52 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] i386/cpuid: Decrease cpuid_i when skipping CPUID leaf
 1F
Date: Tue, 13 Jun 2023 09:19:27 -0400
Message-Id: <20230613131929.720453-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613131929.720453-1-xiaoyao.li@intel.com>
References: <20230613131929.720453-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=xiaoyao.li@intel.com;
 helo=mga03.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

Decrease array index cpuid_i when CPUID leaf 1F is skipped, otherwise it
will get an all zero'ed CPUID entry with leaf 0 and subleaf 0. It
conflicts with correct leaf 0.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index de531842f6b1..afa97799d89a 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1956,6 +1956,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
         case 0x1f:
             if (env->nr_dies < 2) {
+                cpuid_i--;
                 break;
             }
             /* fallthrough */
-- 
2.34.1


