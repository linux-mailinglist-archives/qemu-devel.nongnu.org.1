Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED31832B99
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:49:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQqAx-0002HD-NM; Fri, 19 Jan 2024 09:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQqAu-0002Gl-Cx
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:48:54 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQqAq-0007me-3d
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QKCN+pjZ4XQPs3wyUDnH+MXvsD7/sLfzvDEV9EBbK2s=; b=je/YjabjUjA20YRkWW7y4+ZTxX
 i2zAQ9NXwE7wfXIvtzq19eEGqJokubfsFC96soiMEvie6Vb2m6aF3+6YGy8YvRQ0oZnHByjEEhmMb
 qpshBgPOqednmHLBWsQ3IvBnvw5PMpt7eJ4i1koyikhLT8pMgx7h27LCfkHMRh5V5Iyo=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 34/34] accel/tcg: Compile (a few files) once for
 system-mode
Date: Fri, 19 Jan 2024 15:40:24 +0100
Message-ID: <20240119144024.14289-35-anjo@rev.ng>
In-Reply-To: <20240119144024.14289-1-anjo@rev.ng>
References: <20240119144024.14289-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Build a common static library for a few softmmu files.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/meson.build | 57 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 8783edd06e..420050bdbf 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,28 +1,61 @@
-tcg_ss = ss.source_set()
+tcg_specific_ss = ss.source_set()
+tcg_user_ss = ss.source_set()
 common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cpu-exec-common.c',
 ))
-tcg_ss.add(files(
-  'tcg-all.c',
+common_ss.add(when: libdw, if_true: files('debuginfo.c'))
+
+tcg_specific_ss.add(files(
   'cpu-exec.c',
+  'translator.c',
+))
+
+tcg_user_ss.add(files(
+  'user-exec.c',
+  'translate-all.c',
   'tb-maint.c',
   'tcg-runtime-gvec.c',
   'tcg-runtime.c',
-  'translate-all.c',
-  'translator.c',
+  'tcg-all.c',
 ))
-tcg_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-tcg_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
 if get_option('plugins')
-  tcg_ss.add(files('plugin-gen.c'))
+  tcg_user_ss.add(files('plugin-gen.c'))
 endif
-tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
-tcg_ss.add(when: 'CONFIG_LINUX', if_true: files('perf.c'))
-specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
+tcg_specific_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: tcg_user_ss)
+tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files(
+  'user-exec-stub.c'
+))
+tcg_specific_ss.add(when: 'CONFIG_LINUX', if_true: files('perf.c'))
+specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
-specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
+have_tcg = get_option('tcg').allowed()
+tcg_softmmu_ss = ss.source_set()
+tcg_softmmu_ss.add(files(
   'cputlb.c',
+  'translate-all.c',
+  'tb-maint.c',
+  'tcg-runtime-gvec.c',
+  'tcg-runtime.c',
+  'tcg-all.c',
 ))
+if get_option('plugins')
+  tcg_softmmu_ss.add(files('plugin-gen.c'))
+endif
+tcg_softmmu_ss = tcg_softmmu_ss.apply(config_targetos, strict: false)
+
+libacceltcg_softmmu = static_library('acceltcg_softmmu',
+                                     tcg_softmmu_ss.sources() + genh,
+                                     name_suffix: 'fa',
+                                     c_args: '-DCONFIG_SOFTMMU',
+                                     build_by_default: have_system and
+                                                       have_tcg)
+
+if not get_option('tcg').allowed()
+   subdir_done()
+endif
+tcg_softmmu = declare_dependency(link_with: libacceltcg_softmmu,
+                                 dependencies: tcg_softmmu_ss.dependencies())
+system_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: tcg_softmmu)
 
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'icount-common.c',
-- 
2.43.0


