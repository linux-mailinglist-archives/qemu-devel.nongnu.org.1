Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FC58767A1
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Mar 2024 16:49:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricSM-0000YD-H4; Fri, 08 Mar 2024 10:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ricSJ-0000XJ-4e
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:48:19 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ricSG-0003yV-US
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709912898; x=1741448898;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B3lny/2+b2ix8nzCQ1+R6QE1gQbpbWuXDCZWBTjqMaY=;
 b=lHNRpvYA4pvgTykE3fgEyShzTN0IU9Wsch0g/fZhxNPXryGbXJ3pYyoR
 9uyeuoZsW1Ir8qF0VQnSZLhpKmEhtnisbLwNHnEoeHoOgKLM22qMKRQ0y
 lFazT5kck/wlnt8iRH9fYDGJ35L0ZA0WHV/QF1bIJ0+LppzfihXCmW0eY
 LYH2Lzy8dZh3/ddGCBte5CgT/x+i7g0+0/kDx38yf96kKv+cyOxyRkO/n
 PhowO59VrFebkxUp3NLAkHLRQiSQ2ERO+edB4666QBq8WvW2AwDiyOELi
 dkFfBziJME7fOvfTtfgx1m39ERIjP8Us3zZ9dp8VQhEEA5g9aWeIoaIDc g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4561012"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4561012"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 07:48:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; d="scan'208";a="10400315"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2024 07:48:13 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v2 01/13] hw/core/machine-smp: Remove deprecated "parameter=0"
 SMP configurations
Date: Sat,  9 Mar 2024 00:01:36 +0800
Message-Id: <20240308160148.3130837-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
References: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.21;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

The "parameter=0" SMP configurations have been marked as deprecated
since v6.2.

For these cases, -smp currently returns the warning and adjusts the
zeroed parameters to 1 by default.

Remove the above compatibility logic in v9.0, and return error directly
if any -smp parameter is set as 0.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
---
 docs/about/deprecated.rst       | 16 ----------------
 docs/about/removed-features.rst | 15 +++++++++++++++
 hw/core/machine-smp.c           |  5 +++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 36bd3e15ef06..872974640252 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -36,22 +36,6 @@ and will cause a warning.
 The replacement for the ``nodelay`` short-form boolean option is ``nodelay=on``
 rather than ``delay=off``.
 
-``-smp`` ("parameter=0" SMP configurations) (since 6.2)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-Specified CPU topology parameters must be greater than zero.
-
-In the SMP configuration, users should either provide a CPU topology
-parameter with a reasonable value (greater than zero) or just omit it
-and QEMU will compute the missing value.
-
-However, historically it was implicitly allowed for users to provide
-a parameter with zero value, which is meaningless and could also possibly
-cause unexpected results in the -smp parsing. So support for this kind of
-configurations (e.g. -smp 8,sockets=0) is deprecated since 6.2 and will
-be removed in the near future, users have to ensure that all the topology
-members described with -smp are greater than zero.
-
 Plugin argument passing through ``arg=<string>`` (since 6.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 417a0e4fa1d9..f9cf874f7b1f 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -489,6 +489,21 @@ The ``-singlestep`` option has been turned into an accelerator property,
 and given a name that better reflects what it actually does.
 Use ``-accel tcg,one-insn-per-tb=on`` instead.
 
+``-smp`` ("parameter=0" SMP configurations) (removed in 9.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Specified CPU topology parameters must be greater than zero.
+
+In the SMP configuration, users should either provide a CPU topology
+parameter with a reasonable value (greater than zero) or just omit it
+and QEMU will compute the missing value.
+
+However, historically it was implicitly allowed for users to provide
+a parameter with zero value, which is meaningless and could also possibly
+cause unexpected results in the -smp parsing. So support for this kind of
+configurations (e.g. -smp 8,sockets=0) is removed since 9.0, users have
+to ensure that all the topology members described with -smp are greater
+than zero.
 
 User-mode emulator command line arguments
 -----------------------------------------
diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 25019c91ee36..96533886b14e 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -105,8 +105,9 @@ void machine_parse_smp_config(MachineState *ms,
         (config->has_cores && config->cores == 0) ||
         (config->has_threads && config->threads == 0) ||
         (config->has_maxcpus && config->maxcpus == 0)) {
-        warn_report("Deprecated CPU topology (considered invalid): "
-                    "CPU topology parameters must be greater than zero");
+        error_setg(errp, "Invalid CPU topology: "
+                   "CPU topology parameters must be greater than zero");
+        return;
     }
 
     /*
-- 
2.34.1


