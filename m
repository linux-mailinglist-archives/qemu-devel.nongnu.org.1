Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F91B087D4
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Jul 2025 10:22:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucJsW-0005XO-B3; Thu, 17 Jul 2025 04:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucJrt-0005BI-IT
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucJrp-0000wH-JN
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752740483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxWqvkf2KdiB/qeLezzgRj6u3zI9mtMUQENXYB98ux0=;
 b=UoM51pO569AWKTxK20hhGKZddp3d6mzftq7+jG8nKYVUb+AgzxjR28/n/nXSYzZTej9lvh
 yUTAsrKHxulJSBqlxQTsBO5z8P5pFNHdwdv88Z83bdbafs7JPmmkjouxsmU68OVj8d8Y5F
 1gnz/TbEKrPiLCvoUeQzSuXjAIpMQxE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-nYaqBuTHPI-Mi_j30-SXAQ-1; Thu,
 17 Jul 2025 04:21:21 -0400
X-MC-Unique: nYaqBuTHPI-Mi_j30-SXAQ-1
X-Mimecast-MFC-AGG-ID: nYaqBuTHPI-Mi_j30-SXAQ_1752740480
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFC861800283; Thu, 17 Jul 2025 08:21:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B40A19560A1; Thu, 17 Jul 2025 08:21:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B447B21E6925; Thu, 17 Jul 2025 10:21:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 jsnow@redhat.com
Subject: [PATCH 2/4] qga: Remove trivial "Returns:" sections
Date: Thu, 17 Jul 2025 10:21:15 +0200
Message-ID: <20250717082117.3767754-3-armbru@redhat.com>
In-Reply-To: <20250717082117.3767754-1-armbru@redhat.com>
References: <20250717082117.3767754-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The QAPI doc generator recently started to auto-generate return
documentation when there is no "Returns:" section (commit 636c96cd77d
"qapi: Fix undocumented return values by generating something").
Remove "Returns:" sections where the auto-generated text is obviously
no worse.  For instance, guest-info's documentation changes from

    Return:
       GuestAgentInfo -- GuestAgentInfo

to

    Return:
       GuestAgentInfo

The auto-generated returns all are in the exact same spot.

We did this for qapi/ in commit 0462da9d6b1 (qapi: remove trivial
"Returns:" sections).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a569a14b55..a9cc9150dc 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -202,8 +202,6 @@
 #
 # Get some information about the guest agent.
 #
-# Returns: @GuestAgentInfo
-#
 # Since: 0.15.0
 ##
 { 'command': 'guest-info',
@@ -285,8 +283,6 @@
 # @count: maximum number of bytes to read (default is 4KB, maximum is
 #     48MB)
 #
-# Returns: @GuestFileRead
-#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-read',
@@ -320,8 +316,6 @@
 # @count: bytes to write (actual bytes, after base64-decode), default
 #     is all content in buf-b64 buffer after base64 decoding
 #
-# Returns: @GuestFileWrite
-#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-write',
@@ -387,8 +381,6 @@
 #
 # @whence: Symbolic or numeric code for interpreting offset
 #
-# Returns: @GuestFileSeek
-#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-seek',
@@ -428,9 +420,6 @@
 #
 # Get guest fsfreeze state.
 #
-# Returns: GuestFsfreezeStatus ("thawed", "frozen", etc., as defined
-#     below)
-#
 # .. note:: This may fail to properly report the current state as a
 #    result of some other guest processes having issued an fs
 #    freeze/thaw.
@@ -749,8 +738,6 @@
 #
 # Get list of guest IP addresses, MAC addresses and netmasks.
 #
-# Returns: List of GuestNetworkInterface
-#
 # Since: 1.1
 ##
 { 'command': 'guest-network-get-interfaces',
@@ -1251,8 +1238,6 @@
 #
 # Get information relating to guest memory blocks.
 #
-# Returns: @GuestMemoryBlockInfo
-#
 # Since: 2.3
 ##
 { 'command': 'guest-get-memory-block-info',
@@ -1298,8 +1283,6 @@
 #
 # @pid: pid returned from guest-exec
 #
-# Returns: GuestExecStatus
-#
 # Since: 2.5
 ##
 { 'command': 'guest-exec-status',
@@ -1458,8 +1441,6 @@
 #
 # Retrieves the timezone information from the guest.
 #
-# Returns: A GuestTimezone dictionary.
-#
 # Since: 2.10
 ##
 { 'command': 'guest-get-timezone',
@@ -1533,8 +1514,6 @@
 #
 # Retrieve guest operating system information
 #
-# Returns: @GuestOSInfo
-#
 # Since: 2.10
 ##
 { 'command': 'guest-get-osinfo',
@@ -1604,8 +1583,6 @@
 #
 # Retrieve information about device drivers in Windows guest
 #
-# Returns: @GuestDeviceInfo
-#
 # Since: 5.2
 ##
 { 'command': 'guest-get-devices',
@@ -1633,8 +1610,6 @@
 #
 # @username: the user account to add the authorized keys
 #
-# Returns: @GuestAuthorizedKeys
-#
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-get-authorized-keys',
-- 
2.49.0


