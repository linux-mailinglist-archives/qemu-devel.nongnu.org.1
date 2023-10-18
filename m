Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6537CDC33
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:47:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt5vr-0007Nq-0H; Wed, 18 Oct 2023 08:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qt3Bf-00068T-Nw
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:50:02 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qt3BQ-0004Ob-Mo
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697622584; x=1729158584;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rXT6Mlyo8nMUo+Xa/LhY3Ep4TFB4IYJ1y3RgX521rUk=;
 b=eIsFy0+g6TYkerDbTcxYfbuF0ecbGK2B4Dta7i0m8mx4XQa5cbd/lKzq
 fz7AH8QXH5lOzRxXKO81aVVr2jlF7bqIWg/43EpGsEgEodgj+moShaTmg
 xKE7dBySdvoHJDaZDAsOSH62DWiLqOXG1gjfpy2PCS6qJL3JB6vis9ODR
 qM2sIXncOrKz0qKkrovc1wvxwBkcJfpDeZS54SDAU7oax797fVVOXovtN
 a8rmXbjcRzgDq35RkfvOkNHX2MLqwT9Nl6oB4d6BFYlDHuyuaMSomGVMT
 8mrORL86dPBK5AGvU4NJSAF145MYE9DQ5j/VJe4JEFaY3vu0DHlfeJSF3 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="389855113"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; d="scan'208";a="389855113"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 02:49:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="760162781"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; d="scan'208";a="760162781"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga007.fm.intel.com with ESMTP; 18 Oct 2023 02:49:35 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] scripts/cpu-x86-uarch-abi.py: Fix parameter error of cmd
Date: Wed, 18 Oct 2023 18:00:11 +0800
Message-Id: <20231018100011.685867-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Oct 2023 08:45:43 -0400
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

When run this script, there's the error:

python3 scripts/cpu-x86-uarch-abi.py /tmp/qmp
Traceback (most recent call last):
  File "/path-to-qemu/qemu/scripts/cpu-x86-uarch-abi.py", line 96, in <module>
    cpu = shell.cmd("query-cpu-model-expansion",
TypeError: QEMUMonitorProtocol.cmd() takes 2 positional arguments but 3 were given

Commit 7f521b023bc28 ("scripts/cpu-x86-uarch-abi.py: use .command()
instead of .cmd()") converts the the original .cmd() to .command()
(which was later renamed to "cmd" to replace the original one).

But the new .cmd() only accepts typing.Mapping as the parameter instead
of typing.Dict (see _qmp.execute()).

Change the paremeters of "query-cpu-model-expansion" to typing.Mapping
format to fix this error.

Fixes: 7f521b023bc28 ("scripts/cpu-x86-uarch-abi.py: use .command() instead of .cmd()")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 scripts/cpu-x86-uarch-abi.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/cpu-x86-uarch-abi.py b/scripts/cpu-x86-uarch-abi.py
index f6baeeff2400..052ddd751424 100644
--- a/scripts/cpu-x86-uarch-abi.py
+++ b/scripts/cpu-x86-uarch-abi.py
@@ -94,8 +94,8 @@
 
 for name in sorted(names):
     cpu = shell.cmd("query-cpu-model-expansion",
-                    { "type": "static",
-                      "model": { "name": name }})
+                    type="static",
+                    model={ "name": name })
 
     got = {}
     for (feature, present) in cpu["model"]["props"].items():
-- 
2.34.1


