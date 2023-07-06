Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2AE749518
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 07:51:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHHso-0006xq-UM; Thu, 06 Jul 2023 01:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qHHsj-0006wo-2E
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 01:50:21 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qHHsf-0006KB-0n
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 01:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688622617; x=1720158617;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iJjod/zUFamMtHnABYJMTS1bsTAWH0fNIn4gFWuk3WE=;
 b=h/Syf28kECVSzI81q2pztHClavGfQ4kxhjYZpii3EXVIDFBqOiFdddPG
 xNKnhuon4YY2+hL7ER/k+cK8ToINOhesKFfzdwkOYuewyEFObcJYtfhof
 Z3t9pV27lOKoAXM1iZXY4e3H504JCKcrHp2MAgd9ajxcu5zQ7VsaDETrN
 tSThT/OPQw3m9JNwhRXDOyQV8tXkV4pbz8UkFZLXnMHgWUus4fcpMBs9Q
 S02aL0Q2wGGbvAMtzLeH6Xt0PewYLNb57Grmu3CF/0slcJnYomQpdkPjF
 2+946vahTSOLxu5goRvgB1aZ5CQl2UCHmhVB21B0CaaqlTOnrU1Tt3/1M Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="363540159"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; d="scan'208";a="363540159"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2023 22:50:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="863975929"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="863975929"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2023 22:49:53 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com, tao1.su@linux.intel.com
Subject: [PATCH v2 0/6] Add new CPU model GraniteRapids
Date: Thu,  6 Jul 2023 13:49:43 +0800
Message-Id: <20230706054949.66556-1-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.115;
 envelope-from=tao1.su@linux.intel.com; helo=mga14.intel.com
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

This patch series mainly updates SapphireRapids CPU model and adds new
CPU model GraniteRapids.

Bit 13 (ARCH_CAP_SBDR_SSDP_NO), bit 14 (ARCH_CAP_FBSDP_NO) and bit 15
(ARCH_CAP_PSDP_NO) of MSR_IA32_ARCH_CAPABILITIES are enumerated starting
from SapphireRapids, which are missed in current SapphireRapids CPU model,
so add a new version for SapphireRapids CPU model to expose these bits.

GraniteRapids is Intel's successor to EmeraldRapids, an Intel 3 process
microarchitecture for enthusiasts and servers, which adds new features
based on SapphireRapids. The new features can be found in [1].

---

Changelog:

v2:
    - Drop the same part of patch[2]
    - Drop EmeraldRapids CPU model
    - Change the commit messages to make these clear

v1: https://lore.kernel.org/all/20230616032311.19137-1-tao1.su@linux.intel.com/

[1] https://cdrdv2.intel.com/v1/dl/getContent/671368
[2]
https://lore.kernel.org/all/63d85cc76d4cdc51e6c732478b81d8f13be11e5a.1687551881.git.pawan.kumar.gupta@linux.intel.com/


Lei Wang (1):
  target/i386: Add few security fix bits in ARCH_CAPABILITIES into
    SapphireRapids CPU model

Tao Su (5):
  target/i386: Add FEAT_7_1_EDX to adjust feature level
  target/i386: Add support for MCDT_NO in CPUID enumeration
  target/i386: Allow MCDT_NO if host supports
  target/i386: Add new bit definitions of MSR_IA32_ARCH_CAPABILITIES
  target/i386: Add new CPU model GraniteRapids

 target/i386/cpu.c     | 172 ++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h     |   8 ++
 target/i386/kvm/kvm.c |   4 +
 3 files changed, 184 insertions(+)


base-commit: 2a6ae69154542caa91dd17c40fd3f5ffbec300de
-- 
2.34.1


