Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9B9723F34
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:19:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Tmd-000071-Ki; Tue, 06 Jun 2023 06:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q6Tma-00005r-RH
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:19:21 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q6TmZ-0007NG-00
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686046759; x=1717582759;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=d2+g7qcB7etx1m/vdSDNzEYqB5iTSyIZgMf0TAZz6YQ=;
 b=LSPq4bsQHrsXyDb1eCyiRBowa3kYw/BxaG/d4to2p7Bq3FP7ae/g82uy
 tXmbkG1PeEgdDL9Pk1EtUA6NH6f0d8q0SMvOqsEUyMFK+4VwGuJlFZk4t
 CkGg5os3LzVCfxBUPDTBIhb8snFJyN4RK9DLqqmUzEhahkdjwmaiHTsSf
 VvmOcNbUnL3tm7BDYdz/9pvKyJy2yBk1Xxq8/Ykempwgq7oB4GhoqL/4i
 6KCRS/hnnGVpUufb5IVAvOT9EnfQz31uvQmHVRZ/687tGwdzIn3kw0isJ
 5An3C/j5hbE62ukoknjQMBpNq3ej8to2LMY7/4BwJRQvJp36GOkezS8Cq w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="443004167"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; d="scan'208";a="443004167"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2023 03:19:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="709032910"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; d="scan'208";a="709032910"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
 by orsmga002.jf.intel.com with ESMTP; 06 Jun 2023 03:19:13 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: quintela@redhat.com,
	peterx@redhat.com,
	lei4.wang@intel.com
Cc: qemu-devel@nongnu.org,
	Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH RESEND v2 0/2] Enfore multifd and postcopy preempt setting
Date: Tue,  6 Jun 2023 18:19:08 +0800
Message-Id: <20230606101910.20456-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=wei.w.wang@intel.com;
 helo=mga05.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Setting the cap/params of multifd and postcopy preempt is expected
to be done before incoming starts, as the number of multifd channels or
postcopy ram channels is used by qemu_start_incoming_migration (to
listen on the number of pending connections).

Enfocre the cap/params of multifd and postcopy preempt to be set
before incoming. If not, disable the feature and return with error
messages to remind users to adjust the commands. Fix the
qtest/migration-test to do so.

v2 RESEND change:
- Only patch commit change with more explanations

Wei Wang (2):
  migration: enfocre multifd and postcopy preempt to be set before
    incoming
  qtest/migration-tests.c: use "-incoming defer" for postcopy tests

 migration/options.c          | 36 +++++++++++++++++++++++++++++++-----
 tests/qtest/migration-test.c | 10 ++++++++--
 2 files changed, 39 insertions(+), 7 deletions(-)

-- 
2.27.0


