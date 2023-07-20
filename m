Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E491A75B118
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 16:21:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMUVu-0000xj-Ex; Thu, 20 Jul 2023 10:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1qMUVU-0000sV-Fg
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:19:53 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1qMUVS-0004Ur-9d
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689862789; x=1721398789;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aJKqAgRWdUOMC97LhTdm7nitnjY3ECOh03U/NV5Ta9A=;
 b=LLW4ukoHOjt27oJvhgndg9X8+w6i/A58le924na9Yhs4Ei6Q6Hal5TmH
 f698hNpWjPlcJZTNDrS6OhtF8Af5v1iwPqtRESPQqWab4T58oklCR+sJQ
 Qo27zV4X8J/x8Pe0Ju0wsvd0FdmPx29NEyC73l9/Rj9S9BgWCJMEpeOOy
 4ERV0C2+8kg1A3Jt97rBGxnkOfDi25TGWR+su8bA2ARwgWY12Fczzhkan
 5jIm/jWyocS7Li/4bbIhahqKD7WnYXwBvyp4+IPdQ4/jhNEjuYnHYhmep
 IE4HxP34OgFFyFEzOQdZ/QnDNtIdlbcr7wedeszwgvk7EQardz5csz5S9 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="397629154"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; d="scan'208";a="397629154"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2023 07:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898295616"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; d="scan'208";a="898295616"
Received: from embargo.jf.intel.com ([10.165.9.183])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2023 07:19:29 -0700
From: Yang Weijiang <weijiang.yang@intel.com>
To: pbonzini@redhat.com, mtosatti@redhat.com, seanjc@google.com,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	weijiang.yang@intel.com
Subject: [PATCH v2 0/4] Enable CET userspace support
Date: Thu, 20 Jul 2023 07:14:41 -0400
Message-Id: <20230720111445.99509-1-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=weijiang.yang@intel.com; helo=mga01.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

CET virtualization requires VMM userspace setup for CET feature
bits enumeration, this series enables all related settings.

Guest CET user and kernel mode SHSTK/IBT are both supported.

Changes in v2:
1. Added supervisor CET states support.
2. Consolidated all CET states in a struct of vmstate.

v1 link:
https://lore.kernel.org/all/20230421041227.90915-1-weijiang.yang@intel.com/


Yang Weijiang (4):
  target/i386: Enable XSAVES support for CET states
  target/i386: Add CET MSRs access interface
  target/i386: Add CET states to vmstate
  target/i386: Advertise CET related flags in feature words

 target/i386/cpu.c     | 54 +++++++++++++++++++++++++++++----------
 target/i386/cpu.h     | 41 ++++++++++++++++++++++++++++++
 target/i386/kvm/kvm.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/machine.c | 28 ++++++++++++++++++++
 4 files changed, 169 insertions(+), 13 deletions(-)


base-commit: a342ce9dfeed8088c426e5d51d4a7e47f3764b84
-- 
2.27.0


