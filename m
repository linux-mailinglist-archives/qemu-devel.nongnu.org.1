Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C3672E3F5
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 15:21:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q93wQ-0000ea-G3; Tue, 13 Jun 2023 09:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q93wJ-0000bt-Sk
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:20:03 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q93wG-0006qP-O9
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686662400; x=1718198400;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hfFgdff8XTWie2hZuUxnhjyHznpzx7DqvvjD22d3hG0=;
 b=jo5DaGS7pesLxP2Ix7Bgl8T9G6UqiKv1WVD9MPtt7KuQUteMqjFcaOYn
 UovAL0hcBIzI/XTNeqxKexUTd09+Od+zFhWnBbAzfu/tItKGkqvm0TB2I
 eOxH6EDbamZAGMHaN7Wb1V+LeVOteO9PVI5AFb3CyVPOcUKITjkJLCjI5
 WpI2c1lgk3hWguJc8cXtaO+bQ4yJBVH1SvafixFb0HPUjPXIRQuqaEi2Q
 TRFXQRBp3cR+kY6TY5HQwzUmVJH5CD6S+ngQw845h/7HBhRaiwBcfjnae
 zXjiVPNPBflxhyozq0bKZb4qIsS5Pp+7TOy8tS5seroqOfLQk6+TsQfyF A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361696813"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; d="scan'208";a="361696813"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2023 06:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="744680338"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; d="scan'208";a="744680338"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga001.jf.intel.com with ESMTP; 13 Jun 2023 06:19:53 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] i386/cpuid: Remove subleaf constraint on CPUID leaf 1F
Date: Tue, 13 Jun 2023 09:19:28 -0400
Message-Id: <20230613131929.720453-3-xiaoyao.li@intel.com>
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

No such constraint that subleaf index needs to be less than 64.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index afa97799d89a..d7e235ce35a6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1968,10 +1968,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
                     break;
                 }
 
-                if (i == 0x1f && j == 64) {
-                    break;
-                }
-
                 c->function = i;
                 c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
                 c->index = j;
-- 
2.34.1


