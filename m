Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B66CB7325D2
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 05:24:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA03c-0000DP-0X; Thu, 15 Jun 2023 23:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qA03Y-0000CL-1x
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 23:23:24 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qA03V-0002FT-VQ
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 23:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686885802; x=1718421802;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nmp3WPXbX8yzSHlWPiFArAIGComLEPbWBjW0aJtF6zM=;
 b=Wkjy57jijb68wNlpPkI+Nc0YWsFXCXXXH9JaaLFNx7sEHkzbR5V98Fix
 UBFkJwj0FHyyK/qasld4FdvbivCUGvpmp8OKRU8iaXSsrOTwrcl3eLWvi
 jwLDQQi8hvXrWldieyqmTjIV5OqCityj1m+eXhDJR8fU13FBM7drup6ue
 3156mBKX8rcPNIaDYbYudSjU7AVLfA9c7ceG4OhnalphRSBuyXzaZu7up
 d/Es2BAJM/NLTbqRC3eGXDXld2LiK0n6SGKA2s+IG3Zh6b35/muPi84RZ
 RtlOUwfHsnmaWp6SZmeVvS2tQePDUR+nP6BY6nbgMP+stnmAK5NglbCyV Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="357979151"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="357979151"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 20:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715845979"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="715845979"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2023 20:23:17 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, lei4.wang@intel.com,
 qian.wen@intel.com, imammedo@redhat.com, tao1.su@linux.intel.com
Subject: [PATCH 1/7] target/i386: Add FEAT_7_1_EDX to adjust feature level
Date: Fri, 16 Jun 2023 11:23:05 +0800
Message-Id: <20230616032311.19137-2-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616032311.19137-1-tao1.su@linux.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=tao1.su@linux.intel.com; helo=mga04.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Considering the case of FEAT_7_1_EAX being 0 and FEAT_7_1_EDX being
non-zero, guest may report wrong maximum number sub-leaves in leaf
07H. So add FEAT_7_1_EDX to adjust feature level.

Fixes: eaaa197d5b11 ("target/i386: Add support for AVX-VNNI-INT8 in CPUID
enumeration")

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1242bd541a..e8a70c35d2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6778,6 +6778,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);
-- 
2.34.1


