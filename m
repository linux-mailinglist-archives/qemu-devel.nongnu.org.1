Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AACB087D2
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Jul 2025 10:22:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucJsW-0005de-Rc; Thu, 17 Jul 2025 04:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucJrv-0005D3-8W
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucJrr-0000wr-AY
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752740485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yj9/HwS3k1M0O5YACAdx/JDck9GGndfhiwLtBfQycmo=;
 b=BZhG8WU0veOH4YZh3JaPyEAb+NfiS+IkbvAtPJm4lFgRdtgg5dBWAmQRREOcZDDB/0IUee
 FzvSlFycBuHlLDgDFbIePucqR6BF0+0/Af6zCn1RTx3uIWKhEeQKBCxLTNmbcO2fHYPbkg
 79JikmZD6kecGNQIRsCCU3mPnbufbD4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-Ury0_haMP6ONbePMz1xX5w-1; Thu,
 17 Jul 2025 04:21:21 -0400
X-MC-Unique: Ury0_haMP6ONbePMz1xX5w-1
X-Mimecast-MFC-AGG-ID: Ury0_haMP6ONbePMz1xX5w_1752740481
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F20D51800C37; Thu, 17 Jul 2025 08:21:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79F6730001B9; Thu, 17 Jul 2025 08:21:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B07B521E6924; Thu, 17 Jul 2025 10:21:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 jsnow@redhat.com
Subject: [PATCH 1/4] qga: Fix guest-network-get-route return value
 documentation
Date: Thu, 17 Jul 2025 10:21:14 +0200
Message-ID: <20250717082117.3767754-2-armbru@redhat.com>
In-Reply-To: <20250717082117.3767754-1-armbru@redhat.com>
References: <20250717082117.3767754-1-armbru@redhat.com>
MIME-Version: 1.0
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


