Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A4775C0DF
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 10:08:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMlBT-0001JZ-1K; Fri, 21 Jul 2023 04:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1qMlBQ-0001IY-CW
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 04:08:16 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1qMlBK-0001Wg-OJ
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 04:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689926893; x=1721462893;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/OYZ19T4NsHwtnyFGXtVmXpxXXS9RolHwNWIFpnjuYw=;
 b=TCahKwcjmiS85km/0gV4FD9vc09uCXoL6LqYgQxRcqpBkqKMvZaBwlCp
 Vp2mpdt0NS3EMwTRkhyYmKoe68aYAhciceFV6nJ9uBThYRsDKZlFeU3On
 13dRSS2Wqz1zqy+bnpeJ5zUiiI8wc8hgZHmET1ADe01Num3NqhUqESF4I
 o0QW4cjGz6dNwUDT3SjgLMvMm24P79dKiQsztzX4y/GAiqQWQ3phsDNOW
 3gWkckoFzolHgoO7PLQQn1opb0i6+1kWieoHa12mfhzoNt1EP/CaMsk26
 F0+2EtE53sjCCw3zKZfnfU4SJ9rvaaUk+hFGKm+7IgBYL2TkwJlNhjpES g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346557448"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; d="scan'208";a="346557448"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2023 01:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="724781735"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; d="scan'208";a="724781735"
Received: from binbinwu-mobl.ccr.corp.intel.com ([10.238.9.27])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2023 01:08:04 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, chao.gao@intel.com,
 robert.hu@linux.intel.com, binbin.wu@linux.intel.com
Subject: [PATCH v3 0/2] target/i386: add support for LAM
Date: Fri, 21 Jul 2023 16:07:58 +0800
Message-Id: <20230721080800.2329-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.136;
 envelope-from=binbin.wu@linux.intel.com; helo=mga12.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
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

When the feature is virtualized and exposed to guest, it can be used for 
efficient
address sanitizers (ASAN) implementation and for optimizations in JITs and 
virtual
machines.

[1] Intel ISE https://cdrdv2.intel.com/v1/dl/getContent/671368
    Chapter Linear Address Masking (LAM)

---
Changelog
v3:
- Some change in commit message.
- Add handling of LAM control bits. (Xiaoyao)

v2:
- https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07842.html


Binbin Wu (1):
  target/i386: add control bits support for LAM

Robert Hoo (1):
  target/i386: add support for LAM in CPUID enumeration

 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.25.1


