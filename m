Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FCC72E3F4
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 15:21:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q93wQ-0000cq-8q; Tue, 13 Jun 2023 09:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q93wI-0000bc-Qr
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:20:02 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q93wG-0006qD-O9
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686662400; x=1718198400;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=N0pEAGgj7hl33Q28PPttAftjSjowVftDqP6b6ibIa8U=;
 b=WBzhrf5PVwd4qF5KMTx+CnLsrwTEc81khuw/PIbhlGubfoWpVYlTGQNx
 bS/G6a9Nqw/huLR23Xd5HtSVePgKP4p9e6uOJ1iHvM63TiVhR5tBIwW8Q
 HQrCoYVajYwyiCKfpa8JVoRMXqjN1dP+ps0tOrQfMjUD88hXziUtDKpoP
 PzDwjX4j/Ee4QPOLpBAYFoqZW6+Eg7lfkQ6o3CBy3P2yMIBOtra34b3q7
 nxCqMJLRtAZy8ysxJsjSMfxDPl0s1oTu82l3Uxc6Mg1IcpI1eTUiY8IGa
 0w6FrgAyKxeemFwSueHOOALYj0yExLmbKtcTEJLHXn0uW76BMk7PrKWke g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361696797"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; d="scan'208";a="361696797"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2023 06:19:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="744680300"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; d="scan'208";a="744680300"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga001.jf.intel.com with ESMTP; 13 Jun 2023 06:19:51 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] i386: Minor fixes of building CPUIDs
Date: Tue, 13 Jun 2023 09:19:26 -0400
Message-Id: <20230613131929.720453-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
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

This v2 adds patch 3 to fix the build of CPUID leaf 7.

The issue that fixed by Patch 1 looks fatal though it doesn't appear on
KVM because KVM always searches with assending order and hit with the
correct cpuid leaf 0.

Patch 2 removes the wrong constraint on CPUID leaf 1f.

Changes in v2:
- Add Patch 3;
- rebase to latest master branch
v1: https://lore.kernel.org/qemu-devel/20220712021249.3227256-1-xiaoyao.li@intel.com/

Xiaoyao Li (3):
  i386/cpuid: Decrease cpuid_i when skipping CPUID leaf 1F
  i386/cpuid: Remove subleaf constraint on CPUID leaf 1F
  i386/cpuid: Move leaf 7 to correct group

 target/i386/kvm/kvm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)


base-commit: fdd0df5340a8ebc8de88078387ebc85c5af7b40f
-- 
2.34.1


