Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D73B08C39
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Jul 2025 13:57:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucNCq-0004un-7p; Thu, 17 Jul 2025 07:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucNAX-0003cQ-1q
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 07:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucNAT-0001hX-Fb
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 07:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752753171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AuvT+ecQDMtv9NOHi5WzTVm8kJdJm9sr13IkjBKFsRM=;
 b=Si7/8gvd6PHsNHX82Ia1oacjcilhk7NbhgLuv6rxlpmyCZoexClWLR+GSS0h1jURaMNjTP
 duWAGUzMwBZqz2vlehIVwTqHiigj+mbVuR3sWCRoezyzovBLiKKboPE16qL76H37Kh0MCW
 J+3mZwKI0SAlchxForAcjcrC1Ee2G+E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-CiLRY-PIO-CHv7AegCjo7w-1; Thu,
 17 Jul 2025 07:52:50 -0400
X-MC-Unique: CiLRY-PIO-CHv7AegCjo7w-1
X-Mimecast-MFC-AGG-ID: CiLRY-PIO-CHv7AegCjo7w_1752753169
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36EC818004A7; Thu, 17 Jul 2025 11:52:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C50A730001B1; Thu, 17 Jul 2025 11:52:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 33CE021E6924; Thu, 17 Jul 2025 13:52:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 jsnow@redhat.com, berrange@redhat.com
Subject: [PATCH v2 1/4] qga: Fix guest-network-get-route return value
 documentation
Date: Thu, 17 Jul 2025 13:52:43 +0200
Message-ID: <20250717115246.3830007-2-armbru@redhat.com>
In-Reply-To: <20250717115246.3830007-1-armbru@redhat.com>
References: <20250717115246.3830007-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Tagged sections are only recognized at the beginning of a paragraph.
guest-network-get-route's Returns: isn't, and therefore gets rendered
as ordinary text within its paragraph:

    Retrieve information about route of network. Returns: List of route
    info of guest.

Since there is no (recognized) Returns: section, the doc generator
adds

    Return:
       [GuestNetworkRoute]

Note: only since recent commit 636c96cd77d (qapi: Fix undocumented
return values by generating something).

Insert the required blank line so that Returns: is recognized.
Result:

    Retrieve information about route of network.

    Return:
       [GuestNetworkRoute] -- List of route info of guest.

Fixes: commit 8e326d36dd16 (qga/linux: Add new api 'guest-network-get-route')
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/qapi-schema.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 6d770f7b8e..a569a14b55 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1966,6 +1966,7 @@
 # @guest-network-get-route:
 #
 # Retrieve information about route of network.
+#
 # Returns: List of route info of guest.
 #
 # Since: 9.1
-- 
2.49.0


