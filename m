Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 077EEBCF6AF
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:14:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a88-0006NP-DQ; Sat, 11 Oct 2025 09:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7s-0006J9-DD
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:14 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7X-0004lG-Ep
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7A77CC0182;
 Sat, 11 Oct 2025 16:58:17 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-GCfTdvn5; Sat, 11 Oct 2025 16:58:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191097;
 bh=83Si4n9Xifa8e3/o2G6/CFeqpWDDkQPsyg5kZnGHXPo=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=bX+V2w+F760alYzl/e1pjD2r0n64XZLIJBvuloM6jng7LyIOR5f4YOqe61s7UIOYp
 E8iaG4ESW6+aN6ynDK6iEgBw7sw90BX2jZ2p4WiN7taI8YL6g2FIEMWKTJ1RI1Qgr1
 QegjYZRWDUzJ4SQojbMX4oA/Q9sYXkSuBpG7Y9Oc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 20/33] qapi/qom.json: reflow docs to width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 16:57:20 +0300
Message-ID: <20251011135754.294521-40-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/qom.json | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 830cb2ffe7..99cdd0f60c 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -52,7 +52,8 @@
 #
 # @name: the name of the property.
 #
-# @type: the type of the property, as described in `ObjectPropertyInfo`.
+# @type: the type of the property, as described in
+#     `ObjectPropertyInfo`.
 #
 # @value: the value of the property.  Absent when the property cannot
 #     be read.
@@ -92,9 +93,12 @@
 #     -> { "execute": "qom-list",
 #          "arguments": { "path": "/chardevs" } }
 #     <- { "return": [ { "name": "type", "type": "string" },
-#                      { "name": "parallel0", "type": "child<chardev-vc>" },
-#                      { "name": "serial0", "type": "child<chardev-vc>" },
-#                      { "name": "mon0", "type": "child<chardev-stdio>" } ] }
+#                      { "name": "parallel0", "type":
+#     "child<chardev-vc>" },
+#                      { "name": "serial0", "type": "child<chardev-
+#     vc>" },
+#                      { "name": "mon0", "type": "child<chardev-
+#     stdio>" } ] }
 ##
 { 'command': 'qom-list',
   'data': { 'path': 'str' },
@@ -1082,7 +1086,8 @@
 #     Authentication Information Structure' for the SNP_LAUNCH_FINISH
 #     command defined in the SEV-SNP firmware ABI (default: all-zero)
 #
-# @author-key-enabled: true if 'id-auth' blob contains the 'AUTHOR_KEY'
+# @author-key-enabled: true if 'id-auth' blob contains the
+#     'AUTHOR_KEY'
 #     field defined SEV-SNP firmware ABI (default: false)
 #
 # @host-data: 32-byte, base64-encoded, user-defined blob to provide to
@@ -1117,17 +1122,17 @@
 # @attributes: The 'attributes' of a TD guest that is passed to
 #     KVM_TDX_INIT_VM
 #
-# @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
-#     of EPT violation conversion to #VE on guest TD access of PENDING
-#     pages.  Some guest OS (e.g., Linux TD guest) may require this to
-#     be set, otherwise they refuse to boot.
+# @sept-ve-disable: toggle bit 28 of TD attributes to control
+#     disabling of EPT violation conversion to #VE on guest TD access
+#     of PENDING pages.  Some guest OS (e.g., Linux TD guest) may
+#     require this to be set, otherwise they refuse to boot.
 #
 # @mrconfigid: ID for non-owner-defined configuration of the guest TD,
-#     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
-#     Defaults to all zeros.
+#     e.g., run-time or OS configuration (base64 encoded SHA384
+#     digest).  Defaults to all zeros.
 #
-# @mrowner: ID for the guest TD’s owner (base64 encoded SHA384 digest).
-#     Defaults to all zeros.
+# @mrowner: ID for the guest TD’s owner (base64 encoded SHA384
+#     digest).  Defaults to all zeros.
 #
 # @mrownerconfig: ID for owner-defined configuration of the guest TD,
 #     e.g., specific to the workload rather than the run-time or OS
-- 
2.48.1


