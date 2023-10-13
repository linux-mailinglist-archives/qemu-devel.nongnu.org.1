Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B33557C8926
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:53:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKSF-00014l-BB; Fri, 13 Oct 2023 11:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anvilleg@cisco.com>)
 id 1qrKSC-00014N-VK
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:51:56 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anvilleg@cisco.com>)
 id 1qrKSB-0006Pc-1C
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=2009; q=dns/txt; s=iport;
 t=1697212315; x=1698421915;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sNA3iYZ7BJY1/tsC5Gl4pGEMGganJccgxFEOoep+jeM=;
 b=ToCWjOpP1ruecxIPwowtfSe//xJg2UHdLIYeVjy8dPWrRJul3eBC1b+y
 6y9wnVL8chWR8GuRU0VxxMl8b1mRDqlrhyR5UwILej2V83Mj1zmwxlvg6
 9t1fsX71dOg24LmNRo52mrEnR1qS8cr6LPGUixONQGoMLGZ0rMs4KG8qf U=;
X-CSE-ConnectionGUID: NNdR0yi3SM6O168fKyjoag==
X-CSE-MsgGUID: kzApjTegRmSq5gawyDhgPg==
X-IronPort-AV: E=Sophos;i="6.03,222,1694736000"; d="scan'208";a="170659584"
Received: from alln-core-9.cisco.com ([173.36.13.129])
 by alln-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 15:51:52 +0000
Received: from avavpn-215.vrt.sourcefire.com ([10.83.44.169])
 by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTP id 39DFpp93031994;
 Fri, 13 Oct 2023 15:51:51 GMT
From: "Angel M. Villegas" <anvilleg@cisco.com>
To: qemu-devel@nongnu.org, anvilleg@cisco.com
Cc: michael.roth@amd.com, kkostiuk@redhat.com
Subject: [PATCH] guest-agent: improve help for --allow-rpcs and --block-rpcs
Date: Fri, 13 Oct 2023 11:51:10 -0400
Message-Id: <20231013155110.23175-1-anvilleg@cisco.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.83.44.169, [10.83.44.169]
X-Outbound-Node: alln-core-9.cisco.com
Received-SPF: pass client-ip=173.37.142.89; envelope-from=anvilleg@cisco.com;
 helo=alln-iport-2.cisco.com
X-Spam_score_int: -118
X-Spam_score: -11.9
X-Spam_bar: -----------
X-Spam_report: (-11.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1757

Updates to qga help output and documentation for --allow-rpcs and --blocks-rpcs

Signed-off-by: Angel M. Villegas <anvilleg@cisco.com>
---
 docs/interop/qemu-ga.rst | 8 ++++----
 qga/main.c               | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
index 461c5a35ee..72fb75a6f5 100644
--- a/docs/interop/qemu-ga.rst
+++ b/docs/interop/qemu-ga.rst
@@ -81,13 +81,13 @@ Options
 
 .. option:: -b, --block-rpcs=LIST
 
-  Comma-separated list of RPCs to disable (no spaces, use ``help`` to
-  list available RPCs).
+  Comma-separated list of RPCs to disable (no spaces, use ``--block-rpcs=help``
+  to list available RPCs).
 
 .. option:: -a, --allow-rpcs=LIST
 
-  Comma-separated list of RPCs to enable (no spaces, use ``help`` to
-  list available RPCs).
+  Comma-separated list of RPCs to enable (no spaces, use ``--allow-rpcs=help``
+  to list available RPCs).
 
 .. option:: -D, --dump-conf
 
diff --git a/qga/main.c b/qga/main.c
index 8668b9f3d3..bdf5344584 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -261,9 +261,9 @@ QEMU_COPYRIGHT "\n"
 "  -s, --service     service commands: install, uninstall, vss-install, vss-uninstall\n"
 #endif
 "  -b, --block-rpcs  comma-separated list of RPCs to disable (no spaces,\n"
-"                    use \"help\" to list available RPCs)\n"
+"                    use \"--block-rpcs=help\" to list available RPCs)\n"
 "  -a, --allow-rpcs  comma-separated list of RPCs to enable (no spaces,\n"
-"                    use \"help\" to list available RPCs)\n"
+"                    use \"--allow-rpcs=help\" to list available RPCs)\n"
 "  -D, --dump-conf   dump a qemu-ga config file based on current config\n"
 "                    options / command-line parameters to stdout\n"
 "  -r, --retry-path  attempt re-opening path if it's unavailable or closed\n"
-- 
2.39.2 (Apple Git-143)


