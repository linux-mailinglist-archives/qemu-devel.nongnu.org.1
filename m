Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B4FB03ADC
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Jul 2025 11:33:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFXm-0002mk-Lr; Mon, 14 Jul 2025 05:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubFTi-000124-2Q
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:28:16 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubFTf-0003Dn-Mg
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752485283; x=1784021283;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NrIhWxqy9lKt6T5ujqxvWeG+V9B4bH3HdX3IyDcpYNo=;
 b=YabvIDHhNbI5JPIWCKtbOZIsQs+R7O+AcS9WnPye1Z6W45WVKAcfbVQr
 4uRn2vf8kxa2Nx47k3E0RPTZ4qmyCvUF4q/vCnw8AD+IWhNlSt6sJ8LWA
 ltapquhk6pDvNgOoGAtQBicl9Lj3EygJ9OMhRseTx1k7MAyF5KGI0Kvy/
 bi3CgxTqn3JPclMc/9WWIsQ5GmNgvJv19vljEe7O/917vis8V9t0MhISI
 GCJDxP5tWmcexbbYqNV21tip9cuS90hiqLVF0ZsWNhqtlq/GeKf9dDIgJ
 9EOA7s+9ExS3XeaLP6IGpi7znNSat2kfBwC9/cN56XjNOm54ls75oLsA8 A==;
X-CSE-ConnectionGUID: 0K25RqcCTQCMrZ7YM4yT4w==
X-CSE-MsgGUID: d3DOerbGQJ+qvwCrmZcLTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66029259"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="66029259"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 02:28:00 -0700
X-CSE-ConnectionGUID: sfn6FLUxTOW+yvUW3aJhaQ==
X-CSE-MsgGUID: yvTMClA/RRaewYeA4wUcgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="187882723"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa002.jf.intel.com with ESMTP; 14 Jul 2025 02:27:59 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 0/5] qemu-optios: Fix, cleanup and add description of tdx-guest
Date: Mon, 14 Jul 2025 17:19:48 +0800
Message-ID: <20250714091953.448226-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Patch 1 is the fix to generated doc html.

Patch 2-4 are the cleanup of memory-encryption

Patch 5 add description of tdx-guest.

Xiaoyao Li (5):
  qemu-options: Move sgx-epc options from "M" to "machine"
  i386/sev: Remove the example that references memory-encryption
  qemu-options: Change memory-encryption to confidential-guest-support
    in the example
  qemu-options: Add confidential-guest-support to machine options
  qemu-options: Add description of tdx-guest object

 qemu-options.hx   | 66 ++++++++++++++++++++++++++++++++++++++---------
 target/i386/sev.c |  4 ---
 2 files changed, 54 insertions(+), 16 deletions(-)

-- 
2.43.0


