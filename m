Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9DD868F59
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Feb 2024 12:41:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1revoN-0000Dl-Mm; Tue, 27 Feb 2024 06:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revoH-0000BZ-5T
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:39:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revo0-0005U3-7N
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709033965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PB5/0Iw/Gaz6NFYOrNywdhK6UvD4Tt2ZmhVytaTsAzc=;
 b=Pp13yxh+XMxevqomOibDUGQqVmBXaiWEK5WANsVWu6UgiS72d8nYOaH7uCmR6HG0kNadnj
 5sOxWgfWQKNPLdarKZEsu83WENVExBG0/I2Kjr7oRcdgpFWmdmgQ76Mt93TFDS55c+MEwY
 amOagFHfK5ghsGPV+gzKEmRmCUY/AVI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-Kg_FPme3P-2xjPXujBEenw-1; Tue,
 27 Feb 2024 06:39:23 -0500
X-MC-Unique: Kg_FPme3P-2xjPXujBEenw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79E43381D4A7;
 Tue, 27 Feb 2024 11:39:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 583D21803;
 Tue, 27 Feb 2024 11:39:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 39EB721E60F3; Tue, 27 Feb 2024 12:39:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, eblake@redhat.com,
 kkostiuk@redhat.com
Subject: [PATCH 06/13] qapi: Clean up "Returns" sections
Date: Tue, 27 Feb 2024 12:39:14 +0100
Message-ID: <20240227113921.236097-7-armbru@redhat.com>
In-Reply-To: <20240227113921.236097-1-armbru@redhat.com>
References: <20240227113921.236097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Drop list markup, since there's just one item left.

Drop "on success" where it is redundant with "Returns:".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 4 ++--
 qapi/machine.json    | 4 ++--
 qapi/misc.json       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 94b01deffc..1874f880a8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2457,7 +2457,7 @@
 # @unstable: This command is meant for debugging.
 #
 # Returns:
-#     - BlockDirtyBitmapSha256 on success
+#     BlockDirtyBitmapSha256
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
@@ -6084,7 +6084,7 @@
 # @name: optional the snapshot's name to be deleted
 #
 # Returns:
-#     - SnapshotInfo on success
+#     SnapshotInfo
 #
 # Errors:
 #     - If @device is not a valid block device, GenericError
diff --git a/qapi/machine.json b/qapi/machine.json
index 7d3ca33683..bb5a178909 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1090,7 +1090,7 @@
 # Return information about the balloon device.
 #
 # Returns:
-#     - @BalloonInfo on success
+#     @BalloonInfo
 #
 # Errors:
 #     - If the balloon driver is enabled but not functional because
@@ -1156,7 +1156,7 @@
 # message from the guest.
 #
 # Returns:
-#     - @HvBalloonInfo on success
+#     @HvBalloonInfo
 #
 # Errors:
 #     - If no hv-balloon device is present, guest memory status
diff --git a/qapi/misc.json b/qapi/misc.json
index 015388aa3e..1b0c5dad88 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -332,7 +332,7 @@
 # @opaque: A free-form string that can be used to describe the fd.
 #
 # Returns:
-#     - @AddfdInfo on success
+#     @AddfdInfo
 #
 # Errors:
 #     - If file descriptor was not received, GenericError
-- 
2.43.0


