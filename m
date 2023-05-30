Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3389971594F
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:03:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vG6-0002OU-36; Tue, 30 May 2023 05:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q3vG1-0002IW-OO
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:03:11 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q3vFy-0006CU-Pa
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685437386; x=1716973386;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+TmCxefQKRIrt8k9oFemqoVFUq1O/M97sDrE4mCJ6Eg=;
 b=NsxjctilHtAJfrz6Y0CBNxATHOqmLIIyBx3JY1U7r3Burp7d7xh5od50
 rnFHaVBAyWJtw5OcdGFVJxLpYTHDvZ4hQU/dBw6YyTgvghUjn6Ol7ojpv
 hUutrpk1Nlvk02uAZZHaPFBjluLMypVcnaN4EzbNPLcE1Wv1Pye6xQvgb
 wrTSwwdj+AP8IN/Yec/eL5j+kgTiVxTvtSxCu+FHVcBjikgznufj3LthD
 glpTdMERtPf+71ZSwt2S7IKilCQaYYiYnSX2/6oAXTZWo/3FdNyHUTQT9
 1W1BuIVjGmt4GeppJRKx/8JjuZcP75xvJhLcNcMT627V5liCjFYcyfmTc Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="358110377"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="358110377"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 02:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739435454"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="739435454"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
 by orsmga001.jf.intel.com with ESMTP; 30 May 2023 02:03:02 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: quintela@redhat.com,
	peterx@redhat.com,
	lei4.wang@intel.com
Cc: qemu-devel@nongnu.org,
	Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v2 0/2] Enfore multifd and postcopy preempt setting
Date: Tue, 30 May 2023 17:02:57 +0800
Message-Id: <20230530090259.189462-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=wei.w.wang@intel.com;
 helo=mga03.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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

Wei Wang (2):
  migration: enfocre multifd and postcopy preempt to be set before
    incoming
  qtest/migration-tests.c: use "-incoming defer" for postcopy tests

 migration/options.c          | 36 +++++++++++++++++++++++++++++++-----
 tests/qtest/migration-test.c | 10 ++++++++--
 2 files changed, 39 insertions(+), 7 deletions(-)

-- 
2.27.0


