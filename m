Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA14868F4B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Feb 2024 12:40:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1revoH-0000B7-Gi; Tue, 27 Feb 2024 06:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revoC-00008b-V8
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:39:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revo0-0005Uf-Nh
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709033967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BS5qxS6Y7vFDvl65GsGPtJ391Xu6yhC+wlpLeqZvGwI=;
 b=gKCsKqLUtLkfITbUqVijNyXYStYIWC2HLEYGm/5TPk4BS7Nhwoq1SwIqTFJeH7wYKnWtdt
 yLEKx2eF55CGgJk9SfZk/olggDd9Ir84JN/Cd1uFV0HwKzNJ30kwhSP0U90LoZxiU3sZEa
 3vsP82ge8u45UKSvySyNVBdH8hwduMc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-AvOQ1olJPxCgarJB0U79uw-1; Tue,
 27 Feb 2024 06:39:23 -0500
X-MC-Unique: AvOQ1olJPxCgarJB0U79uw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 882DF3C02762;
 Tue, 27 Feb 2024 11:39:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 658A7492BCF;
 Tue, 27 Feb 2024 11:39:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 43CEF21E5A40; Tue, 27 Feb 2024 12:39:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, eblake@redhat.com,
 kkostiuk@redhat.com
Subject: [PATCH 09/13] qga/qapi-schema: Delete useless "Returns" sections
Date: Tue, 27 Feb 2024 12:39:17 +0100
Message-ID: <20240227113921.236097-10-armbru@redhat.com>
In-Reply-To: <20240227113921.236097-1-armbru@redhat.com>
References: <20240227113921.236097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c5f2ac8f59..636c2c5697 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -153,8 +153,6 @@
 # @time: time of nanoseconds, relative to the Epoch of 1970-01-01 in
 #     UTC.
 #
-# Returns: Nothing on success.
-#
 # Since: 1.5
 ##
 { 'command': 'guest-set-time',
@@ -245,8 +243,6 @@
 #
 # @handle: filehandle returned by guest-file-open
 #
-# Returns: Nothing on success.
-#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-close',
@@ -399,8 +395,6 @@
 #
 # @handle: filehandle returned by guest-file-open
 #
-# Returns: Nothing on success.
-#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-flush',
@@ -1077,8 +1071,6 @@
 # transmission, even if already crypt()d, to ensure it is 8-bit safe
 # when passed as JSON.
 #
-# Returns: Nothing on success.
-#
 # Since: 2.3
 ##
 { 'command': 'guest-set-user-password',
@@ -1602,8 +1594,6 @@
 #
 # @reset: ignore the existing content, set it with the given keys only
 #
-# Returns: Nothing on success.
-#
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-add-authorized-keys',
@@ -1622,8 +1612,6 @@
 # @keys: the public keys to remove (in OpenSSH/sshd(8) authorized_keys
 #     format)
 #
-# Returns: Nothing on success.
-#
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-remove-authorized-keys',
-- 
2.43.0


