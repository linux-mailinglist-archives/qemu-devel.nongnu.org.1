Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6217ACC04E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Jun 2025 08:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMLIG-0000eU-8o; Tue, 03 Jun 2025 02:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGc-0007md-Rx
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGY-0003Qk-HC
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748932610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7dz792t4NYLDzeDLA9lV44WbnXSBPzshzBmxqaTabco=;
 b=LDqIAUoJ4hzG9zrPLcZSWzD0xGlYB823GGVo0d+wtcpel+26pYw1KkhNu9fNWdJQ2qN4gZ
 yKaDM2QFUHtJd5a4kZaRDRPQ9Ec3oTq5Epko6r/Tm23MK9PJdzjoDlsxjKmeItN36LbKkx
 LR/q97ybRwNw3+XwfL+aS5JjGJ78J78=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-mGZ_pOvtOG2yXlVkG7L0Lw-1; Tue,
 03 Jun 2025 02:36:48 -0400
X-MC-Unique: mGZ_pOvtOG2yXlVkG7L0Lw-1
X-Mimecast-MFC-AGG-ID: mGZ_pOvtOG2yXlVkG7L0Lw_1748932608
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 041B5180035F
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF68D1956094
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA94321E6617; Tue, 03 Jun 2025 08:36:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 03/13] qapi: Move (since X.Y) to end of description
Date: Tue,  3 Jun 2025 08:36:34 +0200
Message-ID: <20250603063644.3953528-4-armbru@redhat.com>
In-Reply-To: <20250603063644.3953528-1-armbru@redhat.com>
References: <20250603063644.3953528-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

By convention, we put (since X.Y) at the end of the description.  Move
the ones that somehow ended up in the middle of the description to the
end.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250527073916.1243024-4-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 18 +++++++++---------
 qapi/net.json        |  6 +++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 13223df9b4..0700bd3d46 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1322,8 +1322,8 @@
 # @incremental: only copy data described by the dirty bitmap.
 #     (since: 2.4)
 #
-# @bitmap: only copy data described by the dirty bitmap.  (since: 4.2)
-#     Behavior on completion is determined by the BitmapSyncMode.
+# @bitmap: only copy data described by the dirty bitmap.  Behavior on
+#     completion is determined by the BitmapSyncMode.  (since: 4.2)
 #
 # Since: 1.3
 ##
@@ -3415,8 +3415,8 @@
 # Driver specific block device options for LUKS.
 #
 # @key-secret: the ID of a QCryptoSecret object providing the
-#     decryption key (since 2.6).  Mandatory except when doing a
-#     metadata-only probe of the image.
+#     decryption key.  Mandatory except when doing a metadata-only
+#     probe of the image.  (since 2.6)
 #
 # @header: block device holding a detached LUKS header.  (since 9.0)
 #
@@ -4724,11 +4724,11 @@
 #
 # @driver: block driver name
 #
-# @node-name: the node name of the new node (Since 2.0).  This option
-#     is required on the top level of blockdev-add.  Valid node names
-#     start with an alphabetic character and may contain only
-#     alphanumeric characters, '-', '.' and '_'.  Their maximum length
-#     is 31 characters.
+# @node-name: the node name of the new node.  This option is required
+#     on the top level of blockdev-add.  Valid node names start with
+#     an alphabetic character and may contain only alphanumeric
+#     characters, '-', '.' and '_'.  Their maximum length is 31
+#     characters.  (Since 2.0)
 #
 # @discard: discard-related options (default: ignore)
 #
diff --git a/qapi/net.json b/qapi/net.json
index 310cc4fd19..e670efd6b0 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -150,9 +150,9 @@
 # @domainname: guest-visible domain name of the virtual nameserver
 #     (since 3.0)
 #
-# @ipv6-prefix: IPv6 network prefix (default is fec0::) (since 2.6).
-#     The network prefix is given in the usual hexadecimal IPv6
-#     address notation.
+# @ipv6-prefix: IPv6 network prefix (default is fec0::).  The network
+#     prefix is given in the usual hexadecimal IPv6 address notation.
+#     (since 2.6)
 #
 # @ipv6-prefixlen: IPv6 network prefix length (default is 64) (since
 #     2.6)
-- 
2.48.1


