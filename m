Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D01886B4E3
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 17:28:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMjH-000468-H4; Wed, 28 Feb 2024 11:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMjD-00044p-V3; Wed, 28 Feb 2024 11:24:19 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMj7-0000qD-O8; Wed, 28 Feb 2024 11:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709137454; x=1740673454;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iXzFvZO4SYHHRPae3tgl32srVdfSkIO4ExeRw3/c9WQ=;
 b=ScMpkj13eCn23ALEUAhnCzj/0zFaf2KgX6qKROVejgMzi1qvVlQ67Tfg
 2nOEdCWVOV3XX4BKTWfhVzPClywaH+N7KoEzwnYkpAB69ZPHgPrn7V5Vi
 Hd4Wrh66/v+Q0L8b5GrVzl1dEP6aWIk/73iRzwOkE+WupPd7TxxJ8/Kmt
 D5xT//Dgz5ZKt0FCRj5Bk2c3pHM5g0LwmYjHb5rLqctPmOJJD4f1EeFPY
 JITZWckJp7VFasx20+F97LFgCkHZHd3SEY9zDfHDGfqaFrky8odZOEuVw
 WDEPVupxGIcPB9aRjL7gd9Uhth3+9NzlS5Nke1LZWg/wwd/RhnGCdyA8R g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="28982518"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="28982518"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 08:24:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="12144967"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 28 Feb 2024 08:24:09 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 08/16] block/qcow2: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Thu, 29 Feb 2024 00:37:15 +0800
Message-Id: <20240228163723.1775791-9-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is the pointer of
error_fatal, the user can't see this additional information, because
exit() happens in error_setg earlier than information is added [1].

In block/qcow2.c, there're 2 functions passing @errp to error_prepend()
without ERRP_GUARD():
 - qcow2_co_create()
 - qcow2_co_truncate()

Their @errp parameters are so widely sourced that it is necessary to
protect their @errp with ERRP_GUARD().

Therefore, to avoid the issue like [1] said, add missing ERRP_GUARD() at
their beginning.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 block/qcow2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 204f5854cff2..956128b40948 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3483,6 +3483,7 @@ static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
 static int coroutine_fn GRAPH_UNLOCKED
 qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 {
+    ERRP_GUARD();
     BlockdevCreateOptionsQcow2 *qcow2_opts;
     QDict *options;
 
@@ -4283,6 +4284,7 @@ static int coroutine_fn GRAPH_RDLOCK
 qcow2_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
                   PreallocMode prealloc, BdrvRequestFlags flags, Error **errp)
 {
+    ERRP_GUARD();
     BDRVQcow2State *s = bs->opaque;
     uint64_t old_length;
     int64_t new_l1_size;
-- 
2.34.1


