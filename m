Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 603D3BD316E
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Oct 2025 14:54:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8HvL-0004eQ-Nw; Mon, 13 Oct 2025 08:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvB-0004X3-Um
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hv5-0007wd-Oy
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Khd9Ah7PVkvKBXPNxXDw7F9r6smK+lE2bENEWbULZ70=;
 b=D9PB2lAAe7P2itQjuUfrmnW7flWc9a98WEMz9YSJCy37MA2Pgkg8hUk+8jsyqO8fFa9mLf
 1Ov+iO7QhqKbwoMSi5QPYvZ8QvdKyzFS8xrbqBn1yOwrz92reNttySonTRdSUFcIbGEJBT
 /8iFVSNOJbkYFBT/fEaDcn7HuGsrLTk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-2E_i42YFO8m0Y3dG2tdXuw-1; Mon,
 13 Oct 2025 08:44:49 -0400
X-MC-Unique: 2E_i42YFO8m0Y3dG2tdXuw-1
X-Mimecast-MFC-AGG-ID: 2E_i42YFO8m0Y3dG2tdXuw_1760359488
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4342195410F; Mon, 13 Oct 2025 12:44:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EAB881800446; Mon, 13 Oct 2025 12:44:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PULL 12/29] test/functional/aarch64: Remove test for the
 ast2700a0-evb machine
Date: Mon, 13 Oct 2025 14:44:03 +0200
Message-ID: <20251013124421.71977-13-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The 'ast2700a0-evb' machine was deprecated in commit 6888a4a9c860 and
removal is scheduled in the QEMU 11.0 release. This change removes
the corresponding tests ahead of time to save CI resources.

Cc: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20251007141604.761686-5-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aarch64/test_aspeed_ast2700.py | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index ef7ed522afc3..a60dc1259f69 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -46,10 +46,6 @@ def verify_openbmc_boot_and_login(self, name):
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
 
-    ASSET_SDK_V906_AST2700 = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2700-a0-default-obmc.tar.gz',
-            '7247b6f19dbfb700686f8d9f723ac23f3eb229226c0589cb9b06b80d1b61f3cb')
-
     ASSET_SDK_V908_AST2700A1 = Asset(
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2700-default-obmc.tar.gz',
             'eac3dc409b7ea3cd4b03d4792d3cebd469792ad893cb51e1d15f0fc20bd1e2cd')
@@ -124,14 +120,6 @@ def start_ast2700_test_vbootrom(self, name):
         self.do_test_aarch64_aspeed_sdk_start(
                 self.scratch_file(name, 'image-bmc'))
 
-    def test_aarch64_ast2700a0_evb_sdk_v09_06(self):
-        self.set_machine('ast2700a0-evb')
-
-        self.archive_extract(self.ASSET_SDK_V906_AST2700)
-        self.start_ast2700_test('ast2700-a0-default')
-        self.verify_openbmc_boot_and_login('ast2700-a0-default')
-        self.do_ast2700_i2c_test()
-
     def test_aarch64_ast2700a1_evb_sdk_v09_08(self):
         self.set_machine('ast2700a1-evb')
         self.require_netdev('user')
-- 
2.51.0


