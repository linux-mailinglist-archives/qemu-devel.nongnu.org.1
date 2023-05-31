Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEB6717335
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 03:34:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Ai3-0001QT-3k; Tue, 30 May 2023 21:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1q4Ai0-0001Kt-6v
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:33:04 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1q4Ahy-0006ky-5I
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685496782; x=1717032782;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DO5x2+DWGEXbWvKLRfxQOweivEb6sDShmIWAaT0myJE=;
 b=ST6okmg5UiKC94OH89hxhIceVE/jYHYvXDTA7Iwfb9qoM9oqx9QTe3vj
 SO2WkXiC4CTxKQsMohCp/dnrpVg4BWTbDt7uKMv/2pwCFt38nd4vZUEik
 b1P862pBTyVUrl6tl8UxEWg0k/mMPI7DsH4Bf9fhTSokfK0FlYry/+WOm
 MAIzsEJmpXIBhbszJ068BlliI8PKCErOxhd3gboRHRHkjkc5MSC7a4PH/
 3OoDG4pyu+YpfO2/SmgHDzPm6/LtEzuV0T1Cfo5GRiNc23eoN5OpvRW2Q
 leGeG2gqL70u55XoNg1EhelNrbaWV4Caf7KWX6R3+PRQOHbek8nAy5RYC A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="420861862"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="420861862"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 18:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="851024449"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="851024449"
Received: from binbinwu-mobl.ccr.corp.intel.com ([10.255.31.25])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 18:32:56 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, chao.gao@intel.com,
 robert.hu@linux.intel.com, binbin.wu@linux.intel.com
Subject: [PATCH v2 0/1] target/i386: add support for LAM in CPUID enumeration
Date: Wed, 31 May 2023 09:32:49 +0800
Message-Id: <20230531013250.18311-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=binbin.wu@linux.intel.com; helo=mga07.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

Linear-address masking (LAM) [1], modifies the checking that is applied to
*64-bit* linear addresses, allowing software to use of the untranslated address
bits for metadata and masks the metadata bits before using them as linear 
addresses to access memory.

When the feature is virtualized and exposed to guest, it can be used for efficient
address sanitizers (ASAN) implementation and for optimizations in JITs and virtual
machines.

[1] Intel ISE https://cdrdv2.intel.com/v1/dl/getContent/671368
    Chapter Linear Address Masking (LAM)

---
Changelog
v2:
- Add macro of CPUID definition for LAM bit

v1:
- https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg08036.html


Robert Hoo (1):
  target/i386: add support for LAM in CPUID enumeration

 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)


base-commit: 51bdb0b57a2d9e84d6915fbae7b5d76c8820cf3c
-- 
2.25.1


