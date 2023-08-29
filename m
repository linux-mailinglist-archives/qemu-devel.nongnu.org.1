Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 266CF78BD79
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 06:14:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaq6d-0007Xl-Rh; Tue, 29 Aug 2023 00:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qaq6a-0007XO-28
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 00:13:28 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qaq6S-0005uM-KQ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 00:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693282400; x=1724818400;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=W92ziKqzeadsvTd4nIPrSRSE0oZAOV7m+H+FE3P7yCA=;
 b=iuQcjFW9eR0WrTsgWpJaQmg2NfyT4vWxUPSeQ80A0TJONX7uuQNWkYre
 jUEzYV/E1c5qHBMbgOKycWeanzZgR3BCesZPYfpMXq+xv3XLK7YSSgvPE
 4kv0sbOJUbS24JfboC2Xf1a6rpGXPl3vH/UT8kuZF22VWZqDFoXbWsGMQ
 6YnmJhzHFQoeigLvDnNuN418BVjBBIt+hemcsBtDem6exkBtsK4kBYVWk
 uyplvphVFqVeZ0VyMPn4l2Wkh5Ibfp8U7O/V3SUhIy2MHkUB8fRpt/+AF
 iwpIrSzgM5ow/kAwcYZXLJz2OcG4f6LHG7ItRLq4OtbrN8yd3C4EytqRN A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="439220442"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; d="scan'208";a="439220442"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2023 21:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="862087866"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; d="scan'208";a="862087866"
Received: from pc.sh.intel.com ([10.238.200.75])
 by orsmga004.jf.intel.com with ESMTP; 28 Aug 2023 21:13:12 -0700
From: Qian Wen <qian.wen@intel.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, babu.moger@amd.com,
 Qian Wen <qian.wen@intel.com>
Subject: [PATCH v4 0/2] Fix overflow of the max number of IDs for logic
 processor and core
Date: Tue, 29 Aug 2023 12:24:03 +0800
Message-Id: <20230829042405.932523-1-qian.wen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31; envelope-from=qian.wen@intel.com;
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

CPUID.1.EBX[23:16]: Maximum number of addressable IDs for logical
processors in this physical package.
CPUID.4:EAX[31:26]: Maximum number of addressable IDs for processor cores
in the physical package.

The current qemu code doesn't limit the value written to these two fields.
If the guest has a huge number of cores, APs (application processor) will
fail to bring up and the wrong info will be reported.
According to HW behavior, setting max value written to CPUID.1.EBX[23:16]
to 255, and CPUID.4:EAX[31:26] to 63.

---
Changes v3 -> v4:
  - Add "Reviewed-by" from Isaku and Xiaoyao.
  - Rebase to the v8.1.0.
Changes v2 -> v3:
  - Add patch 2.
  - Revise the commit message and comment to be clearer.
  - Using MIN() for limitation.
Changes v1 -> v2:
  - Revise the commit message and comment to more clearer.
  - Rebased to v8.1.0-rc2.

Qian Wen (2):
  target/i386: Avoid cpu number overflow in legacy topology
  target/i386: Avoid overflow of the cache parameter enumerated by leaf
    4

 target/i386/cpu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

base-commit:f5fe7c17ac4e309e47e78f0f9761aebc8d2f2c81
-- 
2.25.1


