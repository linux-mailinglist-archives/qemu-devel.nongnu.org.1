Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07266B15DD7
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Jul 2025 12:09:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh3ho-0003Zy-Qm; Wed, 30 Jul 2025 06:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uh3dE-0000Sw-LJ
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:01:57 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uh3dC-0000F4-2C
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753869714; x=1785405714;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pCOmCsOy+y2dkE38felrYHXK6amxWRP2U7H+PFIb/VA=;
 b=EQn5nyrnc/CC/RlN2tuWSfVqa9jVPFjiW+JGfXcs3CnktCuiMca5x4cq
 MToJQMu72U97ARSYpSx5hFw87P68/9gaSWiQLJtOrLFIEgesSormFW1jA
 dWa8EcCiqHr7J0HYpSabVzqXKxemZp+jvytkotWXUI/jv/SJZxD44ZR04
 AmV3U89mIoU9UxOsG0dDkQuDljV9Jw5AP2xrMwQYFybKuO+Ko4pv07lk9
 zNyFWXK+/HDvit0tF18tMDPPMK0glTlFhXdssQj9YADvKVE08iA+uIUrj
 AbH46sRGn0HLRlP8NrVGi1AVnYuBi5Kd2otIdqqTT/JX/abzhC7DnB3vl g==;
X-CSE-ConnectionGUID: jDmMHicLSv+PzPs6fMXzhQ==
X-CSE-MsgGUID: FmK6xxCuSs+/h37Tp/F7dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="59992072"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="59992072"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 03:01:49 -0700
X-CSE-ConnectionGUID: Y5TkXXWfRhCj0sMrWdriHQ==
X-CSE-MsgGUID: 9nixQt7yS9q9JHPR0Su96Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="162971735"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 30 Jul 2025 03:01:47 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 0/2] i386/kvm: Enable SMM address space for i386 cpu
Date: Wed, 30 Jul 2025 17:52:51 +0800
Message-ID: <20250730095253.1833411-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.244, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Patch 1 enables the SMM address space i386 cpu under KVM.

Patch 2 gives name for each address space index.

---
changes in v2:
- collect Reviewed-by and Tested-by;
- fix typos and refine changelog;

Xiaoyao Li (2):
  i386/cpu: Enable SMM cpu address space under KVM
  target/i386: Define enum X86ASIdx for x86's address spaces

 accel/kvm/kvm-all.c              |  2 +-
 system/physmem.c                 |  5 -----
 target/i386/cpu.h                |  5 +++++
 target/i386/kvm/kvm-cpu.c        | 10 ++++++++++
 target/i386/kvm/kvm.c            |  7 ++++++-
 target/i386/tcg/system/tcg-cpu.c |  4 ++--
 6 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.43.0


