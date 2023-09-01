Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2E878F848
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 08:00:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbxC3-0003sO-DK; Fri, 01 Sep 2023 01:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1qbxC0-0003hX-Lh
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 01:59:40 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1qbxBy-0003WI-GF
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 01:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693547978; x=1725083978;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kBJjgJUqdsnUFUfQUjqAeWVl/5i30fjbjZiEHQKmmFc=;
 b=DLvLu23viOTOmOMiYhLqnKZlp7ul0PMBXVpdpID65Eins3UeElAljriY
 pCq51U1lGYW2y1YU4fQdAy+OwKD9LCNum+BL3yLZTwljOoRb8rnXSaf93
 nPAOsmwdw8Vrva/upQ4xWpYDbtZiuJPdUX7biAtbz+WyxOzubLkkXkI7a
 9k3hbYTnHrNJglyGrjLgZ1PmVANNYCvdtHO2CedoqsVRAi7xW+XoIjiy0
 Fu/QAKwIPwJcQmJ/VVnE61Tz+UBsJKXC5cZW4d/bYgLqmWyOm6g1rZL5J
 6QJXJt595fxcksGq6ZePVZqMv+NAOchw0bkwb7amEVQ6j/fu8pMK0x8Sh A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356456638"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; d="scan'208";a="356456638"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2023 22:59:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="739816168"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; d="scan'208";a="739816168"
Received: from unknown (HELO fred..) ([172.25.112.68])
 by orsmga002.jf.intel.com with ESMTP; 31 Aug 2023 22:59:25 -0700
From: Xin Li <xin3.li@intel.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
 chao.gao@intel.com, hpa@zytor.com, xiaoyao.li@intel.com,
 weijiang.yang@intel.com
Subject: [PATCH 3/4] target/i386: enumerate VMX nested-exception support
Date: Thu, 31 Aug 2023 22:30:21 -0700
Message-Id: <20230901053022.18672-4-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901053022.18672-1-xin3.li@intel.com>
References: <20230901053022.18672-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=xin3.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Allow VMX nested-exception support to be exposed in KVM guests, thus
nested KVM guests can enumerate it.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3dba6b46d9..ba579e1fb7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1340,6 +1340,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             [54] = "vmx-ins-outs",
             [55] = "vmx-true-ctls",
+            [58] = "vmx-nested-exception",
         },
         .msr = {
             .index = MSR_IA32_VMX_BASIC,
-- 
2.34.1


